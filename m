Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358A71ADC69;
	Fri, 11 Apr 2025 07:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744356109; cv=none; b=lopbtCeuWtk/8djIU83eXDwq/Stac21C6gXaFJao/o/Z5qKbkELI4nvd9tDUVegpFGGH1LFeg3p50wUfSZn9CIMJewV+FyDaUDYfsFmxh79eMG9JRyuqREiTYgDKtK9VUvvLQh+DDRfF3UK3yAMlQz9v2zJpYaryjVljLMlt3AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744356109; c=relaxed/simple;
	bh=PgJeEOXi4NpUwNgbPqmn8M+aEnjV8v35bi6nehb7B1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lism6UtDKZDAJv3Dx3vul1tmswP5OG8VrSq1R8ty8GMWjykpkeHn6xbAaGna6zuNjo63pAdULF6opnYn5OLpzTPlPHx0qeQ2y/uhO+04NMJhYA8UDMybmSnkkXElRV7jkjO0ULQtp8gpOU68Rz/GdMXKqCpJ9Ezm5ZEtcPC+eoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-57-67f8c302739f
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
Subject: Re: [PATCH v7 2/3] mm/mempolicy: Prepare weighted interleave sysfs for memory hotplug
Date: Fri, 11 Apr 2025 16:21:28 +0900
Message-ID: <20250411072135.588-1-rakie.kim@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <67f5ef882b674_72052946a@dwillia2-xfh.jf.intel.com.notmuch>
References: 
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBLMWRmVeSWpSXmKPExsXC9ZZnoS7T4R/pBm8PWVjMWb+GzWL61AuM
	Fl/X/2K2+Hn3OLvFqoXX2CyOb53HbnF+1ikWi8u75rBZ3Fvzn9XizLQii9VrMhy4PXbOusvu
	0d12md2j5chbVo/Fe14yeWz6NInd48SM3yweOx9aerzfd5XNY/Ppao/Pm+QCuKK4bFJSczLL
	Uov07RK4Mia/amIvmKFV8WP9RbYGxpkKXYycHBICJhIt3zYww9ibJ/SzdDFycLAJKEkc2xsD
	EhYR0JaYOOcgUAkXB7PAEyaJuUeWsoEkhAXiJPb93sgGUs8ioCrxcpIESJhXwFji4v4HTBAj
	NSUaLt0DszkFPCT2XzvDCGILCfBIvNqwnxGiXlDi5MwnLCA2s4C8RPPW2WC7JAS+s0l8PLgZ
	6jZJiYMrbrBMYOSfhaRnFpKeBYxMqxiFMvPKchMzc0z0MirzMiv0kvNzNzECw39Z7Z/oHYyf
	LgQfYhTgYFTi4d2x+nu6EGtiWXFl7iFGCQ5mJRHe9uAf6UK8KYmVValF+fFFpTmpxYcYpTlY
	lMR5jb6VpwgJpCeWpGanphakFsFkmTg4pRoYezZe+LI8c/P9xR2np7+/au/hKbT6TnnuK7VN
	3pN1pip9frNru3vsqQ4BD7+F95w+HtjyxWuPhU1R+cqlm1vc13r31jddMz7xMqG+rWu56hPf
	aQImxpNFWsy0ag9Edqq9PlkvsdfdtyFl4lPRLcb9C3NXz5x08KqMyL0Pd9JeZpcxhsX3lJ2p
	UmIpzkg01GIuKk4EAExPmnd7AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrELMWRmVeSWpSXmKPExsXCNUNNS5fp8I90g59ftC3mrF/DZjF96gVG
	i6/rfzFb/Lx7nN3i87PXzBarFl5jszi+dR67xeG5J1ktzs86xWJxedccNot7a/6zWpyZVmRx
	6NpzVovVazIsfm9bwebA77Fz1l12j+62y+weLUfesnos3vOSyWPTp0nsHidm/Gbx2PnQ0uP9
	vqtsHt9ue3gsfvGByWPz6WqPz5vkAniiuGxSUnMyy1KL9O0SuDImv2piL5ihVfFj/UW2BsaZ
	Cl2MnBwSAiYSmyf0s3QxcnCwCShJHNsbAxIWEdCWmDjnIHMXIxcHs8ATJom5R5aygSSEBeIk
	9v3eyAZSzyKgKvFykgRImFfAWOLi/gdMECM1JRou3QOzOQU8JPZfO8MIYgsJ8Ei82rCfEaJe
	UOLkzCcsIDazgLxE89bZzBMYeWYhSc1CklrAyLSKUSQzryw3MTPHVK84O6MyL7NCLzk/dxMj
	MOSX1f6ZuIPxy2X3Q4wCHIxKPLw7Vn9PF2JNLCuuzD3EKMHBrCTC2x78I12INyWxsiq1KD++
	qDQntfgQozQHi5I4r1d4aoKQQHpiSWp2ampBahFMlomDU6qB0cdejNMgoXzTufW17V1fWqQ/
	7gi3sl/K33wsYZomz7Q7pWGNrWab5a45+ehe7ov3zFD9JnFG0fylzH3fFPbQ1lnilx4e0i3v
	EJE7Kxzv37jq0CXNLMPa+pzcH3dj9Lvn5rI0m397XPVYQjMv2qzv9mwzBfNis2Cr7mr7K6ck
	Vy2dpanNUKPEUpyRaKjFXFScCADh+s2ydQIAAA==
X-CFilter-Loop: Reflected

