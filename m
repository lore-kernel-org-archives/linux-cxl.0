Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B47F16BE0E
	for <linux-cxl@vger.kernel.org>; Fri,  2 Aug 2024 16:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722616817; cv=none; b=EM8PdeOFq+pTudofyZrbKCIgv/1kb1+wRBfzHTA797UwUSCqJaygflXFjRATQiCvr4V9P3Qfs08S+KJzVLohJB9J+b+xDM8qP/GVdwPsunWAFKk82fmFyZVEwUJVCXbK/+aPJ+uLHsUzpd+pV1pfCeO0Wr5jkcnWfh+6/K8yXeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722616817; c=relaxed/simple;
	bh=kM/3R3aPhsSM6qfD37mjkioDQ8N15JFcRvn0F+8Y3ig=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dEEc4vvhatfI9ng5iuN5n41nwP5s/7/SpFjFr47AXFpRsAqZSDxJeZw34TA/f0xndMYBFLX450T+loAWv8WTSQ32bXcvaWH0tAeiuQVSJgtq2x/HqZ4QhatMX94VTdklWcjShwI62vo2d8+3EzJMkE3CyGYe9/wQfi1wEspYkGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WbBMy6zfQz6K8jJ;
	Sat,  3 Aug 2024 00:38:06 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 43D5914038F;
	Sat,  3 Aug 2024 00:40:11 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 2 Aug
 2024 17:40:10 +0100
Date: Fri, 2 Aug 2024 17:40:10 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
CC: Fan Ni <fan.ni@samsung.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2] hw/mem/cxl_type3: reset dvsecs in ct3d_reset()
Message-ID: <20240802174010.000025e7@Huawei.com>
In-Reply-To: <96862201-fb35-4fa2-bb77-253773efbe03@fujitsu.com>
References: <20240409075846.85370-1-lizhijian@fujitsu.com>
	<20240411111816.0000343c@Huawei.com>
	<96862201-fb35-4fa2-bb77-253773efbe03@fujitsu.com>
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
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 26 Apr 2024 03:36:07 +0000
"Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com> wrote:

> ping
> 
> 
Hi.

I'm going to drop this again from my tree as it breaks the CDAT DOE
(I was testing Dave's patches with Mike's numa memblk and access0/1
 were empty :(

I haven't looked in detail but it's probably because each PCIe
extended cap includes a pointer to the next one.  This is
rewriting a chunk in the middle of that list.  Hence the
pointer at the end is set to 0 and we don't see the DOE that
follows it.

Various ways we could fix that.  Maybe split the pcie doe
creation from the capability construction so we can reinit that
as well in this path. Not one for a Friday evening!

Thanks,

Jonathan

> 
> On 11/04/2024 18:18, Jonathan Cameron wrote:
> > On Tue,  9 Apr 2024 15:58:46 +0800
> > Li Zhijian <lizhijian@fujitsu.com> wrote:
> >   
> >> After the kernel commit
> >> 0cab68720598 ("cxl/pci: Fix disabling memory if DVSEC CXL Range does not match a CFMWS window")
> >> CXL type3 devices cannot be enabled again after the reboot because the
> >> control register(see 8.1.3.2 in CXL specifiction 2.0 for more details) was
> >> not reset.
> >>
> >> These registers could be changed by the firmware or OS, let them have
> >> their initial value in reboot so that the OS can read their clean status.
> >>
> >> Fixes: e1706ea83da0 ("hw/cxl/device: Add a memory device (8.2.8.5)")
> >> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>  
> > Hi,
> > 
> > We need to have a close look at what this is actually doing before
> > considering applying it.  I don't have time to get that this week, but
> > hopefully will find some time later this month.
> > 
> > I don't want a partial fix for one particular case that causes
> > us potential trouble in others.
> > 
> > Jonathan
> >   
> >> ---
> >> root_port, usp and dsp have the same issue, if this patch get approved,
> >> I will send another patch to fix them later.
> >>
> >> V2:
> >>     Add fixes tag.
> >>     Reset all dvsecs registers instead of CTRL only
> >> ---
> >>   hw/mem/cxl_type3.c | 11 +++++++----
> >>   1 file changed, 7 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> >> index b0a7e9f11b64..4f09d0b8fedc 100644
> >> --- a/hw/mem/cxl_type3.c
> >> +++ b/hw/mem/cxl_type3.c
> >> @@ -30,6 +30,7 @@
> >>   #include "hw/pci/msix.h"
> >>   
> >>   #define DWORD_BYTE 4
> >> +#define CT3D_CAP_SN_OFFSET PCI_CONFIG_SPACE_SIZE
> >>   
> >>   /* Default CDAT entries for a memory region */
> >>   enum {
> >> @@ -284,6 +285,10 @@ static void build_dvsecs(CXLType3Dev *ct3d)
> >>                range2_size_hi = 0, range2_size_lo = 0,
> >>                range2_base_hi = 0, range2_base_lo = 0;
> >>   
> >> +    cxl_cstate->dvsec_offset = CT3D_CAP_SN_OFFSET;
> >> +    if (ct3d->sn != UI64_NULL) {
> >> +        cxl_cstate->dvsec_offset += PCI_EXT_CAP_DSN_SIZEOF;
> >> +    }
> >>       /*
> >>        * Volatile memory is mapped as (0x0)
> >>        * Persistent memory is mapped at (volatile->size)
> >> @@ -664,10 +669,7 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
> >>   
> >>       pcie_endpoint_cap_init(pci_dev, 0x80);
> >>       if (ct3d->sn != UI64_NULL) {
> >> -        pcie_dev_ser_num_init(pci_dev, 0x100, ct3d->sn);
> >> -        cxl_cstate->dvsec_offset = 0x100 + 0x0c;
> >> -    } else {
> >> -        cxl_cstate->dvsec_offset = 0x100;
> >> +        pcie_dev_ser_num_init(pci_dev, CT3D_CAP_SN_OFFSET, ct3d->sn);
> >>       }
> >>   
> >>       ct3d->cxl_cstate.pdev = pci_dev;
> >> @@ -907,6 +909,7 @@ static void ct3d_reset(DeviceState *dev)
> >>   
> >>       cxl_component_register_init_common(reg_state, write_msk, CXL2_TYPE3_DEVICE);
> >>       cxl_device_register_init_t3(ct3d);
> >> +    build_dvsecs(ct3d);
> >>   
> >>       /*
> >>        * Bring up an endpoint to target with MCTP over VDM.  
> >  

