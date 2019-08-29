puts "Longest common substring"

def longest_common_substring(a, b, a_len = a.length, b_len = b.length, count = 0)
  return count if a_len <= 0 || b_len <= 0
  count = longest_common_substring(a, b, a_len - 1, b_len - 1, count + 1) if a[a_len - 1] == b[b_len - 1]
  [count, longest_common_substring(a, b, a_len - 1, b_len), longest_common_substring(a, b, a_len, b_len - 1)].max
end

p longest_common_substring("abdca", "cbda")
p longest_common_substring("passport", "ppsspt")

def longest_common_substring(a, b, a_len = a.length, b_len = b.length, current = "")
  return current if a_len <= 0 || b_len <= 0
  current = longest_common_substring(a, b, a_len - 1, b_len - 1, a[a_len - 1] + current) if a[a_len - 1] == b[b_len - 1]
  without_a = longest_common_substring(a, b, a_len - 1, b_len)
  without_b = longest_common_substring(a, b, a_len, b_len - 1)
  max_len = [current.length, without_a.length, without_b.length].max
  [current, without_a, without_b].find { |x| x.length == max_len }
end

p longest_common_substring("abdca", "cbda")
p longest_common_substring("passport", "ppsspt")

def longest_common_substring(a, b)
  dp = (a.length + 1).times.collect { (b.length + 1).times.collect { 0 } }
  max = 0
  max_start_idx = -1
  1.upto(a.length) do |a_len|
    1.upto(b.length) do |b_len|
      if a[a_len - 1] == b[b_len - 1]
        dp[a_len][b_len] = dp[a_len - 1][b_len - 1] + 1
        if dp[a_len][b_len] > max
          max = dp[a_len][b_len]
          max_start_idx = a_len - max
        end
      end
    end
  end
  max > 0 ? a.slice(max_start_idx, max) : ""
end

def longest_common_substring(a, b)
  a, b = b, a if a.length > b.length
  prev = (b.length + 1).times.collect { 0 }
  current = (b.length + 1).times.collect { 0 }
  max = 0
  max_start_idx = -1
  1.upto(a.length) do |a_len|
    1.upto(b.length) do |b_len|
      if a[a_len - 1] == b[b_len - 1]
        current[b_len] = prev[b_len - 1] + 1
        if current[b_len] > max
          max = current[b_len]
          max_start_idx = a_len - max
        end
      end
    end
    current, prev = prev, current
  end
  max > 0 ? a.slice(max_start_idx, max) : ""
end

p longest_common_substring("abdca", "cbda")
p longest_common_substring("passport", "ppsspt")

puts "longest_common_subsequence"

def longest_common_subsequence(a, b, a_len = a.length, b_len = b.length)
  return 0 if a_len <= 0 || b_len <= 0
  if a[a_len - 1] == b[b_len - 1]
    1 + longest_common_subsequence(a, b, a_len - 1, b_len - 1)
  else
    [longest_common_subsequence(a, b, a_len, b_len - 1), longest_common_subsequence(a, b, a_len - 1, b_len)].max
  end
end

p longest_common_subsequence("abdca", "cbda")
p longest_common_subsequence("passport", "ppsspt")

def longest_common_subsequence(a, b)
  a, b = b, a if a.length > b.length
  prev = [0] * (b.length + 1)
  cur = [0] * (b.length + 1)
  1.upto(a.length) do |a_len|
    1.upto(b.length) do |b_len|
      cur[b_len] = if a[a_len - 1] == b[b_len - 1]
                     1 + prev[b_len - 1]
                   else
                     [cur[b_len - 1], prev[b_len]].max
                   end
    end
    prev, cur = cur, prev
  end
  prev[b.length]
end

def longest_common_subsequence(a, b)
  a, b = b, a if a.length > b.length
  dp = (a.length + 1).times.collect { [0] * (b.length + 1) }
  1.upto(a.length) do |a_len|
    1.upto(b.length) do |b_len|
      dp[a_len][b_len] = if a[a_len - 1] == b[b_len - 1]
                           1 + dp[a_len - 1][b_len - 1]
                         else
                           [dp[a_len][b_len - 1], dp[a_len - 1][b_len]].max
                         end
    end
  end
  a_len, b_len = a.length, b.length
  res = ""
  while a_len > 0 && b_len > 0
    if a[a_len - 1] == b[b_len - 1]
      res = a[a_len - 1] + res
      a_len -= 1
      b_len -= 1
    elsif dp[a_len][b_len - 1] > dp[a_len - 1][b_len]
      b_len -= 1
    else
      a_len -= 1
    end
  end
  res
