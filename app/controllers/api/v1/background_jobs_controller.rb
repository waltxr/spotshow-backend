class Api::V1::BackgroundJobsController < ApplicationController

  def show
    background_job = BackgroundJob.find(params[:id])
    in_memory_status = ActiveJobStatus.fetch(background_job.job_uid).status
    background_job.update(status: in_memory_status)
    render json: { status: in_memory_status }, status: :ok
  end

end
