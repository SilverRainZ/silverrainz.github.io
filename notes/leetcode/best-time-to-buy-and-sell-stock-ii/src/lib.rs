pub struct Solution;

impl Solution {
    // DP2
    pub fn max_profit(prices: Vec<i32>) -> i32 {
        let mut profit = vec![0; prices.len()];
        for i in 1..prices.len() {
            if prices[i] - prices[i-1] > 0 {
                profit[i] = profit[i-1] + (prices[i] - prices[i-1])
            } else {
                profit[i] = profit[i-1]
            }
        }
        return profit[prices.len()-1]
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    #[test]
    fn it_works() {
        assert_eq!(Solution::max_profit(vec![7,1,5,3,6,4]), 7);
        assert_eq!(Solution::max_profit(vec! [1,2,3,4,5]), 4);
    }
}
