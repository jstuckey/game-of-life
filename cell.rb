class Cell
  def initialize(alive = false)
    @alive = alive
  end

  def determine_next_generation(neighbors)
    alive_neighbor_count = neighbors.select { |cell| cell.alive? }.size

    if alive_neighbor_count == 2
      remain!
    elsif alive_neighbor_count == 3
      live!
    else
      die!
    end
  end

  def begin_next_generation
    @alive = @alive_next_generation
  end

  def alive?
    @alive
  end

  def display
    print alive? ? 1 : 0
  end

  private

  def remain!
    @alive_next_generation = @alive
  end

  def die!
    @alive_next_generation = false
  end

  def live!
    @alive_next_generation = true
  end
end
