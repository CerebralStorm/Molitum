module JobsHelper

	def remember_job(job)
		session[:job_token] = job.id
	end

	def current_job
		session[:job_token]
	end

end
