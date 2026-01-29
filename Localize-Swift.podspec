Pod::Spec.new do |s|
  s.name             = "Localize-Swift"
  s.version          = "3.2.0"
  s.summary          = "Swift-friendly localization and i18n syntax with in-app language switching."
  s.description      = <<-DESC
                      A simple framework that improves localization and i18n in Swift apps with cleaner syntax and in-app language switching.
                     DESC

  s.homepage         = "https://github.com/marmelroy/Localize-Swift"
  s.license          = 'MIT'
  s.author           = { "Roy Marmelstein" => "marmelroy@gmail.com" }
  s.source           = { :git => "https://github.com/marmelroy/Localize-Swift.git", :tag => s.version.to_s, :submodules => true}
  s.social_media_url   = "http://twitter.com/marmelroy"

  s.swift_version = '6.2'
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '6.2' }
  s.requires_arc = true

  s.ios.deployment_target = '9.0'
  s.osx.deployment_target = '10.13'
  s.tvos.deployment_target = '9.0'
  s.watchos.deployment_target = '4.0'

  s.subspec 'LocalizeSwiftCore' do |core|
    core.ios.deployment_target = '9.0'
    core.osx.deployment_target = '10.13'
    core.tvos.deployment_target = '9.0'
    core.watchos.deployment_target = '4.0'
    core.source_files = "Sources/"
  end

  s.subspec 'UIKit' do |ui|
    ui.dependency 'Localize-Swift/LocalizeSwiftCore'
    ui.ios.deployment_target = '9.0'
    ui.tvos.deployment_target = '9.0'
    ui.source_files = 'Sources/UI/IBDesignable+Localize.swift'
  end

  s.subspec 'AppKit' do |appkit|
    appkit.dependency 'Localize-Swift/LocalizeSwiftCore'
    appkit.osx.deployment_target = '10.13'
    appkit.source_files = ['Sources/UI/IBDesignable+Localize+AppKit.swift', 'Sources/UI/AutoI18nable+AppKit.swift']
  end

  s.subspec 'SwiftUI' do |swiftui|
    swiftui.dependency 'Localize-Swift/LocalizeSwiftCore'
    swiftui.ios.deployment_target = '13.0'
    swiftui.osx.deployment_target = '10.15'
    swiftui.tvos.deployment_target = '13.0'
    swiftui.watchos.deployment_target = '6.0'
    swiftui.source_files = 'Sources/UI/AutoI18nable+SwiftUI.swift'
  end

end
