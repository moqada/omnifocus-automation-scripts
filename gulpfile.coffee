'use strict'
gulp = require 'gulp'
$ = (require 'gulp-load-plugins')()

paths =
  src: 'src'
  dist: 'build'

gulp.task 'build', ->
  options =
    getScpt: (path) ->
      path.split('/').slice(-1)[0].split('.')[0] + '.scpt'
  cmd = "osacompile -l JavaScript -o #{paths.dist}/<%= options.getScpt(file.path) %> <%= file.path %>"
  gulp.src "#{paths.src}/**/*.js"
    .pipe $.using()
    .pipe $.exec cmd, options
    .pipe $.exec.reporter()
