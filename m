Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E14C1172A;
	Thu, 17 Apr 2025 01:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744854622; cv=none; b=sEnT3BBleJbhGes0Or3M44XG73EDhTHnT3mxrv05Pu/pv8UNLYS+ignuJ+ZNwzu+DURGvTpRgh71CyerLQzWjTjJvaOQwrETUm90e0E0rnoB579NhFqlkZCvaC5r+OT3GwpxlTQn4f/c+0x8lohF+PEAGwEslIfXpWQGo7RXk+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744854622; c=relaxed/simple;
	bh=X71LVokWEWz+T20vPZCEQZFivCkXXJKdbRQ5XPf+lBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uNOPltuGDQzZmIqsggHkbsB8B6XdxjqvVZIeYlGK8RTnGiMdJ+V0IXuokT1/+oYc0x9+a3KIKxrnFshHq6JgWrNfvujktHccmPleeF9BJRhYDIonoTIySGNpIrPnWZDCyHamK1fbjSHDOlKDX6yyCkMUAAWyoN8dBYjqxKlhzk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-18-68005e54eb85
From: Rakie Kim <rakie.kim@sk.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: gourry@gourry.net,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	joshua.hahnjy@gmail.com,
	ying.huang@linux.alibaba.com,
	david@redhat.com,
	Jonathan.Cameron@huawei.com,
	osalvador@suse.de,
	kernel_team@skhynix.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com,
	rakie.kim@sk.com,
	akpm@linux-foundation.org
Subject: Re: [PATCH v8 1/3] mm/mempolicy: Fix memory leaks in weighted interleave sysfs
Date: Thu, 17 Apr 2025 10:49:38 +0900
Message-ID: <20250417015009.650-1-rakie.kim@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <6800270845306_1302d294a4@dwillia2-xfh.jf.intel.com.notmuch>
References: 
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBLMWRmVeSWpSXmKPExsXC9ZZnkW5IHEOGwa4vNhZz1q9hs5g+9QKj
	xdf1v5gtft49zm6xauE1NovjW+exW5yfdYrF4vKuOWwW99b8Z7U4M63IYvWaDAduj52z7rJ7
	dLddZvdoOfKW1WPxnpdMHps+TWL3ODHjN4vHzoeWHu/3XWXz2Hy62uPzJrkArigum5TUnMyy
	1CJ9uwSujBer+Qv2ulY0rP/B1sD4w6SLkZNDQsBEYueGaeww9pW3E1i7GDk42ASUJI7tjQEJ
	iwhoS0ycc5C5i5GLg1ngCZPE3CNL2UASwgLhErte/wazWQRUJZ41NDKC2LwCxhL3Nl+Fmqkp
	0XDpHhOIzSngKXFi8WFWEFtIgEfi1Yb9UPWCEidnPmEBsZkF5CWat84GWyYh8J1NovvcLUaI
	QZISB1fcYJnAyD8LSc8sJD0LGJlWMQpl5pXlJmbmmOhlVOZlVugl5+duYgSG/7LaP9E7GD9d
	CD7EKMDBqMTDe2LR/3Qh1sSy4srcQ4wSHMxKIrznzP+lC/GmJFZWpRblxxeV5qQWH2KU5mBR
	Euc1+laeIiSQnliSmp2aWpBaBJNl4uCUamBkeMz/MG61tu2twj9ic+fe3mEof8LonKJfWs6L
	G56FyjeaYl/PyvVtdy9Yu9tre7Txy0OlqtuclW5VW5QdD9BZ9Pmy4tSZJX0tKu997aJfSNfx
	zbMzu+hX8fHv98sXI5iydPL45LbfmXNF4ubCxLZytfPJlXO6KlMERJz19r0rqfulG5PMZ6fE
	UpyRaKjFXFScCAAg+EhBewIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrELMWRmVeSWpSXmKPExsXCNUNNSzckjiHD4Mc9A4s569ewWUyfeoHR
	4uv6X8wWP+8eZ7f4/Ow1s8WqhdfYLI5vncducXjuSVaL87NOsVhc3jWHzeLemv+sFmemFVkc
	uvac1WL1mgyL39tWsDnwe+ycdZfdo7vtMrtHy5G3rB6L97xk8tj0aRK7x4kZv1k8dj609Hi/
	7yqbx7fbHh6LX3xg8th8utrj8ya5AJ4oLpuU1JzMstQifbsErowXq/kL9rpWNKz/wdbA+MOk
	i5GTQ0LAROLK2wmsXYwcHGwCShLH9saAhEUEtCUmzjnI3MXIxcEs8IRJYu6RpWwgCWGBcIld
	r3+D2SwCqhLPGhoZQWxeAWOJe5uvskPM1JRouHSPCcTmFPCUOLH4MCuILSTAI/Fqw36oekGJ
	kzOfsIDYzALyEs1bZzNPYOSZhSQ1C0lqASPTKkaRzLyy3MTMHFO94uyMyrzMCr3k/NxNjMCQ
	X1b7Z+IOxi+X3Q8xCnAwKvHwnlj0P12INbGsuDL3EKMEB7OSCO8583/pQrwpiZVVqUX58UWl
	OanFhxilOViUxHm9wlMThATSE0tSs1NTC1KLYLJMHJxSDYwPzlQGuve/r9z4yd1zVeOcg08X
	rgzbpZ099+gkwbLneifarKRYrhtPeGGq9kDFP7Rqw+Uz3dLZNg++lB/gXGC7aFfw0cNlXy3E
	d17gZWL43J3au9H4lZqrt/0iDY6Tvxj8byxv58z57fWmQ9MqXOK5ZNHnL0vzGP5dKvrVWX7z
	b8XkCGu1/7lKLMUZiYZazEXFiQD6h9JQdQIAAA==
