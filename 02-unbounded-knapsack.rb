# frozen_string_literal: true

def solve_knapsack(profits, weights, capacity); end

def solve_knapsack_r(profits, weights, capacity, len = profits.length)
  return 0 if len.zero?

  if weights[len - 1] <= capacity
    [solve_knapsack_r(profits, weights, capacity, len - 1),
     profits[len - 1] + solve_knapsack_r(profits, weights, capacity - weights[len - 1], len)].max
  else
    solve_knapsack_r(profits, weights, capacity, len - 1)
  end
end

def solve_knapsack(profits, weights, capacity)
  prev = (capacity + 1).times.collect { 0 }
  current = (capacity + 1).times.collect { 0 }
  1.upto(profits.length) do |len|
    0.upto(capacity) do |c|
      current[c] = if c >= weights[len - 1]
                     [prev[c], profits[len - 1] + current[c - weights[len - 1]]].max
                   else
                     prev[c]
                   end
    end
    prev, current = current, prev
  end
  prev[capacity]
end

def solve_knapsack_with_items(profits, weights, capacity)
  dp = (profits.length + 1).times.collect { (capacity + 1).times.collect { 0 } }
  1.upto(profits.length) do |len|
    0.upto(capacity) do |c|
      if c >= weights[len - 1]
        dp[len][c] = [dp[len - 1][c], profits[len - 1] + dp[len][c - weights[len - 1]]].max
      else
        dp[len][c] = dp[len - 1][c]
      end
    end
  end
  get_items(dp, profits, weights, capacity)
end

def get_items(dp, profits, weights, capacity, len = profits.length)
  res = []
  while len > 0
    count = 0
    while dp[len - 1][capacity] != dp[len][capacity]
      count += 1
      capacity -= weights[len - 1]
    end
    res << [count, profits[len - 1]] if count > 0
    len -= 1
  end
  res
end

p solve_knapsack([15, 50, 60, 90], [1, 3, 4, 5], 8)
p solve_knapsack([15, 50, 60, 90], [1, 3, 4, 5], 6)

p solve_knapsack_r([15, 50, 60, 90], [1, 3, 4, 5], 8)
p solve_knapsack_r([15, 50, 60, 90], [1, 3, 4, 5], 6)

p solve_knapsack_with_items([15, 50, 60, 90], [1, 3, 4, 5], 8)
p solve_knapsack_with_items([15, 50, 60, 90], [1, 3, 4, 5], 6)

puts 'ROD CUTTING'
def rod_cutting_r(lengths, prices, l, len = prices.length)
  return 0 if len.zero?

  if l >= lengths[len - 1]
    [rod_cutting_r(lengths, prices, l, len - 1),
     prices[len - 1] + rod_cutting_r(lengths, prices, l - lengths[len - 1], len)].max
  else
    rod_cutting_r(lengths, prices, l, len - 1)
  end
end

def rod_cutting_dp(lengths, prices, l)
  prev = (l + 1).times.collect { 0 }
  current = (l + 1).times.collect { 0 }
  1.upto(prices.length) do |len|
    0.upto(l) do |l|
      current[l] = if l >= lengths[len - 1]
                     [prev[l], prices[len - 1] + current[l - lengths[len - 1]]].max
                   else
                     prev[l]
                    end
    end
    prev, current = current, prev
  end
  prev[l]
end

def rod_cutting_items(lengths, prices, l)
  dp = (prices.length + 1).times.collect { (l + 1).times.collect { 0 } }
  1.upto(prices.length) do |len|
    0.upto(l) do |l|
      dp[len][l] = if l >= lengths[len - 1]
                     [dp[len - 1][l], prices[len - 1] + dp[len][l - lengths[len - 1]]].max
                   else
                     dp[len - 1][l]
                    end
    end
  end
  res = []
  len = prices.length
  while len > 0
    count = 0
    while dp[len][l] != dp[len - 1][l]
      l -= lengths[len - 1]
      count += 1
    end
    res << [count, lengths[len - 1]] if count > 0
    len -= 1
  end
  res
end

p rod_cutting_dp [1, 2, 3, 4, 5], [2, 6, 7, 10, 13], 5

p rod_cutting_items [1, 2, 3, 4, 5], [2, 6, 7, 10, 13], 5

