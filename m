Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0C61AAE28;
	Mon,  7 Apr 2025 09:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744018776; cv=none; b=HZm4OBzzeR+MRMZRNvVcHxc5VpPpZcxrRllRmcBFYMG+vrcWBZS2vPMyT1g3bNIcezPr8uZ8rfOWGlKJYgDMCdevsUFYDcBv+EID4dMC4cvI/iue05YM3sDVhr8jksFRNbcOjRNoELdn64WtSYbVcOKW/joO1swS2NDddvwGBgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744018776; c=relaxed/simple;
	bh=m4f0r1TcJI62aTa1jc7HClQnsS6wSXaar4/tU0XxWNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iUynL0/S/6PjQBGlE6qSwQUSZEUz3tsuk55V/DCvNSHlX6GF2WVVVhKGZJVvqiHSvvVBYPlg8adv26GYpDSuqguEQN6xTP01P8JicobyT8y1xKpv0gaKIwahvV8dL7fzSDm7xeB5L62xX69eFo3P39bSVUHTJAg5mW4zqj4nRsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-91-67f39d523d72
From: Rakie Kim <rakie.kim@sk.com>
To: David Hildenbrand <david@redhat.com>
Cc: gourry@gourry.net,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	joshua.hahnjy@gmail.com,
	dan.j.williams@intel.com,
	ying.huang@linux.alibaba.com,
	Jonathan.Cameron@huawei.com,
	osalvador@suse.de,
	kernel_team@skhynix.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com,
	Rakie Kim <rakie.kim@sk.com>,
	akpm@linux-foundation.org
Subject: Re: [PATCH v6 3/3] mm/mempolicy: Support memory hotplug in weighted interleave
Date: Mon,  7 Apr 2025 18:39:19 +0900
Message-ID: <20250407093926.450-1-rakie.kim@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <198f2cbe-b1cb-4239-833e-9aac33d978fa@redhat.com>
References: 
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOLMWRmVeSWpSXmKPExsXC9ZZnkW7Q3M/pBk/6hSzmrF/DZjF96gVG
	i6/rfzFb/Lx7nN1i1cJrbBbHt85jtzg/6xSLxeVdc9gs7q35z2pxZlqRxeo1GQ7cHjtn3WX3
	6G67zO7RcuQtq8fiPS+ZPDZ9msTucWLGbxaPnQ8tPd7vu8rmsfl0tcfnTXIBXFFcNimpOZll
	qUX6dglcGRvm1BSsdqzY9Pg/YwPjReMuRk4OCQETifufv7N2MXKA2bu3xoKYbAJKEsf2xoBU
	iAhoSGxq28DcxcjFwSzwg0li64VDbCAJYYFwie/3n7CA2CwCqhI/b85lBLF5BYwlLnbNYIIY
	rynRcOkemM0pYCfxs2EHWI2QAI/Eqw37oeoFJU7OhJjDLCAv0bx1NtgyCYHPbBLNk6+xQAyS
	lDi44gbLBEb+WUh6ZiHpWcDItIpRKDOvLDcxM8dEL6MyL7NCLzk/dxMjMPiX1f6J3sH46ULw
	IUYBDkYlHt4dbp/ThVgTy4orcw8xSnAwK4nwWp76lC7Em5JYWZValB9fVJqTWnyIUZqDRUmc
	1+hbeYqQQHpiSWp2ampBahFMlomDU6qB0WdazdXPaYHixl9nJvKeU12x5fl+noex/IdfPL9x
	P//kq9Tuk7Wupyd0VRTmVs89lOOsf6n+k1TEhiM2vw8fkmNbf7TSJ/HoVAal+QeENvi+5Hse
	c8ePu4MjOW7/nX+598IDLd/lO+cfdJnf/+VXhzp/dFBIgvsCFZU7yzxmf1+aOlEo595VcSWW
	4oxEQy3mouJEALAtHNt6AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrILMWRmVeSWpSXmKPExsXCNUNNSzdo7ud0g19fOC3mrF/DZjF96gVG
	i6/rfzFb/Lx7nN3i87PXzBarFl5jszi+dR67xeG5J1ktzs86xWJxedccNot7a/6zWpyZVmRx
	6NpzVovVazIsfm9bwebA77Fz1l12j+62y+weLUfesnos3vOSyWPTp0nsHidm/Gbx2PnQ0uP9
	vqtsHt9ue3gsfvGByWPz6WqPz5vkAniiuGxSUnMyy1KL9O0SuDI2zKkpWO1Ysenxf8YGxovG
	XYwcHBICJhK7t8aCmGwCShLH9sZ0MXJyiAhoSGxq28DcxcjFwSzwg0li64VDbCAJYYFwie/3
	n7CA2CwCqhI/b85lBLF5BYwlLnbNYAKxJQQ0JRou3QOzOQXsJH427ACrERLgkXi1YT9UvaDE
	yZkQc5gF5CWat85mnsDIMwtJahaS1AJGplWMIpl5ZbmJmTmmesXZGZV5mRV6yfm5mxiBAb+s
	9s/EHYxfLrsfYhTgYFTi4b3R+CldiDWxrLgy9xCjBAezkgiv5SmgEG9KYmVValF+fFFpTmrx
	IUZpDhYlcV6v8NQEIYH0xJLU7NTUgtQimCwTB6dUA2P761WJJyRkDv2ecDUkKHgSi+ai559b
	PD9w/Xd11rj78k4hs0hitN9H2WdvznQo1ga++PYjn+UX55aNNx+eUjFcsNpNNUz5qtYmF4vH
	k1a85BYKnc98zeP1zOtZCUm7Zr9y7G7bZNN789yFwiClaPnY41s0+A4khO/6zXXy+NGOwwy2
	Xlkv1tQosRRnJBpqMRcVJwIArJaB4XQCAAA=
