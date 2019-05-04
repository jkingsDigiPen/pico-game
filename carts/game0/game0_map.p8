pico-8 cartridge // http://www.pico-8.com
version 18
__lua__

__gfx__
000000000000000011111111111111111dddddd50000000000000000000000500000000000000000333333330000002288000000000000000000000000000000
00000000000000001001110110011111111111dd0303303003033050030330050303305000000000333333330000022288800000000000000000000000000000
00000000500000001115111d11111111111111110033335000333305003333350033330500000000333333330000022288800000000000000000000000000000
0000000055000000110101111011d111111101110337370503373735003737350337373500000000333333330000228288880000000000000000000000000000
00000000d55500001111111111111511111111110333330503333335033333050333333500000000333333330000222288880000000000000000000000000000
00000000ddd555501110011111001111111001110aa333a50aa333a50aa333500aa333a500000000333333330002222288888000000000000000000000000000
0000000011dddd5511111101111110011111111103aaaa0530aaaa5030aaaa0003aaaa5000000000333333330002222288888000000000000000000000000000
0000000011111ddd1111111111111111111111110030005000300300000303000003300000000000333333330022222288828800000000000000000000000000
cccccccc000110000001100400011000d666666c0000000000000000000000000000000000000000000000000022222888888800000000000000000000000000
cccccdcc001c1104001c11040011c10466cccccc0000000000000000000000000000000000000000000000000222822288888880000000000000000000000000
cc11cccc0111c1140111c114011c1114cccccccc0000090000000090006000000060000000600000000000000222222288888880000000000000000000000000
c1cccccc00ff7f0400ff7f0f00f7ff04ccccc11c0000900000609900000999900009990000099000000000002222222288888888000000000000000000000000
cccccc1c0011661f001166140066111fcccccccc0609000000090000006000000060009000600990000000002222882288822888000000000000000000000000
cccccccc011116140111166401611114ccc11ccc0090000000060000000000000000000000000000000000022222225544888888800000000000000000000000
ccc11ccc0111fcc4011fcc140111fcc4cccccccc0060000000000000000000000000000000000000000000022222255674488888800000000000000000000000
cccccccc1111ccc41111ccc01111ccc4cccccccc0000000000000000000000000000000000000000000000222222256677488828880000000000000000000000
cccccccc00aaaa000077770033333333333333330000000000000000000000000000000000000000000000222222255544488888880000000000000000000000
cc11cc1c0a0000a007000070333333333333333300c0000000c0000000c0000000c0000000000000000002222222856677482888888000000000000000000000
cccccccca000770a70007707333333333333333d0c7c00000c7c00000c7c00000cac000000000000000002282222256677488888888000000000000000000000
cccc55cca000770a7000770733333333333333ddc7c7c0ccc7c7c0ccc77ac0cccac7c0cc00000000000022222222255544488888888800000000000000000000
c1cccccca000000a70000007333333333333ddd60c0c7cac0c07ac7c0cca7c7cc7cc7c7c00000000000022222222256677488888888800000000000000000000
ccc55ccca000000a70000007333333333dddd66600007ac0000ccac0000cc7c00c00c7c000000000000222222222256677488888888880000000000000000000
ccccccdc0a0000a00700007033333ddddd6666cc0000cc0000000c0000000c0000000c0000000000000222228822256677488882288880000000000000000000
cccccccc00aaaa0000777700dddddd66666ccccc0000000000000000000000000000000000000000002222222222555544448888888888000000000000000000
0000000000bbbb0000bbbb0033333333333333330000000000000000000000000000000000000000002222222822855544488888888888000000000000000000
000000000bbbbbb00bbbbbb033333333333333330008888000088880008888800008888800000000022282222222222288888888822888800000000000000000
0000000d3bbbbbbb3bbbbbbb53333333333333330088999800889998088899980088999800000000522222222222228288888888888888840000000000000000
000000dd36b6b6b63b6b6b6b55333333333333330889a9a888899aa88889aaa888899aa800000000552222222222222288822888888888440000000000000000
0000ddd636b6b6b63b6b6b6bd5553333333333338889aaa88889aaa808899aa80889a9a800000000555522222222222288888888888844440000000000000000
0dddd66633bbbbbb33bbbbbbddd55553333333330088999800889998008899980088999800000000555555522228222288888888844444440000000000000000
dd6666cc033bbbb0033bbbb011dddd55555333330008888800888880000888800008888800000000355555555552222288888444444444430000000000000000
666ccccc003333000033330011111ddddd5555550000000000000000000000000000000000000000335555555555555544444444444444330000000000000000
3333b3333110111111111111cccccccccccc1ccbbbbbbbbb00700000000000000000000000000000333355555555555544444444444433330000000000000000
3b3333333311111111101111ccccccccccccccbbbb3bbbbb00700000007070700000000000000000333333335555555544444444333333330000000000000000
555555555331111111111111ccccc1ccc1cccbb44444444400707070007777700000000000000000333333333333355544433333333333330000000000000000
444444445533111100111111cc11ccccccccbb449999999900777770007666700000000000000000333333333333333333333333333333330000000000000000
444444444553331111111101ccccccccccbbb4499999999970766670077666700000000000000000333333333333333333333333333333330000000000000000
444444244455533111111111cccccccccbb444999999995907766670007777700000000000000000333333333333333333333333333333330000000000000000
424444444444553333311111cccccbbbbb4499999999999900777770000777000000000000000000333333333333333333333333333333330000000000000000
444444444444455555333331cbbbbb44444999999999999900077700000000000000000000000000333333333333333333333333333333330000000000000000
444444440000000045555553b4444449000000009999999900000000000000000000000000000000000000000000000000000000000000000000000000000000
44444444000000004444445544999999000000009599999900000000000000000000000000000000000000000000000000000000000000000000000000000000
44444444000000004424444499999999000000009999999900000000000000000000000000000000000000000000000000000000000000000000000000000000
44244444000000004444444499999959000000009999999900000000000000000000000000000000000000000000000000000000000000000000000000000000
44444424000000004444444499999999000000009999995900000000000000000000000000000000000000000000000000000000000000000000000000000000
44444444000000004444444499599999000000009999999900000000000000000000000000000000000000000000000000000000000000000000000000000000
44444444000000004444244499999999000000009999999900000000000000000000000000000000000000000000000000000000000000000000000000000000
44444444000000004444444499999999000000009999999900000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000111111111111cccccccccccc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000111111111111111ccccccccccccccc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000001111111111d11111cccccccccccccccc0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000001111111111111111cccc1ccccccccccc0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000001111111111111111cccccccccccccccc0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000001111111111111555444ccccccccccccc0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000511111111111d5554446cccccccccc1c0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000111111115111d5554446ccccccccc1cc0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000111111111111d5554446cccccccccccc0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000011d11111111155554444cccccccccccc0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000011111111111155054144cccdcccccccc0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000011111111111150054114ccccccccc6cc0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000011111111111155554444cccccccccccc0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000010011111111155554444cccccccccccc0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000111111111101d5554446cccccccccccc0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000111111111111d5554446cccccccccccc0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000009999999999999999000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000009999999999999999000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000009999999999999999000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000009999999999999999000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000009999999999999999000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000009999999999999999000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000009999999999999999000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000009999999999999999000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__gff__
0002020202000000000000000000000002000000020000000000000000000000020000000200000000000000000000000200000200000000000000000000000002000000000200000000000000000000020000000002000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000020200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0000000000000000000000000000001a1d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000b0c000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000001a1b1c1d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000002a2b2c2d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000003a3b3c3d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000004a4b4c4d0000000000000000000000000000000000000000000000000000000061626364000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000333423240000000000000000000000000000000000000000000000000000000071727374000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000030414100000000000000000000000000000000000000000000000000000000082828383000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000020414100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000020320100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000030210200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
4040404040404040404040404040414243444545454545454545454545454545000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5050505050505050505050505050505253555555555555555555555555555555000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5050505050505050505050505050505055555555555555555555555555555555000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5050505050505050505050505050505055555555555555555555555555555555000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5050505050505050505050505050505055555555555555555555555555555555000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5050505050505050505050505050505055555555555555555555555555555555000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
