Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980A34FC33F
	for <linux-cxl@vger.kernel.org>; Fri, 18 Sep 2026 16:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789747725; cv=none; b=euq03ZwR/gtfSqG4eOAVQJe5e2jLEQM7TC+8SgdxdjEnXhle5LKnefi9SFfnoa3Z/671PwfSWRa1auhUQvJ0QlQZP3KbZuArvIui2DJXYkE+hmZFetkk9964Nhbq5TsHZmLikvCNiJI+/PJOvA16vB+Wd5rwzEDEo+l1LbEm5RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789747725; c=relaxed/simple;
	bh=2Iei0iNRAEeJSJ7nPtTG4RbJeQ+KdptfeUAGR4I4VSQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sJUYLMaCVUo4BNiBP4OX3MAVUlZuLHa9LDQLHadXvs+cEpbMxiJAq6UpU7J8AK/DckXCAms0/dyE/Kts9ofcDyuYEP21CvlUVhwzajI6Z4f7VhO4ksKBC30c4ItvnBa/sFJ6v5ExklI+4Jj2XZASHY2n3gdVAfYqkZ8ZsOZ1304=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LH0kqcJM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LH0kqcJM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789747722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=EO+9xEUKlC0DwXPKoG0UbzFJr/QR6Zrv4dkwCm5D2u8=;
	b=LH0kqcJMGoXX8OenZqlb8vvxeW2rnDWfxMA0qSrS4OMitxsq4d8teEcpGVNtuSteEaFhh2
	zKYQJ1a6R3eW3NgYtVbBwG6JXUqLdOx9rWv0bUEShnwUBEa5KEUXSK+NZk4GCfcNTzhhJ9
	asM68I6TQWbAkfW1fE3t+8QpSYD82tY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-nhlZBbRzOjKKdKenpLk9sQ-1; Fri, 18 Sep 2026 12:08:40 -0400
X-MC-Unique: nhlZBbRzOjKKdKenpLk9sQ-1
X-Mimecast-MFC-AGG-ID: nhlZBbRzOjKKdKenpLk9sQ_1789747719
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49ccfbe060aso6590905e9.0
        for <linux-cxl@vger.kernel.org>; Fri, 18 Sep 2026 09:08:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789747719; x=1790352519;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EO+9xEUKlC0DwXPKoG0UbzFJr/QR6Zrv4dkwCm5D2u8=;
        b=l1FVcJUCL2kYhvg97b5cP8UebUkbk8r+tqZgUAszyaxmEGmgxarofZnFTVZh6R2EAd
         LkzQtZJEuqHGu3IeSidu9B1GRTUUWOcw/RIXnUUKqBjzkmyFPzgCtMAvbWuh0zNvX9Uj
         qkco02E5GDlRYU89VKLIWYX4oYYO7kHXkFvd65CPTFKAf6IVsBdoPTrWDzJiNhzxKSP6
         AQrp7Cd1kce5Qd3mJzS5h9gwBv/LSrtH4nP7F5X3tgij1WknJBlP2r28YAnY0G43ZsNp
         t64xG01T4+LcRg7iFKEIgln4JoF294MVXJiRbNr6s/LaSL5p/QfeMYup71oO7NwzpAAT
         eJ+Q==
X-Forwarded-Encrypted: i=1; AKwUvBwUQTVfhp2/MqvBiXMeWtdIf72UqcHfhuHO8vlCvqDOZlfPGedvVNoQTXR8hGRt7tFp1ozBRBm7GYc=@vger.kernel.org
X-Gm-Message-State: AFuF++mqOiXoTbPECKvsGfKpQZ7jktrzn9YnFBHvw8avkPJ60He/YDw2
	gv0JgEPihnjmtyAhhxVqJZnfV753LAPiyx/6ZrhQQOXAyN8Mvgd5cmlTkhS776R/bxPZL2EJNBS
	Vugto4HSbLvC9QIrIwElEJP0OGVjCg42DaFtIpun/kw05uBHrX4FBz+XamKVZ5w==
