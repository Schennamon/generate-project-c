require 'fileutils'

def gen_struct(arg1, arg2)
  FileUtils.mkdir_p arg1

  file_c = File.new(arg1.to_s + "/" + arg2.to_s + ".c", "a:UTF-8")
  file_h = File.new(arg1.to_s + "/lib.h", "a:UTF-8")
  file_makefile = File.new(arg1.to_s + "/" + "Makefile", "a:UTF-8")

  file_makefile.print("build: " + arg2.to_s + ".c\n" +
    "\tgcc -o " + arg2 + ".o " + arg2 + ".c\n\n" +
    "run:\n" +
    "\t./" + arg2 + ".o\n\n" +
    "clean:\n" +
    "\trm *.o")
    
  file_makefile.close
end

if ARGV[0] && ARGV[1] != nil
  gen_struct(ARGV[0], ARGV[1])

  system("sublime-text.subl " + ARGV[0].to_s + "/" + "lib.h " + ARGV[0].to_s + "/" + ARGV[1] + ".c")

elsif ARGV[0] != nil
  gen_struct(ARGV[0], ARGV[0])

  system("sublime-text.subl " + ARGV[0].to_s + "/" + "lib.h " + ARGV[0].to_s + "/" + ARGV[0] + ".c")

elsif ARGV[0] == nil
  puts "expected argument: ruby generate.rb [arg]"
end
