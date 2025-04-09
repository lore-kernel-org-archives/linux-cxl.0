Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46AB025E474;
	Wed,  9 Apr 2025 11:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744198798; cv=none; b=SXfpWOSa1laoslAd3ZtMHa9j2k7coYh5TxLapW5B9mo/Dp05kEcT5B1qO4BaoHGxg5T5OsPE2z+bKXZh6quvR0u3Sc2UDl1Gwl+S7gr/WjkiXW4AKq3SZLMMZ9/e2idf1JQXrsvR1VX0Epy9gpHbwn92URqiFoy0p+TQ4jYsNIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744198798; c=relaxed/simple;
	bh=hAoiYJ1KpT5w+knPplkQ1VLji4L1Fq9dNFccUY+PH1o=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GRXgcrUPHhFqtw6h9ZHMf3fIll4XeeOqR1qBGGRtiMzFL3GDHXUefvp+QjqN+mWSoHh1O6YbBP4RwtMhquaL7/6uw+pDB51n0wL4zGItWQnf9dsDa4bDHbEYdrKjGcyYklyHPMmYcMtZ5mkCHRMcu3KOjVIR6fXmNHlx4HWwghc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-93-67f65c8475e1
Message-ID: <b58f2dd6-d978-487a-b420-badfb4847c00@sk.com>
Date: Wed, 9 Apr 2025 20:39:47 +0900
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: kernel_team@skhynix.com, gourry@gourry.net, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
 joshua.hahnjy@gmail.com, dan.j.williams@intel.com,
 ying.huang@linux.alibaba.com, Jonathan.Cameron@huawei.com,
 osalvador@suse.de, yunjeong.mun@sk.com
Subject: Re: [PATCH v7 3/3] mm/mempolicy: Support memory hotplug in weighted
 interleave
To: David Hildenbrand <david@redhat.com>, Rakie Kim <rakie.kim@sk.com>,
 akpm@linux-foundation.org
References: <20250408073243.488-1-rakie.kim@sk.com>
 <20250408073243.488-4-rakie.kim@sk.com>
 <19562f7e-38ce-41fc-8dfc-bfd6b1259291@redhat.com>
Content-Language: ko
From: Honggyu Kim <honggyu.kim@sk.com>
In-Reply-To: <19562f7e-38ce-41fc-8dfc-bfd6b1259291@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOIsWRmVeSWpSXmKPExsXC9ZZnoW5LzLd0g5fnuC3mrF/DZjF96gVG
	i6/rfzFb/Lx7nN1i1cJrbBbHt85jtzg/6xSLxeVdc9gs7q35z2pxZlqRxeo1GQ7cHjtn3WX3
	6G67zO7RcuQtq8fiPS+ZPDZ9msTucWLGbxaPnQ8tPd7vu8rmsfl0tcfnTXIBXFFcNimpOZll
	qUX6dglcGSsmphdsEqm417edsYHxgkAXIyeHhICJxOHGqWxdjBxg9sZPoSBhXgFLiWPzrzCD
	2CwCKhKLbk9ghIgLSpyc+YQFxBYVkJe4f2sGexcjFwezwEwmiRdH17KCzBEWiJT42e8MUiMi
	kCxx+MwZZpAaIYGJjBKTLvxgB0kwC4hIzO5sA1vAJqAmceXlJCaQXk4BO4l5vbYQJWYSXVu7
	GCFseYnmrbPB5kgITGaXWLN1IjvE/ZISB1fcYJnAKDgLyX2zkKyYhWTWLCSzFjCyrGIUyswr
	y03MzDHRy6jMy6zQS87P3cQIjK5ltX+idzB+uhB8iFGAg1GJh/eGytd0IdbEsuLK3EOMEhzM
	SiK8byd+SRfiTUmsrEotyo8vKs1JLT7EKM3BoiTOa/StPEVIID2xJDU7NbUgtQgmy8TBKdXA
	qFASYHO1WrzQxe39z/T+1vtWM1PbfTtP39j17vvtSw/O8+qqClw+0aTk+8KlU23K8zJdz7Oy
	VZGus+dl3xadYcak+qmCJ/X/zYbfd0OD7QU97R4sb32+ZdmOea3TtddG51z7eP/awtcnD5Y9
	C3W7vTMs12KvVPF78c287HwVC1PtlzqfT57ircRSnJFoqMVcVJwIADixI0eqAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphkeLIzCtJLcpLzFFi42LhmqGlp9sc8y3dYOcNS4s569ewWUyfeoHR
	4uv6X8wWP+8eZ7dYtfAam8XxrfPYLQ7PPclqcX7WKRaLy7vmsFncW/Of1eLMtCKLQ9ees1qs
	XpNh8XvbCjYHPo+ds+6ye3S3XWb3aDnyltVj8Z6XTB6bPk1i9zgx4zeLx86Hlh7v911l8/h2
	28Nj8YsPTB6bT1d7fN4kF8ATxWWTkpqTWZZapG+XwJWxYmJ6wSaRint92xkbGC8IdDFycEgI
	mEhs/BTaxcjJwStgKXFs/hVmEJtFQEVi0e0JjBBxQYmTM5+wgNiiAvIS92/NYO9i5OJgFpjJ
	JPHi6FpWkDnCApESP/udQWpEBJIlDp85wwxSIyQwkVFi0oUf7CAJZgERidmdbWAL2ATUJK68
	nMQE0sspYCcxr9cWosRMomtrFyOELS/RvHU28wRGvllIzpiFZNIsJC2zkLQsYGRZxSiSmVeW
	m5iZY6pXnJ1RmZdZoZecn7uJERhHy2r/TNzB+OWy+yFGAQ5GJR7eGypf04VYE8uKK3MPMUpw
	MCuJ8L6d+CVdiDclsbIqtSg/vqg0J7X4EKM0B4uSOK9XeGqCkEB6YklqdmpqQWoRTJaJg1Oq
	gVHx++d+Ef31LP83b7i8R/aApmqLb/bT0GPCfqdmC274zLNFvMjuVrjNndZ9u73kc063rnKb
	d1hlz5f1q3ZwVL2SkmZ9mmm0xP9aqsCDnS77tUOS/3zaunP36kOPLth6/+f6oafocqbZ79FZ
	DVmhRb2/X00Lt9Wr8t5huKB9x0mH5aVTT/mfnbdKiaU4I9FQi7moOBEA2u1VLZ8CAAA=
