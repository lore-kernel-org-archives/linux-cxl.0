Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41DA78C69
	for <linux-cxl@vger.kernel.org>; Fri, 31 May 2024 09:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717148940; cv=none; b=Pnjf6rZA8t4WxpF8kFqjIhDaG2rNAIVK2ngQiv1TVUWK+12K0PLgfU6sTxmSsz7hIN2IR1yiawK7Py7TSOUQ/YV7MzzZVwVQY25+y+MKL5hD+rZjatBuH3UqIGJ1VGGU+RYXqQV5tpsqxoE9NY4pZrT9ILpi1hbdUMqeW0k2+eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717148940; c=relaxed/simple;
	bh=uUqurq/KFB438/ANAOHu9jJ9OS4bUmZ2Ea/danf5/Kc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LEz2kogkLEVkL0/LLgReczijByFrSsOhICvrs9gwIP8i3UhhtvWyomhLVyinUFIXuUEh+JKJdv881J4xnDsEpsQeAxJvu3/IoPQR6/bOk/nZaFKcBoq4d7mjDCltfeQYq6+kAxYZvzatETzvYFoB7/LDNdlBf2HXCadsaLycpiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VrJ9p11zGz6K5bC;
	Fri, 31 May 2024 17:44:30 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id C8E62140B33;
	Fri, 31 May 2024 17:48:49 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 31 May
 2024 10:48:49 +0100
Date: Fri, 31 May 2024 10:48:48 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: David Hildenbrand <david@redhat.com>
CC: Dan Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Sudeep Holla <sudeep.holla@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>, Will Deacon <will@kernel.org>, Jia
 He <justin.he@arm.com>, Mike Rapoport <rppt@linux.ibm.com>,
	<linuxarm@huawei.com>, <catalin.marinas@arm.com>,
	<Anshuman.Khandual@arm.com>, Yuquan Wang <wangyuquan1236@phytium.com.cn>,
	Oscar Salvador <osalvador@suse.de>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, James Morse <james.morse@arm.com>
Subject: Re: [RFC PATCH 8/8] HACK: mm: memory_hotplug: Drop
 memblock_phys_free() call in try_remove_memory()
Message-ID: <20240531104848.00006a95@Huawei.com>
In-Reply-To: <b8654dcd-68e1-4823-9588-cfa401104741@redhat.com>
References: <20240529171236.32002-1-Jonathan.Cameron@huawei.com>
	<20240529171236.32002-9-Jonathan.Cameron@huawei.com>
	<b8654dcd-68e1-4823-9588-cfa401104741@redhat.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 31 May 2024 09:49:32 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 29.05.24 19:12, Jonathan Cameron wrote:
> > I'm not sure what this is balancing, but it if is necessary then the re=
served
> > memblock approach can't be used to stash NUMA node assignments as after=
 the
> > first add / remove cycle the entry is dropped so not available if memor=
y is
> > re-added at the same HPA.
> >=20
> > This patch is here to hopefully spur comments on what this is there for!
> >=20
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >   mm/memory_hotplug.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> > index 431b1f6753c0..3d8dd4749dfc 100644
> > --- a/mm/memory_hotplug.c
> > +++ b/mm/memory_hotplug.c
> > @@ -2284,7 +2284,7 @@ static int __ref try_remove_memory(u64 start, u64=
 size)
> >   	}
> >  =20
> >   	if (IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK)) {
> > -		memblock_phys_free(start, size);
> > +		//		memblock_phys_free(start, size);
> >   		memblock_remove(start, size);
> >   	} =20
>=20
> memblock_phys_free() works on memblock.reserved, memblock_remove() works=
=20
>   on memblock.memory.
>=20
> If you take a look at the doc at the top of memblock.c:
>=20
> memblock.memory: physical memory available to the system
> memblock.reserved: regions that were allocated [during boot]
>=20
>=20
> memblock.memory is supposed to be a superset of memblock.reserved. Your=20
> "hack" here indicates that you somehow would be relying on the opposite=20
> being true, which indicates that you are doing the wrong thing.
>=20
>=20
> memblock_remove() indeed balances against memblock_add_node() for=20
> hotplugged memory [add_memory_resource()]. There seem to a case where we=
=20
> would succeed in hotunplugging memory that was part of "memblock.reserved=
".
>=20
> But how could that happen? I think the following way:
>=20
> Once the buddy is up and running, memory allocated during early boot is=20
> not freed back to memblock, but usually we simply go via something like=20
> free_reserved_page(), not memblock_free() [because the buddy took over].=
=20
> So one could end up unplugging memory that still resides in=20
> memblock.reserved set.
>=20
> So with memblock_phys_free(), we are enforcing the invariant that=20
> memblock.memory is a superset of memblock.reserved.
>=20
> Likely, arm64 should store that node assignment elsewhere from where it=20
> can be queried. Or it should be using something like=20
> CONFIG_HAVE_MEMBLOCK_PHYS_MAP for these static windows.
>=20

Hi David,

Thanks for the explanation and pointers.  I'd rather avoid inventing a para=
llel
infrastructure for this (like x86 has for other reasons, but which is also =
used
for this purpose).=20
=46rom a quick look CONFIG_HAVE_MEMBLOCK_PHYS_MAP is documented in a fashion =
that
makes me think it's not directly appropriate (this isn't actual physical me=
mory
available during boot) but the general approach of just adding another memb=
lock
collection seems like it will work.

Hardest problem might be naming it.  physmem_possible perhaps?
Fill that with anything found in SRAT or CEDT should work for ACPI, but I'm=
 not
sure on whether we can fill it when neither of those is present.  Maybe we =
just
don't bother as for today's usecase CEDT needs to be present.

Maybe physmem_known_possible is the way to go. I'll give this approach a sp=
in
and see how it goes.

Jonathan


