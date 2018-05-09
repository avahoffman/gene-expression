require(multtest) # Required for FDR calculations

# Main function
# The datafile contains one line for each homology group
# The columns are then defined as follows
# Column 1: Group id
# Column 2: Minimum paralog p-value for species 1
# Column 3: Number of homologs in the group for species 1
# Column 4: Number of homologs measured for species 1
# Column 5: Minimum paralog p-value species 2
# Column 6: Number of homologs in the group for species 2
# Column 7: Number of homologs measured for species 2
#
# Example data files are available at
# http://bioinformatics.math.chalmers.se/Xspecies/
#
# Example:
# xspecies(file="HS-8sp-twotails.txt")

xspecies<-function(file="/Users/avahoffman/Documents/CSU/Research/RNASEQDATA/Kristiansson_analysis/all_paralogs.txt", weights=rep(1, length(species.names)), species.groups=NULL){

  # Read datafile
  data<-read.table(file, header=T, sep="\t")
  
  # One homology group on each line
  nGroups<-dim(data)[1]  
  
  # Each species have three columns
  rem<-(dim(data)[2]-1) %% 3  
  if(rem!=0){
    stop("Wrong number of columns!")
  }
  
  # Calcultes the number of species
  nSpecies<-(dim(data)[2]-1)/3

  # Calculate the columns for p-values, number of homologenes and the
  # number of genes represented for each species
  pv.seq<-seq(1+1, 3*nSpecies+1, by=3)
  nobs.seq<-seq(1+2, 3*nSpecies+1, by=3)
  ngenes.seq<-seq(1+3, 3*nSpecies+1, by=3)

  # Extract the species names
  species.names<-unlist(strsplit(colnames(data)[pv.seq], "\\."))[seq(1,2*nSpecies, by=2)]  
  cat(sprintf("Found the following species:%s\n", paste(species.names, collapse=", ")))    
    
  # Init some vectors and matrices
  P.combined<-numeric(length=nGroups)
  S<-numeric(length=nGroups)
  alpha<-numeric(length=nGroups)
  nSp.avail<-numeric(length=nGroups)
  Y.matrix<-matrix(NA, nr=nGroups, nc=nSpecies)
  colnames(Y.matrix)<-paste("NormScore", species.names, sep="-")
  P.all<-matrix(nr=nGroups, nc=nSpecies)
  colnames(P.all)<-species.names
 
  # Loop over all homology groups 
  for(i in 1:nGroups){
   
    # Extract species-specific minium p-values
    Pvalues<-as.numeric(data[i,pv.seq])

    # Save P-values
    P.all[i,]<-as.numeric(Pvalues)
    
    # What p-values are available (i.e. not NA)
    tmp<-!is.na(Pvalues)

    # Recalculate weights based on available species and species rgoups
    if(sum(tmp)>0){ # Do we have data for at least one species
      
      # Number of available species
      nSp.avail[i]<-sum(!is.na(Pvalues))
      
      # Has the species group paramter been supplied
      if(!is.null(species.groups)){
      
        # Extract the different species groups
        sp.groups<-unique(species.groups)
	
	# Extarct the number of species groups
	nsp.groups<-length(sp.groups)
	
	# Loop over the speices groups
	for(j in 1:nsp.groups){
	
	  tmp.sp<-species.groups==sp.groups[j]
	  if(sum(tmp.sp)>1){ # Species groups with more than one
                             # species may need to be adjusted
                             # depending on their availability
	  
	    tmp.avail<-(tmp&tmp.sp) # Number of species available in
                                    # the species group
				    
	    if(sum(tmp.avail)>0){ # Do we have any species available?
	    
	      # Adjust weights to the available species without
              # changing the weight of the group
	      weights.group[tmp.avail]<-weights.group[tmp.avail]/sum(weights.group[tmp.avail])*sum(weights.group[tmp.sp])
	    }
	  }
	}
      } else {
        weights.group<-weights
      }
      
      # Recalculate weights based on species available for the
      # homology group
      weights.avail<-weights.group[tmp]/sum(weights.group[tmp]) # Equal weight
      
      # Calculate the number of paralogs for each species      
      nparalogs<-data[i,nobs.seq][tmp] # Pick out the corresponding number of paralogs
      
      # Calculate Y (-log min P-values)
      Y<-(-log(Pvalues))[tmp]

      # Calculate the expected value
      ExpectedValue<-sapply(nparalogs, CalculateExpectedValue) # Calculate the expected value
      
      # Scale Y      
      Y.scaled<-Y/ExpectedValue # Y/Exp[Y]
      
      # Save Y for output
      Y.matrix[i,tmp]<-as.numeric(Y.scaled)
    
      # Calculate S as the weighted sum of the scaled Ys
      S[i]<-sum(Y.scaled*weights.avail, na.rm=T)
      
      # Parameter for the approximate gamma distribution
      alpha[i]<-CalculateAlpha(nparalogs, weights.avail)
      
      # Calculate the cross-species specific p-value      
      P.combined[i]<-pgamma(S[i], shape=alpha[i], rate=alpha[i], lower.tail=F)
      
    } else {
    
      # No observation for this homology group      
      S[i]<-NA
      nSp.avail[i]<-0
      alpha[i]<-NA
      P.combined[i]<-NA
    }
  }

  # Calculate FDR based on the multtest package
  tmp<-mt.rawp2adjp(P.combined, proc="BH") # FDR correction
  FDR.combined<-tmp$adjp[,"BH"][order(tmp$index)]

  # Combine everything for the output
  Result<-data.frame(Group=data[,1], nSpecies=nSp.avail, S=S, alpha=alpha, Variance=1/alpha, Pvalue=P.combined, FDR=FDR.combined, P.all, Y.matrix, data[,nobs.seq], data[,ngenes.seq])
  
  return(Result)  
}

