53. Maximum Subarray
Easy

Given an integer array nums, find the contiguous subarray (containing at least one number) which has the largest sum and return its sum.

A subarray is a contiguous part of an array.
https://leetcode.com/problems/maximum-subarray/


```python
class Solution:
    def maxSubArray(self, nums: List[int]) -> int:
        if len(nums) == 1: return nums[0]
        
        sm = mxSum = nums[0]
        for i in nums[1:]:
            sm = max(sm+i, i)
            mxSum = max(mxSum, sm)
            
        return mxSum
```
