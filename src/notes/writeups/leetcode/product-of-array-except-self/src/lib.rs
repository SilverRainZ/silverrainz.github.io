pub struct Solution;

impl Solution {
    pub fn product_except_self(nums: Vec<i32>) -> Vec<i32> {
        let mut left = vec![1; nums.len()];
        left[1] = nums[0];
        for i in 2..nums.len() {
            left[i] = nums[i - 1] * left[i - 1];
        }
        let mut right = vec![1; nums.len()];
        right[nums.len() - 2] = nums[nums.len() - 1];
        for i in (0..nums.len() - 2).rev() {
            right[i] = nums[i + 1] * right[i + 1];
        }
        for i in 0..nums.len() {
            left[i] = left[i] * right[i];
        }
        left
    }

    pub fn product_except_self2(nums: Vec<i32>) -> Vec<i32> {
        let mut res = vec![1; nums.len()];
        res[1] = nums[0];
        for i in 2..nums.len() {
            res[i] = nums[i - 1] * res[i - 1];
        }
        let mut tmp = nums[nums.len() - 1];
        res[nums.len() - 2] = res[nums.len() - 2] * tmp;
        for i in (0..nums.len() - 2).rev() {
            tmp = tmp * nums[i + 1];
            res[i] = res[i] * tmp;
        }
        res
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    #[test]
    fn it_works() {
        assert_eq!(Solution::product_except_self(vec![1, 2]), vec![2, 1]);
        assert_eq!(
            Solution::product_except_self(vec![1, 2, 3, 4]),
            vec![24, 12, 8, 6]
        );
        assert_eq!(
            Solution::product_except_self(vec![-1, 1, 0, -3, 3]),
            vec![0, 0, 9, 0, 0]
        );

        assert_eq!(Solution::product_except_self2(vec![1, 2]), vec![2, 1]);
        assert_eq!(
            Solution::product_except_self2(vec![1, 2, 3, 4]),
            vec![24, 12, 8, 6]
        );
        assert_eq!(
            Solution::product_except_self2(vec![-1, 1, 0, -3, 3]),
            vec![0, 0, 9, 0, 0]
        );
    }
}
