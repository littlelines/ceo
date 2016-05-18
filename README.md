CEO
---

> Your app's chief executive.

[![Dependency Status](http://img.shields.io/gemnasium/littlelines/ceo.svg)](https://gemnasium.com/littlelines/ceo)
[![Gem Version](http://img.shields.io/gem/v/ceo.svg)](https://rubygems.org/gems/ceo)
[![License](http://img.shields.io/:license-mit-blue.svg)](http://littlelines.mit-license.org)
[![Build Status](https://travis-ci.org/littlelines/ceo.svg?branch=master)](https://travis-ci.org/littlelines/ceo)
[![Code Climate](https://codeclimate.com/github/littlelines/ceo/badges/gpa.svg)](https://codeclimate.com/github/littlelines/ceo)
[![Inline docs](http://inch-ci.org/github/littlelines/ceo.svg?branch=master)](http://inch-ci.org/github/littlelines/ceo)

## Foreword

CEO was created out of frustration with
[ActiveAdmin](http://activeadmin.info/). At Littlelines, we wanted an
admin framework that is simple and flexible, but gets out of your way
when you need it to. CEO's job is to give you the ability to quickly
build customizable admin pages that you don't have to keep looking up
the documentation for.

## Getting Started

Everything in your Rails application with a model can become the base
of an admin page. Let's use `Users` as an example.

```
$ rails new my_app
$ rails g model User first_name:string last_name:string email:string
```

The easiest way to generate an admin page is to use the generator.
