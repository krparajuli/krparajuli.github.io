---
layout: post
title:  "CICD with Jenkins: Installation and Setup"
date:   2021-01-21 21:03:36 -0500
categories: CI/CD Jenkins Git Version-Control
---

46. Permutations
Medium

Given an array nums of distinct integers, return all the possible permutations. You can return the answer in any order.

https://leetcode.com/problems/permutations/


```python
class Solution(object):
    def permute(self, nums):
        """
        :type nums: List[int]
        :rtype: List[List[int]]
        """
        arr = []
        if len(nums) == 1:
            return [nums]
        for i in range(len(nums)):
            for result in self.permute(nums[:i]+nums[i+1:]):
                result.append(nums[i])
                arr.append(result)
        return arr
```