puts 'COIN CHANGE'

def count_change(denominations, total, len = denominations.length)
  return total.zero? ? 1 : 0 if len.zero?

  if denominations[len - 1] <= total
    count_change(denominations, total, len - 1) + count_change(denominations, total - denominations[len - 1], len)
  else
    count_change(denominations, total, len - 1)
  end
end

def count_change(denominations, total)
  prev = (1 + total).times.collect { 0 }
  prev[0] = 1
  cur = (1 + total).times.collect { 0 }
  1.upto(denominations.length) do |len|
    0.upto(total) do |total|
      cur[total] = if total >= denominations[len - 1]
                     prev[total] + cur[total - denominations[len - 1]]
                   else
                     prev[total]
                   end
    end
    prev, cur = cur, prev
  end
  prev[total]
end

def count_change(denominations, total)
  prev = (1 + total).times.collect { 0 }
  prev[0] = 1
  cur = (1 + total).times.collect { 0 }
  1.upto(denominations.length) do |len|
    0.upto(total) do |total|
      cur[total] = if total >= denominations[len - 1]
                     prev[total] + cur[total - denominations[len - 1]]
                   else
                     prev[total]
                   end
    end
    prev, cur = cur, prev
  end
  prev[total]
end
p count_change [1, 2, 3], 5

puts 'MIN COIN CHANGE'

def min_change(denominations, total, len = denominations.length)
  return 1.0 / 0 if total < 0
  return total.zero? ? 0 : 1.0 / 0 if len <= 0

  [min_change(denominations, total, len - 1), 1 + min_change(denominations, total - denominations[len - 1], len)].min
end

def min_change(denominations, total, _len = denominations.length)
  prev = (total + 1).times.collect { 1.0 / 0 }
  prev[0] = 0
  cur = (total + 1).times.collect { 1.0 / 0 }
  1.upto(denominations.length) do |len|
    0.upto(total) do |total|
      cur[total] = if total >= denominations[len - 1]
                     [prev[total], 1 + cur[total - denominations[len - 1]]].min
                   else
                     prev[total]
                   end
    end
    prev, cur = cur, prev
  end
  prev[total]
end

def min_change(denominations, total, _len = denominations.length)
  max = denominations.max + 1
  dp = max.times.collect { 0 }
  1.upto(total) do |amount|
    dp[amount % max] = 1.0 / 0
    denominations.each do |coin|
      if coin <= amount
        dp[amount % max] = 1 + dp[(amount - coin) % max] if dp[(amount - coin) % max] + 1 < dp[amount % max]
      end
    end
  end
  dp[total % max]
end

p min_change [1, 2, 3], 5
p min_change [1, 2, 3], 7

puts "Ribbon Cut"

def ribbon_cut(lengths, size, len = lengths.length)
  return 0 if len.zero?
  if size >= lengths[len - 1]
    [1 + ribbon_cut(lengths, size - lengths[len - 1], len), ribbon_cut(lengths, size, len - 1)].max
  else
    ribbon_cut(lengths, size, len - 1)
  end
end

p ribbon_cut [2,3,5], 5

def ribbon_cut(lengths, size, len = lengths.length)
  prev = (size + 1).times.collect { 0 }
  cur = (size + 1).times.collect { 0 }
  1.upto(lengths.length) do |len|
    1.upto(size) do |size|
      cur[size] = if size >= lengths[len - 1]
                    [prev[size], 1 + cur[size - lengths[len - 1]]].max
                  else
                    prev[size]
                  end
    end
    prev, cur = cur, prev
  end
  prev[size]
end

p ribbon_cut [2,3,5], 5


def ribbon_cut(lengths, size, len = lengths.length)
  max = lengths.max + 1  
  dp = max.times.collect { 0 }
  max_cut = (size + 1).times.collect { 0 }
  1.upto(size) do |size|
    dp[size % max] = 0
    lengths.each do |len|
      if size >= len && 1 + dp[(size - len) % max] >= dp[size % max]
        dp[size % max] = 1 + dp[(size - len) % max]
        max_cut[size] = len
      end
    end
  end
  res = []
  while size > 0
    res.unshift(max_cut[size])
    size -= max_cut[size]
  end
  res
end

p ribbon_cut [2,3,5], 5
p ribbon_cut [2,3,5], 8