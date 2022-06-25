FROM ruby:3.0.0

# for gems packages
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

RUN mkdir /app
WORKDIR /app

ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock

RUN bundle install

ADD . /app


#RUN bundle exec rake db:migrate

#RUN bin/rails db:migrate RAILS_ENV=development