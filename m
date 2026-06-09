Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483AD416D18
	for <linux-cxl@vger.kernel.org>; Tue,  9 Jun 2026 12:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781008603; cv=none; b=XbXWxxbqlrkhcJqvilMtnNHayuwc2W7k7PZm+xCntlOJ+8qRgd0IR3+lg2YGzgiBgm3eHOuA36aAkCbCQ6weBdAk9VU6xA8pU+UQ/zT0kjgp+gV0+rvnuClAdFOEcC1ilIY/RrR4KEfKBmUW/jZJMkrEIRtC2Wn1RY6U9DmptG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781008603; c=relaxed/simple;
	bh=0yP6MF3gE/BfgY5Xm8w9RZgDEaJIlvEEClg/QEFVDUo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bUys0QW02CywM5VLUQZjyncuntGHkX/O7RhNB8Z6kQ9ZhKtvbyS/rbnBXNtmwRXVBl5Pmt0eCODu7y4WDBCIfG32QzZhtHrWLxn2AbAHPTECJwQ4HudogMn0Rm7xJlrLa6XF/tXXLbjh8UIHfAnFcKWEMvkIFZUGf20SNvnaDc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tg4RzaL9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tg4RzaL9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 576411F00893;
	Tue,  9 Jun 2026 12:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781008601;
	bh=sDtzMRMvAl0fvlAZBIDiq1O2az4YurxD2A7Q83AuB9s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Tg4RzaL9TzyeNTB8+6WRXvmYrF7nLlxg4r3xEeHMedZaDYuxyjDbihoXkaCL4KTyQ
	 9wiiNDiYis7mlcD9N8udqC6oJwBLSNZ2hOkgLk67pQLOBmeCYh28ebvsww9EY1IajZ
	 RbQ1yKfDaJ01XNL85ge1Y6gB+F0TR0GnCwwKPCl8p2Cx59tqPLKWtw6TFwEEjwC/1K
	 fYaJVpMaJOqhJbgD43UN/iAR7jsG43Bj989MHNpd2MCIrEw1Lv9POR/BQo7GTGw+jV
	 GWWF7QKddK7XtGj3AVJ37ZZbNRqd0ksKsejtlpCEe3PMBl4rD7aeK5sR/Zn7H40nhm
	 yR1yCq4eZ56LA==
Date: Tue, 9 Jun 2026 13:36:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chen Pei <cp0613@linux.alibaba.com>
Cc: pbonzini@redhat.com, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 sunilvl@ventanamicro.com, jonathan.cameron@huawei.com, fan.ni@samsung.com,
 guoren@kernel.org, qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 linux-cxl@vger.kernel.org
Subject: Re: [PATCH 4/4] hw/cxl: Map committed HDM decoder ranges as RAM for
 direct DMA
Message-ID: <20260609133634.7dbb892c@jic23-huawei>
In-Reply-To: <20260602074127.63819-5-cp0613@linux.alibaba.com>
References: <20260602074127.63819-1-cp0613@linux.alibaba.com>
	<20260602074127.63819-5-cp0613@linux.alibaba.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  2 Jun 2026 15:41:27 +0800
Chen Pei <cp0613@linux.alibaba.com> wrote:

> The CXL Fixed Memory Window (CFMW) is registered with
> memory_region_init_io() and has no backing ram_block.  As a result
> address_space_map() on a guest physical address inside the CFMW
> takes the bounce-buffer path and is bounded by
> DEFAULT_MAX_BOUNCE_BUFFER_SIZE (4 KiB by default for the system
> AddressSpace).  Once a Type-3 device is brought online as system RAM
> (daxctl online-memory), the kernel happily allocates DMA buffers from
> the CFMW range and any virtio operation whose scatter list exceeds
> 4 KiB or that overlaps with another in-flight transfer fails with:
> 
>     qemu-system-riscv64: virtio: bogus descriptor or out of resources

This is half the bug if you are running without the stuff I talk about
below - you can't run instructions out of that memory either.

As to the bonce buffer that should be larger anyway - there has
been some discussion in the past on how to do that for the global one
(there is support for PCI specific cases) but we never got to a
standard solution.

