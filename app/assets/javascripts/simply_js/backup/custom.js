
jQuery(function($){

	var $body=$('body');	
	var $header=$("#header2");
	var $right_side=$('#right-side');
	var $supersized_wrap=$('#supersized-wrap');
	var $main_wrap=$('#main-wrap');
	
	var $open_button=$('#open-button');
	var $close_button=$('#close-button');
	
	var $portfolio_wrap=$('#portfolio-projects');
	var $portfolio_projects=$('.portfolio-project');
	var $blog_wrap=$('#blog-posts');
	var $blog_posts=$('.blog-post');
	
	var $gallery_wrap=$('#gallery-images');
	var $gallery_images=$('#gallery-images .gallery-image');
	var isOpen=$body.hasClass('page-open') ? true: false;	
	var isAnimating=false;
	var menuOpen;
	var menuAnimating=false;
	var themeEasing='easeInOutExpo';
	var mobile;
	var scrollApi=[];
	
	if($.cookie('the_cookie')==null || $.cookie('the_cookie')=='true') menuOpen=true;
	else  menuOpen=false;
	
	$(window).resize(function() {

		var width = $(window).width();
		var height= $(window).height();
		
		
		if(width<959){
		
			mobile=true;
		
			$supersized_wrap.css({height:width/1.4, width:width}); 

			//remove mousewheel functionality
			$body.unbind("mousewheel");
		
			//remove menu sliding functionality
			$header.unbind("mouseenter");
			$right_side.unbind("mousemove");
			
			if (scrollApi!='') {  scrollApi.destroy(); scrollApi = []; }
			
		}
		
		if(width>=960){
		
			mobile=false;
			
		
			if(isAnimating==true) return false;
			
			if(isOpen==true) 
				$supersized_wrap.css({height:height-40, width:width-$main_wrap.width()-9});  
			else 
				$supersized_wrap.css({height:height-40, width:width-9}); 

				
			$right_side.css({width:width-9});	

			//add mousewheel functionality
			if($main_wrap.length) mouseWheel_init();	
			
	
			
			//add menu sliding functionality
			menuHover_init();
			
			

	
					
			
	
		}
		
		

	}).trigger('resize');
	

	//mousewheel init
	function mouseWheel_init(){
	
        scrollApi=$main_wrap.jScrollPane({animateScroll: true, animateEase : themeEasing, animateDuration :300}).data().jsp;

		$body.mousewheel( function(event, delta, deltaX, deltaY) {
								
			scrollApi.scrollBy(0, -200*delta);
			
		});

	}
	
	//navigation
	$('#header2 #nav > ul > li > .sub-menu').siblings('a').addClass('withPlus');

	$header.on("click", ".withPlus", function(e){

		e.preventDefault();
		$('#nav .withMinus').removeClass('withMinus').addClass('withPlus').siblings('.sub-menu').slideUp(400, themeEasing);
		$(this).removeClass('withPlus').addClass('withMinus').siblings('.sub-menu').slideDown(400, themeEasing);

	});

	$header.on("click", ".withMinus", function(e){

		e.preventDefault();
		$(this).removeClass('withMinus').addClass('withPlus').siblings('.sub-menu').slideUp(400, themeEasing);

	});
	
	//touch swipe gestures				
	$header.touchwipe({
		wipeLeft: function() { if(menuOpen==true) hide_header(); },
		wipeRight: function() { show_header(); },
		preventDefaultEvents: false
	});

	//menu hover effect
	function menuHover_init(){
	
		$header.hover(function () {

			show_header();
			
		}, function(){
		
			if(menuOpen==true) hide_header();
		
		});
		
		$right_side.mousemove(function(e){

			if(menuOpen==true) hide_header();
		   
		});
	
	}
		
	function show_header(){

		$header.stop(false,false).animate({left:'0px'},800,themeEasing);
		$right_side.stop(false,false).animate({left:$header.width()},800,themeEasing);
		$.cookie('menu-open', 'true', { expires: 7, path: '/' });
		menuOpen=true;
		
		$('#plus-sign').hide();
		
	}

	function hide_header(){

		$header.stop(false,false).animate({left:'-220px'},800,themeEasing, function(){ $('#plus-sign').show(); });
		$right_side.stop(false,false).animate({left:'9px'},800,themeEasing);
		$.cookie('menu-open', 'false', { expires: 7, path: '/' });
		menuOpen=false;
		$('#nav .withMinus').removeClass('withMinus').addClass('withPlus').siblings('.sub-menu').slideUp(400, themeEasing);
		
	}


	$open_button.click(function () {

		isAnimating=true;
		var interval=setInterval(function(){ $(window).trigger('resize'); },20);

		$main_wrap.animate({right:0},800,themeEasing, function(){
				
			//show the close button	
			$close_button.fadeIn(400,themeEasing).find('.circle').transition({perspective: '100px',rotateY: '180deg'},40).transition({perspective: '100px',rotateY: '0deg'},400);
					
			//hide the open button
			$open_button.fadeOut(400,'easeInOutExpo').find('.circle').transition({perspective: '100px',rotateY: '180deg'},400);
							
			//clearinterval  
			isAnimating=false; 
			clearInterval(interval);

			isOpen=true;			
			
		});
	  
		$supersized_wrap.animate({width:$(window).width()-$main_wrap.width()-9},800,themeEasing);
	  
	});

	$close_button.click(function () {

		isAnimating=true;
		var interval=setInterval(function(){ $(window).trigger('resize'); },10);

		$main_wrap.animate({right:-$main_wrap.width()},800,themeEasing, function(){
			
			//show the open button	
			$open_button.fadeIn(400,themeEasing).find('.circle').transition({perspective: '100px',rotateY: '180deg'},40).transition({perspective: '100px',rotateY: '0deg'},400);
					
			//hide the close button
			$close_button.fadeOut(400,'easeInOutExpo').find('.circle').transition({perspective: '100px',rotateY: '180deg'},400);
			
			//clearinterval  
			isAnimating=false; 
			clearInterval(interval);  
			
			isOpen=false;		
			
		});
	  
		$supersized_wrap.animate({width:$(window).width()-9},800,themeEasing);
	  
	});



	$blog_wrap.imagesLoaded(function(){

		$blog_wrap.masonry({
			itemSelector : '.blog-post',
			isAnimated: true,
			isFitWidth: true,
			position:'relative',			
			columnWidth: function(containerWidth){
					
				var initialWidth=290;		
				var columns=Math.floor(containerWidth/initialWidth);
				var pxleft=Math.floor((containerWidth-columns*initialWidth)/columns);
				$blog_posts.css({width:initialWidth+pxleft+1})	
				return initialWidth+pxleft;

			}
			
		});
		
		$(window).trigger('resize');

		$(".video-wrap").fitVids();

		//hide loading graphic
		$('#loading-graphic').fadeOut(300);

		//fadein blog posts
		$blog_posts.each(function(index){

			$(this).delay(Math.floor(Math.random()*20)*100).fadeIn(800, themeEasing);

		});

	});


	$portfolio_wrap.imagesLoaded(function(){
	
		if($portfolio_wrap.hasClass('grayscale')) grayscale_images($portfolio_wrap);
	
		$portfolio_wrap.masonry({
			itemSelector : '.portfolio-project',
			isAnimated: false,
			isFitWidth: true,
			position:'relative',			
			columnWidth: function(containerWidth){
					
				var initialWidth=260;		
				var columns=Math.floor(containerWidth/initialWidth);
				var pxleft=Math.floor((containerWidth-columns*initialWidth)/columns);
				$portfolio_projects.css({width:initialWidth+pxleft});
				return initialWidth+pxleft;

			}
		});
		
		$(window).trigger('resize');
		
		//fadein portfolio projects
		$portfolio_projects.each(function(index){

			$(this).delay(Math.floor(Math.random()*20)*100).fadeIn(800, themeEasing);

		});
		
	});
	
	
	$gallery_wrap.imagesLoaded(function(){
	
		if($gallery_wrap.hasClass('grayscale')) grayscale_images($gallery_wrap);

		$gallery_wrap.masonry({
			itemSelector : '.gallery-image',
			isAnimated: false,
			isFitWidth: true,
			position:'relative',			
			columnWidth: function(containerWidth){
					
				var initialWidth=160;	
				var columns=Math.floor(containerWidth/initialWidth);
				var pxleft=Math.floor((containerWidth-columns*initialWidth)/columns);
				$gallery_images.css({width:initialWidth+pxleft});
				
				$gallery_wrap.find('.tile-width-2').css({width:(initialWidth+pxleft)*2});
				$gallery_wrap.find('.tile-width-3').css({width:(initialWidth+pxleft)*3});
				
				return initialWidth+pxleft;

			}
		});
		
		$(window).trigger('resize');
				
		//fadein portfolio projects
		$gallery_images.each(function(index){
		
			$(this).delay(Math.floor(Math.random()*20)*10).fadeIn(800, themeEasing);

		});
		
		
	});

	
	

	//masonry sorting functionality
	$('#portfolio-categories li a').click(function () {

		$this=$(this);				
		if($this.hasClass('current')) return false;
		$this.parent().parent().find('a').removeClass('current');
		$this.addClass('current');
		
		var cat=$this.attr('data-cat');
		if(cat=='*') $portfolio_projects.addClass('portfolio-project').fadeIn(600,themeEasing);
		else{

			$portfolio_projects.not('.cat-'+cat).removeClass('portfolio-project').fadeOut(600,themeEasing);
			$portfolio_wrap.find('.cat-'+cat).addClass('portfolio-project').fadeIn(600,themeEasing);
			
		}
		
		$portfolio_wrap.masonry('reload');
	
	});
	

	//fitvids init
	$(".video-wrap").fitVids();

	//lighbox init
	$('a.lightbox').colorbox({

		maxWidth:'80%',
		maxHeight:'80%',
		fixed:true,
		opacity: 1,
		rel:'lightbox'

	});

	//lighbox init for videos
	$('a.lightbox[href*="http://vimeo.com/"]').each(function() {
		$(this).attr('href',this.href.replace('vimeo.com/', 'player.vimeo.com/video/')).removeClass('lightbox').addClass('lightbox-video');
	});
	$('a.lightbox[href*="http://www.youtube.com/watch?"]').each(function() {
		$(this).attr('href',this.href.replace('watch?v=', 'embed/')).removeClass('lightbox').addClass('lightbox-video');
	});

	$("a.lightbox-video").colorbox({

		fixed:true,
		opacity :1,
		iframe:true,			
		innerWidth:'70%', 
		innerHeight:'70%'

	});

	//slideshow shortcode init
	$('.slideshow-wrap').flexslider({
		animation: 'fade',
		slideshow: false, 
		controlNav: false,
		slideshowSpeed: 2000,	
		controlsContainer: '.flexslider-container'
	});

	//on all slideshow buttons hover
	$(".tf-button").hover(function () {

		$(this).find('.circle').stop().transition({perspective: '100px',rotateY: '180deg'},400, 'ease');

	},function (){

		$(this).find('.circle').stop().transition({perspective: '100px',rotateY: '0deg'},400, 'ease');

	});

	//placeholder init
	$('input[placeholder], textarea[placeholder]').placeholder();
	
	//responsive menu 
	var responsivemenuOpen=false;
	$('#responsive-menu-button').click(function () {
	
		if(responsivemenuOpen==true){

			$('#nav-wrap').slideUp(800,themeEasing);
			responsivemenuOpen=false;

		}		
		else {
		
			$('#nav-wrap').slideDown(800,themeEasing);
			responsivemenuOpen=true;
		
		}

	});
	
	//accordion init
	$(".accordion .accordion-title").click(function(){
		$(this).toggleClass('active').siblings().removeClass('active');
		$(this).next('.content').toggleClass('active').siblings('.content').removeClass('active');
		$(this).next("div.content").slideToggle(300).siblings("div.content").slideUp(300);
	});
	$('.accordion .accordion-title:first-child').trigger("click");
	
	//contact form validate
	$('.contact-form').each(function(i){
	
		$(this).validate({

			highlight: function(element, errorClass) { $(element).addClass('invalid'); },

			unhighlight: function(element, errorClass) { $(element).removeClass('invalid'); },

			errorPlacement: function(error, element) {},

			submitHandler: function(form) {
			
				$.post(form.action+'?'+$(form).serialize(),function(){
			
					$(form).find('.alert-success').fadeIn(200);
					
				});
				
			}
		
		});
	});
	
	
	//close portfolio images and grayscale them
	function grayscale_images($container){
	
		$container.find('img').each(function(){
			var el = $(this);
			
			el.css({"position":"relative"}).clone().addClass('img-color').insertBefore(el).queue(function(){
				
				var el = $(this);
				el.dequeue();
				el.hide();
			});
			this.src = grayscale(this.src);
		});
	
	
	}
	
	
	
	
	
	//grasycale function
	function grayscale(src) {
		var supportsCanvas = !!document.createElement('canvas').getContext;
		if (supportsCanvas) {
			var canvas = document.createElement('canvas'),
			context = canvas.getContext('2d'),
			imageData, px, length, i = 0, gray,
			img = new Image();
			 
			img.src = src;
			canvas.width = img.width;
			canvas.height = img.height;
			context.drawImage(img, 0, 0);
			 
			imageData = context.getImageData(0, 0, canvas.width, canvas.height);
			px = imageData.data;
			length = px.length;
			 
			for (; i < length; i += 4) {
				gray = px[i] * .3 + px[i + 1] * .59 + px[i + 2] * .11;
				px[i] = px[i + 1] = px[i + 2] = gray;
			}
			 
			context.putImageData(imageData, 0, 0);
			return canvas.toDataURL();
		} else {
			return src;
		}
	}
	


});