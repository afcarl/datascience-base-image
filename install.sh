#!/bin/bash
locale-gen en_US.UTF-8 && update-locale && apt-get update -y && apt-get install -y bzip2 make build-essential curl

curl https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh >conda_install.sh && chmod +x conda_install.sh && ./conda_install.sh -b -p /home/miniconda3 && rm conda_install.sh

conda install -y jupyter
conda env create --name py3_env python=3 --file conda_py_env.yml

conda env create --name py2_env python=2 --file conda_py_env.yml

conda env create --name r_env --file conda_r_env.yml && source activate r_env
echo 'install.packages("drat", repos="https://cran.rstudio.com"); drat:::addRepo("dmlc"); install.packages("xgboost", repos="http://dmlc.ml/drat/", type = "source")' >xgboost.R && Rscript xgboost.R

rm -rf /tmp/* xgboost.R *.yml *.sh && apt-get clean

chmod -R 0755 /home || true