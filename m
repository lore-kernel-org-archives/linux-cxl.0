Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6123E27702D
	for <linux-cxl@vger.kernel.org>; Tue,  1 Jul 2025 14:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751380878; cv=none; b=adm6hQkKFwKrJa9E8kU76y5IhUXeJWVtZH6+0W1zjCjM7wpETS1U2aYaznnHLbrhLst6on1eu5mWC85sig4LmuKMuYSTm8JltDn3Gd1LkitIDQu95d9zM+NbAfQsnZZciB+1A09cSHzv91+tb9WsY3VlNoQ9Z/8dfmYFQhT4phI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751380878; c=relaxed/simple;
	bh=Sv51aE0SrXuCzutXX+O01rxJN3UVKsuvsHeeLWmWzaw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qCg5F52iVBWG0+OMXxPJA2cBOUk0Fi4mvifUnYuyhi8fnDP3FTwmcFy1i88QKr4KHnStx8bPrC/kCoMLJGnsQWxvoWigzo/LNXclZGUMXleumXdDnHzDURWAuSC9Mj/lTdzrZHoq+CaDyV1tMDxlQmGfPbwfWh8cSksxJg/yN+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bWm0x4y7Bz6L52Z;
	Tue,  1 Jul 2025 22:40:49 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 962CE14027A;
	Tue,  1 Jul 2025 22:41:12 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 1 Jul
 2025 16:41:11 +0200
Date: Tue, 1 Jul 2025 15:41:10 +0100
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
Message-ID: <20250701154110.00007675@huawei.com>
In-Reply-To: <4ceea721-b633-499e-9fcd-735990ee0704@redhat.com>
References: <20250625161926.549812-1-Jonathan.Cameron@huawei.com>
	<20250625161926.549812-4-Jonathan.Cameron@huawei.com>
	<4ceea721-b633-499e-9fcd-735990ee0704@redhat.com>
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

On Tue, 1 Jul 2025 15:26:26 +0200
Eric Auger <eric.auger@redhat.com> wrote:

> Hi Jonathan,
> 
> On 6/25/25 6:19 PM, Jonathan Cameron via wrote:
> > Code based on i386/pc enablement.
> > The memory layout places space for 16 host bridge register regions after
> > the GIC_REDIST2 in the extended memmap. This is a hole in the current
> > map so adding them here has no impact on placement of other memory regions
> > (tested with enough CPUs for GIC_REDIST2 to be in use.)  
> 
> Doesn't it depend on the init RAM size setting.
> if the init RAM top + REDIST2 aligns to a 256MB boundary (size of the
> PCI ECAM) aren't you likely to have no hole?

Hi Eric,

Is that possible?  I think the device_memory_base being force to align
to a 1 GiB means that never happens.  That seems to occur even
if there is no device_memory.  

    device_memory_base =
        ROUND_UP(vms->memmap[VIRT_MEM].base + ms->ram_size, GiB);
    device_memory_size = ms->maxram_size - ms->ram_size + ms->ram_slots * GiB;

    /* Base address of the high IO region */
    memtop = base = device_memory_base + ROUND_UP(device_memory_size, GiB);
//So here we are GiB aligned.
...

    if (base < vms->memmap[VIRT_MEM].base + LEGACY_RAMLIMIT_BYTES) {
        base = vms->memmap[VIRT_MEM].base + LEGACY_RAMLIMIT_BYTES;
    }

//That's 256 GiB in or leave it alone as more than that but GiB aligned.

   /* We know for sure that at least the memory fits in the PA space */
    vms->highest_gpa = memtop - 1;

    virt_set_high_memmap(vms, base, pa_bits);


So I think I'm fine. I should call out that REDIST2 is GiB
aligned though in this patch description.
> 
> 
> >
> > The CFMWs are placed above the extended memmap.  Note the confusing
> > existing variable highest_gpa is the highest_gpa that has been allocated
> > at a particular point in setting up the memory map.  
> what kind of improvement would you foresee wrt highest_gpa?

This was mostly a response to Peter expressed that he was expecting
highest_gpa to reflect the limit, not the highest yet seen.

I'm not sure how to resolve that without having awkward naming
like highest_gpa_sofar. There are existing comments where it is updated
so I'm not thinking we need to change anything for this.


Thanks for taking a look,

Jonathan

