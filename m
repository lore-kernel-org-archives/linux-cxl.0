Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071B02253B2;
	Mon,  7 Apr 2025 09:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744018712; cv=none; b=OEY5L3lnFjptfJcQaL02+YiK4n6qXyAJkw/MiFB3NgTh5U+88gMj4hAzRCS067c0vfB8fPnjKUVIAOxWnbQqT15FpvCV817z6xgirP29mjRnYq8J1zoTsBqwaMqPB0wBeYZT+0U0Chiv1uVOKcOR6PLG9uAXmuecp1wQZPwsiNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744018712; c=relaxed/simple;
	bh=beMQvMmQIfdc0h+suVBsbCQOvkITlVvv2hPxTR98rcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L68UgMuWY1uY23bxMas/KfpDtLkHnKkcWviWBqShF+6At2W3DRsyZkN1d4fnc365233TJ4g2DIbamOzMO33HuYMBBq0bU2EegVjVzwwvjntTybYfTX4uQf/CWGQkcjt7vGMg2qJkOxf7tPoo/P5H5zPzQ66Xn+g4Yukah40Bg+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-82-67f39d12e7b3
From: Rakie Kim <rakie.kim@sk.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: akpm@linux-foundation.org,
	gourry@gourry.net,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	joshua.hahnjy@gmail.com,
	ying.huang@linux.alibaba.com,
	david@redhat.com,
	osalvador@suse.de,
	kernel_team@skhynix.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Rakie Kim <rakie.kim@sk.com>
Subject: Re: [PATCH v6 2/3] mm/mempolicy: Prepare weighted interleave sysfs for memory hotplug
Date: Mon,  7 Apr 2025 18:38:17 +0900
Message-ID: <20250407093822.428-1-rakie.kim@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <67f0157e498c9_464ec294df@dwillia2-xfh.jf.intel.com.notmuch>
References: 
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJLMWRmVeSWpSXmKPExsXC9ZZnoa7Q3M/pBkdmWFjMWb+GzWL61AuM
	Fl/X/2K2+Hn3OLvFqoXX2CyOb53HbnF+1ikWi8u75rBZ3Fvzn9XizLQii9VrMhy4PXbOusvu
	0d12md2j5chbVo/Fe14yeWz6NInd48SM3yweOx9aerzfd5XNY/Ppao/Pm+QCuKK4bFJSczLL
	Uov07RK4Ms5/7mMrmCda8fP1EfYGxn8CXYycHBICJhLfmvcww9j3ju1m7WLk4GATUJI4tjcG
	JCwioC0xcc5BoBIuDmaBZmaJY78uM4IkhAXiJO6dXghmswioStzbepYdxOYVMJZ4suA4I8RM
	TYmGS/eYQGxOAU+J3ubdYLaQAI/Eqw37GSHqBSVOznzCAmIzC8hLNG+dDbZMQuA7m8SZl6eY
	IAZJShxccYNlAiP/LCQ9s5D0LGBkWsUolJlXlpuYmWOil1GZl1mhl5yfu4kRGAHLav9E72D8
	dCH4EKMAB6MSD+8Ot8/pQqyJZcWVuYcYJTiYlUR4LU99ShfiTUmsrEotyo8vKs1JLT7EKM3B
	oiTOa/StPEVIID2xJDU7NbUgtQgmy8TBKdXAuMbZy6M8IG9XjJ3ETkuNiTPubZirK3s4Kzia
	deqqSz7Xaq2slhy1c5+6R+z8jBuHze5z6Lc9fn5N5l7spruZDBPudH1iNKy/JsmWPHeHyev2
	hCsnPmzgeyLdYz8tiHN2iNm8BrOLQeJfbonHtz+eXBaRt2K6ROk8l8az5Qm3HTXbxLLd35i6
	KbEUZyQaajEXFScCAEX99VB8AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMLMWRmVeSWpSXmKPExsXCNUNNS1do7ud0g3PXdC3mrF/DZjF96gVG
	i6/rfzFb/Lx7nN3i87PXzBarFl5jszi+dR67xeG5J1ktzs86xWJxedccNot7a/6zWpyZVmRx
	6NpzVovVazIsfm9bwebA77Fz1l12j+62y+weLUfesnos3vOSyWPTp0nsHidm/Gbx2PnQ0uP9
	vqtsHt9ue3gsfvGByWPz6WqPz5vkAniiuGxSUnMyy1KL9O0SuDLOf+5jK5gnWvHz9RH2BsZ/
	Al2MnBwSAiYS947tZu1i5OBgE1CSOLY3BiQsIqAtMXHOQeYuRi4OZoFmZoljvy4zgiSEBeIk
	7p1eCGazCKhK3Nt6lh3E5hUwlniy4DgjxExNiYZL95hAbE4BT4ne5t1gtpAAj8SrDfsZIeoF
	JU7OfMICYjMLyEs0b53NPIGRZxaS1CwkqQWMTKsYRTLzynITM3NM9YqzMyrzMiv0kvNzNzEC
	g35Z7Z+JOxi/XHY/xCjAwajEw3uj8VO6EGtiWXFl7iFGCQ5mJRFey1NAId6UxMqq1KL8+KLS
	nNTiQ4zSHCxK4rxe4akJQgLpiSWp2ampBalFMFkmDk6pBsb9t/5lLrVYvrjq8en2V38lnvuX
	f+wwYUgIq3igq8A2Ldnade9TUWubAIVv9ulLHm/JPXLmibSczcFosd+vLr6bLGLsopok+1V4
	S/EVrh0nbvhnnn76Mo3tZ5eeruyexnm7lUMnTRG6oZJ9tNvcKffFxD/W62ddvFfGe7yjQW7u
	non1yi+KgzWVWIozEg21mIuKEwHCdIh9dgIAAA==
X-CFilter-Loop: Reflected

On Fri, 4 Apr 2025 10:23:10 -0700 Dan Williams <dan.j.williams@intel.com> wrote:
> Jonathan Cameron wrote:
> > On Fri, 4 Apr 2025 16:46:20 +0900
> > Rakie Kim <rakie.kim@sk.com> wrote:
> > 
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
> > Hi Rakie,
> > 
> > Some things I was requesting in patch 1 are done here.
> > Mostly I think what is wanted is moving some of that
> > refactoring back to that patch rather than here.
> > 
> > Some of the label and function naming needs another look.
> > 
> > Jonathan
> [..]
> > > @@ -3430,27 +3437,24 @@ static ssize_t node_store(struct kobject *kobj, struct kobj_attribute *attr,
> > >  	return count;
> > >  }
> > >  
> > > -static struct iw_node_attr **node_attrs;
> > > -
> > > -static void sysfs_wi_node_release(struct iw_node_attr *node_attr,
> > > -				  struct kobject *parent)
> > > +static void sysfs_wi_node_delete(int nid)
> > 
> > Maybe stick to release naming to match the sysfs_wi_release()
> > below? I don't really care about this.
> 
> I had asked for "delete" to pair with "add" and to not get confused with
> a final kobject_put() callback.

As Dan mentioned earlier, I also believe that "sysfs_wi_node_delete"
is a more appropriate name than "sysfs_wi_node_release" because it
pairs naturally with "sysfs_wi_node_add" and avoids confusion with
a final kobject_put() callback.

Rakie