> 
> The bug is not RISC-V specific: CFMW registration and the bounce
> buffer limit are both arch-agnostic, so any guest that onlines CXL
> memory and issues DMA larger than 4 KiB into it is affected.  It
> shows up first on RISC-V virt because that is where the rest of
> this series enables the daxctl + virtio path end-to-end.
> 
> Reproduce on RISC-V virt with cxl=on and a single Type-3 device:
> 
>     cxl create-region -m -t ram -d decoder0.0 -w 1 mem0 -s 4G
>     daxctl online-memory dax0.0
>     free -h    # triggers the error and stalls the guest
> 
> Fix it by overlaying a RAM alias of the device's memory backend
> (hostvmem / hostpmem) at the committed HDM decoder's HPA range, with
> higher priority than the CFMW I/O region.  flatview_translate() then
> hits the alias, address_space_map() returns a direct host pointer,
> and DMA proceeds without bouncing.  This mirrors the existing QEMU
> pattern of PCI BAR and IOMMU MR overlays.  The alias is torn down on
> hdm_decoder_uncommit() so subsequent region tear-down + re-creation
> works.
> 

+CC linux-cxl as that's where you are more likely to get feedback on 
CXL aspects.

For this one there is a more comprehensive solution that restricts this
to the cases that are valid (no interleaving going on).
https://lore.kernel.org/qemu-devel/20260318171918.146-1-alireza.sanaee@huawei.com/#t
It is rather more complex as a result.

For other cases we have always intentionally left it as not supporting
what you have here because we want the interleave to be correct and testable.

As far as I'm concerned that series of Alireza's has been ready to merge for
a while. I've been a bit busy with other things so haven't been poking
for that though.  Might be a week or two before I get back on top of things.

Anyhow, please give Ali's series a go and see if that works for you.
There may well be other corners we haven't thought of!

Jonathan



> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>



