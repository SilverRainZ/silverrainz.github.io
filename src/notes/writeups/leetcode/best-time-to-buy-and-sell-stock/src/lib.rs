pub struct Solution;

impl Solution {
    // 暴力 O(n!) TLE
    pub fn max_profit(prices: Vec<i32>) -> i32 {
        let mut max = 0;
        for i in 0..prices.len()-1 {
            for j in i+1..prices.len() {
                if prices[j] - prices[i] > max {
                    max = prices[j] - prices[i];
                }
            }
        }
        return max
    }

    // DP1
    pub fn max_profit2(prices: Vec<i32>) -> i32 {
        let mut max = 0;
        let mut profit = vec![0; prices.len()];
        for i in 1..prices.len() {
            for j in (0..i).rev() {
                if prices[i] >= prices[j] {
                    profit[i] = profit[j] + (prices[i] - prices[j]);
                    if profit[i] > max {
                        max = profit[i];
                    }
                    break;
                }
            }
        }
        return max
    }

    // DP2
    pub fn max_profit3(prices: Vec<i32>) -> i32 {
        let mut max = 0;
        let mut profit = vec![0; prices.len()];
        for i in 1..prices.len() {
            profit[i] = profit[i-1] + (prices[i] - prices[i-1]);
            if profit[i] < 0 {
                profit[i] = 0;
            }
            if profit[i] > max {
                max = profit[i];
            }
        }
        return max
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    #[test]
    fn it_works() {
        assert_eq!(Solution::max_profit(vec![1, 2, 3]), 2);
        assert_eq!(Solution::max_profit(vec! [7,1,5,3,6,4]), 5);

        assert_eq!(Solution::max_profit2(vec![1, 2, 3]), 2);
        assert_eq!(Solution::max_profit2(vec! [7,1,5,3,6,4]), 5);
    }
}
