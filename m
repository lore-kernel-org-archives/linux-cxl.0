Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D2878F37;
	Thu, 13 Mar 2025 06:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741847668; cv=none; b=bjree7l82b0Qlw7qpAyJgRLrBak6G1iyFcOa9V6SNY17zJ4bF30UueSDDimn2sOBV0uMieoCmXc5tmOdwV9AbuacotStiET2fl0XhJRdVs5ADxfdOBKbkZ+DzwoSL0pXjxhsiQlIvm1Ink9rNPLaQTtflxjtDPyHEucStKH6nAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741847668; c=relaxed/simple;
	bh=ShBZcBTjWTLU0KA0KP3LT3/x5xLnZRbQqQSFy+J4TWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aZLzFH6PRbB1FYLXtCtsudmElq4p9/N09p7Oi6FV+ohTIuiVcVsc9flDIjbuIQ4kt8gCwKk7gR+jDxi8nvgk7BAbe+r8JMjF304Bp6aGbl0RaYpERD9viQBp11d9fQQQq0udm+ntAGXxBEqiBL724S4Tmi5slieSOevxAAkO49A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-eb-67d27c6c9791
From: Rakie Kim <rakie.kim@sk.com>
To: Gregory Price <gourry@gourry.net>
Cc: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	joshua.hahnjy@gmail.com,
	dan.j.williams@intel.com,
	ying.huang@linux.alibaba.com,
	kernel_team@skhynix.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com,
	Rakie Kim <rakie.kim@sk.com>
Subject: Re: [PATCH v2 3/4] mm/mempolicy: Enable sysfs support for memory hotplug in weighted interleave
Date: Thu, 13 Mar 2025 15:34:10 +0900
Message-ID: <20250313063416.703-1-rakie.kim@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <Z9Gy-No6pXFWZAyc@gourry-fedora-PF4VCD3F>
References: 
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsXC9ZZnkW5OzaV0gzOztS3mrF/DZjF96gVG
	i593j7NbHN86j93i/KxTLBaXd81hs7i35j+rxeo1GQ4cHjtn3WX36G67zO6xeM9LJo9Nnyax
	e5yY8ZvFY+dDS4/Pm+QC2KO4bFJSczLLUov07RK4Mh6cfstcsMyhYtf9JrYGxk+GXYwcHBIC
	JhJflrp2MXKCma/2trKDhNkElCSO7Y0BMUUEVCXarrh3MXJxMAusZ5J4vWkWG0i5sECGxJm5
	PSwgNgtQzbejXxlBbF4BY4nNV94wQozUlGi4dI8JxOYUMJPYMfUiWFxIgEfi1Yb9UPWCEidn
	PgGbwywgL9G8dTYzyDIJgRNsEs1zbrJBDJKUOLjiBssERv5ZSHpmIelZwMi0ilEoM68sNzEz
	x0QvozIvs0IvOT93EyMwiJfV/onewfjpQvAhRgEORiUe3oTJF9OFWBPLiitzDzFKcDArifCu
	tr2QLsSbklhZlVqUH19UmpNafIhRmoNFSZzX6Ft5ipBAemJJanZqakFqEUyWiYNTqoFxfu7T
	94eY9lnULdiXnx4YUJCybrX1KYvZK7N7tnL1HLnGL/6d7UGV6YpnbW+Uk8SFVJ6wlt33MDIs
	b23t6jgUYe19ryWX6dWMAuYL/ccM3864/lxtgkYGX3RV2LwjK/T6pI4fuh+XN23xwnumapqz
	qtoc3Tm0rsreLbLvui/8dYazq+vWX5+VWIozEg21mIuKEwFiKrz9XgIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGLMWRmVeSWpSXmKPExsXCNUNNSzen5lK6wYo7chZz1q9hs5g+9QKj
	xc+7x9ktPj97zWxxfOs8dovDc0+yWpyfdYrF4vKuOWwW99b8Z7U4dO05q8XqNRkWv7etYHPg
	8dg56y67R3fbZXaPxXteMnls+jSJ3ePEjN8sHjsfWnp8u+3hsfjFByaPz5vkAjijuGxSUnMy
	y1KL9O0SuDIenH7LXLDMoWLX/Sa2BsZPhl2MnBwSAiYSr/a2sncxcnCwCShJHNsbA2KKCKhK
	tF1x72Lk4mAWWM8k8XrTLDaQcmGBDIkzc3tYQGwWoJpvR78ygti8AsYSm6+8YYQYqSnRcOke
	E4jNKWAmsWPqRbC4kACPxKsN+6HqBSVOznwCNodZQF6ieets5gmMPLOQpGYhSS1gZFrFKJKZ
	V5abmJljqlecnVGZl1mhl5yfu4kRGLrLav9M3MH45bL7IUYBDkYlHt6EyRfThVgTy4orcw8x
	SnAwK4nwrra9kC7Em5JYWZValB9fVJqTWnyIUZqDRUmc1ys8NUFIID2xJDU7NbUgtQgmy8TB
	KdXAuPr1vaz1iyZpiL+8fk1knYZvUqNvvI7H6ydvRCp2/+UxXulytazUpcm/5EL6k0t2s9nu
	8Tz2XzW9aKr5axfjqYceHOSesFwocu+qGfEq5368CNev8vcMPrC074vUxM6I5hzBbOcngms+
	WgXuktQtLDh6eP5xqaDSDQnHLPQEKvduzNv4fbZnoRJLcUaioRZzUXEiAIX1UIhZAgAA
