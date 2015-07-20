# Class that calculates the smallest path using
# Dijkstra Algorithm
class Dijkstra
  # constructor of the class
  def initialize(startpoint, endpoint, matrix_of_road)
    # start node
    @start = startpoint

    # end node
    @end = endpoint

    @path = []

    @infinit = 88

    read_and_init(matrix_of_road)

    # Dijkstra's algorithm in action and good luck
    dijkstra
  end

  # This method determines the minimum cost of the shortest path
  def cost
    @r[@end]
  end

  # get the shortest path
  def shortest_path
    road(@end)
    @path
  end

  def road(node)
    road(@f[node]) if @f[node] != 0
    @path.push(node)
  end

  def dijkstra
    start = @start
    min = @infinit
    pos_min = @infinit

    (1..@nodes - 1).each do |i|
      @r[i] = @road[start][i]
      @f[i] = start if i != start && @r[i] < @infinit
    end

    @s[start] = 1

    (1..@nodes - 2).each do
      min = @infinit

      (1..@nodes - 1).each do |i|
        if @s[i] == 0 && @r[i] < min
          min = @r[i]
          pos_min = i
        end
      end

      @s[pos_min] = 1

      (1..@nodes - 1).each do|j|
        if @s[j] == 0
          if @r[j] > @r[pos_min] + @road[pos_min][j]
            @r[j] = @r[pos_min] + @road[pos_min][j]
            @f[j] = pos_min
          end
        end
      end
    end
  end

  def read_and_init(arr)
    @nodes = arr[0][0] + 1

    n = arr.size - 1

    @road = Array.new(@nodes) { Array.new(@nodes) }
    @r = Array.new(@nodes)
    @s = Array.new(@nodes)
    @f = Array.new(@nodes)

    (0..@nodes - 1).each do |i|
      @r[i] = 0
    end

    (0..@nodes - 1).each do |i|
      @s[i] = 0
    end

    (0..@nodes - 1).each do |i|
      @f[i] = 0
    end

    (0..@nodes - 1).each do |i|
      (0..@nodes - 1).each do |j|
        if i == j
          @road[i][j] = 0
        else
          @road[i][j] = @infinit
        end
      end
    end

    (1..n).each do |i|
      x = arr[i][0]
      y = arr[i][1]
      c = arr[i][2]
      @road[x][y] = c
    end
  end

  def write_to_file(filename)
    f = File.open(filename, 'w')
    out = "Cost -> #{@r[@end]}\nShortest Path -> #{@path}"
    f.write(out)
    f.close
  end
end
