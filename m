Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B321DFF0;
	Mon, 24 Mar 2025 08:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742806486; cv=none; b=ufOD9yYwxWdRlmhLli8jf2PoOipEwSuTx9Y6jSoPXwiRFUSYNB4vE1akxh7YuEkNCt1CnCJT+4AmpNqa2v5O5pKvjJYyASCIgsCfVBruaaciGvv3fW4DH2Og6CkqKsjtf6YxLxcjTyZ3bAMmgYZB/+JAMdTMuuxq1wcKqsboJAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742806486; c=relaxed/simple;
	bh=lPZJAVjk+k6NzxVm1RrEPaKg6s3Q5Bek4ZO02BSnrQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AVtShVaWegk3eYqGTv8XRmxrgJLQugPfkbsmFWai1cFVq1CE0ADc6VMycpxL+5jkM1mHJ8I+43P6he0SasScrm2Lpc68DUCP8y4xgZY2lVDXqm6Lt4iu04osDvTQGlN4XJPOJOCAKWuNiiBu1zadKaxRQv4l5k0nd87auDkrzmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-34-67e11dce7ec2
From: Rakie Kim <rakie.kim@sk.com>
To: Rakie Kim <rakie.kim@sk.com>
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
	Gregory Price <gourry@gourry.net>
Subject: Re: [PATCH v3 3/3] mm/mempolicy: Support memory hotplug in weighted interleave
Date: Mon, 24 Mar 2025 17:54:27 +0900
Message-ID: <20250324085433.998-1-rakie.kim@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <20250324084920.987-1-rakie.kim@sk.com>
References: 
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPLMWRmVeSWpSXmKPExsXC9ZZnoe452YfpBpOf8VjMWb+GzWL61AuM
	Fl/X/2K2+Hn3OLvFqoXX2CyOb53HbnF+1ikWi8u75rBZ3Fvzn9Vi9ZoMBy6PnbPusnt0t11m
	92g58pbVY/Gel0wemz5NYvc4MeM3i8fOh5Ye7/ddZfP4vEkugDOKyyYlNSezLLVI3y6BK6Nl
	7QWWgm7FiqnnPrI1MG6X7GLk5JAQMJH4/fsRWxcjB5j9Y2ImiMkmoCRxbG8MiCkioCBx6F90
	FyMXB7PAcyaJt8d+sYN0CguES3QffMgCYrMIqErc+XuFGcTmFTCWOH7/ERPEdE2Jhkv3wGxO
	oOmfbjwF6xUS4JF4tWE/I0S9oMTJmU/A5jALyEs0b53NDLJMQuA5m8S9cy2sEIMkJQ6uuMEy
	gZF/FpKeWUh6FjAyrWIUyswry03MzDHRy6jMy6zQS87P3cQIDPZltX+idzB+uhB8iFGAg1GJ
	h3fDy/vpQqyJZcWVuYcYJTiYlUR4j7E+TBfiTUmsrEotyo8vKs1JLT7EKM3BoiTOa/StPEVI
	ID2xJDU7NbUgtQgmy8TBKdXA2KPG5al0/ccbH9tXS4L2aR0+k5CUdbaGvXLGp1qPBstd8scl
	phi+K6lqP+KTcdXlS5W9hcgGpjkxJ7j7l/hanD/QuVZVu1z3QX5Rpk1J6KTwzRaeineXJa3l
	ULRp2+/48U/ig6BNnBP6myw4f9dXXN1rvaSYo0Vgp3hb6/3pst2RjTO6Bb2VWIozEg21mIuK
	EwH49+MkcgIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJLMWRmVeSWpSXmKPExsXCNUNNS/ec7MN0g5ZfzBZz1q9hs5g+9QKj
	xdf1QO7Pu8fZLT4/e81ssWrhNTaL41vnsVscnnuS1eL8rFMsFpd3zWGzuLfmP6vFoWvPWS1W
	r8mw+L1tBZsDn8fOWXfZPbrbLrN7tBx5y+qxeM9LJo9Nnyaxe5yY8ZvFY+dDS4/3+66yeXy7
	7eGx+MUHJo/Pm+QCuKO4bFJSczLLUov07RK4MlrWXmAp6FasmHruI1sD43bJLkYODgkBE4kf
	EzNBTDYBJYlje2NATBEBBYlD/6K7GLk4mAWeM0m8PfaLvYuRk0NYIFyi++BDFhCbRUBV4s7f
	K8wgNq+AscTx+4+YQGwJAU2Jhkv3wGxOoOmfbjwF6xUS4JF4tWE/I0S9oMTJmU/A5jALyEs0
	b53NPIGRZxaS1CwkqQWMTKsYRTLzynITM3NM9YqzMyrzMiv0kvNzNzECA3xZ7Z+JOxi/XHY/
	xCjAwajEw7vh5f10IdbEsuLK3EOMEhzMSiK8x1gfpgvxpiRWVqUW5ccXleakFh9ilOZgURLn
	9QpPTRASSE8sSc1OTS1ILYLJMnFwSjUwtpn3nHd9ee9NlfX5bnNFk72zzsefmv76w+lVsy/c
	cZTINgtT4dVIl/Ji+DI1NXBubEhIBcOKlfosqZWGblvuzax7zHJHSCy3NJl7VX/afBO3ZfVb
	I9Ov2FhPkjiRkcL72zd62tKqu5GWB9+o5P9IF30au1JPd9mcCHPv2fuZd4n4bkp6xCyqxFKc
	kWioxVxUnAgAayADR2wCAAA=
