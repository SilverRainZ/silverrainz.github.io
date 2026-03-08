pub struct Solution;

impl Solution {
    pub fn can_partition(nums: Vec<i32>) -> bool {
        let sum: i32 = nums.iter().sum();
        let len = nums.len();

        if sum % 2 != 0 || len < 2 {
            return false;
        }

        let target = (sum / 2) as usize;
        let mut dp = vec![vec![false; target + 1]; len];

        for i in 0..len {
            dp[i][0] = true;
        }

        let first = nums[0] as usize;
        if first <= target {
            dp[0][first] = true;
        }

        for i in 1..len {
            let num = nums[i] as usize;
            for j in 1..=target {
                dp[i][j] = dp[i - 1][j];
                if j >= num {
                    dp[i][j] = dp[i][j] || dp[i - 1][j - num];
                }
            }
        }

        dp[len - 1][target]
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    #[test]
    fn it_works() {
        assert_eq!(Solution::can_partition(vec![1, 2, 3]), true);
        assert_eq!(Solution::can_partition(vec![1, 5, 11, 5]), true);
        assert_eq!(Solution::can_partition(vec![2, 5, 11, 5]), false);
        assert_eq!(Solution::can_partition(vec![2, 50, 500]), false);
        assert_eq!(Solution::can_partition(vec![5, 1, 1, 1, 2]), true);
        assert_eq!(Solution::can_partition(vec![2, 2, 3, 5]), false);
    }
}
