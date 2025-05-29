Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73C025291B
	for <linux-cxl@vger.kernel.org>; Thu, 29 May 2025 05:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748495629; cv=none; b=Sz8DsdjQc0CY3+LNF6fpJ4Fey4KO+GXw67Wa7dBTa2Kncl1Gr6bu7UUdjvUZFNiAKGyNRMtmgSWYREMgp7BpuINiI30rDWxFnSwxdQormRUPNnL9Q5fb+iyQlJz11aVlexzAKWlwGmMMUDiVahioIhLPqgPK2dTbjnhIm3FbQvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748495629; c=relaxed/simple;
	bh=fHGAkrjJ0diP/1aryM9HUsCICK01IpEIBD3RppjmyIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QgQu0iZEw+pFs8to/U5cSLMDmkc02cCWVmylFwH7gyPPaGI5+pxW5pcRuzSI6TYjPysfL3QcuPsdaROjQAG6LN5AKDyoWsWb1g/SImQm/KgZ49GDlZDOnxpyGjkxFtX7F6/TkpK3w1JPYZapOBC7msllG+/SzFqTKLddPmBqXus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YMikC+Lt; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YMikC+Lt"
Date: Thu, 29 May 2025 14:13:30 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748495620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ft5agwKDm8mVsjeLDhOw5RT0PS9jra2LFUmmBHo9PzE=;
	b=YMikC+Lt8WyYOzjn3zlw0vWqHTGW1zCE2G6beXc++FC/N1ZK4RytW87EtTmHQp/9ZefJNv
	8GSKMe+uPmC1wWA7cxxXzjWUYUgdB+fQVzJpWzGGXOTRporoy0vxi/emfirt/H7r1NINB3
	+qtBmZG7Q1tuZKXF4bP4EAuRQYUbZpo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Itaru Kitayama <itaru.kitayama@linux.dev>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, Fan Ni <fan.ni@samsung.com>,
	Peter Maydell <peter.maydell@linaro.org>, mst@redhat.com,
	linuxarm@huawei.com, linux-cxl@vger.kernel.org, qemu-arm@nongnu.org,
	Yuquan Wang <wangyuquan1236@phytium.com.cn>,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
	Alireza Sanaee <alireza.sanaee@huawei.com>
Subject: Re: [PATCH v14 0/5] arm/virt: CXL support via pxb_cxl
Message-ID: <aDfs+gIkK5ekKBXx@vm4>
References: <20250528110726.226389-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250528110726.226389-1-Jonathan.Cameron@huawei.com>
X-Migadu-Flow: FLOW_OUT

