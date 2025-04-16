Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9B932C8B;
	Wed, 16 Apr 2025 04:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744776287; cv=none; b=hBxs7/ByIUkJD33e0FUFsgS+SadW+d8bKjEXZI5XCy1ABrwDhi7O0a44t5esjoVtSRboYFUIPToMgF0T8RYXNk4fGsykzJTEgaJZi0YTfBeVQZYQVSX384ii+P/u4lBkwRFw9/sdA7EkZxI+TEl2w33nejdMlBIxiUhXUECLqto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744776287; c=relaxed/simple;
	bh=tR5NCxgBrZ5dlUUTfvHg8SYSWUH/c06+Wm8l6CSVaeA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BhJg9E78TFc70f42TlesQN5GznSm4RrxNtqF5DPVkszxsK3PBr+kcBG1DtJtQP9b9ChMsGYGN6h84hACFJFRoL0F+LHcZdLjjRA6Mw3563u4M18oPd1bnV6JLAI6TGQem143yOkuBWB0bYrYQuJgvgixRjeNz+nZClSWUsPfdbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-41-67ff2c50f434
Message-ID: <6a651c16-7ffc-42a5-8c98-95949073c804@sk.com>
Date: Wed, 16 Apr 2025 13:04:32 +0900
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: kernel_team@skhynix.com, akpm@linux-foundation.org, gourry@gourry.net,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
 joshua.hahnjy@gmail.com, dan.j.williams@intel.com,
 ying.huang@linux.alibaba.com, david@redhat.com, osalvador@suse.de,
 yunjeong.mun@sk.com
Subject: Re: [PATCH v7 3/3] mm/mempolicy: Support memory hotplug in weighted
 interleave
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Rakie Kim <rakie.kim@sk.com>
References: <20250408073243.488-1-rakie.kim@sk.com>
 <20250408073243.488-4-rakie.kim@sk.com> <20250415170031.0000372b@huawei.com>
Content-Language: ko
From: Honggyu Kim <honggyu.kim@sk.com>
In-Reply-To: <20250415170031.0000372b@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGIsWRmVeSWpSXmKPExsXC9ZZnkW6gzv90g2+vGC3mrF/DZjF96gVG
	i6/rfzFb/Lx7nN1i1cJrbBbHt85jtzg/6xSLxeVdc9gs7q35z2pxZlqRxeo1GQ7cHjtn3WX3
	6G67zO7RcuQtq8fiPS+ZPDZ9msTucWLGbxaPnQ8tPd7vu8rmsfl0tcfnTXIBXFFcNimpOZll
	qUX6dglcGe9eP2UtmGBVseGtRQNjg34XIweHhICJxInrgTDm3n+WXYycHLwClhItdx4yg9gs
	AqoS9zsmsELEBSVOznzCAmKLCshL3L81g72LkYuDWWAlk8SH+//YQeYIC0RK/Ox3BqkREQiS
	eDrjKdgcIYEmRonO7hQQm1lARGJ2ZxtYnE1ATeLKy0lMIDangKHExlcbmSBqzCS6tnYxQtjy
	EtvfzmEG2SUh0M0u0bNmIVizhICkxMEVN1gmMArOQnLfLCQ7ZiGZNQvJrAWMLKsYhTLzynIT
	M3NM9DIq8zIr9JLzczcxAmNrWe2f6B2Mny4EH2IU4GBU4uGNiP+XLsSaWFZcmXuIUYKDWUmE
	95w5UIg3JbGyKrUoP76oNCe1+BCjNAeLkjiv0bfyFCGB9MSS1OzU1ILUIpgsEwenVAOjU29b
	4oscLc+Hj8oWP9oTElWgH3FVfc6XKWde/dt9J52jY2Kp6zaJkm9b5hxZcPue9Mxqj2fne2JU
	PUKnBC8013qrpntFbZNxkIa2f33GrSfCmyccK4k9ucb28S1bJaGghXE2ivwqJS8iZpQuluyz
	V7P9vEvQ4qn5siPbFgX9+Dmn+6JJXlmFEktxRqKhFnNRcSIAPwjSI6kCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphkeLIzCtJLcpLzFFi42LhmqGlpxug8z/d4OAEQ4s569ewWUyfeoHR
	4uv6X8wWP+8eZ7dYtfAam8XxrfPYLQ7PPclqcX7WKRaLy7vmsFncW/Of1eLMtCKLQ9ees1qs
	XpNh8XvbCjYHPo+ds+6ye3S3XWb3aDnyltVj8Z6XTB6bPk1i9zgx4zeLx86Hlh7v911l8/h2
	28Nj8YsPTB6bT1d7fN4kF8ATxWWTkpqTWZZapG+XwJXx7vVT1oIJVhUb3lo0MDbodzFycEgI
	mEjs/WfZxcjJwStgKdFy5yEziM0ioCpxv2MCK0RcUOLkzCcsILaogLzE/Vsz2LsYuTiYBVYy
	SXy4/48dZI6wQKTEz35nkBoRgSCJpzOegs0REmhilOjsTgGxmQVEJGZ3toHF2QTUJK68nMQE
	YnMKGEpsfLWRCaLGTKJraxcjhC0vsf3tHOYJjHyzkJwxC8moWUhaZiFpWcDIsopRJDOvLDcx
	M8dUrzg7ozIvs0IvOT93EyMwjpbV/pm4g/HLZfdDjAIcjEo8vBHx/9KFWBPLiitzDzFKcDAr
	ifCeMwcK8aYkVlalFuXHF5XmpBYfYpTmYFES5/UKT00QEkhPLEnNTk0tSC2CyTJxcEo1MF6z
	+dRT+SZ3iwXLhb5EzYbfjL/nLFkhuIH5tcM0I8E9XPOzVxoePiGaJzDZhv1SDvOO/+rPF/Pn
	TrrQUxH2M551jRirlQpn0iHD1bvTduZLZIuqindeWsgWpq556MZBlqqVh69uT+h6afX8xKK0
	Os3WVbwym2XnBwXVK8v8jbv0Sk1N8ZfkXSWW4oxEQy3mouJEAJrngYCfAgAA
