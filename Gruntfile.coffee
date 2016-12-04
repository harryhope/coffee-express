module.exports = (grunt) ->

  # Files to monitor.
  styleFiles = [
    'public/**/*.sass'
  ]
  clientScripts = [
    'public/**/*.coffee'
  ]
  serverScripts = [
    'server.coffee'
    'Gruntfile.coffee'
    'app/**/*.coffee'
    'config/**/*.coffee'
    'test/**/*.coffee'
  ]
  scriptFiles = serverScripts.concat clientScripts

  # Grunt Config
  grunt.initConfig
    watch:
      server:
        files: serverScripts,
        tasks: ['express:dev']
        options:
          spawn: false
      client:
        files: clientScripts
        tasks: ['build-fe-js-dev']
        options:
          livereload: 35629
      styles:
        files: styleFiles
        tasks: ['sass']
        options:
          livereload: 35629

    express:
      options:
        script: 'index.js'
      dev:
        options:
          node_env: 'development'
      test:
        options:
          node_env: 'development'

    mochaTest:
      all:
        options:
          reporter: 'spec'
          require: 'coffee-script/register'
        src: ['test/**/*.coffee']

    sass:
      options:
        sourceMap: true
        style: 'compressed'
      dist:
        files:
          './public/css/style.css': './public/sass/main.sass'

    browserify:
      dist:
        files:
          './public/js/main.js': ['./public/coffee/**/*.coffee']
        options:
          transform: ['coffeeify']
          browserifyOptions:
            debug: yes

    extract_sourcemap:
      dist:
        files:
          './public/js': ['./public/js/main.js']

    uglify:
      options:
        sourceMap: yes
        sourceMapIn: './public/js/main.js.map'
      dist:
        files:
          './public/js/main.js': ['./public/js/main.js']

    coffeelint:
      all: scriptFiles
      options:
        arrow_spacing: {level: 'error'}
        ensure_comprehensions: {level: 'error'}
        no_unnecessary_double_quotes: {level: 'error'}
        no_trailing_whitespace: {level: 'error'}
        no_empty_param_list: {level: 'error'}
        spacing_after_comma: {level: 'error'}
        no_stand_alone_at: {level: 'error'}
        space_operators: {level: 'error'}
        indentation:
          value: 2
          level: 'error'
        cyclomatic_complexity:
          value: 8
          level: 'error'
        max_line_length:
          value: 120,
          level: 'error'
          limitComments: yes

  # Npm Tasks
  grunt.loadNpmTasks 'grunt-extract-sourcemap'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-express-server'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-mocha-test'
  grunt.loadNpmTasks 'grunt-browserify'
  grunt.loadNpmTasks 'grunt-coffeelint'
  grunt.loadNpmTasks 'grunt-sass'

  # Tasks
  grunt.registerTask('dev', ['sass', 'build-fe-js-dev', 'express:dev', 'watch'])
  grunt.registerTask('test', ['coffeelint', 'mochaTest'])

  # Helper Tasks
  grunt.registerTask('build-fe-prod', ['sass', 'browserify', 'extract_sourcemap', 'uglify'])
  grunt.registerTask('build-fe-js-dev', ['coffeelint', 'browserify', 'extract_sourcemap'])