X-Gm-Gg: AYBFou020EwzKKcfWK7T5sM7/rW3CflGAItuGV0+nk72sbttRbkZ92iyBY47+mPl9MY
	y7joeMW7bd8CDbZkOyNEs8sW3ixsD53SJoj+0rmcWy2+SVnjxlZbXQ1xrQRd3of9oWrE1VDgIzF
	lRpJ2lkV6ExAbqocmj290eHRlsUXXK0jeg4UUEJ1LxdOn0atOHSQA3H64EpBxJosxu/HgB+JJG9
	B5yRL2yuvWkcVkPlReSFekDs336l0fIdZc1fHZ/hg3+3IOwhfEvS+OVExqHtRIBpmfzc4tCxJTA
	Wlrdqyp/gJONURB1n2YAXeSqKzWFGxYqyD/6NK+MmBg60I5Ao0jmsAMVTZc93C99/X+PI7g7lPC
	O2x8t7s5hAmw2P/2Dk00WpwT/nXXe19ZTfNAEBJkosA==
X-Received: by 2002:a05:600c:6212:b0:499:9240:9a1c with SMTP id 5b1f17b1804b1-49fc56f8327mr34222505e9.15.1789747719146;
        Fri, 18 Sep 2026 09:08:39 -0700 (PDT)
