# encoding: utf-8

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "gmuday/version"

Gem::Specification.new do |spec|
    spec.name         = "gmuday"
    spec.version      = GmuDay::VERSION
    spec.summary      = "GmuDay"
    spec.description  = "GMU course helper"
    spec.authors      = ["Sirius2",]
    spec.email        = "xjy37.me@outlook.com"
    spec.require_path = "lib"
    spec.files        = ["lib/gmuday.rb",]
    spec.homepage     = "https://gitee.com/Sirius2/gmuday"
    spec.license      = "GPL-3.0+"

    spec.add_development_dependency "creek","~>5.2.0"
end
