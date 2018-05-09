

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
library(ggplot2)
library(reshape2)
library(plyr)
library(cowplot)



A.gerardii=expression(paste(italic("Andropogon gerardii")))
S.nutans=expression(paste(italic("Sorghastrum nutans")))
#####
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

#####

# --------------------------------------------------------------------------
# Here is your data from REVIGO. Scroll down for plot configuration options.

revigo.names <- c("term_ID","description","frequency_%","plot_X","plot_Y","plot_size","log10_p_value","uniqueness","dispensability");
revigo.data <- rbind(c("GO:0006621","protein retention in ER lumen", 0.042, 2.511,-4.012, 1.176,-3.1542,0.577,0.000),
                     c("GO:0050896","response to stimulus",24.279, 7.244,-2.571, 3.910,-1.5127,0.983,0.000),
                     c("GO:1901562","response to paraquat", 0.003, 2.588, 7.163, 0.301,-1.6831,0.942,0.000),
                     c("GO:0018298","protein-chromophore linkage", 0.406,-5.667,-4.312, 2.137,-2.3773,0.905,0.030),
                     c("GO:0050898","nitrile metabolic process", 0.015,-7.461, 0.590, 0.778,-1.4667,0.871,0.041),
                     c("GO:0016137","glycoside metabolic process", 0.021,-4.832, 5.946, 0.903,-2.6010,0.788,0.047),
                     c("GO:0090436","leaf pavement cell development", 0.006,-2.619,-6.410, 0.477,-1.6838,0.848,0.075),
                     c("GO:0030042","actin filament depolymerization", 0.096,-3.920,-3.461, 1.519,-1.4654,0.836,0.089),
                     c("GO:0044108","cellular alcohol biosynthetic process", 2.499,-3.790, 1.679, 2.923,-1.8583,0.670,0.141),
                     c("GO:1901002","positive regulation of response to salt stress", 0.062, 4.959, 1.487, 1.322,-1.6837,0.809,0.146),
                     c("GO:0022900","electron transport chain", 0.460,-2.529, 6.509, 2.190,-1.8498,0.808,0.189),
                     c("GO:0006007","glucose catabolic process", 0.878,-2.490, 4.311, 2.470,-1.3876,0.774,0.203),
                     c("GO:0009636","response to toxic substance", 0.263, 3.717, 5.870, 1.949,-1.5250,0.933,0.221),
                     c("GO:0009635","response to herbicide", 0.018, 4.842, 4.816, 0.845,-1.3210,0.933,0.248),
                     c("GO:0034755","iron ion transmembrane transport", 0.033, 0.601,-5.940, 1.079,-1.3249,0.811,0.249),
                     c("GO:0006426","glycyl-tRNA aminoacylation", 0.015,-5.740, 0.137, 0.778,-1.8579,0.762,0.283),
                     c("GO:0009638","phototropism", 0.045, 6.246, 2.915, 1.204,-1.4656,0.935,0.308),
                     c("GO:0006883","cellular sodium ion homeostasis", 0.003, 4.401,-4.666, 0.301,-2.1572,0.676,0.311),
                     c("GO:0009735","response to cytokinin", 0.777, 3.957, 5.301, 2.417,-1.4461,0.929,0.335),
                     c("GO:0010106","cellular response to iron ion starvation", 0.338, 3.724, 3.125, 2.057,-1.4652,0.805,0.371),
                     c("GO:0060151","peroxisome localization", 0.122, 1.577,-5.951, 1.623,-2.1571,0.861,0.392),
                     c("GO:0038018","Wnt receptor catabolic process", 0.003, 2.551, 0.805, 0.301,-1.6830,0.695,0.397),
                     c("GO:0032544","plastid translation", 0.030,-4.656,-1.043, 1.041,-1.4649,0.786,0.419),
                     c("GO:0051235","maintenance of location", 0.361, 2.914,-4.721, 2.086,-1.4285,0.723,0.423),
                     c("GO:0097384","cellular lipid biosynthetic process", 0.680,-4.168, 2.978, 2.358,-1.8583,0.685,0.446),
                     c("GO:0046477","glycosylceramide catabolic process", 0.048,-4.525, 3.820, 1.230,-1.6837,0.557,0.467),
                     c("GO:1902882","response to oxidative stress", 0.009, 4.806, 0.770, 0.602,-1.4659,0.840,0.480),
                     c("GO:0010132","dhurrin biosynthetic process", 0.842,-5.125, 2.563, 2.450,-1.6843,0.516,0.483));

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
ex <- one.data [c(19,27,28  ,2,1),]; 
######*******
#p1 <- p1 + geom_text( data = ex, aes(plot_X, plot_Y, label = description), colour = I(alpha("black", 0.85)), size = 3 );
p1 <- p1 + geom_label_repel(data=ex, aes(plot_X, plot_Y, label = description), fill="lightgrey", size=4, nudge_y = 20, segment.alpha = 0.7, box.padding=unit(0.5,"lines"))
p1 <- p1 + labs (y = NULL, x = "Biological Process");
p1=p1+theme(axis.title.x = element_text(size = 20))
p1 <- p1 + theme(legend.key = element_blank(),legend) ;
one.x_range = max(one.data$plot_X) - min(one.data$plot_X);
one.y_range = max(one.data$plot_Y) - min(one.data$plot_Y);
p1=p1+theme(legend.text = element_text(size = 15), legend.title = element_text(size=15))
p1= p1+ theme(legend.position="none")
#p1 <- p1 + xlim(min(one.data$plot_X)-one.x_range/10,max(one.data$plot_X)+one.x_range/10);
#p1 <- p1 + ylim(min(one.data$plot_Y)-one.y_range/10,max(one.data$plot_Y)+one.y_range/10);
p1 <- p1 + xlim(-8.5,8.5);
p1 <- p1 + ylim(-10,30);
p1 <- p1 + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())
p1 <- p1 + theme(plot.margin=unit(c(0.2,0,0,0.2), "cm"))



