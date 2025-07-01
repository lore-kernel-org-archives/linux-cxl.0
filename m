Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64070182B4
	for <linux-cxl@vger.kernel.org>; Tue,  1 Jul 2025 15:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751385150; cv=none; b=leI8wf/QTA1MoxZIRmDySo0vCQM/H9l7mpIqMxJTyTqDJuXS5XcyABuRYt0iAjz6pOD0hmwTeDrrsEoqtqZY7ueNomlIljLtZ7FTRbyW+/28Tatwmn8wvFgbBYKYMqWbl4L+FP1AInUeYmVXIWx6ENy8nNBJYlJW8EXZoOM5QnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751385150; c=relaxed/simple;
	bh=ZP3Kpx7cQj3KYS51xfys2ciSpqSvyZqPV+IRD1I42i0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bVrSRM/pCXbk5dHQDT66BGUdkmBV73+YnkOqwrYEh7ptyJsdsfI7D7JvgFEu13+5yZ98ilkJrMmDDlnlkqdeR/qTXvURA1MgbqcDh84EEyobIvjeIKJ/z3mvQIyXLxfhwYn0hQf4JdpMWDLkd0Ne4M9U6u6lcK+URF6kdntuF+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bWnZV4npGz6M4Hg;
	Tue,  1 Jul 2025 23:51:30 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id EF2DF14011A;
	Tue,  1 Jul 2025 23:52:24 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 1 Jul
 2025 17:52:24 +0200
Date: Tue, 1 Jul 2025 16:52:22 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Eric Auger <eric.auger@redhat.com>
CC: <qemu-devel@nongnu.org>, Fan Ni <fan.ni@samsung.com>, Peter Maydell
	<peter.maydell@linaro.org>, <mst@redhat.com>, Zhijian Li
	<lizhijian@fujitsu.com>, Itaru Kitayama <itaru.kitayama@linux.dev>,
	<linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>, <qemu-arm@nongnu.org>,
	"Yuquan Wang" <wangyuquan1236@phytium.com.cn>, Philippe
 =?ISO-8859-1?Q?Mathieu-Dau?= =?ISO-8859-1?Q?d=E9?= <philmd@linaro.org>, Alex
 =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH qemu v16 3/5] hw/arm/virt: Basic CXL enablement on
 pci_expander_bridge instances pxb-cxl
Message-ID: <20250701165222.0000068f@huawei.com>
In-Reply-To: <128e59be-4038-4a19-8cca-3be3d6446e0e@redhat.com>
References: <20250625161926.549812-1-Jonathan.Cameron@huawei.com>
	<20250625161926.549812-4-Jonathan.Cameron@huawei.com>
	<128e59be-4038-4a19-8cca-3be3d6446e0e@redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 1 Jul 2025 17:34:36 +0200
Eric Auger <eric.auger@redhat.com> wrote:

> Hi Jonathan,
> 
> On 6/25/25 6:19 PM, Jonathan Cameron via wrote:
> > Code based on i386/pc enablement.
> > The memory layout places space for 16 host bridge register regions after
> > the GIC_REDIST2 in the extended memmap. This is a hole in the current
> > map so adding them here has no impact on placement of other memory regions
> > (tested with enough CPUs for GIC_REDIST2 to be in use.)
> >
> > The CFMWs are placed above the extended memmap.  Note the confusing
> > existing variable highest_gpa is the highest_gpa that has been allocated
> > at a particular point in setting up the memory map.
> >
> > The cxl_devices_state.host_mr is provides a small space in which to place  
> s/is//
Fixed. Thanks.
> > the individual host bridge register regions for whatever host bridges are
> > allocated via -device pxb-cxl on the command line. The existing dynamic
> > sysbus infrastructure is not reused because pxb-cxl is a PCI device not
> > a sysbus one but these registers are directly in the main memory map,
> > not the PCI address space.
> >
> > Only create the CEDT table if cxl=on set for the machine. Default to off.
> >
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---

> > @@ -1895,6 +1917,9 @@ static void virt_set_memmap(VirtMachineState *vms, int pa_bits)
> >      if (device_memory_size > 0) {
> >          machine_memory_devices_init(ms, device_memory_base, device_memory_size);
> >      }
> > +    vms->highest_gpa = cxl_fmws_set_memmap(ROUND_UP(vms->highest_gpa + 1,
> > +                                                    256 * MiB),
> > +                                           BIT_ULL(pa_bits)) - 1;  
> in hw/cxl/cxl-host.c, there seems to be a loop on fw windows? I guess
> those windows only exist if cxl option is set. In the positive,
> highest_gpa will be changed only if the option is set, which is fine.
> Indeed we have requested_ipa_size = 64 - clz64(vms->highest_gpa). So we
> shall not modify this if cxl is not set.
> 
> What I am a bit concerned with is that it"consumes" some high memory
> without making it explicit in extended_memmap. Shouldn't we book some
> dedicated space there? Sorry I am jumping very late in the review, maybe
> turning things worse & noisy :-( Eric

No problem with late review - whilst it looks late we had a several year
gap at one point in updating this series!

How much to book?  It's effectively infinite much like device memory.
Would be odd to book the minimum which is 256MiB given any useful system
is going to have a lot more than that (they are usually a few TiB but
may be much larger than that).

Would a comment after 
   [VIRT_HIGH_PCIE_MMIO] =     { 0x0, DEFAULT_HIGH_PCIE_MMIO_SIZE }, 
such as
   /* Any CXL Fixed memory windows come here */
be enough?

 
