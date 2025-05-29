Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B054813AC1
	for <linux-cxl@vger.kernel.org>; Thu, 29 May 2025 12:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748520840; cv=none; b=QniDNHlUDVxb5coJdGW03U6LudP4QiJTSJZdysO9M8zeZg+4Q5bN0F+cMmDpEq0BL/zpTKs39bsUD/zNUKC11xJOgYHOkLGyXVYZTf04nF/mTtdOyA3tq9CkgSKw2rtRRqUo4NU1zXMvR9GBRckK5hQYAt3nh6NllIhFPeD5LX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748520840; c=relaxed/simple;
	bh=ngzkkTgiR91aIH3u4HQw0tFNWZ9vYkpwMaa2VmeC/S0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nt22Q9VC07tnuBajRjUjkGAyRy3NQOiNM09qykx7wa4DJzmXXQvXIg+GEn5M5vbC1umpLRJZ3ZCs/fSw6L9f5jXDQJgJaDsdsMW1HoN83VnL/OxsxAujdnGoErP8F/iVYh2KEJqU/h6/JvVFhux60PWRBd2cr9ZN0IxoWz5WXvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b7QJZ509Kz6M4tD;
	Thu, 29 May 2025 20:13:50 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id BD27C140432;
	Thu, 29 May 2025 20:13:54 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 29 May
 2025 14:13:54 +0200
Date: Thu, 29 May 2025 13:13:52 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Vinayak Holikatti <vinayak.kh@samsung.com>
CC: <qemu-devel@nongnu.org>, <gost.dev@samsung.com>,
	<linux-cxl@vger.kernel.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
	<vishak.g@samsung.com>, <krish.reddy@samsung.com>,
	<a.manzanares@samsung.com>, <alok.rathore@samsung.com>
Subject: Re: [PATCH] Add support for FMAPI Get Mutliheaded Head info opcode
 (5501h)
Message-ID: <20250529131352.00007aaf@huawei.com>
In-Reply-To: <20250522063135.366295-1-vinayak.kh@samsung.com>
References: <CGME20250522063149epcas5p13719600aa8f59313ff3dc2570c996aec@epcas5p1.samsung.com>
	<20250522063135.366295-1-vinayak.kh@samsung.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 22 May 2025 12:01:35 +0530
Vinayak Holikatti <vinayak.kh@samsung.com> wrote:

> CXL spec 3.2 section 7.6.7.5.2  describes Get Head Info.
> 
> Signed-off-by: Vinayak Holikatti <vinayak.kh@samsung.com>

Hi Vinayak,

Some code simplification suggestions below.

> ---
> This patch is generated against Jonathan Cameron's branch cxl-2025-03-20
> 
>  hw/cxl/cxl-mailbox-utils.c  | 21 +++++++++
>  hw/cxl/mhsld/mhsld.c        | 92 ++++++++++++++++++++++++++++++++++++-
>  hw/cxl/mhsld/mhsld.h        | 26 +++++++++++
>  include/hw/cxl/cxl_device.h |  6 +++
>  4 files changed, 144 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index a02d130926..4f25caecea 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c

