FROM ruby:2.7.3-alpine AS builder

ENV LANG C.UTF-8
ENV RAILS_ENV=production 

RUN apk add --update --no-cache \
  build-base \
  postgresql-dev \
  sqlite-dev \
  nodejs \
  yarn

WORKDIR /usr/src/app
COPY ./Gemfile* ./
RUN bundle config set deployment 'true'
RUN bundle install --without development:test
COPY . .
RUN bundle exec rake assets:precompile

FROM ruby:2.7.3-alpine
ENV RAILS_ENV=production
ENV RAILS_LOG_TO_STDOUT=true
ENV RAILS_SERVE_STATIC_FILES=true

RUN apk add --update --no-cache \
  postgresql-dev \
  nodejs

WORKDIR /usr/src/app
COPY . .
COPY --from=builder /usr/local/bundle/config /usr/local/bundle/config
COPY --from=builder /usr/src/app/vendor/bundle/ /usr/src/app/vendor/bundle/
COPY --from=builder /usr/src/app/public/ /usr/src/app/public/
CMD ["bin/rails", "server", "-b", "0.0.0.0"]
