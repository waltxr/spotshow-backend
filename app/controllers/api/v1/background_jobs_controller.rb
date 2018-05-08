class Api::V1::BackgroundJobsController < ApplicationController
  skip_before_action :authorized

  def show    
    background_job = BackgroundJob.find(params[:id])
    in_memory_status = ActiveJobStatus.fetch(background_job.job_uid).status.to_s
    background_job.update(status: in_memory_status)
    render json: { status: in_memory_status }
  end

end
