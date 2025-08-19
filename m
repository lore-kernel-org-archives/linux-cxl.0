Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F9123F291
	for <linux-cxl@vger.kernel.org>; Tue, 19 Aug 2025 16:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755619555; cv=none; b=J/cdf3ulbVFtj3w6Hqr9SQ3U5jwXjxKH+ZOWG1e1CZsUaAVvArMJuUEY+O5iTcaxfgKPwPDJ1ro/RQWjH0KvFsg4/+T6zN12MtwXdylTyh3qY3UKUxgy+W0J0Qtv6wmrJlhYPTlKHeZixIwLl2zAA+4ah1taJ+7U7N+Lu/eAnVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755619555; c=relaxed/simple;
	bh=PZhF7ONLkDzzfEGSjdEGQqC8inOxMeB7pCSstrHXV4s=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DQxrnlY3tFLSW5rqI0BSc7/jOSLyhxJ2HJHaXhWYaWeDhIuRxFI1N8zXPbKbBtWZihoW70cvGWTxie1NOeneSnoUyHRJx/cDrusYjQKJiyBoD8t+9rrnsnq2j2hXhkawMvjj2t2s+2GMgO6kEYPvsEV9JjhxZyjFefddMKs3weI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4c5vWz2hy2z6GFxY;
	Wed, 20 Aug 2025 00:03:43 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 99D9A1402DA;
	Wed, 20 Aug 2025 00:05:49 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 19 Aug
 2025 18:05:49 +0200
Date: Tue, 19 Aug 2025 17:05:47 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Alejandro Lucero Palau <alucerop@amd.com>
CC: Ben Cheatham <Benjamin.Cheatham@amd.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [RFC PATCH 00/18] Initial CXL.cache device support
Message-ID: <20250819170547.000008da@huawei.com>
In-Reply-To: <20250819165754.0000015f@huawei.com>
References: <20250812212921.9548-1-Benjamin.Cheatham@amd.com>
	<f3ac894b-7c8d-4f9d-9bfb-d05c7d7c5650@amd.com>
	<20250819165754.0000015f@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 19 Aug 2025 16:57:54 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> On Wed, 13 Aug 2025 12:25:12 +0100
> Alejandro Lucero Palau <alucerop@amd.com> wrote:
> 
> > On 8/12/25 22:29, Ben Cheatham wrote:  
> > > This patch series adds initial CXL.cache support. What I have here only
> > > allows for adding a cache device to the system, programming/validating
> > > the system configuration with respect to cache devices, and some basic
> > > cache reporting/management.
> > >
> > > The general philosophy is to have an endpoint/vendor-specific driver
> > > that runs through the same steps of adding a cxl_memdev, but for the
> > > cache portion of the device (both type 1 & 2). Getting cache support for
> > > a CXL device should be as simple as: get cache information, set up the
> > > memory region (see below), and then calling devm_cxl_add_cachedev().
> > >
> > > There's a couple of things missing from this set:
> > >
> > > 1) Missing an endpoint driver
> > >
> > > 	I plan on submitting a reference driver (type 1 or 2) with v1, I
> > > 	figured I'd send out what I have before going much further.
> > >
> > > 2) Mapping/Reserving host memory used for CXL cache(s)
> > >
> > > 	I'm thinking this will be handled by the endpoint driver, but I'm
> > > 	not sure what mechanism would be used and whether to integrate it
> > > 	with the cxl_cache/core. Any thoughts/ideas here are appreciated!    
> > 
> > 
> > Hi Ben,
> > 
> > 
> > Good to see you working on this. I'll go through the series these next days.
> > 
> > 
> > FWIW, I did send a RFC last November about my concerns for 
> > properly/safely supporting CXL.cache.
> > 
> > 
> > I had no time to keep thinking about it. Also, I sent a copy to the 
> > kernel iommu mailing list, but it did not get traction then. Anyways, as 
> > a summary, I think mapping for CXL.cache requires not just the endpoint 
> > driver doing it freely but through the cxl core for ensuring it is done 
> > properly and safely. But I have to admit this could be a 
> > misunderstanding about how the hardware is going to allow CXL.cache.  
> 
> Perhaps it's time to restart that discussion. 
> 
> https://lore.kernel.org/linux-cxl/cc2525a6-0f6a-c1c8-83e1-6396661efc8a@amd.com/
> 
I hit send too fast.  For that thread I'd suggest we break it down into
the various issues you raise. Make it a bit more bite sized!

