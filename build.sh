#!/bin/sh
echo "*** Running container app specs"
source ~/.rvm/scripts/rvm
bundle check || bundle install > /dev/null
bundle exec rake db:migrate db:test:prepare
rspec spec
result=$?


cd engines/news_signup
echo "*** Running news_signup engine specs"
bundle check || bundle install > /dev/null
bundle exec rake db:migrate app:db:test:prepare
rspec spec
result+=$?


cd ../..
cd engines/teaser
echo "*** Running teaser engine non-request specs"
bundle check || bundle install > /dev/null
bundle exec rake db:migrate app:db:test:prepare
rspec spec/controllers
result+=$?

echo "*** Running teaser engine request specs"
rspec spec/requests
result+=$?

echo "*** Running teaser engine javascript specs"
bundle exec rake app:jasmine:ci
result+=$?


cd ../..
cd gems/annoyance
echo "*** Running annoyance gem specs"
bundle check || bundle install > /dev/null
bundle exec rspec spec
result+=$?


exit $result
