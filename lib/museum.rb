class Museum
  attr_reader :name, :exhibits, :patrons, :revenue

  def initialize(name)
    @name = name
    @exhibits = []
    @patrons = []
    @revenue = 0
  end

  def add_exhibit(exhibit)
    @exhibits << exhibit
  end

  def recommend_exhibits(patron)
    @exhibits.find_all { |exhibit| patron.interests.include?(exhibit.name) }
  end

  def admit(patron)
    @patrons << patron
    to_do_list = recommend_exhibits(patron).sort_by { |exhibit| exhibit.cost }
    to_do_list.reverse.each do |exhibit|
      next if patron.spending_money < exhibit.cost
  # I have tried every possible way to write this next conditional that I can think of and it won't continue the iteration
      patron.spending_money -= exhibit.cost
      @revenue += exhibit.cost
    end
  end

  def patrons_interested_in_exhibit(exhibit)
    patrons_interested = []
    @patrons.each do |patron|
      patrons_interested << patron if patron.interests.include?(exhibit.name)
    end
    patrons_interested
  end

  def patrons_by_exhibit_interest
    exhibits_and_patrons = {}
    @exhibits.each do |exhibit|
      exhibits_and_patrons[exhibit] = patrons_interested_in_exhibit(exhibit)
    end
    exhibits_and_patrons
  end
end
