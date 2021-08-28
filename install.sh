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

# Check for install directory
if [ ! -d "${CURRENT_DIR}/install" ];
then
 echo "Directory ${CURRENT_DIR}/install folder not found"
#  exit 2
fi

# Check for client directory
if [ ! -d "${CURRENT_DIR}/webstarter" ];
then
 echo "Directory ${CURRENT_DIR}/webstarter not found"
#  exit 2
fi

# check for java
if ! command -v java >/dev/null 2>&1;
then
  echo "java version 11 or higher required"
  # exit 2
fi

# check for maven
if ! command -v mvn >/dev/null 2>&1;
then
  echo "maven must be installed first"
  # exit 2
fi

cd ${CURRENT_DIR}/install
echo "Build install jar with maven"
if ! mvn > /dev/null 2>&1 ;
then
  echo "Error when building Java installation"
  # exit 2
fi

cd ${CURRENT_DIR}
clear
echo "Launch for Multi-Tenant SaaS"


java -Djava.util.logging.config.file=logging.properties -jar ${CURRENT_DIR}/install/target/MultiTenantSaaSInstall-1.0.0-shaded.jar