# --------------------------------------------------------------------------
# Output the plot to screen

#p1;

# Uncomment the line below to also save the plot to a file.
# The file type depends on the extension (default=pdf).

# ggsave("C:/Users/path_to_your_file/revigo-plot.pdf");

# --------------------------------------------------------------------------
# Here is your data from REVIGO. Scroll down for plot configuration options.

revigo.names <- c("term_ID","description","frequency_%","plot_X","plot_Y","plot_size","log10_p_value","uniqueness","dispensability");
revigo.data <- rbind(c("GO:0010287","plastoglobule", 0.289, 4.707, 5.402, 1.771,-3.5853,0.578,0.000),
                     c("GO:0016020","membrane",37.951, 3.169,-6.344, 3.882,-1.4205,0.956,0.000),
                     c("GO:0098562","cytoplasmic side of membrane", 0.045,-2.694, 6.558, 1.000,-1.4675,0.805,0.000),
                     c("GO:0035619","root hair tip", 0.010,-4.957,-3.066, 0.477,-1.4649,0.915,0.009),
                     c("GO:0031975","envelope", 4.707,-2.421,-4.666, 2.976,-1.3469,0.906,0.016),
                     c("GO:0012505","endomembrane system", 9.315, 0.035,-6.023, 3.273,-3.2341,0.907,0.026),
                     c("GO:0005628","prospore membrane", 6.136,-4.955, 1.094, 3.091,-1.5619,0.833,0.114),
                     c("GO:0019897","extrinsic component of plasma membrane", 0.055,-4.089, 4.639, 1.079,-1.3228,0.813,0.135),
                     c("GO:0000786","nucleosome", 0.433, 5.528, 1.878, 1.944,-1.6151,0.529,0.237),
                     c("GO:0031984","organelle subcompartment", 2.020, 3.451, 6.118, 2.610,-1.6083,0.654,0.286),
                     c("GO:0044425","membrane part",25.272,-3.906, 1.904, 3.706,-1.3111,0.856,0.289),
                     c("GO:0032993","protein-DNA complex", 0.498, 6.061,-2.157, 2.004,-1.3616,0.816,0.297),
                     c("GO:0005789","endoplasmic reticulum membrane", 0.687, 0.812, 4.732, 2.143,-1.4134,0.593,0.301),
                     c("GO:0030093","chloroplast photosystem I", 0.010, 4.393, 2.340, 0.477,-2.1579,0.494,0.363),
                     c("GO:1990104","DNA bending complex", 0.433, 6.388,-1.155, 1.944,-1.6151,0.791,0.377),
                     c("GO:0044815","DNA packaging complex", 0.468, 7.079,-0.804, 1.978,-1.5272,0.790,0.380),
                     c("GO:0044435","plastid part", 5.682, 3.800, 5.207, 3.058,-1.5012,0.562,0.418));

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