X-Received: by 2002:a05:600c:6212:b0:499:9240:9a1c with SMTP id 5b1f17b1804b1-49fc56f8327mr34222105e9.15.1789747718604;
        Fri, 18 Sep 2026 09:08:38 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:1292:d530:e939:7a09:c368:e5d5? ([2a01:e0a:1292:d530:e939:7a09:c368:e5d5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-487203f077fsm4790418f8f.26.2026.09.18.09.08.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2026 09:08:37 -0700 (PDT)
Message-ID: <9795f7b3-6ac4-4693-b39c-bb61d81e3f2d@redhat.com>
Date: Fri, 18 Sep 2026 18:08:36 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/10] hw/vfio/pci: Map the CXL memory on the guest
 decoder commit
To: mhonap@nvidia.com, alex@shazbot.org, ankita@nvidia.com, jic23@kernel.org,
 dave.jiang@intel.com, alejandro.lucero-palau@amd.com, smadhavan@nvidia.com,
 pierrick.bouvier@oss.qualcomm.com, mst@redhat.com, imammedo@redhat.com,
 anisinha@redhat.com, pbonzini@redhat.com, eric.auger@redhat.com,
 peter.maydell@linaro.org, richard.henderson@linaro.org, cohuck@redhat.com
Cc: kjaju@nvidia.com, vsethi@nvidia.com, zhiw@nvidia.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, linux-cxl@vger.kernel.org
References: <20260916184412.3825713-1-mhonap@nvidia.com>
 <20260916184412.3825713-8-mhonap@nvidia.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260916184412.3825713-8-mhonap@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rlEDSIGSjdIORoW4KOUm4vw-BIy6X80Kx6LCJFsDqmM_1789747719
X-Mimecast-Originator: redhat.com
Content-Language: en-US, fr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/16/26 20:44, mhonap@nvidia.com wrote:
> From: Manish Honap <mhonap@nvidia.com>
> 
> Overlay the trapped HDM decoder block over the component BAR and forward
> its accesses to the kernel. QEMU maps the HDM memory at the base of the
> device's CFMWS window and presents that same base back to the guest
> through the trapped decoder read
> 
> Overlap the CFMWS window MemoryRegion the CXL host bridge maps at that
> base, at a higher priority, so precedence is defined by priority rather
> than subregion insertion order.
> 
> QEMU always maps at the CFMWS base, so a decoder the guest commits at any
> other base would leave the guest's view and the mapping diverged. Track
> the base the guest writes to the trapped block and refuse to map a commit
> at a different base; a firmware-committed decoder the guest never
> reprograms keeps the window base.
> 
> AI-used-for: code (prototype)
> Signed-off-by: Manish Honap <mhonap@nvidia.com>
> ---
>   hw/cxl/cxl-host-stubs.c |   5 +
>   hw/vfio/pci.c           | 386 +++++++++++++++++++++++++++++++++++++++-
>   hw/vfio/pci.h           |   8 +
>   3 files changed, 393 insertions(+), 6 deletions(-)


This patch introduces too many concepts at once, a reader familiar
with VFIO can't separate the plumbing from the CXL details. This
needs more commits.

So, something like

1. framework
    Set up the comp_regs_region
    fd pass-through (pread/pwrite), no virtualization.
    teardown

2. Virtualization of decoder base registers

3. Map/unmap of HDM memory

    if fmws_base never changes, there's no reason to remove and
    re-add the subregion. Install it once and toggle with
    memory_region_set_enabled(). this should simplify the decoder
    handling.

4. Config write hooks
    PCI_COMMAND, CXL reset, PM transition, FLR x 2
    each could be a separate patch I think

I don't think we need the machine notifier as said in the previous
patch.

More below,

> 
> diff --git a/hw/cxl/cxl-host-stubs.c b/hw/cxl/cxl-host-stubs.c
> index 9b515913ea..1067c944e2 100644
> --- a/hw/cxl/cxl-host-stubs.c
> +++ b/hw/cxl/cxl-host-stubs.c
> @@ -23,3 +23,8 @@ GSList *cxl_fmws_get_all_sorted(void)
>   {
>       g_assert_not_reached();
>   }
> +
> +int cxl_decoder_count_dec(int enc_cnt)
> +{
> +    g_assert_not_reached();
> +}
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 670e0d1da4..fb3c39d4c6 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -1453,6 +1453,39 @@ uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len)
>       return val;
>   }
>   
> +static void vfio_cxl_decoder_changed(VFIOPCIDevice *vdev);
> +static void vfio_cxl_unmap_mem(VFIOPCIDevice *vdev);
> +
> +/*
> + * Return true if this config write sets a Function Level Reset bit the kernel
> + * acts on: the PCIe Device Control FLR bit or the Advanced Features FLR bit.
> + * FLR bits are write-1-to-trigger and self-clearing, so inspect the written
> + * value rather than the post-write config.
> + */
> +static bool vfio_cxl_flr_write(VFIOPCIDevice *vdev, uint32_t addr,
> +                               uint32_t val, int len)
> +{
> +    PCIDevice *pdev = &vdev->parent_obj;
> +    uint32_t off;
> +
> +    if (pdev->exp.exp_cap) {
> +        /* PCI_EXP_DEVCTL_BCR_FLR (bit 15) is the high byte of Device Ctrl. */
> +        off = pdev->exp.exp_cap + PCI_EXP_DEVCTL + 1;
> +        if (off >= addr && off < addr + len &&
> +            ((val >> (8 * (off - addr))) & (PCI_EXP_DEVCTL_BCR_FLR >> 8))) {
> +            return true;
> +        }
> +    }
> +    if (vdev->cxl.af_offset) {
> +        off = vdev->cxl.af_offset + PCI_AF_CTRL;
> +        if (off >= addr && off < addr + len &&
> +            ((val >> (8 * (off - addr))) & PCI_AF_CTRL_FLR)) {
> +            return true;
> +        }
> +    }
> +    return false;
> +}
> +
>   void vfio_pci_write_config(PCIDevice *pdev,
>                              uint32_t addr, uint32_t val, int len)
>   {
> @@ -1522,9 +1555,74 @@ void vfio_pci_write_config(PCIDevice *pdev,
>                   vfio_sub_page_bar_update_mapping(pdev, bar);
>               }
>           }
> +
> +        /*
> +         * A firmware-committed CXL decoder is already committed at boot, so no
> +         * guest control write triggers the HDM mapping. Map it once the guest
> +         * enables memory decoding, so the region enters the guest address space
> +         * and the IOAS while the device is live. On a clear of memory decoding,
> +         * withdraw the overlay: the kernel revokes the HDM PTEs on the same
> +         * write, so a retained memslot would fault a guest access during the
> +         * disabled interval onto a zapped VMA and stop the VM; the enable path
> +         * re-maps it.
> +         */
> +        if (vdev->cxl.enabled &&
> +            range_covers_byte(addr, len, PCI_COMMAND)) {
> +            if (pci_get_word(pdev->config + PCI_COMMAND) & PCI_COMMAND_MEMORY) {
> +                vfio_cxl_decoder_changed(vdev);
> +            } else {
> +                vfio_cxl_unmap_mem(vdev);
> +            }
> +        }
>       } else {
>           /* Write everything to QEMU to keep emulated bits correct */
>           pci_default_write_config(pdev, addr, val, len);
> +
> +        /*
> +         * A guest CXL reset is a write to the CXL Device DVSEC ctrl2 register,
> +         * forwarded to the kernel above, which re-commits this firmware-fixed
> +         * decoder. If the guest decommitted the decoder before the reset, which
> +         * unmapped the HDM memory, that re-commit is not otherwise visible to
> +         * QEMU, so rescan the decoder here to restore the mapping. Gated on
> +         * memory decoding still being enabled, like the enable path above.
> +         */
> +        if (vdev->cxl.enabled && vdev->cxl.dvsec_offset &&
> +            ranges_overlap(addr, len,
> +                           vdev->cxl.dvsec_offset +
> +                               offsetof(CXLDVSECDevice, ctrl2),
> +                           sizeof_field(CXLDVSECDevice, ctrl2)) &&
> +            (pci_get_word(pdev->config + PCI_COMMAND) & PCI_COMMAND_MEMORY)) {
> +            vfio_cxl_decoder_changed(vdev);
> +        }
> +
> +        /*
> +         * A NoSoftRst- device the guest cycles D3hot->D0 has its physical
> +         * decoder restored by the kernel on resume, which re-commits this
> +         * firmware-fixed decoder just like a reset. That re-commit is not
> +         * otherwise visible to QEMU, so on the transition back to D0 rescan
> +         * the decoder to restore a mapping the guest dropped before it
> +         * suspended. Gated on memory decoding, like the paths above.
> +         */
> +        if (vdev->cxl.enabled && pdev->pm_cap &&
> +            range_covers_byte(addr, len, pdev->pm_cap + PCI_PM_CTRL) &&
> +            (pci_get_word(pdev->config + pdev->pm_cap + PCI_PM_CTRL) &
> +             PCI_PM_CTRL_STATE_MASK) == 0 &&
> +            (pci_get_word(pdev->config + PCI_COMMAND) & PCI_COMMAND_MEMORY)) {
> +            vfio_cxl_decoder_changed(vdev);
> +        }
> +
> +        /*
> +         * A Function Level Reset the guest triggers through the PCIe Device
> +         * Control or Advanced Features FLR bit is forwarded to the kernel,
> +         * which re-commits this firmware-fixed decoder just like a CXL reset.
> +         * That re-commit is not otherwise visible to QEMU, so rescan the
> +         * decoder to restore a mapping the guest dropped before the FLR. Gated
> +         * on memory decoding, like the paths above.
> +         */
> +        if (vdev->cxl.enabled && vfio_cxl_flr_write(vdev, addr, val, len) &&
> +            (pci_get_word(pdev->config + PCI_COMMAND) & PCI_COMMAND_MEMORY)) {
> +            vfio_cxl_decoder_changed(vdev);
> +        }
>       }
>   }


