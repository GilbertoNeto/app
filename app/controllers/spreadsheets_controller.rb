class SpreadsheetsController < ApplicationController
  before_action :authenticate_business!


  def spreadsheet
    @result = ActiveRecord::Base.connection.execute("select
      c.name, count(*) as total
       from customers
      c inner join schedules s on s.customer_id = c.id
      where s.business_id = #{current_business.id}
      group by c.id
       order by total limit 10")

       respond_to do |format|
          format.html
          format.xlsx {
            response.headers['Content-Disposition'] = 'attachment; filename="top10.xlsx"'
          }
      end

  end


  def spreadsheetLavaJato
    @result = ActiveRecord::Base.connection.execute("select
  		b.name, count(*) as total
  		 from businesses
  		b inner join schedules s on s.business_id = b.id
  		where s.business_id = #{current_business.id}
  		group by b.id
  		 order by total limit 10")

       respond_to do |format|
          format.html
          format.xlsx {
            response.headers['Content-Disposition'] = 'attachment; filename="top10_lavajato.xlsx"'
          }
      end
  end

  def spreadsheetLucro
      @result = ActiveRecord::Base.connection.execute("select
        se.name, se.price, s.date, sum(se.price) as total from schedules s
        inner join schedule_services ss on s.id = ss.schedule_id
        inner join services se on ss.service_id = se.id
        where s.business_id = #{current_business.id}"
        )

        respond_to do |format|
           format.html
           format.xlsx {
             response.headers['Content-Disposition'] = 'attachment; filename="lucroMensal.xlsx"'
           }
        end
  end

  def spreadsheetClientes
      @result = ActiveRecord::Base.connection.execute("select
        c.name as name, c.email as email from customers
        c inner join schedules s on s.customer_id = c.id
        where s.business_id = #{current_business.id}
        group by c.id")

        respond_to do |format|
           format.html
           format.xlsx {
             response.headers['Content-Disposition'] = 'attachment; filename="Clientes.xlsx"'
           }
        end
  end

end
