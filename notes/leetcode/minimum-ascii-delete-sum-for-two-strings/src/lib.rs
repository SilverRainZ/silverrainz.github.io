pub struct Solution;

use std::cmp;

impl Solution {
    pub fn minimum_delete_sum(s1: String, s2: String) -> i32 {
        let s1: Vec<char> = s1.chars().collect();
        let s2: Vec<char> = s2.chars().collect();
        let mut del = vec![vec![0; s2.len() + 1]; s1.len() + 1];
        for i in 1..s1.len() + 1 {
            del[i][0] = del[i - 1][0] + s1[i - 1] as i32;
        }
        for i in 1..s2.len() + 1 {
            del[0][i] = del[0][i - 1] + s2[i - 1] as i32;
        }
        for i in 1..s1.len() + 1 {
            for j in 1..s2.len() + 1 {
                if s1[i - 1] == s2[j - 1] {
                    del[i][j] = cmp::min(
                        cmp::min(
                            del[i - 1][j] + s1[i - 1] as i32,
                            del[i][j - 1] + s2[j - 1] as i32,
                        ),
                        del[i - 1][j - 1],
                    );
                } else {
                    del[i][j] = cmp::min(
                        cmp::min(
                            del[i - 1][j] + s1[i - 1] as i32,
                            del[i][j - 1] + s2[j - 1] as i32,
                        ),
                        del[i - 1][j - 1] + s1[i - 1] as i32 + s2[j - 1] as i32,
                    );
                }
            }
        }
        del[s1.len()][s2.len()]
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    #[test]
    fn it_works() {
        assert_eq!(
            Solution::minimum_delete_sum(String::from("sea"), String::from("eat")),
            231
        );
        assert_eq!(
            Solution::minimum_delete_sum(String::from("delete"), String::from("leet")),
            403
        );
    }
}