> diff --git a/hw/cxl/mhsld/mhsld.c b/hw/cxl/mhsld/mhsld.c
> index 9f633b3bed..981546b5ff 100644
> --- a/hw/cxl/mhsld/mhsld.c
> +++ b/hw/cxl/mhsld/mhsld.c
> @@ -61,9 +61,57 @@ static CXLRetCode cmd_mhd_get_info(const struct cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
>  
> +/*
> + * CXL r3.2 section 7.6.7.5.2 - Get Head Info (Opcode 5501h)
> + *
> + * This command retrieves the number of heads, number of supported LDs,
> + * and Head-to-LD mapping of a Multi-Headed device.
> + */
> +static CXLRetCode cmd_mhd_get_head_info(const struct cxl_cmd *cmd,
> +                                        uint8_t *payload_in, size_t len_in,
> +                                        uint8_t *payload_out, size_t *len_out,
> +                                        CXLCCI *cci)
> +{
> +    CXLMHSLDState *s = CXL_MHSLD(cci->d);
> +    MHDGetHeadInfoInput *input = (void *)payload_in;
> +    MHDGetHeadInfoOutput *output = (void *)payload_out;
> +    int i = 0;
> +
> +    if (input->start_head > MHSLD_HEADS) {
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +
> +    output->nr_heads = MIN((MHSLD_HEADS - input->start_head), input->nr_heads);
> +    for (i = input->start_head; i < input->start_head + output->nr_heads; i++) {

Can we get away with a memcpy()?  Any endian issues on any of these?

> +        output->head_info_list[i].port_number =
> +                                 s->mhd_state->head_info_blocks[i].port_number;
> +        output->head_info_list[i].max_link_width =
> +                              s->mhd_state->head_info_blocks[i].max_link_width;
> +        output->head_info_list[i].nego_link_width =
> +                             s->mhd_state->head_info_blocks[i].nego_link_width;
> +        output->head_info_list[i].supp_link_speeds_vector =
> +                     s->mhd_state->head_info_blocks[i].supp_link_speeds_vector;
> +        output->head_info_list[i].max_link_speed =
> +                              s->mhd_state->head_info_blocks[i].max_link_speed;
> +        output->head_info_list[i].current_link_speed =
> +                          s->mhd_state->head_info_blocks[i].current_link_speed;
> +        output->head_info_list[i].ltssm_state =
> +                                 s->mhd_state->head_info_blocks[i].ltssm_state;
> +        output->head_info_list[i].first_nego_lane_num =
> +                         s->mhd_state->head_info_blocks[i].first_nego_lane_num;
> +        output->head_info_list[i].link_state_flags =
> +                            s->mhd_state->head_info_blocks[i].link_state_flags;
> +    }
> +
> +    *len_out = sizeof(*output) + output->nr_heads * sizeof(MHDHeadInfoBlock);
> +    return CXL_MBOX_SUCCESS;
> +}

>  static const Property cxl_mhsld_props[] = {
> @@ -166,6 +214,47 @@ static void cxl_mhsld_state_initialize(CXLMHSLDState *s, size_t dc_size)
>      s->mhd_state->nr_blocks = dc_size / MHSLD_BLOCK_SZ;
>  }
>  
> +
> +static void cxl_mhsld_init_head_info(CXLMHSLDState *s, PCIDevice *pdev)
> +{
> +    uint16_t lnksta = 0;

No need to initialize when they are always set below.

> +    uint16_t current_link_speed = 0;
> +    uint16_t negotiated_link_width = 0;
> +    uint16_t lnkcap = 0, lnkcap2 = 0;
> +    uint16_t max_link_width = 0;
> +    uint16_t max_link_speed = 0;

Once you drop the unnecessary init combine width and speed on one line.
Or as below, get rid of most of these local variables entirely.

> +    uint16_t supported_link_speeds_vector = 0;
> +
> +    lnksta = pdev->config_read(pdev,
> +                               pdev->exp.exp_cap + PCI_EXP_LNKSTA,
> +                               sizeof(lnksta));
> +    lnkcap = pdev->config_read(pdev,
> +                               pdev->exp.exp_cap + PCI_EXP_LNKCAP,
> +                               sizeof(lnkcap));
> +    lnkcap2 = pdev->config_read(pdev,
> +                                pdev->exp.exp_cap + PCI_EXP_LNKCAP2,
> +                                sizeof(lnkcap2));
> +    supported_link_speeds_vector = (lnkcap2 & 0xFE) >> 1;
Worth considering adding defines for that to incluw/hw/pci/pcie_regs.h

> +    max_link_width = (lnkcap & PCI_EXP_LNKCAP_MLW) >> 4;

Use PCI_EXP_LNK_MLW_SHIFT to extract that.
(we should also tidy this up in physical port state.


> +    max_link_speed = lnkcap & PCI_EXP_LNKCAP_SLS;
> +    current_link_speed = lnksta & PCI_EXP_LNKSTA_CLS;
> +    negotiated_link_width = (lnksta & PCI_EXP_LNKSTA_NLW) >> 4;
Similar - there should be a suitable define for that shift.
> +
> +    s->mhd_state->head_info_blocks[s->mhd_head].port_number = s->mhd_head;

I would use something like

    s->mhd_state->head_info_blocks[s->mhd_head] = (MHDHeadInfoBlock) {
        .max_link_width = lnkcap & PCI_EXP_LNKCAP_SLS,
        .nego_link_width = (lnksta & PCI_EXP_LNKSTA_NLW) >> 4, //with the define
        .supp_link_speeds_vector = (lnkcap2 & 0xFE) >> 1,
etc
    };
> +    s->mhd_state->head_info_blocks[s->mhd_head].max_link_width = max_link_width;
> +    s->mhd_state->head_info_blocks[s->mhd_head].nego_link_width =
> +                                                          negotiated_link_width;
> +    s->mhd_state->head_info_blocks[s->mhd_head].supp_link_speeds_vector =
> +                                                   supported_link_speeds_vector;
> +    s->mhd_state->head_info_blocks[s->mhd_head].max_link_speed =
> +                                                                 max_link_speed;
> +    s->mhd_state->head_info_blocks[s->mhd_head].current_link_speed =
> +                                                             current_link_speed;
> +    s->mhd_state->head_info_blocks[s->mhd_head].ltssm_state = 0x7;
> +    s->mhd_state->head_info_blocks[s->mhd_head].first_nego_lane_num = 0;
> +    s->mhd_state->head_info_blocks[s->mhd_head].link_state_flags = 0;
> +}
> +
>  /* Returns starting index of region in MHD map. */
>  static inline size_t cxl_mhsld_find_dc_region_start(PCIDevice *d,
>                                                      CXLDCRegion *r)
> @@ -376,7 +465,7 @@ static void cxl_mhsld_realize(PCIDevice *pci_dev, Error **errp)
>      }
>  
>      cxl_mhsld_state_initialize(s, dc_size);
> -
> +    cxl_mhsld_init_head_info(s, pci_dev);
Avoid the white space noise by leaving a blank line here.

>      /* Set the LD ownership for this head to this system */
>      s->mhd_state->ldmap[s->mhd_head] = s->mhd_head;
>      return;
