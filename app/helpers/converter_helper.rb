module ConverterHelper

  def pdf_ready?(file_name)
    File.exist?("#{Rails.root}/public/readys"+ "#{file_name}+.pdf")
  end

end
