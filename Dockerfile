ARG UBUNTU_RELEASE=22.04
FROM ubuntu:${UBUNTU_RELEASE}

WORKDIR /root

RUN apt-get update && \
    env DEBIAN_FRONTEND=noninteractive apt reinstall -y ca-certificates && \
        update-ca-certificates && \
        apt-get install -y --no-install-recommends \
	wget \
	unzip \
	clinfo \
	ocl-icd-opencl-dev \
	ocl-icd-libopencl1 \
	pocl-opencl-icd \
	opencl-headers \
	jq \
	;

ARG GO_SPACEMESH_VER=v1.2.13

RUN wget https://storage.googleapis.com/go-spacemesh-release-builds/${GO_SPACEMESH_VER}/Linux.zip -O go-sm.zip
RUN unzip go-sm.zip && mv Linux/* .
RUN chmod +x go-spacemesh

COPY configs/config.mainnet.json config-mainnet.json
COPY configs/config-disable-remote-grpc.json config-disable-remote-grpc.json
COPY entrypoint.sh .

ENTRYPOINT ["./entrypoint.sh"]

