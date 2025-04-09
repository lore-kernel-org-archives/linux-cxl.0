Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B18B1D5166;
	Wed,  9 Apr 2025 05:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744178201; cv=none; b=cYHQd65C934+DmxfSDw/6YVEGxOUAmf7ShM7s/g8Pf90OJFz4fkaqgPJcI/6fQIFyP9ngKnrR6pG51PTloRk2dGahNFLKIdBehuyCdn5PjUfS7hRxgoVeXTK+kmd4nTHNen4sxIBqmzNGQbcWiesxQTwj4vnEhvW5QVrhizpC+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744178201; c=relaxed/simple;
	bh=tr8U1M8ttdcHQ5OAE80g0flpZmDz67hIT51+9wlGVRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B/+1jd4Nvq2sdi/lGEdsMuNRA4XzqQZDC5inpaC4Slf71vgsBYnV58fXg439lcCzeSlilMjzuQRDyyt++L71byjTV1h6iTuv5X3RiqJa9pkBI1KpCczUMkS1IHjqnpbDO2LP3g0MMBlTCA0J19ylgyzprK4wl13Dr49VTxUKfe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-6f-67f60c092023
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
Date: Wed,  9 Apr 2025 14:56:11 +0900
Message-ID: <20250409055618.512-1-rakie.kim@sk.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJLMWRmVeSWpSXmKPExsXC9ZZnkS4nz7d0g10TZSzmrF/DZjF96gVG
	i6/rfzFb/Lx7nN1i1cJrbBbHt85jtzg/6xSLxeVdc9gs7q35z2pxZlqRxeo1GQ7cHjtn3WX3
	6G67zO7RcuQtq8fiPS+ZPDZ9msTucWLGbxaPnQ8tPd7vu8rmsfl0tcfnTXIBXFFcNimpOZll
	qUX6dglcGf//PGYpOK5UsfnGb7YGxn3SXYycHBICJhLnZi9jhbGXn1nB3sXIwcEmoCRxbG8M
	SFhEQFti4pyDzF2MXBzMAk+YJOYeWcoGkhAWiJPY93sjmM0ioCpxc+8DdhCbV8BYom97BwvE
	TE2Jhkv3mEBsTgEPif3XzjCC2EICPBKvNuxnhKgXlDg58wlYPbOAvETz1tlgyyQEvrNJLP+x
	GWqQpMTBFTdYJjDyz0LSMwtJzwJGplWMQpl5ZbmJmTkmehmVeZkVesn5uZsYgRGwrPZP9A7G
	TxeCDzEKcDAq8fDeUPmaLsSaWFZcmXuIUYKDWUmE9+3EL+lCvCmJlVWpRfnxRaU5qcWHGKU5
	WJTEeY2+lacICaQnlqRmp6YWpBbBZJk4OKUaGBdtsNI6Ld8y1W675B31+4lHT5wre1JT6Mb3
	/v6yLDGWT+X883YXmc9kdWzV3y+xZsK3sK6+WxucLDaf3WzNa6of+fH5PtUNR09NTzn9bFuI
	XbLY9OMX4n8EKWmZbshYOCP5dMa51VsyZGZPtZGc0BnSITeHs1vccXvnDt+tCsVnDD7LfnG4
	e0aJpTgj0VCLuag4EQC+hkVUfAIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMLMWRmVeSWpSXmKPExsXCNUNNS5eT51u6wY0ZvBZz1q9hs5g+9QKj
	xdf1v5gtft49zm7x+dlrZotVC6+xWRzfOo/d4vDck6wW52edYrG4vGsOm8W9Nf9ZLc5MK7I4
	dO05q8XqNRkWv7etYHPg99g56y67R3fbZXaPliNvWT0W73nJ5LHp0yR2jxMzfrN47Hxo6fF+
	31U2j2+3PTwWv/jA5LH5dLXH501yATxRXDYpqTmZZalF+nYJXBn//zxmKTiuVLH5xm+2BsZ9
	0l2MnBwSAiYSy8+sYO9i5OBgE1CSOLY3BiQsIqAtMXHOQeYuRi4OZoEnTBJzjyxlA0kIC8RJ
	7Pu9EcxmEVCVuLn3ATuIzStgLNG3vYMFYqamRMOle0wgNqeAh8T+a2cYQWwhAR6JVxv2M0LU
	C0qcnPkErJ5ZQF6ieets5gmMPLOQpGYhSS1gZFrFKJKZV5abmJljqlecnVGZl1mhl5yfu4kR
	GPTLav9M3MH45bL7IUYBDkYlHt4bKl/ThVgTy4orcw8xSnAwK4nwvp34JV2INyWxsiq1KD++
	qDQntfgQozQHi5I4r1d4aoKQQHpiSWp2ampBahFMlomDU6qB8WiT8hsTqbrNUr9vVeiuLvbX
	WbAnWLVJaMaGC5c3vvybZPU5d/GcI6GbZPl3FRYwp/Vt5j/i8/3+VAfO4C9S/92rrrxcY1dS
	/dJxqt3RlUppd/mvTNulZvDwxePw9il++wyOLuV+3GgSy29XH3TUNPYQR+OXoyLqAlIFAUuv
	XzBPLdoXKDo9VomlOCPRUIu5qDgRAG1lSRl2AgAA
