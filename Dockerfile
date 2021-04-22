FROM ruby:2.7.2

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

RUN mkdir /qakha-delivery

WORKDIR /qakha-delivery

ADD Gemfile /qakha-delivery/Gemfile
RUN bundle install
ADD . /qakha-delivery
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq && apt-get install -y yarn
RUN yarn install
RUN bundle exec rails webpacker:install
RUN npm install
EXPOSE 3000

CMD rails db:migrate && bundle exec rails s -b 0.0.0.0
