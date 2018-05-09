

# A plotting R script produced by the REVIGO server at http://revigo.irb.hr/
# If you found REVIGO useful in your work, please cite the following reference:
# Supek F et al. "REVIGO summarizes and visualizes long lists of Gene Ontology
# terms" PLoS ONE 2011. doi:10.1371/journal.pone.0021800


# --------------------------------------------------------------------------
# If you don't have the ggplot2 package installed, uncomment the following line:
# install.packages( "ggplot2" );
library( ggplot2 );
# --------------------------------------------------------------------------
# If you don't have the scales package installed, uncomment the following line:
# install.packages( "scales" );
library( scales );


# --------------------------------------------------------------------------
# Here is your data from REVIGO. Scroll down for plot configuration options.

revigo.names <- c("term_ID","description","frequency_%","plot_X","plot_Y","plot_size","log10_p_value","uniqueness","dispensability");
revigo.data <- rbind(c("GO:0009295","nucleoid", 0.194,-3.879, 4.178, 1.602,-1.5280,0.903,0.000),
c("GO:0009522","photosystem I", 0.343, 5.128,-1.811, 1.845,-2.5291,0.517,0.000),
c("GO:0032991","macromolecular complex",15.256,-0.314, 5.459, 3.487,-1.3597,0.917,0.000),
c("GO:0009508","plastid chromosome", 0.080,-2.323,-4.915, 1.230,-1.9145,0.541,0.022),
c("GO:0009536","plastid",12.470,-5.522,-0.125, 3.399,-1.4412,0.744,0.131),
c("GO:0098562","cytoplasmic side of membrane", 0.045, 3.404, 3.825, 1.000,-1.9852,0.769,0.154),
c("GO:0098552","side of membrane", 0.065, 5.752, 2.841, 1.146,-1.5946,0.836,0.158),
c("GO:0031984","organelle subcompartment", 2.020, 1.115,-8.000, 2.610,-1.4346,0.680,0.243),
c("GO:0000178","exosome (RNase complex)", 0.035, 6.219,-3.322, 0.903,-1.5353,0.751,0.301),
c("GO:0005956","protein kinase CK2 complex", 0.055, 5.839,-4.487, 1.079,-1.9640,0.747,0.311),
c("GO:0015629","actin cytoskeleton", 0.358,-4.489,-6.603, 1.863,-1.6297,0.791,0.337),
c("GO:0000176","nuclear exosome (RNase complex)", 0.268, 3.793,-5.375, 1.732,-1.5563,0.580,0.354),
c("GO:0009507","chloroplast",12.066,-3.328,-1.252, 3.385,-1.5163,0.572,0.394),
c("GO:0000229","cytoplasmic chromosome", 0.080,-4.947,-4.878, 1.230,-1.9145,0.735,0.572),
c("GO:0030093","chloroplast photosystem I", 0.010, 2.446,-3.200, 0.477,-2.5248,0.454,0.645));

one.data <- data.frame(revigo.data);
names(one.data) <- revigo.names;
one.data <- one.data [(one.data$plot_X != "null" & one.data$plot_Y != "null"), ];
one.data$plot_X <- as.numeric( as.character(one.data$plot_X) );
one.data$plot_Y <- as.numeric( as.character(one.data$plot_Y) );
one.data$plot_size <- as.numeric( as.character(one.data$plot_size) );
one.data$log10_p_value <- as.numeric( as.character(one.data$log10_p_value) );
one.data$frequency <- as.numeric( as.character(one.data$frequency) );
one.data$uniqueness <- as.numeric( as.character(one.data$uniqueness) );
one.data$dispensability <- as.numeric( as.character(one.data$dispensability) );
#head(one.data);


# --------------------------------------------------------------------------
# Names of the axes, sizes of the numbers and letters, names of the columns,
# etc. can be changed below

p1 <- ggplot( data = one.data );
p1 <- p1 + geom_point( aes( plot_X, plot_Y, colour = log10_p_value, size = plot_size), alpha = I(0.6) ) + scale_size_area();
p1 <- p1 + scale_colour_gradientn( colours = c("blue", "green", "yellow", "red"), limits = c( min(one.data$log10_p_value), 0) );
p1 <- p1 + geom_point( aes(plot_X, plot_Y, size = plot_size), shape = 21, fill = "transparent", colour = I (alpha ("black", 0.6) )) + scale_size_area();
p1 <- p1 + scale_size( range=c(5, 30)) + theme_bw(); # + scale_fill_gradientn(colours = heat_hcl(7), limits = c(-300, 0) );

#ex <- one.data [ one.data$dispensability < 0.15, ]; 
ex <- one.data [ c(2,3,13), ]; 

#p1 <- p1 + geom_text( data = ex, aes(plot_X, plot_Y, label = description), colour = I(alpha("black", 0.85)), size = 3 );
p1 <- p1 + geom_label_repel(data=ex, aes(plot_X, plot_Y, label = description), fill="lightgrey", size=4, nudge_y = 20,segment.alpha = 0.7)

p1 <- p1 + labs (y = NULL, x = "Cellular Component");
p1=p1+theme(axis.title.x = element_text(size = 20))
p1 <- p1 + theme(legend.key = element_blank()) ;
one.x_range = max(one.data$plot_X) - min(one.data$plot_X);
one.y_range = max(one.data$plot_Y) - min(one.data$plot_Y);
p1= p1+ theme(legend.position="none")
p1 <- p1 + xlim(min(one.data$plot_X)-one.x_range/10,max(one.data$plot_X)+one.x_range/10);
#p1 <- p1 + ylim(min(one.data$plot_Y)-one.y_range/10,max(one.data$plot_Y)+one.y_range/10);
p1 <- p1 + xlim(-8.5,8.5);
p1 <- p1 + ylim(-10,30);
p1 <- p1 + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())
p1 <- p1 + theme(plot.margin=unit(c(0,0.2,0,0), "cm"))
p1 <- p1 +  theme(axis.text.y=element_blank(),axis.ticks.y=element_blank())





# --------------------------------------------------------------------------
# Output the plot to screen

plot6=p1
plot6
# Uncomment the line below to also save the plot to a file.
# The file type depends on the extension (default=pdf).

# ggsave("C:/Users/path_to_your_file/revigo-plot.pdf");
