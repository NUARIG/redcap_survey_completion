#!/usr/bin/env bash

# Example script that I run as a cronjob
# Add and uncomment the following line in your crontab -e
#* * * * * /Path/to/this/script/examplescript.sh > /dev/null 2>&1 

# Dies if any of the processes dies
set -e

# No need, I'm lazy, main purpose is to add anaconda3 and Rscript to your path
source ~/.bash_profile

# See config/rc_srvy_cmpltn.txt for definitions of anaconda3 environment
# You create the environment once using `conda create -n rc_srvy_cmpltn --file config/rc_srvy_cmpltn.txt`
source activate rc_srvy_cmpltn

# Make sure this script is in your root directory of the git repo so it can find 'input/'
# Navigate to this script location
cd /Path/to/this/script/

# Here we go. If python fails it doesn't run Rscript. `say` is for Mac OS X
python fetchsurveydata.py || (say "could not get survey data" ; exit 1 )
Rscript surveyAnalysis.R > /dev/null 2>&1
say "updated survey graph"