That's a lot of CXL-specific code injected into vfio_pci_write_config.
Don't do that. Please add :

     if (vdev->cxl.enabled) {
         vfio_cxl_config_written(vdev, addr, val, len);
     }

I think that we should have a vfio/cxl.c subcomponent to isolate the
CXL-specific code :

   vfio_cxl_setup, or better vfio_cxl_realize
   vfio_cxl_config_written,
   vfio_cxl_exit,
   vfio_cxl_finalize,
   etc.



> @@ -3811,6 +3909,239 @@ static void vfio_cxl_bind_fmws(Notifier *n, void *data)
>       }
>   }
>   
> +/*
> + * HDM decoder registers, relative to the trapped decoder block. The block holds
> + * the HDM Decoder Capability register followed by one register set per decoder,
> + * each VFIO_CXL_HDM_DECODER_STRIDE apart, indexed by decoder.
> + */
> +#define VFIO_CXL_HDM_CAP                  0x00
> +#define VFIO_CXL_HDM_DECODER_STRIDE       0x20
> +#define VFIO_CXL_HDM_DECODER_BASE_LOW(n) \
> +    (0x10 + (n) * VFIO_CXL_HDM_DECODER_STRIDE)
> +#define VFIO_CXL_HDM_DECODER_BASE_HIGH(n) \
> +    (0x14 + (n) * VFIO_CXL_HDM_DECODER_STRIDE)
> +#define VFIO_CXL_HDM_DECODER_CTRL(n) \
> +    (0x20 + (n) * VFIO_CXL_HDM_DECODER_STRIDE)
> +#define VFIO_CXL_HDM_CTRL_COMMITTED       (1 << 10)
> +#define VFIO_CXL_HDM_BASE_LOW_MASK        0xf0000000U
> +
> +static void vfio_cxl_unmap_mem(VFIOPCIDevice *vdev)
> +{
> +    VFIOCXL *cxl = &vdev->cxl;
> +
> +    if (!cxl->dpa_mapped) {
> +        return;
> +    }
> +    memory_region_del_subregion(get_system_memory(), cxl->mem_region.mem);
> +    cxl->dpa_mapped = false;
> +    cxl->mapped_base = 0;
> +}
> +
> +/*
> + * The HDM Decoder Capability register encodes the decoder count in its low
> + * nibble (CXL r3.1 8.2.4.20.1, encodings 0h..Ch for 1..32). Decode it with the
> + * shared cxl_decoder_count_dec() helper so the commit handler walks every
> + * decoder rather than assuming decoder 0. An unreadable register or a reserved
> + * encoding (which the helper decodes to 0) is treated as a single decoder.
> + */
> +static unsigned vfio_cxl_decoder_count(VFIOPCIDevice *vdev)
> +{
> +    off_t off = vdev->cxl.comp_regs_region.fd_offset;
> +    uint32_t cap = 0;
> +    int count;
> +
> +    if (pread(vdev->vbasedev.fd, &cap, 4, off + VFIO_CXL_HDM_CAP) != 4) {
> +        return 1;
> +    }
> +    count = cxl_decoder_count_dec(le32_to_cpu(cap) & 0xf);
> +    return count > 0 ? count : 1;
> +}
> +
> +/*
> + * The guest committed or tore down an endpoint decoder. Walk each decoder in
> + * the trapped HDM block and (un)map the HDM memory at the CFMWS window base,
> + * not the base the guest programmed (see vfio_cxl_comp_regs_read). This
> + * generation commits one non-interleaved decoder, so the walk stops at the
> + * first committed decoder.

if only one decoder is supported and the code tracks the guest base
per-device rather than per-decoder, why do the read/write handlers
use VFIO_CXL_HDM_DECODER_BASE_LOW(0) to match all decoders ? This is
inconsistent.

I think we should record the active decoder index 'active_decoder'
instead. If a second committed decoder is found,  decoder_changed
should bail out.


> + */
> +static void vfio_cxl_decoder_changed(VFIOPCIDevice *vdev)
> +{
> +    VFIOCXL *cxl = &vdev->cxl;
> +    VFIODevice *vbasedev = &vdev->vbasedev;
> +    off_t off = cxl->comp_regs_region.fd_offset;
> +    unsigned n, count = vfio_cxl_decoder_count(vdev);
> +
> +    for (n = 0; n < count; n++) {
> +        uint32_t ctrl = 0;
> +
> +        if (pread(vbasedev->fd, &ctrl, 4,
> +                  off + VFIO_CXL_HDM_DECODER_CTRL(n)) != 4) {
> +            return;
> +        }
> +        if (!(le32_to_cpu(ctrl) & VFIO_CXL_HDM_CTRL_COMMITTED)) {
> +            continue;
> +        }
> +
> +        /*
> +         * QEMU always maps at the device's CFMWS base and presents that base
> +         * back to the guest, so a decoder the guest committed at any other base
> +         * would leave the guest's view and the actual mapping diverged. Reject
> +         * it rather than silently relocate. A firmware-committed decoder the
> +         * guest never reprogrammed (guest_base_written == false) keeps the
> +         * CFMWS base.
> +         */
> +        if (cxl->guest_base_written) {
> +            hwaddr guest_base = ((hwaddr)cxl->guest_base_hi << 32) |
> +                                cxl->guest_base_lo;
> +
> +            if (guest_base != cxl->fmws_base) {
> +                warn_report("vfio-cxl: %s: guest committed decoder %u at 0x%"
> +                            HWADDR_PRIx ", not the CFMWS base 0x%" HWADDR_PRIx
> +                            "; not mapping", vbasedev->name, n, guest_base,
> +                            cxl->fmws_base);
> +                vfio_cxl_unmap_mem(vdev);
> +                return;
> +            }
> +        }
> +
> +        if (cxl->dpa_mapped && cxl->mapped_base == cxl->fmws_base) {
> +            return;
> +        }
> +        /*
> +         * Overlap the CFMWS window MemoryRegion the CXL host bridge already
> +         * maps at this base, at a higher priority, so precedence is defined by
> +         * priority rather than subregion insertion order.
> +         */
> +        memory_region_transaction_begin();
> +        vfio_cxl_unmap_mem(vdev);
> +        memory_region_add_subregion_overlap(get_system_memory(),
> +                                            cxl->fmws_base,
> +                                            cxl->mem_region.mem, 1);
> +        memory_region_transaction_commit();
> +        cxl->mapped_base = cxl->fmws_base;
> +        cxl->dpa_mapped = true;
> +        return;
> +    }
> +
> +    /* No committed decoder in the block: tear down any existing mapping. */
> +    vfio_cxl_unmap_mem(vdev);
> +}
> +
> +static uint64_t vfio_cxl_comp_regs_read(void *opaque, hwaddr addr,
> +                                        unsigned size)
> +{
> +    VFIORegion *region = opaque;
> +    VFIODevice *vbasedev = region->vbasedev;
> +    VFIOPCIDevice *vdev =
> +        container_of(region, VFIOPCIDevice, cxl.comp_regs_region);
> +    VFIOCXL *cxl = &vdev->cxl;
> +    uint32_t val = 0xffffffff;
> +
> +    if (pread(vbasedev->fd, &val, size, region->fd_offset + addr) != size) {
> +        error_report("vfio-cxl: %s: HDM decoder read at 0x%" HWADDR_PRIx
> +                     " failed", vbasedev->name, addr);
> +    }
> +    val = le32_to_cpu(val);
> +
> +    /*
> +     * The kernel shadow holds the host physical base for a firmware-committed
> +     * decoder. Never expose that to the guest: present the guest physical base
> +     * QEMU maps the HDM memory at (the device's CFMWS window). Any decoder's
> +     * base registers are virtualized; ctrl, size and the capability header pass
> +     * through. The base registers repeat every VFIO_CXL_HDM_DECODER_STRIDE.
> +     */
> +    if (addr >= VFIO_CXL_HDM_DECODER_BASE_LOW(0) &&
> +        (addr - VFIO_CXL_HDM_DECODER_BASE_LOW(0)) %
> +                VFIO_CXL_HDM_DECODER_STRIDE == 0) {
> +        val = (val & ~VFIO_CXL_HDM_BASE_LOW_MASK) |
> +              ((uint32_t)cxl->fmws_base & VFIO_CXL_HDM_BASE_LOW_MASK);
> +    } else if (addr >= VFIO_CXL_HDM_DECODER_BASE_HIGH(0) &&
> +               (addr - VFIO_CXL_HDM_DECODER_BASE_HIGH(0)) %
> +                       VFIO_CXL_HDM_DECODER_STRIDE == 0) {
> +        val = (uint32_t)(cxl->fmws_base >> 32);
> +    }
> +
> +    return val;
> +}
> +
> +static void vfio_cxl_comp_regs_write(void *opaque, hwaddr addr, uint64_t data,
> +                                     unsigned size)
> +{
> +    VFIORegion *region = opaque;
> +    VFIODevice *vbasedev = region->vbasedev;
> +    VFIOPCIDevice *vdev =
> +        container_of(region, VFIOPCIDevice, cxl.comp_regs_region);
> +    uint32_t val = cpu_to_le32((uint32_t)data);
> +
> +    if (pwrite(vbasedev->fd, &val, size, region->fd_offset + addr) != size) {
> +        error_report("vfio-cxl: %s: HDM decoder write at 0x%" HWADDR_PRIx
> +                     " failed", vbasedev->name, addr);
> +        return;
> +    }
> +
> +    /*
> +     * Record the base the guest programs into a decoder so the commit handler
> +     * can reject a base other than the device's CFMWS window. The base low
> +     * register carries HPA bits [31:28]; the high register carries [63:32].
> +     */
> +    if (addr >= VFIO_CXL_HDM_DECODER_BASE_LOW(0) &&
> +        (addr - VFIO_CXL_HDM_DECODER_BASE_LOW(0)) %
> +                VFIO_CXL_HDM_DECODER_STRIDE == 0) {
> +        vdev->cxl.guest_base_lo = (uint32_t)data & VFIO_CXL_HDM_BASE_LOW_MASK;
> +        vdev->cxl.guest_base_written = true;
> +    } else if (addr >= VFIO_CXL_HDM_DECODER_BASE_HIGH(0) &&
> +               (addr - VFIO_CXL_HDM_DECODER_BASE_HIGH(0)) %
> +                       VFIO_CXL_HDM_DECODER_STRIDE == 0) {
> +        vdev->cxl.guest_base_hi = (uint32_t)data;
> +        vdev->cxl.guest_base_written = true;
> +    }
> +
> +    /*
> +     * The kernel runs the lock-on-commit FSM in the write above, so the
> +     * committed state is settled by now; a control write on any decoder can
> +     * change the mapping.
> +     */
> +    if (addr >= VFIO_CXL_HDM_DECODER_CTRL(0) &&
> +        (addr - VFIO_CXL_HDM_DECODER_CTRL(0)) %
> +        VFIO_CXL_HDM_DECODER_STRIDE == 0) {
> +        vfio_cxl_decoder_changed(vdev);
> +    }
> +}
> +
> +static const MemoryRegionOps vfio_cxl_comp_regs_ops = {
> +    .read = vfio_cxl_comp_regs_read,
> +    .write = vfio_cxl_comp_regs_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .valid = { .min_access_size = 4, .max_access_size = 4 },
> +    .impl = { .min_access_size = 4, .max_access_size = 4 },
> +};
> +
> +/*
> + * Locate the CXL Device DVSEC (CXL r3.1 8.1.3) in config space. The guest
> + * triggers a CXL reset by writing its ctrl2 register; QEMU rescans the decoder
> + * after that write so the HDM mapping is restored (see vfio_pci_write_config).
> + * Returns the DVSEC config offset, or 0 if the device does not expose it.
> + */
> +static uint16_t vfio_cxl_find_device_dvsec(PCIDevice *pdev)
> +{
> +    uint16_t offset;
> +
> +    for (offset = PCI_CONFIG_SPACE_SIZE; offset;
> +         offset = PCI_EXT_CAP_NEXT(pci_get_long(pdev->config + offset))) {
> +        uint32_t hdr = pci_get_long(pdev->config + offset);
> +
> +        if (PCI_EXT_CAP_ID(hdr) == PCI_EXT_CAP_ID_DVSEC &&
> +            (pci_get_long(pdev->config + offset + PCI_DVSEC_HEADER1) & 0xffff)
> +                == CXL_VENDOR_ID &&
> +            pci_get_word(pdev->config + offset + PCI_DVSEC_HEADER2)
> +                == PCIE_CXL_DEVICE_DVSEC) {
> +            return offset;
> +        }
> +    }
> +
> +    return 0;
> +}

