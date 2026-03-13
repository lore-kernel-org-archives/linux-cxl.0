Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7505D2DF12F;
	Fri, 13 Mar 2026 19:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773428736; cv=none; b=oc+CrLsmPOZO/IOiV/KwHk/WoxuUO7M/jr/cpDgKh7zzRVeLDelas6VIle+Z5VtCgGyC5evLqwdfW5qIENdI5V1xP3VXyg1Vmrssuih0twIDPIVFCYZ6x6/BNb2PpoAUSMxIilHfHQ8ScGeU0DcYZPIXSc14/sVkeXeI87i7dYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773428736; c=relaxed/simple;
	bh=lx8ty+X+t4ZEgvHj5IPGuqL7COOkTD6VSN1ffkKJ2pU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sgsxc7zyeD+k+Q35PudP3e8udD1Jb5XwV8HlveFkyg/HnYxb8HNBUOMcd72hENQqMdKxxCSoMszdxD4VgHVWILG4y4w+8Bh+0B/sc6sZ4kLR/48WEz8w+ASnC5Ch9ZXmZR1qwqsqXFPohSX96njKYTKrKYTr+X7vI3gVb/WAP3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nUoeV1hp; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nUoeV1hp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773428735; x=1804964735;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lx8ty+X+t4ZEgvHj5IPGuqL7COOkTD6VSN1ffkKJ2pU=;
  b=nUoeV1hpRpVlcjIRaQFaj9SwKXyLtAtCaq0702WqYn+xhZeB7haCrXtT
   R+m7nLKQ8SRxY4VTzFCUv8jvRoCAxeSis5VVhgErBMcm8ofD/FWiqSBTd
   pHSJLWecebIm8Yq1muNglvVV63syLNzrMYt+P9vatc7CB34Eb1c/O1aaS
   31UzlYUpfHaKwwtxtrqgJtmvIftIBGpYbwQOpJOErwkhSziOe7WwTZ68Q
   xBJVQLxoRBfYUyoJePy0DaUHo/xLtBy84J9RiRYq21Qd2cW6f/sp0TqmI
   YyTYDXoCRdT6kRzi+GS0J/Hdt6om2txhDuCO5Ju8nKQkzflgLOnQZDzyO
   Q==;
X-CSE-ConnectionGUID: f+PLwlT1SkqWzglOpY5wTw==
X-CSE-MsgGUID: dVq0cCwkQbOFwm9QiCTS1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11728"; a="100003714"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="100003714"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 12:05:35 -0700
X-CSE-ConnectionGUID: +fjpag5pQtiVQxYJ5pAEaQ==
X-CSE-MsgGUID: XkXzouXTTdOxfg26F7BeUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="217646209"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.110.233]) ([10.125.110.233])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 12:05:32 -0700
Message-ID: <38c39921-55b7-4f17-86ab-eaa6082f9d96@intel.com>
Date: Fri, 13 Mar 2026 12:05:30 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/20] vfio/cxl: Introduce HDM decoder register emulation
 framework
To: mhonap@nvidia.com, aniketa@nvidia.com, ankita@nvidia.com,
 alwilliamson@nvidia.com, vsethi@nvidia.com, jgg@nvidia.com,
 mochs@nvidia.com, skolothumtho@nvidia.com, alejandro.lucero-palau@amd.com,
 dave@stgolabs.net, jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 jgg@ziepe.ca, yishaih@nvidia.com, kevin.tian@intel.com
Cc: cjia@nvidia.com, targupta@nvidia.com, zhiw@nvidia.com, kjaju@nvidia.com,
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org, kvm@vger.kernel.org
References: <20260311203440.752648-1-mhonap@nvidia.com>
 <20260311203440.752648-14-mhonap@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260311203440.752648-14-mhonap@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 3/11/26 1:34 PM, mhonap@nvidia.com wrote:
> From: Manish Honap <mhonap@nvidia.com>
> 
> Introduce an emulation framework to handle CXL MMIO register emulation
> for CXL devices passed through to a VM.
> 
> A single compact __le32 array (comp_reg_virt) covers only the HDM
> decoder register block (hdm_reg_size bytes, typically 256-512 bytes).
> 
> A new VFIO device region VFIO_REGION_SUBTYPE_CXL_COMP_REGS exposes
> this array to userspace (QEMU) as a read-write region:
>   - Reads return the emulated state (comp_reg_virt[])
>   - Writes go through the HDM register write handlers and are
>     forwarded to hardware where appropriate
> 
> QEMU attaches a notify_change callback to this region. When the
> COMMIT bit is written in a decoder CTRL register the callback
> reads the BASE_LO/HI from the same region fd (emulated state) and
> maps the DPA MemoryRegion at the correct GPA in system_memory.
> 
> Co-developed-by: Zhi Wang <zhiw@nvidia.com>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> Signed-off-by: Manish Honap <mhonap@nvidia.com>
> ---
>  drivers/vfio/pci/Makefile            |   2 +-
>  drivers/vfio/pci/cxl/vfio_cxl_core.c |  36 ++-
>  drivers/vfio/pci/cxl/vfio_cxl_emu.c  | 366 +++++++++++++++++++++++++++
>  drivers/vfio/pci/cxl/vfio_cxl_priv.h |  41 +++
>  drivers/vfio/pci/vfio_pci_priv.h     |   7 +
>  5 files changed, 450 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/vfio/pci/cxl/vfio_cxl_emu.c
> 
> diff --git a/drivers/vfio/pci/Makefile b/drivers/vfio/pci/Makefile
> index ecb0eacbc089..bef916495eae 100644
> --- a/drivers/vfio/pci/Makefile
> +++ b/drivers/vfio/pci/Makefile
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  
>  vfio-pci-core-y := vfio_pci_core.o vfio_pci_intrs.o vfio_pci_rdwr.o vfio_pci_config.o
> -vfio-pci-core-$(CONFIG_VFIO_CXL_CORE) += cxl/vfio_cxl_core.o
> +vfio-pci-core-$(CONFIG_VFIO_CXL_CORE) += cxl/vfio_cxl_core.o cxl/vfio_cxl_emu.o
>  vfio-pci-core-$(CONFIG_VFIO_PCI_ZDEV_KVM) += vfio_pci_zdev.o
>  vfio-pci-core-$(CONFIG_VFIO_PCI_DMABUF) += vfio_pci_dmabuf.o
>  obj-$(CONFIG_VFIO_PCI_CORE) += vfio-pci-core.o
> diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> index 03846bd11c8a..d2401871489d 100644
> --- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
> +++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> @@ -45,6 +45,7 @@ static int vfio_cxl_create_device_state(struct vfio_pci_core_device *vdev,
>  	cxl = vdev->cxl;
>  	cxl->dvsec = dvsec;
>  	cxl->dpa_region_idx = -1;
> +	cxl->comp_reg_region_idx = -1;
>  
>  	pci_read_config_word(pdev, dvsec + CXL_DVSEC_CAPABILITY_OFFSET,
>  			     &cap_word);
> @@ -124,6 +125,10 @@ static int vfio_cxl_setup_regs(struct vfio_pci_core_device *vdev)
>  	cxl->comp_reg_offset = bar_offset;
>  	cxl->comp_reg_size = CXL_COMPONENT_REG_BLOCK_SIZE;
>  
> +	ret = vfio_cxl_setup_virt_regs(vdev);
> +	if (ret)
> +		return ret;
> +
>  	return 0;
>  }
>  
> @@ -281,12 +286,14 @@ void vfio_pci_cxl_detect_and_init(struct vfio_pci_core_device *vdev)
>  
>  	ret = vfio_cxl_create_region_helper(vdev, SZ_256M);
>  	if (ret)
> -		goto failed;
> +		goto regs_failed;
>  
>  	cxl->precommitted = true;
>  
>  	return;
>  
> +regs_failed:
> +	vfio_cxl_clean_virt_regs(vdev);
>  failed:
>  	devm_kfree(&pdev->dev, vdev->cxl);
>  	vdev->cxl = NULL;
> @@ -299,6 +306,7 @@ void vfio_pci_cxl_cleanup(struct vfio_pci_core_device *vdev)
>  	if (!cxl || !cxl->region)
>  		return;
>  
> +	vfio_cxl_clean_virt_regs(vdev);
>  	vfio_cxl_destroy_cxl_region(vdev);
>  }
>  
> @@ -409,6 +417,32 @@ void vfio_cxl_reactivate_region(struct vfio_pci_core_device *vdev)
>  
>  	if (!cxl)
>  		return;
> +
> +	/*
> +	 * Re-initialise the emulated HDM comp_reg_virt[] from hardware.
> +	 * After FLR the decoder registers read as zero; mirror that in
> +	 * the emulated state so QEMU sees a clean slate.
> +	 */
> +	vfio_cxl_reinit_comp_regs(vdev);
> +
> +	/*
> +	 * Only re-enable the DPA mmap if the hardware has actually
> +	 * re-committed decoder 0 after FLR.  Read the COMMITTED bit from the
> +	 * freshly-re-snapshotted comp_reg_virt[] so we check the post-FLR
> +	 * hardware state, not stale pre-reset state.
> +	 *
> +	 * If COMMITTED is 0 (slow firmware re-commit path), leave
> +	 * region_active=false.  Guest faults will return VM_FAULT_SIGBUS
> +	 * until the decoder is re-committed and the region is re-enabled.
> +	 */
> +	if (cxl->precommitted && cxl->comp_reg_virt) {
> +		u32 ctrl = le32_to_cpu(cxl->comp_reg_virt[
> +				       CXL_HDM_DECODER0_CTRL_OFFSET(0) /
> +				       CXL_REG_SIZE_DWORD]);
> +
> +		if (ctrl & CXL_HDM_DECODER_CTRL_COMMITTED_BIT)
> +			WRITE_ONCE(cxl->region_active, true);
> +	}
>  }
>  
>  static ssize_t vfio_cxl_region_rw(struct vfio_pci_core_device *core_dev,
> diff --git a/drivers/vfio/pci/cxl/vfio_cxl_emu.c b/drivers/vfio/pci/cxl/vfio_cxl_emu.c
> new file mode 100644
> index 000000000000..d5603c80fe51
> --- /dev/null
> +++ b/drivers/vfio/pci/cxl/vfio_cxl_emu.c
> @@ -0,0 +1,366 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2026, NVIDIA CORPORATION & AFFILIATES. All rights reserved
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/vfio_pci_core.h>
> +
> +#include "../vfio_pci_priv.h"
> +#include "vfio_cxl_priv.h"
> +
> +/*
> + * comp_reg_virt[] layout:
> + *   Index 0..N correspond to 32-bit registers at byte offset 0..hdm_reg_size-4
> + *   within the HDM decoder capability block.
> + *
> + * Register layout within the HDM block (CXL spec 8.2.5.19):
> + *   0x00: HDM Decoder Capability
> + *   0x04: HDM Decoder Global Control
> + *   0x08: HDM Decoder Global Status
> + *   0x0c: (reserved)
> + *   For each decoder N (N=0..hdm_count-1), at base 0x10 + N*0x20:
> + *     +0x00: BASE_LO
> + *     +0x04: BASE_HI
> + *     +0x08: SIZE_LO
> + *     +0x0c: SIZE_HI
> + *     +0x10: CTRL
> + *     +0x14: TARGET_LIST_LO
> + *     +0x18: TARGET_LIST_HI
> + *     +0x1c: (reserved)
> + */
> +
> +static inline __le32 *hdm_reg_ptr(struct vfio_pci_cxl_state *cxl, u32 off)
> +{
> +	/*
> +	 * off is byte offset within the HDM block; comp_reg_virt is indexed
> +	 * as an array of __le32.
> +	 */
> +	return &cxl->comp_reg_virt[off / sizeof(__le32)];
> +}
> +
> +static ssize_t virt_hdm_rev_reg_write(struct vfio_pci_core_device *vdev,
> +				      const __le32 *val32, u64 offset, u64 size)
> +{
> +	/* Discard writes on reserved registers. */
> +	return size;
> +}
> +
> +static ssize_t hdm_decoder_n_lo_write(struct vfio_pci_core_device *vdev,
> +				      const __le32 *val32, u64 offset, u64 size)
> +{> +	u32 new_val = le32_to_cpu(*val32);
> +
> +	if (WARN_ON_ONCE(size != CXL_REG_SIZE_DWORD))
> +		return -EINVAL;
> +> +	/* Bit [27:0] are reserved. */
> +	new_val &= ~CXL_HDM_DECODER_BASE_LO_RESERVED_MASK;
> +
> +	*hdm_reg_ptr(vdev->cxl, offset) = cpu_to_le32(new_val);
> +
> +	return size;
> +}
> +
> +static ssize_t hdm_decoder_global_ctrl_write(struct vfio_pci_core_device *vdev,
> +					     const __le32 *val32, u64 offset, u64 size)
Why offset? If the dispatch function already checked and confirmed this is the offset for the global ctrl register then there's no need to pass in the offset.

> +{
> +	u32 hdm_decoder_global_cap;
> +	u32 new_val = le32_to_cpu(*val32);
> +
> +	if (WARN_ON_ONCE(size != CXL_REG_SIZE_DWORD))
> +		return -EINVAL;
> +> +	/* Bit [31:2] are reserved. */
> +	new_val &= ~CXL_HDM_DECODER_GLOBAL_CTRL_RESERVED_MASK;
> +
> +	/* Poison On Decode Error Enable bit is 0 and RO if not support. */
> +	hdm_decoder_global_cap = le32_to_cpu(*hdm_reg_ptr(vdev->cxl, 0));
> +	if (!(hdm_decoder_global_cap & CXL_HDM_CAP_POISON_ON_DECODE_ERR_BIT))
> +		new_val &= ~CXL_HDM_DECODER_GLOBAL_CTRL_POISON_EN_BIT;
> +
> +	*hdm_reg_ptr(vdev->cxl, offset) = cpu_to_le32(new_val);
> +
> +	return size;
> +}
> +
> +/*
> + * hdm_decoder_n_ctrl_write - Write handler for HDM decoder CTRL register.

If we are going to start with kdoc style comment, may as well finish the kdoc block and provide parameters and return values

> + *
> + * The COMMIT bit (bit 9) is the key: setting it requests the hardware to
> + * lock the decoder.  The emulated COMMITTED bit (bit 10) mirrors COMMIT
> + * immediately to allow QEMU's notify_change to detect the transition and
> + * map/unmap the DPA MemoryRegion in the guest address space.
> + *
> + * Note: the actual hardware HDM decoder programming (writing the real
> + * BASE/SIZE with host physical addresses) happens in the QEMU notify_change
> + * callback BEFORE this write reaches the hardware.  This ordering is
> + * correct because vfio_region_write() calls notify_change() first.
> + */
> +static ssize_t hdm_decoder_n_ctrl_write(struct vfio_pci_core_device *vdev,
> +					const __le32 *val32, u64 offset, u64 size)
> +{
> +	u32 hdm_decoder_global_cap;
> +	u32 ro_mask = CXL_HDM_DECODER_CTRL_RO_BITS_MASK;
> +	u32 rev_mask = CXL_HDM_DECODER_CTRL_RESERVED_MASK;
> +	u32 new_val = le32_to_cpu(*val32);
> +	u32 cur_val;
> +
> +	if (WARN_ON_ONCE(size != CXL_REG_SIZE_DWORD))
> +		return -EINVAL;
> +
> +	cur_val = le32_to_cpu(*hdm_reg_ptr(vdev->cxl, offset));
> +	if (cur_val & CXL_HDM_DECODER_CTRL_COMMIT_LOCK_BIT)
> +		return size;
> +
> +	hdm_decoder_global_cap = le32_to_cpu(*hdm_reg_ptr(vdev->cxl, 0));
> +	ro_mask |= CXL_HDM_DECODER_CTRL_DEVICE_BITS_RO;
> +	rev_mask |= CXL_HDM_DECODER_CTRL_DEVICE_RESERVED;
> +	if (!(hdm_decoder_global_cap & CXL_HDM_CAP_UIO_SUPPORTED_BIT))
> +		rev_mask |= CXL_HDM_DECODER_CTRL_UIO_RESERVED;
> +
> +	new_val &= ~rev_mask;
> +	cur_val &= ro_mask;
> +	new_val = (new_val & ~ro_mask) | cur_val;
> +
> +	/*
> +	 * Mirror COMMIT → COMMITTED immediately in the emulated state.
> +	 * QEMU's notify_change (called before this write reaches hardware)
> +	 * reads COMMITTED from the region fd to detect commit transitions.
> +	 */
> +	if (new_val & CXL_HDM_DECODER_CTRL_COMMIT_BIT)
> +		new_val |= CXL_HDM_DECODER_CTRL_COMMITTED_BIT;
> +	else
> +		new_val &= ~CXL_HDM_DECODER_CTRL_COMMITTED_BIT;
> +
> +	*hdm_reg_ptr(vdev->cxl, offset) = cpu_to_le32(new_val);
> +
> +	return size;
> +}
> +
> +/*
> + * Dispatch table for COMP_REGS region writes.	Indexed by byte offset within
> + * the HDM decoder block.  Returns the appropriate write handler.
> + *
> + * Layout:
> + *   0x00	  HDM Decoder Capability  (RO)
> + *   0x04	  HDM Global Control	  (RW with reserved masking)
> + *   0x08	  HDM Global Status	  (RO)
> + *   0x0c	  (reserved)		  (ignored)
> + *   Per decoder N, base = 0x10 + N*0x20:
> + *     base+0x00  BASE_LO  (RW, [27:0] reserved)
> + *     base+0x04  BASE_HI  (RW)
> + *     base+0x08  SIZE_LO  (RW, [27:0] reserved)
> + *     base+0x0c  SIZE_HI  (RW)
> + *     base+0x10  CTRL	   (RW, complex rules)
> + *     base+0x14  TARGET_LIST_LO  (ignored for Type-2)
> + *     base+0x18  TARGET_LIST_HI  (ignored for Type-2)
> + *     base+0x1c  (reserved)	 (ignored)
> + */
> +static ssize_t comp_regs_dispatch_write(struct vfio_pci_core_device *vdev,
> +					u32 off, const __le32 *val32, u32 size)
> +{
> +	struct vfio_pci_cxl_state *cxl = vdev->cxl;
> +	u32 dec_base, dec_off;
> +
> +	/* HDM Decoder Capability (0x00): RO */
> +	if (off == 0x00)

define magic number

> +		return size;
> +
> +	/* HDM Global Control (0x04) */
> +	if (off == CXL_HDM_DECODER_GLOBAL_CTRL_OFFSET)
> +		return hdm_decoder_global_ctrl_write(vdev, val32, off, size);
> +
> +	/* HDM Global Status (0x08): RO */
> +	if (off == 0x08)

define magic number

> +		return size;
> +
> +	/* Per-decoder registers start at 0x10, stride 0x20 */
> +	if (off < CXL_HDM_DECODER_FIRST_BLOCK_OFFSET)
> +		return size; /* reserved gap */
> +
> +	dec_base = CXL_HDM_DECODER_FIRST_BLOCK_OFFSET;
> +	dec_off	 = (off - dec_base) % CXL_HDM_DECODER_BLOCK_STRIDE;

Need a check here to make sure offset is within the number of supported decoders.

> +
> +	switch (dec_off) {
> +	case CXL_HDM_DECODER_N_BASE_LOW_OFFSET:	 /* BASE_LO */
> +	case CXL_HDM_DECODER_N_SIZE_LOW_OFFSET:	 /* SIZE_LO */
> +		return hdm_decoder_n_lo_write(vdev, val32, off, size);
> +	case CXL_HDM_DECODER_N_BASE_HIGH_OFFSET: /* BASE_HI */
> +	case CXL_HDM_DECODER_N_SIZE_HIGH_OFFSET: /* SIZE_HI */
> +		/* Full 32-bit write, no reserved bits */
> +		*hdm_reg_ptr(cxl, off) = *val32;
> +		return size;
> +	case CXL_HDM_DECODER_N_CTRL_OFFSET:	  /* CTRL */
> +		return hdm_decoder_n_ctrl_write(vdev, val32, off, size);
> +	case CXL_HDM_DECODER_N_TARGET_LIST_LOW_OFFSET:
> +	case CXL_HDM_DECODER_N_TARGET_LIST_HIGH_OFFSET:
> +	case CXL_HDM_DECODER_N_REV_OFFSET:
> +		return virt_hdm_rev_reg_write(vdev, val32, off, size);
> +	default:
> +		return size;
> +	}
> +}
> +
> +/*
> + * vfio_cxl_comp_regs_rw - regops rw handler for VFIO_REGION_SUBTYPE_CXL_COMP_REGS.
> + *
> + * Reads return the emulated HDM state (comp_reg_virt[]).
> + * Writes go through comp_regs_dispatch_write() for bit-field enforcement.
> + * Only 4-byte aligned 4-byte accesses are supported (hardware requirement).
> + */
> +static ssize_t vfio_cxl_comp_regs_rw(struct vfio_pci_core_device *vdev,
> +				     char __user *buf, size_t count,
> +				     loff_t *ppos, bool iswrite)
> +{
> +	struct vfio_pci_cxl_state *cxl = vdev->cxl;
> +	loff_t pos = *ppos & VFIO_PCI_OFFSET_MASK;
> +	size_t done = 0;
> +
> +	if (!count)
> +		return 0;
> +
> +	/* Clamp to region size */
> +	if (pos >= cxl->hdm_reg_size)
> +		return -EINVAL;
> +	count = min(count, (size_t)(cxl->hdm_reg_size - pos));
> +
> +	while (done < count) {
> +		u32 sz	 = min_t(u32, CXL_REG_SIZE_DWORD, count - done);
> +		u32 off	 = pos + done;
> +		__le32 v;
> +
> +		/* Enforce 4-byte alignment */
> +		if (sz < CXL_REG_SIZE_DWORD || (off & 0x3))
> +			return done ? (ssize_t)done : -EINVAL;
> +
> +		if (iswrite) {
> +			if (copy_from_user(&v, buf + done, sizeof(v)))
> +				return done ? (ssize_t)done : -EFAULT;
> +			comp_regs_dispatch_write(vdev, off, &v, sizeof(v));
> +		} else {
> +			v = *hdm_reg_ptr(cxl, off);
> +			if (copy_to_user(buf + done, &v, sizeof(v)))
> +				return done ? (ssize_t)done : -EFAULT;
> +		}
> +		done += sizeof(v);
> +	}
> +
> +	*ppos += done;
> +	return done;
> +}
> +
> +static void vfio_cxl_comp_regs_release(struct vfio_pci_core_device *vdev,
> +				       struct vfio_pci_region *region)
> +{
> +	/* comp_reg_virt is freed in vfio_cxl_clean_virt_regs(), not here. */
> +}
> +
> +static const struct vfio_pci_regops vfio_cxl_comp_regs_ops = {
> +	.rw	 = vfio_cxl_comp_regs_rw,
> +	.release = vfio_cxl_comp_regs_release,
> +};
> +
> +/*
> + * vfio_cxl_setup_virt_regs - Allocate emulated HDM register state.
> + *
> + * Allocates comp_reg_virt as a compact __le32 array covering only
> + * hdm_reg_size bytes of HDM decoder registers. The initial values
> + * are read from hardware via the BAR ioremap established by the caller.
> + *
> + * DVSEC state is accessed via vdev->vconfig (see the following patch).
> + */
> +int vfio_cxl_setup_virt_regs(struct vfio_pci_core_device *vdev)
> +{
> +	struct vfio_pci_cxl_state *cxl = vdev->cxl;
> +	size_t nregs;
> +
> +	if (WARN_ON(!cxl->hdm_reg_size))
> +		return -EINVAL;
> +
> +	if (pci_resource_len(vdev->pdev, cxl->comp_reg_bar) <
> +	    cxl->comp_reg_offset + cxl->hdm_reg_offset + cxl->hdm_reg_size)
> +		return -ENODEV;
> +
> +	nregs = cxl->hdm_reg_size / sizeof(__le32);
> +	cxl->comp_reg_virt = kcalloc(nregs, sizeof(__le32), GFP_KERNEL);
> +	if (!cxl->comp_reg_virt)
> +		return -ENOMEM;
> +
> +	/* Establish persistent mapping; kept alive until vfio_cxl_clean_virt_regs(). */
> +	cxl->hdm_iobase = ioremap(pci_resource_start(vdev->pdev, cxl->comp_reg_bar) +
> +				  cxl->comp_reg_offset + cxl->hdm_reg_offset,
> +				  cxl->hdm_reg_size);
> +	if (!cxl->hdm_iobase) {
> +		kfree(cxl->comp_reg_virt);
> +		cxl->comp_reg_virt = NULL;
> +		return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * Called with memory_lock write side held (from vfio_cxl_reactivate_region).
> + * Uses the pre-established hdm_iobase, no ioremap() under the lock,
> + * which would deadlock on PREEMPT_RT where ioremap() can sleep.
> + */
> +void vfio_cxl_reinit_comp_regs(struct vfio_pci_core_device *vdev)
> +{
> +	struct vfio_pci_cxl_state *cxl = vdev->cxl;
> +	size_t i, nregs;
> +
> +	if (!cxl || !cxl->comp_reg_virt || !cxl->hdm_iobase)
> +		return;
> +
> +	nregs = cxl->hdm_reg_size / sizeof(__le32);
> +
> +	for (i = 0; i < nregs; i++)
> +		cxl->comp_reg_virt[i] =
> +			cpu_to_le32(readl(cxl->hdm_iobase + i * sizeof(__le32)));
> +}
> +
> +void vfio_cxl_clean_virt_regs(struct vfio_pci_core_device *vdev)
> +{
> +	struct vfio_pci_cxl_state *cxl = vdev->cxl;
> +
> +	if (cxl->hdm_iobase) {
> +		iounmap(cxl->hdm_iobase);
> +		cxl->hdm_iobase = NULL;
> +	}
> +	kfree(cxl->comp_reg_virt);
> +	cxl->comp_reg_virt = NULL;
> +}
> +
> +/*
> + * vfio_cxl_register_comp_regs_region - Register the COMP_REGS device region.
> + *
> + * Exposes the emulated HDM decoder register state as a VFIO device region
> + * with type VFIO_REGION_SUBTYPE_CXL_COMP_REGS.	 QEMU attaches a
> + * notify_change callback to this region to intercept HDM COMMIT writes
> + * and map the DPA MemoryRegion at the appropriate GPA.
> + *
> + * The region is read+write only (no mmap) to ensure all accesses pass
> + * through comp_regs_dispatch_write() for proper bit-field enforcement.
> + */
> +int vfio_cxl_register_comp_regs_region(struct vfio_pci_core_device *vdev)
> +{
> +	struct vfio_pci_cxl_state *cxl = vdev->cxl;
> +	u32 flags = VFIO_REGION_INFO_FLAG_READ | VFIO_REGION_INFO_FLAG_WRITE;
> +	int ret;
> +
> +	if (!cxl || !cxl->comp_reg_virt)
> +		return -ENODEV;
> +
> +	ret = vfio_pci_core_register_dev_region(vdev,
> +						PCI_VENDOR_ID_CXL |
> +						VFIO_REGION_TYPE_PCI_VENDOR_TYPE,
> +						VFIO_REGION_SUBTYPE_CXL_COMP_REGS,
> +						&vfio_cxl_comp_regs_ops,
> +						cxl->hdm_reg_size, flags, cxl);
> +	if (!ret)
> +		cxl->comp_reg_region_idx = vdev->num_regions - 1;
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(vfio_cxl_register_comp_regs_region);
> diff --git a/drivers/vfio/pci/cxl/vfio_cxl_priv.h b/drivers/vfio/pci/cxl/vfio_cxl_priv.h
> index b870926bfb19..4f2637874e9d 100644
> --- a/drivers/vfio/pci/cxl/vfio_cxl_priv.h
> +++ b/drivers/vfio/pci/cxl/vfio_cxl_priv.h
> @@ -25,14 +25,51 @@ struct vfio_pci_cxl_state {
>  	size_t                       hdm_reg_size;
>  	resource_size_t              comp_reg_offset;
>  	size_t                       comp_reg_size;
> +	__le32                      *comp_reg_virt;
> +	void __iomem                *hdm_iobase;
>  	u32                          hdm_count;
>  	int                          dpa_region_idx;
> +	int                          comp_reg_region_idx;
>  	u16                          dvsec;
>  	u8                           comp_reg_bar;
>  	bool                         precommitted;
>  	bool                         region_active;
>  };
>  
> +/* Register access sizes */
> +#define CXL_REG_SIZE_WORD  2
> +#define CXL_REG_SIZE_DWORD 4
> +
> +/* HDM Decoder - register offsets (CXL 2.0 8.2.5.19) */
> +#define CXL_HDM_DECODER_GLOBAL_CTRL_OFFSET	  0x4
> +#define CXL_HDM_DECODER_FIRST_BLOCK_OFFSET	  0x10
> +#define CXL_HDM_DECODER_BLOCK_STRIDE		  0x20
> +#define CXL_HDM_DECODER_N_BASE_LOW_OFFSET	  0x0
> +#define CXL_HDM_DECODER_N_BASE_HIGH_OFFSET	  0x4
> +#define CXL_HDM_DECODER_N_SIZE_LOW_OFFSET	  0x8
> +#define CXL_HDM_DECODER_N_SIZE_HIGH_OFFSET	  0xc
> +#define CXL_HDM_DECODER_N_CTRL_OFFSET		  0x10
> +#define CXL_HDM_DECODER_N_TARGET_LIST_LOW_OFFSET  0x14
> +#define CXL_HDM_DECODER_N_TARGET_LIST_HIGH_OFFSET 0x18
> +#define CXL_HDM_DECODER_N_REV_OFFSET		  0x1c
> +
> +/* HDM Decoder Global Capability / Control - bit definitions */
> +#define CXL_HDM_CAP_POISON_ON_DECODE_ERR_BIT BIT(10)
> +#define CXL_HDM_CAP_UIO_SUPPORTED_BIT	     BIT(13)
> +
> +/* HDM Decoder N Control */
> +#define CXL_HDM_DECODER_CTRL_COMMIT_LOCK_BIT	  BIT(8)
> +#define CXL_HDM_DECODER_CTRL_COMMIT_BIT		  BIT(9)
> +#define CXL_HDM_DECODER_CTRL_COMMITTED_BIT	  BIT(10)
> +#define CXL_HDM_DECODER_CTRL_RO_BITS_MASK	  (BIT(10) | BIT(11))
> +#define CXL_HDM_DECODER_CTRL_RESERVED_MASK	  (BIT(15) | GENMASK(31, 28))
> +#define CXL_HDM_DECODER_CTRL_DEVICE_BITS_RO	  BIT(12)
> +#define CXL_HDM_DECODER_CTRL_DEVICE_RESERVED	  (GENMASK(19, 16) | GENMASK(23, 20))
> +#define CXL_HDM_DECODER_CTRL_UIO_RESERVED	  (BIT(14) | GENMASK(27, 24))
> +#define CXL_HDM_DECODER_BASE_LO_RESERVED_MASK	  GENMASK(27, 0)
> +#define CXL_HDM_DECODER_GLOBAL_CTRL_RESERVED_MASK GENMASK(31, 2)
> +#define CXL_HDM_DECODER_GLOBAL_CTRL_POISON_EN_BIT BIT(0)

Maybe the reg defines should go in include/cxl/regs.h? Or move shared definitions out of drivers/cxl/.

DJ

> +
>  /*
>   * CXL DVSEC for CXL Devices - register offsets within the DVSEC
>   * (CXL 2.0+ 8.1.3).
> @@ -41,4 +78,8 @@ struct vfio_pci_cxl_state {
>  #define CXL_DVSEC_CAPABILITY_OFFSET 0xa
>  #define CXL_DVSEC_MEM_CAPABLE	    BIT(2)
>  
> +int vfio_cxl_setup_virt_regs(struct vfio_pci_core_device *vdev);
> +void vfio_cxl_clean_virt_regs(struct vfio_pci_core_device *vdev);
> +void vfio_cxl_reinit_comp_regs(struct vfio_pci_core_device *vdev);
> +
>  #endif /* __LINUX_VFIO_CXL_PRIV_H */
> diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
> index 8f440f9eaa0c..f8db9a05c033 100644
> --- a/drivers/vfio/pci/vfio_pci_priv.h
> +++ b/drivers/vfio/pci/vfio_pci_priv.h
> @@ -152,6 +152,8 @@ int vfio_cxl_register_cxl_region(struct vfio_pci_core_device *vdev);
>  void vfio_cxl_unregister_cxl_region(struct vfio_pci_core_device *vdev);
>  void vfio_cxl_zap_region_locked(struct vfio_pci_core_device *vdev);
>  void vfio_cxl_reactivate_region(struct vfio_pci_core_device *vdev);
> +int  vfio_cxl_register_comp_regs_region(struct vfio_pci_core_device *vdev);
> +void vfio_cxl_reinit_comp_regs(struct vfio_pci_core_device *vdev);
>  
>  #else
>  
> @@ -173,6 +175,11 @@ static inline void
>  vfio_cxl_zap_region_locked(struct vfio_pci_core_device *vdev) { }
>  static inline void
>  vfio_cxl_reactivate_region(struct vfio_pci_core_device *vdev) { }
> +static inline int
> +vfio_cxl_register_comp_regs_region(struct vfio_pci_core_device *vdev)
> +{ return 0; }
> +static inline void
> +vfio_cxl_reinit_comp_regs(struct vfio_pci_core_device *vdev) { }
>  
>  #endif /* CONFIG_VFIO_CXL_CORE */
>  

