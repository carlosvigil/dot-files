{
	services.keyd.enable = true;

	services.keyd.keyboards = {
		# Canary/Qwerty and Modifiers
		canary = {
			ids = [
				"1a2c:95f6" # mkbox 70%
				"31e3:1102" # wooting one
			];
		extraConfig = ''
			
		'';
			settings = {
				global = {
					"layer_indicator" = "1";
					"chord_timeout" = "20";
				};
				main = {
					q = "w";
					w = "l";
					e = "y";
					r = "p";
					t = "k";
					y = "z";
					u = "x";
					i = "o";
					#o = "u";
					p = "semicolon";
					a = "c";
					s = "r";
					#d = "s";
					f = "t";
					g = "b";
					h = "f";
					j = "n";
					k = "e";
					l = "i";
					";" = "a";
					z = "j";
					x = "v";
					c = "d";
					v = "g";
					b = "q";
					n = "m";
					m = "h";
					"," = "slash";
					"." = "comma";
					"/" = "dot";
					"s+d" = "backspace";
					"d+f" = "esc";
					"j+k" = "enter";
					"k+l" = "toggle(nav)";
					d = "timeout(s, 175, layer(nav))";
					o = "timeout(u, 225, layer(control))";
					capslock    = "overload(control, esc)";
					leftshift   = "overload(shift, backspace)";
					space       = "timeout(space, 250, layer(shift))";
					leftalt     = "layer(meta)";
					leftmeta    = "layer(alt)";
					leftcontrol = "toggle(qwerty)";
				};

				shift = {
					leftshift = "capslock";
					rightshift = "capslock";
					f11 = "volumedown";
					f12 = "volumeup";
				};

				nav = {
					j = "left";
					k = "down";
					i = "up";
					l = "right";
				};

				qwerty = {
					q = "q";
					w = "w";
					e = "e";
					r = "r";
					t = "t";
					y = "y";
					u = "u";
					i = "i";
					o = "o";
					p = "p";
					a = "a";
					s = "s";
					d = "d";
					f = "f";
					g = "g";
					h = "h";
					j = "j";
					k = "k";
					l = "l";
					";" = "semicolon";
					z = "z";
					x = "x";
					c = "c";
					v = "v";
					b = "b";
					n = "n";
					m = "m";
					"," = "comma";
					"." = "dot";
					"/" = "slash";
				};
			};
		};

		dierya = {
			ids = [
				"0c45:766b" # dierya 60%
			];
		extraConfig = ''
			
		'';
			settings = {
				global = {
					"layer_indicator" = "1";
					"chord_timeout" = "20";
				};
				main = {
					q = "w";
					w = "l";
					e = "y";
					r = "p";
					t = "k";
					y = "z";
					u = "x";
					i = "o";
					#o = "u";
					p = "semicolon";
					a = "c";
					s = "r";
					#d = "s";
					f = "t";
					g = "b";
					h = "f";
					j = "n";
					k = "e";
					l = "i";
					";" = "a";
					z = "j";
					x = "v";
					c = "d";
					v = "g";
					b = "q";
					n = "m";
					m = "h";
					"," = "slash";
					"." = "comma";
					"/" = "layer(shift)";
					"rightshift" = "dot";
					"s+d" = "backspace";
					"d+f" = "esc";
					"j+k" = "enter";
					"k+l" = "toggle(nav)";
					d = "timeout(s, 175, layer(nav))";
					o = "timeout(u, 225, layer(control))";
					capslock    = "overload(control, esc)";
					leftshift   = "overload(shift, backspace)";
					space       = "timeout(space, 250, layer(shift))";
					leftalt     = "layer(meta)";
					leftmeta    = "layer(alt)";
					leftcontrol = "toggle(qwerty)";
				};

				shift = {
					leftshift = "capslock";
					rightshift = "capslock";
					f11 = "volumedown";
					f12 = "volumeup";
				};

				nav = {
					j = "left";
					k = "down";
					i = "up";
					l = "right";
				};

				qwerty = {
					q = "q";
					w = "w";
					e = "e";
					r = "r";
					t = "t";
					y = "y";
					u = "u";
					i = "i";
					o = "o";
					p = "p";
					a = "a";
					s = "s";
					d = "d";
					f = "f";
					g = "g";
					h = "h";
					j = "j";
					k = "k";
					l = "l";
					";" = "semicolon";
					z = "z";
					x = "x";
					c = "c";
					v = "v";
					b = "b";
					n = "n";
					m = "m";
					"," = "comma";
					"." = "dot";
					"/" = "slash";
				};
			};
		};
		# Swap command/alt back
		mac = {
			ids = [
				"k:05ac:0273" # mb keys not trackpad
			];
			settings = {
				global = {
					"layer_indicator" = "1";
					"chord_timeout" = "20";
				};
				main = {
					q = "w";
					w = "l";
					e = "y";
					r = "p";
					t = "k";
					y = "z";
					u = "x";
					i = "o";
					#o = "u";
					p = "semicolon";
					a = "c";
					s = "r";
					#d = "s";
					f = "t";
					g = "b";
					h = "f";
					j = "n";
					k = "e";
					l = "i";
					";" = "a";
					z = "j";
					x = "v";
					c = "d";
					v = "g";
					b = "q";
					n = "m";
					m = "h";
					"," = "slash";
					"." = "comma";
					"/" = "dot";
					"s+d" = "backspace";
					"d+f" = "esc";
					"j+k" = "enter";
					"k+l" = "toggle(nav)";
					d = "timeout(s, 175, layer(nav))";
					o = "timeout(u, 225, layer(control))";
					capslock    = "overload(control, esc)";
					leftshift   = "overload(shift, backspace)";
					space       = "timeout(space, 250, layer(shift))";
					leftcontrol = "toggle(qwerty)";
				};

				shift = {
					leftshift = "capslock";
					rightshift = "capslock";
					f11 = "volumedown";
					f12 = "volumeup";
				};

				nav = {
					j = "left";
					k = "down";
					i = "up";
					l = "right";
				};

				qwerty = {
					q = "q";
					w = "w";
					e = "e";
					r = "r";
					t = "t";
					y = "y";
					u = "u";
					i = "i";
					o = "o";
					p = "p";
					a = "a";
					s = "s";
					d = "d";
					f = "f";
					g = "g";
					h = "h";
					j = "j";
					k = "k";
					l = "l";
					";" = "semicolon";
					z = "z";
					x = "x";
					c = "c";
					v = "v";
					b = "b";
					n = "n";
					m = "m";
					"," = "comma";
					"." = "dot";
					"/" = "slash";
				};
			};
		};
	};
}
