Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C9B146A68;
	Thu, 10 Apr 2025 07:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744271634; cv=none; b=oYLNKBoR/PzrzvrK1/rCobz0vXtQ3TKAuLa4lEbmRn9lSedm/gMkQr2ye1YuZJkdlf0IW+FrTp5z4hcuFtUzCx4yyauAYaWgzs0/G7P1ev61mnMlN7DyQWqU31sR0bESbfjGMkv4Ese1k4ylpwI7hKcn8/2ETrnfGNCtLIalIbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744271634; c=relaxed/simple;
	bh=F6qD/pnXLcBrzNtBeLQR23U/XUyZK2uBB+lRPIcoqMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TuDvOzhB82Kk1bim6ly/3TLGHuvSoPHtreXOGGHIAHB1yvgzRDT0Xqa3IudBbmNadB66wKSSMsuXZhUf+SyfE9xPptnOKasMWNynv0bsiPMlKbaFLyVfPQhH3oxzCwtvHEbS38QYMGfN4TCqch9XIJ2gCyjcBiUOxR1Q7Ma/h40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-3b-67f7790abe83
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
Date: Thu, 10 Apr 2025 16:53:33 +0900
Message-ID: <20250410075341.549-1-rakie.kim@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <67f6c1b89cd6a_71fe294bf@dwillia2-xfh.jf.intel.com.notmuch>
References: 
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBLMWRmVeSWpSXmKPExsXC9ZZnkS5X5fd0g11vBSzmrF/DZjF96gVG
	i6/rfzFb/Lx7nN1i1cJrbBbHt85jtzg/6xSLxeVdc9gs7q35z2pxZlqRxeo1GQ7cHjtn3WX3
	6G67zO7RcuQtq8fiPS+ZPDZ9msTucWLGbxaPnQ8tPd7vu8rmsfl0tcfnTXIBXFFcNimpOZll
	qUX6dglcGYc/PWct+GxQMefyBrYGxn+qXYwcHBICJhI7WtO7GDnBzJb9FxlBwmwCShLH9saA
	hEUEtCUmzjnI3MXIxcEs8IRJYu6RpWwgCWGBOIl9vzeC2SwCqhIHu6cxg9i8AsYSF39MZoKY
	qSnRcOkemM0p4CFxfuZlsBohAR6JVxv2M0LUC0qcnPmEBcRmFpCXaN46G2yZhMB3Non5Z96z
	QwySlDi44gbLBEb+WUh6ZiHpWcDItIpRKDOvLDcxM8dEL6MyL7NCLzk/dxMjMPyX1f6J3sH4
	6ULwIUYBDkYlHl6PjG/pQqyJZcWVuYcYJTiYlUR4PQ2/pwvxpiRWVqUW5ccXleakFh9ilOZg
	URLnNfpWniIkkJ5YkpqdmlqQWgSTZeLglGpgrCj/yS5zR0fqFX9+0JYH8p/+rWq4crX36idG
	Fas4gz23ZK6qOX4+JfOcYfmUzg/30s+eX6dowTB1w/mw6u7/D9+9ixUqm3O65nw/c51c+pqj
	mgZbBNPfMsWVX5tf5LtitquMp5Og1MbMYwwMz/LmfNW+nDhxen6BWaB5gslF8XRt2xX9l+Nu
	K7EUZyQaajEXFScCAPu4C+N7AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMLMWRmVeSWpSXmKPExsXCNUNNS5er8nu6wZLXjBZz1q9hs5g+9QKj
	xdf1v5gtft49zm7x+dlrZotVC6+xWRzfOo/d4vDck6wW52edYrG4vGsOm8W9Nf9ZLc5MK7I4
	dO05q8XqNRkWv7etYHPg99g56y67R3fbZXaPliNvWT0W73nJ5LHp0yR2jxMzfrN47Hxo6fF+
	31U2j2+3PTwWv/jA5LH5dLXH501yATxRXDYpqTmZZalF+nYJXBmHPz1nLfhsUDHn8ga2BsZ/
	ql2MnBwSAiYSLfsvMnYxcnCwCShJHNsbAxIWEdCWmDjnIHMXIxcHs8ATJom5R5aygSSEBeIk
	9v3eCGazCKhKHOyexgxi8woYS1z8MZkJYqamRMOle2A2p4CHxPmZl8FqhAR4JF5t2M8IUS8o
	cXLmExYQm1lAXqJ562zmCYw8s5CkZiFJLWBkWsUokplXlpuYmWOqV5ydUZmXWaGXnJ+7iREY
	9Mtq/0zcwfjlsvshRgEORiUeXo+Mb+lCrIllxZW5hxglOJiVRHg9Db+nC/GmJFZWpRblxxeV
	5qQWH2KU5mBREuf1Ck9NEBJITyxJzU5NLUgtgskycXBKNTBKBTh89U0o3RffcVW7VmIuj9wE
	VdU37069nuZ5s02Zy/jlkjnLpp91lWW52HRmVcqnlGVzbLu3MTY6ns7Xi+c/dpJd8LPKtYtL
	GTRddryKyN/38Mc35y96xozZc7epZTNqnBDT0WLPTN4t6v534ceLat4Zh32+3+p2qYk/9l9q
	59Gn09+YnJBSYinOSDTUYi4qTgQAUj5HIHYCAAA=
