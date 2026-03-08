pub struct Solution;

use std::cmp;

impl Solution {
    pub fn longest_palindrome_subseq(s: String) -> i32 {
        let s: Vec<char> = s.chars().collect();
        let mut d = vec![vec![0; s.len() + 1]; s.len() + 1];
        for i in 1..s.len() + 1 {
            for j in 1..s.len() + 1 {
                if s[i - 1] == s[s.len() - j] {
                    d[i][j] = d[i - 1][j - 1] + 1;
                } else {
                    d[i][j] = cmp::max(d[i - 1][j], d[i][j - 1]);
                }
            }
        }
        d[s.len()][s.len()] as i32
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    #[test]
    fn it_works() {
        assert_eq!(
            Solution::longest_palindrome_subseq(String::from("bbbab")),
            4
        );
        assert_eq!(Solution::longest_palindrome_subseq(String::from("cbbd")), 2);
    }
}
