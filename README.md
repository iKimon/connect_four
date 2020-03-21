[travis]: https://travis-ci.org/neopoly/connect_four

# Connect four

[![Travis](https://img.shields.io/travis/neopoly/connect_four.svg?branch=master)][travis]

Console based "Connect four" game.

## Game play

```shell
$ connect_four
```

```shell
player x> 3
 12345678
 ........
 ........
 ........
 ........
 ........
 ........
 ........
 ..x.....
```

```shell
player o> 4
 12345678
 ........
 ........
 ........
 ........
 ........
 ........
 ........
 ..xo....
```

### Many moves later...

```shell
player x> 2

 12345678
 ........
 ........
 ........
 ........
 ........
 ........
 ..xoox..
 .xxoox.x
```

```shell
player o> 4

 12345678
 ........
 ........
 ........
 ........
 ........
 ...o....
 ..xoox..
 .xxoox.x
```

## Setup

Fork from https://github.com/neopoly/connect_four

```shell
git clone git@github.com:YOURNAME/connect_four.git
cd connect_four
gem install bundler
```

Install ruby-2.7.0 and ensure version with:

```shell
ruby -v # => 2.7.0
```

Install dependencies with:

```shell
bundle
```

## Test

```shell
 rake test
```

## Development

A test driven approach is appreciated.

Tests should be written with `minitest/spec` syntax using minitest assertions.
