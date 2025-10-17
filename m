Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E003332EDD
	for <linux-cxl@vger.kernel.org>; Fri, 17 Oct 2025 13:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760706151; cv=none; b=OCdUrk+QUvT8abmzYros1pwmg87jUpyuSjO/1HXsuAILb184qPQ8qqa59uoWDbc2T970ZPk9ZuP3AupZO2tW8DgDI8bFpLI7NXbhyzAM/2B0uoAVkIX2qh37zicV8DzjdO8OTollPmP0ZQ1k660JnzZ6Fbdsoa0dPQ0JgRZeLpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760706151; c=relaxed/simple;
	bh=34g+La58VwqzxKJ/C7/IV+cGlQdf1z+UzgDzMAXfBAY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RfkCuEk15jD8R7C8F4fLI3m6c3VnHfzhN0z6MhApZpD96GQawa1MnscGwNgYAs32U1Fa6+vXoVYx/+plUkyq/zkcg0OrkFH5uVrj7aFuINE3BFXr+yxCdQqbKdx0rK3pCr7BMQ4Wxo8RT6iExYiuLli9RoUwXD+M1jeyIHohZSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cp4f83MKCz6L58j;
	Fri, 17 Oct 2025 20:59:28 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id B84991400C8;
	Fri, 17 Oct 2025 21:02:26 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 17 Oct
 2025 14:02:25 +0100
Date: Fri, 17 Oct 2025 14:02:24 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Alireza Sanaee <alireza.sanaee@huawei.com>
CC: <qemu-devel@nongnu.org>, <fan.ni@samsung.com>, <armbru@redhat.com>,
	<lizhijian@fujitsu.com>, <zhao1.liu@intel.com>, <mst@redhat.com>,
	<linux-cxl@vger.kernel.org>, <anisa.su@samsung.com>, <linuxarm@huawei.com>
Subject: Re: [RFC PATCH] hw/cxl: Add a performant (and correct) path for the
 non interleaved cases.
Message-ID: <20251017140224.00000b61@huawei.com>
In-Reply-To: <20251013143106.884-1-alireza.sanaee@huawei.com>
References: <20251013143106.884-1-alireza.sanaee@huawei.com>
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
 dubpeml100005.china.huawei.com (7.214.146.113)

On Mon, 13 Oct 2025 15:31:06 +0100
Alireza Sanaee <alireza.sanaee@huawei.com> wrote:

> The CXL address to device decoding logic is complex because of the need
> to correctly decode fine grained interleave. The current implementation
> prevents use with KVM where executed instructions may reside in that
> memory and gives very slow performance even in TCG.
> 
> In many real cases non interleaved memory configurations are useful and
> for those we can use a more conventional memory region alias allowing
> similar performance to other memory in the system.
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
Hi Ali,

Given your reply to add +CC had some broken wrapping I have probably
confused things even more but this is a reply to the original email
with the same +CC.  For future series that are qemu and CXL related
as you've noted it needs to go to both main lists. It should also
have
[RFC PATCH qemu] as that helps Dave filter them out from the linux-cxl
patchwork.


Various comments inline. Many of them in the code I hacked together.
That younger me made a mess ;)

> ---
> Thanks to Jonathan Cameron for feedback and help with this patch.
>  hw/cxl/cxl-component-utils.c |   9 ++
>  hw/cxl/cxl-host.c            | 268 ++++++++++++++++++++++++++++++++++-
>  hw/mem/cxl_type3.c           |   4 +
>  include/hw/cxl/cxl.h         |   1 +
>  include/hw/cxl/cxl_device.h  |  10 ++
>  5 files changed, 289 insertions(+), 3 deletions(-)
> 

