Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814A01A5BAE
	for <linux-cxl@vger.kernel.org>; Wed, 25 Jun 2025 16:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750867744; cv=none; b=c+BpO/tCfYhFW7myL+M2gi0KRM3BZ3lWnV7KdmJBu37AtvN2c1TnhFI/am9/hLzRK/jYhZpqoar8pPc43qMKFlB2YHzdNYemXPPwgKHvp6BOVHsaXT0cyYexv7s0FMAWR/2A0CKPsT4OThh8E+D2Po6lahdR7Dv2NLHYjZ6amjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750867744; c=relaxed/simple;
	bh=/C8zVnMuoelZJ//ZG8mbohXXqHMlQezzoK3QLAgyxx4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HoWpnzH/zaaEV2brcRW0mfqFZIYwhqDivy6xwf4BHKXsJ8ki16OU4GlVF45HvvBNLaYTGl9jSAeOu4LR3NB4CG+u6nEkRNiriFTv121V0iDvBfnfgJqlGv0M2F40TpcAMfzh0Z6rouY2c3r35wW2mYclpdAEIOnj6KESuFh3d9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bS6FK2zQHz6DL4c;
	Thu, 26 Jun 2025 00:08:53 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 15D991404C4;
	Thu, 26 Jun 2025 00:08:57 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 25 Jun
 2025 18:08:56 +0200
Date: Wed, 25 Jun 2025 17:08:50 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Peter Maydell <peter.maydell@linaro.org>, <linuxarm@huawei.com>
CC: <qemu-devel@nongnu.org>, Fan Ni <fan.ni@samsung.com>, <mst@redhat.com>,
	Zhijian Li <lizhijian@fujitsu.com>, Itaru Kitayama
	<itaru.kitayama@linux.dev>, <linux-cxl@vger.kernel.org>,
	<qemu-arm@nongnu.org>, Yuquan Wang <wangyuquan1236@phytium.com.cn>, Philippe
 =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>, "Alireza Sanaee"
	<alireza.sanaee@huawei.com>, Alex =?ISO-8859-1?Q?Benn=E9e?=
	<alex.bennee@linaro.org>
Subject: Re: [PATCH v15 3/4] hw/arm/virt: Basic CXL enablement on
 pci_expander_bridge instances pxb-cxl