X-CFilter-Loop: Reflected

On Wed, 16 Apr 2025 14:54:16 -0700 Dan Williams <dan.j.williams@intel.com> wrote:
> Rakie Kim wrote:
> > +
> > +static void iw_table_free(void)
> > +{
> > +	u8 *old;
> > +
> > +	mutex_lock(&iw_table_lock);
> > +	old = rcu_dereference_protected(iw_table,
> > +					lockdep_is_held(&iw_table_lock));
> > +	if (old) {
> > +		rcu_assign_pointer(iw_table, NULL);
> > +		mutex_unlock(&iw_table_lock);
> > +
> > +		synchronize_rcu();
> > +		kfree(old);
> > +	} else
> > +		mutex_unlock(&iw_table_lock);
> 
> This looks correct. I personally would not have spent the effort to
> avoid the synchronize_rcu() because this is an error path that rarely
> gets triggered, and kfree(NULL) is already a nop, so no pressing need to be
> careful there either:
> 
> 	mutex_lock(&iw_table_lock);
> 	old = rcu_dereference_protected(iw_table,
> 					lockdep_is_held(&iw_table_lock));
> 	rcu_assign_pointer(iw_table, NULL);
> 	mutex_unlock(&iw_table_lock);
> 	synchronize_rcu();
> 	kfree(old);

I will modify the structure as you suggested.

> 
> > +}
> > +
> > +static void wi_kobj_release(struct kobject *wi_kobj)
> > +{
> > +	iw_table_free();
> 
> This memory can be freed as soon as node_attrs have been deleted. By
> waiting until final wi_kobj release it confuses the lifetime rules.
> 
> > +	kfree(node_attrs);
> 
> This memory too can be freed as soon as the attributes are deleted.
> 
> ...the rationale for considering these additional cleanups below:
> 

I created a new function named wi_cleanup(), as you proposed.
static void wi_cleanup(struct kobject *wi_kobj) {
	sysfs_wi_node_delete_all(wi_kobj);
	iw_table_free();
	kfree(node_attrs);
}
And I changed the error handling code to call this function.
static int add_weighted_interleave_group(struct kobject *root_kobj)
{
...
err_cleanup_kobj:
	wi_cleanup(wi_kobj);
	kobject_del(wi_kobj);
err_put_kobj:
	kobject_put(wi_kobj);
	return err;
}

However, I have one question.
With this change, iw_table and node_attrs will not be freed at system
shutdown. Is it acceptable to leave this memory unfreed on shutdown?
(As you previously noted, the sysfs files in this patch are also
not removed during system shutdown.)

> > +	kfree(wi_kobj);
> >  }
> >  
> >  static const struct kobj_type wi_ktype = {
> >  	.sysfs_ops = &kobj_sysfs_ops,
> > -	.release = sysfs_wi_release,
> > +	.release = wi_kobj_release,
> >  };
> >  
> >  static int add_weight_node(int nid, struct kobject *wi_kobj)
> > @@ -3525,41 +3548,42 @@ static int add_weighted_interleave_group(struct kobject *root_kobj)
> >  	struct kobject *wi_kobj;
> >  	int nid, err;
> >  
> > +	node_attrs = kcalloc(nr_node_ids, sizeof(struct iw_node_attr *),
> > +			     GFP_KERNEL);
> > +	if (!node_attrs)
> > +		return -ENOMEM;
> > +
> >  	wi_kobj = kzalloc(sizeof(struct kobject), GFP_KERNEL);
> > -	if (!wi_kobj)
> > +	if (!wi_kobj) {
> > +		kfree(node_attrs);
> >  		return -ENOMEM;
> > +	}
> >  
> >  	err = kobject_init_and_add(wi_kobj, &wi_ktype, root_kobj,
> >  				   "weighted_interleave");
> 
> If you fix wi_kobj_release() to stop being responsible to free memory
> that should have been handled in the delete path (@node_attrs,
> iw_table_free()), then you can also drop the wi_ktype and
> wi_kobj_release() callback altogether.

