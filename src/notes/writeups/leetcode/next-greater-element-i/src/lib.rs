pub struct Solution;

use std::collections::HashMap;

impl Solution {
    pub fn next_greater_element(nums1: Vec<i32>, nums2: Vec<i32>) -> Vec<i32> {
        let mut res = vec![-1; nums1.len()];
        let mut map = HashMap::new();
        for i in 0..nums1.len() {
            map.insert(nums1[i], i);
        }

        let mut stack = vec![0; nums2.len()];
        let mut ptr = 1;
        stack[ptr - 1] = nums2[nums2.len() - 1];
        for i in (0..nums2.len() - 1).rev() {
            while ptr > 0 && stack[ptr - 1] < nums2[i] {
                ptr -= 1;
            }
            let next_greater = if ptr > 0 { stack[ptr - 1] } else { -1 };
            match map.get(&nums2[i]) {
                Some(ii) => res[*ii] = next_greater,
                None => (),
            }
            ptr += 1;
            stack[ptr - 1] = nums2[i]
        }
        res
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    #[test]
    fn it_works() {
        assert_eq!(Solution::next_greater_element(vec![2], vec![2]), vec![-1]);
        assert_eq!(
            Solution::next_greater_element(vec![2, 5], vec![2, 5, 6]),
            vec![5, 6]
        );
        assert_eq!(
            Solution::next_greater_element(vec![4, 1, 2], vec![1, 3, 4, 2]),
            vec![-1, 3, -1]
        );
        assert_eq!(
            Solution::next_greater_element(vec![2, 4], vec![1, 2, 3, 4]),
            vec![3, -1]
        );
    }
}