end

p longest_common_subsequence("abdca", "cbda")
p longest_common_subsequence("passport", "ppsspt")

puts "Min Deletions Insertions"

def min_insertions_deletions_lcs(a, b, a_len = a.length, b_len = b.length)
  return 0 if a_len.zero? || b_len.zero?
  if a[a_len - 1] == b[b_len - 1]
    1 + min_insertions_deletions_lcs(a, b, a_len - 1, b_len - 1)
  else
    [min_insertions_deletions_lcs(a, b, a_len - 1, b_len), min_insertions_deletions_lcs(a, b, a_len, b_len - 1)].max
  end
end

def min_insertions_deletions_lcs(a, b, a_len = a.length, b_len = b.length)
  a, b = b, a if a.length > b.length
  prev = [0] * (b.length + 1)
  cur = [0] * (b.length + 1)
  1.upto(a.length) do |a_len|
    1.upto(b.length) do |b_len|
      cur[b_len] = if a[a_len - 1] == b[b_len - 1]
                     1 + prev[b_len - 1]
                   else
                     [cur[b_len - 1], prev[b_len]].max
                   end
    end
    prev, cur = cur, prev
  end
  prev[b.length]
end

def min_insertions_deletions(a, b)
  len = min_insertions_deletions_lcs(a, b)
  puts "Deletions : #{a.length - len}"
  puts "Additions : #{b.length - len}"
end

p min_insertions_deletions("abc", "fbc")
p min_insertions_deletions("abdca", "cbda")
p min_insertions_deletions("passport", "ppsspt")

puts "longest increasing subsequence"

def longest_increasing_subsequence(nums, len = nums.length, last = 1.0 / 0)
  return 0 if len.zero?
  if nums[len - 1] >= last
    longest_increasing_subsequence(nums, len - 1, last)
  else
    [1 + longest_increasing_subsequence(nums, len - 1, nums[len - 1]), longest_increasing_subsequence(nums, len - 1, last)].max
  end
end

p longest_increasing_subsequence [4, 2, 3, 6, 10, 1, 12]

def longest_increasing_subsequence(nums)
  dp = [1] * nums.length
  max = 1
  0.upto(nums.length - 1) do |idx|
    0.upto(idx - 1) do |other_idx|
      if nums[other_idx] < nums[idx] && 1 + dp[other_idx] > dp[idx]
        dp[idx] = 1 + dp[other_idx]
        max = dp[idx] if dp[idx] > max
      end
    end
  end
  max
end

p longest_increasing_subsequence [4, 2, 3, 6, 10, 1, 12]

puts "maximum_sum_increasing_subsequence"

def maximum_sum_increasing_subsequence(nums, len = nums.length)
  return 0 if len.zero?
  max = nums[len - 1]
  val = nums[len - 1]
  1.upto(len - 1) do |len|
    if nums[len - 1] < val
      current = maximum_sum_increasing_subsequence(nums, len)
      max = current + val if current + val >= max
    end
  end
  [max, maximum_sum_increasing_subsequence(nums, len - 1)].max
end

p maximum_sum_increasing_subsequence [4, 1, 2, 6, 10, 1, 12]
p maximum_sum_increasing_subsequence [-4, 10, 3, 7, 15]
p maximum_sum_increasing_subsequence [-4, 10, 3, 17, -4]

def maximum_sum_increasing_subsequence(nums)
  dp = [0] * (nums.length)
  max = -1.0 / 0
  0.upto(nums.length - 1) do |idx|
    dp[idx] = nums[idx]
    0.upto(idx - 1) do |other_idx|
      if nums[other_idx] < nums[idx] && nums[idx] + dp[other_idx] > dp[idx]
        dp[idx] = nums[idx] + dp[other_idx]
        max = dp[idx] if dp[idx] > max
      end
    end
  end
  max