X-CFilter-Loop: Reflected

On Wed, 9 Apr 2025 11:51:36 -0700 Dan Williams <dan.j.williams@intel.com> wrote:
> Rakie Kim wrote:
> > On Tue, 8 Apr 2025 20:54:48 -0700 Dan Williams <dan.j.williams@intel.com> wrote:
> > > Dan Williams wrote:
> > > > Rakie Kim wrote:
> > > > > Previously, the weighted interleave sysfs structure was statically
> > > > > managed during initialization. This prevented new nodes from being
> > > > > recognized when memory hotplug events occurred, limiting the ability
> > > > > to update or extend sysfs entries dynamically at runtime.
> > > > > 
> > > > > To address this, this patch refactors the sysfs infrastructure and
> > > > > encapsulates it within a new structure, `sysfs_wi_group`, which holds
> > > > > both the kobject and an array of node attribute pointers.
> > > > > 
> > > > > By allocating this group structure globally, the per-node sysfs
> > > > > attributes can be managed beyond initialization time, enabling
> > > > > external modules to insert or remove node entries in response to
> > > > > events such as memory hotplug or node online/offline transitions.
> > > > > 
> > > > > Instead of allocating all per-node sysfs attributes at once, the
> > > > > initialization path now uses the existing sysfs_wi_node_add() and
> > > > > sysfs_wi_node_delete() helpers. This refactoring makes it possible
> > > > > to modularly manage per-node sysfs entries and ensures the
> > > > > infrastructure is ready for runtime extension.
> > > > > 
> > > > > Signed-off-by: Rakie Kim <rakie.kim@sk.com>
> > > > > Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
> > > > > Signed-off-by: Yunjeong Mun <yunjeong.mun@sk.com>
> > > > > Reviewed-by: Gregory Price <gourry@gourry.net>
> > > > > ---
> > > > >  mm/mempolicy.c | 61 ++++++++++++++++++++++++--------------------------
> > > > >  1 file changed, 29 insertions(+), 32 deletions(-)
> > > > > 
> > > > > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > > > > index 0da102aa1cfc..988575f29c53 100644
> > > > > --- a/mm/mempolicy.c
> > > > > +++ b/mm/mempolicy.c
> > > > > @@ -3419,6 +3419,13 @@ struct iw_node_attr {
> > > > >  	int nid;
> > > > >  };
> > > > >  
> > > > > +struct sysfs_wi_group {
> > > > > +	struct kobject wi_kobj;
> > > > > +	struct iw_node_attr *nattrs[];
> > > > > +};
> > > > > +
> > > > > +static struct sysfs_wi_group *wi_group;
> > > > > +
> > > > >  static ssize_t node_show(struct kobject *kobj, struct kobj_attribute *attr,
> > > > >  			 char *buf)
> > > > >  {
> > > > > @@ -3461,27 +3468,24 @@ static ssize_t node_store(struct kobject *kobj, struct kobj_attribute *attr,
> > > > >  	return count;
> > > > >  }
> > > > >  
> > > > > -static struct iw_node_attr **node_attrs;
> > > > > -
> > > > > -static void sysfs_wi_node_release(struct iw_node_attr *node_attr,
> > > > > -				  struct kobject *parent)
> > > > > +static void sysfs_wi_node_delete(int nid)
> > > > >  {
> > > > > -	if (!node_attr)
> > > > > +	if (!wi_group->nattrs[nid])
> > > > >  		return;
> > > > > -	sysfs_remove_file(parent, &node_attr->kobj_attr.attr);
> > > > > -	kfree(node_attr->kobj_attr.attr.name);
> > > > > -	kfree(node_attr);
> > > > > +
> > > > > +	sysfs_remove_file(&wi_group->wi_kobj,
> > > > > +			  &wi_group->nattrs[nid]->kobj_attr.attr);
> > > > 
> > > > This still looks broken to me, but I think this is more a problem that
> > > > was present in the original code.
> > > > 
> > > > At this point @wi_group's reference count is zero because
> > > > sysfs_wi_release() has been called. However, it can only be zero if it has
> > > > properly transitioned through kobject_del() and final kobject_put(). It
> > > > follows that kobject_del() arranges for kobj->sd to be NULL. That means
> > > > that this *should* be hitting the WARN() in kernfs_remove_by_name_ns()
> > > > for the !parent case.
> > > > 
> > > > So, either you are not triggering that path, or testing that path, but
> > > > sys_remove_file() of the child attributes should be happening *before*
> > > > sysfs_wi_release().
> > > > 
> > > > Did I miss something?
> > > 
> > > I think the missing change is that sysfs_wi_node_add() failures need to
> > > be done with a sysfs_wi_node_delete() of the added attrs *before* the
> > > kobject_del() of @wi_group.
> > 
> > Hi Dan Williams
> > 
> > Thank you very much for identifying this potential issue in the code.
> > 
> > As you pointed out, this seems to be a problem that was already present in
> > the original implementation, and I agree that it needs to be addressed.
> > 
> > However, since this issue existed prior to the changes in this patch
> > series, I believe it would be more appropriate to fix it in a separate
> > follow-up patch rather than include it here.
> 
> I tend to disagree. The whole motivation of this series is to get the
> kobject lifetime handling correct in order to add the new dynamic
> capability. The claimed correctness fixups are incomplete. There is time
> to respin this (we are only at -rc1) and get it right before landing the
> new dynamic capability.
> 
> One of the outcomes of the "MM Process" topic at LSF/MM was that Andrew
> wanted more feedback on when patches are not quite ready for prime-time
> and I think this is an example of a patch set that deserves another spin
> to meet the stated goals.
> 
> > I will start preparing a new patch to address this problem, and I would
> > greatly appreciate it if you could review it once it's ready.
> 
> Will definitely review it. I will leave to Andrew if he wants an
> incremental fixup on top of this series, or rebase on top of a fully
> fixed baseline. My preference is finish fixing all the old kobject()
> issues and then rebase the new dynamic work on top. Either way, do not
> be afraid to ask Andrew to replace a series in -mm, that's a sign of the
> process working as expected.

Thank you very much for your advice, and I completely agree with your
recommendation. I will immediately ask Andrew to remove this patch series
from -mm. Then, I will prepare a new version, v8, which properly addresses
the kobject-related issues you pointed out.

Once again, I sincerely appreciate your thoughtful and detailed feedback.

Rakie

