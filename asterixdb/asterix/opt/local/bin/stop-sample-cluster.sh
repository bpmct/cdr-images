#!/bin/bash
# ------------------------------------------------------------
# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.
# ------------------------------------------------------------

function usage() {
  echo
  echo Usage: $(basename $0) [-f[orce]]
  echo
  echo "  -f[orce]  : Forcibly terminates any running AsterixDB processes (after shutting down cluster, if running)"
}

while [ -n "$1" ]; do
  case $1 in
    -f|-force) force=1;;
    -help|--help|-usage|--usage) usage; exit 0;;
    *) echo "ERROR: unknown argument '$1'"; usage; exit 1;;
    esac
  shift
done

if [ -z "$JAVA_HOME" -a -x /usr/libexec/java_home ]; then
  JAVA_HOME=$(/usr/libexec/java_home)
  export JAVA_HOME
fi

while [ -n "$1" ]; do
  case $1 in
    -f|-force) force=1;;
    -help|--help|-usage|--usage) usage; exit 0;;
    *) echo "ERROR: unknown argument '$1'"; usage; exit 1;;
  esac
  shift
done

if [ -z "$JAVA_HOME" -a -x /usr/libexec/java_home ]; then
  JAVA_HOME=$(/usr/libexec/java_home)
  export JAVA_HOME
fi

# OS specific support.  $var _must_ be set to either true or false.
cygwin=false;
darwin=false;
case "`uname`" in
  CYGWIN*) cygwin=true ;;
  Darwin*) darwin=true
           if [ -z "$JAVA_VERSION" ] ; then
             JAVA_VERSION="CurrentJDK"
           else
             echo "Using Java version: $JAVA_VERSION"
           fi
           if [ -z "$JAVA_HOME" ]; then
              if [ -x "/usr/libexec/java_home" ]; then
                  JAVA_HOME=`/usr/libexec/java_home`
              else
                  JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Versions/${JAVA_VERSION}/Home
              fi
           fi
           ;;
esac

if [ -z "$JAVA_HOME" ] ; then
  if [ -r /etc/gentoo-release ] ; then
    JAVA_HOME=`java-config --jre-home`
  fi
fi

# For Cygwin, ensure paths are in UNIX format before anything is touched
if $cygwin ; then
  [ -n "$JAVA_HOME" ] && JAVA_HOME=`cygpath --unix "$JAVA_HOME"`
  [ -n "$CLASSPATH" ] && CLASSPATH=`cygpath --path --unix "$CLASSPATH"`
fi

# If a specific java binary isn't specified search for the standard 'java' binary
if [ -z "$JAVACMD" ] ; then
  if [ -n "$JAVA_HOME"  ] ; then
    if [ -x "$JAVA_HOME/jre/sh/java" ] ; then
      # IBM's JDK on AIX uses strange locations for the executables
      JAVACMD="$JAVA_HOME/jre/sh/java"
    else
      JAVACMD="$JAVA_HOME/bin/java"
    fi
  else
    JAVACMD=`which java`
  fi
fi
"$JAVACMD" -version 2>&1 | grep -q '1\.[89]' || {
  echo "JAVA_HOME must be at version 1.8 or later:"
  "$JAVACMD" -version
  exit 2
}
DIRNAME=$(dirname "$0")
[ $(echo $DIRNAME | wc -l) -ne 1 ] && {
  echo "Paths with spaces are not supported"
  exit 3
}

CLUSTERDIR=$(cd "$DIRNAME/.."; echo $PWD)
INSTALLDIR=$(cd "$CLUSTERDIR/../.."; echo $PWD)
"$INSTALLDIR/bin/asterixhelper" get_cluster_state -quiet
if [ $? -ne 1 ]; then
  "$INSTALLDIR/bin/asterixhelper" shutdown_cluster_all
  first=1
  tries=0
  echo -n "INFO: Waiting up to 60s for cluster to shutdown"
  while [ -n "$(ps -ef | grep 'java.*org\.apache\.hyracks\.control\.[cn]c\.\([CN]CDriver\|service\.NCService\)')" ]; do
    if [ $tries -ge 60 ]; then
      echo "...timed out!"
      break
    fi
    sleep 1s
    echo -n .
    tries=$(expr $tries + 1)
  done
  echo ".done." || true
else
  echo "WARNING: sample cluster does not appear to be running"
fi

if ps -ef | grep 'java.*org\.apache\.hyracks\.control\.[cn]c\.\([CN]CDriver\|service\.NCService\)' > /tmp/$$_pids; then
  echo -n "WARNING: AsterixDB processes remain after cluster shutdown; "
  if [ $force ]; then
    echo "-f[orce] specified, forcibly terminating AsterixDB processes:"
    cat /tmp/$$_pids | while read line; do
      echo -n "   - $line..."
      echo $line | awk '{ print $2 }' | xargs -n1 kill -9
      echo "killed"
    done
  else
    echo "re-run with -f|-force to forcibly terminate all AsterixDB processes:"
    cat /tmp/pids |  sed 's/^ *[0-9]* \([0-9]*\).*org\.apache\.hyracks\.control\.[cn]c[^ ]*\.\([^ ]*\) .*/\1 - \2/'
  fi
fi
rm /tmp/$$_pids

