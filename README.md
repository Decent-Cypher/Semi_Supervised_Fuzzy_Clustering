# Semi-Supervised Fuzzy Clustering Algorithm Implementation in Octave

This repository contains implementations of some semi-supervised fuzzy clustering algorithms in Octave.
Some helper functions of the FCM algorithm in Octave are reused or modified to help implement those more advanced algorithms.
So far, the algorithms are tested on the well-known Iris Flower UCI dataset. 

## Overview

Semi-supervised fuzzy clustering algorithms aim to partition a dataset into clusters based on similarity while incorporating partial supervision from labeled data. These algorithms are useful in scenarios where only a portion of the data is labeled, and the algorithm must infer the labels for the remaining data points.

## Implemented Algorithms

- **Semi-supervised standard fuzzy clustering method** (Used in the last phase of TS3FCM)
- **Semi-supervised fuzzy clustering**
- **Trusted safe semi-supervised fuzzy clustering method**

## Usage

To run the algorithms on the Iris Flower dataset, follow these steps:

1. Clone the repository:

git clone https://github.com/Decent-Cypher/Semi_Supervised_Fuzzy_Clustering.git


2. Navigate to the source code directory:

cd Semi_Supervised_Fuzzy_Clustering/src


3. Execute the test script:

octave
test


## Dataset

The Iris Flower dataset is a commonly used benchmark dataset in machine learning. It contains measurements of iris flowers from three different species.

## References

1. Huan, P.T., Thong, P.H., Tuan, T.M. et al. TS3FCM: trusted safe semi-supervised fuzzy clustering method for data partition with high confidence. Multimed Tools Appl 81, 12567–12598 (2022).