X-CFilter-Loop: Reflected

On Wed, 12 Mar 2025 12:14:48 -0400 Gregory Price <gourry@gourry.net> wrote:
> On Wed, Mar 12, 2025 at 04:56:26PM +0900, Rakie Kim wrote:
> > Previously, sysfs entries for weighted interleave were only created during
> > initialization, preventing dynamically added memory nodes from being recognized.
> > 
> > This patch enables sysfs registration for nodes added via memory hotplug,
> > allowing weighted interleave settings to be updated as the system memory
> > configuration changes.
> >
> 
> In patch 2 you said:
> 
> ```
> With this enhancement, the weighted interleave policy now properly supports
> memory hotplug, ensuring that newly added nodes are recognized and sysfs
> entries are created accordingly.
> ```
> 
> By description, this claims to accomplish functionally the same thing
> patch 2 claim.
> 
> The code below actually does two things:
> 
> 1) Refactors the sysfs code to break out the weighted_interleave group
>    into a global that can be referenced by the hotplug callback.
> 
> 2) The change the the memory hotplug callback to add/remove nodes.
> 
> Move the refactor work out ahead in a separate patch to make it easier
> to review the changes individually please.

This change primarily addresses 1) from your feedback. The
modification to the memory hotplug callback was necessary to adapt
to the new `struct iw_node_group`.

Given that this adjustment is part of integrating the refactored
structure, I believe this patch does not need to be split into two.
However, I would appreciate any further input you may have on this.

> 
> > Signed-off-by: Rakie Kim <rakie.kim@sk.com>
> > ---
> >  mm/mempolicy.c | 78 +++++++++++++++++++++++++++++---------------------
> >  1 file changed, 45 insertions(+), 33 deletions(-)
> > 
> > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > index 94efff89e0be..71aff1276d4d 100644
> > --- a/mm/mempolicy.c
> > +++ b/mm/mempolicy.c
> > @@ -3389,6 +3389,13 @@ struct iw_node_attr {
> >  	int nid;
> >  };
> >  
> > +struct iw_node_group {
> > +	struct kobject *wi_kobj;
> > +	struct iw_node_attr **nattrs;
> > +};
> > +
> > +static struct iw_node_group *ngrp;
> > +
> 
> for a global, this should have a more descriptive name.
> 
> And since this actually represents the weighted_interleave sysfs entry,
> it should maybe be `sysfs_wi_group`?  Since it will include more than
> just nodes (e.g. the upcoming `auto`)