CalculateExpectedValue<-function(n){
 
  n<-as.numeric(n)
  if(is.na(n)){
    return(NA)
  }
 
  if(n>0){
    return(sum(1/(1:n)))
  } else { 
    return(NA)
  }
  
}

CalculateVariance<-function(n){

  if(is.na(n)){  
    return(NA)
  }

  if(n>0){
    return(sum(1/(1:n)^2))
  } else { 
    return(NA)
  }
  
}

CalculateAlpha<-function(nparalogs, weights){

  nspecies<-sum(nparalogs>0)

  ExpectedValues<-sapply(nparalogs, CalculateExpectedValue)
  Variances<-sapply(nparalogs, CalculateVariance)

  alpha<-1/(sum(weights^2*(1/(ExpectedValues^2))*Variances, na.rm=T))

  return(alpha)
  
}

# Method for directed test. Uses two files, one for each tail.
xspecies.directed<-function(file.up="/Users/avahoffman/Documents/CSU/Research/RNASEQDATA/Kristiansson_analysis/up.txt",
                            file.down="/Users/avahoffman/Documents/CSU/Research/RNASEQDATA/Kristiansson_analysis/down.txt", 
			    sort=FALSE, ...){
					  					

  res.up<-xspecies(file.up, ...)
  res.down<-xspecies(file.down, ...)
  
  p.up<-res.up[,"Pvalue"]
  p.down<-res.down[,"Pvalue"]
  
  # Picks the most significant p-value
  tmp<-p.down<p.up  
  tmp[is.na(tmp)]<-FALSE  
  res<-res.up
  res[tmp,]<-res.down[tmp,]
  
  # Adds a column that shows the direction of regulation
  n<-dim(res)[1]
  m<-dim(res)[2]
  ind.reg<-rep("Up", n)
  ind.reg[tmp]<-rep("Down", sum(tmp))

  # Creates a new table
  res.table<-data.frame(res[,1:5], Direction=ind.reg, res[,6:m])
  
  # Sort the table 
  if(sort==TRUE){
    ord<-order(res.table[,"FDR"], decreasing=F)
    res.table<-res.table[ord,]
  }
  
  # Done
  return(res.table) 
  
}

df = xspecies(file="/Users/avahoffman/Documents/CSU/Research/RNASEQDATA/Kristiansson_analysis/all_paralogs.txt")
  
write.csv(df, file="/Users/avahoffman/Documents/CSU/Research/RNASEQDATA/Kristiansson_analysis/all_paralogs_xspecies_2tail.csv")