This should be a PCIe helper :

   uint16_t pcie_find_dvsec(PCIDevice *dev, uint16_t vendor_id, uint16_t dvsec_id);

Thanks,

C.


>   /*
>    * Learn the CXL geometry the kernel reports: the HPA-backed HDM memory region
>    * and the trapped HDM decoder block (which BAR carries it and at what offset).
> @@ -3864,6 +4195,8 @@ static bool vfio_cxl_setup(VFIOPCIDevice *vdev, Error **errp)
>       cxl->dpa_size = mem_info->size;
>       cxl->comp_bar = cap->bar;
>       cxl->hdm_offset = cap->offset;
> +    cxl->dvsec_offset = vfio_cxl_find_device_dvsec(&vdev->parent_obj);
> +    cxl->af_offset = pci_find_capability(&vdev->parent_obj, PCI_CAP_ID_AF);
>   
>       if (!vfio_cxl_check_topology(vdev, errp)) {
>           return false;
> @@ -3887,6 +4220,26 @@ static bool vfio_cxl_setup(VFIOPCIDevice *vdev, Error **errp)
>                       "performance may be slow", vbasedev->name);
>       }
>   
> +    /*
> +     * Trap the HDM decoder block: overlay it, priority 1, over the directly
> +     * mapped component BAR, so guest decoder accesses reach the kernel FSM and
> +     * the commit becomes visible to QEMU.
> +     */
> +    if (!vdev->bars[cxl->comp_bar].mr) {
> +        error_setg(errp, "vfio-cxl: %s: component BAR %u is not present",
> +                   vbasedev->name, cxl->comp_bar);
> +        goto err;
> +    }
> +    if (vfio_region_setup_with_ops(OBJECT(vdev), vbasedev,
> +                                   &cxl->comp_regs_region,
> +                                   cxl->comp_regs_region_index, "cxl-comp-regs",
> +                                   &vfio_cxl_comp_regs_ops, errp)) {
> +        goto err;
> +    }
> +    memory_region_add_subregion_overlap(vdev->bars[cxl->comp_bar].mr,
> +                                        cxl->hdm_offset,
> +                                        cxl->comp_regs_region.mem, 1);
> +
>       if (DEVICE(vdev)->hotplugged) {
>           /*
>            * The machine is already up, so the CFMWS windows are placed and the
> @@ -3894,9 +4247,7 @@ static bool vfio_cxl_setup(VFIOPCIDevice *vdev, Error **errp)
>            * device_add fails cleanly instead of aborting the running VM.
>            */
>           if (!vfio_cxl_do_bind_fmws(vdev, errp)) {
> -            vfio_region_exit(&cxl->mem_region);
> -            vfio_region_finalize(&cxl->mem_region);
> -            return false;
> +            goto err;
>           }
>       } else {
>           cxl->machine_done.notify = vfio_cxl_bind_fmws;
> @@ -3906,6 +4257,10 @@ static bool vfio_cxl_setup(VFIOPCIDevice *vdev, Error **errp)
>       cxl->enabled = true;
>   
>       return true;
> +
> +err:
> +    vfio_cxl_teardown(vdev);
> +    return false;
>   }
>   
>   static void vfio_cxl_teardown(VFIOPCIDevice *vdev)
> @@ -3916,15 +4271,26 @@ static void vfio_cxl_teardown(VFIOPCIDevice *vdev)
>           return;
>       }
>   
> -    if (cxl->machine_done.notify) {
> -        qemu_remove_machine_init_done_notifier(&cxl->machine_done);
> -        cxl->machine_done.notify = NULL;
> +    if (cxl->comp_regs_region.mem) {
> +        if (vdev->bars[cxl->comp_bar].mr) {
> +            memory_region_del_subregion(vdev->bars[cxl->comp_bar].mr,
> +                                        cxl->comp_regs_region.mem);
> +        }
> +        vfio_region_exit(&cxl->comp_regs_region);
> +        vfio_region_finalize(&cxl->comp_regs_region);
>       }
>   
> +    vfio_cxl_unmap_mem(vdev);
> +
>       if (cxl->mem_region.mem) {
>           vfio_region_exit(&cxl->mem_region);
>           vfio_region_finalize(&cxl->mem_region);
>       }
> +
> +    if (cxl->machine_done.notify) {
> +        qemu_remove_machine_init_done_notifier(&cxl->machine_done);
> +        cxl->machine_done.notify = NULL;
> +    }
>   }
>   
>   static void vfio_pci_realize(PCIDevice *pdev, Error **errp)
> @@ -4127,6 +4493,14 @@ static void vfio_exitfn(PCIDevice *pdev)
>       vfio_pci_teardown_msi(vdev);
>       vfio_pci_disable_rp_atomics(vdev);
>       vfio_pci_bars_exit(vdev);
> +    /*
> +     * The committed HDM overlay is a subregion of system memory owned by this
> +     * device, so it holds a reference that would keep the object alive past
> +     * unrealize and block instance_finalize (where vfio_cxl_teardown otherwise
> +     * runs). Drop it here; the call is idempotent for a device that never
> +     * mapped or is not CXL.
> +     */
> +    vfio_cxl_unmap_mem(vdev);
>       vfio_migration_exit(vbasedev);
>       if (!vbasedev->mdev) {
>           pci_device_unset_iommu_device(pdev);
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index 22fe8d7ff7..5bfa976112 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -133,11 +133,19 @@ typedef struct VFIOCXL {
>       uint32_t comp_regs_region_index; /* trapped HDM decoder register block */
>       uint32_t comp_bar;               /* component BAR carrying that block */
>       uint64_t hdm_offset;             /* block offset within the component BAR */
> +    uint16_t dvsec_offset;           /* CXL Device DVSEC offset, 0 if none */
> +    uint16_t af_offset;              /* PCI Advanced Features cap, 0 if none */
>       uint64_t dpa_size;               /* size of the HDM memory region */
>       VFIORegion mem_region;           /* HDM memory, mapped at committed GPA */
>       Notifier machine_done;           /* CFMWS validated at machine_done */
>       hwaddr fmws_base;                /* base of the memory window */
>       uint64_t fmws_size;              /* size of the memory window */
> +    VFIORegion comp_regs_region;     /* trapped HDM decoder block */
> +    hwaddr mapped_base;              /* GPA the HDM memory is mapped at */
> +    bool dpa_mapped;                 /* HDM memory currently in system memory */
> +    uint32_t guest_base_lo;          /* decoder base low the guest wrote */
> +    uint32_t guest_base_hi;          /* decoder base high the guest wrote */
> +    bool guest_base_written;         /* the guest wrote a decoder base */
>   } VFIOCXL;
>   
>   struct VFIOPCIDevice {

