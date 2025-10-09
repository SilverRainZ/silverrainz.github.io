pub struct Solution;

use std::cmp::max as max;
use std::i32::MAX as i32max;

impl Solution {
    pub fn can_partition(nums: Vec<i32>) -> bool {
        let sum:i32 = nums.iter().sum();
        if sum%2 != 0 {
            return false
        }
        let mut state:Vec<i32> = vec![-i32max; (sum/2 + 1) as usize];
        state[0] = 0;
        // println!("{:?}", 0..nums.len());
        for i in 0..nums.len() {
            let base_cost = nums[i] as usize;
            if base_cost > state.len()-1 {
                // 放不进去，这里可以特判，但没有必要
                // println!("cost {} > bag cap {}, skipped", base_cost, state.len()-1);
                continue;
            }
            for j in (base_cost..state.len()).rev() {
                state[j] = max(state[j], state[j-base_cost] + 1);
                // println!("cap = {}, {} from ({}, {})", j, state[j], j-1, j-base_cost)
            }
            // println!("{} -> {}", state.len()-1, base_cost);
            // println!("state: {:?}", state);
        }
        // println!("fin state: {:?} {}", state, state[state.len()-1] > 0);
        state[state.len()-1] > 0
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    #[test]
    fn it_works() {
        assert_eq!(Solution::can_partition(vec![1, 2, 3]), true);
        assert_eq!(Solution::can_partition(vec![1,5,11,5]), true);
        assert_eq!(Solution::can_partition(vec![2,5,11,5]), false);
        assert_eq!(Solution::can_partition(vec![2,50,500]), false);
        assert_eq!(Solution::can_partition(vec![5, 1, 1, 1, 2]), true);
        assert_eq!(Solution::can_partition(vec![2, 2, 3, 5]), false);
    }
}
