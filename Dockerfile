ARG CENTOS_VERSION=centos7.9.2009
FROM centos:${CENTOS_VERSION} AS base

    # Centos79 is no longer supported so using vaulted mirrors
    COPY CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo

    RUN \
        yum -y --enablerepo extras install epel-release && \
        yum update -y && \
        yum clean all && \
        yum -y install cmake3 gcc-c++ make libuuid-devel ninja-build python3 openssl-devel file patchelf python3-devel git
        
    RUN \
        pip3 install requests wheel scikit-build pybind11 dataclasses

    RUN \
        pip3 install cmake

    CMD ["/bin/bash"]

FROM scratch as dev

    # Build a clean image
    COPY --from=base / /

    CMD ["bin/bash"]