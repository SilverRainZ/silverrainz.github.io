pub struct Solution;

use std::collections::HashSet;

pub fn combination_sum_rec(
    res: &mut Vec<Vec<i32>>,
    set: &HashSet<i32>,
    remaining: i32,
    cur: Vec<i32>,
) {
    if remaining == 0 {
        res.push(cur);
        return;
    }
    if remaining < 0 {
        return;
    }
    let start = if cur.len() > 0 { cur[cur.len() - 1] } else { 1 };
    for i in start..remaining + 1 {
        if !set.contains(&i) {
            continue;
        }
        let mut next = cur.clone();
        next.push(i);
        combination_sum_rec(res, set, remaining - i, next);
    }
}

impl Solution {
    pub fn combination_sum(candidates: Vec<i32>, target: i32) -> Vec<Vec<i32>> {
        let mut set = HashSet::new();
        for i in 0..candidates.len() {
            set.insert(candidates[i]);
        }
        let mut res: Vec<Vec<i32>> = Vec::new();
        combination_sum_rec(&mut res, &set, target, vec![]);
        res
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    #[test]
    fn it_works() {
        assert_eq!(
            Solution::combination_sum(vec![2, 3, 6, 7], 7),
            vec![vec![2, 2, 3], vec![7]]
        );
        assert_eq!(
            Solution::combination_sum(vec![2, 3, 5], 8),
            vec![vec![2, 2, 2, 2], vec![2, 3, 3], vec![3, 5]]
        );
        assert_eq!(Solution::combination_sum(vec![2], 1), vec![]);
        assert_eq!(Solution::combination_sum(vec![1], 1), vec![vec![1]]);
    }
}
