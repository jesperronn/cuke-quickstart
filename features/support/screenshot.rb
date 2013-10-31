module ScreenshotHelpers

  def screenshot(name)
    name = calculate_name if name.nil?
    screenshot_dir = ROOT + "test-results/screenshots/"
    page.driver.render("#{screenshot_dir}#{name}.png", :full => true)
    source = page.evaluate_script("document.getElementsByTagName('html')[0].outerHTML") rescue nil
    File.open("#{screenshot_dir}#{name}.html", 'w') {|f| f.write(source) } if source
  end

  def calculate_name
    URI.parse(current_url).path.gsub(%r{/}, "_" )
  end


end

World(ScreenshotHelpers)
