Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1031172A;
	Thu, 17 Apr 2025 01:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744854972; cv=none; b=NNAnWK++xJJdDiDbemJ7ng372ntV8g/iBlH4rMSs5zzMbEUTmuy3KuRzfwfnujJ7zp0nIOedAcy0m7PYqBJxiaTYayrOCMLK+bnDAHgTQkRKRtzOUryFv5hUWogUWXrJLGLT1gZwzlAbF9quuZaJc2rWfs7niDS84B9/Doky73Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744854972; c=relaxed/simple;
	bh=nV0XAzhuvzxqrFlXRHsn3+SUZGp/iNsb52WBlKr1hVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YnhNFAKCvH2f7SbwD20L3MyS+4PJwE3UHJuePUaAJym+0bemxEZoj+1zmyJfpOI8NtsL66bsCHq/BWIIMac/coRqqpqVCZKJhH+Muxa5RGGYctx2FAAKU8yVQH2W78A9xcEqPoB3EYQi5StNN/iR08R2ngwNncWNB+59cUqfji0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-3d-68005fb3903e
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
Subject: Re: [PATCH v8 2/3] mm/mempolicy: Prepare weighted interleave sysfs for memory hotplug
Date: Thu, 17 Apr 2025 10:55:52 +0900
Message-ID: <20250417015600.661-1-rakie.kim@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <68003826cb17d_1302d294e@dwillia2-xfh.jf.intel.com.notmuch>
References: 
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBLMWRmVeSWpSXmKPExsXC9ZZnoe7meIYMg6/NthZz1q9hs5g+9QKj
	xdf1v5gtft49zm6xauE1NovjW+exW5yfdYrF4vKuOWwW99b8Z7U4M63IYvWaDAduj52z7rJ7
	dLddZvdoOfKW1WPxnpdMHps+TWL3ODHjN4vHzoeWHu/3XWXz2Hy62uPzJrkArigum5TUnMyy
	1CJ9uwSujOMNnAW7ZCt2v33G3MB4X7yLkZNDQsBEYvGzF6ww9qQ585i6GDk42ASUJI7tjQEJ
	iwhoS0ycc5C5i5GLg1ngCZPE3CNL2UASwgJxEie2P2QCsVkEVCVWXz0PZvMKGEvs6DnHBjFT
	U6Lh0j2wOKeAh8SuvcvYQWwhAR6JVxv2M0LUC0qcnPmEBcRmFpCXaN46G2yZhMB3Nolpj39B
	HScpcXDFDZYJjPyzkPTMQtKzgJFpFaNQZl5ZbmJmjoleRmVeZoVecn7uJkZg+C+r/RO9g/HT
	heBDjAIcjEo8vCcW/U8XYk0sK67MPcQowcGsJMJ7zvxfuhBvSmJlVWpRfnxRaU5q8SFGaQ4W
	JXFeo2/lKUIC6YklqdmpqQWpRTBZJg5OqQbG4F8TueVTjrmmPPpcm8G3JX3+joAg9tee6mmd
	CXfPW7GkCbgINF/d2TZFLlZgekLHRNteg/6KG9zJwv1Lzy5/opre+tp66f50M+ujpevzBEvO
	SE+YW/U5W5bv60FJ9ZvpL2dHRi+aymy989d5Ke0+x3Jv3hVPhO6m7JHeLtZmZ/bCMiKQrUKJ
	pTgj0VCLuag4EQCIQsjyewIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrELMWRmVeSWpSXmKPExsXCNUNNS3dzPEOGwYJGfYs569ewWUyfeoHR
	4uv6X8wWP+8eZ7f4/Ow1s8WqhdfYLI5vncducXjuSVaL87NOsVhc3jWHzeLemv+sFmemFVkc
	uvac1WL1mgyL39tWsDnwe+ycdZfdo7vtMrtHy5G3rB6L97xk8tj0aRK7x4kZv1k8dj609Hi/
	7yqbx7fbHh6LX3xg8th8utrj8ya5AJ4oLpuU1JzMstQifbsErozjDZwFu2Qrdr99xtzAeF+8
	i5GTQ0LARGLSnHlMXYwcHGwCShLH9saAhEUEtCUmzjnI3MXIxcEs8IRJYu6RpWwgCWGBOIkT
	2x8ygdgsAqoSq6+eB7N5BYwldvScY4OYqSnRcOkeWJxTwENi195l7CC2kACPxKsN+xkh6gUl
	Ts58wgJiMwvISzRvnc08gZFnFpLULCSpBYxMqxhFMvPKchMzc0z1irMzKvMyK/SS83M3MQJD
	flntn4k7GL9cdj/EKMDBqMTDe2LR/3Qh1sSy4srcQ4wSHMxKIrznzP+lC/GmJFZWpRblxxeV
	5qQWH2KU5mBREuf1Ck9NEBJITyxJzU5NLUgtgskycXBKNTCGsVyYsTyHxe3jqkeSNxLuzA4M
	jyj21du3vGTtvxMZl/jm3m2ddGfz6eLLjm/vCq3fLaRXtYaThWX1VSGGtfHtnAt3L3B9na2e
	W8UkdzWv9fSSI8d0TRp6Dmx4pR/6Nmhy14WQxbNY1pxQWyx5ecPCpCnXe/xX8Ty8UcuxeKJB
	VbfFdZPjgl9alViKMxINtZiLihMBRKJt6XUCAAA=
