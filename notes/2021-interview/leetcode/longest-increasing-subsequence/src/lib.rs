pub struct Solution;

use std::cmp;

impl Solution {
    // DP
    pub fn length_of_lis(nums: Vec<i32>) -> i32 {
        let mut res = 1;
        let mut state = vec![0; nums.len()];
        state[0] = 1;
        for i in 1..nums.len() {
            state[i] = 1;
            for j in (0..i).rev() {
                if nums[j] < nums[i] {
                    state[i] = cmp::max(state[i], state[j] + 1);
                    res = cmp::max(res, state[i]);
                }
            }
        }
        res
    }

    pub fn length_of_lis2(nums: Vec<i32>) -> i32 {
        let mut low = vec![-100000; nums.len() + 1];
        low[1] = nums[0];
        let mut lidx = 1;
        for i in 1..nums.len() {
            if nums[i] > low[lidx] {
                low[lidx + 1] = nums[i];
                lidx += 1;
            } else {
                let sorted = &low[0..lidx + 1];
                match sorted.binary_search(&nums[i]) {
                    Err(idx) => {
                        low[idx] = nums[i];
                    }
                    _ => (),
                }
            }
        }
        return lidx as i32;
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    #[test]
    fn it_works() {
        assert_eq!(Solution::length_of_lis(vec![10, 9, 2, 5, 3, 7, 101, 18]), 4);
        assert_eq!(Solution::length_of_lis(vec![0, 1, 0, 3, 2, 3]), 4);
        assert_eq!(Solution::length_of_lis(vec![7, 7, 7, 7, 7, 7, 7]), 1);

        assert_eq!(
            Solution::length_of_lis2(vec![10, 9, 2, 5, 3, 7, 101, 18]),
            4
        );
        assert_eq!(Solution::length_of_lis2(vec![0, 1, 0, 3, 2, 3]), 4);
        assert_eq!(Solution::length_of_lis2(vec![7, 7, 7, 7, 7, 7, 7]), 1);
    }
}
