# Project Title

MPSSC: Using Multiple kernels with pairwise and element-wise sparse spectral clustering  

## Overview

MPSSC is a novel spectral clustering framework that imposes sparse structures on a target matrix. Specifically,it utilizes a doubly stochastic affinity matrix to construct a normalized graph Laplacian. Then, it imposes a sparse structure on the target matrix followed by shrinking pairwise differences of the rows in the target matrix. This spectral clustering method uses multiple similarity matrices via non-convex optimization framework. The proposed non-convex problem iteratively using the ADMM algorithm.

### Main functions

SK_normalize.m: Perform SK algorithm to obtain a doubly stochastic matrix (Step 1).

clus_sim_update0_2.m: ADMM algorithm (Step 2).

clus_sim_update2_2.m: An iterative algorithm solving the proposed biconvex problem (Step 2).

clus_sim_update0_3.m: ADMM algorithm (Step 3).

run_real_data_results.m: Example (small-scale scRNA-seq data sets)

run_real_data_results_large.m: Example (large-scale scRNA-seq data sets)


```
Give examples
```

### Codes

All the functions used in the proposed algorithm are located in the directory "Functions".

All the matlab codes related to generating plots shown in the manuscript are located in the directory "Working_m_files".

All the resulting files such as MAT and eps are located in the directory "Results_files".

The nine scRNA-seq data sets used in the manuscript are located in the directory "Data_files".



The remainning directories:

"SIMLR-SIMLR" includes all the files related to SIMLR.

"SparseSC"  includes all the files related to Sparse clustering (SC).

"tSNE"  includes all the files related to t-SNE.



Say what the step will be

```
Give the example
```

And repeat

```
until finished
```

End with an example of getting some data out of the system or using it for a little demo

## Running the tests

Explain how to run the automated tests for this system

### Break down into end to end tests

Explain what these tests test and why

```
Give an example
```

### And coding style tests

Explain what these tests test and why

```
Give an example
```

## Deployment

Add additional notes about how to deploy this on a live system

## Built With

* [Dropwizard](http://www.dropwizard.io/1.0.2/docs/) - The web framework used
* [Maven](https://maven.apache.org/) - Dependency Management
* [ROME](https://rometools.github.io/rome/) - Used to generate RSS Feeds

## Contributing

Please read [CONTRIBUTING.md](https://gist.github.com/PurpleBooth/b24679402957c63ec426) for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/your/project/tags). 

## Authors

* **Seyoung Park**    **Hongyu Zhao**

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* Hat tip to anyone who's code was used
* Inspiration
* etc

