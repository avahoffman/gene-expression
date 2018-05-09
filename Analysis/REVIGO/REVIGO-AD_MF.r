

# A plotting R script produced by the REVIGO server at http://revigo.irb.hr/
# If you found REVIGO useful in your work, please cite the following reference:
# Supek F et al. "REVIGO summarizes and visualizes long lists of Gene Ontology
# terms" PLoS ONE 2011. doi:10.1371/journal.pone.0021800


# --------------------------------------------------------------------------
# If you don't have the ggplot2 package installed, uncomment the following line:
# install.packages( "ggplot2" );
library( ggplot2 );
library(ggrepel)
# --------------------------------------------------------------------------
# If you don't have the scales package installed, uncomment the following line:
# install.packages( "scales" );
library( scales );


# --------------------------------------------------------------------------
# Here is your data from REVIGO. Scroll down for plot configuration options.

revigo.names <- c("term_ID","description","frequency_%","plot_X","plot_Y","plot_size","log10_p_value","uniqueness","dispensability");
revigo.data <- rbind(c("GO:0001071","binding transcription factor activity", 6.456,-2.280, 7.025, 3.278,-1.3198,0.927,0.000),
c("GO:0003700","transcription factor activity", 6.453,-6.961, 3.476, 3.278,-1.3235,0.927,0.000),
c("GO:0009055","electron carrier activity", 0.813,-2.344, 3.036, 2.380,-1.5831,0.922,0.000),
c("GO:0019534","toxin transporter activity", 0.835, 4.796,-4.372, 2.391,-2.2920,0.842,0.000),
c("GO:0046906","tetrapyrrole binding", 2.604, 2.836, 0.206, 2.884,-3.3146,0.888,0.000),
c("GO:0050370","tyrosine N-monooxygenase activity", 0.012,-6.536,-1.236, 0.602,-2.1594,0.815,0.000),
c("GO:0004328","formamidase activity", 0.003, 0.452,-6.695, 0.301,-1.7457,0.863,0.032),
c("GO:0046522","S-methyl-5-thioribose kinase activity", 0.003, 6.367, 1.946, 0.301,-1.9121,0.878,0.032),
c("GO:0000993","RNA polymerase II core binding", 0.100, 2.878, 5.446, 1.477,-1.7232,0.641,0.036),
c("GO:0005506","iron ion binding", 2.396,-4.975, 5.623, 2.848,-1.6343,0.901,0.051),
c("GO:0016168","chlorophyll binding", 0.252, 0.263,-1.317, 1.875,-2.5137,0.846,0.115),
c("GO:0046481","digalactosyldiacylglycerol synthase activity", 0.007, 6.609,-0.504, 0.477,-1.4563,0.835,0.127),
c("GO:0008026","ATP-dependent helicase activity", 0.347,-1.086,-6.589, 2.013,-1.4117,0.806,0.179),
c("GO:0001098","basal transcription machinery binding", 0.003, 1.399, 6.202, 0.301,-1.5733,0.858,0.200),
c("GO:0008138","protein tyrosine/serine/threonine phosphatase activity", 0.092,-2.218,-6.699, 1.447,-1.3325,0.851,0.226),
c("GO:0004497","monooxygenase activity", 1.753,-6.338,-2.688, 2.713,-1.8458,0.801,0.318),
c("GO:0016709","oxidoreductase activity, acting on paired donors, with incorporation or reduction of molecular oxygen, NAD(P)H as one donor, and incorporation of one atom of oxygen", 0.255,-6.372,-1.771, 1.881,-1.5642,0.796,0.530),
c("GO:0016705","oxidoreductase activity, acting on paired donors, with incorporation or reduction of molecular oxygen", 2.985,-5.901,-2.415, 2.943,-1.7031,0.797,0.550),
c("GO:0008493","tetracycline transporter activity", 0.436, 4.491,-4.732, 2.111,-2.2920,0.798,0.564),
c("GO:0070063","RNA polymerase binding", 0.010, 3.295, 5.262, 0.602,-1.5320,0.794,0.632));

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
####
#ex <- one.data [ one.data$dispensability < 0.15, ]; 
ex <- one.data [ c(1,2,5,16,4), ]; 
####
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
p1 <- p1 + theme(plot.margin=unit(c(0,0,0,0), "cm"))
p1 <- p1 +  theme(axis.text.x=element_blank(),axis.ticks.x=element_blank())
p1 <- p1 +  theme(axis.text.y=element_blank(),axis.ticks.y=element_blank())
 


# --------------------------------------------------------------------------
# Output the plot to screen

plot2=p1
plot2

# Uncomment the line below to also save the plot to a file.
# The file type depends on the extension (default=pdf).

# ggsave("C:/Users/path_to_your_file/revigo-plot.pdf");
