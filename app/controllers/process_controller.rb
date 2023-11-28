class ProcessController < ApplicationController
  def run
    puts "running code"
    RunProcessJob.perform_async(params[:code])
    redirect_back fallback_location: :root
  end
end
