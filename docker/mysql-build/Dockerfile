FROM mysql:8.0
RUN microdnf install -y java-11-openjdk unzip \
    && microdnf clean all
WORKDIR /maven
ADD https://dlcdn.apache.org/maven/maven-3/3.8.6/binaries/apache-maven-3.8.6-bin.zip maven.zip
RUN unzip maven.zip; \
    cd apache-maven-3.8.6/bin/; \
    ln -s /maven/apache-maven-3.8.6/bin/mvn /usr/sbin/mvn
