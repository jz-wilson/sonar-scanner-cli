FROM openjdk:8-alpine

ENV SONAR_SCANNER_VERSION 3.3.0.1492
ENV SONAR_RUNNER_HOME=/sonar-scanner-${SONAR_SCANNER_VERSION}-linux
ENV PATH $PATH:/${SONAR_RUNNER_HOME}/bin

RUN apk update && apk add --no-cache unzip curl git python3 python3-dev nodejs nodejs-npm grep sed bash php7 alpine-sdk && \
    pip3 install --upgrade pip && pip3 install pylint setuptools && \
    curl \
        --insecure \
        -o ./sonarscanner.zip \
        https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${SONAR_SCANNER_VERSION}-linux.zip && \
    unzip sonarscanner.zip && rm sonarscanner.zip && \
    rm ${SONAR_RUNNER_HOME}/jre -rf && \
    sed -i 's/use_embedded_jre=true/use_embedded_jre=false/g' ${SONAR_RUNNER_HOME}/bin/sonar-scanner && \
    mkdir /code

WORKDIR /code

# Install Plugins
RUN npm install eslint-plugin-sonarjs eslint -g
CMD sonar-scanner