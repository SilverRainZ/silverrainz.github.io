pub struct Solution;

impl Solution {
    pub fn eval_rpn(tokens: Vec<String>) -> i32 {
        // op in range [-200, 200]
        let mut ops = vec![0];
        for i in 0..tokens.len() {
            match tokens[i].as_str() {
                "+" => {
                    let op2 = ops.pop().unwrap();
                    let op1 = ops.pop().unwrap();
                    ops.push(op1 + op2);
                }
                "-" => {
                    let op2 = ops.pop().unwrap();
                    let op1 = ops.pop().unwrap();
                    ops.push(op1 - op2);
                }
                "*" => {
                    let op2 = ops.pop().unwrap();
                    let op1 = ops.pop().unwrap();
                    ops.push(op1 * op2);
                }
                "/" => {
                    let op2 = ops.pop().unwrap();
                    let op1 = ops.pop().unwrap();
                    ops.push(op1 / op2);
                }
                _ => {
                    ops.push(tokens[i].parse::<i32>().unwrap());
                }
            }
        }
        ops.pop().unwrap()
    }
}

pub fn conv(v: Vec<&str>) -> Vec<String> {
    v.iter().map(|x| x.to_string()).collect()
}

#[cfg(test)]
mod tests {
    use super::*;
    #[test]
    fn it_works() {
        assert_eq!(Solution::eval_rpn(conv(vec!["2", "1", "+", "3", "*"])), 9);
        assert_eq!(Solution::eval_rpn(conv(vec!["-100"])), -100);
        assert_eq!(Solution::eval_rpn(conv(vec!["4", "13", "5", "/", "+"])), 6);
        assert_eq!(
            Solution::eval_rpn(conv(vec![
                "10", "6", "9", "3", "+", "-11", "*", "/", "*", "17", "+", "5", "+"
            ])),
            22
        );
    }
}
