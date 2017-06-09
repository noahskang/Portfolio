def bad_two_sum?(array, target_sum)  # QUADRATIC O(n^2)
  array.each_with_index do |num, idx|
    j = idx + 1
    while j < array.size
      return true if num + array[j] == target_sum
      j += 1
    end
  end
  false
end


bad_two_sum?([0, 1, 5, 7], 6)

def okay_two_sum?(array, target_sum)

  array.each do |num|
    return true if binary_search(array, target_sum-num)
  end

  false
end

def binary_search(array, target)
  return array.first == target if array.count < 2

  midpoint = array.count / 2

  case array[midpoint] <=> target
  when 1
    binary_search(array.take(midpoint), target)
  when 0
    return true
  when -1
    binary_search(array.drop(midpoint), target)
  end
  false
end


def hash_two_sum?(array, target)
  two_sum_hash = Hash.new()
  array.each do |num|

    return true if two_sum_hash[target - num]
    two_sum_hash[num] = num
  end
  false
end

p hash_two_sum?([0, 1, 5, 7], 1)
