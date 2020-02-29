FROM alpine as buildstage

ENV BUMP 20.03.01.1

ENV WORKDIR /kiwiirc
WORKDIR ${WORKDIR}

ENV KIWIIRC_VERSION 18.01.06.1
ENV KIWIIRC_ZIP kiwiirc_${KIWIIRC_VERSION}_linux_amd64.zip

RUN apk add --update openssl
RUN wget https://kiwiirc.com/downloads/${KIWIIRC_ZIP}
RUN	unzip ${KIWIIRC_ZIP}
RUN rm ${KIWIIRC_ZIP}
RUN mv kiwiirc_linux_amd64/* .
RUN rmdir kiwiirc_linux_amd64



FROM alpine as runstage

RUN apk add --no-cache su-exec

ENV WORKDIR /kiwiirc
WORKDIR ${WORKDIR}

COPY --from=buildstage ${WORKDIR} ${WORKDIR}

RUN sed -i 's/^port = 80\b/port = 8080/' ${WORKDIR}/config.conf.example

EXPOSE 8080

VOLUME /kiwiirc-data

COPY docker-entrypoint.sh ${WORKDIR}/docker-entrypoint.sh

ENTRYPOINT ["/kiwiirc/docker-entrypoint.sh"]
CMD ["su-exec", "guest", "/kiwiirc/kiwiirc"]
