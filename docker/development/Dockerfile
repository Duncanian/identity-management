FROM node:11.12-alpine

LABEL MAINTAINER="Ian Duncan <ianduncan08@gmail.com>"

RUN mkdir /iam

WORKDIR /iam

COPY package.json /iam
COPY yarn.lock /iam

RUN yarn install
