---
layout: post
title:  "Leetcode 740 - Delete and Earn (Medium)"
date:   2021-01-22 21:03:36 -0500
categories: Programming-Problems Dynamic-Programming Delete-and-Earn
---
You are given an integer array nums. You want to maximize the number of points you get by performing the following operation any number of times:

Pick any nums[i] and delete it to earn nums[i] points. Afterwards, you must delete every element equal to nums[i] - 1 and every element equal to nums[i] + 1.

Return the maximum number of points you can earn by applying the above operation some number of times.

[740 - Delete and Earn (Medium)](https://leetcode.com/problems/delete-and-earn/)

Example 1:

Input: nums = [3,4,2]
Output: 6
Explanation: You can perform the following operations:
- Delete 4 to earn 4 points. Consequently, 3 is also deleted. nums = [2].
- Delete 2 to earn 2 points. nums = [].
You earn a total of 6 points.

Example 2:

Input: nums = [2,2,3,3,3,4]
Output: 9
Explanation: You can perform the following operations:
- Delete a 3 to earn 3 points. All 2's and 4's are also deleted. nums = [3,3].
- Delete a 3 again to earn 3 points. nums = [3].
- Delete a 3 once more to earn 3 points. nums = [].
You earn a total of 9 points.

## Solution
```python
# Leetcode rating
# 41st percentile runtime
# 15th percentile storage
class Solution:
    def deleteAndEarn(self, nums: List[int]) -> int:
        mx = 0
        for i in nums: mx = max(mx, i)
        count = [0]*(mx+1)
        
        for i in nums: print(i);count[i] += 1
        
        # Now this is set-up like a Adjacent Robber problem
        dp=[0]*(mx+1)
        dp[0]=0
        dp[1]=count[1]
        for i in range(2, mx+1):
            dp[i] = max(dp[i-2]+i*count[i], dp[i-1])
        
        return dp[-1]
```
### Evaluation
41:15

## Solution with lesser storage
```python
class Solution:
    def deleteAndEarn(self, nums: List[int]) -> int:
        mx = 0
        for i in nums: mx = max(mx, i)
        count = [0]*mx        
        
        for i in nums: count[i-1] += 1
            
        # Now this is set-up like a Adjacent Robber problem
        sl = 0
        l = count[0]
        
        for i in range(2, len(count)+1):
            temp = l
            l = max(sl+i*count[i-1], l)
            sl = temp
        
        return l
```
### Evaluation
41:66

Some others used dictionary for storage; while some used library methods like `Counter` and `sorted`.


