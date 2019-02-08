FROM java:8-jre-alpine

ENV SONAR_SCANNER_VERSION 3.3.0.1492
ENV SONAR_RUNNER_HOME=/sonar-scanner-${SONAR_SCANNER_VERSION}-linux
ENV PATH $PATH:/sonar-scanner-${SONAR_SCANNER_VERSION}-linux/bin

RUN apk update && apk add --no-cache -t curl git python3 node && \
    curl --insecure -o ./sonarscanner.zip https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${SONAR_SCANNER_VERSION}-linux.zip && \
    unzip sonarscanner.zip && rm sonarscanner.zip && \
    rm sonar-scanner-${SONAR_SCANNER_VERSION}-linux/jre -rf && \
    sed -i 's/use_embedded_jre=true/use_embedded_jre=false/g' sonar-scanner-${SONAR_SCANNER_VERSION}-linux/bin/sonar-scanner

CMD sonar-scanner