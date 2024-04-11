Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B19146586
	for <linux-cxl@vger.kernel.org>; Thu, 11 Apr 2024 10:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712830704; cv=none; b=eLmL8y9QbRpn7iyu/Os+8w3x5q/Lr4raJ+T4E706xQRlyfv1godDuK9W1oYaz2e10dtyfy2uhgR3kio6WBdSfe6+BvbaVwyNyz9ZFtHTkB3RCuV2GFfT+p0TXxMExQABAEJcep2m7dnd1Z/hoCaoc9q/nVjtbrPvjqrqv8X2aG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712830704; c=relaxed/simple;
	bh=LCR+EEhwzXQCRBBYTf00pxHTL9AcTqSUzD1C9E74kP8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u8eDkvX/1miuJaiPvgGkoBqTAgEMvdkkm7IXZiJ1zIsHy1pcuGT1WdB07DiCetWIiqCNagY1AZAdNXeGCNwImaNnl6PGBwMxZVhp3Z+DonbGPse4+WeAsMrM4tEUzYnnueuBk+eu/KJnDEl9YzLscOp0ZupjtGz7JzjIrzP87wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VFbBK0msbz6K8wH;
	Thu, 11 Apr 2024 18:13:29 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id BA4B81400E7;
	Thu, 11 Apr 2024 18:18:17 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 11 Apr
 2024 11:18:17 +0100
Date: Thu, 11 Apr 2024 11:18:16 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Li Zhijian <lizhijian@fujitsu.com>
CC: Fan Ni <fan.ni@samsung.com>, <qemu-devel@nongnu.org>,
	<linux-cxl@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2] hw/mem/cxl_type3: reset dvsecs in ct3d_reset()
Message-ID: <20240411111816.0000343c@Huawei.com>
In-Reply-To: <20240409075846.85370-1-lizhijian@fujitsu.com>
References: <20240409075846.85370-1-lizhijian@fujitsu.com>
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

On Tue,  9 Apr 2024 15:58:46 +0800
Li Zhijian <lizhijian@fujitsu.com> wrote:

> After the kernel commit
> 0cab68720598 ("cxl/pci: Fix disabling memory if DVSEC CXL Range does not match a CFMWS window")
> CXL type3 devices cannot be enabled again after the reboot because the
> control register(see 8.1.3.2 in CXL specifiction 2.0 for more details) was
> not reset.
> 
> These registers could be changed by the firmware or OS, let them have
> their initial value in reboot so that the OS can read their clean status.
> 
> Fixes: e1706ea83da0 ("hw/cxl/device: Add a memory device (8.2.8.5)")
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
Hi,

We need to have a close look at what this is actually doing before
considering applying it.  I don't have time to get that this week, but
hopefully will find some time later this month.

I don't want a partial fix for one particular case that causes
us potential trouble in others.

Jonathan

> ---
> root_port, usp and dsp have the same issue, if this patch get approved,
> I will send another patch to fix them later.
> 
> V2:
>    Add fixes tag.
>    Reset all dvsecs registers instead of CTRL only
> ---
>  hw/mem/cxl_type3.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index b0a7e9f11b64..4f09d0b8fedc 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -30,6 +30,7 @@
>  #include "hw/pci/msix.h"
>  
>  #define DWORD_BYTE 4
> +#define CT3D_CAP_SN_OFFSET PCI_CONFIG_SPACE_SIZE
>  
>  /* Default CDAT entries for a memory region */
>  enum {
> @@ -284,6 +285,10 @@ static void build_dvsecs(CXLType3Dev *ct3d)
>               range2_size_hi = 0, range2_size_lo = 0,
>               range2_base_hi = 0, range2_base_lo = 0;
>  
> +    cxl_cstate->dvsec_offset = CT3D_CAP_SN_OFFSET;
> +    if (ct3d->sn != UI64_NULL) {
> +        cxl_cstate->dvsec_offset += PCI_EXT_CAP_DSN_SIZEOF;
> +    }
>      /*
>       * Volatile memory is mapped as (0x0)
>       * Persistent memory is mapped at (volatile->size)
> @@ -664,10 +669,7 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
>  
>      pcie_endpoint_cap_init(pci_dev, 0x80);
>      if (ct3d->sn != UI64_NULL) {
> -        pcie_dev_ser_num_init(pci_dev, 0x100, ct3d->sn);
> -        cxl_cstate->dvsec_offset = 0x100 + 0x0c;
> -    } else {
> -        cxl_cstate->dvsec_offset = 0x100;
> +        pcie_dev_ser_num_init(pci_dev, CT3D_CAP_SN_OFFSET, ct3d->sn);
>      }
>  
>      ct3d->cxl_cstate.pdev = pci_dev;
> @@ -907,6 +909,7 @@ static void ct3d_reset(DeviceState *dev)
>  
>      cxl_component_register_init_common(reg_state, write_msk, CXL2_TYPE3_DEVICE);
>      cxl_device_register_init_t3(ct3d);
> +    build_dvsecs(ct3d);
>  
>      /*
>       * Bring up an endpoint to target with MCTP over VDM.