X-CFilter-Loop: Reflected

On Wed, 16 Apr 2025 16:07:18 -0700 Dan Williams <dan.j.williams@intel.com> wrote:
> Rakie Kim wrote:
> > Previously, the weighted interleave sysfs structure was statically
> > managed during initialization. This prevented new nodes from being
> > recognized when memory hotplug events occurred, limiting the ability
> > to update or extend sysfs entries dynamically at runtime.
> > 
> > To address this, this patch refactors the sysfs infrastructure and
> > encapsulates it within a new structure, `sysfs_wi_group`, which holds
> > both the kobject and an array of node attribute pointers.
> > 
> > By allocating this group structure globally, the per-node sysfs
> > attributes can be managed beyond initialization time, enabling
> > external modules to insert or remove node entries in response to
> > events such as memory hotplug or node online/offline transitions.
> > 
> > Instead of allocating all per-node sysfs attributes at once, the
> > initialization path now uses the existing sysfs_wi_node_add() and
> > sysfs_wi_node_delete() helpers. This refactoring makes it possible
> > to modularly manage per-node sysfs entries and ensures the
> > infrastructure is ready for runtime extension.
> > 
> > Signed-off-by: Rakie Kim <rakie.kim@sk.com>
> > Reviewed-by: Gregory Price <gourry@gourry.net>
> > Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> > ---
> >  mm/mempolicy.c | 60 ++++++++++++++++++++++++--------------------------
> >  1 file changed, 29 insertions(+), 31 deletions(-)
> > 
> > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > index dcf03c389b51..998635127e9d 100644
> > --- a/mm/mempolicy.c
> > +++ b/mm/mempolicy.c
> > @@ -3419,6 +3419,13 @@ struct iw_node_attr {
> >  	int nid;
> >  };
> >  
> > +struct sysfs_wi_group {
> > +	struct kobject wi_kobj;
> > +	struct iw_node_attr *nattrs[];
> > +};
> > +
> > +static struct sysfs_wi_group *wi_group;
> > +
> >  static ssize_t node_show(struct kobject *kobj, struct kobj_attribute *attr,
> >  			 char *buf)
> >  {
> > @@ -3461,24 +3468,23 @@ static ssize_t node_store(struct kobject *kobj, struct kobj_attribute *attr,
> >  	return count;
> >  }
> >  
> > -static struct iw_node_attr **node_attrs;
> > -
> > -static void sysfs_wi_node_delete(struct iw_node_attr *node_attr,
> > -				 struct kobject *parent)
> > +static void sysfs_wi_node_delete(int nid)
> >  {
> > -	if (!node_attr)
> > +	if (!wi_group->nattrs[nid])
> >  		return;
> > -	sysfs_remove_file(parent, &node_attr->kobj_attr.attr);
> > -	kfree(node_attr->kobj_attr.attr.name);
> > -	kfree(node_attr);
> > +
> > +	sysfs_remove_file(&wi_group->wi_kobj,
> > +			  &wi_group->nattrs[nid]->kobj_attr.attr);
> > +	kfree(wi_group->nattrs[nid]->kobj_attr.attr.name);
> > +	kfree(wi_group->nattrs[nid]);
> >  }
> >  
> > -static void sysfs_wi_node_delete_all(struct kobject *wi_kobj)
> > +static void sysfs_wi_node_delete_all(void)
> >  {
> >  	int nid;
> >  
> >  	for (nid = 0; nid < nr_node_ids; nid++)
> > -		sysfs_wi_node_delete(node_attrs[nid], wi_kobj);
> > +		sysfs_wi_node_delete(nid);
> >  }
> >  
> >  static void iw_table_free(void)
> > @@ -3501,8 +3507,7 @@ static void iw_table_free(void)
> >  static void wi_kobj_release(struct kobject *wi_kobj)
> >  {
> >  	iw_table_free();
> > -	kfree(node_attrs);
> > -	kfree(wi_kobj);
> > +	kfree(wi_group);
> 
> Ah, look just one more iw_table_free() deletion to be able to switch to
> kobject_create_and_add() flow.
> 
> For what this patch is though you can add:
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>

Thank you for the suggestion.
I have already removed the iw_table_free() and kfree(node_attrs) from
the release path in Patch1 as part of wi_cleanup().

Rakie

