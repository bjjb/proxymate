FROM node:alpine
WORKDIR /app
ADD ./ ./
RUN npm install
CMD ./bin/proxymate server
