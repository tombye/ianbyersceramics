var gulp = require('gulp');
var uglify = require('gulp-uglify');
var deleteFiles = require('del');
var sourcemaps = require('gulp-sourcemaps');

// Paths
jsFolder = 'public/javascripts/';
cssFolder = 'public/stylesheets/';

// JavaScript paths
jsSourceFiles = [
  'jquery-1.9.1.min.js',
  'modernizr-2.6.2-custom.min.js',
  'main.js'
];
jsDistributionFile = ['application.js'];

// CSS paths
cssScreenSourceFiles = ['main.css'];
cssPrintSourceFiles = ['print.css'];
cssSourceFiles = cssScreenSourceFiles.concat(cssPrintSourceFiles);
cssScreenDistributionFile = 'application.css';
cssPrintDistributionFile = 'application-print.css';

// Configuration
var uglifyOptions = {
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

  deleteFiles(jsSourceFiles, logOutputFor('JavaScript'));
  deleteFiles(cssSourceFiles, logOutputFor('CSS'));
});

gulp.task('js', function () {
  var stream = gulp.src(jsSourceFiles)
    .pipe(filelog('Compressing JavaScript files'))
    .pipe(include())
    .pipe(sourcemaps.init())
    .pipe(uglify(
      uglifyOptions[environment]
    ))
    .pipe(sourcemaps.write('./maps'))
    .pipe(gulp.dest(jsFolder + jsDistributionFile));

  stream.on('end', function () {
    console.log('💾 Compressed JavaScript saved as ' + jsFolder + jsDistributionFile);
  });

  return stream;
});

gulp.task('cssScreen', function () {
  var stream = gulp.src(cssScreenSourceFiles)
    .pipe(filelog('Compressing CSS files for screen'))
    .pipe(include())
    .pipe(sourcemaps.init())
    .pipe(uglify(
      uglifyOptions[environment]
    ))
    .pipe(sourcemaps.write('./maps'))
    .pipe(gulp.dest(cssFolder + cssScreenDistributionFile));

  stream.on('end', function () {
    console.log('💾 Compressed CSS saved as ' + cssFolder + cssScreenDistributionFile);
  });

  return stream;
});

gulp.task('cssPrint', function () {
  var stream = gulp.src(cssPrintSourceFiles)
    .pipe(filelog('Compressing CSS files for screen'))
    .pipe(include())
    .pipe(sourcemaps.init())
    .pipe(uglify(
      uglifyOptions[environment]
    ))
    .pipe(sourcemaps.write('./maps'))
    .pipe(gulp.dest(cssFolder + cssPrintDistributionFile));

  stream.on('end', function () {
    console.log('💾 Compressed CSS saved as ' + cssFolder + cssPrintDistributionFile);
  });

  return stream;
});

gulp.task('watch', ['build'], function () {
  var jsWatcher = gulp.watch([ jsFolder + '*.js' ], ['js']);
  var cssWatcher = gulp.watch([ cssFolder + '*.css' ], ['cssScreen', 'cssPrint']);
  var notice = function (event) {
    console.log('File ' + event.path + ' was ' + event.type + ' running tasks...');
  };

  cssWatcher.on('change', notice);
  jsWatcher.on('change', notice);
});

gulp.task(
  'compile',
  function() {
    gulp.start('cssScreen');
    gulp.start('cssPrint');
    gulp.start('js');
  }
);

gulp.task('build', ['clean'], function () {
  gulp.start('compile');
});
