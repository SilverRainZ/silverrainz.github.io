pub struct Solution;

pub fn partition(nums: &mut Vec<i32>, l: usize, r: usize) -> usize {
    let pivot = nums[r];
    // println!("before: {:?}", nums);
    // println!("pivot: {}, [{}, {})", pivot, l, r);
    let mut ptr = l;
    for i in l..r {
        // println!("cmp: {} and {}", nums[i], pivot);
        if nums[i] <= pivot {
            nums.swap(ptr, i);
            ptr += 1;
            // println!("swap: {} <-> {}", nums[i], nums[ptr]);
        }
    }
    nums.swap(ptr, r);
    ptr
}

pub fn rand_int(l: usize, r: usize) -> usize {
    let v = vec![2, 3];
    let a = &v as *const Vec<i32>;
    let n = a as usize;
    n % (r - l) + l
}

pub fn partition_rand(nums: &mut Vec<i32>, l: usize, r: usize) -> usize {
    let pivot_idx = rand_int(l, r);
    nums.swap(r, pivot_idx);
    let pivot = nums[r];
    // println!("before: {:?}", nums);
    // println!("pivot: {}, [{}, {})", pivot, l, r);
    let mut ptr = l;
    for i in l..r {
        // println!("cmp: {} and {}", nums[i], pivot);
        if nums[i] <= pivot {
            nums.swap(ptr, i);
            ptr += 1;
            // println!("swap: {} <-> {}", nums[i], nums[ptr]);
        }
    }
    nums.swap(ptr, r);
    ptr
}

pub fn quick_sort(nums: &mut Vec<i32>, l: usize, r: usize) {
    if l >= r {
        return;
    }
    let m = partition_rand(nums, l, r);
    if m > l {
        quick_sort(nums, l, m - 1);
    }
    if r > m {
        quick_sort(nums, m + 1, r);
    }
}

impl Solution {
    pub fn sort_array(nums: Vec<i32>) -> Vec<i32> {
        let mut nums = nums.clone();
        if nums.len() < 2 {
            return nums;
        }
        let r = nums.len() - 1;
        quick_sort(&mut nums, 0, r);
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
