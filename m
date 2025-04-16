Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E316A18A6A9;
	Wed, 16 Apr 2025 07:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744789805; cv=none; b=bDzvW/6Db0kY+U9gwTFsTmnArKaEGSCwgAunz8xiLIYp1Kndgt15ASFfW+/UzdoStWApyXz3zS3ONsAbDfDhY8gdyESZZAVhQ0KJ5nvpHA08fT+tArckqMjPOdEP6nedy+WomUESJfS9c3mCK+imwY6HOtFv69yzrajzSxZNYfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744789805; c=relaxed/simple;
	bh=ASSFA4eCrkh3PyFIJus+km6hN54aGjh1fhPfA6AGLpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gptjmkke0/5yTIGaO2GkZ/TV0e5tA4PdPbbMLEAf3kZNAgIPb0tsu/M6K7bcLcIi/lh8KWgWkjQuM9c3Z+awmgux10yaIvX+x9l5ur516SitAZ6KLeS00XutNYdD6QThTsIOxQqlmIjaPvG8dpUrvAT/PH+e5jc1LS3barNBj68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-6e-67ff61235ab6
From: Rakie Kim <rakie.kim@sk.com>
To: Honggyu Kim <honggyu.kim@sk.com>
Cc: kernel_team@skhynix.com,
	akpm@linux-foundation.org,
	gourry@gourry.net,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	joshua.hahnjy@gmail.com,
	dan.j.williams@intel.com,
	ying.huang@linux.alibaba.com,
	david@redhat.com,
	osalvador@suse.de,
	yunjeong.mun@sk.com,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Rakie Kim <rakie.kim@sk.com>
Subject: Re: [PATCH v7 3/3] mm/mempolicy: Support memory hotplug in weighted interleave
Date: Wed, 16 Apr 2025 16:49:32 +0900
Message-ID: <20250416074951.610-1-rakie.kim@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <6a651c16-7ffc-42a5-8c98-95949073c804@sk.com>
References: 
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOLMWRmVeSWpSXmKPExsXC9ZZnka5K4v90gxVXmC3mrF/DZjF96gVG
	i6/rfzFb/Lx7nN1i1cJrbBbHt85jtzg/6xSLxeVdc9gs7q35z2pxZlqRxeo1GQ7cHjtn3WX3
	6G67zO7RcuQtq8fiPS+ZPDZ9msTucWLGbxaPnQ8tPd7vu8rmsfl0tcfnTXIBXFFcNimpOZll
	qUX6dglcGbOPTmApWO9T8eTZD6YGxquWXYycHBICJhJ9c94zdjFygNldP6VBTDYBJYlje2NA
	KkQEVCTWHpzC1sXIxcEs0MkssejoPmaQhLBAuMSfHzdZQWwWAVWJu53PGUFsXgFjifa/s1kh
	xmtKNFy6xwRicwpYSUx9eokNxBYS4JF4tWE/VL2gxMmZT1hAbGYBeYnmrbOZIXo/s0msuOgH
	YUtKHFxxg2UCI/8sJC2zkLQsYGRaxSiUmVeWm5iZY6KXUZmXWaGXnJ+7iREY/Mtq/0TvYPx0
	IfgQowAHoxIPb0T8v3Qh1sSy4srcQ4wSHMxKIrznzIFCvCmJlVWpRfnxRaU5qcWHGKU5WJTE
	eY2+lacICaQnlqRmp6YWpBbBZJk4OKUaGNfcmlScz/7ed3+VaZdTRvqs/38a7peytl1VrTD3
	K9D3vPtBNrwz/i77yUlmioc8Ni+PfsD0xpTzgC3XoosSpxSyJ+7zOnUj5xwv15f3qnPmrf4c
	Zvl/m2K2y4X/brP54uPCtwuX7vxaddp2ma3v5Kp7OULXCt4vf1O0KaLz+ebfO841azo9S1Bi
	Kc5INNRiLipOBAB+zyfyegIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrELMWRmVeSWpSXmKPExsXCNUNNS1c58X+6wZmjhhZz1q9hs5g+9QKj
	xdf1v5gtft49zm7x+dlrZotVC6+xWRzfOo/d4vDck6wW52edYrG4vGsOm8W9Nf9ZLc5MK7I4
	dO05q8XqNRkWv7etYHPg99g56y67R3fbZXaPliNvWT0W73nJ5LHp0yR2jxMzfrN47Hxo6fF+
	31U2j2+3PTwWv/jA5LH5dLXH501yATxRXDYpqTmZZalF+nYJXBmzj05gKVjvU/Hk2Q+mBsar
	ll2MHBwSAiYSXT+lQUw2ASWJY3tjuhg5OUQEVCTWHpzC1sXIxcEs0MkssejoPmaQhLBAuMSf
	HzdZQWwWAVWJu53PGUFsXgFjifa/s8HiEgKaEg2X7jGB2JwCVhJTn15iA7GFBHgkXm3YD1Uv
	KHFy5hMWEJtZQF6ieets5gmMPLOQpGYhSS1gZFrFKJKZV5abmJljqlecnVGZl1mhl5yfu4kR
	GPLLav9M3MH45bL7IUYBDkYlHt6I+H/pQqyJZcWVuYcYJTiYlUR4z5kDhXhTEiurUovy44tK
	c1KLDzFKc7AoifN6hacmCAmkJ5akZqemFqQWwWSZODilGhj91t2f1d38faeZuc7ryperWXf4
	fjRu7n961VEq+bF2fIfEPaEET9H5tj9nHS/mzTTzKa5/ef1S+qoVilpKLx3vvtp1nmuxYxaz
	+MIkhVXe9RJac2/VSvA7VfAm7e7anMLt4y9Sv9g51Euq8U2K1u9tFgsn10z+0i6+UmpP4b4K
	gfqTOh9EfJVYijMSDbWYi4oTAemx/8B1AgAA
