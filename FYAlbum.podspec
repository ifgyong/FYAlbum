
Pod::Spec.new do |s|

  s.name          = "FYAlbum"
  s.version       = "1.0.0"
  s.license       = "MIT"
  s.summary       = "Fast encryption string used on iOS, which implement by Objective-C."
  s.homepage      = "https://github.com/ifgyong/FYAlbum"
  s.author        = { "fgyong" => "fgyong@yeah.net" } 
  s.source        = { :git => "https://github.com/ifgyong/FYAlbum.git", :tag => "1.0.0" }
  s.requires_arc  = true           
   s.source_files  = "FYAlbum/*/*"
   s.platform      = :ios, '8.0'        
   s.framework     = 'Foundation', 'CoreGraphics', 'UIKit'  
                    
end
