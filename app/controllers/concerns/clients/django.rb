module Django
  def get_json(url, student_ids)
    conn.get url do |f|
      f.params['student_ids'] = student_ids
    end
    JSON.parse(body, symbolize_name: true)
  end

  def conn
    Faraday.new("http://lit-fortress-28598.herokuapp.com") do |f|
      f.adapter Faraday.default_adapter
    end
  end
end
