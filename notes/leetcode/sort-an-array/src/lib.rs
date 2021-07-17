pub struct Solution;

pub fn partition(nums: &mut Vec<i32>, l: usize, r: usize) -> usize {
    println!("before: {:?}", nums);
    println!("pivot: {}, [{}, {})", nums[l], l, r);
    let pivot = nums[r];
    let mut ptr = l;
    for i in l..r {
        println!("cmp: {} and {}", nums[i], pivot);
        if nums[i] <= pivot {
            nums.swap(ptr, i);
            ptr += 1;
            println!("swap: {} <-> {}", nums[i], nums[ptr]);
        }
    }
    ptr
}

pub fn quick_sort(nums: &mut Vec<i32>, l: usize, r: usize) {
    if l >= r {
        return;
    }
    let m = partition(nums, l, r);
    quick_sort(nums, l, m - 1);
    quick_sort(nums, m + 1, r);
}

impl Solution {
    pub fn sort_array(nums: Vec<i32>) -> Vec<i32> {
        let mut nums = nums.clone();
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
        // assert_eq!(Solution::sort_array(vec![5, 3, 2, 5]), vec![2, 3, 5, 5]);
        assert_eq!(
            Solution::sort_array(vec![1, 5, 3, 2, 1, 0]),
            vec![0, 1, 2, 3, 4]
        );
    }
}
