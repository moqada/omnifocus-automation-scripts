'use strict'
del = require 'del'
path = require 'path'
gulp = require 'gulp'
$ = (require 'gulp-load-plugins')()

paths =
  src: 'src'
  dest: 'build'

gulp.task 'clean', (cb) ->
  del [paths.dest], cb

gulp.task 'build', ['clean'], ->
  options =
    destDir: (src) ->
      dest = src.replace path.resolve(paths.src), path.resolve(paths.dest)
      path.dirname dest
    destFile: (src) ->
      dir = options.destDir src
      path.join dir, "#{path.basename(src, '.js')}.scpt"
  cmd = "mkdir -p <%= options.destDir(file.path) %>"
  cmd += "&& osacompile -l JavaScript -o <%= options.destFile(file.path) %> <%= file.path %>"
  gulp.src "#{paths.src}/**/*.js"
    .pipe $.using()
    .pipe $.exec cmd, options
    .pipe $.exec.reporter()
