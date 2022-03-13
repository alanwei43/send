##
# Firefox Send - Mozilla
#
# License https://github.com/mozilla/send/blob/master/LICENSE
##


# Build project
FROM node:12
RUN set -x \
    # Add user
    && addgroup --gid 10001 app \
    && adduser --disabled-password \
        --gecos '' \
        --gid 10001 \
        --home /app \
        --uid 10001 \
        app
COPY --chown=app:app . /app
USER app
WORKDIR /app
RUN set -x \
    && PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true npm ci \
    && npm run build

RUN mkdir -p /app/.config/configstore
RUN ln -s dist/version.json version.json

ENV PORT=1443

EXPOSE ${PORT}

CMD ["node", "server/bin/prod.js"]
