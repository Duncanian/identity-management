FROM node:11.11

LABEL MAINTAINER="Ian Duncan <ianduncan08@gmail.com>"

RUN mkdir /app

WORKDIR /app

COPY . /app

COPY yarn.lock /app

RUN yarn install
