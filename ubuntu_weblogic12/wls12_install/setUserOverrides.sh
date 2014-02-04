# PermGen Space needed for RPLAN, and max heap
MEM_ARGS="-XX:MaxPermSize=512M -Xmx1024M"
export MEM_ARGS

#needs to point to the JRE for the weblogic scripts
JAVA_HOME="/usr/lib/jvm/java-6-openjdk-amd64/jre"
export JAVA_HOME
