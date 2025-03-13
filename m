Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA7E2690E6;
	Thu, 13 Mar 2025 16:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741882354; cv=none; b=r1Tw1qJEUm5xwOy9Zjv2NEX9XfD3OoV67vDsdjOMTK8HvAKr95Wiv9j1aytSL86DMY/GWpC/mKj2mHj5EwMwYAnSpKAenhvzT3H/ofvPxithpPLNGxiTW3sJjWmukSbj7J9WMFm2ubTfZGZ+qGitaah4VT43jxZBTwgz/lwCE3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741882354; c=relaxed/simple;
	bh=nJgwZ90lvtn9MB8Orqeey9ZWPMtUlNmbJi/0dOUJIEI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SZWkXTMmDCqO/jLNW0eQ2fLOzSmksi52EQauScZOaiIJuc5NXJggVlBHsrf6VyQGyjQhlIu0IXIf+sQ7lLoi8mYKbcyfDvf3p4JdaqpGvgSJVVU4/DYofEug9vH5dK5Q/xwNDrKMvqAsMlLgME89XfSi4Zh5rbWMsjOQi3Sj67Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZDC9p4X3zz6H8mF;
	Fri, 14 Mar 2025 00:09:18 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 90C2C140391;
	Fri, 14 Mar 2025 00:12:28 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 13 Mar
 2025 17:12:28 +0100
Date: Thu, 13 Mar 2025 16:12:26 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Gregory Price <gourry@gourry.net>
CC: <lsf-pc@lists.linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [LSF/MM] CXL Boot to Bash - Section 1: BIOS, EFI, and Early
 Boot
Message-ID: <20250313161226.00000038@huawei.com>
In-Reply-To: <Z8ZKKwDnuAjtyohz@gourry-fedora-PF4VCD3F>
References: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>
	<Z6LKJZkcdjuit2Ck@gourry-fedora-PF4VCD3F>
	<Z8ZKKwDnuAjtyohz@gourry-fedora-PF4VCD3F>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 3 Mar 2025 19:32:43 -0500
Gregory Price <gourry@gourry.net> wrote:

> On Tue, Feb 04, 2025 at 09:17:09PM -0500, Gregory Price wrote:
> > ------------------------------------------------------------------
> > Step 2: BIOS / EFI generates the CEDT (CXL Early Detection Table).
> > ------------------------------------------------------------------
> > 
> > This table is responsible for reporting each "CXL Host Bridge" and
> > "CXL Fixed Memory Window" present at boot - which enables early boot
> > software to manage those devices and the memory capacity presented
> > by those devices.
> > 
> > Example CEDT Entries (truncated) 
> >          Subtable Type : 00 [CXL Host Bridge Structure]
> >               Reserved : 00
> >                 Length : 0020
> > Associated host bridge : 00000005
> > 
> >          Subtable Type : 01 [CXL Fixed Memory Window Structure]
> >               Reserved : 00
> >                 Length : 002C
> >               Reserved : 00000000
> >    Window base address : 000000C050000000
> >            Window size : 0000003CA0000000
> > 
> > If this memory is NOT marked "Special Purpose" by BIOS (next section),
> > you should find a matching entry EFI Memory Map and /proc/iomem
> > 
> > BIOS-e820:   [mem 0x000000c050000000-0x000000fcefffffff] usable
> > /proc/iomem: c050000000-fcefffffff : System RAM
> > 
> > 
> > Observation: This memory is treated as 100% normal System RAM
> > 
> >    1) This memory may be placed in any zone (ZONE_NORMAL, typically)
> >    2) The kernel may use this memory for arbitrary allocations
> >    4) The driver still enumerates CXL devices and memory regions, but
> >    3) The CXL driver CANNOT manage this memory (as of today)
> >       (Caveat: *some* RAS features may still work, possibly)
> > 
> > This creates an nuanced management state.
> > 
> > The memory is online by default and completely usable, AND the driver
> > appears to be managing the devices - BUT the memory resources and the
> > management structure are fundamentally separate.
> >    1) CXL Driver manages CXL features
> >    2) Non-CXL SystemRAM mechanisms surface the memory to allocators.
> >   
> 
> Adding some additional context here
> 
> -------------------------------------
> Nuance X: NUMA Nodes and ACPI Tables.
> -------------------------------------
> 
> ACPI Table parsing is partially architecture/platform dependent, but
> there is common code that affects boot-time creation of NUMA nodes.
> 
> NUMA-nodes are not a dynamic resource.  They are (presently, Feb 2025)
> statically configured during kernel init, and the number of possible
> NUMA nodes (N_POSSIBLE) may not change during runtime.
> 
> CEDT/CFMW and SRAT/Memory Affinity entries describe memory regions
> associated with CXL devices.  These tables are used to allocate NUMA
> node IDs during _init.
> 
> The "System Resource Affinity Table" has "Memory Affinity" entries
> which associate memory regions with a "Proximity Domain"
> 
>         Subtable Type : 01 [Memory Affinity]
>                Length : 28
>      Proximity Domain : 00000001
>             Reserved1 : 0000
>          Base Address : 000000C050000000
>        Address Length : 0000003CA0000000
> 
> The "Proximity Domain" utilized by the kernel ACPI driver to match this
> region with a NUMA node (in most cases, the proximity domains here will
> directly translate to a NUMA node ID - but not always).
> 
> CEDT/CFMWS do not have a proximity domain - so the kernel will assign it
> a NUMA node association IFF no SRAT Memory Affinity entry is present.
> 
> SRAT entries are optional, CFMWS are required for each host bridge.

They aren't required for each HB.  You could have multiple host bridge and one CFMWS
as long as you have decided to only support interleave.
I would only expect to see this where the bios is instantiating CFMWS
entries to match a specific locked down config though.

> 
> If SRAT entries are present, one NUMA node is created for each detected
> proximity domain in the SRAT. Additional NUMA nodes are created for each
> CFMWS without a matching SRAT entry.

Don't forget the fun of CFMWS covering multiple SRAT entries (I think
we just go with the first one?)

> 
> CFMWS describes host-bridge information, and so if SRAT is missing - all
> devices behind the host bridge will become naturally associated with the
> same NUMA node.

I wouldn't go with naturally for the reason below.  It happens, but maybe
not natural :)

> 
> 
> big long TL;DR:
> 
> This creates the subtle assumption that each host-bridge will have
> devices with similar performance characteristics if they're intended
> for use as general purpose memory and/or interleave.

Not just devices, also topologies.  Could well have switches below some
ports and direct connected devices on others.

> 
> This means you should expect to have to reboot your machine if a
> different NUMA topology is needed (for example, if you are physically
> hotunplugging a volatile device to plug in a non-volatile device).
If the bios is friendly you should be able to map that to a different
CFMWS, but sure what bios is that nice?
> 
> 
> 
> Stay tuned for more Fun and Profit with ACPI tables :]
:)
> ~Gregory
> 

