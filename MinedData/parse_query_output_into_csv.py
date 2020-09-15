import sys
import pandas as pd 
import json
import numpy as np

# print dataframe df to file specified
def printDFToFile( df, filename):
	f = open(filename, 'w');
	f.write(df.to_csv(index = False, header=None))
	f.close()

def getPortalRoot( portal):
	return portal[ portal.index('root') + len('root https://www.npmjs.com/package/') : portal.index(')')]

# function to load in a single file
# return a dataframe of the portal, eventname, and project
def get_info_from_file( filename):
	f = open(filename, "r")
	data = json.loads( f.read())
	f.close()
	# now, read in the relevant info from the json object
	portals = [k[0].get("value") for k in data.get("data")]
	eventnames = [k[1].get("value") for k in data.get("data")]
	proj_names = [data.get("project").get("name")] * len(portals)
	proj_count = [1] * len(portals) # we don't remove duplicates yet
	ret_val = pd.DataFrame(np.column_stack([portals, eventnames, proj_count, proj_names]), columns = ["portal", "eventname", "projcount", "path"])
	ret_val.insert(loc=0, column="proot", value=ret_val.portal.apply(getPortalRoot))
	return( ret_val)

def merge_info_from_files( specfile):
	f = open( specfile, "r")
	all_files = f.read().splitlines()
	f.close()
	return( pd.concat([get_info_from_file(fname) for fname in all_files], ignore_index=True))

# read in a file that has a list of all json files to use 
# specify this file as a command line arg

if( len( sys.argv) != 3):
	print("Usage: python parse_query_output_into_csv.py file_spec_list_of_query_output_files output_filename")
else:
	df = merge_info_from_files( sys.argv[1])
	printDFToFile( df, sys.argv[2])
	print("Done processing")
