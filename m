Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C422FE577
	for <linux-cxl@vger.kernel.org>; Mon, 13 Oct 2025 15:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760367723; cv=none; b=QMJfEnkVixXmTwDmCXm8jOn3E9G4m6W1WSgk0itqGpQAyK9H+v2iK6yGrCCaSbW0yqKq7IPNmTbqRxluxLRxP2/l5ByYoNmIgVN1PlF2IdMWpI0vKcBA5FgsJr9Vjnr9mDKGKbcrlPG9qDoMWCbHqoBjrphnSL9zeI08v2Y6BVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760367723; c=relaxed/simple;
	bh=BQWBmfFPFn0wYnXJvhq9A5dXteWo8+aY1beOJB/kDuo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DT590o8W1wBDRaNwfRQ1fv4cvvkhHhDi0oG6H6UjA63dpAufgbE7fVIQli/6CwcxjgR000UTM8XIFa8RwyuEARzwbLvjE1ZC2nv9p9zhVqZ17txeGAG6B2iwAXB3Q4kBOURDbBdDbGZBkexvHOFjsWuW0FUQ632X01YG7ui6sGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4clgXG5Pjwz6G8xv;
	Mon, 13 Oct 2025 23:01:02 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 51FB01402F3;
	Mon, 13 Oct 2025 23:01:58 +0800 (CST)
Received: from localhost (10.47.28.241) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 13 Oct
 2025 16:01:57 +0100
Date: Mon, 13 Oct 2025 16:01:51 +0100
From: Alireza Sanaee <alireza.sanaee@huawei.com>
To: Alireza Sanaee via <qemu-devel@nongnu.org>
CC: <jonathan.cameron@huawei.com>, <linux-cxl@vger.kernel.org>,
	<armbru@redhat.com>, <lizhijian@fujitsu.com>, <zhao1.liu@intel.com>,
	<mst@redhat.com>, <linuxarm@huawei.com>, <anisa.su@samsung.com>
Subject: Re: [RFC PATCH] hw/cxl: Add a performant (and correct) path for the
 non interleaved cases.
Message-ID: <20251013160151.000039dd.alireza.sanaee@huawei.com>
In-Reply-To: <20251013143106.884-1-alireza.sanaee@huawei.com>
References: <20251013143106.884-1-alireza.sanaee@huawei.com>
Organization: Huawei
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
 dubpeml500005.china.huawei.com (7.214.145.207)

On Mon, 13 Oct 2025 15:31:06 +0100
Alireza Sanaee via <qemu-devel@nongnu.org> wrote:

