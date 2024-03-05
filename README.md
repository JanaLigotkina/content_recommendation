## GEM ContentRecommendation

### About

This is a simple gem that provides a content recommendation system. 
It is based on the content-based recommendation system.
Currently added support for recommendations for movies and books. 
You can get a recommendation by author.

### Installation

Add this line to your application's Gemfile:

```ruby
gem 'content_recommendation'
```

And then execute:
```shell
$ bundle install
```

Or install it yourself as:
```shell
$ gem install content_recommendation
```

### Usage

```ruby
require 'content_recommendation'

RecommendationCLI.start(['recommend', 'movies'])

RecommendationCLI.start(['recommend', 'books'])
```

### Example

```shell
Which creator's work would you like to see today?

0. Stanley Kubrick
1. Martin Scorsese
2. Christopher Nolan
3. Steven Spielberg
4. Quentin Tarantino
5. David Fincher
6. Clint Eastwood
7. Alfred Hitchcock
2

Today, I recommend: `Inception` by Christopher Nolan (2010 year)
```

```shell
Which creator's work would you like to see today?

0. Stephen King
1. Anthony Burgess
2. Gustav Hasford
3. George Orwell
0

Today, I recommend: `The Shining` by Stephen King (1980 year)
```
