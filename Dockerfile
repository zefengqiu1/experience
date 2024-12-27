# make sure jdk can be found from docker hub
FROM openjdk:17-jdk-slim
WORKDIR /app
#s make sure have /app backslash at front, otherwise copy can fail
COPY target/ExpManagement-0.0.1-SNAPSHOT.jar /app/ExpManagement-0.0.1-SNAPSHOT.jar

# 设置环境变量 JAVA_OPTS，用来传递 JVM 启动参数
ENV JAVA_OPTS="-Dcom.sun.management.jmxremote \
               -Dcom.sun.management.jmxremote.port=1099 \
               -Dcom.sun.management.jmxremote.ssl=false \
               -Dcom.sun.management.jmxremote.authenticate=false \
               -Djava.rmi.server.hostname=0.0.0.0 \
               -Djava.rmi.server.useLocalHostname=true \
               -Dsun.rmi.registry.registryFilter=0.0.0.0 \
               -Dsun.rmi.transport.tcp.handshakeTimeout=20000 \
               -Djava.net.preferIPv4Stack=true"

EXPOSE 8080
# 启动 Spring Boot 应用（使用 JSON 数组格式）
CMD ["sh", "-c", "java $JAVA_OPTS -jar /app/ExpManagement-0.0.1-SNAPSHOT.jar"]
