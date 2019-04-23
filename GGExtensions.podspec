Pod::Spec.new do |spec|
  spec.name         = "GGExtensions"
  spec.version      = "0.0.1"
  spec.summary      = "方便iOS开发的Swift扩展库"
  spec.description  = <<-DESC
                      方便iOS开发的Swift扩展库
                      AppVersion iOS版本类
                      GGExtensions  一些扩展库
                      DESC

  spec.homepage     = "https://github.com/GG-A/GGExtensions"
  spec.license      = "MIT"
  spec.author             = { "GG-A" => "yiyikela@qq.com" }


  spec.platform     = :ios, "9.0"

  #  When using multiple platforms
  # spec.ios.deployment_target = "9.0"
  # spec.osx.deployment_target = "10.7"
  # spec.watchos.deployment_target = "2.0"
  # spec.tvos.deployment_target = "9.0"


  spec.source       = { :git => "https://github.com/GG-A/GGExtensions.git", :tag => "#{spec.version}" }

  spec.source_files  = "GGExtensions/**/*.swift"
  spec.swift_version = '5.0'

  spec.requires_arc = true


  # spec.resource  = "icon.png"
  # spec.resources = "Resources/*.png"

  # spec.preserve_paths = "FilesToSave", "MoreFilesToSave"


  # spec.framework  = "SomeFramework"
  # spec.frameworks = "SomeFramework", "AnotherFramework"

  # spec.library   = "iconv"
  # spec.libraries = "iconv", "xml2"

  # spec.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # spec.dependency "JSONKit", "~> 1.4"

end
