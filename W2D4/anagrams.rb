require 'byebug'

def first_anagram?(string1, string2)
  permutations(string1).include?(string2)
end

def permutations(string)
  return [string] if string.size < 2

  last_char = string[-1]
  old_perms = permutations(string[0...-1])
  new_perms = []

  old_perms.each do |ele|
    j = 0
    while j <= ele.size
      new_perms << ele[0...j] + last_char + ele[j..-1]
      j+=1
    end
  end
  new_perms
end

# p first_anagram?("gizmo", "sally")    #=> false
# p first_anagram?("elvis", "lives")

def second_anagram?(string1, string2)
  # debugger
  i = 0

  string1.chars.each_with_index do |char, i|
    string2.size.times do |j|
      if char == string2[j]
        i-=string1.size+1
        string2.slice!(j)
        string1.slice!(i)
      end
    end

  end
  p string1
  p string2.empty?
end

# p second_anagram?("gizmo", "sally")    #=> false

def third_anagram?(string1, string2)
  sorted_string1 = string1.split("").sort
  sorted_string2 = string2.split("").sort

  sorted_string2.join("") == sorted_string1.join("")
end

# p third_anagram?("elvis", "lives")

def fourth_anagram?(string1, string2)
  first_strings = Hash.new(0)

  string1.chars{|char|first_strings[char] += 1}

  string2.chars{|char|first_strings[char] -= 1}

  return false if first_strings.values.any?{|v| v != 0}
  true
end

p fourth_anagram?("elvis", "lives")
p fourth_anagram?("aa", "bb")
