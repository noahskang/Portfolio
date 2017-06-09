

def my_min(list)
  smallest = list[0]
  list.each do |el|
    smallest = el if el < smallest
  end
  smallest
end

my_min([ 0, 3, 5, 4, -5, 10, 1, 90 ])

def largest_contiguous_subsum(list)
  accumulator = 0

  sub_arrays = get_sub_arrays(list)
  sums = [0]

  sub_arrays.each do |array|
    if array.reduce(:+) > sums[0]
      sums = []
      sums << array.reduce(:+)
    end
  end
  sums

end

def get_sub_arrays(list)
  sub_arrays = []

  list.each_index do |i|
    list.each_index do |j|
      j+=1 until j >= i
      sub_arrays << list[i..j]
    end
  end

  sub_arrays
end

list = [2, 3, -6, 7, -6, 7]
p largest_contiguous_subsum(list)


def largest_contiguous_subsum_phase2(list)
  accumulator = 0

  sub_arrays = get_sub_arrays(list)
  sums = [0]

  sub_arrays.each do |array|
    if array.reduce(:+) > sums[0]
      sums = []
      sums << array.reduce(:+)
    end
  end
  sums

end

def sub_arrays_phase(list)
  sums = [list[0]]
  list.each_index do |i|

    sums << list[i]
  end
  sums.reduce(:+)
end
list = [2, 3, -6, 7, -6, 7]


def sub_arays_phase3(list)
  sum = []
  current_index = 0
  list.each_index do |idx|
    next if i == 1

    if (sums.reduce(:+) + list[i]) > sums.reduce(:+) && list[idx+1] + (sums.reduce(:+) + list[i]) < (sums.reduce(:+) + list[i])
      sum << list[idx]
    end
  end
  sum
end
