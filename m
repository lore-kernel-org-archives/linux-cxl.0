Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE20F381A3;
	Thu, 10 Apr 2025 08:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744272401; cv=none; b=h/kxqHlLYRh6DzfTWjKfmVvCj071Qgh3qU4vGi7ZrtjA8kuLM1EP0uR4TLXZ4vBEWUkssKY/CjPhkYKBXwZh31dhAAUJnkYypCMlWyuFJiD/Ol1d6n38nxM7VobHlk/oJz/xjl/UQqDvy8Xt0rLu3aYwBvlleW7MTzcI1aHxLEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744272401; c=relaxed/simple;
	bh=Eu7ZUw1kA+huwNWmhYz+sYJqpRJLQFYkskDCGUdGFsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dCKawVikFFIiyaIbKWidef5JN5LeVlwbd7Sd5whuXhOcVo9yVD22qgxoaNCrQsVu3asbvaGmtLGuTI50H0hKPxkUDrOwubVXs4Nd+o7iHiM+657UEchrjlphNLD0H3fYgBfMxoOS/8lhGiB6bPQZAgkgsl3mP6KcEXyDDDO/GJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-b1-67f77c09ae62
From: Rakie Kim <rakie.kim@sk.com>
To: akpm@linux-foundation.org
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
	Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v7 2/3] mm/mempolicy: Prepare weighted interleave sysfs for memory hotplug
Date: Thu, 10 Apr 2025 17:06:19 +0900
Message-ID: <20250410080629.564-1-rakie.kim@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <20250410075341.549-1-rakie.kim@sk.com>
References: 
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJLMWRmVeSWpSXmKPExsXC9ZZnoS5nzfd0g/1tshZz1q9hs5g+9QKj
	xdf1v5gtft49zm6xauE1NovjW+exW5yfdYrF4vKuOWwW99b8Z7U4M63IYvWaDAduj52z7rJ7
	dLddZvdoOfKW1WPxnpdMHps+TWL3ODHjN4vHzoeWHu/3XWXz2Hy62uPzJrkArigum5TUnMyy
	1CJ9uwSujMu3GpgLnmtUfOv/xt7AuEuhi5GTQ0LARGLp0e3MMPa5b6vZuhg5ONgElCSO7Y0B
	CYsIyEpM/XuepYuRi4NZ4BOTxMFXP1hBEsICcRL7fm9kA7FZBFQl+tc9BIvzChhLvFmxjR1i
	pqZEw6V7TCA2J8j8P7fBaoQEeCRebdjPCFEvKHFy5hMWEJtZQF6ieetsZpBlEgLf2STurvnJ
	BDFIUuLgihssExj5ZyHpmYWkZwEj0ypGocy8stzEzBwTvYzKvMwKveT83E2MwAhYVvsnegfj
	pwvBhxgFOBiVeHg9Mr6lC7EmlhVX5h5ilOBgVhLh9TT8ni7Em5JYWZValB9fVJqTWnyIUZqD
	RUmc1+hbeYqQQHpiSWp2ampBahFMlomDU6qB0ebf7f+hrAqZuueeBO+bEFX195X58RiV++oX
	1KR1JdfPLArgvjlN9UrdkS372uP/LT/QPSvc8dqjilNrefwnT/0rNCe82uT4Y8GZyU/+Xiu4
	Uvqzbf2PuEsqVhzFzyTPv+7Ycqo43/pvyWzBtzqr0jgTee/sefayqjnbqPS25Js/7zXWXc31
	OqfEUpyRaKjFXFScCADKl+KAfAIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMLMWRmVeSWpSXmKPExsXCNUNNS5ez5nu6weeTQhZz1q9hs5g+9QKj
	xdf1v5gtft49zm7x+dlrZotVC6+xWRzfOo/d4vDck6wW52edYrG4vGsOm8W9Nf9ZLc5MK7I4
	dO05q8XqNRkWv7etYHPg99g56y67R3fbZXaPliNvWT0W73nJ5LHp0yR2jxMzfrN47Hxo6fF+
	31U2j2+3PTwWv/jA5LH5dLXH501yATxRXDYpqTmZZalF+nYJXBmXbzUwFzzXqPjW/429gXGX
	QhcjJ4eEgInEuW+r2boYOTjYBJQkju2NAQmLCMhKTP17nqWLkYuDWeATk8TBVz9YQRLCAnES
	+35vZAOxWQRUJfrXPQSL8woYS7xZsY0dYqamRMOle0wgNifI/D+3wWqEBHgkXm3YzwhRLyhx
	cuYTFhCbWUBeonnrbOYJjDyzkKRmIUktYGRaxSiSmVeWm5iZY6pXnJ1RmZdZoZecn7uJERj0
	y2r/TNzB+OWy+yFGAQ5GJR5ej4xv6UKsiWXFlbmHGCU4mJVEeD0Nv6cL8aYkVlalFuXHF5Xm
	pBYfYpTmYFES5/UKT00QEkhPLEnNTk0tSC2CyTJxcEo1MM7abfvgpewkbpP0gEcnzPyY/fx3
	ZUe1WF66en257+kGEZs36n4Xjxd8WbL2VEZHVhrXquK+0If1i+IZle85yy7Rud25N+vjAsGm
	ec+riiOOPNt/ssH41hSJm3I7RXWVbbfoLUnSnPKM71eUX9t3AfY72+8rTtLdN1vv2r4f6RxV
	2yJPrGpMklZiKc5INNRiLipOBABEqBxVdgIAAA==
