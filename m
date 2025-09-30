Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0705D1EB5E3
	for <linux-cxl@vger.kernel.org>; Tue, 30 Sep 2025 15:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759245553; cv=none; b=TAPdGNV4wgJQTTShX9hYRvodXAprC1fbIIW3a5vnndt6G+Jx2/68rXLcmR64mRLPTCUVafXumEDb0xHfzIfDyrR/ysDVcX9lYjtIIlGXlW1nv69rXnABAI7aBXy1scxwQ/E0ywGKRSOE3ltlRVAfeoE5HGRvXGR4Z5kjuWwqsSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759245553; c=relaxed/simple;
	bh=g8H5/LizN+D4rM940L/YeONy6/lu2+k2/K5iiLX993U=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M/6tYs14DD6rJeCcqa1ZWgyHFufFFolel6ConfvhEpdhVSLW7ZJjX0LPAjlT8+zg2lrzolJ4A+rJXaoMmZCghHSYJf6tdFynl0ka3q9WNgUhcIaE/oY3DeO44EVKcgXIp5rYE5r6RaLRo/9Vl4JbVCGde8Lgf/2KGcXMU6XRGLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cbhXq6V7Pz6K5Wg;
	Tue, 30 Sep 2025 23:18:51 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 471E31402ED;
	Tue, 30 Sep 2025 23:19:06 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 30 Sep
 2025 16:19:05 +0100
Date: Tue, 30 Sep 2025 16:19:03 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <ira.weiny@intel.com>, <lucerop@amd.com>, <a.manzanares@samsung.com>,
	<mst@redhat.com>, <marcel.apfelbaum@gmail.com>, <armbru@redhat.com>,
	<linux-cxl@vger.kernel.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH 1/5] hw/pcie: Support enabling flit mode
Message-ID: <20250930161903.00006583@huawei.com>
In-Reply-To: <20250930032153.1127773-2-dave@stgolabs.net>
References: <20250930032153.1127773-1-dave@stgolabs.net>
	<20250930032153.1127773-2-dave@stgolabs.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Mon, 29 Sep 2025 20:21:49 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> PCIe Flit Mode, introduced with the PCIe 6.0 specification, is a
> fundamental change in how data is transmitted over the bus to
> improve transfer rates. It shifts from variable-sized Transaction
> Layer Packets (TLPs) to fixed 256-byte Flow Control Units (FLITs).
> 
> As with the link speed and width training, have ad-hoc property for
> setting the flit mode and allow CXL components to make use of it.
> 
> For the CXL root port and dsp cases, always report flit mode but
> the actual value after 'training' will depend on the downstream
> device configuration.
> 
> Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Hi Davidlohr,

A few comments inline. Main one is that I think we need the CAP to still
say we support 68B flits on the CXL devices and just mess with the
status.

