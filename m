Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5748578F37;
	Thu, 13 Mar 2025 06:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741847723; cv=none; b=WblcYnsI+Hsh3eToZYZqYraLH9BXE/fz0fHyaUaedvswIe40nWugOpP1hS9ahTEeVCoU+XuwgUokc/CU76PJDSZ329UPva3sRcpvSqa2crDC49PTkbY8wwsI26mR0FeojSxyhEIzK+WGCJ0yDOr2PM0mQ4dvkndp9LVGL64ssnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741847723; c=relaxed/simple;
	bh=YrfbdKbPK3eqyWobrssdzYKVz6bEdAz4t2AJx96VxYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H4rtG+rkg3nUfl27TecJEeVK4gsx76Y6TqRFKBQ15XxJlD0lSiUqRPxJ92OZI8lVK/qtBEodVhKLhAz0gTwlwzQzTBLuAeBFcpMwgXep0w7yODWl42pYaVPc/TOzVciUw5UMdOi6uVYInc9gt3owtE37inejQpW+U8ej/4ofpSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-23-67d27ca66d1f
From: Rakie Kim <rakie.kim@sk.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: gourry@gourry.net,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	dan.j.williams@intel.com,
	ying.huang@linux.alibaba.com,
	kernel_team@skhynix.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com,
	Rakie Kim <rakie.kim@sk.com>
Subject: Re: [PATCH v2 4/4] mm/mempolicy: Fix duplicate node addition in sysfs for weighted interleave
Date: Thu, 13 Mar 2025 15:34:37 +0900
Message-ID: <20250313063511.714-1-rakie.kim@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <20250312150440.2301373-1-joshua.hahnjy@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLLMWRmVeSWpSXmKPExsXC9ZZnoe7ymkvpBlNPM1nMWb+GzWL61AuM
	Fj/vHme3OL51HrvF+VmnWCwu75rDZnFvzX9Wi9VrMhw4PHbOusvu0d12md1j8Z6XTB6bPk1i
	9zgx4zeLx86Hlh6fN8kFsEdx2aSk5mSWpRbp2yVwZRz88Yit4L5cxaL5t5gbGN+KdzFyckgI
	mEhcvzaNHcb+vWMXUxcjBwebgJLEsb0xIGERAU2JE62TmLsYuTiYBVYySbQtOM0MkhAWSJM4
	fuw4K4jNIqAq8fdgNwuIzStgLLH+ZRPUTE2Jhkv3mEBsTgF7iU29/YwgtpAAj8SrDfsZIeoF
	JU7OfALWyywgL9G8dTbYMgmBy2wSUy4+Y4QYJClxcMUNlgmM/LOQ9MxC0rOAkWkVo1BmXllu
	YmaOiV5GZV5mhV5yfu4mRmAgL6v9E72D8dOF4EOMAhyMSjy8CZMvpguxJpYVV+YeYpTgYFYS
	4V1teyFdiDclsbIqtSg/vqg0J7X4EKM0B4uSOK/Rt/IUIYH0xJLU7NTUgtQimCwTB6dUA6PQ
	lQ9isxg8pvfzLpjO3HpI/i9XSW5ft2qO0amnOtUr9gYLTLvtcEGXn0XFqtrd1tDovBbTnoLw
	Nz3vcyXb+DNFgprO+TbGqMRLTzJSZWtVj5/YtlG69KTM1kbm226vHu2rdri8WVjr14NZ3ote
	+P04+kbr2MuJLOmfe3vXpc///HTvh1u7LJRYijMSDbWYi4oTAcfrV7FgAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOLMWRmVeSWpSXmKPExsXCNUNNS3dZzaV0g5uHLSzmrF/DZjF96gVG
	i593j7NbfH72mtni+NZ57BaH555ktTg/6xSLxeVdc9gs7q35z2px6NpzVovVazIsfm9bwebA
	47Fz1l12j+62y+wei/e8ZPLY9GkSu8eJGb9ZPHY+tPT4dtvDY/GLD0wenzfJBXBGcdmkpOZk
	lqUW6dslcGUc/PGIreC+XMWi+beYGxjfincxcnJICJhI/N6xi6mLkYODTUBJ4tjeGJCwiICm
	xInWScxdjFwczAIrmSTaFpxmBkkIC6RJHD92nBXEZhFQlfh7sJsFxOYVMJZY/7KJHWKmpkTD
	pXtMIDangL3Ept5+RhBbSIBH4tWG/YwQ9YISJ2c+AetlFpCXaN46m3kCI88sJKlZSFILGJlW
	MYpk5pXlJmbmmOoVZ2dU5mVW6CXn525iBAbvsto/E3cwfrnsfohRgINRiYc3YfLFdCHWxLLi
	ytxDjBIczEoivKttL6QL8aYkVlalFuXHF5XmpBYfYpTmYFES5/UKT00QEkhPLEnNTk0tSC2C
	yTJxcEo1MC4oDJcPXe0zoYGls+ipn2B+lErJt21R26ssnuvaLMzJuGl0z7X4VEagsuafazN3
	L9Z5XKvW3hEmvD3kSLOeSafbrS9zwh+wP3y5vc2B0Vp7gsD9g9v3991YZBv84vBOZsf9C9ff
	nthW9K7SiSNy8yuTKQ+dtM9Mnbjg4brrzzmY9tXslD7wW0uJpTgj0VCLuag4EQAHcwJdWgIA
	AA==
