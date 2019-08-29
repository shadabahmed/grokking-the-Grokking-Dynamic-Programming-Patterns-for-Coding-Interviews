puts "Fibonacchi"

def fib(n)
  return n if n < 2
  prev, cur = 0, 1
  while n > 1
    cur, prev = cur + prev, cur
    n -= 1
  end
  cur
end

p 0.upto(10).collect { |n| fib(n) }

puts "Stair Case"

def count_ways(stairs)
  return 1 if stairs.zero?
  total_steps = 0
  [1, 2, 3].each do |steps|
    total_steps += count_ways(stairs - steps) if stairs >= steps
  end
  total_steps
end

def count_ways_dp(stairs)
  dp = [1]
  1.upto(stairs) do |stairs|
    if stairs >= 3
      dp[stairs] = dp[stairs - 1] + dp[stairs - 2] + dp[stairs - 3]
    elsif stairs >= 2
      dp[stairs] = dp[stairs - 1] + dp[stairs - 2]
    else
      dp[stairs] = dp[stairs - 1]
    end
  end
  dp[stairs]
end

def count_ways_dp(stairs, steps = [1, 2, 3])
  max = steps.max + 1
  dp = (max + 1).times.collect { 0 }
  dp[0] = 1
  1.upto(stairs) do |stairs|
    dp[stairs % max] = 0
    steps.each do |step|
      dp[stairs % max] += dp[(stairs - step) % max] if stairs >= step
    end
  end
  dp[stairs % max]
end

p count_ways_dp(4)

puts "Num factors"

def num_factors(num, numbers = [1, 3, 4])
  return 1 if num.zero?
  numbers.collect do |factor|
    if num >= factor
      num_factors(num - factor, numbers = [1, 3, 4])
    else
      0
    end
  end.sum
end

p num_factors 4

def num_factors_dp(num, numbers = [1, 3, 4])
  max = numbers.max + 1
  dp = max.times.collect { 0 }
  dp[0] = 1
  1.upto(num) do |num|
    dp[num % max] = 0
    factors.each do |factor|
      next if factor > num
      dp[num % max] += dp[(num - factor) % max]
    end
  end
  dp[num % max]
end

p num_factors 4

puts "MIN JUMPS"

def min_jumps(nums, idx = nums.length - 1)
  return 0 if idx == 0
  min = nums.length + 1
  (idx - 1).downto(0) do |other_idx|
    next if other_idx + nums[other_idx] != idx
    cost_from_other_idx = 1 + min_jumps(nums, other_idx)
    min = cost_from_other_idx if cost_from_other_idx < min
  end
  min
end

p min_jumps [2, 1, 1, 1, 4]
p min_jumps [1, 1, 3, 6, 9, 3, 0, 1, 3]

def min_jumps(nums)
  dp = nums.length.times.collect { 1.0 / 0 }
  dp[0] = 0
  1.upto(nums.length - 1) do |idx|
    (idx - 1).downto(0) do |other_idx|
      next if other_idx + nums[other_idx] != idx
      dp[idx] = 1 + dp[other_idx] if dp[idx] < 0 || 1 + dp[other_idx] < dp[idx]
    end
  end
  dp[nums.length - 1]
end

p min_jumps [2, 1, 1, 1, 4]
p min_jumps [1, 1, 3, 6, 9, 3, 0, 1, 3]

puts "MIN JUMPS WITH FEE"

def min_jumps_with_fee(fees, idx = fees.length)
  return fees[0] if idx == 1
  return 1.0 / 0 if idx < 0
  [1, 2, 3].collect do |steps|
    min_jumps_with_fee(fees, idx - steps)
  end.min + fees[idx - 1]
end

p min_jumps_with_fee [1, 2, 5, 2, 1, 2]
p min_jumps_with_fee [2, 3, 4, 5]

def min_jumps_with_fee_dp(fees)
  dp = [1.0 / 0] * (fees.length + 1)
  dp[0] = 0
  1.upto(fees.length) do |idx|
    [1, 2, 3].each do |steps|
      if idx >= steps && dp[idx - steps] < dp[idx]
        dp[idx] = dp[idx - steps]
      end
    end
    dp[idx] += fees[idx - 1]
  end
  dp[fees.length]
end

p min_jumps_with_fee_dp [1, 2, 5, 2, 1, 2]
p min_jumps_with_fee_dp [2, 3, 4, 5]

puts "House thief"

def rob(houses, len = houses.length)
  return 0 if len <= 0
  [houses[len - 1] + rob(houses, len - 2), rob(houses, len - 1)].max
end

p rob [2, 5, 1, 3, 6, 2, 4]

def rob_dp(houses)
  prev_prev, prev = 0, 0
  0.upto(houses.length - 1) do |idx|
    cur = [prev, prev_prev + houses[idx]].max
    prev, prev_prev = cur, prev
  end
  prev
end

p rob_dp [2, 5, 1, 3, 6, 2, 4]
p rob_dp [2, 10, 14, 8, 1]