X-CFilter-Loop: Reflected

Hi Jonathan,

Thanks for reviewing our patches.

I have a few comments and the rest will be addressed by Rakie.

On 4/16/2025 1:00 AM, Jonathan Cameron wrote:
> On Tue, 8 Apr 2025 16:32:42 +0900
> Rakie Kim <rakie.kim@sk.com> wrote:
> 
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
>>     the creation of sysfs entries for nodes that cannot be used.
>> 2) Support memory hotplug by dynamically adding and removing sysfs entries
>>     based on whether a node transitions into or out of the N_MEMORY state.
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
>> Reviewed-by: Oscar Salvador <osalvador@suse.de>
>> ---
>>   mm/mempolicy.c | 106 ++++++++++++++++++++++++++++++++++++++-----------
>>   1 file changed, 83 insertions(+), 23 deletions(-)
>>
>> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
>> index 988575f29c53..9aa884107f4c 100644
>> --- a/mm/mempolicy.c
>> +++ b/mm/mempolicy.c
>> @@ -113,6 +113,7 @@
>>   #include <asm/tlbflush.h>
>>   #include <asm/tlb.h>
>>   #include <linux/uaccess.h>
>> +#include <linux/memory.h>
>>   
>>   #include "internal.h"
>>   
>> @@ -3421,6 +3422,7 @@ struct iw_node_attr {
>>   
>>   struct sysfs_wi_group {
>>   	struct kobject wi_kobj;
>> +	struct mutex kobj_lock;
>>   	struct iw_node_attr *nattrs[];
>>   };
>>   
>> @@ -3470,13 +3472,24 @@ static ssize_t node_store(struct kobject *kobj, struct kobj_attribute *attr,
>>   
>>   static void sysfs_wi_node_delete(int nid)
>>   {
>> -	if (!wi_group->nattrs[nid])
>> +	struct iw_node_attr *attr;
>> +
>> +	if (nid < 0 || nid >= nr_node_ids)
>> +		return;
>> +
>> +	mutex_lock(&wi_group->kobj_lock);
>> +	attr = wi_group->nattrs[nid];
>> +	if (!attr) {
>> +		mutex_unlock(&wi_group->kobj_lock);
>>   		return;
>> +	}
>> +
>> +	wi_group->nattrs[nid] = NULL;
>> +	mutex_unlock(&wi_group->kobj_lock);
>>   
>> -	sysfs_remove_file(&wi_group->wi_kobj,
>> -			  &wi_group->nattrs[nid]->kobj_attr.attr);
>> -	kfree(wi_group->nattrs[nid]->kobj_attr.attr.name);
>> -	kfree(wi_group->nattrs[nid]);
>> +	sysfs_remove_file(&wi_group->wi_kobj, &attr->kobj_attr.attr);
>> +	kfree(attr->kobj_attr.attr.name);
>> +	kfree(attr);
> Here you go through a careful dance to not touch wi_group->nattrs[nid]
> except under the lock, but later you are happy to do so in the
> error handling paths.  Maybe better to do similar to here and
> set it to NULL under the lock but do the freeing on a copy taken
> under that lock.
> .
>>   }
>>   
>>   static void sysfs_wi_release(struct kobject *wi_kobj)
>> @@ -3495,35 +3508,77 @@ static const struct kobj_type wi_ktype = {
>>   
>>   static int sysfs_wi_node_add(int nid)
>>   {
>> -	struct iw_node_attr *node_attr;
>> +	int ret = 0;
> 
> Trivial but isn't ret always set when it is used? So no need to initialize
> here.

If we don't initialize it, then this kind of trivial fixup might be needed later
so I think there is no reason not to initialize it.
https://lore.kernel.org/mm-commits/20240705010631.46743C4AF07@smtp.kernel.org

> 
>>   	char *name;
>> +	struct iw_node_attr *new_attr = NULL;
> 
> This is also always set before use so I'm not seeing a
> reason to initialize it to NULL.

Ditto.

> 
> 
>>   
>> -	node_attr = kzalloc(sizeof(*node_attr), GFP_KERNEL);
>> -	if (!node_attr)
>> +	if (nid < 0 || nid >= nr_node_ids) {
>> +		pr_err("Invalid node id: %d\n", nid);
>> +		return -EINVAL;
>> +	}
>> +
>> +	new_attr = kzalloc(sizeof(struct iw_node_attr), GFP_KERNEL);
> 
> I'd prefer sizeof(*new_attr) because I'm lazy and don't like checking
> types for allocation sizes :)  Local style seems to be a bit
> of a mix though.

Agreed.

> 
>> +	if (!new_attr)
>>   		return -ENOMEM;
>>   
>>   	name = kasprintf(GFP_KERNEL, "node%d", nid);
>>   	if (!name) {
>> -		kfree(node_attr);
>> +		kfree(new_attr);
>>   		return -ENOMEM;
>>   	}
>>   
>> -	sysfs_attr_init(&node_attr->kobj_attr.attr);
>> -	node_attr->kobj_attr.attr.name = name;
>> -	node_attr->kobj_attr.attr.mode = 0644;
>> -	node_attr->kobj_attr.show = node_show;
>> -	node_attr->kobj_attr.store = node_store;
>> -	node_attr->nid = nid;
>> +	mutex_lock(&wi_group->kobj_lock);
>> +	if (wi_group->nattrs[nid]) {
>> +		mutex_unlock(&wi_group->kobj_lock);
>> +		pr_info("Node [%d] already exists\n", nid);
>> +		kfree(new_attr);
>> +		kfree(name);
>> +		return 0;
>> +	}
>> +	wi_group->nattrs[nid] = new_attr;

This set can be done after all the "wi_group->nattrs[nid]" related set is done.

>>   
>> -	if (sysfs_create_file(&wi_group->wi_kobj, &node_attr->kobj_attr.attr)) {
>> -		kfree(node_attr->kobj_attr.attr.name);
>> -		kfree(node_attr);
>> -		pr_err("failed to add attribute to weighted_interleave\n");
>> -		return -ENOMEM;
>> +	sysfs_attr_init(&wi_group->nattrs[nid]->kobj_attr.attr);
> 
> I'd have been tempted to use the new_attr pointer but perhaps
> this brings some documentation like advantages.

+1

> 
>> +	wi_group->nattrs[nid]->kobj_attr.attr.name = name;
>> +	wi_group->nattrs[nid]->kobj_attr.attr.mode = 0644;
>> +	wi_group->nattrs[nid]->kobj_attr.show = node_show;
>> +	wi_group->nattrs[nid]->kobj_attr.store = node_store;
>> +	wi_group->nattrs[nid]->nid = nid;

As Jonathan mentioned, all the "wi_group->nattrs[nid]" here is better to be
"new_attr" for simplicity.

Thanks,
Honggyu

>> +
>> +	ret = sysfs_create_file(&wi_group->wi_kobj,
>> +				&wi_group->nattrs[nid]->kobj_attr.attr);
>> +	if (ret) {
>> +		kfree(wi_group->nattrs[nid]->kobj_attr.attr.name);
> 
> See comment above on the rather different handling here to in
> sysfs_wi_node_delete() where you set it to NULL first, release the lock and tidy up.
> new_attrand name are still set so you could even combine the handling with the
> if (wi_group->nattrs[nid]) above via appropriate gotos.
> 
>> +		kfree(wi_group->nattrs[nid]);
>> +		wi_group->nattrs[nid] = NULL;
>> +		pr_err("Failed to add attribute to weighted_interleave: %d\n", ret);
>>   	}
>> +	mutex_unlock(&wi_group->kobj_lock);
>>   
>> -	wi_group->nattrs[nid] = node_attr;
>> -	return 0;
>> +	return ret;
>> +}
> 
> 