X-CFilter-Loop: Reflected

On Wed, 16 Apr 2025 13:04:32 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:

Hi Jonathan and Honggyu,

Thank you for reviewing this patch and for offering valuable ideas to
address the issues. I have accepted all of your suggestions and am
currently preparing a new patch series, version v8.

> Hi Jonathan,
> 
> Thanks for reviewing our patches.
> 
> I have a few comments and the rest will be addressed by Rakie.
> 
> On 4/16/2025 1:00 AM, Jonathan Cameron wrote:
> > On Tue, 8 Apr 2025 16:32:42 +0900
> > Rakie Kim <rakie.kim@sk.com> wrote:
> > 
> >> @@ -3470,13 +3472,24 @@ static ssize_t node_store(struct kobject *kobj, struct kobj_attribute *attr,
> >>   
> >>   static void sysfs_wi_node_delete(int nid)
> >>   {
> >> -	if (!wi_group->nattrs[nid])
> >> +	struct iw_node_attr *attr;
> >> +
> >> +	if (nid < 0 || nid >= nr_node_ids)
> >> +		return;
> >> +
> >> +	mutex_lock(&wi_group->kobj_lock);
> >> +	attr = wi_group->nattrs[nid];
> >> +	if (!attr) {
> >> +		mutex_unlock(&wi_group->kobj_lock);
> >>   		return;
> >> +	}
> >> +
> >> +	wi_group->nattrs[nid] = NULL;
> >> +	mutex_unlock(&wi_group->kobj_lock);
> >>   
> >> -	sysfs_remove_file(&wi_group->wi_kobj,
> >> -			  &wi_group->nattrs[nid]->kobj_attr.attr);
> >> -	kfree(wi_group->nattrs[nid]->kobj_attr.attr.name);
> >> -	kfree(wi_group->nattrs[nid]);
> >> +	sysfs_remove_file(&wi_group->wi_kobj, &attr->kobj_attr.attr);
> >> +	kfree(attr->kobj_attr.attr.name);
> >> +	kfree(attr);
> > Here you go through a careful dance to not touch wi_group->nattrs[nid]
> > except under the lock, but later you are happy to do so in the
> > error handling paths.  Maybe better to do similar to here and
> > set it to NULL under the lock but do the freeing on a copy taken
> > under that lock.

I have updated the error handling path in sysfs_wi_node_add() as you
suggested.

> > .
> >>   }
> >>   
> >>   static void sysfs_wi_release(struct kobject *wi_kobj)
> >> @@ -3495,35 +3508,77 @@ static const struct kobj_type wi_ktype = {
> >>   
> >>   static int sysfs_wi_node_add(int nid)
> >>   {
> >> -	struct iw_node_attr *node_attr;
> >> +	int ret = 0;
> > 
> > Trivial but isn't ret always set when it is used? So no need to initialize
> > here.

In the updated code for v8, I retained the initialization of `ret = 0`
because it is required for proper cleanup handling in the current
version.

> 
> If we don't initialize it, then this kind of trivial fixup might be needed later
> so I think there is no reason not to initialize it.
> https://lore.kernel.org/mm-commits/20240705010631.46743C4AF07@smtp.kernel.org
> 
> > 
> >>   	char *name;
> >> +	struct iw_node_attr *new_attr = NULL;
> > 
> > This is also always set before use so I'm not seeing a
> > reason to initialize it to NULL.
> 
> Ditto.

I also removed the unnecessary `= NULL` initializer for `new_attr`,
as it is always assigned before use.

> 
> > 
> > 
> >>   
> >> -	node_attr = kzalloc(sizeof(*node_attr), GFP_KERNEL);
> >> -	if (!node_attr)
> >> +	if (nid < 0 || nid >= nr_node_ids) {
> >> +		pr_err("Invalid node id: %d\n", nid);
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	new_attr = kzalloc(sizeof(struct iw_node_attr), GFP_KERNEL);
> > 
> > I'd prefer sizeof(*new_attr) because I'm lazy and don't like checking
> > types for allocation sizes :)  Local style seems to be a bit
> > of a mix though.
> 
> Agreed.

As you recommended, I changed the allocation from
`sizeof(struct iw_node_attr)` to `sizeof(*new_attr)` for better 
readability and consistency.

> 
> > 
> >> +	if (!new_attr)
> >>   		return -ENOMEM;
> >>   
> >>   	name = kasprintf(GFP_KERNEL, "node%d", nid);
> >>   	if (!name) {
> >> -		kfree(node_attr);
> >> +		kfree(new_attr);
> >>   		return -ENOMEM;
> >>   	}
> >>   
> >> -	sysfs_attr_init(&node_attr->kobj_attr.attr);
> >> -	node_attr->kobj_attr.attr.name = name;
> >> -	node_attr->kobj_attr.attr.mode = 0644;
> >> -	node_attr->kobj_attr.show = node_show;
> >> -	node_attr->kobj_attr.store = node_store;
> >> -	node_attr->nid = nid;
> >> +	mutex_lock(&wi_group->kobj_lock);
> >> +	if (wi_group->nattrs[nid]) {
> >> +		mutex_unlock(&wi_group->kobj_lock);
> >> +		pr_info("Node [%d] already exists\n", nid);
> >> +		kfree(new_attr);
> >> +		kfree(name);
> >> +		return 0;
> >> +	}
> >> +	wi_group->nattrs[nid] = new_attr;
> 
> This set can be done after all the "wi_group->nattrs[nid]" related set is done.
> 
> >>   
> >> -	if (sysfs_create_file(&wi_group->wi_kobj, &node_attr->kobj_attr.attr)) {
> >> -		kfree(node_attr->kobj_attr.attr.name);
> >> -		kfree(node_attr);
> >> -		pr_err("failed to add attribute to weighted_interleave\n");
> >> -		return -ENOMEM;
> >> +	sysfs_attr_init(&wi_group->nattrs[nid]->kobj_attr.attr);
> > 
> > I'd have been tempted to use the new_attr pointer but perhaps
> > this brings some documentation like advantages.
> 
> +1

Additionally, I replaced all usage of `wi_group->nattrs[nid]` in
sysfs_wi_node_add() with the `new_attr` pointer to simplify the logic
and improve clarity. This also aligns with your suggestion to treat
`new_attr` consistently throughout the function.

> 
> > 
> >> +	wi_group->nattrs[nid]->kobj_attr.attr.name = name;
> >> +	wi_group->nattrs[nid]->kobj_attr.attr.mode = 0644;
> >> +	wi_group->nattrs[nid]->kobj_attr.show = node_show;
> >> +	wi_group->nattrs[nid]->kobj_attr.store = node_store;
> >> +	wi_group->nattrs[nid]->nid = nid;
> 
> As Jonathan mentioned, all the "wi_group->nattrs[nid]" here is better to be
> "new_attr" for simplicity.
> 
> Thanks,
> Honggyu
> 
> >> +
> >> +	ret = sysfs_create_file(&wi_group->wi_kobj,
> >> +				&wi_group->nattrs[nid]->kobj_attr.attr);
> >> +	if (ret) {
> >> +		kfree(wi_group->nattrs[nid]->kobj_attr.attr.name);
> > 
> > See comment above on the rather different handling here to in
> > sysfs_wi_node_delete() where you set it to NULL first, release the lock and tidy up.
> > new_attrand name are still set so you could even combine the handling with the
> > if (wi_group->nattrs[nid]) above via appropriate gotos.

I agree with your observation regarding the difference in error
handling between sysfs_wi_node_add() and sysfs_wi_node_delete(), so I
refactored sysfs_wi_node_add() to follow the same structure.

I will apply all of these updates in the new v8 series. Thank you
again for your thoughtful and detailed feedback.
Below is the revised code after incorporating your feedback.

Rakie

@@ -3532,14 +3532,14 @@ static int sysfs_wi_node_add(int nid)
 {
        int ret = 0;
        char *name;
-       struct iw_node_attr *new_attr = NULL;
+       struct iw_node_attr *new_attr;
 
        if (nid < 0 || nid >= nr_node_ids) {
-               pr_err("Invalid node id: %d\n", nid);
+               pr_err("invalid node id: %d\n", nid);
                return -EINVAL;
        }
 
-       new_attr = kzalloc(sizeof(struct iw_node_attr), GFP_KERNEL);
+       new_attr = kzalloc(sizeof(*new_attr), GFP_KERNEL);
        if (!new_attr)
                return -ENOMEM;
 
@@ -3549,33 +3549,32 @@ static int sysfs_wi_node_add(int nid)
                return -ENOMEM;
        }
 
+       sysfs_attr_init(&new_attr->kobj_attr.attr);
+       new_attr->kobj_attr.attr.name = name;
+       new_attr->kobj_attr.attr.mode = 0644;
+       new_attr->kobj_attr.show = node_show;
+       new_attr->kobj_attr.store = node_store;
+       new_attr->nid = nid;
+
        mutex_lock(&wi_group->kobj_lock);
        if (wi_group->nattrs[nid]) {
                mutex_unlock(&wi_group->kobj_lock);
-               pr_info("Node [%d] already exists\n", nid);
-               kfree(new_attr);
-               kfree(name);
-               return 0;
+               pr_info("node%d already exists\n", nid);
+               goto out;
        }
-       wi_group->nattrs[nid] = new_attr;
-
-       sysfs_attr_init(&wi_group->nattrs[nid]->kobj_attr.attr);
-               pr_info("Node [%d] already exists\n", nid);
-               kfree(new_attr);
-               kfree(name);
-               return 0;
+               pr_info("node%d already exists\n", nid);
+               goto out;
        }
-       wi_group->nattrs[nid] = new_attr;
-
-       sysfs_attr_init(&wi_group->nattrs[nid]->kobj_attr.attr);
-       wi_group->nattrs[nid]->kobj_attr.attr.name = name;
-       wi_group->nattrs[nid]->kobj_attr.attr.mode = 0644;
-       wi_group->nattrs[nid]->kobj_attr.show = node_show;
-       wi_group->nattrs[nid]->kobj_attr.store = node_store;
-       wi_group->nattrs[nid]->nid = nid;
 
-       ret = sysfs_create_file(&wi_group->wi_kobj,
-                               &wi_group->nattrs[nid]->kobj_attr.attr);
+       ret = sysfs_create_file(&wi_group->wi_kobj, &new_attr->kobj_attr.attr);
        if (ret) {
-               kfree(wi_group->nattrs[nid]->kobj_attr.attr.name);
-               kfree(wi_group->nattrs[nid]);
-               wi_group->nattrs[nid] = NULL;
-               pr_err("Failed to add attribute to weighted_interleave: %d\n", ret);
+               mutex_unlock(&wi_group->kobj_lock);
+               goto out;
        }
+       wi_group->nattrs[nid] = new_attr;
        mutex_unlock(&wi_group->kobj_lock);
+       return 0;
 
+out:
+       kfree(new_attr->kobj_attr.attr.name);
+       kfree(new_attr);
        return ret;
}

> > 
> >> +		kfree(wi_group->nattrs[nid]);
> >> +		wi_group->nattrs[nid] = NULL;
> >> +		pr_err("Failed to add attribute to weighted_interleave: %d\n", ret);
> >>   	}
> >> +	mutex_unlock(&wi_group->kobj_lock);
> >>   
> >> -	wi_group->nattrs[nid] = node_attr;
> >> -	return 0;
> >> +	return ret;
> >> +}
> > 
> > 
