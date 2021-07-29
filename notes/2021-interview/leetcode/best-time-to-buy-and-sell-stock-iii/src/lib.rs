use std::cmp;

pub struct Solution;

impl Solution {
    pub fn max_profit(prices: Vec<i32>) -> i32 {
        let mut max = 0;

        // First transaction
        let mut profit1 = vec![0; prices.len()];
        let mut max_profit1 = vec![0; prices.len()];
        for i in 1..prices.len() {
            profit1[i] = profit1[i - 1] + (prices[i] - prices[i - 1]);
            if profit1[i] < 0 {
                profit1[i] = 0;
            }
            max_profit1[i] = cmp::max(profit1[i], max_profit1[i - 1]);
            if profit1[i] > max {
                max = profit1[i];
            }
        }

        // Possible second transaction
        let mut profit2 = vec![0; prices.len()];
        for i in 2..prices.len() {
            profit2[i] = cmp::max(max_profit1[i - 2], profit2[i - 1]) + (prices[i] - prices[i - 1]);
            if profit2[i] < 0 {
                profit2[i] = 0;
            }
            if profit2[i] > max {
                max = profit2[i];
            }
        }
        return max;
    }

    pub fn max_profit2(prices: Vec<i32>) -> i32 {
        let mut buy1 = prices[0];
        let mut sell1 = 0;
        let mut buy2 = prices[0];
        let mut sell2 = 0;
        for i in 1..prices.len() {
            buy1 = cmp::min(buy1, prices[i]);
            sell1 = cmp::max(sell1, prices[i] - buy1);
            buy2 = cmp::min(buy2, prices[i] - sell1);
            sell2 = cmp::max(sell2, prices[i] - buy2);
        }
        sell2
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    #[test]
    fn it_works() {
        assert_eq!(Solution::max_profit(vec![3, 3, 5, 0, 0, 3, 1, 4]), 6);
        assert_eq!(Solution::max_profit(vec![1, 2, 3, 4, 5]), 4);
        assert_eq!(Solution::max_profit(vec![7, 6, 4, 3, 1]), 0);
        assert_eq!(Solution::max_profit(vec![1, 8, 1, 8, 7, 10]), 16);
        assert_eq!(Solution::max_profit(vec![3, 2, 6, 5, 0, 3]), 7);
        assert_eq!(Solution::max_profit(vec![6, 1, 6, 4, 3, 0, 2]), 7); // 5

        assert_eq!(Solution::max_profit2(vec![3, 3, 5, 0, 0, 3, 1, 4]), 6);
        // assert_eq!(Solution::max_profit2(vec![1, 2, 3, 4, 5]), 4);
        // assert_eq!(Solution::max_profit2(vec![7, 6, 4, 3, 1]), 0);
        // assert_eq!(Solution::max_profit2(vec![1, 8, 1, 8, 7, 10]), 16);
        // assert_eq!(Solution::max_profit2(vec![3, 2, 6, 5, 0, 3]), 7);
        // assert_eq!(Solution::max_profit2(vec![6, 1, 6, 4, 3, 0, 2]), 7); // 5
    }
}
