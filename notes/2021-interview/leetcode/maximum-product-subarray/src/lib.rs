pub struct Solution;

use std::cmp;

impl Solution {
    pub fn max_product(nums: Vec<i32>) -> i32 {
        let mut products = vec![0; nums.len()];
        let mut products_neg = vec![0; nums.len()];
        products[0] = if nums[0] > 0 {nums[0]} else {0};
        products_neg[0] = if nums[0] < 0 {nums[0]} else {0};
        let mut res = nums[0];
        for i in 1..nums.len() {
            let p = products[i-1]*nums[i];
            let p_neg = products_neg[i-1]*nums[i];
            products[i] = cmp::max(p, nums[i]);
            products[i] = cmp::max(products[i], p_neg);
            products_neg[i] = cmp::min(p_neg, nums[i]);
            products_neg[i] = cmp::min(products_neg[i], p);
            res = cmp::max(res, products[i]);
        }
        //println!("{:?}", products);
        //println!("{:?}", products_neg);

        res
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    #[test]
    fn it_works() {
        assert_eq!(Solution::max_product(vec![-2, 0, -1]), 0);
        assert_eq!(Solution::max_product(vec![-2, 2, 3, -5]), 60);
        assert_eq!(Solution::max_product(vec![2, 3, -5]), 6);
        assert_eq!(Solution::max_product(vec![2,3,-2,4]), 6);
        assert_eq!(Solution::max_product(vec![-2]), -2);
        assert_eq!(Solution::max_product(vec![-100,-2]), 200);
        assert_eq!(Solution::max_product(vec![-100, 2]), 2);
    }
}
