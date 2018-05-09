

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
revigo.data <- rbind(c("GO:0045735","nutrient reservoir activity", 0.286,-6.449,-3.933, 1.929,-1.3427,0.879,0.000),
c("GO:0046923","ER retention sequence binding", 0.048,-1.986, 6.791, 1.176,-1.9764,0.857,0.000),
c("GO:0050370","tyrosine N-monooxygenase activity", 0.012, 5.932, 1.527, 0.602,-2.4137,0.799,0.000),
c("GO:0019843","rRNA binding", 0.347,-6.084, 1.818, 2.013,-1.6615,0.714,0.028),
c("GO:0008905","mannose-phosphate guanylyltransferase activity", 0.014,-1.873,-6.799, 0.699,-1.9672,0.706,0.034),
c("GO:0004820","glycine-tRNA ligase activity", 0.017, 5.166,-4.319, 0.778,-1.7332,0.796,0.035),
c("GO:0003913","DNA photolyase activity", 0.071, 1.340, 6.847, 1.342,-1.4846,0.842,0.039),
c("GO:1901363","heterocyclic compound binding",39.805,-1.370,-1.998, 4.068,-1.5485,0.875,0.057),
c("GO:0097159","organic cyclic compound binding",39.816, 0.114,-0.610, 4.068,-1.5353,0.875,0.204),
c("GO:0008883","glutamyl-tRNA reductase activity", 0.010, 4.695, 3.645, 0.602,-1.7620,0.800,0.228),
c("GO:0004616","phosphogluconate dehydrogenase (decarboxylating) activity", 0.051, 5.609, 2.765, 1.204,-1.3716,0.795,0.250),
c("GO:0008097","5S rRNA binding", 0.027,-5.490, 3.014, 0.954,-1.8006,0.733,0.432),
c("GO:0008266","poly(U) RNA binding", 0.054,-6.164, 2.465, 1.230,-1.4688,0.677,0.455),
c("GO:0016884","carbon-nitrogen ligase activity, with glutamine as amido-N-donor", 0.095, 4.676,-4.861, 1.462,-1.3241,0.793,0.472),
c("GO:0070568","guanylyltransferase activity", 0.051,-1.117,-6.933, 1.204,-1.5934,0.740,0.505));

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
ex <- one.data [ c(1,8), ]; 

#p1 <- p1 + geom_text( data = ex, aes(plot_X, plot_Y, label = description), colour = I(alpha("black", 0.85)), size = 3 );
p1 <- p1 + geom_label_repel(data=ex, aes(plot_X, plot_Y, label = description), fill="lightgrey", size=4, nudge_y = 20,segment.alpha = 0.7)

p1 <- p1 + labs (y = NULL, x = "Molecular Function");
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
p1 <- p1 + theme(plot.margin=unit(c(0,0,0.1,0), "cm"))
p1 <- p1 +  theme(axis.text.y=element_blank(),axis.ticks.y=element_blank())




# --------------------------------------------------------------------------
# Output the plot to screen

plot5=p1
plot5
# Uncomment the line below to also save the plot to a file.
# The file type depends on the extension (default=pdf).

# ggsave("C:/Users/path_to_your_file/revigo-plot.pdf");
