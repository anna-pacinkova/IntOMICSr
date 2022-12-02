#' Random initial network edge generation
#' @description
#' `sample_chain` This function is used to sample random initial network. 
#' The edges are sampled only between GE nodes.
#' @param empty_net adjacency matrix of an empty network/graph 
#' (all values are 0).
#' @param omics_ge matrix with gene expression data (samples in rows and
#' features in columns).
#' @importFrom bnstruct BNDataset
#' @importFrom bnstruct BN
#' @importFrom bnstruct dag
#' @importFrom bnstruct learn.params
#' 
#' @examples
#' data(list=c("PK", "TFtarg_mat", "annot", "layers_def", "omics", 
#' "gene_annot"), package="IntOMICS")
#' omics <- omics_to_list(omics = omics, layers_def = layers_def, 
#' gene_annot = gene_annot)
#' B <- b_prior_mat(omics = omics, PK = PK, layers_def = layers_def, 
#'      annot = annot, lm_METH = TRUE, r_squared_thres = 0.3,
#'      p_val_thres = 0.05, TFtargs = TFtarg_mat, TFBS_belief = 0.75, 
#'      nonGE_belief = 0.5, woPKGE_belief = 0.5)
#' empty.net <- matrix(0, nrow = sum(mapply(ncol,B$omics)), ncol =
#' sum(mapply(ncol,B$omics)), dimnames = list(unlist(mapply(colnames,B$omics)),
#' unlist(mapply(colnames,B$omics))))
#' sample_chain(empty_net = empty.net, 
#'      omics_ge = B$omics[[layers_def$omics[1]]])
#'      
#' @return BN object with conditional probabilities
#' @keywords internal
#' @export 
sample_chain <- function(empty_net, omics_ge)
{
    suppressWarnings(dataset_BND <- BNDataset(data = empty_net, 
        discreteness = rep('d',ncol(empty_net)),
        variables = c(colnames(empty_net)), node.sizes = rep(2,ncol(empty_net)),
        starts.from=0))
    net <- BN(dataset_BND)
    net.dag <- bnstruct::dag(net)
    n <- ncol(omics_ge)
    chain <- sample(n,n)
    for(i in seq(from=2, to=n))
    {
        net.dag[chain[i-1],chain[i]] <- 1
    }
    bnstruct::dag(net) <- net.dag
    return(learn.params(net,dataset_BND))
}