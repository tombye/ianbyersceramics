const { src, dest, series, parallel } = require('gulp');
const filelog = require('gulp-filelog');
const uglifyJS = require('gulp-uglify');
const uglifyCSS = require('gulp-uglifycss');
const include = require('gulp-include');
const deleteFiles = require('del');
const sourcemaps = require('gulp-sourcemaps');

// Paths
const root = __dirname + '/';
const jsFolder = root + 'public/javascripts/';
const cssFolder = root + 'public/stylesheets/';

// JavaScript paths
const jsSourceFile = jsFolder + 'src/application.js';
const jsDistributionFile = jsFolder + 'dist/application.js';
const jsDistributionFolder = jsFolder + 'dist';

// CSS paths
const cssSourceFiles = cssFolder + 'src/*';
const cssDistributionFolder = cssFolder + 'dist';
const cssScreenDistributionFile = cssFolder + 'dist/application.css';
const cssPrintDistributionFile = cssFolder + 'dist/application-print.css';

// Configuration
const uglifyJSOptions = {
  mangle: false,
  output: {
    beautify: true,
    semicolons: true,
    comments: true,
    indent_level: 2
  },
  compress: false
};

function logErrorAndExit(err) {
  function printError(type, message) {
    console.log('gulp ' + colours.red('ERR! ') + type + ': ' + message);
  };

  printError('message', err.message);
  printError('file name', err.fileName);
  printError('line number', err.lineNumber);
  process.exit(1);

};

function clean(cb) {
  var fileTypes = [];
  function complete(fileType) {
    fileTypes.push(fileType);
    if (fileTypes.length == 2) {
      cb();
    }
  };
  function logOutputFor(fileType) {
    return function (err, paths) {
      if (paths !== undefined) {
        console.log('💥  Deleted the following ' + fileType + ' files:\n', paths.join('\n'));
      }
      complete(fileType);
    };
  };

  deleteFiles(jsDistributionFolder + '/*').then(logOutputFor('JavaScript'));
  deleteFiles(cssDistributionFolder + '/*').then(logOutputFor('CSS'));
};

function js() {
  const stream = src(jsSourceFile)
    .pipe(filelog('Compressing JavaScript files'))
    .pipe(include())
    .pipe(sourcemaps.init())
    .pipe(uglifyJS(
      uglifyJSOptions
    ))
    .pipe(sourcemaps.write('./maps'))
    .pipe(dest(jsDistributionFolder));

  stream.on('end', function () {
    console.log('💾 Compressed JavaScript saved as ' + jsDistributionFile);
  });

  return stream;
};

function css() {
  const stream = src(cssSourceFiles)
    .pipe(filelog('Compressing CSS files'))
    .pipe(include())
    .pipe(sourcemaps.init())
    .pipe(uglifyCSS())
    .pipe(sourcemaps.write('./maps'))
    .pipe(dest(cssDistributionFolder));

  stream.on('end', function () {
    console.log('💾 Compressed CSS saved as ' + cssScreenDistributionFile + ' and ' + cssPrintDistributionFile);
  });

  return stream;
};

exports.build = parallel(css, js);
