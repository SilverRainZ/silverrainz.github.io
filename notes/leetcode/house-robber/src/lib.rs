pub struct Solution;

use std::cmp;

impl Solution {
    pub fn rob(nums: Vec<i32>) -> i32 {
        // init state
        let mut state = vec![0; nums.len()];
        if nums.len() < 2 {
            return nums[0];
        }
        state[0] = nums[0];
        state[1] = nums[1];
        if nums.len() < 3 {
            return cmp::max(state[1], state[0]);
        }
        state[2] = nums[0] + nums[2];
        if nums.len() < 4 {
            return cmp::max(state[2], state[1]);
        }
        let mut res = cmp::max(state[2], state[1]);
        for i in 3..nums.len() {
            state[i] = cmp::max(state[i - 2], state[i - 3]) + nums[i];
            res = cmp::max(res, state[i]);
        }
        res
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    #[test]
    fn it_works() {
        assert_eq!(Solution::rob(vec![1, 2, 3, 1]), 4);
        assert_eq!(Solution::rob(vec![2, 7, 9, 3, 1]), 12);
        assert_eq!(Solution::rob(vec![100, 1, 2, 200]), 300);
    }
}
