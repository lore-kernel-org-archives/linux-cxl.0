Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CC2133993
	for <linux-cxl@vger.kernel.org>; Thu, 15 Feb 2024 19:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708024273; cv=none; b=X5MmPzd8dksapZVSAxEJXcxFs6yz8k2RvdOOaWUr6WzzD88ajsTFJRTG9XA06PwzZ/Ww5LxJZr6DuG/bZseTLhSYfZ8IpVwVaG5tqxz7fIJ8LlTiQaGKI2NJP6B1wti4FCkX43s1wsEsHE8MwbdXwWbsVO/4Y1MyWxUmJHP9CcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708024273; c=relaxed/simple;
	bh=TG3GOT+4BIXOS2PcqpYAN2rudnIL75hpeE5rnJ/Ygqo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RWGP4rtUjDk2jVAjZAb3lZ4hpPSL5ng/+uz6gChgLTWhjuVwISsXmo6RPExOIQkU4Sf67BlC91V5V+xkCI61XNGc3oW0qVKRxyQN4JBQnp1H2AEH/jalqHOUVmyRmRRZ5zqYjiv6xZAH63hkZrBixamOQdzpUNgIeJwh2FBti18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mOq5vNdb; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mOq5vNdb"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6e10746c6f4so996722b3a.2
        for <linux-cxl@vger.kernel.org>; Thu, 15 Feb 2024 11:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708024270; x=1708629070; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OBVn+VYEOLPWxHkYLSAH1u/vsJkqTKBZdT9CVb6RiYc=;
        b=mOq5vNdbSmN2b2Bt2MxolyihjFU2O4Dddj67aJgxA++/ky1Ww9ALr11m1zVrAZ4Jvj
         fWhhKeMd64aFVwmaO+6WZUrV3Kj5pgG7prveWfxUXcX9KUKnoCwrY/LwxvfaB19RCRew
         3ZsLYl1CSjfJRWcpKT3LyUFoaccJPrEQoSGzhTf9NJhjBe5/C9rImdoDorVfcCTkfTe8
         Z64BkU3GpPCRF+SKEGlfawtcTWe9RybPCBzeFU97x6EQaknHOIQZ1S+KWHgLCXGPticg
         Kh9SqGHfyGJAzicUzYcoHiAVNfd1M00g8kHxkHXQZvZo2LvjBTz6/Wiqp/fY8FAk84Co
         ZPAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708024270; x=1708629070;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OBVn+VYEOLPWxHkYLSAH1u/vsJkqTKBZdT9CVb6RiYc=;
        b=BN46IZU2knAaXJZ1ytmGQ0hUfiT32GS0ckA/gexiExMms7HJENIBGV0sLsmdUwAl+f
         8Zkr2nO8v+/nku7mfnP86gjEMcC7BrTeYK4yp+tLRR7aHxQr9kqCHxlMy4PF7tkozBag
         lHmEr04oxxuvDPHCsIfdQ9DVia5O4jBsf2uTrZCCGdDLFBXDdYIUTRWgQ0Qhlkb+ziTG
         77tQfrPlKvsnXIhmgAdZyyzrfNGQrn6VdA+PglNBVswdkcmWT0lllBB1iYe/vgFV/ICS
         T1Mt2sjnzr0LhV91vabjF6c6IXVd40zYzvGyLq/kqSfQ2eTg/c6+FP9MU8Tt74EF6m1Z
         eTew==
X-Forwarded-Encrypted: i=1; AJvYcCW2N0nwJbLvXASqDpYfivGXEIIxR/Z5GuC/JtxLl43DDAT5tCVPY91uGDo4DfHeCD0LJGHvzENzmDs/qTpm2RI1sOSZuH5qJfEL
X-Gm-Message-State: AOJu0Yxn/mGK+DxdLCty5E4AY31dl+GGA+cY8bqb44umDXVpWgDktnJN
	wyj/g78jfmEInlQftuQRb8nQjJGheeDO2ypfAWBktNIXBbKqhjTw
