Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2ABB28689C
	for <linux-cxl@vger.kernel.org>; Fri,  8 Aug 2025 16:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754668929; cv=none; b=emFwMbYWe1yWn092Y8mJ3UuJvhhmT+Ma571FnWC3+5EhfIBADCt3oaXdO0EJVO9UMJUU2FdNAJZkY4V3cG0f5ptjYSFrppMEOcS2oICWynhVsc1LLRxqWWuOyykyH2pUizYPETKgCxrNwuNC17qUuLEGX+uNhfYmsV3seBpW+ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754668929; c=relaxed/simple;
	bh=30TUkONAW7kMy6Ia7D90i3RsFW8zmrEtK36PO2eD07o=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k96T51+mKTBcrgj8xbQs7Dp+hHYw5fhJMmI9eqJG8Yy7qhV5wmzhzLPwZG5m9WVqvarn+ZX1IykPgL0WiPRGOgscV5NEvBp2snGfB1d8zEewPoL3zzGSswD+/JLGtNUqvpyLgJBegDNJAnb9ysZjLz2W2XSmx50fihU36UNZHEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bz7z01fdfz6K9Fl;
	Sat,  9 Aug 2025 00:00:12 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 7922214027A;
	Sat,  9 Aug 2025 00:02:02 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 8 Aug
 2025 18:02:02 +0200
Date: Fri, 8 Aug 2025 17:02:00 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <ira.weiny@intel.com>, <alucerop@amd.com>, <a.manzanares@samsung.com>,
	<linux-cxl@vger.kernel.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH 1/4] hw/pcie: Support enabling flit mode
Message-ID: <20250808170200.00001cde@huawei.com>
In-Reply-To: <20250806055708.196851-2-dave@stgolabs.net>
References: <20250806055708.196851-1-dave@stgolabs.net>
	<20250806055708.196851-2-dave@stgolabs.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue,  5 Aug 2025 22:57:05 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> As with the link speed and width training, have ad-hoc property for
> setting the flit mode and allow CXL components to make use of it.
> 
> For the CXL root port and dsp cases, always report flit mode but
> the actual value after 'training' will depend on the downstream
> device configuration.
Hi Davidlohr,

I'm not immediately spotting how this bit works. I was expecting
to see some code in pcie_sync_bridge_lnk() to see the Link Status
stuff indicating if it 'trained' in flit mode or not.

What am I missing?

J

