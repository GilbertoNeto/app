# XGH
class ReportsController < ApplicationController
  before_action :authenticate_business!
  def top10
  	@result = ActiveRecord::Base.connection.execute("select
  		c.name, count(*) as total
  		 from customers
  		c inner join schedules s on s.customer_id = c.id
  		where s.business_id = #{current_business.id}
  		group by c.id
  		 order by total limit 10")
  end

  def lucro
  	if params[:ano] and params[:mes]
	 	ano = ActiveRecord::Base.connection.quote(params[:ano])
	 	mes = ActiveRecord::Base.connection.quote(params[:mes])

	  	@result = ActiveRecord::Base.connection.execute("select
	  		sum(se.price) as total from schedules s
	  		inner join schedule_services ss on s.id = ss.schedule_id
	  		inner join services se on ss.service_id = se.id
	  		where s.business_id = #{current_business.id} and strftime(\"%Y\", date) = #{ano} and strftime(\"%m\", date) = #{mes}"
	  		)
    end
  end

  def cliente
    @result = ActiveRecord::Base.connection.execute("select
  		c.name as name, c.email as email from customers
  		c inner join schedules s on s.customer_id = c.id
  		where s.business_id = #{current_business.id}
  		group by c.id")
  end

end
