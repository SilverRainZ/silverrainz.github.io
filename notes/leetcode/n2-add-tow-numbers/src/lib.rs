// Definition for singly-linked list.
#[derive(PartialEq, Eq, Clone, Debug)]
pub struct ListNode {
    pub val: i32,
    pub next: Option<Box<ListNode>>
}

impl ListNode {
    #[inline]
    fn new(val: i32) -> Self {
        ListNode {
            next: None,
            val
        }
    }
}

pub struct Solution;

impl Solution {
    pub fn add_two_numbers(l1: Option<Box<ListNode>>, l2: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
        let sum = Some(Box::new(ListNode::new(-1)));
        let mut carry = 0;
        {
            let mut cursor = &sum;
            let mut ml1 = l1;
            let mut ml2 = l2;
            loop {
                if ml1 == None && ml2 == None {
                    break;
                }
                let mut val:i32 = carry;
                if ml1 != None {
                    val += ml1.unwrap().val;
                }
                if ml2 != None {
                    val += ml2.unwrap().val;
                }
                carry = val / 10;
                let digit = Some(Box::new(ListNode::new(val % 10)));
                cursor.unwrap().next = digit;
                cursor = &cursor.unwrap().next;
                ml1 = ml1.unwrap().next;
                ml2 = ml2.unwrap().next;
            }
            if carry != 0 {
                cursor.unwrap().next = Some(Box::new(ListNode::new(carry)));
            }
        }
        sum
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    #[test]
    fn it_works() {
        assert_eq!(Solution::add_two_numbers(
                Some(Box::new(ListNode::new(1))),
                Some(Box::new(ListNode::new(2)))),
                Some(Box::new(ListNode::new(3))));
    }
}