> ---
>  hw/mem/cxl_type3.c          | 81 +++++++++++++++++++++++++++++++++++++
>  include/hw/cxl/cxl_device.h |  4 ++
>  2 files changed, 85 insertions(+)
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 4739239da3..f962bce66a 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -24,6 +24,7 @@
>  #include "qemu/module.h"
>  #include "qemu/pmem.h"
>  #include "qemu/range.h"
> +#include "system/address-spaces.h"
>  #include "qemu/rcu.h"
>  #include "qemu/guest-random.h"
>  #include "system/hostmem.h"
> @@ -420,6 +421,11 @@ static void hdm_decoder_commit(CXLType3Dev *ct3d, int which)
>      ComponentRegisters *cregs = &ct3d->cxl_cstate.crb;
>      uint32_t *cache_mem = cregs->cache_mem_registers;
>      uint32_t ctrl;
> +    uint32_t low, high;
> +    uint64_t decoder_base, decoder_size;
> +    MemoryRegion *mr = NULL;
> +    uint64_t dpa_offset = 0;
> +    char *alias_name;
>  
>      ctrl = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL + which * hdm_inc);
>      /* TODO: Sanity checks that the decoder is possible */
> @@ -427,6 +433,73 @@ static void hdm_decoder_commit(CXLType3Dev *ct3d, int which)
>      ctrl = FIELD_DP32(ctrl, CXL_HDM_DECODER0_CTRL, COMMITTED, 1);
>  
>      stl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL + which * hdm_inc, ctrl);
> +
> +    /*
> +     * Create a RAM alias in system memory for the committed decoder range.
> +     * This enables direct DMA mapping (address_space_map) for devices like
> +     * virtio that need to DMA to/from CXL memory.  Without this, the CFMW
> +     * I/O region would require bounce buffering which is limited to 4KB.
> +     */
> +    low = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_BASE_LO + which * hdm_inc);
> +    high = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_BASE_HI + which * hdm_inc);
> +    decoder_base = ((uint64_t)high << 32) | (low & 0xf0000000);
> +
> +    low = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_SIZE_LO + which * hdm_inc);
> +    high = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_SIZE_HI + which * hdm_inc);
> +    decoder_size = ((uint64_t)high << 32) | (low & 0xf0000000);
> +
> +    if (!decoder_base || !decoder_size) {
> +        return;
> +    }
> +
> +    /* Calculate DPA offset by summing sizes of preceding decoders */
> +    for (int i = 0; i < which; i++) {
> +        uint32_t prev_low, prev_high;
> +        uint64_t prev_size;
> +        uint32_t prev_ctrl;
> +
> +        prev_ctrl = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL +
> +                             i * hdm_inc);
> +        if (!FIELD_EX32(prev_ctrl, CXL_HDM_DECODER0_CTRL, COMMITTED)) {
> +            continue;
> +        }
> +        prev_low = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_SIZE_LO +
> +                            i * hdm_inc);
> +        prev_high = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_SIZE_HI +
> +                             i * hdm_inc);
> +        prev_size = ((uint64_t)prev_high << 32) | (prev_low & 0xf0000000);
> +        dpa_offset += prev_size;
> +    }
> +
> +    /* Determine which memory backend to alias */
> +    if (ct3d->hostvmem) {
> +        MemoryRegion *vmr = host_memory_backend_get_memory(ct3d->hostvmem);
> +        uint64_t vmr_size = memory_region_size(vmr);
> +
> +        if (dpa_offset < vmr_size) {
> +            mr = vmr;
> +        }
> +    }
> +    if (!mr && ct3d->hostpmem) {
> +        MemoryRegion *pmr = host_memory_backend_get_memory(ct3d->hostpmem);
> +        uint64_t vmr_size = ct3d->hostvmem ?
> +            memory_region_size(
> +                host_memory_backend_get_memory(ct3d->hostvmem)) : 0;
> +        mr = pmr;
> +        dpa_offset -= vmr_size;
> +    }
> +
> +    if (!mr) {
> +        return;
> +    }
> +
> +    alias_name = g_strdup_printf("cxl-hdm%d-ram-alias", which);
> +    memory_region_init_alias(&ct3d->hdm_ram_alias[which], OBJECT(ct3d),
> +                             alias_name, mr, dpa_offset, decoder_size);
> +    memory_region_add_subregion_overlap(get_system_memory(), decoder_base,
> +                                        &ct3d->hdm_ram_alias[which], 1);
> +    ct3d->hdm_ram_alias_valid[which] = true;
> +    g_free(alias_name);
>  }
>  
>  static void hdm_decoder_uncommit(CXLType3Dev *ct3d, int which)
> @@ -442,6 +515,14 @@ static void hdm_decoder_uncommit(CXLType3Dev *ct3d, int which)
>      ctrl = FIELD_DP32(ctrl, CXL_HDM_DECODER0_CTRL, COMMITTED, 0);
>  
>      stl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL + which * hdm_inc, ctrl);
> +
> +    /* Remove the RAM alias if it was added during commit */
> +    if (ct3d->hdm_ram_alias_valid[which]) {
> +        memory_region_del_subregion(get_system_memory(),
> +                                    &ct3d->hdm_ram_alias[which]);
> +        object_unparent(OBJECT(&ct3d->hdm_ram_alias[which]));
> +        ct3d->hdm_ram_alias_valid[which] = false;
> +    }
>  }
>  
>  static int ct3d_qmp_uncor_err_to_cxl(CxlUncorErrorType qmp_err)
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index 393f312217..07deef2e2c 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -714,6 +714,10 @@ struct CXLType3Dev {
>      /* State */
>      AddressSpace hostvmem_as;
>      AddressSpace hostpmem_as;
> +
> +    /* RAM aliases for HDM decoders - enables direct DMA mapping */
> +    MemoryRegion hdm_ram_alias[CXL_HDM_DECODER_COUNT];
> +    bool hdm_ram_alias_valid[CXL_HDM_DECODER_COUNT];
>      CXLComponentState cxl_cstate;
>      CXLDeviceState cxl_dstate;
>      CXLCCI cci; /* Primary PCI mailbox CCI */

