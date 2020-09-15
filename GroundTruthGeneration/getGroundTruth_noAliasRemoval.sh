#!/bin/bash

codeql query run --database=placeholderdb --output=temp.bqrs knownUnknown_groundTruthNoAliasRemoval.ql
codeql bqrs decode --format=csv temp.bqrs | tail -n+2 > old_knownUnknown.csv
rm temp.bqrs

codeql query run --database=placeholderdb --output=temp.bqrs broken_groundTruthNoAliasRemoval.ql
codeql bqrs decode --format=csv temp.bqrs | tail -n+2 > old_broken.csv
rm temp.bqrs

codeql query run --database=placeholderdb --output=temp.bqrs correct_groundTruthNoAliasRemoval.ql
codeql bqrs decode --format=csv temp.bqrs | tail -n+2 > old_correct.csv
rm temp.bqrs