X-CFilter-Loop: Reflected

On Wed, 12 Mar 2025 08:04:39 -0700 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:

Hi Joshua
Thank you for your response regarding this patch.

> Hi Rakie, thank your new revision!
> 
> I think this new ordering of the series makes more sense, since the bug exists
> even before your patch is applied! IMHO, it might also make sense to take
> patch 1 out of this series, and send it separately (and make patches 2-4
> their own series). 
> 
> I have a nit and a few thoughts about this patch and the way we order locking
> and allocating:
> 
> >  static void sysfs_wi_release(struct kobject *wi_kobj)
> > @@ -3464,35 +3470,54 @@ static const struct kobj_type wi_ktype = {
> >  
> >  static int sysfs_wi_node_add(int nid)
> >  {
> > -	struct iw_node_attr *node_attr;
> > +	int ret = 0;
> >  	char *name;
> >  
> > -	node_attr = kzalloc(sizeof(*node_attr), GFP_KERNEL);
> > -	if (!node_attr)
> > -		return -ENOMEM;
> > +	if (nid < 0 || nid >= nr_node_ids) {
> > +		pr_err("Invalid node id: %d\n", nid);
> > +		ret = -EINVAL;
> > +		goto out;
> > +	}
> > +
> > +	mutex_lock(&ngrp->kobj_lock);
> > +	if (!ngrp->nattrs[nid]) {
> > +		ngrp->nattrs[nid] = kzalloc(sizeof(struct iw_node_attr), GFP_KERNEL);
> 
> I am unsure if kzallocing with the mutex_lock held is best practice. Even though
> two threads won't reach this place simultaneously since *most* calls to this
> function are sequential, we should try to keep the code safe since future
> patches might overlook this, and later make non-sequential calls : -)
> 
> It also doesn't seem wise to directly assign the result of an allocation
> without checking for its success (as I explain below).
> 
> IMHO it is best to allocate first, then acquire the lock and check for
> existence, then assign with the lock still held. We can also reduce this code
> section into a single if statement for clarity (but if you think it looks
> cleaner with the if-else, please keep it!)
> 
> struct iw_node_attr *node_attr;
> 
> ...
> 
> node_attr = kzalloc(sizeof(*node_attr), GFP_KERNEL);
> if (!node_attr) {
> 	ret = -ENOMEM;
> 	goto out;
> }
> 
> mutex_lock(&ngrp->kobj_lock);
> if (ngrp->nattrs[nid]) {
> 	mutex_unlock(&ngrp->kobj_lock);
> 	kfree(node_attr);
> 	pr_info("Node [%d] already exists\n");
> 	goto out;
> }
> ngrp->attrs[nid] = node_attr;
> mutex_unlock(&ngrp->kobj_lock):
> 

Your suggestion makes sense, and I will update this part accordingly
to reflect your feedback.

> 
> > +	} else {
> > +		mutex_unlock(&ngrp->kobj_lock);
> > +		pr_info("Node [%d] is already existed\n", nid);
> 
> NIT: To keep consistency with other parts of the kernel, maybe this can be
> rephrased to "Node [%d] already exists\n"

I also agree that modifying the wording would improve clarity.
I will make the necessary adjustments in the next version.

> 
> > +		goto out;
> > +	}
> > +	mutex_unlock(&ngrp->kobj_lock);
> > +
> > +	if (!ngrp->nattrs[nid]) {
> > +		ret = -ENOMEM;
> > +		goto out;
> > +	}
> 
> If we make the changes above, we don't have to check for allocation success
> *after* already having locked & unlocked and making the unnecessary assignment.
> 
> >  
> >  	name = kasprintf(GFP_KERNEL, "node%d", nid);
> >  	if (!name) {
> > -		kfree(node_attr);
> > -		return -ENOMEM;
> > +		kfree(ngrp->nattrs[nid]);
> > +		ret = -ENOMEM;
> > +		goto out;
> >  	}
> 
> For the same reasons above, I think it makes sense to make this allocation
> together with the allocation of node_attr above, and free / return -ENOMEM
> as early as possible if we can.
> 
> [...snip...]
> 
> Thank you again for this patch! Please let me know what you think : -)
> Have a great day!
> Joshua

Thank you for your detailed and thoughtful review. I will incorporate
your suggestions and update the next version accordingly.

> 
> Sent using hkml (https://github.com/sjp38/hackermail)
> 