>  static void cxl_cache_mem_write_reg(void *opaque, hwaddr offset, uint64_t value,
> diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
> index 0d891c651d..3a563af3bc 100644
> --- a/hw/cxl/cxl-host.c
> +++ b/hw/cxl/cxl-host.c
> @@ -12,6 +12,7 @@

> @@ -226,7 +232,7 @@ static PCIDevice *cxl_cfmws_find_device(CXLFixedWindow *fw, hwaddr addr)
>  
>      cache_mem = usp_cstate->crb.cache_mem_registers;
>  
> -    target_found = cxl_hdm_find_target(cache_mem, addr, &target);
> +    target_found = cxl_hdm_find_target(cache_mem, addr, &target, NULL);
>      if (!target_found) {
>          return NULL;
>      }
> @@ -248,6 +254,262 @@ static PCIDevice *cxl_cfmws_find_device(CXLFixedWindow *fw, hwaddr addr)
>      return d;
>  }
>  
> +static bool cfmws_is_not_interleaved(CXLFixedWindow *fw, hwaddr addr)
Naming is a bit non obvious as it's not just checking the cfmws but
also the rest of the path.  find_device doesn't suffer that confusion
because it is finding a device under a cfwms.
> +{

It's a bit annoying how much this code shares with
cxl_cfmws_find_device()

As we take this forward perhaps we need a shared helper that both wrap
which takes a interleave allowed parameter.

Something like:

static PCIDevice *do_cxl_cfws_find_device(CXLFixedWindow *fw, hwaddr addr,
					  bool allow_interleave)
(
    CXLComponentState *hb_cstate, *usp_cstate;
    PCIHostState *hb;
    CXLUpstreamPort *usp;
    int rb_index;
    uint32_t *cache_mem;
    uint8_t target;
    bool target_found;
    PCIDevice *rp, *d;
    bool interleaved = false;

    /* Address is relative to memory region. Convert to HPA */
    addr += fw->base;

//new bit
    if ((fw->num_targets > 1) && !allow_interleave) {
        return NULL;
    }
    rb_index = (addr / cxl_decode_ig(fw->enc_int_gran)) % fw->num_targets;
    hb = PCI_HOST_BRIDGE(fw->target_hbs[rb_index]->cxl_host_bridge);
    if (!hb || !hb->bus || !pci_bus_is_cxl(hb->bus)) {
        return NULL;
    }

    if (cxl_get_hb_passthrough(hb)) {
        rp = pcie_find_port_first(hb->bus);
        if (!rp) {
            return NULL;
        }
    } else {
        hb_cstate = cxl_get_hb_cstate(hb);
        if (!hb_cstate) {
            return NULL;
        }

        cache_mem = hb_cstate->crb.cache_mem_registers;

        target_found = cxl_hdm_find_target(cache_mem, addr, &target, &interleaved);
        if (!target_found) {
            return NULL;
        }
//new bit.
	if (interleaved && !allow_interleave) {
            return NULL;
        }

        rp = pcie_find_port_by_pn(hb->bus, target);
        if (!rp) {
            return NULL;
        }
    }

    d = pci_bridge_get_sec_bus(PCI_BRIDGE(rp))->devices[0];
    if (!d) {
        return NULL;
    }

    if (object_dynamic_cast(OBJECT(d), TYPE_CXL_TYPE3)) {
        return d;
    }

    /*
     * Could also be a switch.  Note only one level of switching currently
     * supported.
     */
    if (!object_dynamic_cast(OBJECT(d), TYPE_CXL_USP)) {
        return NULL;
    }
    usp = CXL_USP(d);

    usp_cstate = cxl_usp_to_cstate(usp);
    if (!usp_cstate) {
        return NULL;
    }

    cache_mem = usp_cstate->crb.cache_mem_registers;

    target_found = cxl_hdm_find_target(cache_mem, addr, &target, &interleaved);
    if (!target_found) {
        return NULL;
    }
//new bit.
    if (interleaved && !allow_interleave) {
        return NULL;
    }

    d = pcie_find_port_by_pn(&PCI_BRIDGE(d)->sec_bus, target);
    if (!d) {
        return NULL;
    }

    d = pci_bridge_get_sec_bus(PCI_BRIDGE(d))->devices[0];
    if (!d) {
        return NULL;
    }

    if (!object_dynamic_cast(OBJECT(d), TYPE_CXL_TYPE3)) {
        return NULL;
    }

    return d;
}

Then have two wrappers that hid away the oddity of the check.

We still need to verify the interleave of the type3 but that
happens when working out the mapping below.


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
> +     * Could also be a switch.  Note only one level of switching currently
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

Might as well combine the two lines above given they are all set to 0
so I don't think it hurt readability.

> +
> +        if (ct3d->hostvmem) {
> +            MemoryRegion *vmr = host_memory_backend_get_memory(ct3d->hostvmem);

Blank line here.

> +            vmr_size = memory_region_size(vmr);
> +            if (state->dpa_base < vmr_size) {
> +                mr = vmr;
> +                offset = state->dpa_base;
> +            }
> +        }
> +        if (!mr && ct3d->hostpmem) {
> +            MemoryRegion *pmr = host_memory_backend_get_memory(ct3d->hostpmem);

and here.  I have it in my head that checkpatch moans about this, but maybe not.

> +            pmr_size = memory_region_size(pmr);
pmr size is used only once. Maybe...

            if (state->dpa_base - vmr_size < memory_region_size(pmr)) {

However it then looks more different from previous block, so perhaps
this isn't a good change to make.  Up to you.

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
> +        if (memory_region_is_mapped(&ct3d->direct_mr[state->hdm_decoder_idx])) {
> +            return 0;
> +        }
> +
> +        memory_region_init_alias(&ct3d->direct_mr[state->hdm_decoder_idx],
> +                                 OBJECT(ct3d), "direct-mapping", mr, offset,
> +                                 state->decoder_size);
> +        memory_region_add_subregion(&fw->mr,
> +                                    state->decoder_base - fw->base,
> +                                    &ct3d->direct_mr[state->hdm_decoder_idx]);
> +    } else {
> +        if (memory_region_is_mapped(&ct3d->direct_mr[state->hdm_decoder_idx])) {
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
> +    int hdm_inc = R_CXL_HDM_DECODER1_BASE_LO - R_CXL_HDM_DECODER0_BASE_LO;
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
I'd move this down to...
> +     */
> +    cap = ldl_le_p(cache_mem + R_CXL_HDM_DECODER_CAPABILITY);
> +    hdm_count = cxl_decoder_count_dec(FIELD_EX32(cap,
> +                                                 CXL_HDM_DECODER_CAPABILITY,
> +                                                 DECODER_COUNT));
> +
... here and drop the following code as we already said it was commiteed

> +    /* Now for each committed HDM decoder */
> +    for (i = 0; i < hdm_count; i++) {
> +        uint64_t decoder_base, decoder_size, skip;
> +        uint32_t hdm_ctrl, low, high;
> +        int iw, committed;
> +
> +        hdm_ctrl = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL + i * hdm_inc);
> +        committed = FIELD_EX32(hdm_ctrl, CXL_HDM_DECODER0_CTRL, COMMITTED);
> +        if (commit) {
> +            if (!committed) {
> +                return 0;
> +            }
> +        } else {
> +            if (committed) {
> +                return 0;
> +            }
> +        }

Smells like if could be something like:
        /* If this state isn't the one we are looking for, nothing to do */
        if (commit ^ committed) { 
            return 0;
        }


> +
> +        /*
> +         * Even if this decoder is interleaved need to keep track of DPA as the
> +         * next HDM decoder may not be interleaved.
> +         */

This comment feels a bit belt and braces given we do the += skip just below.
Probably left over from when I was thinking my way around the original PoC.
So I'd drop ti.


> +        low = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_DPA_SKIP_LO +
> +                       i * hdm_inc);
> +        high = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_DPA_SKIP_HI +
> +                        i * hdm_inc);
> +        skip = ((uint64_t)high << 32) | (low & 0xf0000000);
> +        dpa_base += skip;
> +
> +        low = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_SIZE_LO + i * hdm_inc);
> +        high = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_SIZE_HI + i * hdm_inc);
> +        decoder_size = ((uint64_t)high << 32) | (low & 0xf0000000);
> +        iw = FIELD_EX32(hdm_ctrl, CXL_HDM_DECODER0_CTRL, IW);
> +        /* Get the HPA of the base */

