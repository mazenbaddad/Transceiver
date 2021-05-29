
Pod::Spec.new do |spec|

spec.name                   = "Transceiver"
spec.version                = "1.0.0"
spec.summary                = "Many-to-Many Communication Using Protocol in Swift"
spec.description            = "Many-to-Many Communication Using Protocol in Swift , A Replacement for apple NotificationCenter"

spec.homepage               = "https://github.com/mazenbaddad/Transceiver"
spec.license                = { :type => "MIT", :file => "LICENSE" }
spec.author                 = { "mazenbaddad" => "mazenbaddad@hotmail.com" }
spec.social_media_url       = "https://twitter.com/mazenbaddad"

spec.swift_version          = "5.0"
spec.ios.deployment_target  = "9.0"
spec.osx.deployment_target  = "10.15"

spec.source                 = { :git => "https://github.com/mazenbaddad/Transceiver.git", :tag => spec.version.to_s }
spec.source_files           = "Source/*.{swift}"
spec.frameworks             = "Foundation"

end
