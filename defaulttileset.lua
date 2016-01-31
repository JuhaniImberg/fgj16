vector = require "hump/vector"
TileSet = require "tileset"
ti = require "tileinfo"

return TileSet("graphics/tileset.png", 24, 24,
               {
                   -- a	b c d e	f g h i
                   -- j k l m n o p q r
                   -- s t u v w x y z 0
                   -- 1 2 3 4 5 6 7 8 9
        		   -- A B C D E F G H I
        		   -- J K L M N O P Q R

                   ti.TileInfo("a", 0, 0),
                   ti.TileInfo("b", 1, 0),
                   ti.TileInfo("c", 2, 0),
                   ti.TileInfo("d", 3, 0),
                   ti.TileInfo("e", 4, 0),
                   ti.TileInfo("f", 5, 0),
                   ti.TileInfo("g", 6, 0),
                   ti.AnimatedTileInfo("h", {vector(7, 0),vector(3, 4),vector(4, 4),vector(5, 4)}, true),
                   ti.TileInfo("i", 8, 0),

                   ti.TileInfo("j", 0, 1, true),
                   ti.TileInfo("k", 1, 1, true),
                   ti.TileInfo("l", 2, 1, true),
                   ti.TileInfo("m", 3, 1, true),
                   ti.TileInfo("n", 4, 1, true),
                   ti.AnimatedTileInfo("o", {vector(5, 1),vector(8, 1),vector(0, 3)}),
                   ti.TileInfo("p", 6, 1),
                   ti.TileInfo("q", 7, 1),
                   ti.TileInfo("r", 8, 1),

                   ti.TileInfo("s", 0, 2),
                   ti.TileInfo("t", 1, 2),
                   ti.TileInfo("u", 2, 2),
                   ti.TileInfo("v", 3, 2),
                   ti.TileInfo("w", 4, 2),
                   ti.TileInfo("x", 5, 2),
                   ti.TileInfo("y", 6, 2),
                   ti.TileInfo("z", 7, 2),
                   ti.TileInfo("0", 8, 2),

                   ti.TileInfo("1", 0, 3),
                   ti.AnimatedTileInfo("2", {vector(1, 3),vector(0, 7),vector(1, 7),vector(1, 3),vector(2, 7),vector(3, 7)}),
                   ti.TileInfo("3", 2, 3, true),
                   ti.TileInfo("4", 3, 3, true),
                   ti.TileInfo("5", 4, 3, true),
                   ti.TileInfo("6", 5, 3, true),
                   ti.TileInfo("7", 6, 3, true),
                   ti.TileInfo("8", 7, 3, true),
                   ti.TileInfo("9", 8, 3, true),

                   ti.TileInfo("A", 0, 4, true),
                   ti.TileInfo("B", 1, 4, true),
                   ti.TileInfo("C", 2, 4, true),
                   ti.TileInfo("D", 3, 4, true),
                   ti.TileInfo("E", 4, 4, true),
                   ti.TileInfo("F", 5, 4, true),
                   ti.TileInfo("G", 6, 4),
                   ti.TileInfo("H", 7, 4, true),
                   ti.TileInfo("I", 8, 4, true),

		   						 			   ti.TileInfo("J", 0, 5, true),
                   ti.TileInfo("K", 1, 5, true),
                   ti.TileInfo("L", 2, 5, true),
                   ti.TileInfo("M", 3, 5, true),
                   ti.TileInfo("N", 4, 5),
                   ti.TileInfo("O", 5, 5, true),
                   ti.TileInfo("P", 6, 5, true),
                   ti.TileInfo("Q", 7, 5),
                   ti.TileInfo("R", 8, 5, true),

									 			   ti.TileInfo("S", 0, 6),
                   ti.TileInfo("T", 1, 6, true),
                   ti.TileInfo("U", 2, 6, true),
                   ti.TileInfo("V", 3, 6, true),
                   ti.TileInfo("W", 4, 6, true),
                   ti.TileInfo("X", 5, 6),
                   ti.TileInfo("Y", 6, 6, true),
                   ti.TileInfo("Z", 7, 6),
                   ti.TileInfo("!", 8, 6, true),

		   ti.TileInfo("#", 0, 7),
		   ti.TileInfo("¤", 1, 7),
		   ti.TileInfo("%", 2, 7),
		   ti.TileInfo("&", 3, 7),
		   ti.TileInfo("/", 4, 7),
		   ti.TileInfo("(", 5, 7),
		   ti.TileInfo(")", 6, 7),
		   ti.TileInfo("=", 7, 7),
		   ti.TileInfo("?", 8, 7),


		   ti.TileInfo("@", 0, 8),
		   ti.TileInfo("£", 1, 8),
		   ti.TileInfo("$", 2, 8),
		   ti.TileInfo("{", 3, 8),
		   ti.TileInfo("[", 4, 8),
		   ti.TileInfo("]", 5, 8),
		   ti.TileInfo("}", 6, 8),
		   ti.TileInfo("~", 7, 8),
		   ti.TileInfo("*", 8, 8),

               }
)
