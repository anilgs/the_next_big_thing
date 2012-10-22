
#!/bin/sh
echo "*** Running container app specs"
bundle exec rake db:migrate db:test:prepare
bundle exec rspec spec
result=$?


cd engines/teaser
echo "*** Running teaser engine specs"
source "$HOME/.rvm/scripts/rvm"
bundle install
bundle exec rake db:migrate app:db:test:prepare
bundle exec rspec spec/controllers
result+=$?

echo "*** Running teaser engine request specs"
bundle exec rspec spec/requests
result+=$?

echo "*** Running teaser engine javascript specs"
bundle exec rake app:jasmine:ci
result+=$?


cd ../..
cd engines/news_signup
echo "*** Running news_signup engine specs"
source "$HOME/.rvm/scripts/rvm"
bundle install
bundle exec rake db:migrate app:db:test:prepare
rspec spec
result+=$?


cd ../..
cd gems/annoyance
echo "*** Running annoyance gem specs"
bundle install
bundle exec rspec spec
result+=$?


exit $result
