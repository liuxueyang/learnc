#!/usr/bin/ruby 

puts "\033[1mForeground Colors...\033[0m\n"  
puts "   \033[30mBlack (30)\033[0m\n"  
puts "   \033[31mRed (31)\033[0m\n"  
puts "   \033[32mGreen (32)\033[0m\n"  
puts "   \033[33mYellow (33)\033[0m\n"  
puts "   \033[34mBlue (34)\033[0m\n"  
puts "   \033[35mMagenta (35)\033[0m\n"  
puts "   \033[36mCyan (36)\033[0m\n"  
puts "   \033[37mWhite (37)\033[0m\n"  
puts ''  
  
puts "\033[1mBackground Colors...\033[0m\n"  
puts "   \033[40m\033[37mBlack (40), White Text\033[0m\n"  
puts "   \033[41mRed (41)\033[0m\n"  
puts "   \033[42mGreen (42)\033[0m\n"  
puts "   \033[43mYellow (43)\033[0m\n"  
puts "   \033[44mBlue (44)\033[0m\n"  
puts "   \033[45mMagenta (45)\033[0m\n"  
puts "   \033[46mCyan (46)\033[0m\n"  
puts "   \033[47mWhite (47)\033[0m\n"  

puts ''  
puts "\033[1mModifiers...\033[0m\n"  
puts "   Reset (0)"  
puts "   \033[1mBold (1)\033[0m\n"  
puts "   \033[4mUnderlined (4)\033[0m\n"  

printf("\033[31m%d\033[0m\n", 1024)
