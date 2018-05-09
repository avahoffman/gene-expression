

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
revigo.data <- rbind(c("GO:0009638","phototropism", 0.045, 3.290,-6.436, 1.204,-2.8910,0.878,0.000),
c("GO:0009772","photosynthetic electron transport in photosystem II", 0.027,-4.504, 4.809, 1.000,-3.2998,0.783,0.000),
c("GO:0006369","termination of RNA polymerase II transcription", 0.040, 5.298, 3.321, 1.146,-2.2063,0.845,0.044),
c("GO:0048698","negative regulation of collateral sprouting in absence of injury", 0.003,-5.435,-2.171, 0.301,-2.2014,0.450,0.070),
c("GO:0016099","monoterpenoid biosynthetic process", 0.003, 0.427, 6.034, 0.301,-1.7547,0.823,0.105),
c("GO:0006470","protein dephosphorylation", 0.723, 0.564,-0.133, 2.386,-2.1843,0.881,0.106),
c("GO:0006007","glucose catabolic process", 0.878,-1.804, 5.978, 2.470,-1.4871,0.801,0.132),
c("GO:0015904","tetracycline transport", 0.066, 5.522,-3.201, 1.362,-2.2920,0.796,0.143),
c("GO:0090092","regulation of transmembrane receptor protein serine/threonine kinase signaling pathway", 0.111, 1.119,-5.618, 1.580,-2.0157,0.693,0.152),
c("GO:0034389","lipid particle organization", 0.006,-6.886, 1.747, 0.477,-1.9798,0.860,0.180),
c("GO:0006379","mRNA cleavage", 0.018, 6.263, 1.676, 0.845,-1.7695,0.893,0.181),
c("GO:0006378","mRNA polyadenylation", 0.030, 6.332, 2.540, 1.041,-1.3200,0.891,0.186),
c("GO:1901998","toxin transport", 0.003,-0.335,-7.726, 0.301,-2.0227,0.962,0.195),
c("GO:0009605","response to external stimulus", 6.919, 3.717,-5.514, 3.365,-1.7390,0.889,0.226),
c("GO:0009635","response to herbicide", 0.018, 4.843,-3.570, 0.845,-1.5538,0.904,0.227),
c("GO:0010193","response to ozone", 0.099, 4.745,-4.563, 1.531,-1.3185,0.895,0.254),
c("GO:0010132","dhurrin biosynthesis", 0.826, 2.661, 4.520, 2.442,-1.6842,0.566,0.254),
c("GO:0051881","regulation of mitochondrial membrane potential", 0.003,-2.603,-7.384, 0.301,-1.8353,0.885,0.272),
c("GO:0030042","actin filament depolymerization", 0.096,-6.235, 2.211, 1.519,-1.7456,0.747,0.301),
c("GO:0060612","adipose tissue development", 0.868,-5.563,-3.801, 2.464,-1.9629,0.707,0.312),
c("GO:0050898","nitrile metabolic process", 0.015, 3.503, 5.639, 0.778,-1.6620,0.907,0.324),
c("GO:0006515","misfolded protein catabolic process", 0.015,-0.785, 1.548, 0.778,-1.4849,0.891,0.333),
c("GO:0018298","protein-chromophore linkage", 0.406, 0.234,-0.512, 2.137,-1.8574,0.892,0.356),
c("GO:0009838","abscission", 0.149,-5.950,-4.029, 1.708,-1.4874,0.763,0.370),
c("GO:0009606","tropism", 0.433, 4.700,-5.463, 2.164,-1.7627,0.870,0.378),
c("GO:0016098","monoterpenoid metabolic process", 0.003,-0.872, 5.450, 0.301,-1.7547,0.851,0.437),
c("GO:0003008","system process", 0.900,-6.397,-3.002, 2.480,-1.3986,0.762,0.438),
c("GO:0051960","regulation of nervous system development", 0.244,-4.964,-4.344, 1.914,-1.3509,0.648,0.460),
c("GO:0009267","cellular response to starvation", 0.866, 3.437,-4.645, 2.464,-1.5907,0.697,0.488),
c("GO:0043102","amino acid salvage", 0.045, 2.116, 5.713, 1.204,-1.4265,0.766,0.491),
c("GO:0009637","response to blue light", 0.382, 2.870,-6.436, 2.111,-1.7933,0.899,0.492),
c("GO:0006353","DNA-templated transcription, termination", 0.036, 5.124, 3.053, 1.114,-1.5344,0.857,0.500),
c("GO:0071265","L-methionine biosynthetic process", 0.066, 2.270, 5.409, 1.362,-1.3347,0.757,0.507),
c("GO:0010270","photosystem II oxygen evolving complex assembly", 0.006,-5.483, 3.537, 0.477,-1.7294,0.786,0.510),
c("GO:0035970","peptidyl-threonine dephosphorylation", 0.003,-0.363,-1.126, 0.301,-2.1513,0.907,0.535),
c("GO:0050905","neuromuscular process", 9.993,-5.982,-3.002, 3.525,-2.0414,0.666,0.591),
c("GO:0043252","sodium-independent organic anion transport", 0.114, 6.866,-1.394, 1.591,-2.2920,0.876,0.631),
c("GO:0051961","negative regulation of nervous system development", 0.050,-4.947,-4.006, 1.230,-1.6966,0.578,0.666),
c("GO:0010207","photosystem II assembly", 0.439,-5.561, 3.247, 2.170,-2.2837,0.728,0.670),
c("GO:0022900","electron transport chain", 0.460,-3.777, 4.726, 2.190,-1.6562,0.756,0.689),
c("GO:0061448","connective tissue development", 0.360,-4.528,-5.351, 2.083,-1.9629,0.822,0.695));

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
p1 <- p1 + scale_colour_gradientn( colours = c("blue", "green", "yellow", "red"), limits = c( min(one.data$log10_p_value), 0), name="log10 p-value");
p1 <- p1 + geom_point( aes(plot_X, plot_Y, size = plot_size), shape = 21, fill = "transparent", colour = I (alpha ("black", 0.6) )) + scale_size_area();
p1 <- p1 + scale_size( range=c(5, 30), name="frequency") + theme_bw(); # + scale_fill_gradientn(colours = heat_hcl(7), limits = c(-300, 0) );
######******* changing this part
#ex <- one.data [ one.data$dispensability < 0.15, ]; 
ex <- one.data [c(24,30,17,22,6,14),]; 
######*******
#p1 <- p1 + geom_text( data = ex, aes(plot_X, plot_Y, label = description), colour = I(alpha("black", 0.85)), size = 5 );
p1 <- p1 + geom_label_repel(data=ex, aes(plot_X, plot_Y, label = description), fill="lightgrey", size=4, nudge_y = 20,segment.alpha = 0.7,box.padding=unit(1.5,"lines"))
p1 <- p1 + labs (y = A.gerardii, x = NULL);
p1=p1+theme(axis.title.y = element_text(size = 20))
p1 <- p1 + theme(legend.key = element_blank()) ;
one.x_range = max(one.data$plot_X) - min(one.data$plot_X);
one.y_range = max(one.data$plot_Y) - min(one.data$plot_Y);
p1=p1+theme(legend.text = element_text(size = 15), legend.title = element_text(size=15))
p1= p1+ theme(legend.position="none")
p1 <- p1 + xlim(min(one.data$plot_X)-one.x_range/10,max(one.data$plot_X)+one.x_range/10);
#p1 <- p1 + ylim(min(one.data$plot_Y)-one.y_range/10,max(one.data$plot_Y)+one.y_range/10);
p1 <- p1 + xlim(-8.5,8.5);
p1 <- p1 + ylim(-10,30);
p1 <- p1 + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())
p1 <- p1 + theme(plot.margin=unit(c(0,0,0,0.5), "cm"))
p1 <- p1 +  theme(axis.text.x=element_blank(),axis.ticks.x=element_blank())






# --------------------------------------------------------------------------
# Output the plot to screen

plot1=p1
plot1

# Uncomment the line below to also save the plot to a file.
# The file type depends on the extension (default=pdf).

# ggsave("C:/Users/path_to_your_file/revigo-plot.pdf");
