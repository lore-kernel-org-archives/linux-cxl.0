Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4095382D82
	for <linux-cxl@vger.kernel.org>; Wed,  8 May 2024 12:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715169784; cv=none; b=fK67StKAkIubwCd6bbsue0E4zKOZPH320fXQIFP9VV/FTfz7QlWfMSCbE/dng/vum0X/Kpx/FbVAjjF6Izn5InFKW9cnyyIlYui3AsQiSJiNo3I34ExpEx7L51NTXFcKXWuYdKMRFei048wn+ginl1HqvEMTUbeGPzNyeKpiSWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715169784; c=relaxed/simple;
	bh=Du36ewh4lvTuM0HvVdRrYUOg8BnXuF2dkwVxQHbNXdM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gp0zMaUvTELQuUGXBO8kB6pefpSR5tldWlY8dEb/JzNIzjfav+LpgjIsjZnQwCkDTI3WMybiNT8TboGVJBt10GJXKHq1C7t2V0rvDii2Xcb9l9L8EzRBOBlRU8UG1Rv112azx+1qsG78uGT4J2piRRkgoXdPomfSWgW+dzVlXaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VZDGX73SZz6K6Pr;
	Wed,  8 May 2024 19:59:48 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 6A1E7140B38;
	Wed,  8 May 2024 20:02:54 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 8 May
 2024 13:02:54 +0100
Date: Wed, 8 May 2024 13:02:52 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>
Subject: Re: CXL numa error on arm64 qemu virt machine
Message-ID: <20240508130252.00006367@Huawei.com>
In-Reply-To: <20240508080051.3756934-1-wangyuquan1236@phytium.com.cn>
References: <20240508080051.3756934-1-wangyuquan1236@phytium.com.cn>
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
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 8 May 2024 16:00:51 +0800
Yuquan Wang <wangyuquan1236@phytium.com.cn> wrote:

> Hello, Jonathan
> 
> Recently I run some cxl tests on qemu virt(branch:cxl-2024-04-22-draft) but met some
> problems.
> 
> Problems: 
> 1) the virt machine could not set the right numa topology from user input;
> 
> My Qemu numa set:
> -object memory-backend-ram,size=2G,id=mem0 \
> -numa node,nodeid=0,cpus=0-1,memdev=mem0 \
> -object memory-backend-ram,size=2G,id=mem1 \
> -numa node,nodeid=1,cpus=2-3,memdev=mem1 \

That is setting up the main DRAM nodes, unrelated to
CXL memory. For CXL memory you need to use generic
port entries (in my gitlab qemu tree - with examples but not upstream yet)
However, if you get some breakage

> 
> However, the system shows:
> root@ubuntu-jammy-arm64:~# numactl -H
> 	available: 1 nodes (0)
> 	node 0 cpus: 0 1 2 3
> 	node 0 size: 4166 MB
> 	node 0 free: 3920 MB
> 	node distances:
> 	node   0 
> 	0:  10 
> 
> Boot Kernel print:
> [    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x40000000-0xbfffffff]
> [    0.000000] ACPI: SRAT: Node 1 PXM 1 [mem 0xc0000000-0x13fffffff]
> [    0.000000] ACPI: Unknown target node for memory at 0x10000000000, assuming node 0
> [    0.000000] NUMA: Warning: invalid memblk node 16 [mem 0x0000000004000000-0x0000000007ffffff]
> [    0.000000] NUMA: Faking a node at [mem 0x0000000004000000-0x000000013fffffff]
> [    0.000000] NUMA: NODE_DATA [mem 0x13f7f89c0-0x13f7fafff]
> 
> 2) it seems like the problem of allocating numa node in arm for cxl memory still exists;
> Previous discussion: https://lore.kernel.org/linux-cxl/20231011150620.0000212a@Huawei.com/
> 
> root@debian-bullseye-arm64:~# cxl create-region -d decoder0.0 -t ram
> [   68.653873] cxl region0: Bypassing cpu_cache_invalidate_memregion() for testing!
> [   68.660568] Unknown target node for memory at 0x10000000000, assuming node 0

You need a load of kernel changes for NUMA nodes to work correctly with
CXL memory on arm64 platforms.  I have some working code but need to tidy
up a few corners that came up in an internal review earlier this week.

I have some travel coming up so may take a week or so to get those out.

Curiously that invalid memblk has nothing to do with the CXL fixed memory window
Could you check if that is happening for you without the CXL patches?

> 
> If not, maybe I could try to do something to help fix this problem.
> 
> 
> My full qemu command line:
> qemu-system-aarch64 \
> -M virt,gic-version=3,cxl=on \
> -m 4G \
> -smp 4 \
> -object memory-backend-ram,size=2G,id=mem0 \
> -numa node,nodeid=0,cpus=0-1,memdev=mem0 \
> -object memory-backend-ram,size=2G,id=mem1 \
> -numa node,nodeid=1,cpus=2-3,memdev=mem1 \
> -cpu cortex-a57 \
> -bios QEMU_EFI.fd.bak \
> -device virtio-blk-pci,drive=hd,bus=pcie.0 \
> -drive if=none,id=hd,file=../disk/debos_arm64.ext \
> -nographic \
> -object memory-backend-file,id=mem2,mem-path=/tmp/mem2,size=256M,share=true \
> -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
> -device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \
> -device cxl-type3,bus=root_port13,volatile-memdev=mem2,id=cxl-mem1 \
> -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G \
> -qmp tcp:127.0.0.1:4444,server,nowait \
> 
> Qemu version: the lastest commit of branch cxl-2024-04-22-draft in "https://gitlab.com/jic23/qemu" 
> Kernel version: 6.6.0

Whilst it doesn't work yet (because of missing kernel support)
you'll need something that looks more like the generic ports test added in 
https://gitlab.com/jic23/qemu/-/commit/6589c527920ba22fe0923b60b58d33a8e9fd371e

Most importantly
-numa node,nodeid=2 -object acpi-generic-port,id=gp0,pci-bus-cxl.1,node=2
+ the bits setting distances etc.  Note CXL memory does not provide SLIT like
data at the moment, so the test above won't help you identify if it is correctly
set up.  That's a gap in general in the kernel support. Whilst we'd love
it if everyone moved to hmat derived information we may need to provide
some fallback.

Jonathan




> 
> Many thanks
> Yuquan
> 