X-CFilter-Loop: Reflected

On Mon, 24 Mar 2025 17:48:39 +0900 Rakie Kim <rakie.kim@sk.com> wrote:
> On Fri, 21 Mar 2025 10:24:46 -0400 Gregory Price <gourry@gourry.net> wrote:
> > On Thu, Mar 20, 2025 at 01:17:48PM +0900, Rakie Kim wrote:
> > ... snip ...
> > > +	mutex_lock(&sgrp->kobj_lock);
> > > +	if (sgrp->nattrs[nid]) {
> > > +		mutex_unlock(&sgrp->kobj_lock);
> > > +		pr_info("Node [%d] already exists\n", nid);
> > > +		kfree(new_attr);
> > > +		kfree(name);
> > > +		return 0;
> > > +	}
> > >  
> > > -	if (sysfs_create_file(&sgrp->wi_kobj, &node_attr->kobj_attr.attr)) {
> > > -		kfree(node_attr->kobj_attr.attr.name);
> > > -		kfree(node_attr);
> > > -		pr_err("failed to add attribute to weighted_interleave\n");
> > > -		return -ENOMEM;
> > > +	sgrp->nattrs[nid] = new_attr;
> > > +	mutex_unlock(&sgrp->kobj_lock);
> > > +
> > > +	sysfs_attr_init(&sgrp->nattrs[nid]->kobj_attr.attr);
> > > +	sgrp->nattrs[nid]->kobj_attr.attr.name = name;
> > > +	sgrp->nattrs[nid]->kobj_attr.attr.mode = 0644;
> > > +	sgrp->nattrs[nid]->kobj_attr.show = node_show;
> > > +	sgrp->nattrs[nid]->kobj_attr.store = node_store;
> > > +	sgrp->nattrs[nid]->nid = nid;
> > 
> > These accesses need to be inside the lock as well.  Probably we can't
> > get here concurrently, but I can't so so definitively that I'm
> > comfortable blind-accessing it outside the lock.
> 
> You're right, and I appreciate your point. It's not difficult to apply your
> suggestion, so I plan to update the code as follows:
> 
>     sgrp->nattrs[nid] = new_attr;
> 
>     sysfs_attr_init(&sgrp->nattrs[nid]->kobj_attr.attr);
>     sgrp->nattrs[nid]->kobj_attr.attr.name = name;
>     sgrp->nattrs[nid]->kobj_attr.attr.mode = 0644;
>     sgrp->nattrs[nid]->kobj_attr.show = node_show;
>     sgrp->nattrs[nid]->kobj_attr.store = node_store;
>     sgrp->nattrs[nid]->nid = nid;
> 
>     ret = sysfs_create_file(&sgrp->wi_kobj,
>            &sgrp->nattrs[nid]->kobj_attr.attr);
>     if (ret) {
>         mutex_unlock(&sgrp->kobj_lock);
>         ...
>     }
>     mutex_unlock(&sgrp->kobj_lock);
> 
> > 
> > > +static int wi_node_notifier(struct notifier_block *nb,
> > > +			       unsigned long action, void *data)
> > > +{
> > ... snip ...
> > > +	case MEM_OFFLINE:
> > > +		sysfs_wi_node_release(nid);
> > 
> > I'm still not convinced this is correct.  `offline_pages()` says this:
> > 
> > /*
> >  * {on,off}lining is constrained to full memory sections (or more
> >  * precisely to memory blocks from the user space POV).
> >  */
> > 
> > And that is the function calling:
> > 	memory_notify(MEM_OFFLINE, &arg);
> > 
> > David pointed out that this should be called when offlining each memory
> > block.  This is not the same as simply doing `echo 0 > online`, you need
> > to remove the dax device associated with the memory.
> > 
> > For example:
> > 
> >       node1
> >     /       \
> >  dax0.0    dax1.0
> >    |          |
> >   mb1        mb2
> > 
> > 
> > With this code, if I `daxctl reconfigure-device devmem dax0.0` it will
> > remove the first memory block, causing MEM_OFFLINE event to fire and
> > removing the node - despite the fact that dax1.0 is still present.
> > 
> > This matters for systems with memory holes in CXL hotplug memory and
> > also for systems with Dynamic Capacity Devices surfacing capacity as
> > separate dax devices.
> > 
> > ~Gregory
> 
> If all memory blocks belonging to a node are offlined, the node will lose its
> `N_MEMORY` state before the notifier callback is invoked. This should help avoid
> the issue you mentioned.
> Please let me know your thoughts on this approach.
> 
> Rakie
> 

I'm sorry, the code is missing.
I may not fully understand the scenario you described, but I think your concern
can be addressed by adding a simple check like the following:

    case MEM_OFFLINE:
        if (!node_state(nid, N_MEMORY)) --> this point
            sysfs_wi_node_release(nid);

If all memory blocks belonging to a node are offlined, the node will lose its
`N_MEMORY` state before the notifier callback is invoked. This should help avoid
the issue you mentioned.
Please let me know your thoughts on this approach.

Rakie.

