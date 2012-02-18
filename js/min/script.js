(function() {
  var $, Slider;

  $ = jQuery;

  Slider = {
    el: $('#gallery'),
    current: 0,
    total: 0,
    init: function() {
      if (Slider.el.hasClass('no-gallery')) return false;
      Slider.width = Slider.el.width();
      Slider.tagline = Slider.el.find('.tagline');
      Slider.nav = Slider.el.find('.nav');
      Slider.total = Slider.el.find('figure').length - 1;
      Slider.nav.hide();
      Slider.el.hover(function() {
        return $(Slider.nav).show();
      }, function() {
        return Slider.nav.hide();
      });
      Slider.el.find('.nav').click(function(ev) {
        ev.preventDefault();
        if ($(this).hasClass('left')) {
          Slider.current--;
        } else {
          Slider.current++;
        }
        if (Slider.current < 0) Slider.current = Slider.total;
        if (Slider.total < Slider.current) Slider.current = 0;
        return Slider.slideTo(Slider.current);
      });
      return Slider.el.find('.navigation ul li a').unbind('click').bind('click', function(ev) {
        ev.preventDefault();
        Slider.current = $(this).attr('data-id');
        return Slider.slideTo(Slider.current);
      });
    },
    slideTo: function(id) {
      Slider.el.find('.navigation ul li').removeClass('current');
      Slider.currentEl = Slider.el.find('.navigation ul li a[data-id=' + Slider.current + ']');
      if (Slider.current) Slider.nav.find('.right').addClass('show');
      Slider.currentEl.parent().addClass('current');
      Slider.tagline.html('<h3>' + Slider.currentEl.attr('data-title') + '</h3>' + Slider.currentEl.attr('data-price'));
      return Slider.el.find('#slider').animate({
        'left': (Slider.width * Slider.current) * -1
      });
    }
  };

  Slider.init();

}).call(this);