On Tue, 8 Apr 2025 20:54:48 -0700 Dan Williams <dan.j.williams@intel.com> wrote:
> Dan Williams wrote:
> > >  
> > > +struct sysfs_wi_group {
> > > +	struct kobject wi_kobj;
> > > +	struct iw_node_attr *nattrs[];
> > > +};
> > > +
> > > +static struct sysfs_wi_group *wi_group;
> > > +
> > >  static ssize_t node_show(struct kobject *kobj, struct kobj_attribute *attr,
> > >  			 char *buf)
> > >  {
> > > @@ -3461,27 +3468,24 @@ static ssize_t node_store(struct kobject *kobj, struct kobj_attribute *attr,
> > >  	return count;
> > >  }
> > >  
> > > -static struct iw_node_attr **node_attrs;
> > > -
> > > -static void sysfs_wi_node_release(struct iw_node_attr *node_attr,
> > > -				  struct kobject *parent)
> > > +static void sysfs_wi_node_delete(int nid)
> > >  {
> > > -	if (!node_attr)
> > > +	if (!wi_group->nattrs[nid])
> > >  		return;
> > > -	sysfs_remove_file(parent, &node_attr->kobj_attr.attr);
> > > -	kfree(node_attr->kobj_attr.attr.name);
> > > -	kfree(node_attr);
> > > +
> > > +	sysfs_remove_file(&wi_group->wi_kobj,
> > > +			  &wi_group->nattrs[nid]->kobj_attr.attr);
> > 
> > This still looks broken to me, but I think this is more a problem that
> > was present in the original code.
> > 
> > At this point @wi_group's reference count is zero because
> > sysfs_wi_release() has been called. However, it can only be zero if it has
> > properly transitioned through kobject_del() and final kobject_put(). It
> > follows that kobject_del() arranges for kobj->sd to be NULL. That means
> > that this *should* be hitting the WARN() in kernfs_remove_by_name_ns()
> > for the !parent case.
> > 
> > So, either you are not triggering that path, or testing that path, but
> > sys_remove_file() of the child attributes should be happening *before*
> > sysfs_wi_release().
> > 
> > Did I miss something?
> 
> I think the missing change is that sysfs_wi_node_add() failures need to
> be done with a sysfs_wi_node_delete() of the added attrs *before* the
> kobject_del() of @wi_group.

Hi Dan,

Thank you for pointing out this issue.

As you suggested, I believe the most appropriate way to handle this is
to incorporate your feedback into Patch 1 
(mm/mempolicy: Fix memory leaks in weighted interleave sysfs).

To ensure that sysfs_remove_file() is called before kobject_del(), I
have restructured the code as follows:

<Previously>
static void sysfs_wi_release(struct kobject *wi_kobj)
{
	int nid;

	for (nid = 0; nid < nr_node_ids; nid++)
		sysfs_wi_node_delete(node_attrs[nid], wi_kobj);
		-> ERROR: sysfs_remove_file called here
	kfree(node_attrs);
	kfree(wi_kobj);
}

<Now>
static void sysfs_wi_node_delete_all(struct kobject *wi_kobj)
{
	int nid;

	for (nid = 0; nid < nr_node_ids; nid++)
		sysfs_wi_node_delete(node_attrs[nid], wi_kobj);
		-> sysfs_remove_file called here
}

static void sysfs_wi_release(struct kobject *wi_kobj)
{
	kfree(node_attrs);
	kfree(wi_kobj);
}

In addition, I call sysfs_wi_node_delete_all() before kobject_del()
during error handling:

+err_cleanup_kobj:
+	sysfs_wi_node_delete_all(wi_kobj);
	kobject_del(wi_kobj);

I believe this resolves the issue you raised.

That said, I have a follow-up question. With this structure, when the
system is shutting down, sysfs_remove_file() will not be called. Based
on my review of other kernel subsystems, it seems that sysfs_remove_file()
is only called during module_exit() in driver code, and not in other
built-in subsystems.

Is this an acceptable practice? If you happen to know the expected
behavior in such cases, I would appreciate your insights.

Below is the full content of the updated Patch 1.
@@ -3463,8 +3463,8 @@ static ssize_t node_store(struct kobject *kobj, struct kobj_attribute *attr,
 
 static struct iw_node_attr **node_attrs;
 
-static void sysfs_wi_node_release(struct iw_node_attr *node_attr,
-                                 struct kobject *parent)
+static void sysfs_wi_node_delete(struct iw_node_attr *node_attr,
+                                struct kobject *parent)
 {
        if (!node_attr)
                return;
@@ -3473,13 +3473,16 @@ static void sysfs_wi_node_release(struct iw_node_attr *node_attr,
        kfree(node_attr);
 }
 
-static void sysfs_wi_release(struct kobject *wi_kobj)
+static void sysfs_wi_node_delete_all(struct kobject *wi_kobj)
 {
-       int i;
+       int nid;
 
-       for (i = 0; i < nr_node_ids; i++)
-               sysfs_wi_node_release(node_attrs[i], wi_kobj);
+       for (nid = 0; nid < nr_node_ids; nid++)
+               sysfs_wi_node_delete(node_attrs[nid], wi_kobj);
+}
 
+static void sysfs_wi_release(struct kobject *wi_kobj)
+{
        kfree(node_attrs);
        kfree(wi_kobj);
 }
@@ -3547,13 +3550,14 @@ static int add_weighted_interleave_group(struct kobject *root_kobj)
                err = add_weight_node(nid, wi_kobj);
                if (err) {
                        pr_err("failed to add sysfs [node%d]\n", nid);
-                       goto err_del_kobj;
+                       goto err_cleanup_kobj;
                }
        }
 
        return 0;
 
-err_del_kobj:
+err_cleanup_kobj:
+       sysfs_wi_node_delete_all(wi_kobj);
        kobject_del(wi_kobj);
 err_put_kobj:
        kobject_put(wi_kobj);

Thank you again for your helpful feedback.

Rakie

