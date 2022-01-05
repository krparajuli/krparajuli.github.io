---
layout: post
title:  "Leetcode 70 - Climbing Stairs (Easy)"
date:   2021-01-21 21:03:36 -0500
categories: Programming-Problems Leetcode Dynamic-Programming DP Stairs Climbing-Stairs Easy
---

70. Climbing Stairs (Easy)

You are climbing a staircase. It takes n steps to reach the top.
Each time you can either climb 1 or 2 steps. In how many distinct ways can you climb to the top?

https://leetcode.com/problems/climbing-stairs/


```python 
class Solution: 
    memo = [
    l = 3
    
    def climbStairs(self, n: int) -> int:
        if n <= self.l:
            return self.memo[n]
        
        pos_steps = [2,1]
        ways = 0
        for st in pos_steps:
            self.memo[n-st] = self.climbStairs(n-st)
            ways += self.memo[n-st]
            if n-st > self.l: self.l = n-st

        self.memo[n] = ways
        return ways
```
### Evaluation:
5:72

* This code is having to make function calls repeatedly. Thus, it suffers from overhead of function calling.
* It also has a quite a few conditionals

The following re-attempt did not outperform the above code becuase of the same function calling overhead.
```python
class Solution:
    
    memo = [0]*46
    memo[1] = 1
    memo[2] = 2
    
    def climbStairs(self, n: int) -> int:
        if self.memo[n] != 0:
            return self.memo[n]
        
        pos_steps = [1,2]
        ways = 0
        for st in pos_steps:
            ways += self.climbStairs(n-st)
        
        self.memo[n] = ways
        return ways
```

### Just calculate all at once
Instead of repeatedly calling the function in a recursive way, we can just implement the loop and calculate the values without conditionals.

```python
class Solution:    
    def climbStairs(self, n: int) -> int:
        memo = [0,1,2]
        if n<=2: return n
        for i in range(3,n+1):
            memo.append(memo[i-1]+memo[i-2])
        return memo[-1]
```
**Result: 94:91**

Runtime: 24 ms, faster than **94.68%** of Python3 online submissions for Climbing Stairs.

Memory Usage: 14 MB, less than **91.11%** of Python3 online submissions for Climbing Stairs.