end

p maximum_sum_increasing_subsequence [4, 1, 2, 6, 10, 1, 12]
p maximum_sum_increasing_subsequence [-4, 10, 3, 7, 15]
p maximum_sum_increasing_subsequence [-4, 10, 3, 17, -4]

puts "Shortest common supersequence"

def shortest_common_supersequence(a, b, a_len = a.length, b_len = b.length)
  return [a_len, b_len].max if a_len.zero? || b_len.zero?
  if a[a_len - 1] == b[b_len - 1]
    1 + shortest_common_supersequence(a, b, a_len - 1, b_len - 1)
  else
    1 + [shortest_common_supersequence(a, b, a_len - 1, b_len), shortest_common_supersequence(a, b, a_len, b_len - 1)].min
  end
end

p shortest_common_supersequence "abcf", "bdcf"
p shortest_common_supersequence("dynamic", "programming")
p shortest_common_supersequence("dynamic", "programming")

def shortest_common_supersequence(a, b)
  a, b = b, a if a.length > b.length
  prev = 0.upto(b.length).to_a
  cur = [0] * (b.length + 1)
  1.upto(a.length) do |a_len|
    cur[0] = a_len
    1.upto(b.length) do |b_len|
      cur[b_len] = if a[a_len - 1] == b[b_len - 1]
                     1 + prev[b_len - 1]
                   else
                     1 + [cur[b_len - 1], prev[b_len]].min
                   end
    end
    prev, cur = cur, prev
  end
  prev[b.length]
end

p shortest_common_supersequence "abcf", "bdcf"
p shortest_common_supersequence("dynamic", "programming")
p shortest_common_supersequence("dynamic", "programming")

puts "Make deletions for sorted sequence"

def min_deletions_for_sorted(nums, len = nums.length, prev = 1.0 / 0)
  return 0 if len.zero?
  if nums[len - 1] < prev
    [min_deletions_for_sorted(nums, len - 1, nums[len - 1]), 1 + min_deletions_for_sorted(nums, len - 1, prev)].min
  else
    1 + min_deletions_for_sorted(nums, len - 1, prev)
  end
end

puts min_deletions_for_sorted [4, 2, 3, 6, 10, 1, 12]
puts min_deletions_for_sorted [-4, 10, 3, 7, 15]
puts min_deletions_for_sorted [3, 2, 1, 0]

def min_deletions_for_sorted(nums, len = nums.length, prev = 1.0 / 0)
  dp = [1] * nums.length
  max = 1
  0.upto(nums.length - 1) do |idx|
    0.upto(idx - 1) do |other_idx|
      if nums[other_idx] < nums[idx] && dp[other_idx] >= dp[idx]
        dp[idx] = 1 + dp[other_idx]
        max = dp[idx] if dp[idx] > max
      end
    end
  end
  nums.length - max
end

puts min_deletions_for_sorted [4, 2, 3, 6, 10, 1, 12]
puts min_deletions_for_sorted [-4, 10, 3, 7, 15]
puts min_deletions_for_sorted [3, 2, 1, 0]

puts "Longest repeating subsequence"

def longest_repeating_subsequence(s, a_len = s.length, b_len = s.length - 1)
  return 0 if a_len.zero? || b_len.zero?
  if s[a_len - 1] == s[b_len - 1] && a_len != b_len
    1 + longest_repeating_subsequence(s, a_len - 1, b_len - 1)
  else
    [longest_repeating_subsequence(s, a_len - 1, b_len), longest_repeating_subsequence(s, a_len, b_len - 1)].max
  end
end

p longest_repeating_subsequence "tomorrow"
p longest_repeating_subsequence "aabdbcec"
p longest_repeating_subsequence "fmff"

def longest_repeating_subsequence(s)
  dp = (s.length + 1).times.collect { [0] * (s.length + 1) }
  1.upto(s.length) do |a_len|
    1.upto(s.length) do |b_len|
      dp[a_len][b_len] = if s[a_len - 1] == s[b_len - 1] && a_len != b_len
                           1 + dp[a_len - 1][b_len - 1]
                         else
                           [dp[a_len - 1][b_len], dp[a_len][b_len - 1]].max
                         end
    end
  end
  a_len, b_len = s.length, s.length - 1
  res = ""
  while a_len > 0 && b_len > 0
    if s[a_len - 1] == s[b_len - 1] && a_len != b_len
      res = s[a_len - 1] + res
      a_len -= 1
      b_len -= 1
    elsif dp[a_len - 1][b_len] >= dp[a_len][b_len - 1]
      a_len -= 1
    else
      b_len -= 1
    end
  end
  res