Some such as trust should be relatively easy to tick off with the work
Lukas is doing on attestation (or the version that uses confidential
compute infrastructure)

Jonathan

> > 
> > 
> > Thanks
> > 
> >   
> > > 3) RAS Support
> > >
> > > 	Same situation as 1) above.
> > >
> > > Some quick notes: The actual cache parts of this set are untested due
> > > to problems with my set up, but I did make sure nothing here breaks type
> > > 3 support. I'll have this fixed before sending out a v1. This series is
> > > based on the for-6.18/cxl-probe-order (commit 5e29cbd1077b) branch in
> > > the CXL repo, with v7 of Dave's deferred dport probe set on top [1]. I
> > > added Dave's set to help with getting around constraints with HDM
> > > decoders in CXL.cache device only configurations (see 08/18 for more).
> > >
> > > Patch Breakdown:
> > > 	- 1 & 2: Preliminary changes for struct cxl_cachedev
> > > 	- 3: Add struct cxl_cachedev
> > > 	- 4-8: Preliminary changes for adding cache devices to port
> > > 	  hierarchy
> > > 	- 9: Function for getting CXL cache info
> > > 	- 10: cxl_cache driver (mirrors cxl_mem)
> > > 	- 11-16: Checking CXL.cache capabilities for system configuration
> > > 	  validity
> > > 	- 17-18: Cache device attributes
> > >
> > > [1]:
> > > Link: https://lore.kernel.org/linux-cxl/20250714223527.461147-1-dave.jiang@intel.com/
> > >
> > > Ben Cheatham (18):
> > >    cxl/mem: Change cxl_memdev_ops to cxl_dev_ops
> > >    cxl: Move struct cxl_dev_state definition
> > >    cxl/core: Add CXL.cache device struct
> > >    cxl: Replace cxl_mem_find_port() with cxl_dev_find_port()
> > >    cxl: Change cxl_ep_load() to use struct device * parameter
> > >    cxl/port, mem: Make adding an endpoint device type agnostic
> > >    cxl/port: Split endpoint port probe on device type
> > >    cxl/port: Update switch_port_probe() for CXL cache devices
> > >    cxl/core: Add function for getting CXL cache info
> > >    cxl/cache: Add cxl_cache driver
> > >    cxl/core: Add CXL snoop filter setup and checking
> > >    cxl/cache: Add CXL Cache ID Route Table mapping
> > >    cxl/cache: Implement Cache ID Route Table programming
> > >    cxl/cache: Add Cache ID Decoder capability mapping
> > >    cxl/cache: Implement Cache ID Decoder programming
> > >    cxl/cache: Add cache device counting for CXL ports
> > >    cxl/core: Add cache device attributes
> > >    cxl/core: Add cache device cache management attributes
> > >
> > >   drivers/cxl/Kconfig         |  14 +
> > >   drivers/cxl/Makefile        |   2 +
> > >   drivers/cxl/cache.c         | 276 +++++++++++++++++++
> > >   drivers/cxl/core/Makefile   |   1 +
> > >   drivers/cxl/core/cachedev.c | 292 ++++++++++++++++++++
> > >   drivers/cxl/core/hdm.c      |  31 +++
> > >   drivers/cxl/core/memdev.c   |   2 +-
> > >   drivers/cxl/core/pci.c      | 134 ++++++++++
> > >   drivers/cxl/core/port.c     | 518 +++++++++++++++++++++++++++++++++---
> > >   drivers/cxl/core/region.c   |  25 +-
> > >   drivers/cxl/core/regs.c     |  28 ++
> > >   drivers/cxl/cxl.h           | 193 +++++++++++++-
> > >   drivers/cxl/cxlcache.h      |  42 +++
> > >   drivers/cxl/cxlmem.h        | 121 +--------
> > >   drivers/cxl/cxlpci.h        |  10 +
> > >   drivers/cxl/mem.c           |  14 +-
> > >   drivers/cxl/pci.c           |   2 +-
> > >   drivers/cxl/port.c          |  54 ++--
> > >   drivers/cxl/private.h       |   8 +-
> > >   19 files changed, 1569 insertions(+), 198 deletions(-)
> > >   create mode 100644 drivers/cxl/cache.c
> > >   create mode 100644 drivers/cxl/core/cachedev.c
> > >   create mode 100644 drivers/cxl/cxlcache.h
> > >    
> >   
> 
> 

