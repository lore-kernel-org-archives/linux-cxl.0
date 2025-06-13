Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800052E11B1
	for <linux-cxl@vger.kernel.org>; Fri, 13 Jun 2025 17:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749835291; cv=none; b=Y5/OoQQBBT98TJUeBTNsyqgdX6Vlk8gIORnPxsF9z9qEEPKw1oL4jdQIjAV5wdMCZVwIQoSt5mJSrD5XZ190g4ymrrSNbQfvdQcKw9TEpqgN7nztKVnwjDrsahkeL89mUXkzCLFrHwVnCrxDGWzTnyYMkZba3cWrtmvCfzWPj4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749835291; c=relaxed/simple;
	bh=7Si/bGOF6FHwxjdL6wUOLUl98HnD7E4p/4ENKCfWYVg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L7V7kyzB7t6wUyF5vK679zO4CxPvEzCCdaLSOeI2bBzdSjAhfdu6FnJLAna47Q5QeqwHtNH0dP3xRxzIYx2v9KogeCTZjNUcqeSeKVPZPjXRf3K47PhBDH+t98Yvk6j6LD0N9K8SMluYpjatvIPwTvDcc2gNL1qpudY9u9dfUuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bJmKV07Vxz6L51g;
	Sat, 14 Jun 2025 01:17:02 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 447A1140371;
	Sat, 14 Jun 2025 01:21:27 +0800 (CST)
Received: from localhost (10.122.19.247) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 13 Jun
 2025 19:21:26 +0200
Date: Fri, 13 Jun 2025 18:21:25 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: <qemu-devel@nongnu.org>, Fan Ni <fan.ni@samsung.com>, <mst@redhat.com>,
	Zhijian Li <lizhijian@fujitsu.com>, Itaru Kitayama
	<itaru.kitayama@linux.dev>, <linuxarm@huawei.com>,
	<linux-cxl@vger.kernel.org>, <qemu-arm@nongnu.org>, Yuquan Wang
	<wangyuquan1236@phytium.com.cn>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
	<philmd@linaro.org>, Alireza Sanaee <alireza.sanaee@huawei.com>, Alex
 =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v15 3/4] hw/arm/virt: Basic CXL enablement on
 pci_expander_bridge instances pxb-cxl
Message-ID: <20250613182125.00004e5f@huawei.com>
In-Reply-To: <CAFEAcA9dHc8werChGk_HzXWsxqv1E4==iDPxRtCmPe9Ndr7nmA@mail.gmail.com>
References: <20250612134338.1871023-1-Jonathan.Cameron@huawei.com>
	<20250612134338.1871023-4-Jonathan.Cameron@huawei.com>
	<CAFEAcA-J+vAGfEV67PezA72rUiqpuqTBT=8hJLc1sw+xo3XHWQ@mail.gmail.com>
	<20250613162054.000003cf@huawei.com>
	<CAFEAcA9dHc8werChGk_HzXWsxqv1E4==iDPxRtCmPe9Ndr7nmA@mail.gmail.com>
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

On Fri, 13 Jun 2025 17:07:24 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Fri, 13 Jun 2025 at 16:20, Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Fri, 13 Jun 2025 13:57:39 +0100
> > Peter Maydell <peter.maydell@linaro.org> wrote:
> >  
> > > On Thu, 12 Jun 2025 at 14:45, Jonathan Cameron
> > > <Jonathan.Cameron@huawei.com> wrote:  
> > > >
> > > > Code based on i386/pc enablement. The memory layout places space for 16
> > > > host bridge register regions after the GIC_REDIST2 in the extended memmap.
> > > > The CFMWs are placed above the extended memmap.
> > > >
> > > > Only create the CEDT table if cxl=on set for the machine.
> > > >
> > > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > >
> > > > ---
> > > > v15: No changes.
> > > > ---
> > > >  include/hw/arm/virt.h    |  4 ++++
> > > >  hw/arm/virt-acpi-build.c | 34 ++++++++++++++++++++++++++++++++++
> > > >  hw/arm/virt.c            | 29 +++++++++++++++++++++++++++++
> > > >  3 files changed, 67 insertions(+)  
> > >  
> > Hi Peter,
> >
> > Thanks for reviewing.
> >  
> > > Can we have some user-facing documentation, please?
> > > (docs/system/arm/virt.rst -- can just be a brief mention
> > > and link to docs/system/devices/cxl.rst if you want to put the
> > > examples of aarch64 use in there.)  
> >
> > Given the examples should look exactly like those for x86/pc, do we need
> > extra examples in cxl.rst? I guess I can add one simple arm/virt example
> > in a follow up patch without bloating that file too badly..  
> 
> That's fine too -- if the answer is "all these command lines work
> for aarch64 too", then you can just say that in cxl.rst.