X-CFilter-Loop: Reflected

On Thu, 10 Apr 2025 16:53:33 +0900 Rakie Kim <rakie.kim@sk.com> wrote:
> On Wed, 9 Apr 2025 11:51:36 -0700 Dan Williams <dan.j.williams@intel.com> wrote:
> > Rakie Kim wrote:
> > > > > > +static void sysfs_wi_node_delete(int nid)
> > > > > >  {
> > > > > > -	if (!node_attr)
> > > > > > +	if (!wi_group->nattrs[nid])
> > > > > >  		return;
> > > > > > -	sysfs_remove_file(parent, &node_attr->kobj_attr.attr);
> > > > > > -	kfree(node_attr->kobj_attr.attr.name);
> > > > > > -	kfree(node_attr);
> > > > > > +
> > > > > > +	sysfs_remove_file(&wi_group->wi_kobj,
> > > > > > +			  &wi_group->nattrs[nid]->kobj_attr.attr);
> > > > > 
> > > > > This still looks broken to me, but I think this is more a problem that
> > > > > was present in the original code.
> > > > > 
> > > > > At this point @wi_group's reference count is zero because
> > > > > sysfs_wi_release() has been called. However, it can only be zero if it has
> > > > > properly transitioned through kobject_del() and final kobject_put(). It
> > > > > follows that kobject_del() arranges for kobj->sd to be NULL. That means
> > > > > that this *should* be hitting the WARN() in kernfs_remove_by_name_ns()
> > > > > for the !parent case.
> > > > > 
> > > > > So, either you are not triggering that path, or testing that path, but
> > > > > sys_remove_file() of the child attributes should be happening *before*
> > > > > sysfs_wi_release().
> > > > > 
> > > > > Did I miss something?
> > > > 
> > > > I think the missing change is that sysfs_wi_node_add() failures need to
> > > > be done with a sysfs_wi_node_delete() of the added attrs *before* the
> > > > kobject_del() of @wi_group.
> > > 
> > > Hi Dan Williams
> > > 
> > > Thank you very much for identifying this potential issue in the code.
> > > 
> > > As you pointed out, this seems to be a problem that was already present in
> > > the original implementation, and I agree that it needs to be addressed.
> > > 
> > > However, since this issue existed prior to the changes in this patch
> > > series, I believe it would be more appropriate to fix it in a separate
> > > follow-up patch rather than include it here.
> > 
> > I tend to disagree. The whole motivation of this series is to get the
> > kobject lifetime handling correct in order to add the new dynamic
> > capability. The claimed correctness fixups are incomplete. There is time
> > to respin this (we are only at -rc1) and get it right before landing the
> > new dynamic capability.
> > 
> > One of the outcomes of the "MM Process" topic at LSF/MM was that Andrew
> > wanted more feedback on when patches are not quite ready for prime-time
> > and I think this is an example of a patch set that deserves another spin
> > to meet the stated goals.
> > 
> > > I will start preparing a new patch to address this problem, and I would
> > > greatly appreciate it if you could review it once it's ready.
> > 
> > Will definitely review it. I will leave to Andrew if he wants an
> > incremental fixup on top of this series, or rebase on top of a fully
> > fixed baseline. My preference is finish fixing all the old kobject()
> > issues and then rebase the new dynamic work on top. Either way, do not
> > be afraid to ask Andrew to replace a series in -mm, that's a sign of the
> > process working as expected.
> 
> Thank you very much for your advice, and I completely agree with your
> recommendation. I will immediately ask Andrew to remove this patch series
> from -mm. Then, I will prepare a new version, v8, which properly addresses
> the kobject-related issues you pointed out.
> 
> Once again, I sincerely appreciate your thoughtful and detailed feedback.
> 
> Rakie
> 

To Andrew

I sincerely apologize for the inconvenience. It appears that this commit still
requires additional corrections. I would appreciate it if you could drop the
changes you merged into -mm, mm-new branch yesterday.

<1>
The patch titled
     Subject: mm/mempolicy: fix memory leaks in weighted interleave sysfs has been added to the -mm mm-new branch.  Its filename is
     mm-mempolicy-fix-memory-leaks-in-weighted-interleave-sysfs.patch
This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-mempolicy-fix-memory-leaks-in-weighted-interleave-sysfs.patch

<2>
The patch titled
     Subject: mm/mempolicy: prepare weighted interleave sysfs for memory hotplug has been added to the -mm mm-new branch.  Its filename is
     mm-mempolicy-prepare-weighted-interleave-sysfs-for-memory-hotplug.patch
This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-mempolicy-prepare-weighted-interleave-sysfs-for-memory-hotplug.patch

<3>
The patch titled
     Subject: mm/mempolicy: support memory hotplug in weighted interleave has been added to the -mm mm-new branch.  Its filename is
     mm-mempolicy-support-memory-hotplug-in-weighted-interleave.patch
This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-mempolicy-support-memory-hotplug-in-weighted-interleave.patch

Rakie

