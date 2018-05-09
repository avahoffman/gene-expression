

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
revigo.data <- rbind(c("GO:0031526","brush border membrane", 0.065, 4.385,-6.129, 1.146,-2.2920,0.651,0.000),
c("GO:0045202","synapse",19.205,-5.220,-1.570, 3.587,-1.7196,0.912,0.000),
c("GO:0010287","plastoglobule", 0.289, 6.261, 2.463, 1.771,-1.7189,0.621,0.011),
c("GO:0030496","midbody", 6.665,-4.873, 2.435, 3.127,-1.8492,0.868,0.016),
c("GO:0015629","actin cytoskeleton", 0.358,-0.108, 6.750, 1.863,-1.5703,0.802,0.041),
c("GO:0019867","outer membrane", 0.532,-2.881,-5.479, 2.033,-1.5432,0.784,0.096),
c("GO:0009523","photosystem II", 0.642, 1.166,-5.155, 2.114,-1.9773,0.366,0.166),
c("GO:0005849","mRNA cleavage factor complex", 0.055, 3.672,-0.534, 1.079,-1.5555,0.674,0.327),
c("GO:0005811","lipid particle", 0.328,-1.108, 6.215, 1.826,-1.3235,0.802,0.379),
c("GO:0031968","organelle outer membrane", 0.478, 5.807,-1.854, 1.987,-1.5460,0.575,0.460),
c("GO:0044434","chloroplast part", 5.528, 6.110, 1.608, 3.046,-1.5599,0.548,0.619),
c("GO:0044435","plastid part", 5.682, 6.557, 1.082, 3.058,-1.5517,0.607,0.632));

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

# <- one.data [ one.data$dispensability < 0.15, ]; 
ex <- one.data [ c(6,11,10,1), ]; 

#p1 <- p1 + geom_text( data = ex, aes(plot_X, plot_Y, label = description), colour = I(alpha("black", 0.85)), size = 5 );
p1 <- p1 + geom_label_repel(data=ex, aes(plot_X, plot_Y, label = description), fill="lightgrey", size=4, nudge_y = 20,segment.alpha = 0.7)

p1 <- p1 + labs (y = NULL, x = NULL);
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
p1 <- p1 +  theme(axis.text.x=element_blank(),axis.ticks.x=element_blank())
p1 <- p1 +  theme(axis.text.y=element_blank(),axis.ticks.y=element_blank())




# --------------------------------------------------------------------------
# Output the plot to screen

plot3=p1
plot3
# Uncomment the line below to also save the plot to a file.
# The file type depends on the extension (default=pdf).

# ggsave("C:/Users/path_to_your_file/revigo-plot.pdf");
