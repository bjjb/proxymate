gulp = require 'gulp'
pug = require 'gulp-pug'
stylus = require 'gulp-stylus'
coffee = require 'gulp-coffee'

task = (f, src, dest) -> -> gulp.src(src).pipe(f()).pipe(gulp.dest(dest))

proxymate = task coffee, 'proxymate.coffee',  './'
server    = task coffee, 'server.coffee',     './'
index     = task coffee, 'index.coffee',      './'
html      = task pug,    'app/*.pug',         'app/'
css       = task stylus, 'app/*.styl',        'app/'
js        = task coffee, 'app/*.coffee',      'app/'

gulp.task 'proxymate', proxymate
gulp.task 'server', server
gulp.task 'index', index
gulp.task 'html', html
gulp.task 'css', css
gulp.task 'js', js

gulp.task 'module', ['server', 'proxymate', 'index']
gulp.task 'app', ['html', 'css', 'js']

gulp.task 'default', ['module', 'app']
