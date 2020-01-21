FROM registry.access.redhat.com/ubi8/nodejs-10:1 AS builder

WORKDIR /opt/app-root

COPY --chown=default:root . .

RUN npm install
RUN npm run build --if-present

FROM registry.access.redhat.com/ubi8/nodejs-10:1

COPY --chown=default:root . .
COPY --from=builder /opt/app-root/dist dist
RUN npm install --production

ENV HOST=0.0.0.0 PORT=3000

EXPOSE 3000/tcp

CMD npm run serve