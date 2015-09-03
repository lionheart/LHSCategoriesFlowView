Pod::Spec.new do |s|
  s.name         = "LHSCategoriesFlowView"
  s.version      = "0.0.1"
  s.summary      = "A simple view that displays tags in a flow layout."
  s.license      = {
    :type => 'Apache 2.0',
    :file => 'LICENSE' }

  s.homepage     = "http://lionheartsw.com/"

  s.author       = { "Dan Loewenherz" => "dan@lionheartsw.com" }
  s.platform     = :ios, '7.0'
  s.source       = {
    :git => "https://github.com/lionheart/LHSCategoriesFlowView.git",
    :tag => "v#{s.version}"
  }

  s.source_files  = 'LHSCategoriesFlowView/*.{h,m}'
  s.exclude_files = 'Classes/Exclude'

  s.frameworks = 'UIKit', 'Foundation'
  s.requires_arc = true
  s.dependency 'LHSCategoryCollection'
end
