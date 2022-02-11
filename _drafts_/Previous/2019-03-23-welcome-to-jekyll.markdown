---
layout: post
title:  "Pinned Post 1"
date:   2019-03-23 21:03:36 +0530
categories: Javascript NodeJS
---

75. Sort Colors [Medium]

Given an array nums with n objects colored red, white, or blue, sort them in-place so that objects of the same color are adjacent, with the colors in the order red, white, and blue.

We will use the integers 0, 1, and 2 to represent the color red, white, and blue, respectively.

You must solve this problem without using the library's sort function.

[https://leetcode.com/problems/sort-colors/](https://leetcode.com/problems/sort-colors/)
```python
class Solution(object):
    def sortColors(self, nums):
        """
        :type nums: List[int]
        :rtype: None Do not return anything, modify nums in-place instead.
        """
        count = [0,0,0]
        for i in nums:
            count[i]+=1
        for i in range(0, count[0]):
            nums[i] = 0
        for i in range(count[0],count[1]+count[0]):
            nums[i] = 1
        for i in range(count[0]+count[1], len(nums)):
            nums[i] = 2
```
     
```python
class Solution(object):
    def sortColors(self, nums):
        """
        :type nums: List[int]
        :rtype: None Do not return anything, modify nums in-place instead.
        """
        lo1,hi1=0,0
        for i in nums:
            if i == 0:
                nums[lo1]=0
                lo1+=1
                if hi1 >= lo1:
                    nums[hi1]=1
                hi1+=1
            elif i == 1:
                nums[hi1]=1
                hi1+=1
        for i in range(hi1,len(nums)):
            nums[i]=2
```
        
            

