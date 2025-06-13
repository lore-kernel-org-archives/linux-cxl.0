Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C84C2E11BF
	for <linux-cxl@vger.kernel.org>; Fri, 13 Jun 2025 15:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749829659; cv=none; b=rY8fjEmCTRQ1zn9hmAdiTqruUaOoaMKhxPfoBI72x83fCZDbIBmtt0nOpRpBcpTdR2x5rLBVdL7kocHDeI0k8qaDW3UVrE18WaYWcGuFjxcpYtCRpklpZpLmqnAjHkLiDDiJaHjvWZssBFdn7TL0DRigX1s8EWw0HgKQ4cjMsHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749829659; c=relaxed/simple;
	bh=eZelsH0PU0Bn64yY9imz61L1R2Rna31pdQC3NSlOXLE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FyF3TxA11+BcKWP+O221SUd1+Jno63CPsHg4/Qwy03OmcZax4qYs1ll8+4V2YX6xs7vzKdaGqmf79dLJ+kFgnLBOmzJU1tttiuVWNnnSQ1TcBaXInd4vAWtMoo8QxdlFHsFhQQ8edUkCkrb/Kti4wyNKpGinklW+OfZBgTvDOI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bJkHx6Hrnz6L4rw;
	Fri, 13 Jun 2025 23:45:33 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 7C157140159;
	Fri, 13 Jun 2025 23:47:32 +0800 (CST)
Received: from localhost (10.122.19.247) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 13 Jun
 2025 17:47:31 +0200
Date: Fri, 13 Jun 2025 16:47:30 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Itaru Kitayama <itaru.kitayama@linux.dev>
CC: <qemu-devel@nongnu.org>, Fan Ni <fan.ni@samsung.com>, Peter Maydell
	<peter.maydell@linaro.org>, <mst@redhat.com>, Zhijian Li
	<lizhijian@fujitsu.com>, <linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>,
	<qemu-arm@nongnu.org>, Yuquan Wang <wangyuquan1236@phytium.com.cn>, Philippe
 =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>, Alireza Sanaee
	<alireza.sanaee@huawei.com>, Alex =?ISO-8859-1?Q?Benn=E9e?=
	<alex.bennee@linaro.org>
Subject: Re: [PATCH v15 0/4] arm/virt: CXL support via pxb_cxl
Message-ID: <20250613164730.00004d58@huawei.com>
In-Reply-To: <aEuyFHlk7t7wiLvU@vm4>
References: <20250612134338.1871023-1-Jonathan.Cameron@huawei.com>
	<aEuyFHlk7t7wiLvU@vm4>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 13 Jun 2025 14:07:32 +0900
Itaru Kitayama <itaru.kitayama@linux.dev> wrote:

> On Thu, Jun 12, 2025 at 02:43:34PM +0100, Jonathan Cameron wrote:
> > v15:
> >   - Split the address map calculations and mmio setup into separate
> >     functions in patch 2, allowing v14 patch 3 to be dropped as not
> >     x86 and arm make the same calls.  Note I felt this was a sufficient
> >     change to trigger dropping tags. (Zhijian Li)
> >   - A few other minor tweaks.
> >   - TLB issue mentioned in v14 now fixed upstream so dropped reference
> >     in this cover letter.
> > 
> > Thanks to Itaru Kitayama and Zhijian Li for testing + reviews.
> > 
> > Updated cover letter
> > 
> > Back in 2022, this series stalled on the absence of a solution to device
> > tree support for PCI Expander Bridges (PXB) and we ended up only having
> > x86 support upstream. I've been carrying the arm64 support out of tree
> > since then, with occasional nasty surprises (e.g. UNIMP + DT issue seen
> > a few weeks ago) and a fair number of fiddly rebases.
> > gitlab.com/jic23/qemu cxl-<latest date>.  Will update shortly with this
> > series.
> > 
> > A recent discussion with Peter Maydell indicated that there are various
> > other ACPI only features now, so in general he might be more relaxed
> > about DT support being necessary. The upcoming vSMMUv3 support would
> > run into this problem as well.
> > 
> > I presented the background to the PXB issue at Linaro connect 2022. In
> > short the issue is that PXBs steal MMIO space from the main PCI root
> > bridge. The challenge is knowing how much to steal.
> > 
> > On ACPI platforms, we can rely on EDK2 to perform an enumeration and
> > configuration of the PCI topology and QEMU can update the ACPI tables
> > after EDK2 has done this when it can simply read the space used by the
> > root ports. On device tree, there is no entity to figure out that
> > enumeration so we don't know how to size the stolen region.
> > 
> > Three approaches were discussed:
> > 1) Enumerating in QEMU. Horribly complex and the last thing we want is a
> >    3rd enumeration implementation that ends up out of sync with EDK2 and
> >    the kernel (there are frequent issues because of how those existing
> >    implementations differ.
> > 2) Figure out how to enumerate in kernel. I never put a huge amount of work
> >    into this, but it seemed likely to involve a nasty dance with similar
> >    very specific code to that EDK2 is carrying and would very challenging
> >    to upstream (given the lack of clarity on real use cases for PXBs and
> >    DT).
> > 3) Hack it based on the control we have which is bus numbers.
> >    No one liked this but it worked :)
> > 
> > The other little wrinkle would be the need to define full bindings for CXL
> > on DT + implement a fairly complex kernel stack as equivalent in ACPI
> > involves a static table, CEDT, new runtime queries via _DSM and a description
> > of various components. Doable, but so far there is no interest on physical
> > platforms. Worth noting that for now, the QEMU CXL emulation is all about
> > testing and developing the OS stack, not about virtualization (performance
> > is terrible except in some very contrived situations!)
> > 
> > There is only a very simple test in here, because my intent is not to
> > duplicate what we have on x86, but just to do a smoke test that everything
> > is hooked up.  In general we need much more comprehensive end to end CXL
> > tests but that requires a reaonsably stable guest software stack. A few
> > people have expressed interest in working on that, but we aren't there yet.
> > 
> > Note that this series has a very different use case to that in the proposed
> > SBSA-ref support:
> > https://lore.kernel.org/qemu-devel/20250117034343.26356-1-wangyuquan1236@phytium.com.cn/
> > 
> > SBSA-ref is a good choice if you want a relatively simple mostly fixed
> > configuration.  That works well with the limited host system
> > discoverability etc as EDK2 can be build against a known configuration.
> > 
> > My interest with this support in arm/virt is support host software stack
> > development (we have a wide range of contributors, most of whom are working
> > on emulation + the kernel support). I care about the weird corners. As such
> > I need to be able to bring up variable numbers of host bridges, multiple CXL
> > Fixed Memory Windows with varying characteristics (interleave etc), complex
> > NUMA topologies with wierd performance characteristics etc. We can do that
> > on x86 upstream today, or my gitlab tree. Note that we need arm support
> > for some arch specific features in the near future (cache flushing).
> > Doing kernel development with this need for flexibility on SBSA-ref is not
> > currently practical. SBSA-ref CXL support is an excellent thing, just
> > not much use to me for this work.
> > 
> > Also, we are kicking off some work on DCD virtualization, particularly to
> > support inter-host shared memory being presented up into a VM. That
> > will need upstream support on arm64 as it is built on top of the existing
> > CXL emulation to avoid the need for a separate guest software stack.
> > 
> > Note this is TCG only - it is possible to support limited use with KVM but
> > that needs additional patches not yet ready for upstream.  The challenge
> > is interleave - and the solution is don't interleave if you want to run
> > with KVM.  
> 
> One of the ndctl:cxl tests fails (other tests ran ok):

Whilst interesting and needing debugging I'd just like to point out that those
tests are not running on the qemu CXL emulation at all, but on cxl test which
is mocking stuff in the kernel.   I know you know that but it might not
be obvious to anyone seeing a bug report on this thread!

Jonathan