X-CFilter-Loop: Reflected

Hi David,

On 4/9/2025 6:05 PM, David Hildenbrand wrote:
> On 08.04.25 09:32, Rakie Kim wrote:
>> The weighted interleave policy distributes page allocations across multiple
>> NUMA nodes based on their performance weight, thereby improving memory
>> bandwidth utilization. The weight values for each node are configured
>> through sysfs.
>>
>> Previously, sysfs entries for configuring weighted interleave were created
>> for all possible nodes (N_POSSIBLE) at initialization, including nodes that
>> might not have memory. However, not all nodes in N_POSSIBLE are usable at
>> runtime, as some may remain memoryless or offline.
>> This led to sysfs entries being created for unusable nodes, causing
>> potential misconfiguration issues.
>>
>> To address this issue, this patch modifies the sysfs creation logic to:
>> 1) Limit sysfs entries to nodes that are online and have memory, avoiding
>>     the creation of sysfs entries for nodes that cannot be used.
>> 2) Support memory hotplug by dynamically adding and removing sysfs entries
>>     based on whether a node transitions into or out of the N_MEMORY state.
>>
>> Additionally, the patch ensures that sysfs attributes are properly managed
>> when nodes go offline, preventing stale or redundant entries from persisting
>> in the system.
>>
>> By making these changes, the weighted interleave policy now manages its
>> sysfs entries more efficiently, ensuring that only relevant nodes are
>> considered for interleaving, and dynamically adapting to memory hotplug
>> events.
>>
>> Signed-off-by: Rakie Kim <rakie.kim@sk.com>
>> Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
>> Signed-off-by: Yunjeong Mun <yunjeong.mun@sk.com>
> 
> 
> Why are the other SOF in there? Are there Co-developed-by missing?

I initially found the problem and fixed it with my internal implementation but
Rakie also had his idea so he started working on it.  His initial implementation
has almost been similar to mine.

I thought Signed-off-by is a way to express the patch series contains our
contribution, but if you think it's unusual, then I can add this.

   Co-developed-by: Honggyu Kim <honggyu.kim@sk.com>
   Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>

For Yunjeong, the following can be added.

   Tested-by: Yunjeong Mun <yunjeong.mun@sk.com>

However, this patch series is already in Andrew's mm-new so I don't want to
bother him again unless we need to update this patches for other reasons.

Is this okay?

Thanks,
Honggyu

> 
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> 

