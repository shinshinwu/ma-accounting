class DatatableStudents
  delegate :params, to: :@view

  def initialize(view, config = {})
    @view     = view
    @columns  = config[:columns]
    @query    = config[:datatable_query]
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      aaData: data,
      iTotalRecords: records_count,
      iTotalDisplayRecords: records_count
    }
  end

  def data
    student_records = [ ]
    records.map do |s|
      student = []
      student << s.id
      student << student_link(s)
      student << s.email
      student << (s.is_active? ? "Active" : "Inactive")
      student << s.created_at.in_time_zone.to_date.to_s
      student << (s.is_active? ? s.activated_at.in_time_zone.to_date.to_s : "N/A")
      student << (s.is_active? ? "Module #{s.current_module.sort_order}" : "N/A")
      student << toggle_activation_link(s)
      student_records << student
    end
    student_records
  end

  def records
    @records ||= fetch_records
  end

  def fetch_records
    @query.order("#{sort_column} #{sort_direction}")
  end

  def records_count
    records.size
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    if( params[:iDisplayLength].to_i == -1 )
      "ALL"
    else
      params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
    end
  end

  def sort_column
    @columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end

  def student_link(record)
    @view.link_to "#{record.name}",
    {
      :controller => "users/users",
      :action => "profile",
      :user_id => record.id,
      format: :html
    }, class: "link-text"
  end

  # TODO: this for some reason keep trying to nest the controller under admin namespace
  # def module_link(mod)
  #   @view.link_to "Module #{mod.unit.sort_order}",
  #   {
  #     :controller => "course_modules",
  #     :action     => "show",
  #     :id         => mod.id
  #   }, class: "link-text"
  # end

  def toggle_activation_link(record)
    if record.is_active?
      text = "Deactivate"
      color = "danger"
    else
      text = "Activate"
      color = "success"
    end

    @view.link_to "#{text}",
    {
      controller: "users/users",
      action:     "toggle_activation",
      user_id:    record.id
    }, method: :put,
    class: "btn btn-#{color}"
  end
end
