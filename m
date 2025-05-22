Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA81258CC2
	for <linux-cxl@vger.kernel.org>; Thu, 22 May 2025 23:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747955531; cv=none; b=pOSHk6sQgrHwQuowqPyouu5KiZONofszzTHY7QkOj85KuKDQFqK3CBJAnAg2T2jSGOm7bMiWCwW6z1t2XcfKksI6oYCYVaDz7K0Vg+U3Df8XAO78zfhvv28oX7B+NIZ3u/42wrxJ+99ktBDff9jCZwm5Aj83AaQQ1DcN3BmlZkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747955531; c=relaxed/simple;
	bh=nMFPkRsTPos0ytqR3GkK4mhdn/vla0d+C+qH31CCANk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O9yir7XBaKXR5Z199Xrvc4HhIjahr18RRE0r3Eqsy7lUvIgSmFrZU4vTa98fmj9h36vmN313gD5DU/NQLOME4G7S08Q1/tAcu0ZJmI0B/tetrIHp7Pds6Qyt/RY2PYODrXYG6LMNCOMQjFfkUEn75GBrOjF2nIz0+gqA5NmO4hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YIXGA6Kj; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YIXGA6Kj"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-742c035f2afso3867814b3a.2
        for <linux-cxl@vger.kernel.org>; Thu, 22 May 2025 16:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747955528; x=1748560328; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j1J0rdfNf6oSVNd0zB5466LyVNvbYFqQVm29KeuaT/c=;
        b=YIXGA6KjjxqONTsid30BqjQIWz2AOzjotu2lM+lMA78ZCk0POTcNdpAE/FJ5S35uws
         IZ5x4xdyje4TMsR3sFI5mg0xhFIK7V5fuy6ZGyl7DATsZbyxQ6q27NywJwkYGx2z3mrJ
         7Mm0IOPK2bRtV9S2MV4tAlRA+gS1JkP24MbNu2FyfDTL7bK5JCCMzIoFdj46/mQmobRp
         6HPkF0ozM1NMmLo7eyOXpQ6BDlyPoAM6eHGZeU2vt/h/GHUK31tu4cwCkwP2xzPl4qUR
         y14FsDpLNHXn4OEljWTmQaB/yW8sH5D1iSxWvSbZaKiwwO6+mWdtq/dmjsJ/PG70XZxn
         zRJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747955528; x=1748560328;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j1J0rdfNf6oSVNd0zB5466LyVNvbYFqQVm29KeuaT/c=;
        b=gt8NUqpbbtAwQs8Zol16m2JpfGgHEZ7YfBWdLzygDr+aJZpo7hdwx7/Xqz5Qx2pnFD
         agQIW6bJjy9wLpIOd97V0OC2dG1XW+N5IHTKWvKFQyhrEKllRxNVrndVikH/QygerI9Q
         98KC2vw72+MN/AjLiDMrxGyANNgf5XhQi0x04Z5oG7gYoSDWbJ5b8wJ5HYPfQiKH9loM
         pJOUcjYe4tZmQhjWvrdX9qOMBJC1RUOeGNg6d1fHZAvGUEhnCNfI0EoCE66P8flaWR9A
         wtL4S1+hx6ZZ1cfb5U6cSkBdpljaymAuns7N3iyyqCbhjRAig1JiXsTVdbLQxtlAew3X
         LysQ==
X-Forwarded-Encrypted: i=1; AJvYcCXX2mTYvOE3r9rCeiHbEBhW58q43LQmBjGQnBUy0ESMt+3GXtcTzgKUZPWg/6PrDxswulMWZqyQJhc=@vger.kernel.org
X-Gm-Message-State: AOJu0YziLx39WNvfMNTUcS8CQJ1SSIoz+TTfvHjeTedMAmt5EqV89AZD
	JbTU/oCEcLfroxL123TwCKHlsRB4/zCC4MBLagXATm9niVbWn87MQ6lq
X-Gm-Gg: ASbGncvtCKBmG5tM9DWRxlMHOHU1BjH2YH1d/ahdm1NBk5otqQbFXsSyEXBE9Pm7cH3
	BO+yBfiAUuOTggV7PoNYygCTbme2eoM1r404pBQfiPolgXUagCiLm8DfbgK9yx+Dys5kp47mmIx
	CBkzbsx20p6t9M4thmivk/W89gD6CzvQMThzbHnSj1tlUl8tspQb3sXeeeV7iQSAJcGf3UfLfFU
	4SGDbrMK/ejy/QsvXsAI7gR/ZE9WR1s20P58H9YckzF3+OJJLr07zZloHUYhHnPutmSlHpgnzW6
	62L1MysJqUEtRE02bvsgkXCTPVekucYvfCfqtcHfh5ZPg6aM4QRjHHJe2Y/vD5puVyW7g606ubx
	1waGHBCa9kTuS
