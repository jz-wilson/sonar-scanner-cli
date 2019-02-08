FROM java:alpine
ENV SONAR_SCANNER_VERSION 3.3.0.1492

RUN apk add --no-cache wget && \
    wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${SONAR_SCANNER_VERSION}-linux.zip && \
    unzip sonar-scanner-cli-${SONAR_SCANNER_VERSION}-linux.zip && \
    cd /usr/bin && ln -s /sonar-scanner-${SONAR_SCANNER_VERSION}-linux/bin/sonar-scanner sonar-scanner && \
    apk del wget

COPY files/sonar-scanner-run.sh /usr/bin