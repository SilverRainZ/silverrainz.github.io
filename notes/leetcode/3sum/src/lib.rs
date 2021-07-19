pub struct Solution;

impl Solution {
    pub fn three_sum(nums: Vec<i32>) -> Vec<Vec<i32>> {
        let mut res: Vec<Vec<i32>> = Vec::new();
        if nums.len() < 3 {
            return res;
        }
        let mut nums = nums;
        nums.sort();
        for i in 0..nums.len() - 2 {
            if i != 0 && nums[i] == nums[i - 1] {
                continue;
            }
            let mut k = nums.len() - 1;
            for j in i + 1..nums.len() - 1 {
                if j != i + 1 && nums[j] == nums[j - 1] {
                    continue;
                }
                while k > j && nums[i] + nums[j] + nums[k] > 0 {
                    k -= 1;
                }
                if k == j {
                    break;
                }
                if nums[i] + nums[j] + nums[k] == 0 {
                    res.push(vec![nums[i], nums[j], nums[k]]);
                }
            }
        }
        res
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    #[test]
    fn it_works() {
        // assert_eq!(
        //     Solution::three_sum(vec![-1, 0, 1, 2, -1, -4]),
        //     vec![vec![-1, -1, 2], vec![-1, 0, 1]]
        // );
        // assert_eq!(Solution::three_sum(vec![1, 2, -3]), vec![vec![-3, 1, 2]]);
        assert_eq!(
            Solution::three_sum(vec![1, -1, -1, -1, 0, 0, 0, 1, 1, 1, 1]),
            vec![vec![-1, 0, 1], vec![0, 0, 0]]
        );
    }
}
