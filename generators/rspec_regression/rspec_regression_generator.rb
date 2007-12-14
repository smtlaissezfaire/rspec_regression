require 'rbconfig'

class RspecRegressionGenerator < Rails::Generator::NamedBase
  DEFAULT_SHEBANG = File.join(Config::CONFIG['bindir'],
                              Config::CONFIG['ruby_install_name'])


  def now
    @now ||= Time.now
  end

  def todays_date
    @now.strftime("%Y-%m-%d")
  end
  
  def todays_date_underscored
    @now.strftime("%Y_%m-%d")
  end

  def behaviour_type
    @args.first || ""
  end
  
  def regression_name
    self.name.underscore.split("_").join(" ")
  end
  
  def banner
    "Usage: #{$0} rspec_regression RegressionName [regression_type]"
  end

  def manifest
    record do |m|
      @todays_date = 
      
      script_options = {
        :chmod => 0755, 
        :shebang => options[:shebang] == DEFAULT_SHEBANG ? nil : options[:shebang] 
      }

      m.directory 'spec'
      m.directory 'spec/regressions'
      m.template  'template.erb',                "spec/regressions/#{todays_date_underscored}_#{file_path}.rb"
    end
  end

end