Message-ID: <20250625170850.00005cfe@huawei.com>
In-Reply-To: <20250613182125.00004e5f@huawei.com>
References: <20250612134338.1871023-1-Jonathan.Cameron@huawei.com>
	<20250612134338.1871023-4-Jonathan.Cameron@huawei.com>
	<CAFEAcA-J+vAGfEV67PezA72rUiqpuqTBT=8hJLc1sw+xo3XHWQ@mail.gmail.com>
	<20250613162054.000003cf@huawei.com>
	<CAFEAcA9dHc8werChGk_HzXWsxqv1E4==iDPxRtCmPe9Ndr7nmA@mail.gmail.com>
	<20250613182125.00004e5f@huawei.com>
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
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 13 Jun 2025 18:21:25 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> On Fri, 13 Jun 2025 17:07:24 +0100
> Peter Maydell <peter.maydell@linaro.org> wrote:
> 
> > On Fri, 13 Jun 2025 at 16:20, Jonathan Cameron
> > <Jonathan.Cameron@huawei.com> wrote:  
> > >
> > > On Fri, 13 Jun 2025 13:57:39 +0100
> > > Peter Maydell <peter.maydell@linaro.org> wrote:
> > >    
> > > > On Thu, 12 Jun 2025 at 14:45, Jonathan Cameron
> > > > <Jonathan.Cameron@huawei.com> wrote:    
> > > > >
> > > > > Code based on i386/pc enablement. The memory layout places space for 16
> > > > > host bridge register regions after the GIC_REDIST2 in the extended memmap.
> > > > > The CFMWs are placed above the extended memmap.
> > > > >
> > > > > Only create the CEDT table if cxl=on set for the machine.
> > > > >
> > > > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > >
> > > > > ---
> > > > > v15: No changes.
> > > > > ---
> > > > >  include/hw/arm/virt.h    |  4 ++++
> > > > >  hw/arm/virt-acpi-build.c | 34 ++++++++++++++++++++++++++++++++++
> > > > >  hw/arm/virt.c            | 29 +++++++++++++++++++++++++++++
> > > > >  3 files changed, 67 insertions(+)    
> > > >    
> > > Hi Peter,
> > >
> > > Thanks for reviewing.
> > >    
> > > > Can we have some user-facing documentation, please?
> > > > (docs/system/arm/virt.rst -- can just be a brief mention
> > > > and link to docs/system/devices/cxl.rst if you want to put the
> > > > examples of aarch64 use in there.)    
> > >
> > > Given the examples should look exactly like those for x86/pc, do we need
> > > extra examples in cxl.rst? I guess I can add one simple arm/virt example
> > > in a follow up patch without bloating that file too badly..    
> > 
> > That's fine too -- if the answer is "all these command lines work
> > for aarch64 too", then you can just say that in cxl.rst.  
> 
> I'll put an example in just to avoid people using a default
> command line and getting an a55 with too small a PA range.
> 
> >   
> > > Is the following sufficient for the board specific docs?
> > >
> > > diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
> > > index 6a719b9586..10cbffc8a7 100644
> > > --- a/docs/system/arm/virt.rst
> > > +++ b/docs/system/arm/virt.rst
> > > @@ -31,6 +31,7 @@ Supported devices
> > >  The virt board supports:
> > >
> > >  - PCI/PCIe devices
> > > +- CXL Fixed memory windows, root bridges and devices.
> > >  - Flash memory
> > >  - Either one or two PL011 UARTs for the NonSecure World
> > >  - An RTC
> > > @@ -189,6 +190,14 @@ ras
> > >  acpi
> > >    Set ``on``/``off``/``auto`` to enable/disable ACPI.
> > >
> > > +cxl
> > > +  Set  ``on``/``off`` to enable/disable CXL. More details in
> > > +  :doc:`../devices/cxl`. The default is off.
> > > +
> > > +cxl-fmw
> > > +  Array of CXL fixed memory windows describing fixed address routing to
> > > +  target CXL host bridges. See :doc:`../devices/cxl`.
> > > +
> > >  dtb-randomness
> > >    Set ``on``/``off`` to pass random seeds via the guest DTB
> > >    rng-seed and kaslr-seed nodes (in both "/chosen" and    
> > 
> > Looks OK.
> >   
> > > >    
> > > > > @@ -220,6 +223,7 @@ static const MemMapEntry base_memmap[] = {
> > > > >  static MemMapEntry extended_memmap[] = {
> > > > >      /* Additional 64 MB redist region (can contain up to 512 redistributors) */
> > > > >      [VIRT_HIGH_GIC_REDIST2] =   { 0x0, 64 * MiB },
> > > > > +    [VIRT_CXL_HOST] =           { 0x0, 64 * KiB * 16 }, /* 16 UID */    
> > > >
> > > > This is going to shuffle the memory map around, even if CXL
> > > > isn't enabled, which will break migration compatibility.
> > > > You need to do something to ensure that the CXL region isn't
> > > > included in the calculations of the base addresses for these
> > > > regions if CXL isn't enabled.
> > > >    
> > >
> > > It doesn't move any existing stuff because these are naturally aligned
> > > regions so this is in a gap before the PCIE ECAM region.    
> > 
> > Is that true even when we have the maximum number of CPUs and
> > so the max number of redistributors in that VIRT_HIGH_GIC_REDIST2
> > region ?  
> 
> Yes.   The gap is between that and the ECAM window.  The CXL RCRB
> stuff doesn't move whether or not that is there.  Making sure it
> is present does make it easier to see the gap though - hence example below.
> 
> 
> >   
> > > > >      [VIRT_HIGH_PCIE_ECAM] =     { 0x0, 256 * MiB },
> > > > >      /* Second PCIe window */
> > > > >      [VIRT_HIGH_PCIE_MMIO] =     { 0x0, DEFAULT_HIGH_PCIE_MMIO_SIZE },    
> > > >
> > > > If you're OK with having the CXL host region at the end of the
> > > > list then that's a simpler way to avoid its presence disturbing
> > > > the layout of the existing regions, but you might not like it
> > > > being at such a high physaddr.    
> > >
> > > From what I recall a higher address isn't a problem I just wanted to not waste any
> > > PA space at all so used the gap.
> > >
> > > Chunk of /proc/iomem with a random test case (in first case with the cxl bits
> > > removed as obvious that doesn't start until this patch is in place).
> > > Need more than 123 cpus to make the second gicv3 redist appear
> > > (I've no idea why that number I just printed the threshold where
> > > it was calculated to find out what I needed to wait for boot on).    
> > 
> > It's 123 because that's the most redistributors we can fit into
> > the lower redistributor region. (We didn't really allow enough
> > space in the lower memory map, which is why we need this awkward
> > split setup.
> > 
> > (I have to run now, will look at the rest of the email next week.)  
> Thanks and have a good weekend.

Hi Peter,

I'll post a v16 with the changes discussed and for this patch include a few
comments on what we didn't yet resolve in this thread.

Thanks,

Jonathan

> 
> J
> > 
> > -- PMM  
> 
> 