On Wed, May 28, 2025 at 12:07:21PM +0100, Jonathan Cameron wrote:
> v14: Simplifications suggeseted by Itaru (and some extra simplifications
>      that became apparent) and gather tags.
>      See individual patches for more information.
> 
> Updated cover letter
> 
> Richard Henderson has posted a pull request with a fix for the TCG TLB
> issue which will hopefully merge shortly (Thanks Richard!).
> 
> Back in 2022, this series stalled on the absence of a solution to device
> tree support for PCI Expander Bridges (PXB) and we ended up only having
> x86 support upstream. I've been carrying the arm64 support out of tree
> since then, with occasional nasty surprises (e.g. UNIMP + DT issue seen
> a few weeks ago) and a fair number of fiddly rebases.
> gitlab.com/jic23/qemu cxl-<latest date>.  Will update shortly with this
> series.
> 
> A recent discussion with Peter Maydell indicated that there are various
> other ACPI only features now, so in general he might be more relaxed
> about DT support being necessary. The upcoming vSMMUv3 support would
> run into this problem as well.
> 
> I presented the background to the PXB issue at Linaro connect 2022. In
> short the issue is that PXBs steal MMIO space from the main PCI root
> bridge. The challenge is knowing how much to steal.
> 
> On ACPI platforms, we can rely on EDK2 to perform an enumeration and
> configuration of the PCI topology and QEMU can update the ACPI tables
> after EDK2 has done this when it can simply read the space used by the
> root ports. On device tree, there is no entity to figure out that
> enumeration so we don't know how to size the stolen region.
> 
> Three approaches were discussed:
> 1) Enumerating in QEMU. Horribly complex and the last thing we want is a
>    3rd enumeration implementation that ends up out of sync with EDK2 and
>    the kernel (there are frequent issues because of how those existing
>    implementations differ.
> 2) Figure out how to enumerate in kernel. I never put a huge amount of work
>    into this, but it seemed likely to involve a nasty dance with similar
>    very specific code to that EDK2 is carrying and would very challenging
>    to upstream (given the lack of clarity on real use cases for PXBs and
>    DT).
> 3) Hack it based on the control we have which is bus numbers.
>    No one liked this but it worked :)
> 
> The other little wrinkle would be the need to define full bindings for CXL
> on DT + implement a fairly complex kernel stack as equivalent in ACPI
> involves a static table, CEDT, new runtime queries via _DSM and a description
> of various components. Doable, but so far there is no interest on physical
> platforms. Worth noting that for now, the QEMU CXL emulation is all about
> testing and developing the OS stack, not about virtualization (performance
> is terrible except in some very contrived situations!)
> 
> There is only a very simple test in here, because my intent is not to
> duplicate what we have on x86, but just to do a smoke test that everything
> is hooked up.  In general we need much more comprehensive end to end CXL
> tests but that requires a reaonsably stable guest software stack. A few
> people have expressed interest in working on that, but we aren't there yet.
> 
> Note that this series has a very different use case to that in the proposed
> SBSA-ref support:
> https://lore.kernel.org/qemu-devel/20250117034343.26356-1-wangyuquan1236@phytium.com.cn/
> 
> SBSA-ref is a good choice if you want a relatively simple mostly fixed
> configuration.  That works well with the limited host system
> discoverability etc as EDK2 can be build against a known configuration.
> 
> My interest with this support in arm/virt is support host software stack
> development (we have a wide range of contributors, most of whom are working
> on emulation + the kernel support). I care about the weird corners. As such
> I need to be able to bring up variable numbers of host bridges, multiple CXL
> Fixed Memory Windows with varying characteristics (interleave etc), complex
> NUMA topologies with wierd performance characteristics etc. We can do that
> on x86 upstream today, or my gitlab tree. Note that we need arm support
> for some arch specific features in the near future (cache flushing).
> Doing kernel development with this need for flexibility on SBSA-ref is not
> currently practical. SBSA-ref CXL support is an excellent thing, just
> not much use to me for this work.
> 
> Also, we are kicking off some work on DCD virtualization, particularly to
> support inter-host shared memory being presented up into a VM. That
> will need upstream support on arm64 as it is built on top of the existing
> CXL emulation to avoid the need for a separate guest software stack.
> 
> Note this is TCG only - it is possible to support limited use with KVM but
> that needs additional patches not yet ready for upstream.  The challenge
> is interleave - and the solution is don't interleave if you want to run
> with KVM.

Series applied cleanly on top of today's QEMU. And I confirm that
qtest-aarch64/cxl-test passes the test as it should and ndctl cxl test
suite ran fine 11 out of 12 (1 SKIP) on this series again this time tracing
subsystem enabled as Alison suggested. Used the Intel folk cxl/next
kernel.

Tested-by: Itaru Kitayama <itaru.kitayama@fujitsu.com>

Thanks,
Itaru.

> 
> Jonathan Cameron (5):
>   hw/cxl-host: Add an index field to CXLFixedMemoryWindow
>   hw/cxl: Make the CXL fixed memory windows devices.
>   hw/cxl-host: Allow split of establishing memory address and mmio
>     setup.
>   hw/arm/virt: Basic CXL enablement on pci_expander_bridge instances
>     pxb-cxl
>   qtest/cxl: Add aarch64 virt test for CXL
> 
>  include/hw/arm/virt.h     |   4 +
>  include/hw/cxl/cxl.h      |   4 +
>  include/hw/cxl/cxl_host.h |   6 +-
>  hw/acpi/cxl.c             |  76 +++++++--------
>  hw/arm/virt-acpi-build.c  |  34 +++++++
>  hw/arm/virt.c             |  29 ++++++
>  hw/cxl/cxl-host-stubs.c   |   8 +-
>  hw/cxl/cxl-host.c         | 190 ++++++++++++++++++++++++++++++++------
>  hw/i386/pc.c              |  51 +++++-----
>  tests/qtest/cxl-test.c    |  59 +++++++++---
>  tests/qtest/meson.build   |   1 +
>  11 files changed, 353 insertions(+), 109 deletions(-)
> 
> -- 
> 2.48.1
> 