I'll put an example in just to avoid people using a default
command line and getting an a55 with too small a PA range.

> 
> > Is the following sufficient for the board specific docs?
> >
> > diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
> > index 6a719b9586..10cbffc8a7 100644
> > --- a/docs/system/arm/virt.rst
> > +++ b/docs/system/arm/virt.rst
> > @@ -31,6 +31,7 @@ Supported devices
> >  The virt board supports:
> >
> >  - PCI/PCIe devices
> > +- CXL Fixed memory windows, root bridges and devices.
> >  - Flash memory
> >  - Either one or two PL011 UARTs for the NonSecure World
> >  - An RTC
> > @@ -189,6 +190,14 @@ ras
> >  acpi
> >    Set ``on``/``off``/``auto`` to enable/disable ACPI.
> >
> > +cxl
> > +  Set  ``on``/``off`` to enable/disable CXL. More details in
> > +  :doc:`../devices/cxl`. The default is off.
> > +
> > +cxl-fmw
> > +  Array of CXL fixed memory windows describing fixed address routing to
> > +  target CXL host bridges. See :doc:`../devices/cxl`.
> > +
> >  dtb-randomness
> >    Set ``on``/``off`` to pass random seeds via the guest DTB
> >    rng-seed and kaslr-seed nodes (in both "/chosen" and  
> 
> Looks OK.
> 
> > >  
> > > > @@ -220,6 +223,7 @@ static const MemMapEntry base_memmap[] = {
> > > >  static MemMapEntry extended_memmap[] = {
> > > >      /* Additional 64 MB redist region (can contain up to 512 redistributors) */
> > > >      [VIRT_HIGH_GIC_REDIST2] =   { 0x0, 64 * MiB },
> > > > +    [VIRT_CXL_HOST] =           { 0x0, 64 * KiB * 16 }, /* 16 UID */  
> > >
> > > This is going to shuffle the memory map around, even if CXL
> > > isn't enabled, which will break migration compatibility.
> > > You need to do something to ensure that the CXL region isn't
> > > included in the calculations of the base addresses for these
> > > regions if CXL isn't enabled.
> > >  
> >
> > It doesn't move any existing stuff because these are naturally aligned
> > regions so this is in a gap before the PCIE ECAM region.  
> 
> Is that true even when we have the maximum number of CPUs and
> so the max number of redistributors in that VIRT_HIGH_GIC_REDIST2
> region ?

Yes.   The gap is between that and the ECAM window.  The CXL RCRB
stuff doesn't move whether or not that is there.  Making sure it
is present does make it easier to see the gap though - hence example below.


> 
> > > >      [VIRT_HIGH_PCIE_ECAM] =     { 0x0, 256 * MiB },
> > > >      /* Second PCIe window */
> > > >      [VIRT_HIGH_PCIE_MMIO] =     { 0x0, DEFAULT_HIGH_PCIE_MMIO_SIZE },  
> > >
> > > If you're OK with having the CXL host region at the end of the
> > > list then that's a simpler way to avoid its presence disturbing
> > > the layout of the existing regions, but you might not like it
> > > being at such a high physaddr.  
> >
> > From what I recall a higher address isn't a problem I just wanted to not waste any
> > PA space at all so used the gap.
> >
> > Chunk of /proc/iomem with a random test case (in first case with the cxl bits
> > removed as obvious that doesn't start until this patch is in place).
> > Need more than 123 cpus to make the second gicv3 redist appear
> > (I've no idea why that number I just printed the threshold where
> > it was calculated to find out what I needed to wait for boot on).  
> 
> It's 123 because that's the most redistributors we can fit into
> the lower redistributor region. (We didn't really allow enough
> space in the lower memory map, which is why we need this awkward
> split setup.
> 
> (I have to run now, will look at the rest of the email next week.)
Thanks and have a good weekend.

J
> 
> -- PMM

