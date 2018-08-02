FROM ruby:2.5.1

ENV LANG C.UTF-8

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash
RUN apt-get update && apt-get install nodejs

WORKDIR /usr/src/app
COPY Gemfile* ./
RUN bundle install
COPY . .

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]