I understand your suggestion about simplifying the kobject
handling.
If we only consider Patch1, then replacing kobject_init_and_add
with kobject_create_and_add would be the right choice.

However, in Patch2, the code changes as follows:
struct sysfs_wi_group {
	struct kobject wi_kobj;
	struct iw_node_attr *nattrs[];
};
static struct sysfs_wi_group *wi_group;
...
static void wi_kobj_release(struct kobject *wi_kobj)
{
	kfree(wi_group);
}
...
static int __init add_weighted_interleave_group(struct kobject *mempolicy_kobj)
{
	int nid, err;

	wi_group = kzalloc(struct_size(wi_group, nattrs, nr_node_ids),
			   GFP_KERNEL);

In this case, wi_kobj_release() is responsible for freeing the
container struct wi_group that includes the kobject.
Therefore, it seems more appropriate to use kobject_init_and_add
in this context.
I would appreciate your thoughts on this.

> 
> I.e. once releasing @wi_kobj is just "kfree(wi_kobj)", then this
> sequence:
> 
> 	wi_kobj = kzalloc(...)
> 	kobject_init_and_add(wi_kob, &wi_ktype, ...)
> 
> Can simply become:
> 
> 	wi_kobj = kobject_create_and_add("weighted_interleave", root_kobj);
> 
> > -	if (err) {
> > -		kfree(wi_kobj);
> > -		return err;
> > -	}
> > +	if (err)
> > +		goto err_put_kobj;
> >  
> >  	for_each_node_state(nid, N_POSSIBLE) {
> >  		err = add_weight_node(nid, wi_kobj);
> >  		if (err) {
> >  			pr_err("failed to add sysfs [node%d]\n", nid);
> > -			break;
> > +			goto err_cleanup_kobj;
> >  		}
> >  	}
> > -	if (err)
> > -		kobject_put(wi_kobj);
> > +
> >  	return 0;
> > +
> > +err_cleanup_kobj:
> > +	sysfs_wi_node_delete_all(wi_kobj);
> > +	kobject_del(wi_kobj);
> > +err_put_kobj:
> > +	kobject_put(wi_kobj);
> > +	return err;
> >  }
> >  
> >  static void mempolicy_kobj_release(struct kobject *kobj)
> >  {
> > -	u8 *old;
> > -
> > -	mutex_lock(&iw_table_lock);
> > -	old = rcu_dereference_protected(iw_table,
> > -					lockdep_is_held(&iw_table_lock));
> > -	rcu_assign_pointer(iw_table, NULL);
> > -	mutex_unlock(&iw_table_lock);
> > -	synchronize_rcu();
> > -	kfree(old);
> > -	kfree(node_attrs);
> >  	kfree(kobj);
> >  }
> >  
> > @@ -3573,37 +3597,24 @@ static int __init mempolicy_sysfs_init(void)
> >  	static struct kobject *mempolicy_kobj;
> >  
> >  	mempolicy_kobj = kzalloc(sizeof(*mempolicy_kobj), GFP_KERNEL);
> > -	if (!mempolicy_kobj) {
> > -		err = -ENOMEM;
> > -		goto err_out;
> > -	}
> > -
> > -	node_attrs = kcalloc(nr_node_ids, sizeof(struct iw_node_attr *),
> > -			     GFP_KERNEL);
> > -	if (!node_attrs) {
> > -		err = -ENOMEM;
> > -		goto mempol_out;
> > -	}
> > +	if (!mempolicy_kobj)
> > +		return -ENOMEM;
> >  
> >  	err = kobject_init_and_add(mempolicy_kobj, &mempolicy_ktype, mm_kobj,
> >  				   "mempolicy");
> 
> Similar comment as above, now that mempolicy_kobj_release() is simply
> kfree(@kobj), you can use kobject_create_and_add() and make this all
> that much simpler.