X-Google-Smtp-Source: AGHT+IH7whzAf2whtoDFTquvBNsG/3LI1KXbcv9+gKKkOiltbhsJf48t+Kra9iQEzx7XYOKESMd8Dg==
X-Received: by 2002:a05:6a00:2d03:b0:6e0:e235:e2ca with SMTP id fa3-20020a056a002d0300b006e0e235e2camr2910166pfb.9.1708024270301;
        Thu, 15 Feb 2024 11:11:10 -0800 (PST)
Received: from debian ([2601:641:300:14de:5279:cdf6:aaf1:e09c])
        by smtp.gmail.com with ESMTPSA id e6-20020a056a0000c600b006e0cfe94fc5sm1682161pfj.107.2024.02.15.11.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 11:11:09 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Thu, 15 Feb 2024 11:11:07 -0800
To: shiju.jose@huawei.com
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
	jonathan.cameron@huawei.com, tanxiaofei@huawei.com,
	prime.zeng@hisilicon.com, linuxarm@huawei.com
Subject: Re: [PATCH v2 3/3] hw/cxl/cxl-mailbox-utils: Add device DDR5 ECS
 control feature
Message-ID: <Zc5hy-HR3sRTPLC6@debian>
References: <20231124135338.1191-1-shiju.jose@huawei.com>
 <20231124135338.1191-4-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124135338.1191-4-shiju.jose@huawei.com>

On Fri, Nov 24, 2023 at 09:53:37PM +0800, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> CXL spec 3.1 section 8.2.9.9.11.2 describes the DDR5 Error Check Scrub (ECS)
> control feature.
> 
> The Error Check Scrub (ECS) is a feature defined in JEDEC DDR5 SDRAM
> Specification (JESD79-5) and allows the DRAM to internally read, correct
> single-bit errors, and write back corrected data bits to the DRAM array
> while providing transparency to error counts. The ECS control feature
> allows the request to configure ECS input configurations during system
> boot or at run-time.
> 
> The ECS control allows the requester to change the log entry type, the ECS
> threshold count provided that the request is within the definition
> specified in DDR5 mode registers, change mode between codeword mode and
> row count mode, and reset the ECS counter.
> 
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>

LGTM.

Reviewed-by: Fan Ni <fan.ni@samsung.com>

Fan

