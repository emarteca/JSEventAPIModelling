## Setup and Running

First clone this repo.
Make sure you have docker installed.

Then, you'll need to download `codeql-linux64.zip` from the [latest codeql CLI releases](https://github.com/github/codeql-cli-binaries/releases).
Place this in the root directory of this repo.

Then, from the root of the repo, you can build and run the docker image.

To build the docker image: `docker build -t api-modelling . `
To run it: `./runDocker.sh`

Now, you'll be in the `/home/playground` directory of the docker image.
Instructions on how to interact with our data and reproduce our experiments are included below, in the description of the repo contents.


## Repo Contents

Now we describe the contents of this repo, with some brief explanations for each component.
We've divided the contents into Data and Code.

Note: this all assumes you're working inside the docker container.
The docker build unzips some of our large data -- if you want to run this locally, look at the contents of `build.sh` to see what needs to be unzipped.

---

### Data


#### Semi-automatically generated ground truth used for our experiments 
This data is included in the `GroundTruthGeneration` directory.

* `broken.csv`: Our list of ground truth incorrect pairs, for all modelled APIs.  
* `correct.csv`: Our list of ground truth correct pairs, for all modelled APIs.
* `knownUnknowns.csv`: Our list of imprecise pairs (i.e. pairs with an overapproximate access paths).
These files are all 2-column csvs, where the first column is the access path and the second column is the event name.

#### Experimental data

* `list_results`: The results of running the classification for each of the 4096 parameter configurations we tested with.
This is a directory containing all the output files for each configuration.
For each configuration, there is a generated "correct" file, with the list of labelled correct listener registrations, and a generated "broken" file, with the list of labelled incorrect listener registrations.
For configuration `[pe, pa, pce, pca]` the files have the name: `broken_pe<pe value>_pp<pa value>_pce<pce value>_pcp<pca value>_.csv` (and similarly for "correct")

These files could be generated by running all the experiments again (explained briefly in the Code section below), but since this takes about 10 hours (on a ThinkPad P43s with 32GB RAM) we've also included these outputs here.
These files are inputs in some of the data analysis code.
These are all 3-column csvs, where the first column is the frequency of the pair, the second is the access path and the third is the event name.


#### Mined data:

This is in the `MinedData` directory.

* `listeners-and-emitters.zip`: The results of the initial data mining.
This is a zipped directory of JSON files, each is the result of running our initial static analysis on a github repo (i.e., there is a JSON file for each of the repos we mined). This includes data mined on both listeners registered (on which all of our primary experiments are conducted), and the dual information about events emitted (about which we have one experiment in the paper).
* `listen_merged_data.out`: This is a 4 column CSV file, and results from processing the mined data on listener registrations. The first column is the package, then the access path, then the event name, and finally the occurrence frequency. This data file is used by our data processing script.
* `listen_merged_data_withFile.out`: This is the same information, but _includes_ information on the repository that the access path, event name pairs originated from in the mined data.

We have also included a script, getMergedFiles.sh, to generate these `listen_merged_data` files from the mined data.
Simply run `./getMergedFiles.sh` from inside `MinedData` to regenerate these files.


---

### Code


#### Data Processing

* `dataProcessing.py`: Python script containing all our data processing code
This code is fully commented. 
There is a commented sample of functions to run in the main method.
Note: it's not meant to just run the script directly. 
Doing this would run the classification for all configurations, generating the files included in `list_results` (the call to `runTests`).
Line 335 until `main` are the functions which run the various experiments.

The `main` function includes commented examples of the code for running the main experiments.

Recommendation:
`ipython3 -i dataProcessing.py`
Then, you can interact with the data processing code and run whatever you'd like from the suite.

Note: running any of the analysis code without rerunning the experiments will use our initial experiment data, in `list_results` and the results of our mined data in `MinedData`.


#### Model Generation
This code is in `GroundTruthGeneration` directory.

* `getGroundTruth.sh`: Our ground truth generating script (runs the QL analysis for each of the correct, knownUnknown, and incorrect sets)
This is the script which generates our ground truth models -- we've included the output files (`broken.csv`, `correct.csv`, and `knownUnknown.csv` as explained above).
The code is basically a mapping of API types to their associated events (which we created by manually reading the API documentations), and mappings of these types to access path representations of objects with these types.
Then the script generates the lists of access path, event name pairs which exist in the mined data and which correspond to correct and incorrect pairings of types and events.


#### Static Analysis

* `MinedData/findListenersAndEmitters.ql`: Our data mining script
This is another QL script, which does the data mining for the list of all listener registrations in a project.

A note on usage: this script can be test-run on a project (we would recommend trying the browser tool for QL, the query console on [LGTM.com](lgtm.com) with an open source JavaScript project of your choosing).
However, we cannot provide access to the entire dataset since this is all projects available on [LGTM.com](lgtm.com), which you need to request access to query.


Thanks for your time!
