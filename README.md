<a href="https://www.cortex-ia.com/" target="_blank"><img src="https://github.com/CortexIATest/CTXImages/blob/master/Cortex-350-120.png" alt="Welcome to Cortex!" width="350" height="120" border="0"></a>

# CTX-Configuration-Store
Cortex flows and subtasks to interact and manage the Cortex-ConfigStore database.

The module allows users to:
* Add, modify and delete:
  * Customers
  * Areas
  * Envrionments
  * Parameter Names
  * Parameter Values

* Retrieve config parameters assigned to the Area, Customer and/or Environment specified

* Implement Replicated Databases between 2 SQL Servers


## Table of Contents
1) [Dependencies](#dependencies)
    * [Cortex Version](#cortex-version)
    * [OCIs](#ocis)
    * [Files](#files)
    * [Other](#other)
1) [Installation](#installation)
1) [How to use](#how-to-use)
1) [How you can contribute](#how-you-can-contribute)
1) [Versioning](#versioning)
1) [Licensing](#licensing)

## Dependencies
### Cortex Version
This version of the CTX-Configuration-Store module was developed in Cortex v6.4.0. Some functionality may not be available in earlier verions of Cortex.

### OCIs
The CTX-Configuration-Store module requires the following Cortex OCIs:
* Database

### Files
The CTX-Configuration-Store module requires the following files:
* [CTX-Configuration-Store Studio Package](https://github.com/CortexIntelligentAutomation/CTX-Configuration-Store/releases/download/untagged-65b7745783574262f475/CTX-Configuration-Store.studiopkg)
* [Cortex-ConfigStore Database Install Script](https://github.com/CortexIntelligentAutomation/CTX-Configuration-Store/releases/download/untagged-65b7745783574262f475/CTX-Configuration-Deployment-Script.sql)
* [CTX-Configuration-Store v0.1 to v1 Migration Script](https://github.com/CortexIntelligentAutomation/CTX-Configuration-Store/releases/download/untagged-65b7745783574262f475/Configuration_v01-to-v1_Migration.sql)


## Installation
Details of how the module should be imported into Cortex can be found in the [Deployment Plan](https://github.com/CortexIntelligentAutomation/CTX-Configuration-Store/blob/master/CTX-Configuration-Store%20-%20Deployment%20Plan.pdf).

*If you have a previous Cortex Configuration Store (beta version released before the GitHub release) please contact Cortex to obtain the migration document and scripts. These will allow you to migrate existing configuration data into this Configuration Store version and continue using it as before.*

## How to use
A detailed User Guide has been provided with instructions on how to use the module, available [here](https://github.com/CortexIntelligentAutomation/CTX-Configuration-Store/blob/master/CTX-Configuration-Store%20-%20User%20Guide.pdf). Configuration of each flow/subtask's inputs and outputs are detailed in notes on the flow/subtask workspace.

## How you can contribute
Unfortunately, we cannot offer pull requests at this time or accept any improvements.

## Versioning
The CTX-Configuration-Store module has the following versions, starting with the most recent:

Version | Release | Functionality | Notes
------------ | ------------- | ----------- | -----------
v1.0 | 28/05/2019 | Config-CGD-Get-DB-Server | Created
v1.0 | 28/05/2019 | Config-CQD-Query-DB | Created
v1.0 | 28/05/2019 | Config-CGP-Get-Parameters | Created
v1.0 | 28/05/2019 | Config-CEV-Encrypt-Value | Created
v1.0 | 28/05/2019 | Config-GCPQ-Generate-Config-Params-Queries | Created
v1.0 | 28/05/2019 | Config-GPVDQ-Generate-Parameter-Value-Delete-Query | Created
v1.0 | 28/05/2019 | Cortex-ConfigStore-Management-UI | Created
v1.1 | 3/10/2019  | Replication and Migration Scripts | Created

## Licensing
All functionality within this module is licensed under the [Apache 2.0 License](https://www.apache.org/licenses/LICENSE-2.0).

Copyright 2018 Cortex Limited

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