X-CFilter-Loop: Reflected

On Fri, 4 Apr 2025 22:45:00 +0200 David Hildenbrand <david@redhat.com> wrote:
> On 04.04.25 09:46, Rakie Kim wrote:
> > The weighted interleave policy distributes page allocations across multiple
> > NUMA nodes based on their performance weight, thereby improving memory
> > bandwidth utilization. The weight values for each node are configured
> > through sysfs.
> > 
> > Previously, sysfs entries for configuring weighted interleave were created
> > for all possible nodes (N_POSSIBLE) at initialization, including nodes that
> > might not have memory. However, not all nodes in N_POSSIBLE are usable at
> > runtime, as some may remain memoryless or offline.
> > This led to sysfs entries being created for unusable nodes, causing
> > potential misconfiguration issues.
> > 
> > To address this issue, this patch modifies the sysfs creation logic to:
> > 1) Limit sysfs entries to nodes that are online and have memory, avoiding
> >     the creation of sysfs entries for nodes that cannot be used.
> > 2) Support memory hotplug by dynamically adding and removing sysfs entries
> >     based on whether a node transitions into or out of the N_MEMORY state.
> > 
> > Additionally, the patch ensures that sysfs attributes are properly managed
> > when nodes go offline, preventing stale or redundant entries from persisting
> > in the system.
> > 
> > By making these changes, the weighted interleave policy now manages its
> > sysfs entries more efficiently, ensuring that only relevant nodes are
> > considered for interleaving, and dynamically adapting to memory hotplug
> > events.
> > 
> > Signed-off-by: Rakie Kim <rakie.kim@sk.com>
> > Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
> > Signed-off-by: Yunjeong Mun <yunjeong.mun@sk.com>
> > ---
> >   mm/mempolicy.c | 109 ++++++++++++++++++++++++++++++++++++++-----------
> >   1 file changed, 86 insertions(+), 23 deletions(-)
> > 
> > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > index 73a9405ff352..f25c2c7f8fcf 100644
> > --- a/mm/mempolicy.c
> > +++ b/mm/mempolicy.c
> > @@ -113,6 +113,7 @@
> >   #include <asm/tlbflush.h>
> >   #include <asm/tlb.h>
> >   #include <linux/uaccess.h>
> > +#include <linux/memory.h>
> >   
> >   #include "internal.h"
> >   
> > @@ -3390,6 +3391,7 @@ struct iw_node_attr {
> >   
> >   struct sysfs_wi_group {
> >   	struct kobject wi_kobj;
> > +	struct mutex kobj_lock;
> >   	struct iw_node_attr *nattrs[];
> >   };
> >   
> > @@ -3439,13 +3441,24 @@ static ssize_t node_store(struct kobject *kobj, struct kobj_attribute *attr,
> >   
> >   static void sysfs_wi_node_delete(int nid)
> >   {
> > -	if (!wi_group->nattrs[nid])
> > +	struct iw_node_attr *attr;
> > +
> > +	if (nid < 0 || nid >= nr_node_ids)
> > +		return;
> > +
> > +	mutex_lock(&wi_group->kobj_lock);
> > +	attr = wi_group->nattrs[nid];
> > +	if (!attr) {
> > +		mutex_unlock(&wi_group->kobj_lock);
> >   		return;
> > +	}
> > +
> > +	wi_group->nattrs[nid] = NULL;
> > +	mutex_unlock(&wi_group->kobj_lock);
> >   
> > -	sysfs_remove_file(&wi_group->wi_kobj,
> > -			  &wi_group->nattrs[nid]->kobj_attr.attr);
> > -	kfree(wi_group->nattrs[nid]->kobj_attr.attr.name);
> > -	kfree(wi_group->nattrs[nid]);
> > +	sysfs_remove_file(&wi_group->wi_kobj, &attr->kobj_attr.attr);
> > +	kfree(attr->kobj_attr.attr.name);
> > +	kfree(attr);
> >   }
> >   
> >   static void sysfs_wi_release(struct kobject *wi_kobj)
> > @@ -3464,35 +3477,80 @@ static const struct kobj_type wi_ktype = {
> >   
> >   static int sysfs_wi_node_add(int nid)
> >   {
> > -	struct iw_node_attr *node_attr;
> > +	int ret = 0;
> >   	char *name;
> > +	struct iw_node_attr *new_attr = NULL;
> >   
> > -	node_attr = kzalloc(sizeof(*node_attr), GFP_KERNEL);
> > -	if (!node_attr)
> > +	if (nid < 0 || nid >= nr_node_ids) {
> > +		pr_err("Invalid node id: %d\n", nid);
> > +		return -EINVAL;
> > +	}
> > +
> > +	new_attr = kzalloc(sizeof(struct iw_node_attr), GFP_KERNEL);
> > +	if (!new_attr)
> >   		return -ENOMEM;
> >   
> >   	name = kasprintf(GFP_KERNEL, "node%d", nid);
> >   	if (!name) {
> > -		kfree(node_attr);
> > +		kfree(new_attr);
> >   		return -ENOMEM;
> >   	}
> >   
> > -	sysfs_attr_init(&node_attr->kobj_attr.attr);
> > -	node_attr->kobj_attr.attr.name = name;
> > -	node_attr->kobj_attr.attr.mode = 0644;
> > -	node_attr->kobj_attr.show = node_show;
> > -	node_attr->kobj_attr.store = node_store;
> > -	node_attr->nid = nid;
> > +	mutex_lock(&wi_group->kobj_lock);
> > +	if (wi_group->nattrs[nid]) {
> > +		mutex_unlock(&wi_group->kobj_lock);
> > +		pr_info("Node [%d] already exists\n", nid);
> > +		kfree(new_attr);
> > +		kfree(name);
> > +		return 0;
> > +	}
> > +	wi_group->nattrs[nid] = new_attr;
> >   
> > -	if (sysfs_create_file(&wi_group->wi_kobj, &node_attr->kobj_attr.attr)) {
> > -		kfree(node_attr->kobj_attr.attr.name);
> > -		kfree(node_attr);
> > -		pr_err("failed to add attribute to weighted_interleave\n");
> > -		return -ENOMEM;
> > +	sysfs_attr_init(&wi_group->nattrs[nid]->kobj_attr.attr);
> > +	wi_group->nattrs[nid]->kobj_attr.attr.name = name;
> > +	wi_group->nattrs[nid]->kobj_attr.attr.mode = 0644;
> > +	wi_group->nattrs[nid]->kobj_attr.show = node_show;
> > +	wi_group->nattrs[nid]->kobj_attr.store = node_store;
> > +	wi_group->nattrs[nid]->nid = nid;
> > +
> > +	ret = sysfs_create_file(&wi_group->wi_kobj,
> > +				&wi_group->nattrs[nid]->kobj_attr.attr);
> > +	if (ret) {
> > +		kfree(wi_group->nattrs[nid]->kobj_attr.attr.name);
> > +		kfree(wi_group->nattrs[nid]);
> > +		wi_group->nattrs[nid] = NULL;
> > +		pr_err("Failed to add attribute to weighted_interleave: %d\n", ret);
> >   	}
> > +	mutex_unlock(&wi_group->kobj_lock);
> >   
> > -	wi_group->nattrs[nid] = node_attr;
> > -	return 0;
> > +	return ret;
> > +}
> > +
> > +static int wi_node_notifier(struct notifier_block *nb,
> > +			       unsigned long action, void *data)
> > +{
> > +	int err;
> > +	struct memory_notify *arg = data;
> > +	int nid = arg->status_change_nid;
> > +
> > +	if (nid < 0)
> > +		goto notifier_end;
> > +
> > +	switch(action) {
> > +	case MEM_ONLINE:
> 
> MEM_ONLINE is too late, we cannot fail hotplug at that point.
> 
> Would MEM_GOING_ONLINE / MEM_CANCEL_ONLINE be better?

Hi David,

Thank you for raising these points. I would appreciate your clarification
on the following:

Issue1: I want to invoke sysfs_wi_node_add() after a node with memory
has been fully transitioned to the online state. Does replacing
MEM_ONLINE with MEM_GOING_ONLINE or MEM_CANCEL_ONLINE still ensure
that the node is considered online and usable by that point?

> 
> 
> > +		err = sysfs_wi_node_add(nid);
> > +		if (err) {
> > +			pr_err("failed to add sysfs [node%d]\n", nid);
> > +			return NOTIFY_BAD;
> 
> Note that NOTIFY_BAD includes NOTIFY_STOP_MASK. So you wouldn't call 
> other notifiers, but the overall memory onlining would succeed, which is 
> bad.
> 
> If we don't care about the error (not prevent hotplug) we could only 
> pr_warn() and continue. Maybe this (unlikely) case is not a good reason 
> to stop memory from getting onlined. OTOH, it will barely ever trigger 
> in practice ...
> 

Issue2: Regarding your note about NOTIFY_BAD ? are you saying that
if sysfs_wi_node_add() returns NOTIFY_BAD, it will trigger
NOTIFY_STOP_MASK, preventing other notifiers from running, while
still allowing the memory hotplug operation to complete?

If so, then I'm thinking of resolving both issues as follows:
- For Issue1: I keep using MEM_ONLINE, assuming it is safe and
  sufficient to ensure the node is fully online.
- For Issue2: I avoid returning NOTIFY_BAD from the notifier.
  Instead, I log the error using pr_err() and continue the operation.

This would result in the following code:

	if (nid < 0)
		return NOTIFY_OK;

	switch (action) {
	case MEM_ONLINE: // Issue1: keeping this unchanged
		err = sysfs_wi_node_add(nid);
		if (err) {
			pr_err("failed to add sysfs [node%d]\n", nid);
			// Issue2: Do not return NOTIFY_BAD
		}
		break;
	case MEM_OFFLINE:
		sysfs_wi_node_delete(nid);
		break;
	}

	// Always return NOTIFY_OK
	return NOTIFY_OK;

Please let me know if this approach is acceptable.

Rakie

> -- 
> Cheers,
> 
> David / dhildenb
> 
