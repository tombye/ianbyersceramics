var IBC = IBC || {};

IBC.slideshow = (function () {
    Slideshow = function ($elm) {
        var orientation = $elm[0].className.match(/portrait|landscape/),
            keyword;
        
        this.$container = $elm
        this.slides = $elm.find('img');
        keyword = this.slides[0].src.match(/([a-z]+)\d+\.jpg$/);

        if (!keyword.length || orientation === null) {
            return;
        } else {
            this.keyword = keyword[1];
            this.orientation = orientation[0];
        }

        this.init();
    };

    Slideshow.prototype = {
        createControls : function () {
            var $control,
                $controls = $('<ul class="controls clearfix" role="tablist" aria-label="Slideshow controls"/>'),
                rowLen = (this.orientation === 'portrait') ? 4 : 5,
                i,
                j;

            for (i = 0, j = this.slides.length; i < j; i++) {
                $control = $('<li><a role="tab" aria-selected="false" href="#"><img src="/static/img/process_and_material/' + this.keyword + (i + 1) + '_90x90.jpg" alt="Slide ' + (i + 1) + '" /></a></li>');
                if ((i > 0) && ((i + 1) % rowLen) === 0) {
                    $control.addClass('last');
                }
                $controls.append($control);
            }
            this.$container.append($controls);
            this.$controls = $controls.find('a');
            this.$controls.eq(0)
                .addClass('active')
                .attr('aria-selected','true');
        },
        onClick : function (control) {
            var idx = this.$controls.index(control);

            if (idx !== -1) {
                this.slides.hide();
                this.slides.eq(idx).css('display', 'block');
                this.$controls
                    .removeClass('active')
                    .attr('aria-selected', 'false');
                $(control)
                    .addClass('active')
                    .attr('aria-selected', 'true');
            }
        },
        init : function () {
            var self = this;
            this.createControls();
            this.$controls.on('click', function () {
                var control = this;
                self.onClick(control);
                return false;
            });
            this.$container.addClass('active');
        }
    };

    return {
        slideshows : [],
        init : function () {
            var self = this;
            $('.slideshow').each(function () {
                self.slideshows.push(new Slideshow($(this)));
            })
        }
    };
}());

IBC.video = (function () {
    return {
        setUpCaptions : function () {
            var $transcripts = $('.video-transcript'),
                onClick;

            if ($transcripts.length) {

                onClick = function ($transcript) {
                    if ($transcript.css('display') === 'block') {
                        $transcript.hide();
                    } else {
                        $transcript.show();
                    }
                };

                $transcripts.each(function (idx) {
                    var $transcript = $(this),
                        $toggle = $transcript.siblings('p').find('a.transcript-toggle');

                    $toggle.on('click', function () {
                        return function () {
                            onClick($transcript);
                            return false;
                        } 
                    }());
                });
            }
        },
        init : function () {
            this.setUpCaptions();
        }
    };
}());

$(document).ready(function () {
    IBC.slideshow.init();        
    IBC.video.init();
});