Similar on this. Comment feels a bit much given we use it to fill
decoder_base.  Just drop it.

> +        low = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_BASE_LO + i * hdm_inc);
> +        high = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_BASE_HI + i * hdm_inc);
> +        decoder_base = ((uint64_t)high << 32) | (low & 0xf0000000);
> +
> +#ifdef DEBUG
> +        qemu_log("non interleaved decoder %lx %lx %lx %d\n", decoder_base,
> +                 decoder_size, dpa_base, commit);
> +#endif
> +
> +        /* Is it non interleaved? - need to check full path later */
I'd drop the 'need to check the full path later' given it happens just below anyway.
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
> +                                           cxl_fmws_direct_passthrough, &state);
> +        }
> +        dpa_base += decoder_size / cxl_interleave_ways_dec(iw, &error_fatal);
> +
> +    }
> +    return 0;
> +}


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

I don't see why this is the header.  It's only used in cxl-host.c
so I'd move it down there. If it were widely visible type you'd need
to follow QEMU type naming conventions. For local types things tend to be
a bit more relaxed.

> +
>  #define TYPE_CXL_SWITCH_MAILBOX_CCI "cxl-switch-mailbox-cci"
>  OBJECT_DECLARE_TYPE(CSWMBCCIDev, CSWMBCCIClass, CXL_SWITCH_MAILBOX_CCI)
>  

