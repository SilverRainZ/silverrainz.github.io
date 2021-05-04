pub struct Solution;

impl Solution {
    pub fn is_valid(s: String) -> bool {
        let mut stack = Vec::new();
        for ch in s.chars() {
            match ch {
                '(' | '{' | '[' => stack.push(ch),
                ']' => {
                    let _ = match stack.last() {
                        Some('[') => stack.pop(),
                        _ => return false,
                    };
                },
                '}' => {
                    let _ = match stack.last() {
                        Some('{') => stack.pop(),
                        _ => return false,
                    };
                },
                ')' => {
                    let _ = match stack.last() {
                        Some('(') => stack.pop(),
                        _ => return false,
                    };
                },
                _ => panic!("no parenthes!"),
            }
        }
        return stack.len() == 0
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    #[test]
    fn it_works() {
        assert_eq!(true, Solution::is_valid(String::from("[][]"), ));
        assert_eq!(false, Solution::is_valid(String::from("[[]"), ));
        assert_eq!(true, Solution::is_valid(String::from("{[]}"), ));
        assert_eq!(false, Solution::is_valid(String::from("{[}]"), ));
    }
}
