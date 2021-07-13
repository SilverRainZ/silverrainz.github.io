pub struct Solution;

impl Solution {
    pub fn longest_palindrome(s: String) -> String {
        let s: Vec<char> = s.chars().collect();
        let mut p = vec![vec![0; s.len()]; s.len()];
        p[0][0] = 1;
        for i in 0..s.len() {
            p[i][i] = 1;
        }
        for j in 1..s.len()-1 {
            for i in (0..j).rev() {
                if i == j {
                    p[i][j] = 1
                }
                if j-1 == i {
                }
            }
        }
        s[l.0..l.1].iter().collect::<String>()
    }

#[cfg(test)]
    mod tests {
        use super::*;
        #[test]
        fn it_works() {
            // assert_eq!(Solution::longest_palindrome(String::from("babad")), "bab");
            assert_eq!(Solution::longest_palindrome(String::from("cbbd")), "bb");
            // assert_eq!(Solution::longest_palindrome(String::from("a")), "a");
        }
    }
