pub struct Solution;

use std::cmp;

impl Solution {
    pub fn trap(height: Vec<i32>) -> i32 {
        if height.len() == 0 {
            return 0;
        }
        let mut left = vec![0; height.len()];
        let mut right = vec![0; height.len()];
        left[0] = height[0];
        right[height.len() - 1] = height[height.len() - 1];
        for i in 1..height.len() {
            left[i] = cmp::max(left[i - 1], height[i]);
        }
        for i in (0..height.len() - 1).rev() {
            right[i] = cmp::max(right[i + 1], height[i]);
        }
        let mut water = 0;
        for i in 0..height.len() {
            water += cmp::min(left[i], right[i]) - height[i];
        }
        water
    }

    pub fn trap2(height: Vec<i32>) -> i32 {
        if height.len() == 0 {
            return 0;
        }
        let mut water = 0;
        let mut stack = vec![0 as usize; height.len() + 1];
        let mut ptr = 0;
        for i in 0..height.len() {
            while ptr > 0 && height[stack[ptr]] < height[i] {
                let bottom = stack[ptr];
                ptr -= 1;
                if ptr == 0 {
                    break;
                }
                let left = stack[ptr];
                let water_height = cmp::min(height[i], height[left]) - height[bottom];
                let water_width = (i - left - 1) as i32;
                water += water_height * water_width
            }
            ptr += 1;
            stack[ptr] = i;
        }
        water
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    #[test]
    fn it_works() {
        assert_eq!(Solution::trap(vec![]), 0);
        assert_eq!(Solution::trap(vec![0]), 0);
        assert_eq!(Solution::trap(vec![0, 1, 0, 2, 1, 0, 1, 3, 2, 1, 2, 1]), 6);
        assert_eq!(Solution::trap(vec![4, 2, 0, 3, 2, 5]), 9);

        assert_eq!(Solution::trap2(vec![]), 0);
        assert_eq!(Solution::trap2(vec![0]), 0);
        assert_eq!(Solution::trap2(vec![0, 1, 0, 2, 1, 0, 1, 3, 2, 1, 2, 1]), 6);
        assert_eq!(Solution::trap2(vec![4, 2, 0, 3, 2, 5]), 9);
    }
}
