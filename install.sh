#!/usr/bin/env bash

#  * Licensed under the Apache License, Version 2.0 (the "License").
#  * You may not use this file except in compliance with the License.
#  * You may obtain a copy of the License at
#  *
#  *   http://www.apache.org/licenses/LICENSE-2.0
#  *
#  * Unless required by applicable law or agreed to in writing, software
#  * distributed under the License is distributed on an "AS IS" BASIS,
#  * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  * See the License for the specific language governing permissions and
#  * limitations under the License.



echo "Start Multi-Tenant SaaS Installation"

CURRENT_DIR=$(pwd)

# Check for installer dir
if [ ! -d "${CURRENT_DIR}/installer" ];
then
 echo "Directory ${CURRENT_DIR}/installer not found"
 exit 2
fi

# Check for client/web dir
if [ ! -d "${CURRENT_DIR}/client/web" ];
then
 echo "Directory ${CURRENT_DIR}/client/web not found"
 exit 2
fi

# check for java
if ! command -v java >/dev/null 2>&1;
then
  echo "java version 11 or higher must be installed"
  exit 2
fi

# check for maven
if ! command -v mvn >/dev/null 2>&1;
then
  echo "maven must be installed"
  exit 2
fi

cd ${CURRENT_DIR}/installer
echo "Build installer jar with maven"
if ! mvn > /dev/null 2>&1 ;
then
  echo "Error with build of Java installer for SaaS Boost"
  exit 2
fi

cd ${CURRENT_DIR}/client/web
echo "Download dependencies for React Web App"
yarn
if [ $? -ne 0 ]; then
  echo "Error with yarn build of dependencies for React Web App. Check node version per documentation"
  exit 2
fi

cd ${CURRENT_DIR}
clear
echo "Launch Java Installer for SaaS Boost"


java -Djava.util.logging.config.file=logging.properties -jar ${CURRENT_DIR}/installer/target/SaaSBoostInstall-1.0.0-shaded.jar