X-Google-Smtp-Source: AGHT+IFEIgXigdlw1VBiXkMiCdivhEwucMa8iHNVPAwYBgAkncbxZL2qPZ1uPumoF+TIZfHlqUeqAA==
X-Received: by 2002:aa7:88c8:0:b0:73e:2dc5:a93c with SMTP id d2e1a72fcca58-742a97c4fd9mr34074533b3a.11.1747955528252;
        Thu, 22 May 2025 16:12:08 -0700 (PDT)
Received: from deb-101020-bm01.eng.stellus.in ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a9739906sm11733480b3a.80.2025.05.22.16.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 16:12:07 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Thu, 22 May 2025 23:12:05 +0000
To: Vinayak Holikatti <vinayak.kh@samsung.com>
Cc: nifan.cxl@gmail.com, a.manzanares@samsung.com, alok.rathore@samsung.com,
	dave@stgolabs.net, gost.dev@samsung.com, krish.reddy@samsung.com,
	linux-cxl@vger.kernel.org, qemu-devel@nongnu.org,
	vishak.g@samsung.com
Subject: Re: [PATCH] Add support for FMAPI Get Mutliheaded Head info opcode
 (5501h)
Message-ID: <aC-vRUoCDJ70_yox@deb-101020-bm01.eng.stellus.in>
References: <20250522063135.366295-1-vinayak.kh@samsung.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250522063135.366295-1-vinayak.kh@samsung.com>

