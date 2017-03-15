#
# Be sure to run `pod lib lint GASSwiftExtensions.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'GASSwiftExtensions'
  s.version          = '0.1.0'
  s.summary          = 'GASSwiftExtensions are extensions over some classes and libs.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'GASSwiftExtensions are extensions over some classes and libs.'

  s.homepage         = 'https://github.com/sol88/GASSwiftExtensions'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'sol88' => 'viczaikin@gmail.com' }
  s.source           = { :git => 'https://github.com/sol88/GASSwiftExtensions.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'GASSwiftExtensions/Sources/*.swift'

  # s.public_header_files = 'Pod/Sources/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
