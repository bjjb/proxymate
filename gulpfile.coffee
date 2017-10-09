gulp = require 'gulp'
pug = require 'gulp-pug'
stylus = require 'gulp-stylus'
coffee = require 'gulp-coffee'

task = (f, src, dest) -> -> gulp.src(src).pipe(f()).pipe(gulp.dest(dest))

gulp.task 'proxymate.js', task(coffee, 'proxymate.coffee', './')
gulp.task 'server.js', task(coffee, 'server.coffee', './')
gulp.task 'index.js', task(coffee, 'index.coffee', './')
gulp.task 'module', ['proxymate.js', 'server.js', 'index.js']

gulp.task 'app/html', task(pug, 'app/*.pug', 'app/')
gulp.task 'app/css', task(stylus, 'app/*.styl', 'app/')
gulp.task 'app/js', task(coffee, 'app/*.coffee', 'app/')
gulp.task 'app', ['app/html', 'app/css', 'app/js']

gulp.task 'docs/html', task(pug, 'docs/*.pug', 'docs/')
gulp.task 'docs/css', task(stylus, 'docs/*.styl', 'docs/')
gulp.task 'docs/js', task(coffee, 'docs/*.coffee', 'docs/')
gulp.task 'docs', ['docs/html', 'docs/css', 'docs/js']

gulp.task 'default', ['module', 'app', 'docs']
