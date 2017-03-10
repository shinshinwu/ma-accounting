class DatatableSubmissions
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
    submissions = []
    records.map do |record|
      submission = []
      submission << student_link(record)
      submission << unit_link(record)
      submission << module_link(record)
      submission << assignment_link(record)
      submission << record.created_at.in_time_zone.to_date.to_s
      submission << return_reviewed_date(record)
      submission << review_status(record)
      submissions << submission
    end
    submissions
  end

  def student_link(record)
    @view.link_to "#{record.user.name}",
    {
      :controller => "users/users",
      :action => "profile",
      :user_id => record.user.id,
      format: :html
    }, class: "link-text"
  end

  def unit_link(record)
    @view.link_to "#{record.course_module.unit.sort_order}",
    {
      :controller => "units",
      :action     => "index",
      :id         => record.course_module.unit.id
    }, class: "link-text"
  end

  def module_link(record)
    @view.link_to "#{record.course_module.unit.sort_order}",
    {
      :controller => "course_modules",
      :action     => "show",
      :id         => record.course_module.id
    }, class: "link-text"
  end

  def assignment_link(record)
    @view.link_to "#{record.course_module.unit.sort_order}",
    {
      :controller => "course_modules",
      :action     => "show",
      :anchor     => "assignment#{record.course_assignment.id}",
      :id         => record.course_module.id
    }, class: "link-text"
  end

  def review_status(record)
    if record.reviewed?
     @view.link_to record.status,
      {
        :controller  => "course_submissions",
        :action       => "show",
        :slug         => record.slug
      }, class: "link-text"
   else
     @view.link_to 'Review',
      {
        :controller => "course_submissions",
        :action      => "show",
        :slug        => record.slug
      }, class: "btn btn-success"
   end
  end

  def return_reviewed_date(record)
    record.reviewed? ? record.reviewed_on.to_date.to_s : 'N/A'
  end

  def records
    @records ||= fetch_records
  end

  def fetch_records
    @query
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

end
