Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5C71DFF0;
	Mon, 24 Mar 2025 08:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742806171; cv=none; b=rDI6vHOGZCZlTLbcFNmjTz5MTGfcagTm7sxKTzGmFByjAQkNGNS2qUF0KrEKJz2LlBlZDmW74/yZBg+3ZtHKWpDzw1iSyVrY+fbLWsRQ/7sIQZ8V0K4H0i/ISKPVHgr7r1w9NM5/KjoIg/OJXDsRrQn96gNzmQWhhbYHTyA5iH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742806171; c=relaxed/simple;
	bh=tgHSdLmcu+BTlohdPKf8RQNBJRwJvD587RFMtRPn/Ug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jC4GfRudhxNe4fMfCnhM4P+GXUjKYxl1ic4mpxnTPuZCwVzPs4xzpcbL84ScVzIMJBoPZU98rVIUae9LGFrZRY4JAgg58x0Glm4lbFb6TFA+gCwOqeoFigFW9RAfn6LEHOh92HJIcOpoufgd5KE5xygNVBOttM1Rx8hMHK54aFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-a9-67e11c94e9b9
From: Rakie Kim <rakie.kim@sk.com>
To: Gregory Price <gourry@gourry.net>
Cc: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	joshua.hahnjy@gmail.com,
	dan.j.williams@intel.com,
	ying.huang@linux.alibaba.com,
	david@redhat.com,
	Jonathan.Cameron@huawei.com,
	kernel_team@skhynix.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com,
	Rakie Kim <rakie.kim@sk.com>
Subject: Re: [PATCH v3 3/3] mm/mempolicy: Support memory hotplug in weighted interleave
Date: Mon, 24 Mar 2025 17:48:39 +0900
Message-ID: <20250324084920.987-1-rakie.kim@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <Z912rrV4xTOBwEP7@gourry-fedora-PF4VCD3F>
References: 
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPLMWRmVeSWpSXmKPExsXC9ZZnke5UmYfpBt3NLBZz1q9hs5g+9QKj
	xdf1v5gtft49zm6xauE1NovjW+exW5yfdYrF4vKuOWwW99b8Z7VYvSbDgctj56y77B7dbZfZ
	PVqOvGX1WLznJZPHpk+T2D1OzPjN4rHzoaXH+31X2Tw+b5IL4IzisklJzcksSy3St0vgyph+
	/T1TwWWpikPnFzE2ML4R6WLk5JAQMJF4sGYmE4x9YNNc1i5GDg42ASWJY3tjQEwRAVWJtivu
	XYxcHMwCj5gkTrcvZQUpFxYIl+g++JAFpIYFqObGu1yQMK+AscTvxysZISZqSjRcugc2nVPA
	TOLt27XsILaQAI/Eqw37GSHqBSVOznzCAmIzC8hLNG+dzQyyS0LgNZtEx7tNzBCDJCUOrrjB
	MoGRfxaSnllIehYwMq1iFMrMK8tNzMwx0cuozMus0EvOz93ECAz2ZbV/oncwfroQfIhRgINR
	iYd3w8v76UKsiWXFlbmHGCU4mJVEeI+xPkwX4k1JrKxKLcqPLyrNSS0+xCjNwaIkzmv0rTxF
	SCA9sSQ1OzW1ILUIJsvEwSnVwDi/5khosGTS3u/dp1ojWoUuRq90LZfcFjS34c3y1v8GJ2v2
	nPyn41y8tvTVgt6/jY8U45aqFB7X2sZ5jCvJm/1xVNIJg2Vr5KuEloVFF2+Tq1auDo9J0uJY
	J3l3zpHniXJPDIJXrf4ocmD1pq1fHjWePjvRfp/nmQD1UxM5Qv5zXTlemS9nsleJpTgj0VCL
	uag4EQCiZuT9cgIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJLMWRmVeSWpSXmKPExsXCNUNNS3eKzMN0g7szLC3mrF/DZjF96gVG
	i6/rfzFb/Lx7nN3i87PXzBarFl5jszi+dR67xeG5J1ktzs86xWJxedccNot7a/6zWhy69pzV
	YvWaDIvf21awOfB57Jx1l92ju+0yu0fLkbesHov3vGTy2PRpErvHiRm/WTx2PrT0eL/vKpvH
	t9seHotffGDy+LxJLoA7issmJTUnsyy1SN8ugStj+vX3TAWXpSoOnV/E2MD4RqSLkZNDQsBE
	4sCmuaxdjBwcbAJKEsf2xoCYIgKqEm1X3LsYuTiYBR4xSZxuX8oKUi4sEC7RffAhC0gNC1DN
	jXe5IGFeAWOJ349XMkJM1JRouHSPCcTmFDCTePt2LTuILSTAI/Fqw35GiHpBiZMzn7CA2MwC
	8hLNW2czT2DkmYUkNQtJagEj0ypGkcy8stzEzBxTveLsjMq8zAq95PzcTYzAAF9W+2fiDsYv
	l90PMQpwMCrx8G54eT9diDWxrLgy9xCjBAezkgjvMdaH6UK8KYmVValF+fFFpTmpxYcYpTlY
	lMR5vcJTE4QE0hNLUrNTUwtSi2CyTBycUg2MPVNSbBRftsWeP/v9arb1v4i082b3fqoW84TO
	m6xbfOHF/xUnvdeJd2m8SP6zPaHCZ32GlbKRjxrznkcdp3Y0eascmJLh1JO6otv08HSJLZ3C
	3e6pF4o37Mt6bhsUPT9NpSomac+bBLnm2qvXRZcYZze9S8kSri/qvH6i+IizwblTZuxdJcxK
	LMUZiYZazEXFiQA6gMb5bAIAAA==