On Thu, May 22, 2025 at 12:01:35PM +0530, Vinayak Holikatti wrote:
> CXL spec 3.2 section 7.6.7.5.2  describes Get Head Info.
> 
> Signed-off-by: Vinayak Holikatti <vinayak.kh@samsung.com>
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
> @@ -122,6 +122,7 @@ enum {
>          #define MANAGEMENT_COMMAND     0x0
>      MHD = 0x55,
>          #define GET_MHD_INFO 0x0
> +        #define GET_MHD_HEAD_INFO 0x1
>  };
>  
>  /* CCI Message Format CXL r3.1 Figure 7-19 */
> @@ -267,6 +268,23 @@ static CXLRetCode cmd_mhd_get_info(const struct cxl_cmd *cmd,
>      return CXL_MBOX_UNSUPPORTED;
>  }
>  
> +/*
> + * CXL r3.2 section 7.6.7.5.2 - Get Multi-Headed Head Info (Opcode 5501h)
> + */
> +static CXLRetCode cmd_mhd_get_head_info(const struct cxl_cmd *cmd,
> +                                   uint8_t *payload_in, size_t len_in,
> +                                   uint8_t *payload_out, size_t *len_out,
> +                                   CXLCCI *cci)
> +{
> +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> +    CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(ct3d);
> +    if (cvc->mhd_get_head_info) {
> +        return cvc->mhd_get_head_info(cmd, payload_in, len_in, payload_out,
> +                                 len_out, cci);
> +    }
> +    return CXL_MBOX_UNSUPPORTED;
> +}
> +
>  static CXLRetCode cmd_events_get_records(const struct cxl_cmd *cmd,
>                                           uint8_t *payload_in, size_t len_in,
>                                           uint8_t *payload_out, size_t *len_out,
> @@ -3429,6 +3447,7 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
>          "MEDIA_AND_POISON_GET_SCAN_MEDIA_RESULTS",
>          cmd_media_get_scan_media_results, 0, 0 },
>      [MHD][GET_MHD_INFO] = { "GET_MULTI_HEADED_INFO", cmd_mhd_get_info, 2, 0},
> +    [MHD][GET_MHD_HEAD_INFO] = { "GET_MULTI_HEADED_INFO", cmd_mhd_get_head_info, 2, 0},
The name here "GET_MULTI_HEADED_INFO" is the same as the previous command.
>  };
>  
...  
> +
> +static void cxl_mhsld_init_head_info(CXLMHSLDState *s, PCIDevice *pdev)
> +{
> +    uint16_t lnksta = 0;
> +    uint16_t current_link_speed = 0;
> +    uint16_t negotiated_link_width = 0;
> +    uint16_t lnkcap = 0, lnkcap2 = 0;
> +    uint16_t max_link_width = 0;
> +    uint16_t max_link_speed = 0;
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
> +    max_link_width = (lnkcap & PCI_EXP_LNKCAP_MLW) >> 4;
> +    max_link_speed = lnkcap & PCI_EXP_LNKCAP_SLS;
> +    current_link_speed = lnksta & PCI_EXP_LNKSTA_CLS;
> +    negotiated_link_width = (lnksta & PCI_EXP_LNKSTA_NLW) >> 4;
> +
> +    s->mhd_state->head_info_blocks[s->mhd_head].port_number = s->mhd_head;
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
I think it would be helpful to make a define for the ltssm states?
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
>      /* Set the LD ownership for this head to this system */
>      s->mhd_state->ldmap[s->mhd_head] = s->mhd_head;
>      return;
> @@ -428,6 +517,7 @@ static void cxl_mhsld_class_init(ObjectClass *klass, void *data)
>  
>      CXLType3Class *cvc = CXL_TYPE3_CLASS(klass);
>      cvc->mhd_get_info = cmd_mhd_get_info;
> +    cvc->mhd_get_head_info = cmd_mhd_get_head_info;
>      cvc->mhd_access_valid = cxl_mhsld_access_valid;
>      cvc->mhd_reserve_extents = cxl_mhsld_reserve_extents;
>      cvc->mhd_reclaim_extents = cxl_mhsld_reclaim_extents;
> diff --git a/hw/cxl/mhsld/mhsld.h b/hw/cxl/mhsld/mhsld.h
> index e7ead1f0d2..c9fbec71ca 100644
> --- a/hw/cxl/mhsld/mhsld.h
> +++ b/hw/cxl/mhsld/mhsld.h
> @@ -23,6 +23,18 @@
>   */
>  #define MHSLD_HEADS  (8)
>  
> +typedef struct MHDHeadInfoBlock {
> +    uint8_t port_number;
> +    uint8_t max_link_width;
> +    uint8_t nego_link_width;
> +    uint8_t supp_link_speeds_vector;
> +    uint8_t max_link_speed;
> +    uint8_t current_link_speed;
> +    uint8_t ltssm_state;
> +    uint8_t first_nego_lane_num;
> +    uint8_t link_state_flags;
> +} QEMU_PACKED MHDHeadInfoBlock;
> +
>  /*
>   * The shared state cannot have 2 variable sized regions
>   * so we have to max out the ldmap.
> @@ -32,6 +44,7 @@ typedef struct MHSLDSharedState {
>      uint8_t nr_lds;
>      uint8_t ldmap[MHSLD_HEADS];
>      uint64_t nr_blocks;
> +    MHDHeadInfoBlock head_info_blocks[MHSLD_HEADS];
>      uint8_t blocks[];
>  } MHSLDSharedState;
>  
> @@ -52,6 +65,7 @@ struct CXLMHSLDClass {
>  enum {
>      MHSLD_MHD = 0x55,
>          #define GET_MHD_INFO 0x0
> +        #define GET_MHD_HEAD_INFO 0x1
>  };
>  
>  /*
> @@ -72,4 +86,16 @@ typedef struct MHDGetInfoOutput {
>      uint16_t resv2;
>      uint8_t ldmap[];
>  } QEMU_PACKED MHDGetInfoOutput;
> +
> +typedef struct MHDGetHeadInfoInput {
> +    uint8_t start_head;
> +    uint8_t nr_heads;
> +} QEMU_PACKED MHDGetHeadInfoInput;
> +
> +typedef struct MHDGetHeadInfoOutput {
> +    uint8_t nr_heads;
> +    uint8_t rsvd[3];
> +    MHDHeadInfoBlock head_info_list[];
> +} QEMU_PACKED MHDGetHeadInfoOutput;
> +
>  #endif
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index ca515cab13..c93c71c45d 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -732,6 +732,12 @@ struct CXLType3Class {
>                                 uint8_t *payload_out,
>                                 size_t *len_out,
>                                 CXLCCI *cci);
> +    CXLRetCode (*mhd_get_head_info)(const struct cxl_cmd *cmd,
> +                               uint8_t *payload_in,
> +                               size_t len_in,
> +                               uint8_t *payload_out,
> +                               size_t *len_out,
> +                               CXLCCI *cci);
I think the indent here needs to be aligned with the open parentheses on
the first line of the function declaration
>      bool (*mhd_access_valid)(PCIDevice *d, uint64_t addr, unsigned int size);
>      bool (*mhd_reserve_extents)(PCIDevice *d,
>                                  CxlDynamicCapacityExtentList *records,
> -- 
> 2.34.1
