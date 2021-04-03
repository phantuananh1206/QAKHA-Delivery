FROM ruby:2.7.2

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

RUN mkdir /qakha-delivery

WORKDIR /qakha-delivery

ADD Gemfile /qakha-delivery/Gemfile
RUN bundle install
ADD . /qakha-delivery

EXPOSE 3000

CMD rails db:migrate && bundle exec rails s -b 0.0.0.0