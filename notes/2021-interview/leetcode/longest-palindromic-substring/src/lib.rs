pub struct Solution;

static mut ANS: (i32, i32) = (0, 0);

pub fn reslove_palindrome(s: &Vec<char>, l: i32, r: i32) {
    if l < 0 || r >= s.len() as i32 {
        return;
    }
    if s[l as usize] == s[r as usize] {
        unsafe {
            if r - l > ANS.1 - ANS.0 {
                ANS = (l, r);
            }
        }
        reslove_palindrome(s, l - 1, r + 1);
    }
}

impl Solution {
    // 递归解法
    pub fn longest_palindrome(s: String) -> String {
        unsafe { ANS = (0, 0) };
        let s: Vec<char> = s.chars().collect();
        for i in 0..s.len() {
            reslove_palindrome(&s, i as i32, i as i32);
            if i >= 1 {
                reslove_palindrome(&s, (i - 1) as i32, i as i32);
            }
        }
        let safe_ans = unsafe { (ANS.0 as usize, ANS.1 as usize) };
        s[safe_ans.0..safe_ans.1 + 1].iter().collect::<String>()
    }

    pub fn longest_palindrome2(s: String) -> String {
        let s: Vec<char> = s.chars().collect();
        let mut res = (0, 0);
        let mut d = vec![vec![false; s.len()]; s.len()];
        for i in (0..s.len()).rev() {
            for j in i..s.len() {
                if s[i] == s[j] {
                    if j - i <= 2 {
                        d[i][j] = true;
                    } else {
                        d[i][j] = d[i + 1][j - 1];
                    }
                }
                if d[i][j] {
                    if j - i > res.1 - res.0 {
                        println!("update {:?}", res);
                        res = (i, j);
                    }
                }
            }
        }
        s[res.0..res.1 + 1].iter().collect::<String>()
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    #[test]
    fn it_works() {
        assert_eq!(Solution::longest_palindrome(String::from("babad")), "bab");
        assert_eq!(Solution::longest_palindrome(String::from("cbbd")), "bb");
        assert_eq!(Solution::longest_palindrome(String::from("a")), "a");
        assert_eq!(Solution::longest_palindrome(String::from("aaca")), "aca");
        assert_eq!(Solution::longest_palindrome(String::from("bb")), "bb");

        assert_eq!(Solution::longest_palindrome2(String::from("babad")), "aba");
        assert_eq!(Solution::longest_palindrome2(String::from("cbbd")), "bb");
        assert_eq!(Solution::longest_palindrome2(String::from("a")), "a");
        assert_eq!(Solution::longest_palindrome2(String::from("aaca")), "aca");
        assert_eq!(Solution::longest_palindrome2(String::from("bb")), "bb");
    }
}