X-CFilter-Loop: Reflected

On Fri, 21 Mar 2025 10:24:46 -0400 Gregory Price <gourry@gourry.net> wrote:
> On Thu, Mar 20, 2025 at 01:17:48PM +0900, Rakie Kim wrote:
> ... snip ...
> > +	mutex_lock(&sgrp->kobj_lock);
> > +	if (sgrp->nattrs[nid]) {
> > +		mutex_unlock(&sgrp->kobj_lock);
> > +		pr_info("Node [%d] already exists\n", nid);
> > +		kfree(new_attr);
> > +		kfree(name);
> > +		return 0;
> > +	}
> >  
> > -	if (sysfs_create_file(&sgrp->wi_kobj, &node_attr->kobj_attr.attr)) {
> > -		kfree(node_attr->kobj_attr.attr.name);
> > -		kfree(node_attr);
> > -		pr_err("failed to add attribute to weighted_interleave\n");
> > -		return -ENOMEM;
> > +	sgrp->nattrs[nid] = new_attr;
> > +	mutex_unlock(&sgrp->kobj_lock);
> > +
> > +	sysfs_attr_init(&sgrp->nattrs[nid]->kobj_attr.attr);
> > +	sgrp->nattrs[nid]->kobj_attr.attr.name = name;
> > +	sgrp->nattrs[nid]->kobj_attr.attr.mode = 0644;
> > +	sgrp->nattrs[nid]->kobj_attr.show = node_show;
> > +	sgrp->nattrs[nid]->kobj_attr.store = node_store;
> > +	sgrp->nattrs[nid]->nid = nid;
> 
> These accesses need to be inside the lock as well.  Probably we can't
> get here concurrently, but I can't so so definitively that I'm
> comfortable blind-accessing it outside the lock.

You're right, and I appreciate your point. It's not difficult to apply your
suggestion, so I plan to update the code as follows:

    sgrp->nattrs[nid] = new_attr;

    sysfs_attr_init(&sgrp->nattrs[nid]->kobj_attr.attr);
    sgrp->nattrs[nid]->kobj_attr.attr.name = name;
    sgrp->nattrs[nid]->kobj_attr.attr.mode = 0644;
    sgrp->nattrs[nid]->kobj_attr.show = node_show;
    sgrp->nattrs[nid]->kobj_attr.store = node_store;
    sgrp->nattrs[nid]->nid = nid;

    ret = sysfs_create_file(&sgrp->wi_kobj,
           &sgrp->nattrs[nid]->kobj_attr.attr);
    if (ret) {
        mutex_unlock(&sgrp->kobj_lock);
        ...
    }
    mutex_unlock(&sgrp->kobj_lock);

> 
> > +static int wi_node_notifier(struct notifier_block *nb,
> > +			       unsigned long action, void *data)
> > +{
> ... snip ...
> > +	case MEM_OFFLINE:
> > +		sysfs_wi_node_release(nid);
> 
> I'm still not convinced this is correct.  `offline_pages()` says this:
> 
> /*
>  * {on,off}lining is constrained to full memory sections (or more
>  * precisely to memory blocks from the user space POV).
>  */
> 
> And that is the function calling:
> 	memory_notify(MEM_OFFLINE, &arg);
> 
> David pointed out that this should be called when offlining each memory
> block.  This is not the same as simply doing `echo 0 > online`, you need
> to remove the dax device associated with the memory.
> 
> For example:
> 
>       node1
>     /       \
>  dax0.0    dax1.0
>    |          |
>   mb1        mb2
> 
> 
> With this code, if I `daxctl reconfigure-device devmem dax0.0` it will
> remove the first memory block, causing MEM_OFFLINE event to fire and
> removing the node - despite the fact that dax1.0 is still present.
> 
> This matters for systems with memory holes in CXL hotplug memory and
> also for systems with Dynamic Capacity Devices surfacing capacity as
> separate dax devices.
> 
> ~Gregory

If all memory blocks belonging to a node are offlined, the node will lose its
`N_MEMORY` state before the notifier callback is invoked. This should help avoid
the issue you mentioned.
Please let me know your thoughts on this approach.

Rakie

