Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDBB2BCF5D;
	Fri,  6 Feb 2026 16:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770395209; cv=none; b=FWONy2dOii2UcF5cxOnj/hQjB3t1HF7mc42T6/N/nAgoDQCJond/nNaPjzyOKw3N/o4sSGo5EK007uUJ/HnAwSgU+U6vEe4iM5vRGtniTHnbMfEImNWK/psPEVUZ5RgVSvUhUk+3OQwOgXzfquvjGdjg5JMRZt0RCpJbRwnl5qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770395209; c=relaxed/simple;
	bh=17rjHDiJNeSBQWuNIq3xb92bZlgx/Osy7/6sfw0O26s=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lHjNRhRARm6l3BLKGt6NjzMNiaWOrRCUE5MJ6yhIszgpVFXP5BzA3GVdbfrWanSREAicPdBmwRFa+KewWcyjHSCMkU3QcLuyDTqZsXyR53Ex4cUktE8KZ4mpknZEHthFl+2YG3Z7SdwiFzZm1RNHx1OMQKDjJVouVphDXTfIcGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f6zxY4tVlzHnGfl;
	Sat,  7 Feb 2026 00:26:41 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 6559B4056A;
	Sat,  7 Feb 2026 00:26:46 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 6 Feb
 2026 16:26:45 +0000
Date: Fri, 6 Feb 2026 16:26:44 +0000
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
Message-ID: <20260206162644.000050fe@huawei.com>
In-Reply-To: <aYYOZ1TK5dpX_h_Q@gourry-fedora-PF4VCD3F>
References: <20260115101858.85fd7b8e837c1c92a4fdc5f0@linux-foundation.org>
	<696944eca1837_34d2a10056@dwillia2-mobl4.notmuch>
	<2d1e23ad-7ec1-483b-88b3-70ce19b69106@phytium.com.cn>
	<aXOl9CN_66HywIjZ@gourry-fedora-PF4VCD3F>
	<a90bc6f2-105c-4ffc-99d9-4fa5eaa79c45@phytium.com.cn>
	<20260205145842.efb90572a902ae4c481e6ef6@linux-foundation.org>
	<aYUjf0OrD8f_bJCy@gourry-fedora-PF4VCD3F>
	<20260206110305.00001fbb@huawei.com>
	<aYXtHa4Y2y_5xgcS@gourry-fedora-PF4VCD3F>
	<20260206150941.000028ae@huawei.com>
	<aYYOZ1TK5dpX_h_Q@gourry-fedora-PF4VCD3F>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Fri, 6 Feb 2026 10:53:11 -0500
Gregory Price <gourry@gourry.net> wrote:

> On Fri, Feb 06, 2026 at 03:09:41PM +0000, Jonathan Cameron wrote:
> > On Fri, 6 Feb 2026 08:31:09 -0500
> > Gregory Price <gourry@gourry.net> wrote:
> > 
> > Now a fun corner is that a node isn't created unless there is something
> > in it - the whole SRAT is the source of truth for what nodes exist
> > - so we need 'something' in it - a cpu will do, or a GI, probably a GP.
> > Otherwise memory ends up in node0.  However, fallback lists etc happen
> > as normal when first mem in a node is added.
> >   
> ...
> > For now I 'suspect' we could hack things to provide lots of waiting numa nodes
> > and merrily assign HPA into them as we like whatever SRAT provides
> > in the way of 'hints' :) 
> >   
> 
> look at ACPI MSCT - "Maximum Proximity Domain Information Structure" ;]
> 
> I don't remember reading anything in the ACPI spec that says something
> has to be ON any of these PXMs for it to be accounted for in the MSCT.
> 
> Platforms can just say "Reserve that many Nodes".
> 
> (Linux does not read this value, and on my existing systems, this number
> always reflects the number of actually present PXMs)
> 
> ---
> 
> We probably want to ignore that and just add this:
> 
> CONFIG_ACPI_NUMA_NODES_PER_CFMWS
>     int
>     range 1 4
>     help
>         This option determines the number of NUMA nodes that will be
> 	added for each CEDT CFMWS entry.
> 
> 	By default ACPI reserves 1 per unique PXM entry in the SRAT,
> 	or 1 for a CXL Fixed Memory Window without SRAT mappings.
> 
> 	This will reserve up to N nodes per CEDT entry, even if that
> 	CEDT has one or more SRAT entries.
> 
> then in the acpi/numa/srat.c code that parses srat/cedt, just track
> the number of nodes over a CEDT range.
> 
> for each srat:
>    account_unique_pxm(pxm, srat_range)
> 
> for each cedt:
>    nr_nodes = unique_pxms(cedt_range)
>    while (nr_nodes < CONFIG_ACPI_NUMA_NODES_PER_CFMWS)
>       node = acpi_map_pxm_to_node(*fake_pxm++);
>       if (node == NUMA_NO_NODE):
>       	err("Unable to reserve additional nodes for CXL windows")
> 	break;
>       node_set(node, numa_nodes_parsed);
>       nr_nodes++
> 
> This should fall out cleanly.
> 
> The additional nodes won't be associated with anything, but could be
> used for hotplug - I imagine.
> 

That aligns with what I was thinking as a first solution to allowing this
to be more dynamic.   We can get clever later if this doesn't prove sufficient.

Jonathan

> ~Gregory

