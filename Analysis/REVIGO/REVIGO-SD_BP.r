

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
revigo.data <- rbind(c("GO:0009735","response to cytokinin", 0.777,-3.544,-6.286, 2.417,-2.2752,0.900,0.000),
c("GO:0055064","chloride ion homeostasis", 0.022,-3.526, 3.955, 0.903,-2.0541,0.713,0.000),
c("GO:0070966","nuclear-transcribed mRNA catabolic process, no-go decay", 0.006, 6.140, 2.028, 0.477,-2.2064,0.840,0.000),
c("GO:0008154","actin depolymerization", 0.409, 2.979, 4.942, 2.140,-1.7718,0.739,0.026),
c("GO:0006825","copper ion transport", 0.057,-0.760, 6.134, 1.301,-1.3284,0.849,0.059),
c("GO:0010431","seed maturation", 0.541,-6.501, 2.936, 2.260,-1.3556,0.889,0.071),
c("GO:0070981","L-asparagine biosynthetic process", 0.018, 5.109,-4.669, 0.845,-2.0333,0.718,0.111),
c("GO:1902882","regulation of response to oxidative stress", 0.009,-5.126,-1.758, 0.602,-1.6661,0.808,0.151),
c("GO:0009298","GDP-mannose biosynthetic process", 0.033, 4.024,-2.333, 1.079,-1.8232,0.695,0.232),
c("GO:0009408","response to heat", 1.019,-4.666,-4.489, 2.534,-1.3634,0.866,0.243),
c("GO:0050898","nitrile metabolic process", 0.015, 3.229,-6.939, 0.778,-1.6943,0.854,0.253),
c("GO:1901562","response to paraquat", 0.003,-2.274,-7.746, 0.301,-1.8455,0.914,0.280),
c("GO:0016137","glycoside metabolic process", 0.021, 1.072,-1.637, 0.903,-1.3914,0.778,0.316),
c("GO:0006621","protein retention in ER lumen", 0.042,-2.612, 3.801, 1.176,-1.9054,0.623,0.350),
c("GO:0006426","glycyl-tRNA aminoacylation", 0.015, 5.664,-3.161, 0.778,-1.7332,0.754,0.373),
c("GO:0006782","protoporphyrinogen IX biosynthetic process", 0.048, 4.397,-4.900, 1.230,-1.3573,0.724,0.377),
c("GO:1902884","positive regulation of response to oxidative stress", 0.003,-5.715,-2.026, 0.301,-1.7758,0.809,0.406),
c("GO:0000027","ribosomal large subunit assembly", 0.029, 2.658, 5.460, 1.000,-1.3584,0.881,0.439),
c("GO:0032544","plastid translation", 0.030, 5.427,-1.177, 1.041,-1.5388,0.733,0.464),
c("GO:0042538","hyperosmotic salinity response", 0.460,-4.936,-4.058, 2.190,-1.3436,0.847,0.467),
c("GO:0047484","response to osmotic stress", 0.012,-5.228,-2.828, 0.699,-1.3249,0.792,0.509),
c("GO:0010132","dhurrin biosynthesis", 0.826, 4.087,-3.385, 2.442,-1.7463,0.417,0.537),
c("GO:0071025","RNA surveillance", 0.006, 5.468, 2.153, 0.477,-1.7393,0.840,0.580),
c("GO:0070481","nuclear-transcribed mRNA catabolic process, non-stop decay", 0.006, 5.808, 2.195, 0.477,-2.2064,0.840,0.599),
c("GO:0055078","sodium ion homeostasis", 0.006,-3.318, 4.559, 0.477,-1.8917,0.744,0.632),
c("GO:1901002","positive regulation of response to salt stress", 0.062,-4.845,-2.478, 1.322,-1.7681,0.734,0.639),
c("GO:0046501","protoporphyrinogen IX metabolic process", 0.048, 4.047,-5.975, 1.230,-1.3573,0.816,0.646));

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
ex <- one.data [ c(4,6,21,20,22,1), ]; 

#p1 <- p1 + geom_text( data = ex, aes(plot_X, plot_Y, label = description), colour = I(alpha("black", 0.85)), size = 3 );
p1 <- p1 + geom_label_repel(data=ex, aes(plot_X, plot_Y, label = description), fill="lightgrey", size=4, nudge_y = 20,segment.alpha = 0.7)

p1 <- p1 + labs (y = S.nutans, x = "Biological Process");
p1=p1+theme(axis.title.y = element_text(size = 20))
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
p1 <- p1 + theme(plot.margin=unit(c(0,0,0,0.5), "cm"))




# --------------------------------------------------------------------------
# Output the plot to screen

plot4=p1
plot4
# Uncomment the line below to also save the plot to a file.
# The file type depends on the extension (default=pdf).

# ggsave("C:/Users/path_to_your_file/revigo-plot.pdf");
