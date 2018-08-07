Pod::Spec.new do |s| 
s.name = "HitEnlarged" 
s.version = "1.0"
s.summary = "扩大响应区域" 
s.description = "扩大响应区域，更方便的适应点击" 
s.homepage = "https://github.com/yinjining/hitEnlarged" 
s.license = { :type => 'MIT', :file => 'LICENSE' } 
s.author = { 'yinjining' => '921652053@qq.com' } 
s.ios.deployment_target = '9.0' 
s.source = { :git => "https://github.com/yinjining/hitEnlarged.git", :tag => "v#{s.version}" } 
s.source_files = 'HitEnlarged/HitEnlarged/*/*'
s.requires_arc = true 
s.framework = 'UIKit' 
end
