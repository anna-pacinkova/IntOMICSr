% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ggraph_weighted_net.R
\name{ggraph_weighted_net}
\alias{ggraph_weighted_net}
\title{Regulatory network plot with edge labels}
\usage{
ggraph_weighted_net(
  net,
  node_size = 10,
  node_label_size = 4,
  edge_label_size = 4
)
}
\arguments{
\item{net}{list output from the trace_plots function.}

\item{node_size}{numeric node size}

\item{node_label_size}{numeric node label size}

\item{edge_label_size}{numeric edge label size}
}
\value{
Figure of weighted network
}
\description{
\code{ggraph_weighted_net} Figure of the regulatory network.
}
\examples{
if(interactive()){data(list=c("OMICS_mod_res", "BN_mod_res", "gene_annot", "TFtarg_mat", 
"PK"), package="IntOMICSr")
res_weighted <- edge_weights(mcmc_res = BN_mod_res, burn_in = 10000, 
 thin = 500, edge_freq_thres = 0.3)
weighted_net_res <- weighted_net(cpdag_weights = res_weighted, 
 gene_annot = gene_annot, PK = PK, OMICS_mod_res = OMICS_mod_res, 
 gene_ID = "gene_symbol", TFtargs = TFtarg_mat,
 B_prior_mat_weighted = B_prior_mat_weighted(BN_mod_res))
library(ggraph)
ggraph_weighted_net(weighted_net_res)}

}
