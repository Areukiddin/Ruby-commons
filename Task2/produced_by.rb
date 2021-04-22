module ProducedBy
  def company_name(name)
    @company_name = name
  end

  def produced_by
    "This #{self.class.to_s.downcase} produced by #{@company_name} inc."
  end
end