Regarding your naming suggestion, I agree that `sysfs_wi_group` is
more descriptive and aligns well with its role in managing the
weighted_interleave sysfs entry. I will update the patch accordingly.

> 
> >  static ssize_t node_show(struct kobject *kobj, struct kobj_attribute *attr,
> >  			 char *buf)
> >  {
> > @@ -3431,24 +3438,22 @@ static ssize_t node_store(struct kobject *kobj, struct kobj_attribute *attr,
> >  	return count;
> >  }
> >  
> > -static struct iw_node_attr **node_attrs;
> > -
> > -static void sysfs_wi_node_release(struct iw_node_attr *node_attr,
> > -				  struct kobject *parent)
> > +static void sysfs_wi_node_release(int nid)
> >  {
> > -	if (!node_attr)
> > +	if (!ngrp->nattrs[nid])
> >  		return;
> > -	sysfs_remove_file(parent, &node_attr->kobj_attr.attr);
> > -	kfree(node_attr->kobj_attr.attr.name);
> > -	kfree(node_attr);
> > +
> > +	sysfs_remove_file(ngrp->wi_kobj, &ngrp->nattrs[nid]->kobj_attr.attr);
> > +	kfree(ngrp->nattrs[nid]->kobj_attr.attr.name);
> > +	kfree(ngrp->nattrs[nid]);
> >  }
> >  
> >  static void sysfs_wi_release(struct kobject *wi_kobj)
> >  {
> > -	int i;
> > +	int nid;
> >  
> > -	for (i = 0; i < nr_node_ids; i++)
> > -		sysfs_wi_node_release(node_attrs[i], wi_kobj);
> > +	for (nid = 0; nid < nr_node_ids; nid++)
> > +		sysfs_wi_node_release(nid);
> >  	kobject_put(wi_kobj);
> >  }
> >  
> > @@ -3457,7 +3462,7 @@ static const struct kobj_type wi_ktype = {
> >  	.release = sysfs_wi_release,
> >  };
> >  
> > -static int add_weight_node(int nid, struct kobject *wi_kobj)
> > +static int sysfs_wi_node_add(int nid)
> >  {
> >  	struct iw_node_attr *node_attr;
> >  	char *name;
> > @@ -3479,19 +3484,17 @@ static int add_weight_node(int nid, struct kobject *wi_kobj)
> >  	node_attr->kobj_attr.store = node_store;
> >  	node_attr->nid = nid;
> >  
> > -	if (sysfs_create_file(wi_kobj, &node_attr->kobj_attr.attr)) {
> > +	if (sysfs_create_file(ngrp->wi_kobj, &node_attr->kobj_attr.attr)) {
> >  		kfree(node_attr->kobj_attr.attr.name);
> >  		kfree(node_attr);
> >  		pr_err("failed to add attribute to weighted_interleave\n");
> >  		return -ENOMEM;
> >  	}
> >  
> > -	node_attrs[nid] = node_attr;
> > +	ngrp->nattrs[nid] = node_attr;
> >  	return 0;
> >  }
> >  
> > -struct kobject *wi_kobj;
> > -
> >  static int wi_node_notifier(struct notifier_block *nb,
> >  			       unsigned long action, void *data)
> >  {
> > @@ -3504,15 +3507,15 @@ static int wi_node_notifier(struct notifier_block *nb,
> >  
> >  	switch(action) {
> >  	case MEM_ONLINE:
> > -		err = add_weight_node(nid, wi_kobj);
> > +		err = sysfs_wi_node_add(nid);
> >  		if (err) {
> >  			pr_err("failed to add sysfs [node%d]\n", nid);
> > -			kobject_put(wi_kobj);
> > +			kobject_put(ngrp->wi_kobj);
> >  			return NOTIFY_BAD;
> >  		}
> >  		break;
> >  	case MEM_OFFLINE:
> > -		sysfs_wi_node_release(node_attrs[nid], wi_kobj);
> > +		sysfs_wi_node_release(nid);
> >  		break;
> >  	}
> >  
> > @@ -3524,14 +3527,14 @@ static int add_weighted_interleave_group(struct kobject *root_kobj)
> >  {
> >  	int nid, err;
> >  
> > -	wi_kobj = kzalloc(sizeof(struct kobject), GFP_KERNEL);
> > -	if (!wi_kobj)
> > +	ngrp->wi_kobj = kzalloc(sizeof(struct kobject), GFP_KERNEL);
> > +	if (!ngrp->wi_kobj)
> >  		return -ENOMEM;
> >  
> > -	err = kobject_init_and_add(wi_kobj, &wi_ktype, root_kobj,
> > +	err = kobject_init_and_add(ngrp->wi_kobj, &wi_ktype, root_kobj,
> >  				   "weighted_interleave");
> >  	if (err) {
> > -		kfree(wi_kobj);
> > +		kfree(ngrp->wi_kobj);
> >  		return err;
> >  	}
> >  
> > @@ -3539,7 +3542,7 @@ static int add_weighted_interleave_group(struct kobject *root_kobj)
> >  		if (!node_state(nid, N_MEMORY))
> >  			continue;
> >  
> > -		err = add_weight_node(nid, wi_kobj);
> > +		err = sysfs_wi_node_add(nid);
> >  		if (err) {
> >  			pr_err("failed to add sysfs [node%d]\n", nid);
> >  			goto err_out;
> > @@ -3550,7 +3553,7 @@ static int add_weighted_interleave_group(struct kobject *root_kobj)
> >  	return 0;
> >  
> >  err_out:
> > -	kobject_put(wi_kobj);
> > +	kobject_put(ngrp->wi_kobj);
> >  	return err;
> >  }
> >  
> > @@ -3565,7 +3568,9 @@ static void mempolicy_kobj_release(struct kobject *kobj)
> >  	mutex_unlock(&iw_table_lock);
> >  	synchronize_rcu();
> >  	kfree(old);
> > -	kfree(node_attrs);
> > +
> > +	kfree(ngrp->nattrs);
> > +	kfree(ngrp);
> >  	kfree(kobj);
> >  }
> >  
> > @@ -3578,17 +3583,23 @@ static int __init mempolicy_sysfs_init(void)
> >  	int err;
> >  	static struct kobject *mempolicy_kobj;
> >  
> > -	node_attrs = kcalloc(nr_node_ids, sizeof(struct iw_node_attr *),
> > -			     GFP_KERNEL);
> > -	if (!node_attrs) {
> > +	ngrp = kzalloc(sizeof(*ngrp), GFP_KERNEL);
> > +	if (!ngrp) {
> >  		err = -ENOMEM;
> >  		goto err_out;
> >  	}
> >  
> > +	ngrp->nattrs = kcalloc(nr_node_ids, sizeof(struct iw_node_attr *),
> > +			       GFP_KERNEL);
> > +	if (!ngrp->nattrs) {
> > +		err = -ENOMEM;
> > +		goto ngrp_out;
> > +	}
> > +
> >  	mempolicy_kobj = kzalloc(sizeof(*mempolicy_kobj), GFP_KERNEL);
> >  	if (!mempolicy_kobj) {
> >  		err = -ENOMEM;
> > -		goto node_out;
> > +		goto nattr_out;
> >  	}
> >  
> >  	err = kobject_init_and_add(mempolicy_kobj, &mempolicy_ktype, mm_kobj,
> > @@ -3606,12 +3617,13 @@ static int __init mempolicy_sysfs_init(void)
> >  
> >  	return 0;
> >  
> > -node_out:
> > -	kfree(node_attrs);
> > +nattr_out:
> > +	kfree(ngrp->nattrs);
> > +ngrp_out:
> > +	kfree(ngrp);
> >  err_out:
> >  	pr_err("mempolicy sysfs structure failed to initialize\n");
> >  	return err;
> > -
> >  }
> >  
> >  late_initcall(mempolicy_sysfs_init);
> > -- 
> > 2.34.1
> > 
