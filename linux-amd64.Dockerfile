FROM hotio/base@sha256:8b88c1eca2ef3df526f109a37bea2e6148e45e4b7cd7517be1cb8dde8a1e4594

EXPOSE 6789

RUN apk add --no-cache python3 py3-lxml

# install app
ARG VERSION
ARG VERSION_SHORT
RUN runfile="/tmp/app.run" && curl -fsSL -o "${runfile}" "https://github.com/nzbget/nzbget/releases/download/v${VERSION_SHORT}/nzbget-${VERSION}-bin-linux.run" && sh "${runfile}" --destdir "${APP_DIR}" && rm "${runfile}" && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /
RUN chmod 755 "${APP_DIR}/scripts/"*