p2 <- ggplot( data = one.data );
p2 <- p2 + geom_point( aes( plot_X, plot_Y, colour = log10_p_value, size = plot_size), alpha = I(0.6) ) + scale_size_area();
p2 <- p2 + scale_colour_gradientn( colours = c("blue", "green", "yellow", "red"), limits = c( min(one.data$log10_p_value), 0), name="log10 p-value");
p2 <- p2 + geom_point( aes(plot_X, plot_Y, size = plot_size), shape = 21, fill = "transparent", colour = I (alpha ("black", 0.6) )) + scale_size_area();
p2 <- p2 + scale_size( range=c(5, 30), name="frequency") + theme_bw(); # + scale_fill_gradientn(colours = heat_hcl(7), limits = c(-300, 0) );
######******* changing this part
#ex <- one.data [ one.data$dispensability < 0.15, ]; 
ex <- one.data [c(1,6,11),]; 
######*******
#p2 <- p2 + geom_text( data = ex, aes(plot_X, plot_Y, label = description), colour = I(alpha("black", 0.85)), size = 3 );
p2 <- p2 + geom_label_repel(data=ex, aes(plot_X, plot_Y, label = description), fill="lightgrey", size=4, nudge_y = 20,segment.alpha = 0.7)
p2 <- p2 + labs (y = NULL, x = "Cellular Component");
p2=p2+theme(axis.title.x = element_text(size = 20))
p2 <- p2 + theme(legend.key = element_blank()) ;
one.x_range = max(one.data$plot_X) - min(one.data$plot_X);
one.y_range = max(one.data$plot_Y) - min(one.data$plot_Y);
p2=p2+theme(legend.text = element_text(size = 15), legend.title = element_text(size=15))
p2= p2+ theme(legend.position="none")
#p2 <- p2 + xlim(min(one.data$plot_X)-one.x_range/10,max(one.data$plot_X)+one.x_range/10);
#p2 <- p2 + ylim(min(one.data$plot_Y)-one.y_range/10,max(one.data$plot_Y)+one.y_range/10);
p2 <- p2 + xlim(-8.5,8.5);
p2 <- p2 + ylim(-10,30);
p2 <- p2 + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())
p2 <- p2 + theme(plot.margin=unit(c(0.2,0,0,0), "cm"))
p2 <- p2 +  theme(axis.text.y=element_blank(),axis.ticks.y=element_blank())



# --------------------------------------------------------------------------
# Output the plot to screen

#p2;

# Uncomment the line below to also save the plot to a file.
# The file type depends on the extension (default=pdf).

# ggsave("C:/Users/path_to_your_file/revigo-plot.pdf");

# --------------------------------------------------------------------------
# Here is your data from REVIGO. Scroll down for plot configuration options.

revigo.names <- c("term_ID","description","frequency_%","plot_X","plot_Y","plot_size","log10_p_value","uniqueness","dispensability");
revigo.data <- rbind(c("GO:0008526","phosphatidylinositol transporter activity", 0.014,-4.944, 1.319, 0.699,-1.4656,0.927,0.000),
                     c("GO:0046923","ER retention sequence binding", 0.048,-6.619, 3.692, 1.176,-3.3289,0.859,0.000),
                     c("GO:0050370","tyrosine N-monooxygenase activity", 0.012, 6.289, 1.096, 0.602,-2.1583,0.790,0.000),
                     c("GO:0033984","indole-3-glycerol-phosphate lyase activity", 0.007,-5.441,-3.094, 0.477,-1.6838,0.815,0.033),
                     c("GO:0046906","tetrapyrrole binding", 2.604, 5.993,-4.040, 2.884,-2.1481,0.901,0.033),
                     c("GO:0004820","glycine-tRNA ligase activity", 0.017,-2.650, 6.128, 0.778,-1.8579,0.770,0.035),
                     c("GO:0005537","mannose binding", 0.143, 1.575,-2.392, 1.633,-1.6842,0.915,0.037),
                     c("GO:0016765","transferase activity", 0.606,-1.542,-5.320, 2.253,-1.5860,0.835,0.045),
                     c("GO:0004348","glucosylceramidase activity", 0.041,-7.214, 0.112, 1.114,-1.5615,0.874,0.048),
                     c("GO:0016208","AMP binding", 0.003,-1.750, 0.059, 0.301,-1.8578,0.908,0.080),
                     c("GO:0008266","poly(U) RNA binding", 0.054, 2.663, 7.934, 1.230,-1.3212,0.905,0.099),
                     c("GO:0016168","chlorophyll binding", 0.252, 4.135,-5.266, 1.875,-1.6359,0.903,0.115),
                     c("GO:0046481","digalactosyldiacylglycerol synthase activity", 0.007,-0.934,-6.318, 0.477,-1.4647,0.855,0.172),
                     c("GO:0004659","prenyltransferase activity", 0.167, 0.546,-6.012, 1.699,-1.7125,0.810,0.220),
                     c("GO:0000293","ferric-chelate reductase activity", 0.027, 5.184, 1.560, 0.954,-1.8583,0.742,0.241),
                     c("GO:0047037","salutaridine reductase (NADPH) activity", 0.021, 4.614, 3.232, 0.845,-1.6855,0.786,0.249),
                     c("GO:0033743","peptide-methionine (R)-S-oxide reductase activity", 0.037, 6.390, 2.552, 1.079,-1.6842,0.781,0.258),
                     c("GO:0004497","monooxygenase activity", 1.753, 5.525, 2.519, 2.713,-1.3551,0.745,0.348),
                     c("GO:0016722","oxidoreductase activity, oxidizing metal ions", 0.065, 5.633, 3.602, 1.301,-1.3224,0.776,0.365),
                     c("GO:0004834","tryptophan synthase activity", 0.034,-5.116,-3.507, 1.041,-1.3222,0.817,0.433),
                     c("GO:0004066","asparagine synthase (glutamine-hydrolyzing) activity", 0.034,-1.770, 6.792, 1.041,-1.4662,0.765,0.443),
                     c("GO:0016851","magnesium chelatase activity", 0.024,-2.446, 6.690, 0.903,-1.3864,0.732,0.452),
                     c("GO:0051002","ligase activity, forming nitrogen-metal bonds", 0.024,-1.871, 6.198, 0.903,-1.3864,0.767,0.452));

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

