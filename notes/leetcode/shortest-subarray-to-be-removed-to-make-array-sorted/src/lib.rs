pub struct Solution;

use std::cmp;

pub fn cross_find(arr: &Vec<i32>, l: i32, r: i32) -> i32 {
    if l < 0 {
        return r;
    }
    if r >= arr.len() as i32 {
        return arr.len() as i32 - l - 1;
    }
    if arr[l as usize] <= arr[r as usize] {
        return r - l - 1;
    }
    cmp::min(
        cross_find(arr, l - 1, r),
        cmp::min(cross_find(arr, l, r + 1), cross_find(arr, l - 1, r + 1)),
    )
}

impl Solution {
    pub fn find_length_of_shortest_subarray(arr: Vec<i32>) -> i32 {
        let mut l_ptr = 0;
        for i in 1..arr.len() {
            if arr[i] < arr[i - 1] {
                break;
            }
            l_ptr = i;
        }
        if l_ptr == arr.len() - 1 {
            return 0;
        }
        let mut r_ptr = arr.len() - 1;
        for i in (l_ptr..arr.len() - 1).rev() {
            if arr[i] > arr[i + 1] {
                break;
            }
            r_ptr = i;
        }
        cross_find(&arr, l_ptr as i32, r_ptr as i32)
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    #[test]
    fn it_works() {
        assert_eq!(
            Solution::find_length_of_shortest_subarray(vec![1, 2, 3, 10, 4, 2, 3, 5]),
            3
        );
        assert_eq!(
            Solution::find_length_of_shortest_subarray(vec![5, 4, 3, 2, 1]),
            4
        );
        assert_eq!(Solution::find_length_of_shortest_subarray(vec![1, 2, 3]), 0);
        assert_eq!(
            Solution::find_length_of_shortest_subarray(vec![1, 2, 3, 10, 0, 7, 8, 9]),
            2
        );
    }
}
