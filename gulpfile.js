var gulp = require('gulp');
var filelog = require('gulp-filelog');
var uglifyJS = require('gulp-uglify');
var uglifyCSS = require('gulp-uglifycss');
var include = require('gulp-include');
var deleteFiles = require('del');
var sourcemaps = require('gulp-sourcemaps');

// Paths
var root = __dirname + '/';
var jsFolder = root + 'public/javascripts/';
var cssFolder = root + 'public/stylesheets/';

// JavaScript paths
var jsSourceFile = jsFolder + 'src/application.js';
var jsDistributionFile = jsFolder + 'dist/application.js';
var jsDistributionFolder = jsFolder + 'dist';

// CSS paths
var cssSourceFiles = cssFolder + 'src/*';
var cssDistributionFolder = cssFolder + 'dist';
var cssScreenDistributionFile = cssFolder + 'dist/application.css';
var cssPrintDistributionFile = cssFolder + 'dist/application-print.css';

// Configuration
var uglifyJSOptions = {
  mangle: false,
  output: {
    beautify: true,
    semicolons: true,
    comments: true,
    indent_level: 2
  },
  compress: false
};

var logErrorAndExit = function logErrorAndExit(err) {
  var printError = function (type, message) {
    console.log('gulp ' + colours.red('ERR! ') + type + ': ' + message);
  };

  printError('message', err.message);
  printError('file name', err.fileName);
  printError('line number', err.lineNumber);
  process.exit(1);

};

gulp.task('clean', function (cb) {
  var fileTypes = [];
  var complete = function (fileType) {
    fileTypes.push(fileType);
    if (fileTypes.length == 2) {
      cb();
    }
  };
  var logOutputFor = function (fileType) {
    return function (err, paths) {
      if (paths !== undefined) {
        console.log('💥  Deleted the following ' + fileType + ' files:\n', paths.join('\n'));
      }
      complete(fileType);
    };
  };

  deleteFiles(jsDistributionFolder + '/*').then(logOutputFor('JavaScript'));
  deleteFiles(cssDistributionFolder + '/*').then(logOutputFor('CSS'));
});

gulp.task('js', function () {
  var stream = gulp.src(jsSourceFile)
    .pipe(filelog('Compressing JavaScript files'))
    .pipe(include())
    .pipe(sourcemaps.init())
    .pipe(uglifyJS(
      uglifyJSOptions
    ))
    .pipe(sourcemaps.write('./maps'))
    .pipe(gulp.dest(jsDistributionFolder));

  stream.on('end', function () {
    console.log('💾 Compressed JavaScript saved as ' + jsDistributionFile);
  });

  return stream;
});

gulp.task('css', function () {
  var stream = gulp.src(cssSourceFiles)
    .pipe(filelog('Compressing CSS files'))
    .pipe(include())
    .pipe(sourcemaps.init())
    .pipe(uglifyCSS())
    .pipe(sourcemaps.write('./maps'))
    .pipe(gulp.dest(cssDistributionFolder));

  stream.on('end', function () {
    console.log('💾 Compressed CSS saved as ' + cssScreenDistributionFile + ' and ' + cssPrintDistributionFile);
  });

  return stream;
});

gulp.task('watch', ['build'], function () {
  var jsWatcher = gulp.watch([ jsFolder + '*.js' ], ['js']);
  var cssWatcher = gulp.watch([ cssFolder + '*.css' ], ['css']);
  var notice = function (event) {
    console.log('File ' + event.path + ' was ' + event.type + ' running tasks...');
  };

  cssWatcher.on('change', notice);
  jsWatcher.on('change', notice);
});

gulp.task(
  'compile',
  function() {
    gulp.start('css');
    gulp.start('js');
  }
);

gulp.task('build', ['clean'], function () {
  gulp.start('compile');
});
