puts "longest palindromic subsequence"

def longest_palindromic_subsequence(str, first = 0, last = str.length - 1)
  return str[first] if first == last
  return "" if first > last
  if str[first] == str[last]
    str[first] + longest_palindromic_subsequence(str, first + 1, last - 1) + str[last]
  else
    without_last = longest_palindromic_subsequence(str, first, last - 1)
    without_first = longest_palindromic_subsequence(str, first + 1, last)
    if without_first.length > without_last.length
      without_first
    else
      without_last
    end
  end
end

p longest_palindromic_subsequence "cddpd"

def longest_palindromic_subsequence(str, first = 0, last = str.length - 1)
  dp = str.length.times.collect { [0] * str.length }
  0.upto(str.length - 1) do |idx|
    dp[idx][idx] = 1
  end
  2.upto(str.length) do |len|
    0.upto(str.length - len) do |first|
      last = first + len - 1
      dp[first][last] = if str[first] == str[last]
                          2 + dp[first + 1][last - 1]
                        else
                          [dp[first + 1][last], dp[first][last - 1]].max
                        end
    end
  end
  first, last = 0, str.length - 1
  prefix, suffix = "", ""
  while first <= last
    if str[first] == str[last]
      prefix << str[first]
      suffix = str[last] + suffix if last > first
      first += 1
      last -= 1
    elsif dp[first + 1][last] > dp[first][last - 1]
      first += 1
    else
      last -= 1
    end
  end
  prefix + suffix
end

p longest_palindromic_subsequence "cddpd"

puts "longest palindromic string"

def longest_palindromic_substring(str, first = 0, last = str.length - 1)
  return '' if first > last
  return str[first] if first == last
  if str[first] == str[last] && longest_palindromic_substring(str, first + 1, last - 1).length == last - first - 1
    return str[first..last] 
  else
    without_first = longest_palindromic_substring(str, first + 1, last)
    without_last = longest_palindromic_substring(str, first, last - 1)
    without_first.length > without_last.length ? without_first : without_last
  end
end

p longest_palindromic_substring("abdbca")
p longest_palindromic_substring("cddpd")
p longest_palindromic_substring("pqr")

def longest_palindromic_substring(str)
  dp = str.length.times.collect { [-1] * str.length }
  0.upto(str.length - 1) do |idx|
    dp[idx][idx] = 1
  end
  2.upto(str.length) do |len|
    0.upto(str.length - len) do |first|
      last = first + len - 1
      dp[first][last] = if str[first] == str[last] && dp[first + 1][last - 1] == last - first - 1
                          last - first + 1
                        else
                          [dp[first + 1][last], dp[first][last - 1]].max
                        end
    end
  end
  first, last = 0, str.length - 1
  while dp[first][last] != last - first + 1
    if dp[first + 1][last] > dp[first][last - 1]
      first += 1
    else
      last -= 1
    end
  end
  str[first..last]
end

p longest_palindromic_substring("abdbca")
p longest_palindromic_substring("cddpd")
p longest_palindromic_substring("pqr")

puts "count of palindromic substrings"
def count_palindromic_substrings(str, first = 0, last = str.length - 1, count = 0)

end


def count_palindromic_substrings(str, first = 0, last = str.length - 1, count = 0)
  dp = str.length.times.collect { [false] * str.length }
  count = 0
  1.upto(str.length) do |len|
    0.upto(str.length - len) do |first|
      last = first + len - 1
      if str[first] == str[last] && (first + 1 >= last - 1 || dp[first + 1][last - 1])
        dp[first][last] = true
        count += 1
      end
    end
  end
  count
end

p count_palindromic_substrings("abdbca")
p count_palindromic_substrings("cddpd")
p count_palindromic_substrings("pqr")
p count_palindromic_substrings("qqq")


puts "minimum deletions to make palindrome"

def min_deletions(str, first = 0, last = str.length - 1)
  return 0 if first == last
  return 1.0 / 0 if first > last
  if str[first] == str[last]
    min_deletions(str, first + 1, last - 1)
  else
    [1 + min_deletions(str, first + 1, last),
     1 + min_deletions(str, first, last - 1)].min
  end
end
p min_deletions("abdbca")
p min_deletions("cddpd")
p min_deletions("pqr")

def min_deletions(str)
  dp = str.length.times.collect { [ 1.0 / 0] * str.length }
  1.upto(str.length) do |len|
    0.upto(str.length - len) do |first|
      last = first + len - 1
      dp[first][last] = if str[first] == str[last] && first >= last - 1
                          0
                        elsif str[first] == str[last]
                          dp[first + 1][last - 1]
                        else
                          1 + [dp[first + 1][last], dp[first][last - 1]].min
                        end
    end
  end
  dp[0][str.length - 1]
end
p min_deletions("abdbca")
p min_deletions("cddpd")
p min_deletions("pqr")


puts "Palindromic partitioning"

def min_cuts(str, first = 0, last = str.length - 1)
  return  0 if first >= last
  if str[first] == str[last] && min_cuts(str, first + 1, last - 1) == 0
    0
  else
    1 + [min_cuts(str, first + 1, last), min_cuts(str, first, last - 1)].min
  end
end

p min_cuts("abdbca")
p min_cuts("cddpd")
p min_cuts("pqr")
p min_cuts("pp")

def min_cuts(str)
  dp = str.length.times.collect { [0] * str.length }
  2.upto(str.length) do |len|
    0.upto(str.length - len) do |first|
      last = first + len - 1
      next if str[first] == str[last] && dp[first + 1][last - 1].zero?
      dp[first][last] = 1 + [dp[first + 1][last], dp[first][last - 1]].min
    end
  end
  dp[0][str.length - 1]
end

p min_cuts("abdbca")
p min_cuts("cddpd")
p min_cuts("pqr")
p min_cuts("pp")
p min_cuts("madam")

# Santa Calara Behaviour Health
# 408 851 4890

# 50,000 stock options

# 73 million shares
# 0.07 %

# 2016 - 15million
# 2017 - 50million
# 2018 - 100million
# 2019 - 170million
