---
layout: post
title:  "Terraforming a AWS EC2 Compute Instance"
author: Kalyan Parajuli
date:   2021-02-10 23:00:00 -0500
categories: AWS EC2 Compute Terraform IaC Infrastructure-as-Code Infrastructure
comments: true
---
1010. Pairs of Songs With Total Durations Divisible by 60
Medium

You are given a list of songs where the ith song has a duration of time[i] seconds.

Return the number of pairs of songs for which their total duration in seconds is divisible by 60. Formally, we want the number of indices i, j such that i < j with (time[i] + time[j]) % 60 == 0.

https://leetcode.com/problems/pairs-of-songs-with-total-durations-divisible-by-60/

```python
class Solution:
    def numPairsDivisibleBy60(self, time: List[int]) -> int:
        dic = {}
        for i in range(len(time)):
            rem = time[i]%60
            if rem in dic:
                dic[rem].append(i)
            else:
                dic[rem] = [i]
        
        count = 0
        for i in range(len(time)):
            rem = time[i]%60
            s = 0 if not rem else 60-rem
            if s in dic:
                if s in [0, 30]:
                    count += 0 if len(dic[s])==1 else (len(dic[s])*(len(dic[s])-1))//2
                else:
                    count += len(dic[s])
                if rem in dic:
                    dic.pop(rem)
        return count
```