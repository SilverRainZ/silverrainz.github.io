pub struct Solution;

pub fn combination_sum2_rec(
    res: &mut Vec<Vec<i32>>,
    candidates: &Vec<i32>,
    remaining: i32,
    index: usize,
    cur: Vec<i32>,
) {
    if remaining == 0 {
        res.push(cur);
        return;
    }
    if remaining < 0 {
        return;
    }
    let mut next_index = index;
    for i in next_index + 1..candidates.len() {
        if candidates[i] != candidates[index] {
            next_index = i;
            break;
        }
    }
    if index < candidates.len() {
        let mut next = cur.clone();
        next.push(candidates[index]);
        combination_sum2_rec(
            res,
            candidates,
            remaining - candidates[index],
            index + 1,
            next,
        );
    }
    if next_index != index && next_index < candidates.len() {
        combination_sum2_rec(res, candidates, remaining, next_index, cur);
    }
}

impl Solution {
    pub fn combination_sum2(candidates: Vec<i32>, target: i32) -> Vec<Vec<i32>> {
        let mut candidates = candidates;
        candidates.sort();
        let mut res: Vec<Vec<i32>> = Vec::new();
        combination_sum2_rec(&mut res, &candidates, target, 0, vec![]);
        res
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    #[test]
    fn it_works() {
        assert_eq!(
            Solution::combination_sum2(vec![10, 1, 2, 7, 6, 1, 5], 8),
            vec![vec![1, 1, 6], vec![1, 2, 5], vec![1, 7], vec![2, 6]]
        );
        assert_eq!(
            Solution::combination_sum2(vec![2, 5, 2, 1, 2], 5),
            vec![vec![1, 2, 2], vec![5]]
        );
        assert_eq!(Solution::combination_sum2(vec![1, 1], 1), vec![vec![1]]);
    }
}
