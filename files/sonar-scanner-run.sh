#!/bin/sh

if [[ -z "$SONAR_PROJECT_KEY" ]]; then
  echo "Undefined \"projectKey\"" && exit 1
else
  COMMAND="sonar-scanner -Dsonar.login=\"$SONAR_LOGIN_KEY\" -Dsonar.projectKey=\"$SONAR_PROJECT_KEY\""

  if [[ ! -z "$SONAR_PROJECT_VERSION" ]]; then
    COMMAND="$COMMAND -Dsonar.projectVersion=\"$SONAR_PROJECT_VERSION\""
  fi

  if [[ ! -z "$SONAR_PROJECT_NAME" ]]; then
    COMMAND="$COMMAND -Dsonar.projectName=\"$SONAR_PROJECT_NAME\""
  fi
  if [[ ! -z $CI_BUILD_REF ]]; then
    COMMAND="$COMMAND -Dsonar.gitlab.commit_sha=\"$CI_BUILD_REF\""
  fi
  if [[ ! -z $CI_BUILD_REF_NAME ]]; then
    COMMAND="$COMMAND -Dsonar.gitlab.ref_name=\"$CI_BUILD_REF_NAME\""
  fi
  if [[ ! -z $SONAR_BRANCH ]]; then
    COMMAND="$COMMAND -Dsonar.branch=\"$SONAR_BRANCH\""
  fi
  if [[ ! -z $SONAR_ANALYSIS_MODE ]]; then
    COMMAND="$COMMAND -Dsonar.analysis.mode=\"$SONAR_ANALYSIS_MODE\""
    if [[ $SONAR_ANALYSIS_MODE="preview" ]]; then
      COMMAND="$COMMAND -Dsonar.issuesReport.console.enable=true"
    fi
  fi

  eval $COMMAND
fi