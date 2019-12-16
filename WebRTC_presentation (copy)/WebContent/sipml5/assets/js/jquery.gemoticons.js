(function($){
	$.fn.gemoticon = function(options){ /**We have named our plugin 'gemoticon'**/

		var defaults = {
			enabled: true,
			speed: 100,
			emo: new Array('smile', 'grin', 'wink', 'cry', 'shocked', 'slant', 'angry', 'frown', 'cool', 'tongue', 'heart', 'straight_face'),
			symbols: new Array(":)", ":D", ";)", ":'(", ":-o", ":-/", "x-(", ":(", "B-)", ":P", "<3", ":-|")
		};
		var options = $.extend(defaults, options);

		var t = {};

		var $this = $(this);
		if(options.enabled){
			return $this.each(function(i,obj) {
				var x = $(obj);
				
				// Entites Encode 
				var encoded = [];
				for(j=0; j<options.symbols.length; j++){
					encoded[j] = String(options.symbols[j]).replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;');
				}
				for(i=0; i<options.symbols.length; i++){
					var htm = x.html();
					if (htm.indexOf(options.symbols[i]) !== -1 || htm.indexOf(encoded[i]) !== -1) {
						var elem = options.emo[i];
						var a = options.symbols[i];
						var b = encoded[i];
						var c = $("<img src='images/blank.png' class='"+elem+" g_icon g_new' />");
						var myHtm = c.clone().wrap('<p>').parent().html();
						htm = replaceAll(a, myHtm, htm);
						htm = replaceAll(b, myHtm, htm);

						x.html(htm);
						
						var k=0;
						$('.'+elem).each(function(){
							var new_id = elem+'_'+k;
							$(this).attr('id', new_id);

							if ($(this).hasClass('g_new')) {
								resetIcon($('#'+new_id));
								t[new_id] = setInterval( function() {
									anim($('#'+new_id));
								}, options.speed);
							}
							$(this).removeClass('g_new');

							//Attach the mouseover event
							$('#'+new_id).live('hover', function(){
								if (!t[new_id]) {
									resetIcon($('#'+new_id));
									t[new_id] = setInterval( function() {
										anim($('#'+new_id));
									}, options.speed);
								}
							});
							
							k++;
						});
					}
				}
			});
		}

		function resetIcon(el){
			el.css('background-position', '0 14px');
		}
		function anim(el) {
			var id = el.attr('id');
			var bg = el.css('background-position');
			var bgXY = bg.split(' ');
			var bgX = bgXY[0];
			var bgY = parseFloat(bgXY[1]);
			var newbgY = (parseFloat(bgY) - parseFloat(14)) + 'px';
			var newBgXy = bgX + ' ' + newbgY;

			var bgImg = el.css('background-image');
			bgImg = bgImg.replace(/^url\(["']?/, '').replace(/["']?\)$/, '');
			var image = new Image();
			image.src = bgImg;
			var width = image.width;
			var height = image.height;
			var diff = parseFloat(bgY) + parseFloat(height) - parseFloat(el.height());
			if (diff == 0) {
				clearInterval(t[id]);
				t[id] = null;
			} else {
				el.css('background-position', newBgXy);
			}
		}

		function replaceAll(find, replace, str) {
			find = escapeRegExp(find);
			var regex = new RegExp(find, 'gi');
			return str.replace(regex, replace);
		}
		function escapeRegExp(str) {
			return str.replace(/[\-\[\]\/\{\}\(\)\*\+\?\.\\\^\$\|]/g, "\\$&");
		}

	};
})(jQuery);