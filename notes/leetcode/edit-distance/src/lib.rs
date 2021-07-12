pub struct Solution;

use std::cmp;

impl Solution {
    pub fn min_distance(word1: String, word2: String) -> i32 {
        let word1: Vec<char> = word1.chars().collect();
        let word2: Vec<char> = word2.chars().collect();
        let mut d = vec![vec![0; word2.len() + 1]; word1.len() + 1];
        for i in 0..word1.len() + 1 {
            d[i][0] = i
        }
        for i in 0..word2.len() + 1 {
            d[0][i] = i
        }
        for i in 1..word1.len() + 1 {
            for j in 1..word2.len() + 1 {
                d[i][j] = cmp::min(d[i - 1][j], d[i][j - 1]) + 1;
                if word1[i - 1] == word2[j - 1] {
                    d[i][j] = cmp::min(d[i][j], d[i - 1][j - 1]);
                } else {
                    d[i][j] = cmp::min(d[i][j], d[i - 1][j - 1] + 1);
                }
            }
        }
        d[word1.len()][word2.len()] as i32
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    #[test]
    fn it_works() {
        assert_eq!(
            Solution::min_distance(String::from("horse"), String::from("ros")),
            3
        );
        assert_eq!(
            Solution::min_distance(String::from("intention"), String::from("execution")),
            5
        );
    }
}
