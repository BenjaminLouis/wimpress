/* To avoid CSS expressions while still supporting IE 7 and IE 6, use this script */
/* The script tag referencing this file must be placed before the ending body tag. */

/* Use conditional comments in order to target IE 7 and older:
	<!--[if lt IE 8]><!-->
	<script src="ie7/ie7.js"></script>
	<!--<![endif]-->
*/

(function() {
	function addIcon(el, entity) {
		var html = el.innerHTML;
		el.innerHTML = '<span style="font-family: \'icopaged\'">' + entity + '</span>' + html;
	}
	var icons = {
		'icon-top-left-corner': '&#xe900;',
		'icon-top-left': '&#xe901;',
		'icon-top-center': '&#xe902;',
		'icon-top-right': '&#xe903;',
		'icon-top-right-corner': '&#xe904;',
		'icon-right-top': '&#xe905;',
		'icon-right-middle': '&#xe906;',
		'icon-right-bottom': '&#xe907;',
		'icon-bottom-right-corner': '&#xe908;',
		'icon-bottom-right': '&#xe909;',
		'icon-bottom-center': '&#xe90a;',
		'icon-bottom-left': '&#xe90b;',
		'icon-bottom-left-corner': '&#xe90c;',
		'icon-left-bottom': '&#xe90d;',
		'icon-left-middle': '&#xe90e;',
		'icon-left-top': '&#xe90f;',
		'icon-none': '&#xe910;',
		'0': 0
		},
		els = document.getElementsByTagName('*'),
		i, c, el;
	for (i = 0; ; i += 1) {
		el = els[i];
		if(!el) {
			break;
		}
		c = el.className;
		c = c.match(/icon-[^\s'"]+/);
		if (c && icons[c[0]]) {
			addIcon(el, icons[c[0]]);
		}
	}
}());
