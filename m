Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C75933689D;
	Fri, 13 Mar 2026 22:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773439637; cv=none; b=SE9KNXYPELskIPV6ifoTKAwciUAGEr/d0LlLYgvBCWRrOTOc2n5NVmbPfoYlUx45UA4Lt8zNeDZtgbqW18vF2svOPP82oDrBQMdkLlqy4C+cCySBbGbNHUol7FnCh2IimGpkvUGFuXbrSaaNeM0TXAt/6qtiQIUh2ca8GiewC5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773439637; c=relaxed/simple;
	bh=FX9j5wMJPqh4H4pK++nvUJvHV67KgMULiYTtkRBkQOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F39uZJPhQbLvPagER7A5LlhY+kEvpJlf5PeYll+KC2cl3x5ySP862XqvKRDck9q112CoTFeXM2nL6oDQ2gxopJHwyubt+j3BwJoYbJdiU7Xmr8LvDzrtCRsZPgP+o+SpZO6DcegCtdIVl17C6jpa32+Oxmq5BrBUvCsjd98M9Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AMkrswMK; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AMkrswMK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773439634; x=1804975634;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FX9j5wMJPqh4H4pK++nvUJvHV67KgMULiYTtkRBkQOo=;
  b=AMkrswMKJnx1YPUym81wIW+W2A0KLy4VcP7R/YpdJ5LyajR0iTeGz1Wd
   1gC5R7i4VdFY+DLqasjZIYWWC4p8jbiXFYSCi9nfHRq3ZvmX15kWtu1dl
   F4roogPZqiAwW6zpI01ayG76+BIimRGzm1C45eXtlHCHotuQusmbyPBWu
   eVDw9ZhHiRAciYo/hf6c9I4Ou0d27s1mXsTKLuhaMs+Gc3r73x3eNV9zp
   vakqeWZES8CdWmsEXpskO4gdXkHPWrQsgfGzymkpF1XUQROyJ/qimNBBF
   RjMncug2wLKihlzLfWGMzj6Hn5BBtrplYQWvbJ+oCVO444e4M+Eev+ZPF
   g==;
X-CSE-ConnectionGUID: 1QWAQCyqQh6kZnyk29nbPw==
X-CSE-MsgGUID: kfSVJByCQB6PJJCS4qBN6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11728"; a="73569585"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="73569585"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 15:07:14 -0700
X-CSE-ConnectionGUID: cVyIladeQl+pfZYdWBHHXw==
X-CSE-MsgGUID: iTyhsAcgRBGzUvf0P6i6BQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="217676683"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.110.233]) ([10.125.110.233])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 15:07:12 -0700
Message-ID: <b6f85dc5-7619-4125-a63a-632d379a0d34@intel.com>
Date: Fri, 13 Mar 2026 15:07:10 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/20] vfio/cxl: Introduce CXL DVSEC configuration space
 emulation
To: mhonap@nvidia.com, aniketa@nvidia.com, ankita@nvidia.com,
 alwilliamson@nvidia.com, vsethi@nvidia.com, jgg@nvidia.com,
 mochs@nvidia.com, skolothumtho@nvidia.com, alejandro.lucero-palau@amd.com,
 dave@stgolabs.net, jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 jgg@ziepe.ca, yishaih@nvidia.com, kevin.tian@intel.com
Cc: cjia@nvidia.com, targupta@nvidia.com, zhiw@nvidia.com, kjaju@nvidia.com,
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org, kvm@vger.kernel.org
References: <20260311203440.752648-1-mhonap@nvidia.com>
 <20260311203440.752648-16-mhonap@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260311203440.752648-16-mhonap@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/11/26 1:34 PM, mhonap@nvidia.com wrote:
> From: Manish Honap <mhonap@nvidia.com>
> 
> CXL devices have CXL DVSEC registers in the configuration space.
> Many of them affect the behaviors of the devices, e.g. enabling
> CXL.io/CXL.mem/CXL.cache.
> 
> However, these configurations are owned by the host and a virtualization
> policy should be applied when handling the access from the guest.
> 
> Introduce the emulation of CXL configuration space to handle the access
> of the virtual CXL configuration space from the guest.
> 
> vfio-pci-core already allocates vdev->vconfig as the authoritative
> virtual config space shadow. Directly use vdev->vconfig:
>   - DVSEC reads return data from vdev->vconfig (already populated by
>     vfio_config_init() via vfio_ecap_init())
>   - DVSEC writes go through new CXL-aware write handlers that update
>     vdev->vconfig in place
>   - The writable DVSEC registers are marked virtual in vdev->pci_config_map
> 
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> Signed-off-by: Manish Honap <mhonap@nvidia.com>
> ---
>  drivers/vfio/pci/Makefile              |   2 +-
>  drivers/vfio/pci/cxl/vfio_cxl_config.c | 304 +++++++++++++++++++++++++
>  drivers/vfio/pci/cxl/vfio_cxl_core.c   |   4 +
>  drivers/vfio/pci/cxl/vfio_cxl_priv.h   |  38 +++-
>  drivers/vfio/pci/vfio_pci.c            |  14 ++
>  drivers/vfio/pci/vfio_pci_config.c     |  46 +++-
>  drivers/vfio/pci/vfio_pci_priv.h       |   3 +
>  include/linux/vfio_pci_core.h          |   8 +-
>  8 files changed, 415 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/vfio/pci/cxl/vfio_cxl_config.c
> 
> diff --git a/drivers/vfio/pci/Makefile b/drivers/vfio/pci/Makefile
> index bef916495eae..7c86b7845e8f 100644
> --- a/drivers/vfio/pci/Makefile
> +++ b/drivers/vfio/pci/Makefile
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  
>  vfio-pci-core-y := vfio_pci_core.o vfio_pci_intrs.o vfio_pci_rdwr.o vfio_pci_config.o
> -vfio-pci-core-$(CONFIG_VFIO_CXL_CORE) += cxl/vfio_cxl_core.o cxl/vfio_cxl_emu.o
> +vfio-pci-core-$(CONFIG_VFIO_CXL_CORE) += cxl/vfio_cxl_core.o cxl/vfio_cxl_emu.o cxl/vfio_cxl_config.o
>  vfio-pci-core-$(CONFIG_VFIO_PCI_ZDEV_KVM) += vfio_pci_zdev.o
>  vfio-pci-core-$(CONFIG_VFIO_PCI_DMABUF) += vfio_pci_dmabuf.o
>  obj-$(CONFIG_VFIO_PCI_CORE) += vfio-pci-core.o
> diff --git a/drivers/vfio/pci/cxl/vfio_cxl_config.c b/drivers/vfio/pci/cxl/vfio_cxl_config.c
> new file mode 100644
> index 000000000000..a9560661345c
> --- /dev/null
> +++ b/drivers/vfio/pci/cxl/vfio_cxl_config.c
> @@ -0,0 +1,304 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * CXL DVSEC configuration space emulation for vfio-pci.
> + *
> + * Integrates into the existing vfio-pci-core ecap_perms[] framework using
> + * vdev->vconfig as the sole shadow buffer for DVSEC registers.
> + *
> + * Copyright (c) 2026, NVIDIA CORPORATION & AFFILIATES. All rights reserved
> + */
> +
> +#include <linux/pci.h>
> +#include <linux/vfio_pci_core.h>
> +
> +#include "../vfio_pci_priv.h"
> +#include "vfio_cxl_priv.h"
> +
> +/* Helpers to access vdev->vconfig at a DVSEC-relative offset */
> +static inline u16 dvsec_virt_read16(struct vfio_pci_core_device *vdev,
> +				    u16 off)
> +{
> +	return le16_to_cpu(*(u16 *)(vdev->vconfig +
> +				    vdev->cxl->dvsec + off));
> +}
> +
> +static inline void dvsec_virt_write16(struct vfio_pci_core_device *vdev,
> +				      u16 off, u16 val)
> +{
> +	*(u16 *)(vdev->vconfig + vdev->cxl->dvsec + off) = cpu_to_le16(val);
> +}
> +
> +static inline u32 dvsec_virt_read32(struct vfio_pci_core_device *vdev,
> +				    u16 off)
> +{
> +	return le32_to_cpu(*(u32 *)(vdev->vconfig +
> +				    vdev->cxl->dvsec + off));
> +}
> +
> +static inline void dvsec_virt_write32(struct vfio_pci_core_device *vdev,
> +				      u16 off, u32 val)
> +{
> +	*(u32 *)(vdev->vconfig + vdev->cxl->dvsec + off) = cpu_to_le32(val);
> +}
> +
> +/* Individual DVSEC register write handlers */
> +
> +static void cxl_control_write(struct vfio_pci_core_device *vdev,

cxl_dvsec_control_write()

> +			      u16 abs_off, u16 new_val)

abs_off not needed?

