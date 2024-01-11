#!/bin/sh

# Create Gemfile
bundle init

# Remove example line from Gemfile
sed '$d' Gemfile > temp; cat temp > Gemfile; rm temp

# I prefer ruby version to be in my Gemfile versus a seperate .ruby-version file.
rbversion=$(ruby --version | cut -d " " -f2)
printf "ruby \"$rbversion\"\n" >> Gemfile

# I like Shopify's style rules for my ruby projects
bundle add rubocop rubocop-shopify --group development
touch .rubocop.yml
cat <<EOF >.rubocop.yml
inherit_gem:
  rubocop-shopify: rubocop.yml

AllCops:
  NewCops: enable
EOF

# Create Gemfile.lock
bundle install

# Lint the generated files
bundle exec rubocop -a