> 
> Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  hw/core/qdev-properties-system.c          | 11 +++++++++++
>  hw/mem/cxl_type3.c                        |  4 +++-
>  hw/pci-bridge/cxl_downstream.c            |  1 +
>  hw/pci-bridge/cxl_root_port.c             |  1 +
>  hw/pci-bridge/cxl_upstream.c              |  3 ++-
>  hw/pci-bridge/gen_pcie_root_port.c        |  1 +
>  hw/pci/pcie.c                             | 13 +++++++++----
>  include/hw/cxl/cxl_device.h               |  1 +
>  include/hw/pci-bridge/cxl_upstream_port.h |  1 +
>  include/hw/pci/pcie.h                     |  2 +-
>  include/hw/pci/pcie_port.h                |  1 +
>  include/hw/qdev-properties-system.h       |  3 +++
>  qapi/common.json                          | 14 ++++++++++++++
>  13 files changed, 49 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
> index 24e145d87001..94a1b754ecdc 100644
> --- a/hw/core/qdev-properties-system.c
> +++ b/hw/core/qdev-properties-system.c
> @@ -1172,6 +1172,17 @@ const PropertyInfo qdev_prop_pcie_link_width = {
>      .set_default_value = qdev_propinfo_set_default_value_enum,
>  };
>  
> +/* --- Flit mode --- */
> +
> +const PropertyInfo qdev_prop_pcie_link_flit = {
> +    .type = "PCIELinkFlit",
> +    .description = "off/on",
> +    .enum_table = &PCIELinkFlit_lookup,
> +    .get   = qdev_propinfo_get_enum,
> +    .set   = qdev_propinfo_set_enum,
> +    .set_default_value = qdev_propinfo_set_default_value_enum,
> +};
> +
>  /* --- UUID --- */
>  
>  static void get_uuid(Object *obj, Visitor *v, const char *name, void *opaque,
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index c4658e0955d5..324cf62e8141 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -1501,7 +1501,8 @@ void ct3d_reset(DeviceState *dev)
>      uint32_t *reg_state = ct3d->cxl_cstate.crb.cache_mem_registers;
>      uint32_t *write_msk = ct3d->cxl_cstate.crb.cache_mem_regs_write_mask;
>  
> -    pcie_cap_fill_link_ep_usp(PCI_DEVICE(dev), ct3d->width, ct3d->speed);
> +    pcie_cap_fill_link_ep_usp(PCI_DEVICE(dev), ct3d->width, ct3d->speed,
> +                              ct3d->flitmode);
>      cxl_component_register_init_common(reg_state, write_msk, CXL2_TYPE3_DEVICE);
>      cxl_device_register_init_t3(ct3d, CXL_T3_MSIX_MBOX);
>  
> @@ -1540,6 +1541,7 @@ static const Property ct3_props[] = {
>                                  speed, PCIE_LINK_SPEED_32),
>      DEFINE_PROP_PCIE_LINK_WIDTH("x-width", CXLType3Dev,
>                                  width, PCIE_LINK_WIDTH_16),
> +    DEFINE_PROP_PCIE_LINK_FLIT("256b-flit", CXLType3Dev, flitmode, 0),
>      DEFINE_PROP_UINT16("chmu-port", CXLType3Dev, cxl_dstate.chmu[0].port, 0),
>  };
>  
> diff --git a/hw/pci-bridge/cxl_downstream.c b/hw/pci-bridge/cxl_downstream.c
> index 6aa8586f0161..82e6618b111c 100644
> --- a/hw/pci-bridge/cxl_downstream.c
> +++ b/hw/pci-bridge/cxl_downstream.c
> @@ -257,6 +257,7 @@ static const Property cxl_dsp_props[] = {
>                                  speed, PCIE_LINK_SPEED_64),
>      DEFINE_PROP_PCIE_LINK_WIDTH("x-width", PCIESlot,
>                                  width, PCIE_LINK_WIDTH_16),
> +    DEFINE_PROP_PCIE_LINK_FLIT("256b-flit", PCIESlot, flitmode, 1),
>  };
>  
>  static void cxl_dsp_class_init(ObjectClass *oc, const void *data)
> diff --git a/hw/pci-bridge/cxl_root_port.c b/hw/pci-bridge/cxl_root_port.c
> index f035987b6f1f..721dc3981fd2 100644
> --- a/hw/pci-bridge/cxl_root_port.c
> +++ b/hw/pci-bridge/cxl_root_port.c
> @@ -235,6 +235,7 @@ static const Property gen_rp_props[] = {
>                                  speed, PCIE_LINK_SPEED_64),
>      DEFINE_PROP_PCIE_LINK_WIDTH("x-width", PCIESlot,
>                                  width, PCIE_LINK_WIDTH_32),
> +    DEFINE_PROP_PCIE_LINK_FLIT("256b-flit", PCIESlot, flitmode, 1),
>  };
>  
>  static void cxl_rp_dvsec_write_config(PCIDevice *dev, uint32_t addr,
> diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
> index c2150afff39b..5e6d559a3215 100644
> --- a/hw/pci-bridge/cxl_upstream.c
> +++ b/hw/pci-bridge/cxl_upstream.c
> @@ -147,7 +147,7 @@ static void cxl_usp_reset(DeviceState *qdev)
>  
>      pci_bridge_reset(qdev);
>      pcie_cap_deverr_reset(d);
> -    pcie_cap_fill_link_ep_usp(d, usp->width, usp->speed);
> +    pcie_cap_fill_link_ep_usp(d, usp->width, usp->speed, usp->flitmode);
>      latch_registers(usp);
>  }
>  
> @@ -433,6 +433,7 @@ static const Property cxl_upstream_props[] = {
>                                  speed, PCIE_LINK_SPEED_32),
>      DEFINE_PROP_PCIE_LINK_WIDTH("x-width", CXLUpstreamPort,
>                                  width, PCIE_LINK_WIDTH_16),
> +    DEFINE_PROP_PCIE_LINK_FLIT("256b-flit", CXLUpstreamPort, flitmode, 0),
>  };
>  
>  static void cxl_upstream_class_init(ObjectClass *oc, const void *data)
> diff --git a/hw/pci-bridge/gen_pcie_root_port.c b/hw/pci-bridge/gen_pcie_root_port.c
> index d9078e783bf0..c00be8147c2a 100644
> --- a/hw/pci-bridge/gen_pcie_root_port.c
> +++ b/hw/pci-bridge/gen_pcie_root_port.c
> @@ -145,6 +145,7 @@ static const Property gen_rp_props[] = {
>                                  speed, PCIE_LINK_SPEED_16),
>      DEFINE_PROP_PCIE_LINK_WIDTH("x-width", PCIESlot,
>                                  width, PCIE_LINK_WIDTH_32),
> +    DEFINE_PROP_PCIE_LINK_FLIT("256b-flit", PCIESlot, flitmode, 0),
>  };
>  
>  static void gen_rp_dev_class_init(ObjectClass *klass, const void *data)
> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> index eaeb68894e6e..55e0f7110ae5 100644
> --- a/hw/pci/pcie.c
> +++ b/hw/pci/pcie.c
> @@ -113,7 +113,7 @@ pcie_cap_v1_fill(PCIDevice *dev, uint8_t port, uint8_t type, uint8_t version)
>  
>  /* Includes setting the target speed default */
>  static void pcie_cap_fill_lnk(uint8_t *exp_cap, PCIExpLinkWidth width,
> -                              PCIExpLinkSpeed speed)
> +                              PCIExpLinkSpeed speed, PCIELinkFlit flitmode)
>  {
>      /* Clear and fill LNKCAP from what was configured above */
>      pci_long_test_and_clear_mask(exp_cap + PCI_EXP_LNKCAP,
> @@ -158,10 +158,15 @@ static void pcie_cap_fill_lnk(uint8_t *exp_cap, PCIExpLinkWidth width,
>                                         PCI_EXP_LNKCAP2_SLS_64_0GB);
>          }
>      }
> +
> +    if (flitmode) {
> +        pci_long_test_and_set_mask(exp_cap + PCI_EXP_LNKSTA2,
> +                                   PCI_EXP_LNKSTA2_FLIT);
> +    }
>  }
>  
>  void pcie_cap_fill_link_ep_usp(PCIDevice *dev, PCIExpLinkWidth width,
> -                               PCIExpLinkSpeed speed)
> +                               PCIExpLinkSpeed speed, PCIELinkFlit flitmode)
>  {
>      uint8_t *exp_cap = dev->config + dev->exp.exp_cap;
>  
> @@ -175,7 +180,7 @@ void pcie_cap_fill_link_ep_usp(PCIDevice *dev, PCIExpLinkWidth width,
>                                 QEMU_PCI_EXP_LNKSTA_NLW(width) |
>                                 QEMU_PCI_EXP_LNKSTA_CLS(speed));
>  
> -    pcie_cap_fill_lnk(exp_cap, width, speed);
> +    pcie_cap_fill_lnk(exp_cap, width, speed, flitmode);
>  }
>  
>  static void pcie_cap_fill_slot_lnk(PCIDevice *dev)
> @@ -212,7 +217,7 @@ static void pcie_cap_fill_slot_lnk(PCIDevice *dev)
>          /* the PCI_EXP_LNKSTA_DLLLA will be set in the hotplug function */
>      }
>  
> -    pcie_cap_fill_lnk(exp_cap, s->width, s->speed);
> +    pcie_cap_fill_lnk(exp_cap, s->width, s->speed, s->flitmode);
>  }
>  
>  int pcie_cap_init(PCIDevice *dev, uint8_t offset,
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index 068c20d61ebc..4c9d2247cf02 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -796,6 +796,7 @@ struct CXLType3Dev {
>      /* PCIe link characteristics */
>      PCIExpLinkSpeed speed;
>      PCIExpLinkWidth width;
> +    PCIELinkFlit flitmode;
>  
>      /* DOE */
>      DOECap doe_cdat;
> diff --git a/include/hw/pci-bridge/cxl_upstream_port.h b/include/hw/pci-bridge/cxl_upstream_port.h
> index db1dfb6afd98..584e43c37291 100644
> --- a/include/hw/pci-bridge/cxl_upstream_port.h
> +++ b/include/hw/pci-bridge/cxl_upstream_port.h
> @@ -20,6 +20,7 @@ typedef struct CXLUpstreamPort {
>  
>      PCIExpLinkSpeed speed;
>      PCIExpLinkWidth width;
> +    PCIELinkFlit flitmode;
>  
>      DOECap doe_cdat;
>      uint64_t sn;
> diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
> index ff6ce08e135a..82fcbc9f8823 100644
> --- a/include/hw/pci/pcie.h
> +++ b/include/hw/pci/pcie.h
> @@ -142,7 +142,7 @@ void pcie_ari_init(PCIDevice *dev, uint16_t offset);
>  void pcie_dev_ser_num_init(PCIDevice *dev, uint16_t offset, uint64_t ser_num);
>  void pcie_ats_init(PCIDevice *dev, uint16_t offset, bool aligned);
>  void pcie_cap_fill_link_ep_usp(PCIDevice *dev, PCIExpLinkWidth width,
> -                               PCIExpLinkSpeed speed);
> +                               PCIExpLinkSpeed speed, PCIELinkFlit flitmode);
>  
>  void pcie_cap_slot_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
>                                 Error **errp);
> diff --git a/include/hw/pci/pcie_port.h b/include/hw/pci/pcie_port.h
> index 7cd7af8cfa4b..2f96fc685729 100644
> --- a/include/hw/pci/pcie_port.h
> +++ b/include/hw/pci/pcie_port.h
> @@ -58,6 +58,7 @@ struct PCIESlot {
>  
>      PCIExpLinkSpeed speed;
>      PCIExpLinkWidth width;
> +    PCIELinkFlit flitmode;
>  
>      /* Disable ACS (really for a pcie_root_port) */
>      bool        disable_acs;
> diff --git a/include/hw/qdev-properties-system.h b/include/hw/qdev-properties-system.h
> index b921392c5256..dd5dc4515ea7 100644
> --- a/include/hw/qdev-properties-system.h
> +++ b/include/hw/qdev-properties-system.h
> @@ -28,6 +28,7 @@ extern const PropertyInfo qdev_prop_audiodev;
>  extern const PropertyInfo qdev_prop_off_auto_pcibar;
>  extern const PropertyInfo qdev_prop_pcie_link_speed;
>  extern const PropertyInfo qdev_prop_pcie_link_width;
> +extern const PropertyInfo qdev_prop_pcie_link_flit;
>  extern const PropertyInfo qdev_prop_cpus390entitlement;
>  extern const PropertyInfo qdev_prop_iothread_vq_mapping_list;
>  extern const PropertyInfo qdev_prop_endian_mode;
> @@ -80,6 +81,8 @@ extern const PropertyInfo qdev_prop_vmapple_virtio_blk_variant;
>  #define DEFINE_PROP_PCIE_LINK_WIDTH(_n, _s, _f, _d) \
>      DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_pcie_link_width, \
>                          PCIExpLinkWidth)
> +#define DEFINE_PROP_PCIE_LINK_FLIT(_n, _s, _f, _d) \
> +    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_pcie_link_flit, PCIELinkFlit)
>  
>  #define DEFINE_PROP_UUID(_name, _state, _field) \
>      DEFINE_PROP(_name, _state, _field, qdev_prop_uuid, QemuUUID, \
> diff --git a/qapi/common.json b/qapi/common.json
> index 0e3a0bbbfb0b..da047fbf874f 100644
> --- a/qapi/common.json
> +++ b/qapi/common.json
> @@ -140,6 +140,20 @@
>  { 'enum': 'PCIELinkWidth',
>    'data': [ '1', '2', '4', '8', '12', '16', '32' ] }
>  
> +##
> +# @PCIELinkFlit:
> +#
> +# An enumeration of PCIe link FLIT mode
> +#
> +# @off: the link is not operating in FLIT mode
> +#
> +# @on: each FLIT is a fixed 256 bytes in size
> +#
> +# Since: 10.0
> +##
> +{ 'enum': 'PCIELinkFlit',
> +  'data': [ 'off', 'on'] }
> +
>  ##
>  # @HostMemPolicy:
>  #

