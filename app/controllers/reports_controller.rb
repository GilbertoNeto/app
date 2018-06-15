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
end
