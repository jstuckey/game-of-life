require_relative "cell.rb"

class Board
  attr_reader :height, :width, :cells

  def initialize(seed: nil, size: 10)
    if seed
      @width = seed.size
      @height = seed.size
      @cells = seed.map { |row| row.map { |seed_value| Cell.new(seed_value == 1) } }
    else
      @width = size
      @height = size
      @cells = Array.new(size) { Array.new(size) { Cell.new(random_seed) } }
    end
  end

  def play(generations = 1)
    display
    generations.times do
      determine_next_generation
      begin_next_generation
      display
    end
  end

  def determine_next_generation
    cells.each_with_index do |row, row_index|
      row.each_with_index do |cell, column_index|
        west_cell = row[column_index - 1] if column_index > 0
        east_cell = row[column_index + 1] if column_index < width - 1

        if row_index > 0
          north_west_cell = cells[row_index - 1][column_index - 1] if column_index > 0
          north_cell = cells[row_index - 1][column_index]
          north_east_cell = cells[row_index - 1][column_index + 1] if column_index < width - 1
        end

        if row_index < height - 1
          south_west_cell = cells[row_index + 1][column_index - 1] if column_index > 0
          south_cell = cells[row_index + 1][column_index]
          south_east_cell = cells[row_index + 1][column_index + 1] if column_index < width - 1
        end

        neighbors = [
          north_west_cell, north_cell, north_east_cell,
          west_cell,                   east_cell,
          south_west_cell, south_cell, south_east_cell
        ].compact

        cell.determine_next_generation(neighbors)
      end
    end
  end

  def begin_next_generation
    cells.each { |row| row.each(&:begin_next_generation) }
  end

  def display
    cells.each do |row|
      row.each do |cell|
        cell.display
      end
      puts
    end
    puts "-" * width
  end

  private

  def random_seed
    rand(2) == 1
  end
end
