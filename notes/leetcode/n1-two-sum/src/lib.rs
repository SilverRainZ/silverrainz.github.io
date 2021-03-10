// ref: https://github.com/iosmanthus/leetcode-rust/blob/master/two-sum/src/lib.rs

use std::collections::HashMap;

pub struct Solution;

impl Solution {
    pub fn two_sum(nums: Vec<i32>, target: i32) -> Vec<i32> {
        let mut seen = HashMap::new();
        for (i, num) in nums.iter().enumerate() {
            if seen.contains_key(num) {
                return vec![seen[num], i as i32];
            } else {
                seen.insert(target - num, i as i32);
            }
        }
        panic!();
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    #[test]
    fn it_works() {
        assert_eq!(vec![1, 3], Solution::two_sum(vec![9, 1, 2, 4, 3], 5));
        assert_eq!(vec![0, 5], Solution::two_sum(vec![1, 4, 3, 4, 0, 5], 6));
    }
}