> The CXL address to device decoding logic is complex because of the
> need to correctly decode fine grained interleave. The current
> implementation prevents use with KVM where executed instructions may
> reside in that memory and gives very slow performance even in TCG.
> 
> In many real cases non interleaved memory configurations are useful
> and for those we can use a more conventional memory region alias
> allowing similar performance to other memory in the system.
> 
> Whether this fast path is applicable can be established once the full
> set of HDM decoders has been committed (in whatever order the guest
> decides to commit them). As such a check is performed on each commit /
> uncommit of HDM decoder to establish if the alias should be added or
> removed.
> 
> Co-developed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
> ---
> Thanks to Jonathan Cameron for feedback and help with this patch.
>  hw/cxl/cxl-component-utils.c |   9 ++
>  hw/cxl/cxl-host.c            | 268
> ++++++++++++++++++++++++++++++++++- hw/mem/cxl_type3.c           |
> 4 + include/hw/cxl/cxl.h         |   1 +
>  include/hw/cxl/cxl_device.h  |  10 ++
>  5 files changed, 289 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/cxl/cxl-component-utils.c
> b/hw/cxl/cxl-component-utils.c index 473895948b..f1ecd6ed22 100644
> --- a/hw/cxl/cxl-component-utils.c
> +++ b/hw/cxl/cxl-component-utils.c
> @@ -116,6 +116,15 @@ static void dumb_hdm_handler(CXLComponentState
> *cxl_cstate, hwaddr offset, value = FIELD_DP32(value,
> CXL_HDM_DECODER0_CTRL, COMMITTED, 0); }
>      stl_le_p((uint8_t *)cache_mem + offset, value);
> +
> +    if (should_commit) {
> +        cfmws_update_non_interleaved(true);
> +    }
> +
> +    if (should_uncommit) {
> +        cfmws_update_non_interleaved(false);
> +    }
> +
>  }
>  
>  static void cxl_cache_mem_write_reg(void *opaque, hwaddr offset,
> uint64_t value, diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
> index 0d891c651d..3a563af3bc 100644
> --- a/hw/cxl/cxl-host.c
> +++ b/hw/cxl/cxl-host.c
> @@ -12,6 +12,7 @@
>  #include "qapi/error.h"
>  #include "system/qtest.h"
>  #include "hw/boards.h"
> +#include "qemu/log.h"
>  
>  #include "qapi/qapi-visit-machine.h"
>  #include "hw/cxl/cxl.h"
> @@ -104,7 +105,7 @@ void cxl_fmws_link_targets(Error **errp)
>  }
>  
>  static bool cxl_hdm_find_target(uint32_t *cache_mem, hwaddr addr,
> -                                uint8_t *target)
> +                                uint8_t *target, bool *interleaved)
>  {
>      int hdm_inc = R_CXL_HDM_DECODER1_BASE_LO -
> R_CXL_HDM_DECODER0_BASE_LO; unsigned int hdm_count;
> @@ -138,6 +139,11 @@ static bool cxl_hdm_find_target(uint32_t
> *cache_mem, hwaddr addr, found = true;
>          ig_enc = FIELD_EX32(ctrl, CXL_HDM_DECODER0_CTRL, IG);
>          iw_enc = FIELD_EX32(ctrl, CXL_HDM_DECODER0_CTRL, IW);
> +
> +        if (interleaved) {
> +            *interleaved = iw_enc != 0;
> +        }
> +
>          target_idx = (addr / cxl_decode_ig(ig_enc)) % (1 << iw_enc);
>  
>          if (target_idx < 4) {
> @@ -190,7 +196,7 @@ static PCIDevice
> *cxl_cfmws_find_device(CXLFixedWindow *fw, hwaddr addr) 
>          cache_mem = hb_cstate->crb.cache_mem_registers;
>  
> -        target_found = cxl_hdm_find_target(cache_mem, addr, &target);
> +        target_found = cxl_hdm_find_target(cache_mem, addr, &target,
> NULL); if (!target_found) {
>              return NULL;
>          }
> @@ -226,7 +232,7 @@ static PCIDevice
> *cxl_cfmws_find_device(CXLFixedWindow *fw, hwaddr addr) 
>      cache_mem = usp_cstate->crb.cache_mem_registers;
>  
> -    target_found = cxl_hdm_find_target(cache_mem, addr, &target);
> +    target_found = cxl_hdm_find_target(cache_mem, addr, &target,
> NULL); if (!target_found) {
>          return NULL;
>      }
> @@ -248,6 +254,262 @@ static PCIDevice
> *cxl_cfmws_find_device(CXLFixedWindow *fw, hwaddr addr) return d;
>  }
>  
> +static bool cfmws_is_not_interleaved(CXLFixedWindow *fw, hwaddr addr)
> +{
> +    PCIDevice *rp, *d;
> +    PCIHostState *hb;
> +    CXLComponentState *hb_cstate, *usp_cstate;
> +    CXLUpstreamPort *usp;
> +    uint32_t *cache_mem;
> +    bool target_found, interleaved;
> +    uint8_t target;
> +
> +    addr = fw->base;
> +    if (fw->num_targets > 1) {
> +        return false;
> +    }
> +
> +    hb = PCI_HOST_BRIDGE(fw->target_hbs[0]->cxl_host_bridge);
> +    if (!hb || !hb->bus || !pci_bus_is_cxl(hb->bus)) {
> +        return false;
> +    }
> +    if (cxl_get_hb_passthrough(hb)) {
> +        rp = pcie_find_port_first(hb->bus);
> +        if (!rp) {
> +            return false;
> +        }
> +    } else {
> +        hb_cstate = cxl_get_hb_cstate(hb);
> +        if (!hb_cstate) {
> +            return false;
> +        }
> +        cache_mem = hb_cstate->crb.cache_mem_registers;
> +
> +        target_found = cxl_hdm_find_target(cache_mem, addr, &target,
> +                                           &interleaved);
> +        if (!target_found) {
> +            return false;
> +        }
> +        if (interleaved) {
> +            return false;
> +        }
> +
> +        rp = pcie_find_port_by_pn(hb->bus, target);
> +        if (!rp) {
> +            return false;
> +        }
> +    }
> +    d = pci_bridge_get_sec_bus(PCI_BRIDGE(rp))->devices[0];
> +    if (!d) {
> +        return false;
> +    }
> +
> +    if (object_dynamic_cast(OBJECT(d), TYPE_CXL_TYPE3)) {
> +        return true;
> +    }
> +    /*
> +     * Could also be a switch.  Note only one level of switching
> currently
> +     * supported.
> +     */
> +    if (!object_dynamic_cast(OBJECT(d), TYPE_CXL_USP)) {
> +        return false;
> +    }
> +    usp = CXL_USP(d);
> +
> +    usp_cstate = cxl_usp_to_cstate(usp);
> +    if (!usp_cstate) {
> +        return false;
> +    }
> +
> +    cache_mem = usp_cstate->crb.cache_mem_registers;
> +
> +    target_found = cxl_hdm_find_target(cache_mem, addr, &target,
> +                                       &interleaved);
> +    if (!target_found) {
> +        return false;
> +    }
> +    if (interleaved) {
> +        return false;
> +    }
> +
> +    d = pcie_find_port_by_pn(&PCI_BRIDGE(d)->sec_bus, target);
> +    if (!d) {
> +        return false;
> +    }
> +
> +    d = pci_bridge_get_sec_bus(PCI_BRIDGE(d))->devices[0];
> +    if (!d) {
> +        return false;
> +    }
> +
> +    if (!object_dynamic_cast(OBJECT(d), TYPE_CXL_TYPE3)) {
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
> +static int cxl_fmws_direct_passthrough(Object *obj, void *opaque)
> +{
> +    struct cxl_direct_pt_state *state = opaque;
> +    struct CXLFixedWindow *fw;
> +    CXLType3Dev *ct3d = state->ct3d;
> +
> +    if (!object_dynamic_cast(obj, TYPE_CXL_FMW)) {
> +        return 0;
> +    }
> +
> +    fw = CXL_FMW(obj);
> +
> +    if (!cfmws_is_not_interleaved(fw, state->decoder_base)) {
> +        return 0;
> +    }
> +
> +    if (state->commit) {
> +        MemoryRegion *mr = NULL;
> +        uint64_t vmr_size = 0, pmr_size = 0;
> +        uint64_t offset = 0;
> +
> +        if (ct3d->hostvmem) {
> +            MemoryRegion *vmr =
> host_memory_backend_get_memory(ct3d->hostvmem);
> +            vmr_size = memory_region_size(vmr);
> +            if (state->dpa_base < vmr_size) {
> +                mr = vmr;
> +                offset = state->dpa_base;
> +            }
> +        }
> +        if (!mr && ct3d->hostpmem) {
> +            MemoryRegion *pmr =
> host_memory_backend_get_memory(ct3d->hostpmem);
> +            pmr_size = memory_region_size(pmr);
> +            if (state->dpa_base - vmr_size < pmr_size) {
> +                mr = pmr;
> +                offset = state->dpa_base - vmr_size;
> +            }
> +        }
> +
> +        if (!mr) {
> +            return 0;
> +        }
> +
> +        if
> (memory_region_is_mapped(&ct3d->direct_mr[state->hdm_decoder_idx])) {
> +            return 0;
> +        }
> +
> +
> memory_region_init_alias(&ct3d->direct_mr[state->hdm_decoder_idx],
> +                                 OBJECT(ct3d), "direct-mapping", mr,
> offset,
> +                                 state->decoder_size);
> +        memory_region_add_subregion(&fw->mr,
> +                                    state->decoder_base - fw->base,
> +
> &ct3d->direct_mr[state->hdm_decoder_idx]);
> +    } else {
> +        if
> (memory_region_is_mapped(&ct3d->direct_mr[state->hdm_decoder_idx])) {
> +            memory_region_del_subregion(&fw->mr,
> +                &ct3d->direct_mr[state->hdm_decoder_idx]);
> +        }
> +    }
> +
> +    return 0;
> +}
> +
> +static int update_non_interleaved(Object *obj, void *opaque)
> +{
> +    CXLType3Dev *ct3d;
> +    uint32_t *cache_mem;
> +    unsigned int hdm_count, i;
> +    uint32_t cap;
> +    int hdm_inc = R_CXL_HDM_DECODER1_BASE_LO -
> R_CXL_HDM_DECODER0_BASE_LO;
> +    uint64_t dpa_base = 0;
> +    bool commit = *(bool *) opaque;
> +
> +    if (!object_dynamic_cast(obj, TYPE_CXL_TYPE3)) {
> +        return 0;
> +    }
> +
> +    ct3d = CXL_TYPE3(obj);
> +    cache_mem = ct3d->cxl_cstate.crb.cache_mem_registers;
> +    /*
> +     * Walk the decoders and find any committed with iw set to 0
> +     * (non interleaved).
> +     */
> +    cap = ldl_le_p(cache_mem + R_CXL_HDM_DECODER_CAPABILITY);
> +    hdm_count = cxl_decoder_count_dec(FIELD_EX32(cap,
> +
> CXL_HDM_DECODER_CAPABILITY,
> +                                                 DECODER_COUNT));
> +
> +    /* Now for each committed HDM decoder */
> +    for (i = 0; i < hdm_count; i++) {
> +        uint64_t decoder_base, decoder_size, skip;
> +        uint32_t hdm_ctrl, low, high;
> +        int iw, committed;
> +
> +        hdm_ctrl = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL + i
> * hdm_inc);
> +        committed = FIELD_EX32(hdm_ctrl, CXL_HDM_DECODER0_CTRL,
> COMMITTED);
> +        if (commit) {
> +            if (!committed) {
> +                return 0;
> +            }
> +        } else {
> +            if (committed) {
> +                return 0;
> +            }
> +        }
> +
> +        /*
> +         * Even if this decoder is interleaved need to keep track of
> DPA as the
> +         * next HDM decoder may not be interleaved.
> +         */
> +        low = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_DPA_SKIP_LO +
> +                       i * hdm_inc);
> +        high = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_DPA_SKIP_HI +
> +                        i * hdm_inc);
> +        skip = ((uint64_t)high << 32) | (low & 0xf0000000);
> +        dpa_base += skip;
> +
> +        low = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_SIZE_LO + i *
> hdm_inc);
> +        high = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_SIZE_HI + i *
> hdm_inc);
> +        decoder_size = ((uint64_t)high << 32) | (low & 0xf0000000);
> +        iw = FIELD_EX32(hdm_ctrl, CXL_HDM_DECODER0_CTRL, IW);
> +        /* Get the HPA of the base */
> +        low = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_BASE_LO + i *
> hdm_inc);
> +        high = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_BASE_HI + i *
> hdm_inc);
> +        decoder_base = ((uint64_t)high << 32) | (low & 0xf0000000);
> +
> +#ifdef DEBUG
> +        qemu_log("non interleaved decoder %lx %lx %lx %d\n",
> decoder_base,
> +                 decoder_size, dpa_base, commit);
> +#endif
> +
> +        /* Is it non interleaved? - need to check full path later */
> +        if (iw == 0) {
> +            struct cxl_direct_pt_state state = {
> +                .ct3d = ct3d,
> +                .decoder_base = decoder_base,
> +                .decoder_size = decoder_size,
> +                .dpa_base = dpa_base,
> +                .hdm_decoder_idx = i,
> +                .commit = commit,
> +            };
> +            object_child_foreach_recursive(object_get_root(),
> +
> cxl_fmws_direct_passthrough, &state);
> +        }
> +        dpa_base += decoder_size / cxl_interleave_ways_dec(iw,
> &error_fatal); +
> +    }
> +    return 0;
> +}
> +
> +bool cfmws_update_non_interleaved(bool commit)
> +{
> +    /*
> +     * Walk endpoints to find committed decoders then check if they
> are not
> +     * interleaved (but path full is set up).
> +     */
> +    object_child_foreach_recursive(object_get_root(),
> +                                   update_non_interleaved, &commit);
> +
> +    return false;
> +}
> +
>  static MemTxResult cxl_read_cfmws(void *opaque, hwaddr addr,
> uint64_t *data, unsigned size, MemTxAttrs attrs)
>  {
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index be609ff9d0..8cdb3bff7e 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -427,6 +427,8 @@ static void hdm_decoder_commit(CXLType3Dev *ct3d,
> int which) ctrl = FIELD_DP32(ctrl, CXL_HDM_DECODER0_CTRL, COMMITTED,
> 1); 
>      stl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL + which * hdm_inc,
> ctrl); +
> +    cfmws_update_non_interleaved(true);
>  }
>  
>  static void hdm_decoder_uncommit(CXLType3Dev *ct3d, int which)
> @@ -442,6 +444,8 @@ static void hdm_decoder_uncommit(CXLType3Dev
> *ct3d, int which) ctrl = FIELD_DP32(ctrl, CXL_HDM_DECODER0_CTRL,
> COMMITTED, 0); 
>      stl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL + which * hdm_inc,
> ctrl); +
> +    cfmws_update_non_interleaved(false);
>  }
>  
>  static int ct3d_qmp_uncor_err_to_cxl(CxlUncorErrorType qmp_err)
> diff --git a/include/hw/cxl/cxl.h b/include/hw/cxl/cxl.h
> index 998f495a98..d5d2a9efb5 100644
> --- a/include/hw/cxl/cxl.h
> +++ b/include/hw/cxl/cxl.h
> @@ -71,4 +71,5 @@ CXLComponentState
> *cxl_usp_to_cstate(CXLUpstreamPort *usp); typedef struct
> CXLDownstreamPort CXLDownstreamPort;
> DECLARE_INSTANCE_CHECKER(CXLDownstreamPort, CXL_DSP, TYPE_CXL_DSP) 
> +bool cfmws_update_non_interleaved(bool);
>  #endif
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index 89411c8093..1d199d035e 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -584,6 +584,7 @@ struct CXLType3Dev {
>      uint64_t sn;
>  
>      /* State */
> +    MemoryRegion direct_mr[CXL_HDM_DECODER_COUNT];
>      AddressSpace hostvmem_as;
>      AddressSpace hostpmem_as;
>      CXLComponentState cxl_cstate;
> @@ -671,6 +672,15 @@ struct CSWMBCCIDev {
>      CXLCCI *cci;
>  };
>  
> +struct cxl_direct_pt_state {
> +    CXLType3Dev *ct3d;
> +    hwaddr decoder_base;
> +    hwaddr decoder_size;
> +    hwaddr dpa_base;
> +    unsigned int hdm_decoder_idx;
> +    bool commit;
> +};
> +
>  #define TYPE_CXL_SWITCH_MAILBOX_CCI "cxl-switch-mailbox-cci"
>  OBJECT_DECLARE_TYPE(CSWMBCCIDev, CSWMBCCIClass,
> CXL_SWITCH_MAILBOX_CCI) 

Added anisa, linux-cxl, and linux-arm to the CC. 
