FROM ruby:2.3.0
RUN apt-get update -qq && apt-get install -y build-essential libxml2 libxml2-dev libxslt1.1 libxslt1-dev libpq-dev postgresql-client

RUN mkdir /logistic_service
WORKDIR /logistic_service

ADD Gemfile /logistic_service/Gemfile
ADD Gemfile.lock /logistic_service/Gemfile.lock
# RUN bundle install --deployment --without development test
RUN bundle install

ADD . /logistic_service

CMD bundle exec rails server --port 3001 --binding 0.0.0.0