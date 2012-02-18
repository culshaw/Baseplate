$ = jQuery;

Slider = {
  el:		$('#gallery')
  current:	0
  total:	0
  init: 	-> 
  	return false if Slider.el.hasClass('no-gallery')
  	Slider.width = Slider.el.width()
  	Slider.tagline 	= Slider.el.find('.tagline')
  	Slider.nav		= Slider.el.find('.nav')
  	# Calculate total number of slides
  	Slider.total = Slider.el.find('figure').length-1
  	Slider.nav.hide()
  	
  	Slider.el.hover(
  	  ->
  	  	#$(Slider.nav[0]).show() if !$(Slider.nav[0]).hasClass('disabled')
  	  	#$(Slider.nav[1]).show() if !$(Slider.nav[1]).hasClass('disabled')
  	  	$(Slider.nav).show()
  	  ->
  	  	Slider.nav.hide()
  	)
  	
  	Slider.el.find('.nav').click((ev)->
  		ev.preventDefault()
  		
  		if $(this).hasClass('left') then  Slider.current--; else Slider.current++
  		
  		
  		if Slider.current < 0 then Slider.current = Slider.total
  		if Slider.total < Slider.current then Slider.current = 0
  		
  		Slider.slideTo(Slider.current)
  	)

  	Slider.el.find('.navigation ul li a').unbind('click').bind('click', (ev)->
  	  ev.preventDefault()
  	  Slider.current = $(this).attr('data-id')
  	  
  	  Slider.slideTo(Slider.current)
  	)
  slideTo: (id)->
    Slider.el.find('.navigation ul li').removeClass('current')
    Slider.currentEl = Slider.el.find('.navigation ul li a[data-id='+Slider.current+']')
    #if Slider.current > 0 && Slider.total >= Slider.current then $(Slider.nav[0]).removeClass('disabled').show(); else $(Slider.nav[0]).addClass('disabled').hide()
    #if Slider.current < Slider.total && Slider.total > 0 then $(Slider.nav[1]).removeClass('disabled').show(); else $(Slider.nav[1]).addClass('disabled').hide()
    
    Slider.nav.find('.right').addClass('show') if Slider.current
    
    Slider.currentEl.parent().addClass('current')
    Slider.tagline.html('<h3>' + Slider.currentEl.attr('data-title') + '</h3>' + Slider.currentEl.attr('data-price'))
    Slider.el.find('#slider').animate({'left': (Slider.width * Slider.current)*-1 })
};

Slider.init();