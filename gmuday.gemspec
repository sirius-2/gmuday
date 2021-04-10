# encoding: utf-8

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "gmuday/version"

Gem::Specification.new do |spec|
    spec.name         = "gmuday"
    spec.version      = GmuDay::VERSION
    spec.summary      = "GmuDay"
    spec.description  = "Show GMU courses of someday or someweek"
    spec.authors      = ["Sirius2",]
    spec.email        = "xjy37.me@outlook.com"
    spec.require_path = "lib"
    spec.files        = ["lib/gmuday.rb", 'ext/test.xlsx']
    spec.homepage     = "https://gitee.com/Sirius2/gmuday"
    spec.license      = "GPL-3.0+"

    spec.add_development_dependency "creek","~>5.2.0"
    spec.add_development_dependency "ruby2d","~>0.9.5"
    spec.add_development_dependency "os","~>1.1.1"
end