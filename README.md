hdp-sandbox-storm
=================

Hortonworks Blog Post - http://hortonworks.com/blog/storm-technical-preview-available-now/

Storm Technical Preview PDF - http://public-repo-1.hortonworks.com/HDP-LABS/Projects/Storm/0.9.0.1/StormTechnicalPreview.pdf

Getting Started
---------------
### Clone the Repo
1. `git clone https://github.com/risdenk/hdp-sandbox-storm.git`
2. `cd hdp-sandbox-storm`

### Run the install
1. `sudo ./install.sh`

### Run the WordCount Topology
1. `wget http://public-repo-1.hortonworks.com/HDP-LABS/Projects/Storm/0.9.0.1/storm-starter-0.0.1-storm-0.9.0.1.jar`
2. `storm jar storm-starter-0.0.1-storm-0.9.0.1.jar storm.starter.WordCountTopology WordCount -c nimbus.host=sandbox.hortonworks.com`