> 
> # meson test cxl-region-sysfs.sh
> ninja: Entering directory `/root/ndctl/build'
> [1/55] Generating version.h with a custom command
> [  706.564783][ T2080] calling  cxl_port_init+0x0/0xfe0 [cxl_port] @ 2080
> [  706.566861][ T2080] initcall cxl_port_init+0x0/0xfe0 [cxl_port] returned 0 after 1735 usecs
> [  706.586457][ T2080] calling  cxl_acpi_init+0x0/0xfe0 [cxl_acpi] @ 2080
> [  706.625690][ T2080] probe of port1 returned 0 after 25381 usecs
> [  706.626634][ T2080]  pci0000:bf: host supports CXL
> [  706.653573][ T2080] probe of port2 returned 0 after 25631 usecs
> [  706.655164][ T2080]  pci0000:35: host supports CXL
> [  706.662409][ T2080] probe of ACPI0017:00 returned 0 after 74464 usecs
> [  706.663150][ T2080] initcall cxl_acpi_init+0x0/0xfe0 [cxl_acpi] returned 0 after 76306 usecs
> [  706.690482][ T2080] calling  cxl_pmem_init+0x0/0xfd0 [cxl_pmem] @ 2080
> [  706.695324][ T2080] probe of ndbus0 returned 0 after 1496 usecs
> [  706.699217][ T2080] probe of nvdimm-bridge0 returned 0 after 6705 usecs
> [  706.702372][ T2080] initcall cxl_pmem_init+0x0/0xfd0 [cxl_pmem] returned 0 after 11576 usecs
> [  706.717668][ T2080] calling  cxl_mem_driver_init+0x0/0xfe0 [cxl_mem] @ 2080
> [  706.758561][ T2080] probe of port3 returned 0 after 34188 usecs
> [  706.767080][ T2080] cxl_nvdimm pmem11: GPF: could not set dirty shutdown state
> [  706.779392][ T2080] probe of nmem0 returned 0 after 1083 usecs
> [  706.782181][ T2080] probe of pmem11 returned 0 after 15516 usecs
> [  706.826941][ T2080] probe of endpoint4 returned 0 after 42630 usecs
> [  706.827987][ T2080] probe of mem11 returned 0 after 108475 usecs
> [  706.878052][ T2080] probe of port5 returned 0 after 41354 usecs
> [  706.938260][ T2080] probe of endpoint6 returned 0 after 46831 usecs
> [  706.939223][ T2080] probe of mem12 returned 0 after 105104 usecs
> [  706.994611][ T2080] probe of endpoint7 returned 0 after 49337 usecs
> [  706.995790][ T2080] probe of mem13 returned 0 after 53632 usecs
> [  707.004334][ T2080] cxl_nvdimm pmem14: GPF: could not set dirty shutdown state
> [  707.017782][ T2080] probe of nmem1 returned 0 after 1115 usecs
> [  707.019324][ T2080] probe of pmem14 returned 0 after 14920 usecs
> [  707.072148][ T2080] probe of endpoint8 returned 0 after 50887 usecs
> [  707.073367][ T2080] probe of mem14 returned 0 after 71279 usecs
> [  707.079062][ T2080] initcall cxl_mem_driver_init+0x0/0xfe0 [cxl_mem] returned 0 after 361073 usecs
> [  707.111533][ T2080] calling  cxl_test_init+0x0/0xc88 [cxl_test] @ 2080
> [  708.001403][ T2080] platform cxl_host_bridge.0: Unsupported platform config, mixed Virtual Host and Restricted CXL Host hierarchy.
> [  708.002032][ T2080] platform cxl_host_bridge.1: Unsupported platform config, mixed Virtual Host and Restricted CXL Host hierarchy.
> [  708.010988][ T2080] platform cxl_host_bridge.2: Unsupported platform config, mixed Virtual Host and Restricted CXL Host hierarchy.
> [  708.011963][ T2080] platform cxl_host_bridge.3: Unsupported platform config, mixed Virtual Host and Restricted CXL Host hierarchy.
> [  708.034604][ T2080] platform cxl_host_bridge.0: Unsupported platform config, mixed Virtual Host and Restricted CXL Host hierarchy.
> [  708.056775][ T2080] probe of port10 returned 0 after 20555 usecs
> [  708.057814][ T2080] platform cxl_host_bridge.0: host supports CXL
> [  708.062226][ T2080] platform cxl_host_bridge.1: Unsupported platform config, mixed Virtual Host and Restricted CXL Host hierarchy.
> [  708.081857][ T2080] probe of port11 returned 0 after 18696 usecs
> [  708.085821][ T2080] platform cxl_host_bridge.1: host supports CXL
> [  708.086496][ T2080] platform cxl_host_bridge.2: Unsupported platform config, mixed Virtual Host and Restricted CXL Host hierarchy.
> [  708.538268][ T2080] probe of port12 returned 0 after 450064 usecs
> [  708.563248][ T2080] platform cxl_host_bridge.2: host supports CXL
> [  708.563875][ T2080] platform cxl_host_bridge.3: host supports CXL (restricted)
> [  708.803640][ T2080] probe of ndbus1 returned 0 after 87373 usecs
> [  708.817241][ T2080] probe of nvdimm-bridge1 returned 0 after 182992 usecs
> [  708.839172][ T2080] probe of cxl_acpi.0 returned 0 after 843615 usecs
> [  709.026867][  T503] cxl_mock_mem cxl_mem.0: CXL MCE unsupported
> [  709.240435][  T502] cxl_mock_mem cxl_mem.1: CXL MCE unsupported
> [  709.263055][  T499] cxl_mock_mem cxl_mem.2: CXL MCE unsupported
> [  709.317257][  T503] probe of port13 returned 0 after 57147 usecs
> [  709.442524][  T498] cxl_mock_mem cxl_mem.3: CXL MCE unsupported
> [  709.495789][  T499] probe of port15 returned 0 after 57022 usecs
> [  709.538513][ T1514] cxl_mock_mem cxl_mem.5: CXL MCE unsupported
> [  709.553021][  T503] probe of nmem3 returned 0 after 12329 usecs
> [  709.555876][  T503] probe of pmem0 returned 0 after 54954 usecs
> [  709.567823][  T499] probe of nmem2 returned 0 after 27577 usecs
> [  709.569359][  T499] probe of pmem2 returned 0 after 64505 usecs
> [  709.603845][  T497] cxl_mock_mem cxl_mem.4: CXL MCE unsupported
> [  709.626487][   T12] cxl_mock_mem cxl_mem.6: CXL MCE unsupported
> [  709.639194][  T502] probe of port14 returned 0 after 255539 usecs
> [  709.662671][  T503] probe of region2 returned 6 after 421 usecs
> [  709.664855][  T503] cxl_mock_mem cxl_mem.0: Extended linear cache calculation failed rc:-2
> [  709.694975][  T503] probe of endpoint16 returned 0 after 100427 usecs
> [  709.698678][  T503] probe of mem0 returned 0 after 516964 usecs
> [  709.752821][   T49] cxl_mock_mem cxl_mem.7: CXL MCE unsupported
> [  709.782050][  T499] probe of endpoint17 returned 0 after 102692 usecs
> [  709.814422][  T499] probe of mem2 returned 0 after 539843 usecs
> [  709.859496][  T497] probe of nmem4 returned 0 after 74368 usecs
> [  709.860064][  T497] probe of pmem5 returned 0 after 120134 usecs
> [  709.862431][  T499] probe of cxl_mem.2 returned 0 after 686512 usecs
> [  709.863290][  T503] probe of cxl_mem.0 returned 0 after 892734 usecs
> [  709.870924][   T30] cxl_mock_mem cxl_mem.9: CXL MCE unsupported
> [  709.876631][ T2080] initcall cxl_test_init+0x0/0xc88 [cxl_test] returned 0 after 2764528 usecs
> [  709.886776][  T498] probe of port18 returned 0 after 168122 usecs
> [  709.900934][  T500] cxl_mock_mem cxl_mem.8: CXL MCE unsupported
> [  709.946498][ T1514] probe of nmem5 returned 0 after 9462 usecs
> [  709.947381][ T1514] probe of pmem4 returned 0 after 14445 usecs
> [  709.970022][   T12] probe of nmem6 returned 0 after 32603 usecs
> [  709.978337][  T498] probe of nmem7 returned 0 after 35875 usecs
> [  709.986071][  T498] probe of pmem3 returned 0 after 46583 usecs
> [  710.010717][   T12] probe of pmem6 returned 0 after 75369 usecs
> [  710.014337][  T501] cxl_mock_mem cxl_rcd.10: CXL MCE unsupported
> [  710.040337][  T502] probe of nmem8 returned 0 after 29862 usecs
> [  710.059653][  T502] probe of pmem1 returned 0 after 88935 usecs
> [  710.079573][   T12] probe of endpoint23 returned 0 after 49198 usecs
> [  710.097280][   T30] probe of port21 returned 0 after 120461 usecs
> [  710.097393][   T49] probe of nmem9 returned 0 after 26437 usecs
> [  710.101820][   T49] probe of pmem7 returned 0 after 36944 usecs
> [  710.106202][   T12] probe of mem6 returned 0 after 452293 usecs
> [  710.130816][   T12] probe of cxl_mem.6 returned 0 after 669975 usecs
> [  710.133959][  T500] probe of nmem10 returned 0 after 12351 usecs
> [  710.170179][  T500] probe of pmem9 returned 0 after 50316 usecs
> [  710.183178][  T498] probe of endpoint22 returned 0 after 160579 usecs
> [  710.208790][  T498] probe of mem3 returned 0 after 760551 usecs
> [  710.212463][  T501] probe of endpoint24 returned 0 after 149792 usecs
> [  710.236975][  T497] probe of dax2.0 returned 0 after 118646 usecs
> [  710.240952][  T497] probe of dax_region2 returned 0 after 166940 usecs
> [  710.242545][  T498] probe of cxl_mem.3 returned 0 after 917362 usecs
> [  710.256278][   T30] probe of nmem11 returned 0 after 45572 usecs
> [  710.257079][   T30] probe of pmem8 returned 0 after 105691 usecs
> [  710.259332][  T501] probe of mem10 returned 0 after 218194 usecs
> [  710.265545][  T497] probe of region2 returned 0 after 225563 usecs
> [  710.269232][ T1514] probe of endpoint20 returned 0 after 320269 usecs
> [  710.282299][  T497] probe of endpoint19 returned 0 after 421116 usecs
> [  710.283234][  T497] probe of mem5 returned 0 after 642268 usecs
> [  710.304734][ T1514] probe of mem4 returned 0 after 762768 usecs
> [  710.322940][   T49] probe of endpoint26 returned 0 after 117975 usecs
> [  710.324643][   T49] probe of mem7 returned 0 after 558032 usecs
> [  710.336434][  T501] probe of cxl_rcd.10 returned 0 after 414904 usecs
> [  710.339624][  T497] probe of cxl_mem.4 returned 0 after 957535 usecs
> [  710.400496][ T1514] probe of cxl_mem.5 returned 0 after 996364 usecs
> [  710.450320][   T49] probe of cxl_mem.7 returned 0 after 842769 usecs
> [  710.648851][  T500] probe of endpoint25 returned 0 after 477479 usecs
> [  710.659334][  T500] probe of mem9 returned 0 after 690185 usecs
> [  710.706030][  T500] probe of cxl_mem.8 returned 0 after 917194 usecs
> [  711.162896][   T30] probe of endpoint28 returned 0 after 493899 usecs
> [  711.227336][   T30] probe of mem8 returned 0 after 1278462 usecs
> [  711.325568][  T502] probe of endpoint27 returned 0 after 929403 usecs
> [  711.356687][  T502] probe of mem1 returned 0 after 2101415 usecs
> [  711.531055][   T30] probe of cxl_mem.9 returned 0 after 1707787 usecs
> [  711.554073][  T502] probe of cxl_mem.1 returned 0 after 2425696 usecs
> [  724.421245][ T2077] probe of region5 returned 6 after 262 usecs
> 1/1 ndctl:cxl / cxl-region-sysfs.sh        FAIL            18.22s   exit status 1
> >>> TEST_PATH=/root/ndctl/build/test ASAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1 LD_LIBRARY_PATH=/root/ndctl/build/daxctl/lib:/root/ndctl/build/cxl/lib:/root/ndctl/build/ndctl/lib DAXCTL=/root/ndctl/build/daxctl/daxctl DATA_PATH=/root/ndctl/test NDCTL=/root/ndctl/build/ndctl/ndctl MESON_TEST_ITERATION=1 UBSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 MSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 MALLOC_PERTURB_=123 /bin/bash /root/ndctl/test/cxl-region-sysfs.sh  
> 
> The kernel (the cxl_test kernel module) is built off of cxl/next which
> has Jonathan's fix to the cxl_test seen on arm64.
> Could the experts take a look at this issue?
> 
> Thanks,
> Itaru.
> 
> > 
> > Jonathan Cameron (4):
> >   hw/cxl-host: Add an index field to CXLFixedMemoryWindow
> >   hw/cxl: Make the CXL fixed memory windows devices.
> >   hw/arm/virt: Basic CXL enablement on pci_expander_bridge instances
> >     pxb-cxl
> >   qtest/cxl: Add aarch64 virt test for CXL
> > 
> >  include/hw/arm/virt.h     |   4 +
> >  include/hw/cxl/cxl.h      |   5 +-
> >  include/hw/cxl/cxl_host.h |   5 +-
> >  hw/acpi/cxl.c             |  76 +++++++++--------
> >  hw/arm/virt-acpi-build.c  |  34 ++++++++
> >  hw/arm/virt.c             |  29 +++++++
> >  hw/cxl/cxl-host-stubs.c   |   7 +-
> >  hw/cxl/cxl-host.c         | 170 +++++++++++++++++++++++++++++++-------
> >  hw/i386/pc.c              |  50 +++++------
> >  tests/qtest/cxl-test.c    |  59 ++++++++++---
> >  tests/qtest/meson.build   |   1 +
> >  11 files changed, 330 insertions(+), 110 deletions(-)
> > 
> > -- 
> > 2.48.1
> >   

