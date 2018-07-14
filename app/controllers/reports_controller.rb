# XGH
class ReportsController < ApplicationController


  def top10
  	@result = ActiveRecord::Base.connection.execute("select
  		c.name, count(*) as total
  		 from customers
  		c inner join schedules s on s.customer_id = c.id
  		where s.business_id = #{current_business.id}
  		group by c.id
  		 order by total desc limit 10")
  end

  def top10LavaJatos
	@result = ActiveRecord::Base.connection.execute("select
		b.name, count(*) as total
		 from businesses
		b inner join schedules s on s.business_id = b.id
		group by b.id
		 order by total desc limit 10")
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

  def send_notification
    email = params[:email_cliente]
    NotificationMailer.notification(email).deliver_now
    flash.now[:alert] = 'Email enviado com sucesso!'

    redirect_back(fallback_location: reports_cliente_path)

  end


  def cancelados
    @schedules = Schedule.where(deletado: 1)
  end

end
