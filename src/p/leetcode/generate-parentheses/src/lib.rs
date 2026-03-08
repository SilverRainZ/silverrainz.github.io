pub struct Solution;

pub fn generate_parenthesis_rec(
    ans: &mut Vec<String>,
    remaining: i32,
    unclosed: i32,
    cur: Vec<char>,
) {
    let mut cur = cur.clone();
    if remaining == 0 {
        for _i in 0..unclosed {
            cur.push(')')
        }
        ans.push(cur.iter().collect());
        return;
    }
    for i in 0..unclosed + 1 {
        let mut next = cur.clone();
        next.push('(');
        generate_parenthesis_rec(ans, remaining - 1, unclosed - i + 1, next);
        cur.push(')');
    }
}

impl Solution {
    pub fn generate_parenthesis(n: i32) -> Vec<String> {
        let mut res: Vec<String> = Vec::new();
        generate_parenthesis_rec(&mut res, n, 0, vec![]);
        res
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    #[test]
    fn it_works() {
        assert_eq!(Solution::generate_parenthesis(1), vec!["()"]);
        assert_eq!(
            Solution::generate_parenthesis(3),
            vec!["((()))", "(()())", "(())()", "()(())", "()()()"]
        );
    }
}
