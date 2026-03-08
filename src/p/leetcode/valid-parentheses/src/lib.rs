pub struct Solution;

impl Solution {
    pub fn is_valid(s: String) -> bool {
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
