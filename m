Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net (zg8tmja5ljk3lje4ms43mwaa.icoremail.net [209.97.181.73])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246FD12E1C4
	for <linux-cxl@vger.kernel.org>; Thu,  9 May 2024 08:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.181.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715243783; cv=none; b=ER5OHRxT1gRKpxp/3jnPTMlqBLfGobeFnU2AXdp60c2xMNTVJZJCSGYwLAoMKibkAkCZJYF5O4MilHrnM9EFeXNpVhcOSa6l96S64MMXd/ZqiHfsifTn3f6rgjTitv1pAxolp2M0KD6LMTy7K8TpuQ4nKo3Pl2OLyhTfsRWElmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715243783; c=relaxed/simple;
	bh=6BimscIfEVy+rigGE22N8TRVH9Ai1yIz3OtT7I8wsVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OcHjALcOzGYO/69JaprzAohdutvfVez8oxj/9OY/XIU3fPQP3vXsI4MqSPMWR0SypV4ezJ0JLgxkBaKNYcBR8T4YG5LCoVqODW1/5MUPzjmEpwTRhEx18K36waBIqGFJIC08FnIsROHZddkM+KCV2qZs7kTV/QfTaayk2ELYRtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=209.97.181.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwAnCQbxijxmyPsYAQ--.5778S2;
	Thu, 09 May 2024 16:36:01 +0800 (CST)
Received: from localhost (unknown [123.150.8.50])
	by mail (Coremail) with SMTP id AQAAfwBn15fbijxmX4IAAA--.1030S2;
	Thu, 09 May 2024 16:35:55 +0800 (CST)
Date: Thu, 9 May 2024 16:35:34 +0800
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org
Subject: Re: CXL numa error on arm64 qemu virt machine
Message-ID: <ZjyK1tI0TtbAKhmh@phytium.com.cn>
Reply-To: 20240508130252.00006367@huawei.com
References: <20240508080051.3756934-1-wangyuquan1236@phytium.com.cn>
 <20240508130252.00006367@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240508130252.00006367@Huawei.com>
X-CM-TRANSID:AQAAfwBn15fbijxmX4IAAA--.1030S2
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAAAWY70+QC3QABs0
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7CrW8GFWkZF1ktw1xuF45Wrg_yoW8tw4fpF
	4jgFn3CrWkJr1xKryktw43Jr15Awn5Ca1DWFyfGw18Arn8Xr1DJw17Kw1agF9xC3yfAw42
	qFyDtr1qya1DZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU

On Wed, May 08, 2024 at 01:02:52PM +0100, Jonathan Cameron wrote:
> 
> > [    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x40000000-0xbfffffff]
> > [    0.000000] ACPI: SRAT: Node 1 PXM 1 [mem 0xc0000000-0x13fffffff]
> > [    0.000000] ACPI: Unknown target node for memory at 0x10000000000, assuming node 0
> > [    0.000000] NUMA: Warning: invalid memblk node 16 [mem 0x0000000004000000-0x0000000007ffffff]
> > [    0.000000] NUMA: Faking a node at [mem 0x0000000004000000-0x000000013fffffff]
> > [    0.000000] NUMA: NODE_DATA [mem 0x13f7f89c0-0x13f7fafff]
> > 
> > Previous discussion: https://lore.kernel.org/linux-cxl/20231011150620.0000212a@Huawei.com/
> > 
> > root@debian-bullseye-arm64:~# cxl create-region -d decoder0.0 -t ram
> > [   68.653873] cxl region0: Bypassing cpu_cache_invalidate_memregion() for testing!
> > [   68.660568] Unknown target node for memory at 0x10000000000, assuming node 0
> 
> You need a load of kernel changes for NUMA nodes to work correctly with
> CXL memory on arm64 platforms.  I have some working code but need to tidy
> up a few corners that came up in an internal review earlier this week.
> 
> I have some travel coming up so may take a week or so to get those out.
> 
> Curiously that invalid memblk has nothing to do with the CXL fixed memory window
> Could you check if that is happening for you without the CXL patches?
> 

Thanks.

I have checked it, the problem is caused by my bios firmware file. I
change the bios file and the numa topology can works.

BTW, if it is convenient, could you help to post the link of the patches of CXL 
memory NUMA nodes on arm64 platforms?

> 
> Whilst it doesn't work yet (because of missing kernel support)
> you'll need something that looks more like the generic ports test added in 
> https://gitlab.com/jic23/qemu/-/commit/6589c527920ba22fe0923b60b58d33a8e9fd371e
> 
> Most importantly
> -numa node,nodeid=2 -object acpi-generic-port,id=gp0,pci-bus-cxl.1,node=2
> + the bits setting distances etc.  Note CXL memory does not provide SLIT like
> data at the moment, so the test above won't help you identify if it is correctly
> set up.  That's a gap in general in the kernel support. Whilst we'd love
> it if everyone moved to hmat derived information we may need to provide
> some fallback.
> 
> Jonathan
> 

Many thanks
Yuquan

