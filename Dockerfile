FROM alpine as builder

ENV WORKDIR /kiwiirc
WORKDIR ${WORKDIR}

ENV KIWIIRC_VERSION 17.10.06.1
ENV KIWIIRC_ZIP kiwiirc_${KIWIIRC_VERSION}_linux_amd64.zip

RUN apk add --update openssl
RUN wget https://kiwiirc.com/downloads/${KIWIIRC_ZIP}
RUN	unzip ${KIWIIRC_ZIP}
RUN rm ${KIWIIRC_ZIP}
RUN mv kiwiirc_linux_amd64/* .
RUN rmdir kiwiirc_linux_amd64


FROM alpine
ENV WORKDIR /kiwiirc
WORKDIR ${WORKDIR}

COPY --from=builder ${WORKDIR} ${WORKDIR}

EXPOSE 80

VOLUME /kiwiirc-data

COPY docker-entrypoint.sh /kiwiirc/docker-entrypoint.sh

ENTRYPOINT ["/kiwiirc/docker-entrypoint.sh"]
CMD ["/kiwiirc/kiwiirc"]