end

p longest_repeating_subsequence "tomorrow"
p longest_repeating_subsequence "aabdbcec"
p longest_repeating_subsequence "fmff"

puts "Count pattern"

def pattern_count(s, p, s_len = s.length, p_len = p.length)
  return 0 if s_len.zero?
  if s[s_len - 1] == p[p_len - 1]
    if p_len == 1
      1 + pattern_count(s, p, s_len - 1, p.length)
    else
      pattern_count(s, p, s_len - 1, p_len - 1) + pattern_count(s, p, s_len - 1, p_len)
    end
  else
    pattern_count(s, p, s_len - 1, p_len)
  end
end

p pattern_count "baxmx", "ax"
p pattern_count "tomorrow", "tor"

def pattern_count(s, p)
  prev = (p.length + 1).times.collect { 0 }
  cur = (p.length + 1).times.collect { 0 }
  prev[0], cur[0] = 1, 1
  1.upto(s.length) do |s_len|
    1.upto(p.length) do |p_len|
      cur[p_len] = if p[p_len - 1] == s[s_len - 1]
                     prev[p_len - 1] + prev[p_len]
                   else
                     prev[p_len]
                   end
    end
    cur, prev = prev, cur
  end
  prev[p.length]
end

p pattern_count "baxmx", "ax"
p pattern_count "tomorrow", "tor"

puts "Largest bitonic subsequence"

def longest_increasing_subsequence(nums)
  dp = [1] * nums.length
  0.upto(nums.length - 1) do |idx|
    (idx - 1).downto(0) do |other_idx|
      if nums[other_idx] < nums[idx] && dp[other_idx] >= dp[idx]
        dp[idx] = 1 + dp[other_idx]
      end
    end
  end
  dp
end

def longest_bitonic_subsequence(nums)
  dp = longest_increasing_subsequence(nums)
  dp_rev = longest_increasing_subsequence(nums.reverse)
  len = 0
  1.upto(nums.length - 2) do |midx|
    sum = dp[midx] + dp_rev[midx] - 1
    len = sum if sum > len
  end
  len
end

p longest_bitonic_subsequence [4, 2, 3, 6, 10, 1, 12]
p longest_bitonic_subsequence [4, 2, 5, 9, 7, 6, 10, 3, 1]

puts "Longest alternatig subsequence"

def longest_alternating_subsequence(nums, len = nums.length, decreasing = false, prev = decreasing ? 1.0 / 0 : -1.0 / 0)
  return 0 if len.zero?
  if decreasing && nums[len - 1] < prev
    [1 + longest_alternating_subsequence(nums, len - 1, false, nums[len - 1]),
     longest_alternating_subsequence(nums, len - 1, decreasing, prev)].max
  elsif !decreasing && nums[len - 1] > prev
    [1 + longest_alternating_subsequence(nums, len - 1, true, nums[len - 1]),
     longest_alternating_subsequence(nums, len - 1, decreasing, prev)].max
  else
    longest_alternating_subsequence(nums, len - 1, decreasing, prev)
  end
end

p longest_alternating_subsequence [1, 2, 3, 4]
p longest_alternating_subsequence [3, 2, 1, 4]

def longest_alternating_subsequence(nums)
  dp = nums.length.times.collect { [1, 1] }
  0.upto(nums.length - 1) do |idx|
    (idx - 1).downto(0) do |other_idx|
      if nums[other_idx] < nums[idx] && dp[other_idx][1] >= dp[idx][0]
        dp[idx][0] = 1 + dp[other_idx][1]
      elsif nums[other_idx] > nums[idx] && dp[other_idx][0] >= dp[idx][1]
        dp[idx][1] = 1 + dp[other_idx][0]
      end
    end
  end
  dp[nums.length - 1].max
end

