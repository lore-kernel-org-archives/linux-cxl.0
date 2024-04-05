Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF911E52C
	for <linux-cxl@vger.kernel.org>; Fri,  5 Apr 2024 13:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712323799; cv=none; b=RuHoxqbr9hwXG/pnB3MkenPNA0YTt9UnoUtL/4YkxlBzwL4l9EexqZlRORj4jW4o+1L+21smBWR9p4Jw27z+pnvp7ViMEJJcVjojx8xN8pZmI9pNGc70/o4Xv6uvrLVlTSTKXwHBvpS1HisyQ0HYaX8fNbEgwktK8KYOigE43mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712323799; c=relaxed/simple;
	bh=g/jr4ZlUC7P6kGCGyWxaH4F/lIX2SGExW5Lqb5u6aAE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XEV53lgIFD+0GD1zW4hXDSXKkI3vIHocTjE4gm3PwSd4QV+lk56YAWwr81rbQWQmOGGzTTa/nT3SKSJ3+a7KPW8gOOuHhQGEDcQyefClN7ScoZ+dPkLomh+wiSmZ2ajth+y1DSWo7tkrBLR9PonKP5A8lTKpwgCBWRWABn6X5EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V9znz3DBtz688sb;
	Fri,  5 Apr 2024 21:28:23 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 3D7951400CD;
	Fri,  5 Apr 2024 21:29:46 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 5 Apr
 2024 14:29:45 +0100
Date: Fri, 5 Apr 2024 14:29:45 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Parthasarathy, Mohan (In-Memory Compute Platforms)"
	<mohan_parthasarathy@hpe.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, Dave Jiang
	<dave.jiang@intel.com>
Subject: Re: How to connect a CXL memory device to a NUMA node ?
Message-ID: <20240405142945.00002921@Huawei.com>
In-Reply-To: <PH7PR84MB158244A35FB3A633E6E0DFE888032@PH7PR84MB1582.NAMPRD84.PROD.OUTLOOK.COM>
References: <PH7PR84MB158244A35FB3A633E6E0DFE888032@PH7PR84MB1582.NAMPRD84.PROD.OUTLOOK.COM>
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
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 5 Apr 2024 10:36:37 +0000
"Parthasarathy, Mohan (In-Memory Compute Platforms)" <mohan_parthasarathy@hpe.com> wrote:

> Hi all,

Hi Mohan,

You've found a gap on the kernel side of things rather than QEMU I think.
Btw I assume you are testing on x86 - there are some more changes needed on
ARM64. I have them but need to find time to clean up the code. My tests
are on ARM64 but should align with what you are seeing.

Directly no, there isn't a way to do it because such a setup would rely
on firmware doing the distance discovery and creating SLIT and SRAT appropriate.
It doesn't make sense to emulate a firmware setup directly in QEMU though we
could in theory do so.

Unless someone fancies taking on EDK2 support for doing that on top of QEMU, we are
focusing on what looks more like a hotplug flow (or a BIOS leaving configuration
to the OS.)

For that we use SRAT Generic Port Affinity structures and CFMW Structures in CEDT.
Not all the code is upstream yet though. You'll need qemu patches
https://lore.kernel.org/qemu-devel/20240403102927.31263-1-Jonathan.Cameron@huawei.com/
(there is a test in there to act as an example on how to configure it)
which I posted earlier this week +
 Dave Jiang's kernel fixes on this list for the kernel
https://lore.kernel.org/linux-cxl/20240403154844.3403859-1-dave.jiang@intel.com/T/#t

However, I think we do have a gap in providing any data for SLIT equivalent for the NUMA
nodes generated for CXL memory.

You can add SLIT for all the ACPI nodes via the -numa dist,src=0,dst=0,val=10 etc
entrees in here
https://github.com/open-mpi/hwloc/wiki/Simulating-complex-memory-with-Qemu

I've just run with that and get generic distances from numactl -H similar to below
but the HMAT derived /sys/bus/nodes/devices/nodeX/access0/ etc correctly show different distances.
For nodes in SLIT the values /sys/bus/node/devices/nodeX/distances (which is probably
what numactl -H reads) show the values provided (I used 21 to make it obvious) but
for CXL memory added to the OS the default value of 20 is used.

Currently CXL related NUMA nodes are per CFMWS so if you want to separate devices into their
own nodes you will need to create 2 of those if you want to separate your two devices into
their own NUMA nodes.

So I wonder, what should we do about distances traditionally retrieved from SLIT?
There will be lots of legacy code out there unfortunately that will care :(

We need to poke something into numa_set_distance() I think.

Fun here is how do we derive something sensible given the can of worms SLIT
is? 10 is well defined but other than 'bigger' internode distances depend
on what mood the bios writer was in and what broke in various OS with
the values they actually wanted to put in - these are tweaked to get around
OS issues - we like about some of our platforms so that the scheduler doesn't
go crazy for example. We could try to calculate relationship between SLIT
values and HMAT values on a platform and use that to derive a value?

Anyone object to just using 42 for all CXL memory nodes that weren't set
to anything at boot time? (i.e. not already in SLIT?)

Jonathan


> 
> I want to create a VM with 2 CXL memory devices - one attached to NUMA node 0 and one attached to NUMA node 1. Is this possible in QEMU ? Currently when I create a CXL memory device in QEMU, it shows equal distances from each numa node in numactl output. I want it such that it should show closer distance to the NUMA node (or socket) it is attached to. Something like this :
> 
> [fedora@localhost ~]$ numactl -H
> available: 3 nodes (0-2)
> node 0 cpus: 0 1
> node 0 size: 1894 MB
> node 0 free: 1627 MB
> node 1 cpus: 2 3
> node 1 size: 2012 MB
> node 1 free: 1696 MB
> node 2 cpus:
> node 2 size: 4096 MB
> node 2 free: 4096 MB
> node distances:
> node   0   1   2
>   0:  10  20  20
>   1:  20  10  30
>   2:  20  20  10
> 
> As you can see the distance for numa node 1 to the cxl device should be 30, not 20, assuming the CXL device is attached to node 0. Any thoughts on how to make this work ?
.
> 
> Regards,
> Mohan
> 