p3 <- ggplot( data = one.data );
p3 <- p3 + geom_point( aes( plot_X, plot_Y, colour = log10_p_value, size = plot_size), alpha = I(0.6) ) + scale_size_area();
p3 <- p3 + scale_colour_gradientn( colours = c("blue", "green", "yellow", "red"), limits = c( min(one.data$log10_p_value), 0), name="log10 p-value");
p3 <- p3 + geom_point( aes(plot_X, plot_Y, size = plot_size), shape = 21, fill = "transparent", colour = I (alpha ("black", 0.6) )) + scale_size_area();
p3 <- p3 + scale_size( range=c(5, 30), name="frequency") + theme_bw(); # + scale_fill_gradientn(colours = heat_hcl(7), limits = c(-300, 0) );
######******* changing this part
#ex <- one.data [ one.data$dispensability < 0.15, ]; 
ex <- one.data [c(2,8,18,5),]; 
######*******
#p3 <- p3 + geom_text( data = ex, aes(plot_X, plot_Y, label = description), colour = I(alpha("black", 0.85)), size = 3 );
p3 <- p3 + geom_label_repel(data=ex, aes(plot_X, plot_Y, label = description), fill="lightgrey", size=4, nudge_y = 20,segment.alpha = 0.7)
p3 <- p3 + labs (y = NULL, x = "Molecular Function");
p3=p3+theme(axis.title.x = element_text(size = 20))
p3 <- p3 + theme(legend.key = element_blank()) ;
one.x_range = max(one.data$plot_X) - min(one.data$plot_X);
one.y_range = max(one.data$plot_Y) - min(one.data$plot_Y);
p3=p3+theme(legend.text = element_text(size = 15), legend.title = element_text(size=15))
p3= p3+ theme(legend.position="none")
#p3 <- p3 + xlim(min(one.data$plot_X)-one.x_range/10,max(one.data$plot_X)+one.x_range/10);
#p3 <- p3 + ylim(min(one.data$plot_Y)-one.y_range/10,max(one.data$plot_Y)+one.y_range/10);
p3 <- p3 + xlim(-8.5,8.5);
p3 <- p3 + ylim(-10,30);
p3 <- p3 + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())
p3 <- p3 + theme(plot.margin=unit(c(0.2,0.2,0.08,0), "cm"))
p3 <- p3 +  theme(axis.text.y=element_blank(),axis.ticks.y=element_blank())




# --------------------------------------------------------------------------
# Output the plot to screen

#p3;

# Uncomment the line below to also save the plot to a file.
# The file type depends on the extension (default=pdf).

# ggsave("C:/Users/path_to_your_file/revigo-plot.pdf");



A.gerardii=expression(paste(italic("Andropogon gerardii")))
S.nutans=expression(paste(italic("Sorghastrum nutans")))

#pdf(file="/Users/avahoffman/Documents/CSU/Research/RNASEQDATA/MEC_reanalysis/Kristiansson-plots/revigo-go-plot.pdf",height=6,width=15)
grid=plot_grid( p1,p2,p3,
                #align = 'h',
                #labels = c("A", "B", "C", "D", "E", "F"),
                #label_size=35,
                #hjust = -0.5,
                nrow = 1,
                rel_widths=c(1,1,1) )
grobs=ggplotGrob(plot1 + theme(legend.position="bottom",legend.box.just = "left"))$grobs
legend=grobs[[which(sapply(grobs, function(x) x$name) == "guide-box")]]
#add legend
pdf(file="/Users/avahoffman/Documents/CSU/Research/Shenghua_Data_Manuscripts/RNA-seq/MER-resubmit/FIGURE_6.pdf",height=6,width=14.1732)
plot_grid(grid, legend, ncol = 1, rel_heights = c(1, .3)) 
dev.off()
