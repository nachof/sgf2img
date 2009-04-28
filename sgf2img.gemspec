Gem::Specification.new do |s|
  s.name = 'sgf2img'
  s.version = '0.0.1'
  s.summary = %{Create an image from an SGF file. Useful for tsumego SGFs.}
  s.date = %q{2009-04-28}
  s.author = "Nacho Facello"
  s.email = "nacho@nucleartesuji.com"
 
  s.specification_version = 2 if s.respond_to? :specification_version=
 
  s.files = [
              "bin/sgf2img",
              "lib/sgf2img/bottom_left.gif",
              "lib/sgf2img/center_center.gif",
              "lib/sgf2img/top_right.gif",
              "lib/sgf2img/bottom_right.gif",
              "lib/sgf2img/center_left.gif",
              "lib/sgf2img/top_left.gif",
              "lib/sgf2img/top_center.gif",
              "lib/sgf2img/sgf.rb",
              "lib/sgf2img/center_right.gif",
              "lib/sgf2img/bottom_center.gif",
              "lib/sgf2img/black.gif",
              "lib/sgf2img/white.gif",
              "lib/sgf2img/image_creator.rb",
              "lib/sgf2img.rb",
              "LICENSE"]
 
  s.require_paths = ['lib']
 
  s.bindir = "bin"
  s.executables = "sgf2img"
 
  s.has_rdoc = false

end
