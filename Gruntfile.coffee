module.exports = (grunt) ->

  # Files to monitor.
  appFiles = [
    'server.coffee',
    'Gruntfile.coffee',
    'app/**/*.coffee',
    'config/**/*.coffee',
    'test/**/*.coffee'
  ]

  # Grunt Config
  grunt.initConfig

    watch:
      server:
        files: appFiles,
        tasks: ['build', 'express:dev']
        options:
          spawn: false

    express:
      options:
        script: 'index.js'
      dev:
        options:
          node_env: 'development'

    mochaTest:
      all:
        options:
          reporter: 'spec'
          require: 'coffee-script/register'
        src: ['test/**/*.coffee']

    coffeelint:
      all: appFiles
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
          value: 36
          level: 'error'
        max_line_length:
          value: 120,
          level: 'error'
          limitComments: yes

  # Npm Tasks
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-coffeelint'
  grunt.loadNpmTasks 'grunt-express-server'
  grunt.loadNpmTasks 'grunt-mocha-test'

  # Tasks
  grunt.registerTask('build', ['coffeelint'])
  grunt.registerTask('dev', ['build', 'express:dev', 'watch'])
  grunt.registerTask('test', ['build', 'mochaTest'])
