puts "Knapsack"

def knapsack(w, p, cap, len = w.length)
  return 0 if len.zero? || cap <= 0
  [knapsack(w, p, cap, len - 1), p[len - 1] + knapsack(w, p, cap - w[len - 1], len - 1)].max
end

p knapsack([1, 2, 3, 4], [5, 6, 7, 8], 4, 4)

def knapsack_dp(w, p, cap)
  prev = (cap + 1).times.collect { 0 }
  cur = (cap + 1).times.collect { 0 }
  1.upto(w.length) do |len|
    0.upto(cap) do |cap|
      if w[len - 1] <= cap
        cur[cap] = [prev[cap], p[len - 1] + prev[cap - w[len - 1]]].max
      else
        cur[cap] = prev[cap]
      end
    end
    cur, prev = prev, cur
  end
  prev[cap]
end

p knapsack([1, 2, 3, 4], [5, 6, 7, 8], 4, 4)

puts "Equal subsets"

def can_partition(nums)
  sum = nums.sum
  return false if sum.odd?
  can_partition_dp(nums, sum / 2)
end

def can_partition_r(nums, target, len = nums.length)
  return false if target < 0
  return target.zero? if len.zero?
  can_partition_r(nums, target, len - 1) || can_partition_r(nums, target - nums[len - 1], len - 1)
end

def can_partition_dp(nums, target, len = nums.length)
  prev = (1 + target).times.collect { false }
  cur = (1 + target).times.collect { false }
  prev[0] = true
  1.upto(nums.length) do |len|
    0.upto(target) do |target|
      cur[target] = prev[target] || (nums[len - 1] <= target && prev[target - nums[len - 1]])
    end
    prev, cur = cur, prev
  end
  prev[target]
end

p can_partition [1, 2, 3, 6]
p can_partition [1, 2, 3, 5]

puts "Min subset difference"

def min_subset_diff(nums)
  sum = nums.sum
  found = can_partition_dp(nums, sum / 2)
  sum - 2 * found
end

def can_partition_dp(nums, target, len = nums.length)
  prev = (1 + target).times.collect { false }
  cur = (1 + target).times.collect { false }
  prev[0] = true
  1.upto(nums.length) do |len|
    0.upto(target) do |target|
      cur[target] = prev[target] || (nums[len - 1] <= target && prev[target - nums[len - 1]])
    end
    prev, cur = cur, prev
  end
  target.downto(0).find { |x| prev[x] }
end

p min_subset_diff [1, 2, 3, 5]
p min_subset_diff [1, 2, 3, 6]
p min_subset_diff [1, 2, 3, 600]

puts "Count of subset sum"

def subset_count(nums, target, len = nums.length)
  prev = (1 + target).times.collect { 0 }
  cur = (1 + target).times.collect { 0 }
  prev[0] = 1
  1.upto(nums.length) do |len|
    0.upto(target) do |target|
      cur[target] = prev[target]
      cur[target] += prev[target - nums[len - 1]] if nums[len - 1] <= target
    end
    prev, cur = cur, prev
  end
  prev[target]
end

p subset_count [1, 2, 2, 3, 4], 4

puts "Target sum"

def count_target_sum(nums, target, len = nums.length)
  return 0 if len < 1
  target_sum(nums, target - nums[len - 1], len - 1) + target_sum(nums, target + nums[len - 1], len - 1)
end

def count_target_sum(nums, target)
  target = (nums.sum + target) / 2
  prev = (1 + target).times.collect { 0 }
  cur = (1 + target).times.collect { 0 }
  prev[0] = 1
  1.upto(nums.length) do |len|
    0.upto(target) do |target|
      cur[target] = prev[target]
      cur[target] += prev[target - nums[len - 1]] if nums[len - 1] <= target
    end
    prev, cur = cur, prev
  end
  prev[target]
end

# P - S = T
# P + S = SUM
p count_target_sum [1, 2, 2, 3], 0
