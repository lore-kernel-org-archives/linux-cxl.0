Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843D21353EC
	for <linux-cxl@vger.kernel.org>; Fri, 16 Feb 2024 18:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708108210; cv=none; b=jYiG4n7U9AWnlhLi+Y/RBdkDzRAlzh55inH95tc17iCG2bMvOQYd8Cxs7l/mwoHdumigTJbd/cG14G8Mm9bjPDYBPtxOUUrxcflSZJws2vs8JDvw81B08Xv4rAL9AtW7cAhZbBqSurRtEqBZaPRXZjqYGjpaICqWWkvZhSPWowc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708108210; c=relaxed/simple;
	bh=KVeMWaUDWpNaQnAXRNJzCiPENdJYjxslQ1dwGUrYuf8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kG0jZPyPxYJ5XI2KwnKrhMHWjn9I9XBUtU8lvXcfALU+zxVwA43Cm0I7nCulHPa+3DnBf/K9s3j/zDvEJnyjxIkgUnXTaAdTDjQCxAHaz9WPTBpjzjGvaADxQ+sgVWemrqRu45mfPWh+kRlQ5/jv+RZFX1PymNWrKF5kqnrj9yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y+Pv1Mj/; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+Pv1Mj/"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d746ce7d13so9177145ad.0
        for <linux-cxl@vger.kernel.org>; Fri, 16 Feb 2024 10:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708108208; x=1708713008; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mObbpYEKqcp4uRcZvwPuXcfhackZdXkNqYjw0XdnrF4=;
        b=Y+Pv1Mj/WJK1cPKp5+PHsKCF4dlfv2UyGC1h4Op69lRAz+IGB16U03dd9bdem2eKsG
         qy6rRSvEUQUeFmN4gJs/D0lJVn4jRdVP9hG2zBVl4KGZUdUc2uadoORSnPXmaAlBwhv8
         ze0C9vO5WqG1uOyv6up8kXLrtPZHlCjp7oJbgALytLeBbjOqs/rDZq/pXqrDhHZmPbxp
         WUIusqqQ7dk/lWOw9fP8itjOJTlt++c33ZbLI44KComgwUIitQzc7f2glVkqpUnZO35/
         8dOcpE4zX/oBp4wHZjtXQZnv4IiGff018VCLA7jGeLsZXXXAu9MPzFKnlirG4KBoWEF+
         oO3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708108208; x=1708713008;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mObbpYEKqcp4uRcZvwPuXcfhackZdXkNqYjw0XdnrF4=;
        b=dEzL49YyQxetG4BePkfQNVt3LyCmKD2HtqerQTRKFayEA3JhGytWG7ZTQCzqZu1ouF
         3ND8mrea8uoO4m6xvBvjAPS5OCfZVNKKM3DFr1c4rcECGIv73XngSCIUwY7ggJnbUfvg
         swOfoav1LZRH90RbgihlYX/ZIMROH0arg8E+m2ekkOlt+Hok2oD0ONVGujf10/UeqCc4
         pcYTMuBEwFYBjLJeiBiY9gbrm8JhkoXAf84gRpVNaP/pH3UbWfGwB5H6zkgatuugVvVP
         S0zzoZSYbrdcEHuyG4w0bKdBsN++r+wwbqLzjn8CJVS3RQJEz3qKNwvgR76HFJ3LMFCt
         8bgA==
X-Forwarded-Encrypted: i=1; AJvYcCX7+H4N91F3s5UQuhVE1FuzSZ+BE+GLDJVkDZ6mNttm1zM0hOKx2T1HmrTmuMx7PXHCvU9u6ia7OtZ++Ba45Q+ygcBPgX+vOZS/
X-Gm-Message-State: AOJu0Yw1dZQ7i24l+z6k4kV99VSDqwtUHxPae4unXXsvvmthNn+gsEmP
	iBTzVk/HLMoTb6qSWuZhALohyULN1i5rFh3voOfCeyI9/G4HIkjn
X-Google-Smtp-Source: AGHT+IFzfupfHxMT0oJfKTI47824WBIRA00QRnKQQ+07IrRBbshHZw7h4IyGcPLqBi+T+xVlNk46bQ==
X-Received: by 2002:a17:902:8a94:b0:1db:9e2a:7e59 with SMTP id p20-20020a1709028a9400b001db9e2a7e59mr3833414plo.7.1708108207660;
        Fri, 16 Feb 2024 10:30:07 -0800 (PST)
Received: from debian ([2601:641:300:14de:f1a:387c:5c5c:3099])
        by smtp.gmail.com with ESMTPSA id lo5-20020a170903434500b001db83ae5d08sm163286plb.243.2024.02.16.10.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 10:30:07 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Fri, 16 Feb 2024 10:30:05 -0800
To: shiju.jose@huawei.com
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
	jonathan.cameron@huawei.com, tanxiaofei@huawei.com,
	prime.zeng@hisilicon.com, linuxarm@huawei.com, fan.ni@samsung.com
Subject: Re: [PATCH v3 3/3] hw/cxl/cxl-mailbox-utils: Add device DDR5 ECS
 control feature
Message-ID: <Zc-prXVf1bwfKoiv@debian>
References: <20240215110146.1444-1-shiju.jose@huawei.com>
 <20240215110146.1444-4-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215110146.1444-4-shiju.jose@huawei.com>

On Thu, Feb 15, 2024 at 07:01:46PM +0800, shiju.jose@huawei.com wrote:
> 500006.china.huawei.com (7.191.161.198)
> Status: O
> Content-Length: 7949
> Lines: 181
> 
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

Reviewed-by: Fan Ni <fan.ni@samsung.com>

> ---
>  hw/cxl/cxl-mailbox-utils.c | 100 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 99 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 9557c38dd9..a14eee9ff5 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -998,6 +998,7 @@ typedef struct CXLSupportedFeatureEntry {
>  
>  enum CXL_SUPPORTED_FEATURES_LIST {
>      CXL_FEATURE_PATROL_SCRUB = 0,
> +    CXL_FEATURE_DDR5_ECS,
>      CXL_FEATURE_MAX
>  };
>  
> @@ -1069,6 +1070,42 @@ typedef struct CXLMemPatrolScrubSetFeature {
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
>  /* CXL r3.1 section 8.2.9.6.1: Get Supported Features (Opcode 0500h) */
>  static CXLRetCode cmd_features_get_supported(const struct cxl_cmd *cmd,
>                                               uint8_t *payload_in,
> @@ -1087,7 +1124,7 @@ static CXLRetCode cmd_features_get_supported(const struct cxl_cmd *cmd,
>          CXLSupportedFeatureHeader hdr;
>          CXLSupportedFeatureEntry feat_entries[];
>      } QEMU_PACKED QEMU_ALIGNED(16) * get_feats_out = (void *)payload_out;
> -    uint16_t index;
> +    uint16_t count, index;
>      uint16_t entry, req_entries;
>      uint16_t feat_entries = 0;
>  
> @@ -1129,6 +1166,35 @@ static CXLRetCode cmd_features_get_supported(const struct cxl_cmd *cmd,
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
> @@ -1180,6 +1246,19 @@ static CXLRetCode cmd_features_get_feature(const struct cxl_cmd *cmd,
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
> @@ -1197,8 +1276,11 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
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
> @@ -1216,6 +1298,22 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
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
