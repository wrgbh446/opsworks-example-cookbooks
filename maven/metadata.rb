# metadata.rb
#

maintainer       "wrgbh446"
maintainer_email "wrgbh446@gmail.com"
license          "MIT"
description      "Installs Maven"
version          "1.0.0"

# I'll add more!
%w{ ubuntu debian }.each do |os|
    supports os
end
