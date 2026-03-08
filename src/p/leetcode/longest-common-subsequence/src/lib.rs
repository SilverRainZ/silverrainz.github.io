pub struct Solution;

use std::cmp;

impl Solution {
    pub fn longest_common_subsequence(text1: String, text2: String) -> i32 {
        let text1: Vec<char> = text1.chars().collect();
        let text2: Vec<char> = text2.chars().collect();
        let mut d = vec![vec![0; text2.len() + 1]; text1.len() + 1];
        for i in 1..text1.len() + 1 {
            for j in 1..text2.len() + 1 {
                if text1[i - 1] == text2[j - 1] {
                    d[i][j] = d[i - 1][j - 1] + 1;
                } else {
                    d[i][j] = cmp::max(d[i - 1][j], d[i][j - 1]);
                }
            }
        }
        d[text1.len()][text2.len()] as i32
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    #[test]
    fn it_works() {
        assert_eq!(
            Solution::longest_common_subsequence(String::from("abcde"), String::from("ace")),
            3
        );
        assert_eq!(
            Solution::longest_common_subsequence(String::from("abc"), String::from("abc")),
            3
        );
        assert_eq!(
            Solution::longest_common_subsequence(String::from("def"), String::from("def")),
            3
        );
    }
}
