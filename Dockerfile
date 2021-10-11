FROM ruby:2.5

RUN apt-get update && \
    apt-get install -y postgresql-client nodejs vim --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /myproject

ADD Gemfile /myproject/Gemfile
ADD Gemfile.lock /myproject/Gemfile.lock

RUN gem install bundler
RUN bundle install

ADD . /myproject