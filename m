Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00678EAF9
	for <linux-cxl@vger.kernel.org>; Thu, 30 May 2024 12:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717071293; cv=none; b=GDetG/dePknFqXILgHs+vwRzAHuCHW25RxF9dvROIAJIS0AisfPYbtwGI1f/2CURxU2QMPTTWSDSDDE8VF4NMT6d4F794U7h+BYxTsx0EdsDovtoRCWcFa67hzneFs0D6UyqdO5glESOCtDbVV/DQ/xdUU5JvgcfJ+qstZmWQL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717071293; c=relaxed/simple;
	bh=0BDEx9EqrIPkxdWhNuvKkt3r2RMape/x8QUEy1B1J9I=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MySxWWNHOlpUvZGUfjtayM5kOWEKYE0aaIUGs/n9dnO0SnDnSRGc/nsU/tJHrwfrvMl5UhOCyddxebbW8mAJ45P6V4RY+qjk05S427ums6wRvo+al9v0ilfggMtYNoBlfvhgVAkgkiMsgeuujRiQ5pZRhtwmT9xEwiNPFfkZQtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VqlSd2YNWz6K63S;
	Thu, 30 May 2024 20:10:25 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 93A961400D7;
	Thu, 30 May 2024 20:14:42 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 30 May
 2024 13:14:42 +0100
Date: Thu, 30 May 2024 13:14:41 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Oscar Salvador <osalvador@suse.com>
CC: Dan Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Sudeep Holla <sudeep.holla@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand
	<david@redhat.com>, Will Deacon <will@kernel.org>, Jia He
	<justin.he@arm.com>, Mike Rapoport <rppt@linux.ibm.com>,
	<linuxarm@huawei.com>, <catalin.marinas@arm.com>,
	<Anshuman.Khandual@arm.com>, Yuquan Wang <wangyuquan1236@phytium.com.cn>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>, James Morse <james.morse@arm.com>
Subject: Re: [RFC PATCH 8/8] HACK: mm: memory_hotplug: Drop
 memblock_phys_free() call in try_remove_memory()
Message-ID: <20240530131441.000020bd@Huawei.com>
In-Reply-To: <ZlhP6aMUOjx_EziA@localhost.localdomain>
References: <20240529171236.32002-1-Jonathan.Cameron@huawei.com>
	<20240529171236.32002-9-Jonathan.Cameron@huawei.com>
	<ZlhP6aMUOjx_EziA@localhost.localdomain>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 30 May 2024 12:07:37 +0200
Oscar Salvador <osalvador@suse.com> wrote:

> On Wed, May 29, 2024 at 06:12:36PM +0100, Jonathan Cameron wrote:
> > I'm not sure what this is balancing, but it if is necessary then the reserved
> > memblock approach can't be used to stash NUMA node assignments as after the
> > first add / remove cycle the entry is dropped so not available if memory is
> > re-added at the same HPA.  
> 
> It is balancing previously allocated memory which was allocated via
> memblock_phys_alloc{_range,try_nid}.
> memblock_phys_alloc_try_nid() is who does the heavy-lifting, and also calls
> kmemleak_alloc_phys() to make kmemleak aware of that memory.

Thanks Oscar,

I'm struggling to find the call path that does that for the particular range being
released.

There are some calls to allocate node data but for small amounts of data
whereas I think this call is removing the full range of the hot removed memory.
Is the intent just to get rid of the node data related reserved memblock if
it happens to be in the memory removed?  If so feels like the call should
really be targetting just that.

> 
> A quick idea that came to me is:
> I think that it should be possible 1) create a new memory_block flag
> (check 'enum memblock_flags') and 2) flag the range you want with this
> range (check memblock_setclr_flag()) with a function like
> memblock_reserved_mark_{yourflag}.
> 
> Then, in memblock_phys_free() (or down the path) we could check for that flag,
> and refuse to proceed if it is set.

I had tried a flag in the main memblock rather than using the reserved memblock
a while back and that was horribly invasive so I got a bit scared of touching
those flags. One used only in the reserved memblock might work
to bypass the removal of the reserved memblocks but carry out everything
else that call is intended to do. I'm still sketchy on what I'm bypassing
though!

Thanks,

Jonathan

> 
> Would that work?
> I am not sure, but you might need to 
> 
> 

