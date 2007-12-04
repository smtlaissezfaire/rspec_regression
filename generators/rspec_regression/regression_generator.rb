require 'rbconfig'

class RspecRegressionGenerator < Rails::Generator::NamedBase
  DEFAULT_SHEBANG = File.join(Config::CONFIG['bindir'],
                              Config::CONFIG['ruby_install_name'])


  def todays_date
    Time.now.strftime("%Y-%m-%d")
  end

  def behaviour_type
    @args.first || ""
  end
  
  def regression_name
    self.name.underscore.split("_").join(" ")
  end

  
  def banner
    "Usage: #{$0} generate RegressionName [regression_type]"
  end

  def manifest
    record do |m|
      @todays_date = 
      
      script_options = {
        :chmod => 0755, 
        :shebang => options[:shebang] == DEFAULT_SHEBANG ? nil : options[:shebang] 
      }

      m.directory 'db'
      m.template  'template.erb',                "spec/regressions/#{todays_date}_#{file_path}.rb"
    end
  end

end
