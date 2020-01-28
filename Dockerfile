FROM hub.pingcap.net/jenkins/centos7_golang-1.13 AS builder

USER root
WORKDIR /project
COPY go.mod go.sum ./
RUN go mod download
ADD . .
RUN go build -o shell-agent ./


FROM hub.pingcap.net/jenkins/centos7_golang-1.13

USER root
WORKDIR /workspace
COPY --from=builder /project/shell-agent /usr/bin/shell-agent

ENTRYPOINT [ "/usr/bin/shell-agent" ]

# hub.pingcap.net/zyguan/shell-agent