> ---
>  hw/mem/cxl_type3.c                        |  9 ++++++---
>  hw/pci-bridge/cxl_downstream.c            | 11 +++++++----
>  hw/pci-bridge/cxl_root_port.c             | 11 +++++++----
>  hw/pci-bridge/cxl_upstream.c              | 19 +++++++++++--------
>  hw/pci-bridge/gen_pcie_root_port.c        |  1 +
>  hw/pci/pcie.c                             | 23 +++++++++++++++++++----
>  include/hw/cxl/cxl_device.h               |  1 +
>  include/hw/pci-bridge/cxl_upstream_port.h |  1 +
>  include/hw/pci/pcie.h                     |  2 +-
>  include/hw/pci/pcie_port.h                |  1 +
>  10 files changed, 55 insertions(+), 24 deletions(-)
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index c4658e0955d5..891b75618892 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -533,9 +533,10 @@ static void build_dvsecs(CXLType3Dev *ct3d)
>                                 GPF_DEVICE_DVSEC_REVID, dvsec);
>  
>      dvsec = (uint8_t *)&(CXLDVSECPortFlexBus){
> -        .cap                     = 0x26, /* 68B, IO, Mem, non-MLD */
> +                                   /* 68B (maybe), IO, Mem, non-MLD */
> +        .cap                     = ct3d->flitmode ? 0x6 : 0x26,

Do we need this capability bit change?  The bit says the device is capable of doing it,
not that we currently are.   I think from a spec point of view we aren't allowed to
not support this.  Applies int the various other places as well.


>          .ctrl                    = 0x02, /* IO always enabled */
> -        .status                  = 0x26, /* same as capabilities */
> +        .status                  = ct3d->flitmode ? 0x6 : 0x26, /* same */

This is correct but if we do leave teh cap alone we probably need to note
that flitmode means we aren't in the old 68B flit mode.

>          .rcvd_mod_ts_data_phase1 = 0xef, /* WTF? */
>      };
>      cxl_component_create_dvsec(cxl_cstate, CXL2_TYPE3_DEVICE,
> @@ -1501,7 +1502,8 @@ void ct3d_reset(DeviceState *dev)
>      uint32_t *reg_state = ct3d->cxl_cstate.crb.cache_mem_registers;
>      uint32_t *write_msk = ct3d->cxl_cstate.crb.cache_mem_regs_write_mask;
>  
> -    pcie_cap_fill_link_ep_usp(PCI_DEVICE(dev), ct3d->width, ct3d->speed);
> +    pcie_cap_fill_link_ep_usp(PCI_DEVICE(dev), ct3d->width, ct3d->speed,
> +                              ct3d->flitmode);
>      cxl_component_register_init_common(reg_state, write_msk, CXL2_TYPE3_DEVICE);
>      cxl_device_register_init_t3(ct3d, CXL_T3_MSIX_MBOX);
>  
> @@ -1540,6 +1542,7 @@ static const Property ct3_props[] = {
>                                  speed, PCIE_LINK_SPEED_32),
>      DEFINE_PROP_PCIE_LINK_WIDTH("x-width", CXLType3Dev,
>                                  width, PCIE_LINK_WIDTH_16),
> +    DEFINE_PROP_BOOL("x-256b-flit", CXLType3Dev, flitmode, false),
>      DEFINE_PROP_UINT16("chmu-port", CXLType3Dev, cxl_dstate.chmu[0].port, 0),
>  };
>  
> diff --git a/hw/pci-bridge/cxl_downstream.c b/hw/pci-bridge/cxl_downstream.c
> index 6aa8586f0161..f8d64263ac08 100644
> --- a/hw/pci-bridge/cxl_downstream.c
> +++ b/hw/pci-bridge/cxl_downstream.c

>  static void gen_rp_dev_class_init(ObjectClass *klass, const void *data)
> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> index eaeb68894e6e..cc8e7c3cbf3f 100644
> --- a/hw/pci/pcie.c
> +++ b/hw/pci/pcie.c

> @@ -1106,6 +1111,8 @@ void pcie_sync_bridge_lnk(PCIDevice *bridge_dev)
>      if (!target || !target->exp.exp_cap) {
>          lnksta = lnkcap;
>      } else {
> +        uint16_t lnksta2;
> +
>          lnksta = target->config_read(target,
>                                       target->exp.exp_cap + PCI_EXP_LNKSTA,
>                                       sizeof(lnksta));
> @@ -1119,6 +1126,14 @@ void pcie_sync_bridge_lnk(PCIDevice *bridge_dev)
>              lnksta &= ~PCI_EXP_LNKSTA_CLS;
>              lnksta |= lnkcap & PCI_EXP_LNKCAP_SLS;
>          }
> +
> +        lnksta2 = target->config_read(target,
> +                                      target->exp.exp_cap + PCI_EXP_LNKSTA2,
> +                                      sizeof(lnksta2));
> +        pci_word_test_and_clear_mask(exp_cap + PCI_EXP_LNKSTA2,
> +                                     PCI_EXP_LNKSTA2_FLIT);
> +        pci_word_test_and_set_mask(exp_cap + PCI_EXP_LNKSTA2, lnksta2 &
> +                                   PCI_EXP_LNKSTA2_FLIT);

Odd linewrap. Kind of makes some sense for the linksta one I guess you based this
on but here, we can fit the whole parameter on one line.


>      }
>  
>      if (!(lnksta & PCI_EXP_LNKSTA_NLW)) {