> +{
> +	u16 lock = dvsec_virt_read16(vdev, CXL_DVSEC_LOCK_OFFSET);
> +	u16 cap3 = dvsec_virt_read16(vdev, CXL_DVSEC_CAPABILITY3_OFFSET);
> +	u16 rev_mask = CXL_CTRL_RESERVED_MASK;
> +
> +	if (lock & CXL_CTRL_LOCK_BIT)
> +		return; /* register is locked after first write */
> +
> +	if (!(cap3 & CXL_CAP3_P2P_BIT))
> +		rev_mask |= CXL_CTRL_P2P_REV_MASK;
> +
> +	new_val &= ~rev_mask;
> +	new_val |= CXL_CTRL_CXL_IO_ENABLE_BIT; /* CXL.io always enabled */

Can FIELD_MODIFY() be used here?

> +
> +	dvsec_virt_write16(vdev, CXL_DVSEC_CONTROL_OFFSET, new_val);
> +}
> +
> +static void cxl_status_write(struct vfio_pci_core_device *vdev,

cxl_dvsec_status_write()
> +			     u16 abs_off, u16 new_val)

abs_off not needed


> +{
> +	u16 cur_val = dvsec_virt_read16(vdev, CXL_DVSEC_STATUS_OFFSET);
> +
> +	new_val &= ~CXL_STATUS_RESERVED_MASK;
> +
> +	/* RW1C: writing a 1 clears the bit; writing 0 leaves it unchanged */
> +	if (new_val & CXL_STATUS_RW1C_BIT)
> +		new_val &= ~CXL_STATUS_RW1C_BIT;
> +	else
> +		new_val = (new_val & ~CXL_STATUS_RW1C_BIT) |
> +			(cur_val & CXL_STATUS_RW1C_BIT);

Given there's only 1 bit we need to deal with in this register and everything else is reserved, can't we just do:

if (new_val & CXL_STATUS_RW1C_BIT)
	new_val = 0;
else
	new_val = old_val;

> +
> +	dvsec_virt_write16(vdev, CXL_DVSEC_STATUS_OFFSET, new_val);
> +}
> +
> +static void cxl_control2_write(struct vfio_pci_core_device *vdev,
> +			       u16 abs_off, u16 new_val)

abs_off not needed?

> +{
> +	struct pci_dev *pdev = vdev->pdev;
> +	u16 cap2 = dvsec_virt_read16(vdev, CXL_DVSEC_CAPABILITY2_OFFSET);
> +	u16 cap3 = dvsec_virt_read16(vdev, CXL_DVSEC_CAPABILITY3_OFFSET);
> +	u16 rev_mask = CXL_CTRL2_RESERVED_MASK;
> +	u16 hw_bits  = CXL_CTRL2_HW_BITS_MASK;
> +	bool initiate_cxl_reset = new_val & CXL_CTRL2_INITIATE_CXL_RESET_BIT;
> +
> +	if (!(cap3 & CXL_CAP3_VOLATILE_HDM_BIT))
> +		rev_mask |= CXL_CTRL2_VOLATILE_HDM_REV_MASK;
> +	if (!(cap2 & CXL_CAP2_MODIFIED_COMPLETION_BIT))
> +		rev_mask |= CXL_CTRL2_MODIFIED_COMP_REV_MASK;
> +
> +	new_val &= ~rev_mask;
> +
> +	/* Bits that go directly to hardware */
> +	hw_bits &= new_val;
> +

Bit 1 and 2 are always read 0 by hardware. Probably should clear it before writing to the virtual register?

> +	dvsec_virt_write16(vdev, CXL_DVSEC_CONTROL2_OFFSET, new_val);
> +
> +	if (hw_bits)
> +		pci_write_config_word(pdev, abs_off, hw_bits);
> +
> +	if (initiate_cxl_reset) {
> +		/* TODO: invoke CXL protocol reset via cxl subsystem */
> +		dev_warn(&pdev->dev, "vfio-cxl: CXL reset requested but not yet supported\n");
> +	}
> +}
> +
> +static void cxl_status2_write(struct vfio_pci_core_device *vdev,
> +			      u16 abs_off, u16 new_val)

abs_off not needed

> +{
> +	u16 cap3 = dvsec_virt_read16(vdev, CXL_DVSEC_CAPABILITY3_OFFSET);
> +
> +	/* RW1CS: write 1 to clear, but only if the capability is supported */
> +	if ((cap3 & CXL_CAP3_VOLATILE_HDM_BIT) &&
> +	    (new_val & CXL_STATUS2_RW1CS_BIT))
> +		pci_write_config_word(vdev->pdev, abs_off,
> +				      CXL_STATUS2_RW1CS_BIT);
> +	/* STATUS2 is not mirrored in vconfig - reads go to hardware */
> +}
> +
> +static void cxl_lock_write(struct vfio_pci_core_device *vdev,
> +			   u16 abs_off, u16 new_val)