p longest_alternating_subsequence [1, 2, 3, 4]
p longest_alternating_subsequence [3, 2, 1, 4]

puts "Min edit distance"

def min_edit_distance(s1, s2, s1_len = s1.length, s2_len = s2.length)
  return [s1_len, s2_len].max if s1_len.zero? || s2_len.zero?
  if s1[s1_len - 1] == s2[s2_len - 1]
    min_edit_distance(s1, s2, s1_len - 1, s2_len - 1)
  else
    [1 + min_edit_distance(s1, s2, s1_len - 1, s2_len - 1),
     1 + min_edit_distance(s1, s2, s1_len, s2_len - 1),
     1 + min_edit_distance(s1, s2, s1_len - 1, s2_len)].min
  end
end

p min_edit_distance "but", "bat"

p min_edit_distance "passpot", "ppsspqrt"

def min_edit_distance(s1, s2)
  prev = 0.upto(s2.length).to_a
  cur = [1.0 / 0] * (s2.length + 1)
  1.upto(s1.length) do |s1_len|
    cur[0] = s1_len
    1.upto(s2.length) do |s2_len|
      cur[s2_len] = if s1[s1_len - 1] == s2[s2_len - 1]
                      prev[s2_len - 1]
                    else
                      1 + [prev[s2_len - 1],
                           cur[s2_len - 1],
                           prev[s2_len]].min
                    end
    end
    prev, cur = cur, prev
  end
  prev[s2.length]
end

p min_edit_distance "but", "bat"

p min_edit_distance "passpot", "ppsspqrt"
p min_edit_distance "passpot", ""

p min_edit_distance "", "ppsspqrt"

puts "string interleaving"

def is_interleaving(a, b, p, a_len = a.length, b_len = b.length, p_len = p.length)
  return false if p_len != a_len + b_len
  return true if p_len.zero?
  if a_len > 0 && a[a_len - 1] == p[p_len - 1]
    is_interleaving(a, b, p, a_len - 1, b_len, p_len - 1)
  elsif b_len > 0 || b[b_len - 1] == p[p_len - 1]
    is_interleaving(a, b, p, a_len, b_len - 1, p_len - 1)
  else
    false
  end
end

p is_interleaving m = "abd", n = "cef", p = "abcdef"
p is_interleaving m = "abd", n = "cef", p = "adcbef"
p is_interleaving m = "", n = "abd", p = "abd"

def is_interleaving(a, b, p)
  return false if p.length != a.length + b.length
  dp = (a.length + 1).times.collect { [false] * (b.length + 1) }
  dp[0][0] = true
  1.upto(a.length) do |a_len|
    break unless a[a_len - 1] == p[a_len - 1]
    dp[a_len][0] = true
  end
  1.upto(b.length) do |b_len|
    break unless b[b_len - 1] == p[b_len - 1]
    dp[0][b_len] = true
  end
  1.upto(a.length) do |a_len|
    1.upto(b.length) do |b_len|
      dp[a_len][b_len] = (a[a_len - 1] == p[a_len + b_len - 1] && dp[a_len - 1][b_len]) ||
                         (b[b_len - 1] == p[a_len + b_len - 1] && dp[a_len][b_len - 1])
    end
  end
  dp[a.length][b.length]
end

def is_interleaving(a, b, p)
  return false if p.length != a.length + b.length
  prev = [false] * (b.length + 1)
  cur = [false] * (b.length + 1)
  prev[0] = true
  1.upto(b.length) do |b_len|
    break unless b[b_len - 1] == p[b_len - 1]
    prev[b_len] = true
  end
  1.upto(a.length) do |a_len|
    cur[0] = prev[0] && a[a_len - 1] == p[a_len - 1]
    1.upto(b.length) do |b_len|
      cur[b_len] = (a[a_len - 1] == p[a_len + b_len - 1] && prev[b_len]) ||
                   (b[b_len - 1] == p[a_len + b_len - 1] && cur[b_len - 1])
    end
    cur, prev = prev, cur
  end
  prev[b.length]
end

p is_interleaving m = "abd", n = "cef", p = "abcdef"
p is_interleaving m = "abd", n = "cef", p = "adcbef"
p is_interleaving m = "", n = "abd", p = "abd"
