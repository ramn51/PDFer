class ConverterController < ApplicationController

  STORAGE_PATH = Rails.root.join('public', 'uploads')
  DOWNLOAD_PATH = Rails.root.join('public', 'readys')
  PDF_DELETE_BASE_TIME = 10 # 10 min

  rescue_from ActionController::MissingFile, with: :error_render_method
  rescue_from ActionController::ParameterMissing do |exception|
    render json: { error: exception.message }, status: :bad_request
  end

  def index
    render 'index'
  end

  def convert
    # avoid NoMethodError and auto abort
    file_data = params.try(:[], :conversion).try(:[], :file)
    if file_data.nil?
      flash[:error] = 'Conversion failed'
      return respond_to do |format|
        format.html { render file: 'public/400.html' }
        format.json { render json: 'Error in processing', status: :unprocessable_entity }
      end
    end

    # validate for pdf file uploaded
    return error_render_method(400) unless file_data.content_type != 'application/pdf'

    if file_data.respond_to?(:read)
      File.open(Rails.root.join('public', 'uploads', file_data.original_filename), 'wb') do |file|
        file.write(file_data.read)
      end

      files = Dir.glob("#{Rails.root}/public/uploads/*")
      file_to_convert = files.find { |x| x[file_data.original_filename] }

      # remove extension of the file from name and set location and path for download
      dest_file, dest_file_name = make_dest_file file_data

      begin
        Libreconv.convert(file_to_convert, dest_file)
        logger.debug { "File Converted: #{file_data.original_filename}" }

        render action: 'show', locals: { file_name: dest_file_name, time_to_destory: PDF_DELETE_BASE_TIME }
        flash[:notice] = 'Successfully converted'

      rescue => error
        logger.error { "Couldn't not convert file: #{file_data.class.name}: #{file_data.inspect}, ERROR: #{error}" }
        flash.now[:error] = 'Conversion failed'
        # send log report of the error
        send_error_mail Time.now, error

        render file: 'public/500.html'
        # render json: { message: 'File not converted' }, status: :bad_request
      ensure
        file_cleanup file_data.original_filename, 'uploads'
        logger.info { "File cleanup initiated for uploaded doc #{file_data.original_filename}" }
        file_cleanup dest_file_name, 'readys', true
      end

    else
      logger.error { "Bad file_data: #{file_data.class.name}: #{file_data.inspect}" }
      render json: { message: 'file is not readable or it not docx or doc' }, status: :bad_request
    end

  end

  def show
    render 'converter/show'
  end

  def download
    file_name = params[:download_file_name]
    send_file "#{Rails.root}/public/readys/#{file_name}"
  end

  def error_render_method(error_type = 404)
    respond_to do |format|
      format.html { render file: "public/#{error_type}.html" }
      format.json do
        render json: (error_type == 404 ? 'Error in processing' : 'Bad request, content not supported'),
               status: :unprocessable_entity
      end
    end
  end

  private

  def converter_params
    params.require(:conversion).permit(:file_name, :file_type, :download_file_name, file: {})
  end

  def file_cleanup(file_name, directory, later = false)
    path = "#{Rails.root}/public/#{directory}/" + "#{file_name}"
    if later
      UploadsCleanupJob.set(wait_until: Time.now + PDF_DELETE_BASE_TIME.minutes).perform_later path
    else
      UploadsCleanupJob.perform_later path
    end
  end

  def make_dest_file(file_data)
    file_name = file_data.original_filename.split('.docx')
    dest_file_name = file_name[0] + '.pdf'

    ["#{Rails.root}/public/readys/#{dest_file_name}", dest_file_name]
  end

  def send_error_mail(time, error)
    LogMailerJob.perform_now(time, error)
  end

end
