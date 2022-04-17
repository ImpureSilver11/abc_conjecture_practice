# ABC予想

# a + b = c を満たす、互いに素な自然数の組 (a, b, c) に対し、積 abc の互いに異なる素因数の積を d と表す。
# このとき、任意の ε > 0 に対して、
# c > d^1+ε
# を満たす組 (a, b, c, d)を列挙する
def abc_conjecture
  result = []
  (9001..10000).each do |a|
    (a..10000).each do |b|
      # aとbの最大公約数が1であること。違う場合はskip
      next unless greatest_common_divisor?(a, b)
      # a + b = c
      c = a + b
      # 互いに異なる素因数の積
      d = (prime_factor_decomposition(a) + prime_factor_decomposition(b) + prime_factor_decomposition(c)).uniq
      if c > d.inject(:*)
        pop = {a: a, b: b, c: c, d: d, epsilon: epsilon(c, d.inject(:*)) }
        pp pop
        result.push(pop)
      end
    end
  end
  result
end

# 1以上の最大公約数があるかどうか判別する
def greatest_common_divisor?(a, b)
  # a <= bにする
  if a > b
    x = b
    b = a
    a = b
  end
  (2..a).each do |x|
    return false if (a % x == 0) && (b % x == 0)
  end
  true
end

# 問題文のεを求める
# c > d ^ 1 + εであることから
# log(c)[d] - 1.0 を満たさない最大の値がεとなる
def epsilon(c, d)
  Math.log(c, d) - 1.0.to_f
end

# 素因数分解を行う
# e.g. 18 => [2, 3 ,3]
def prime_factor_decomposition(number)
  result = []
  (2..number).map do |i|
    while number % i == 0
      number = number / i
      result << i
    end
  end
  result.flatten.compact
end

pp abc_conjecture
