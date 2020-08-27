########################################################################
#####                   Download dependencies                      #####
#####                                                              #####
########################################################################
FROM maven:3.6.3-jdk-11-slim as dependencies

COPY pom.xml ./
RUN mvn -B -f pom.xml  \
de.qaware.maven:go-offline-maven-plugin:resolve-dependencies


########################################################################
#####                    Build the app with maven                  #####
#####                                                              #####
########################################################################

FROM dependencies as build

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY . .

RUN mvn -B -f pom.xml -Dmaven.test.skip=true clean package


########################################################################
#####                    run the app                               #####
#####                                                              #####
########################################################################

FROM build
RUN mkdir -p /usr/src/server
WORKDIR /usr/src/server

COPY --from=build /usr/src/app/target/*.jar server.jar

ENTRYPOINT ["java"]
CMD ["-jar", "-Dspring.profiles.active=dev", "server.jar"]