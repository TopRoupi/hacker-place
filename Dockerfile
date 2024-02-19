FROM ruby:3.2.3-alpine3.18

RUN apk add --update build-base bash git bash-completion libffi-dev tzdata postgresql-client postgresql-dev nodejs npm yarn

WORKDIR /app

COPY . .

RUN gem install bundler

RUN bundle install

RUN gem install foreman

RUN yarn install

CMD [ "/bin/bash" ]