X-CFilter-Loop: Reflected

On Tue, 8 Apr 2025 20:54:48 -0700 Dan Williams <dan.j.williams@intel.com> wrote:
> Dan Williams wrote:
> > Rakie Kim wrote:
> > > Previously, the weighted interleave sysfs structure was statically
> > > managed during initialization. This prevented new nodes from being
> > > recognized when memory hotplug events occurred, limiting the ability
> > > to update or extend sysfs entries dynamically at runtime.
> > > 
> > > To address this, this patch refactors the sysfs infrastructure and
> > > encapsulates it within a new structure, `sysfs_wi_group`, which holds
> > > both the kobject and an array of node attribute pointers.
> > > 
> > > By allocating this group structure globally, the per-node sysfs
> > > attributes can be managed beyond initialization time, enabling
> > > external modules to insert or remove node entries in response to
> > > events such as memory hotplug or node online/offline transitions.
> > > 
> > > Instead of allocating all per-node sysfs attributes at once, the
> > > initialization path now uses the existing sysfs_wi_node_add() and
> > > sysfs_wi_node_delete() helpers. This refactoring makes it possible
> > > to modularly manage per-node sysfs entries and ensures the
> > > infrastructure is ready for runtime extension.
> > > 
> > > Signed-off-by: Rakie Kim <rakie.kim@sk.com>
> > > Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
> > > Signed-off-by: Yunjeong Mun <yunjeong.mun@sk.com>
> > > Reviewed-by: Gregory Price <gourry@gourry.net>
> > > ---
> > >  mm/mempolicy.c | 61 ++++++++++++++++++++++++--------------------------
> > >  1 file changed, 29 insertions(+), 32 deletions(-)
> > > 
> > > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > > index 0da102aa1cfc..988575f29c53 100644
> > > --- a/mm/mempolicy.c
> > > +++ b/mm/mempolicy.c
> > > @@ -3419,6 +3419,13 @@ struct iw_node_attr {
> > >  	int nid;
> > >  };
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

Hi Dan Williams

Thank you very much for identifying this potential issue in the code.

As you pointed out, this seems to be a problem that was already present in
the original implementation, and I agree that it needs to be addressed.

However, since this issue existed prior to the changes in this patch
series, I believe it would be more appropriate to fix it in a separate
follow-up patch rather than include it here.

I will start preparing a new patch to address this problem, and I would
greatly appreciate it if you could review it once it's ready.

Rakie