For the mempolicy_kobj, I will update the code as you suggested
and use kobject_create_and_add().

With all your recommendations applied, Patch1 would now look like this:
@@ -3488,20 +3488,21 @@ static void iw_table_free(void)
        mutex_lock(&iw_table_lock);
        old = rcu_dereference_protected(iw_table,
                                        lockdep_is_held(&iw_table_lock));
-       if (old) {
-               rcu_assign_pointer(iw_table, NULL);
-               mutex_unlock(&iw_table_lock);
+       rcu_assign_pointer(iw_table, NULL);
+       mutex_unlock(&iw_table_lock);

-               synchronize_rcu();
-               kfree(old);
-       } else
-               mutex_unlock(&iw_table_lock);
+       synchronize_rcu();
+       kfree(old);
 }

-static void wi_kobj_release(struct kobject *wi_kobj)
-{
+static void wi_cleanup(struct kobject *wi_kobj) {
+       sysfs_wi_node_delete_all(wi_kobj);
        iw_table_free();
        kfree(node_attrs);
+}
+
+static void wi_kobj_release(struct kobject *wi_kobj)
+{
        kfree(wi_kobj);
 }

@@ -3575,45 +3576,30 @@ static int add_weighted_interleave_group(struct kobject *root_kobj)
        return 0;

 err_cleanup_kobj:
-       sysfs_wi_node_delete_all(wi_kobj);
+       wi_cleanup(wi_kobj);
        kobject_del(wi_kobj);
 err_put_kobj:
        kobject_put(wi_kobj);
        return err;
 }

-static void mempolicy_kobj_release(struct kobject *kobj)
-{
-       kfree(kobj);
-}
-
-static const struct kobj_type mempolicy_ktype = {
-       .release = mempolicy_kobj_release
-};
-
 static int __init mempolicy_sysfs_init(void)
 {
        int err;
        static struct kobject *mempolicy_kobj;

-       mempolicy_kobj = kzalloc(sizeof(*mempolicy_kobj), GFP_KERNEL);
+       mempolicy_kobj = kobject_create_and_add("mempolicy", mm_kobj);
        if (!mempolicy_kobj)
                return -ENOMEM;

-       err = kobject_init_and_add(mempolicy_kobj, &mempolicy_ktype, mm_kobj,
-                                  "mempolicy");
-       if (err)
-               goto err_put_kobj;
-
        err = add_weighted_interleave_group(mempolicy_kobj);
        if (err)
-               goto err_del_kobj;
+               goto err_kobj;

        return 0;

-err_del_kobj:
+err_kobj:
        kobject_del(mempolicy_kobj);
-err_put_kobj:
        kobject_put(mempolicy_kobj);
        return err;
 }

Rakie

> 
> So the patch looks technically correct as is, but if you make those
> final cleanups I will add my review tag.
