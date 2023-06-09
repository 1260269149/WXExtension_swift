
Pod::Spec.new do |spec|

  spec.name         = "wxExtension_swift"
  spec.version      = "0.0.1"
  spec.summary      = "wxExtension_swift"
  spec.description  = "wxExtension, 给系统类提供扩展"
  spec.homepage     = "https://github.com/1260269149/WXExtension_swift"
  spec.license      = "MIT"
  spec.author       = { "wangxu" => "1260269149@qq.com" }
  spec.source       = { :git => "https://github.com/1260269149/WXExtension_swift.git", :tag => "#{spec.version}" }
  spec.source_files  = "Classes", "Classes/**/*.{h,m,swift}"
  spec.exclude_files = "Classes/Exclude"
end
