Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F5E2FE595;
	Thu, 19 Feb 2026 14:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771510777; cv=none; b=oJUijJlL2P0VgyXj3GyNRSaNkx4bywdiXMZNbUU7Tr19Y6/kSsHw5r+TpZQ5T2cRuXZfuS9yKam9vbda5y9wUfEd/OYM/Mz6tY8wL14D/bxiJGTMF+47mW6xmgLe21puRp+68WYUn34tRK4c533ByBFimSMDwWY3Vi+nHpD39uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771510777; c=relaxed/simple;
	bh=WZxPjuvtJUEZN+0yhSYnrlafptb0X+sYlOujxHYfplU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SAXb6UTzdsHF2+aUEAuMI9MBRRkwlDBIWMRh2fo+r1QLyUbJFCksKpLpMbfr8B9X3pEDPvJ6hDMfiQd2cGIHUhkThFAugNAFFaooBcbpkwneMPs4sDnIOnrEIS3V4tH77xiv3AqNaeoK+kJ8B/LuHYAOlDjD/YeonsHBo1OP/mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fGwVG3kLfzHnGj5;
	Thu, 19 Feb 2026 22:19:02 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id B24FA40086;
	Thu, 19 Feb 2026 22:19:32 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 19 Feb
 2026 14:19:32 +0000
Date: Thu, 19 Feb 2026 14:19:30 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Gregory Price <gourry@gourry.net>
CC: Andrew Morton <akpm@linux-foundation.org>, Cui Chao
	<cuichao1753@phytium.com.cn>, <dan.j.williams@intel.com>, Mike Rapoport
	<rppt@kernel.org>, Wang Yinfeng <wangyinfeng@phytium.com.cn>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <qemu-devel@nongnu.org>, "David Hildenbrand (Arm)"
	<david@kernel.org>
Subject: Re: [PATCH v2 1/1] mm: numa_memblks: Identify the accurate NUMA ID
 of CFMW
Message-ID: <20260219141930.0000124a@huawei.com>
In-Reply-To: <aYYXif7IPXnXZPnn@gourry-fedora-PF4VCD3F>
References: <2d1e23ad-7ec1-483b-88b3-70ce19b69106@phytium.com.cn>
	<aXOl9CN_66HywIjZ@gourry-fedora-PF4VCD3F>
	<a90bc6f2-105c-4ffc-99d9-4fa5eaa79c45@phytium.com.cn>
	<20260205145842.efb90572a902ae4c481e6ef6@linux-foundation.org>
	<aYUjf0OrD8f_bJCy@gourry-fedora-PF4VCD3F>
	<20260206110305.00001fbb@huawei.com>
	<aYXtHa4Y2y_5xgcS@gourry-fedora-PF4VCD3F>
	<20260206150941.000028ae@huawei.com>
	<aYYOZ1TK5dpX_h_Q@gourry-fedora-PF4VCD3F>
	<20260206162644.000050fe@huawei.com>
	<aYYXif7IPXnXZPnn@gourry-fedora-PF4VCD3F>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Fri, 6 Feb 2026 11:32:09 -0500
Gregory Price <gourry@gourry.net> wrote:

> On Fri, Feb 06, 2026 at 04:26:44PM +0000, Jonathan Cameron wrote:
> > > 
> > > This should fall out cleanly.
> > > 
> > > The additional nodes won't be associated with anything, but could be
> > > used for hotplug - I imagine.
> > >   
> > 
> > That aligns with what I was thinking as a first solution to allowing this
> > to be more dynamic.   We can get clever later if this doesn't prove sufficient.
> >   
> 
> I can get this out pretty quickly, hopefully sometime next week.
> 
> I had a long talk with Dan about this topic previously, and I'm not sure
> how we get more dynamic than this to be honest.  nr_possible_nodes is
> *definitely* expected to be immutable after __init all over the kernel,
> it's used to allocate a memory.

Indeed. But that doesn't mean to say they are all in use after __init.

You end up allocating a bunch of space, that is not used until there
is some memory there.  Not a problem.

So dynamic nr_possible_nodes is tricky.  Dynamic allocation of stuff into
those nodes is fine. That happens with memory hotplug today.

J
> 
> Surface area is very large here.
> 
> ~Gregory