abs_off not needed

> +{
> +	u16 cur_val = dvsec_virt_read16(vdev, CXL_DVSEC_LOCK_OFFSET);
> +
> +	/* Once the LOCK bit is set it can only be cleared by conventional reset */
> +	if (cur_val & CXL_CTRL_LOCK_BIT)
> +		return;
> +
> +	new_val &= ~CXL_LOCK_RESERVED_MASK;
> +	dvsec_virt_write16(vdev, CXL_DVSEC_LOCK_OFFSET, new_val);
> +}
> +
> +static void cxl_range_base_lo_write(struct vfio_pci_core_device *vdev,
> +				    u16 dvsec_off, u32 new_val)
> +{
> +	new_val &= ~CXL_BASE_LO_RESERVED_MASK;
> +	dvsec_virt_write32(vdev, dvsec_off, new_val);
> +}
> +
> +/*
> + * vfio_cxl_dvsec_readfn - per-device DVSEC read handler.
> + *
> + * Called via vfio_pci_dvsec_dispatch_read() for devices that have registered
> + * a dvsec_readfn.  Returns shadow vconfig values for virtualized DVSEC
> + * registers (CONTROL, STATUS, CONTROL2, LOCK) so that userspace reads reflect
> + * the emulated state rather than the raw hardware value.  All other DVSEC
> + * bytes are passed through to hardware via vfio_raw_config_read().
> + */

Provide proper kdoc function header

