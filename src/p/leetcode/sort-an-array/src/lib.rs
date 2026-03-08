pub struct Solution;

pub fn partition(nums: &mut [i32]) -> usize {
    let l = 0;
    let r = nums.len();
    if r == 1 {
        return 0;
    }

    let pivotidx = r/2 as usize;
    nums.swap(pivotidx, r-1);
    let pivot = nums[r-1];

    let mut ptr = l;
    for i in l..r {
        if nums[i] <= pivot {
            if ptr != i {
                nums.swap(i, ptr);
            }
            ptr += 1;
        }
    }
    ptr-1
}

pub fn quick_sort(nums: &mut [i32])  {
    if nums.len() < 2 {
        return
    }
    let mid = partition(nums);
    if mid > 1 {
        quick_sort(&mut nums[0..mid]);
    }
    if mid < nums.len() - 2 {
        quick_sort(&mut nums[mid+1..]);
    }
}

impl Solution {
    pub fn sort_array(nums: Vec<i32>) -> Vec<i32> {
        let mut nums = nums.clone();
        quick_sort(&mut nums);
        nums
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    #[test]
    fn it_works() {
        assert_eq!(Solution::sort_array(vec![5, 3, 2, 5]), vec![2, 3, 5, 5]);
        assert_eq!(
            Solution::sort_array(vec![1, 5, 3, 2, 1, 0]),
            vec![0, 1, 1, 2, 3, 5]
        );
        assert_eq!(Solution::sort_array(vec![]), vec![]);
        assert_eq!(Solution::sort_array(vec![1]), vec![1]);
        assert_eq!(Solution::sort_array(vec![1, 2]), vec![1, 2]);
    }
}