> ---
>  hw/cxl/cxl-mailbox-utils.c | 100 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 99 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 5a6f4e4029..098b92815a 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -810,6 +810,7 @@ typedef struct CXLSupportedFeatureEntry {
>  
>  enum CXL_SUPPORTED_FEATURES_LIST {
>      CXL_FEATURE_PATROL_SCRUB = 0,
> +    CXL_FEATURE_DDR5_ECS,
>      CXL_FEATURE_MAX
>  };
>  
> @@ -881,6 +882,42 @@ typedef struct CXLMemPatrolScrubSetFeature {
>          CXLMemPatrolScrubWriteAttrbs feat_data;
>  } QEMU_PACKED QEMU_ALIGNED(16) CXLMemPatrolScrubSetFeature;
>  
> +/*
> + * CXL r3.1 section 8.2.9.9.11.2:
> + * DDR5 Error Check Scrub (ECS) Control Feature
> + */
> +static const QemuUUID ddr5_ecs_uuid = {
> +    .data = UUID(0xe5b13f22, 0x2328, 0x4a14, 0xb8, 0xba,
> +                 0xb9, 0x69, 0x1e, 0x89, 0x33, 0x86)
> +};
> +
> +#define CXL_DDR5_ECS_GET_FEATURE_VERSION    0x01
> +#define CXL_DDR5_ECS_SET_FEATURE_VERSION    0x01
> +#define CXL_DDR5_ECS_LOG_ENTRY_TYPE_DEFAULT    0x01
> +#define CXL_DDR5_ECS_REALTIME_REPORT_CAP_DEFAULT    1
> +#define CXL_DDR5_ECS_THRESHOLD_COUNT_DEFAULT    3 /* 3: 256, 4: 1024, 5: 4096 */
> +#define CXL_DDR5_ECS_MODE_DEFAULT    0
> +
> +#define CXL_DDR5_ECS_NUM_MEDIA_FRUS   3
> +
> +/* CXL memdev DDR5 ECS control attributes */
> +struct CXLMemECSReadAttrbs {
> +        uint8_t ecs_log_cap;
> +        uint8_t ecs_cap;
> +        uint16_t ecs_config;
> +        uint8_t ecs_flags;
> +} QEMU_PACKED cxl_ddr5_ecs_feat_read_attrbs[CXL_DDR5_ECS_NUM_MEDIA_FRUS];
> +
> +typedef struct CXLDDR5ECSWriteAttrbs {
> +    uint8_t ecs_log_cap;
> +    uint16_t ecs_config;
> +} QEMU_PACKED CXLDDR5ECSWriteAttrbs;
> +
> +typedef struct CXLDDR5ECSSetFeature {
> +        CXLSetFeatureInHeader hdr;
> +        CXLDDR5ECSWriteAttrbs feat_data[];
> +} QEMU_PACKED QEMU_ALIGNED(16) CXLDDR5ECSSetFeature;
> +
>  /* CXL r3.0 section 8.2.9.6.1: Get Supported Features (Opcode 0500h) */
>  static CXLRetCode cmd_features_get_supported(const struct cxl_cmd *cmd,
>                                               uint8_t *payload_in,
> @@ -899,7 +936,7 @@ static CXLRetCode cmd_features_get_supported(const struct cxl_cmd *cmd,
>          CXLSupportedFeatureHeader hdr;
>          CXLSupportedFeatureEntry feat_entries[];
>      } QEMU_PACKED QEMU_ALIGNED(16) * get_feats_out = (void *)payload_out;
> -    uint16_t index;
> +    uint16_t count, index;
>      uint16_t entry, req_entries;
>      uint16_t feat_entries = 0;
>  
> @@ -941,6 +978,35 @@ static CXLRetCode cmd_features_get_supported(const struct cxl_cmd *cmd,
>              cxl_memdev_ps_feat_read_attrbs.scrub_flags =
>                                  CXL_MEMDEV_PS_ENABLE_DEFAULT;
>              break;
> +        case  CXL_FEATURE_DDR5_ECS:
> +            /* Fill supported feature entry for device DDR5 ECS control */
> +            get_feats_out->feat_entries[entry] =
> +                         (struct CXLSupportedFeatureEntry) {
> +                .uuid = ddr5_ecs_uuid,
> +                .feat_index = index,
> +                .get_feat_size = CXL_DDR5_ECS_NUM_MEDIA_FRUS *
> +                                    sizeof(struct CXLMemECSReadAttrbs),
> +                .set_feat_size = CXL_DDR5_ECS_NUM_MEDIA_FRUS *
> +                                    sizeof(CXLDDR5ECSWriteAttrbs),
> +                .attrb_flags = 0x1,
> +                .get_feat_version = CXL_DDR5_ECS_GET_FEATURE_VERSION,
> +                .set_feat_version = CXL_DDR5_ECS_SET_FEATURE_VERSION,
> +                .set_feat_effects = 0,
> +            };
> +            feat_entries++;
> +            /* Set default value for DDR5 ECS read attributes */
> +            for (count = 0; count < CXL_DDR5_ECS_NUM_MEDIA_FRUS; count++) {
> +                cxl_ddr5_ecs_feat_read_attrbs[count].ecs_log_cap =
> +                                    CXL_DDR5_ECS_LOG_ENTRY_TYPE_DEFAULT;
> +                cxl_ddr5_ecs_feat_read_attrbs[count].ecs_cap =
> +                                    CXL_DDR5_ECS_REALTIME_REPORT_CAP_DEFAULT;
> +                cxl_ddr5_ecs_feat_read_attrbs[count].ecs_config =
> +                                    CXL_DDR5_ECS_THRESHOLD_COUNT_DEFAULT |
> +                                    (CXL_DDR5_ECS_MODE_DEFAULT << 3);
> +                /* Reserved */
> +                cxl_ddr5_ecs_feat_read_attrbs[count].ecs_flags = 0;
> +            }
> +            break;
>          default:
>              break;
>          }
> @@ -992,6 +1058,19 @@ static CXLRetCode cmd_features_get_feature(const struct cxl_cmd *cmd,
>          memcpy(payload_out,
>                 &cxl_memdev_ps_feat_read_attrbs + get_feature->offset,
>                 bytes_to_copy);
> +    } else if (qemu_uuid_is_equal(&get_feature->uuid, &ddr5_ecs_uuid)) {
> +        if (get_feature->offset >=  CXL_DDR5_ECS_NUM_MEDIA_FRUS *
> +                                sizeof(struct CXLMemECSReadAttrbs)) {
> +            return CXL_MBOX_INVALID_INPUT;
> +        }
> +        bytes_to_copy = CXL_DDR5_ECS_NUM_MEDIA_FRUS *
> +                        sizeof(struct CXLMemECSReadAttrbs) -
> +                                     get_feature->offset;
> +        bytes_to_copy = (bytes_to_copy > get_feature->count) ?
> +                                    get_feature->count : bytes_to_copy;
> +        memcpy(payload_out,
> +               &cxl_ddr5_ecs_feat_read_attrbs + get_feature->offset,
> +               bytes_to_copy);
>      } else {
>          return CXL_MBOX_UNSUPPORTED;
>      }
> @@ -1009,8 +1088,11 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
>                                             size_t *len_out,
>                                             CXLCCI *cci)
>  {
> +    uint16_t count;
>      CXLMemPatrolScrubWriteAttrbs *ps_write_attrbs;
> +    CXLDDR5ECSWriteAttrbs *ecs_write_attrbs;
>      CXLMemPatrolScrubSetFeature *ps_set_feature;
> +    CXLDDR5ECSSetFeature *ecs_set_feature;
>      CXLSetFeatureInHeader *hdr = (void *)payload_in;
>  
>      if (qemu_uuid_is_equal(&hdr->uuid, &patrol_scrub_uuid)) {
> @@ -1028,6 +1110,22 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
>          cxl_memdev_ps_feat_read_attrbs.scrub_flags &= ~0x1;
>          cxl_memdev_ps_feat_read_attrbs.scrub_flags |=
>                            ps_write_attrbs->scrub_flags & 0x1;
> +    } else if (qemu_uuid_is_equal(&hdr->uuid,
> +                                  &ddr5_ecs_uuid)) {
> +        if (hdr->version != CXL_DDR5_ECS_SET_FEATURE_VERSION ||
> +            (hdr->flags & CXL_SET_FEATURE_FLAG_DATA_TRANSFER_MASK) !=
> +                               CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER) {
> +            return CXL_MBOX_UNSUPPORTED;
> +        }
> +
> +        ecs_set_feature = (void *)payload_in;
> +        ecs_write_attrbs = ecs_set_feature->feat_data;
> +        for (count = 0; count < CXL_DDR5_ECS_NUM_MEDIA_FRUS; count++) {
> +                cxl_ddr5_ecs_feat_read_attrbs[count].ecs_log_cap =
> +                                  ecs_write_attrbs[count].ecs_log_cap;
> +                cxl_ddr5_ecs_feat_read_attrbs[count].ecs_config =
> +                                  ecs_write_attrbs[count].ecs_config & 0x1F;
> +        }
>      } else {
>          return CXL_MBOX_UNSUPPORTED;
>      }
> -- 
> 2.34.1
> 
