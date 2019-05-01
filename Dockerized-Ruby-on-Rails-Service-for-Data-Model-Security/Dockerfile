FROM ruby:2.5
RUN apt-get update -qq && apt-get install -y mysql-client
RUN mkdir /datamodel
WORKDIR /datamodel

COPY Gemfile /datamodel/Gemfile
COPY Gemfile.lock /datamodel/Gemfile.lock
RUN gem install bundler
RUN bundle install
COPY . /datamodel
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]