> +static int vfio_cxl_dvsec_readfn(struct vfio_pci_core_device *vdev,
> +				 int pos, int count,
> +				 struct perm_bits *perm,
> +				 int offset, __le32 *val)
> +{
> +	struct vfio_pci_cxl_state *cxl = vdev->cxl;
> +	u16 dvsec_off;
> +
> +	if (!cxl || (u16)pos < cxl->dvsec ||
> +	    (u16)pos >= cxl->dvsec + cxl->dvsec_length)
> +		return vfio_raw_config_read(vdev, pos, count, perm, offset, val);
> +
> +	dvsec_off = (u16)pos - cxl->dvsec;
> +
> +	switch (dvsec_off) {
> +	case CXL_DVSEC_CONTROL_OFFSET:
> +	case CXL_DVSEC_STATUS_OFFSET:
> +	case CXL_DVSEC_CONTROL2_OFFSET:
> +	case CXL_DVSEC_LOCK_OFFSET:
> +		/* Return shadow vconfig value for virtualized registers */
> +		memcpy(val, vdev->vconfig + pos, count);
> +		return count;
> +	default:
> +		return vfio_raw_config_read(vdev, pos, count,
> +					    perm, offset, val);
> +	}> +}
> +
> +/*
> + * vfio_cxl_dvsec_writefn - ecap_perms write handler for PCI_EXT_CAP_ID_DVSEC.
> + *
> + * Installed once into ecap_perms[PCI_EXT_CAP_ID_DVSEC].writefn by
> + * vfio_pci_init_perm_bits() when CONFIG_VFIO_CXL_CORE=y.  Applies to every
> + * device opened under vfio-pci; the vdev->cxl NULL check distinguishes CXL
> + * devices from non-CXL devices that happen to expose a DVSEC capability.
> + *
> + * @pos:    absolute byte position in config space
> + * @offset: byte offset within the capability structure

missing return value expectations
> + */
> +static int vfio_cxl_dvsec_writefn(struct vfio_pci_core_device *vdev,
> +				  int pos, int count,
> +				  struct perm_bits *perm,
> +				  int offset, __le32 val)
> +{
> +	struct vfio_pci_cxl_state *cxl = vdev->cxl;
> +	u16 abs_off = (u16)pos;
> +	u16 dvsec_off;
> +	u16 wval16;
> +	u32 wval32;
> +
> +	if (!cxl || (u16)pos < cxl->dvsec ||
> +	    (u16)pos >= cxl->dvsec + cxl->dvsec_length)
> +		return vfio_raw_config_write(vdev, pos, count, perm,
> +					     offset, val);
> +
> +	pci_dbg(vdev->pdev,
> +		"vfio_cxl: DVSEC write: abs=0x%04x dvsec_off=0x%04x "
> +		"count=%d raw_val=0x%08x\n",
> +		abs_off, abs_off - cxl->dvsec, count, le32_to_cpu(val));
> +
> +	dvsec_off = abs_off - cxl->dvsec;
> +
> +	/* Route to the appropriate per-register handler */
> +	switch (dvsec_off) {
> +	case CXL_DVSEC_CONTROL_OFFSET:
> +		wval16 = (u16)le32_to_cpu(val);
> +		cxl_control_write(vdev, abs_off, wval16);
> +		break;
> +	case CXL_DVSEC_STATUS_OFFSET:
> +		wval16 = (u16)le32_to_cpu(val);
> +		cxl_status_write(vdev, abs_off, wval16);
> +		break;
> +	case CXL_DVSEC_CONTROL2_OFFSET:
> +		wval16 = (u16)le32_to_cpu(val);
> +		cxl_control2_write(vdev, abs_off, wval16);
> +		break;
> +	case CXL_DVSEC_STATUS2_OFFSET:
> +		wval16 = (u16)le32_to_cpu(val);
> +		cxl_status2_write(vdev, abs_off, wval16);
> +		break;
> +	case CXL_DVSEC_LOCK_OFFSET:
> +		wval16 = (u16)le32_to_cpu(val);
> +		cxl_lock_write(vdev, abs_off, wval16);
> +		break;
> +	case CXL_DVSEC_RANGE1_BASE_HIGH_OFFSET:
> +	case CXL_DVSEC_RANGE2_BASE_HIGH_OFFSET:
> +		wval32 = le32_to_cpu(val);
> +		dvsec_virt_write32(vdev, dvsec_off, wval32);
> +		break;
> +	case CXL_DVSEC_RANGE1_BASE_LOW_OFFSET:
> +	case CXL_DVSEC_RANGE2_BASE_LOW_OFFSET:
> +		wval32 = le32_to_cpu(val);
> +		cxl_range_base_lo_write(vdev, dvsec_off, wval32);
> +		break;
> +	default:
> +		/* RO registers: header, capability, range sizes - discard */
> +		break;
> +	}
> +
> +	return count;
> +}
> +
> +/*
> + * vfio_cxl_setup_dvsec_perms - Install per-device CXL DVSEC read/write hooks.
> + *
> + * Called once per device open after vfio_config_init() has seeded vdev->vconfig
> + * from hardware.  Registers vfio_cxl_dvsec_readfn and vfio_cxl_dvsec_writefn
> + * as the per-device DVSEC handlers.  The global dispatch functions installed
> + * in ecap_perms[PCI_EXT_CAP_ID_DVSEC] at module init call these per-device
> + * hooks so that pci_config_map bytes remain PCI_EXT_CAP_ID_DVSEC throughout.

provide proper kdoc function header

> + *
> + * vfio_cxl_dvsec_readfn: returns vconfig shadow for CONTROL/STATUS/CONTROL2/
> + *   LOCK; passes all other DVSEC bytes through to hardware.
> + * vfio_cxl_dvsec_writefn: enforces per-register semantics (RW1C, forced
> + *   IO_ENABLE, reserved-bit masking) and stores results in vconfig.
> + *
> + * Also forces CXL.io IO_ENABLE in the CONTROL vconfig shadow so the initial
> + * read returns 1 even before the first write.
> + */
> +void vfio_cxl_setup_dvsec_perms(struct vfio_pci_core_device *vdev)
> +{
> +	u16 ctrl = dvsec_virt_read16(vdev, CXL_DVSEC_CONTROL_OFFSET);
> +
> +	/*
> +	 * Register per-device DVSEC read/write handlers.  The global
> +	 * ecap_perms[PCI_EXT_CAP_ID_DVSEC] dispatchers will call them.
> +	 *
> +	 * vfio_cxl_dvsec_readfn returns vconfig shadow values for the
> +	 * virtualized registers (CONTROL, STATUS, CONTROL2, LOCK) so that
> +	 * reads reflect emulated state rather than raw hardware.
> +	 *
> +	 * vfio_cxl_dvsec_writefn enforces per-register semantics (RW1C,
> +	 * forced IO_ENABLE, reserved-bit masking) and stores results in
> +	 * vconfig.  Because ecap_perms[DVSEC].writefn dispatches to this
> +	 * handler, the pci_config_map bytes remain as PCI_EXT_CAP_ID_DVSEC
> +	 * _ no PCI_CAP_ID_INVALID_VIRT marking is needed or wanted.
> +	 */
> +	vdev->dvsec_readfn  = vfio_cxl_dvsec_readfn;
> +	vdev->dvsec_writefn = vfio_cxl_dvsec_writefn;
> +
> +	/*
> +	 * vconfig is seeded from hardware at open time.  Force IO_ENABLE set
> +	 * in the CONTROL shadow so the initial read returns 1 even if the
> +	 * hardware reset value has it cleared.	 Subsequent writes are handled
> +	 * by cxl_control_write() which also forces this bit.
> +	 */
> +	ctrl |= CXL_CTRL_CXL_IO_ENABLE_BIT;
> +	dvsec_virt_write16(vdev, CXL_DVSEC_CONTROL_OFFSET, ctrl);
> +}
> +EXPORT_SYMBOL_GPL(vfio_cxl_setup_dvsec_perms);
> diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> index 15b6c0d75d9e..e18e992800f6 100644
> --- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
> +++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> @@ -26,6 +26,7 @@ static int vfio_cxl_create_device_state(struct vfio_pci_core_device *vdev,
>  	struct vfio_pci_cxl_state *cxl;
>  	bool cxl_mem_capable, is_cxl_type3;
>  	u16 cap_word;
> +	u32 hdr1;
>  
>  	/*
>  	 * The devm allocation for the CXL state remains for the entire time
> @@ -47,6 +48,9 @@ static int vfio_cxl_create_device_state(struct vfio_pci_core_device *vdev,
>  	cxl->dpa_region_idx = -1;
>  	cxl->comp_reg_region_idx = -1;
>  
> +	pci_read_config_dword(pdev, dvsec + PCI_DVSEC_HEADER1, &hdr1);
> +	cxl->dvsec_length = PCI_DVSEC_HEADER1_LEN(hdr1);
> +
>  	pci_read_config_word(pdev, dvsec + CXL_DVSEC_CAPABILITY_OFFSET,
>  			     &cap_word);
>  
> diff --git a/drivers/vfio/pci/cxl/vfio_cxl_priv.h b/drivers/vfio/pci/cxl/vfio_cxl_priv.h
> index 3ef8d923a7e8..158fe4e67f98 100644
> --- a/drivers/vfio/pci/cxl/vfio_cxl_priv.h
> +++ b/drivers/vfio/pci/cxl/vfio_cxl_priv.h
> @@ -31,6 +31,7 @@ struct vfio_pci_cxl_state {
>  	u32                          hdm_count;
>  	int                          dpa_region_idx;
>  	int                          comp_reg_region_idx;
> +	size_t                       dvsec_length;
>  	u16                          dvsec;
>  	u8                           comp_reg_bar;
>  	bool                         precommitted;
> @@ -76,9 +77,44 @@ struct vfio_pci_cxl_state {
>   * (CXL 2.0+ 8.1.3).
>   * Offsets are relative to the DVSEC capability base (cxl->dvsec).
>   */
> -#define CXL_DVSEC_CAPABILITY_OFFSET 0xa
> +#define CXL_DVSEC_CAPABILITY_OFFSET       0xa
> +#define CXL_DVSEC_CONTROL_OFFSET	  0xc
> +#define CXL_DVSEC_STATUS_OFFSET		  0xe
> +#define CXL_DVSEC_CONTROL2_OFFSET	  0x10
> +#define CXL_DVSEC_STATUS2_OFFSET	  0x12
> +#define CXL_DVSEC_LOCK_OFFSET		  0x14
> +#define CXL_DVSEC_CAPABILITY2_OFFSET	  0x16
> +#define CXL_DVSEC_RANGE1_SIZE_HIGH_OFFSET 0x18
> +#define CXL_DVSEC_RANGE1_SIZE_LOW_OFFSET  0x1c
> +#define CXL_DVSEC_RANGE1_BASE_HIGH_OFFSET 0x20
> +#define CXL_DVSEC_RANGE1_BASE_LOW_OFFSET  0x24
> +#define CXL_DVSEC_RANGE2_SIZE_HIGH_OFFSET 0x28
> +#define CXL_DVSEC_RANGE2_SIZE_LOW_OFFSET  0x2c
> +#define CXL_DVSEC_RANGE2_BASE_HIGH_OFFSET 0x30
> +#define CXL_DVSEC_RANGE2_BASE_LOW_OFFSET  0x34
> +#define CXL_DVSEC_CAPABILITY3_OFFSET	  0x38
> +
>  #define CXL_DVSEC_MEM_CAPABLE	    BIT(2)
>  
> +/* CXL Control / Status / Lock - bit definitions */
> +#define CXL_CTRL_LOCK_BIT		 BIT(0)

CXL_CTRL_CONFIG_LOCK_BIT

> +#define CXL_CTRL_CXL_IO_ENABLE_BIT	 BIT(1)
> +#define CXL_CTRL2_INITIATE_CXL_RESET_BIT BIT(2)
> +#define CXL_CAP3_VOLATILE_HDM_BIT	 BIT(3)
> +#define CXL_STATUS2_RW1CS_BIT		 BIT(3)

CXL_STATUS2_VOL_HDM_PRSV_ERR_BIT

> +#define CXL_CAP3_P2P_BIT		 BIT(4)
> +#define CXL_CAP2_MODIFIED_COMPLETION_BIT BIT(6)
> +#define CXL_STATUS_RW1C_BIT		 BIT(14)

CXL_STATUS_VIRAL_STATUS_BIT

> +#define CXL_CTRL_RESERVED_MASK		 (BIT(13) | BIT(15))
> +#define CXL_CTRL_P2P_REV_MASK		 BIT(12)
> +#define CXL_STATUS_RESERVED_MASK	 (GENMASK(13, 0) | BIT(15))
> +#define CXL_CTRL2_RESERVED_MASK		 GENMASK(15, 6)
> +#define CXL_CTRL2_HW_BITS_MASK		 (BIT(0) | BIT(1) | BIT(3))
> +#define CXL_CTRL2_VOLATILE_HDM_REV_MASK	 BIT(4)
> +#define CXL_CTRL2_MODIFIED_COMP_REV_MASK BIT(5)
> +#define CXL_LOCK_RESERVED_MASK		 GENMASK(15, 1)
> +#define CXL_BASE_LO_RESERVED_MASK	 GENMASK(27, 0)

Move the CXL reg offset and bit defs to a common header. Also, please group the relevant bits together per register.

DJ

> +
>  int vfio_cxl_setup_virt_regs(struct vfio_pci_core_device *vdev);
>  void vfio_cxl_clean_virt_regs(struct vfio_pci_core_device *vdev);
>  void vfio_cxl_reinit_comp_regs(struct vfio_pci_core_device *vdev);
> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index d3138badeaa6..22cf9ea831f9 100644
> --- a/drivers/vfio/pci/vfio_pci.c
> +++ b/drivers/vfio/pci/vfio_pci.c
> @@ -121,12 +121,26 @@ static int vfio_pci_open_device(struct vfio_device *core_vdev)
>  	}
>  
>  	if (vdev->cxl) {
> +		/*
> +		 * pci_config_map and vconfig are valid now (allocated by
> +		 * vfio_config_init() inside vfio_pci_core_enable() above).
> +		 */
> +		vfio_cxl_setup_dvsec_perms(vdev);
> +
>  		ret = vfio_cxl_register_cxl_region(vdev);
>  		if (ret) {
>  			pci_warn(pdev, "Failed to setup CXL region\n");
>  			vfio_pci_core_disable(vdev);
>  			return ret;
>  		}
> +
> +		ret = vfio_cxl_register_comp_regs_region(vdev);
> +		if (ret) {
> +			pci_warn(pdev, "Failed to register COMP_REGS region\n");
> +			vfio_cxl_unregister_cxl_region(vdev);
> +			vfio_pci_core_disable(vdev);
> +			return ret;
> +		}
>  	}
>  
>  	vfio_pci_core_finish_enable(vdev);
> diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
> index 79aaf270adb2..90e2c25381d6 100644
> --- a/drivers/vfio/pci/vfio_pci_config.c
> +++ b/drivers/vfio/pci/vfio_pci_config.c
> @@ -1085,6 +1085,49 @@ static int __init init_pci_ext_cap_pwr_perm(struct perm_bits *perm)
>  	return 0;
>  }
>  
> +/*
> + * vfio_pci_dvsec_dispatch_read - per-device DVSEC read dispatcher.
> + *
> + * Installed as ecap_perms[PCI_EXT_CAP_ID_DVSEC].readfn at module init.
> + * Calls vdev->dvsec_readfn when a shadow-read handler has been registered
> + * (e.g. by vfio_cxl_setup_dvsec_perms() for CXL Type-2 devices), otherwise
> + * falls through to vfio_raw_config_read for hardware pass-through.
> + *
> + * This indirection allows per-device DVSEC reads from vconfig shadow
> + * without touching the global ecap_perms[] table.
> + */
> +static int vfio_pci_dvsec_dispatch_read(struct vfio_pci_core_device *vdev,
> +					int pos, int count,
> +					struct perm_bits *perm,
> +					int offset, __le32 *val)
> +{
> +	if (vdev->dvsec_readfn)
> +		return vdev->dvsec_readfn(vdev, pos, count, perm, offset, val);
> +	return vfio_raw_config_read(vdev, pos, count, perm, offset, val);
> +}
> +
> +/*
> + * vfio_pci_dvsec_dispatch_write - per-device DVSEC write dispatcher.
> + *
> + * Installed as ecap_perms[PCI_EXT_CAP_ID_DVSEC].writefn at module init.
> + * Calls vdev->dvsec_writefn when a handler has been registered for this
> + * device (e.g. by vfio_cxl_setup_dvsec_perms() for CXL Type-2 devices),
> + * otherwise falls through to vfio_raw_config_write so that non-CXL
> + * devices with a DVSEC capability continue to pass writes to hardware.
> + *
> + * This indirection allows per-device DVSEC handlers to be registered
> + * without touching the global ecap_perms[] table.
> + */
> +static int vfio_pci_dvsec_dispatch_write(struct vfio_pci_core_device *vdev,
> +					 int pos, int count,
> +					 struct perm_bits *perm,
> +					 int offset, __le32 val)
> +{
> +	if (vdev->dvsec_writefn)
> +		return vdev->dvsec_writefn(vdev, pos, count, perm, offset, val);
> +	return vfio_raw_config_write(vdev, pos, count, perm, offset, val);
> +}
> +
>  /*
>   * Initialize the shared permission tables
>   */
> @@ -1121,7 +1164,8 @@ int __init vfio_pci_init_perm_bits(void)
>  	ret |= init_pci_ext_cap_err_perm(&ecap_perms[PCI_EXT_CAP_ID_ERR]);
>  	ret |= init_pci_ext_cap_pwr_perm(&ecap_perms[PCI_EXT_CAP_ID_PWR]);
>  	ecap_perms[PCI_EXT_CAP_ID_VNDR].writefn = vfio_raw_config_write;
> -	ecap_perms[PCI_EXT_CAP_ID_DVSEC].writefn = vfio_raw_config_write;
> +	ecap_perms[PCI_EXT_CAP_ID_DVSEC].readfn  = vfio_pci_dvsec_dispatch_read;
> +	ecap_perms[PCI_EXT_CAP_ID_DVSEC].writefn = vfio_pci_dvsec_dispatch_write;
>  
>  	if (ret)
>  		vfio_pci_uninit_perm_bits();
> diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
> index f8db9a05c033..d778107fa908 100644
> --- a/drivers/vfio/pci/vfio_pci_priv.h
> +++ b/drivers/vfio/pci/vfio_pci_priv.h
> @@ -154,6 +154,7 @@ void vfio_cxl_zap_region_locked(struct vfio_pci_core_device *vdev);
>  void vfio_cxl_reactivate_region(struct vfio_pci_core_device *vdev);
>  int  vfio_cxl_register_comp_regs_region(struct vfio_pci_core_device *vdev);
>  void vfio_cxl_reinit_comp_regs(struct vfio_pci_core_device *vdev);
> +void vfio_cxl_setup_dvsec_perms(struct vfio_pci_core_device *vdev);
>  
>  #else
>  
> @@ -180,6 +181,8 @@ vfio_cxl_register_comp_regs_region(struct vfio_pci_core_device *vdev)
>  { return 0; }
>  static inline void
>  vfio_cxl_reinit_comp_regs(struct vfio_pci_core_device *vdev) { }
> +static inline void
> +vfio_cxl_setup_dvsec_perms(struct vfio_pci_core_device *vdev) { }
>  
>  #endif /* CONFIG_VFIO_CXL_CORE */
>  
> diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
> index cd8ed98a82a3..aa159d0c8da7 100644
> --- a/include/linux/vfio_pci_core.h
> +++ b/include/linux/vfio_pci_core.h
> @@ -31,7 +31,7 @@ struct p2pdma_provider;
>  struct dma_buf_phys_vec;
>  struct dma_buf_attachment;
>  struct vfio_pci_cxl_state;
> -
> +struct perm_bits;
>  
>  struct vfio_pci_eventfd {
>  	struct eventfd_ctx	*ctx;
> @@ -141,6 +141,12 @@ struct vfio_pci_core_device {
>  	struct list_head	ioeventfds_list;
>  	struct vfio_pci_vf_token	*vf_token;
>  	struct vfio_pci_cxl_state *cxl;
> +	int (*dvsec_readfn)(struct vfio_pci_core_device *vdev, int pos,
> +			    int count, struct perm_bits *perm,
> +			    int offset, __le32 *val);
> +	int (*dvsec_writefn)(struct vfio_pci_core_device *vdev, int pos,
> +			     int count, struct perm_bits *perm,
> +			     int offset, __le32 val);
>  	struct list_head		sriov_pfs_item;
>  	struct vfio_pci_core_device	*sriov_pf_core_dev;
>  	struct notifier_block	nb;

