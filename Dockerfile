FROM frolvlad/alpine-glibc

MAINTAINER Viktor Farcic <viktor@farcic.com>

LABEL org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/vfarcic/openshift-client" \
      org.label-schema.docker.dockerfile="/Dockerfile"

ENV OC_VERSION v3.9.0
ENV OC_HASH 191fece

RUN apk add --update ca-certificates && \
    apk add --update -t deps curl && \
    curl -L https://github.com/openshift/origin/releases/download/${OC_VERSION}/openshift-origin-client-tools-${OC_VERSION}-${OC_HASH}-linux-64bit.tar.gz -o /tmp/oc.tar.gz && \
    tar --strip-components=1 -xzvf  /tmp/oc.tar.gz -C /tmp/ && \
    mv /tmp/oc /usr/local/bin/oc && \
    chmod +x /usr/local/bin/oc && \
    apk del --purge deps && \
    rm /var/cache/apk/* && \
    rm -rf /tmp/*

CMD ["oc", "version"]