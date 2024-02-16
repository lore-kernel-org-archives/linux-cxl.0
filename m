Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDEC130AD5
	for <linux-cxl@vger.kernel.org>; Fri, 16 Feb 2024 18:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708108049; cv=none; b=SyKtu2iYTVUbnk5yodO267PTg0So70IL+WF7oMRQVKX2Z2gHYvPsciTmRUsB3dfkUIL1bYAgiSIWDb3gEYHqlo7VqV9W/PK225D7wvVSDuRrWl+SYX9HRp7m+3q8RaehgM5TuMrGE7v0G+mQGErR4d+pjm61E1jwBVTCxwiC1c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708108049; c=relaxed/simple;
	bh=BNneu8N7E6o0zskvBQy3FXVKLPbUrsn1xuPbz68hhu8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D/FRFL1ZCi4yFswZVnkot2sdunfF70Q1aKm3bcBTtv9X3b7/yqskbqTQttaaSNWILfKPXbV+EAh7q0fSVcuzsxUHIIjv3awuAiLfEobPQm8EQ0k5HfQI/jrE0rAFmprl1p5XqodXBkaw7zR8vIDEuVQoR2GfkL/spwvurbPb/38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iVNqyemf; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iVNqyemf"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6de3141f041so1907301b3a.0
        for <linux-cxl@vger.kernel.org>; Fri, 16 Feb 2024 10:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708108047; x=1708712847; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XZmwPG3PlOOCsVBQBG5AibLUXpR6Zlx7US+ZbDcfVX0=;
        b=iVNqyemf4bRdW/cDzAi4CWNHxL5HSUABNz6l2BakNxpDMbRRZOKfqqlEvl/AUXtPuw
         C+OjIxxIGDghTjUZpQwghMJCVMGPgZ5ho8OpkZZo58waqC70XXxFsiUYgYfbNJG985rU
         4wcICQecXX2t+ueaFfYGLYTDcY3Dg4+UegJyh5FivWASeZe0QarUXUoJU48fnb10aTQE
         LoUGT5sN9cGUowNywMtQcvKw12rfablmggcJu6iMQr+6ebcPz9V/AFSD4daRLBV1y+6f
         Om4/G9kcT2m9GBKjCPK1Cxc3yp9JJ2JaTMdSTIU724CjefnEhe+Fi/BlrckRrEajNFIq
         cK2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708108047; x=1708712847;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XZmwPG3PlOOCsVBQBG5AibLUXpR6Zlx7US+ZbDcfVX0=;
        b=xItupphilALCqIL0GvRBZmlJuVy8HHlJdOGA66NMDRKkT4AvvKQ8zB8aopFlh82S99
         XnNoq27TLAn5aL7Ui1Vm/9ANR49876BEjp+lHhHhxYeIMeyA0iIsvPgVzttfthkiorMy
         KwqoOLRQnUYU7KbjEKTGhYkfkBgUlGYa8SBCXDz9oPKYDz9dLaDZZu52jiSWIpkkXUkz
         JpQR08A1L/WhtvPPxJxzd2Fz7Z6AFxaGGuZzRMdeX8yde8/MCyaCbCOCOznpDKnX8x0z
         ZHhL5ezYLM0HC9YTDjPL3VsFamehwZJ/vyLisEzlUgFOixVIzo3yJss6CeKQQo9Nntoo
         qCRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXs09GED5w6lwLo1H35aF7g4NyGQkmS2qOOCeBPXQpL17HC1TEqKVKncMl+3lO/BCip2hHI6phehiLebwNu4F1WlmXVMZned8vu
X-Gm-Message-State: AOJu0Yxq+zwyqjD43CfJm76uTvcfBi4sErG0wyEf1WobRwHrFleKmLP+
	39KILv9KxLCYOHS0RrusOLnwAEoXINFNASJPo8h3IZ8n9YoljKas
X-Google-Smtp-Source: AGHT+IEbxYP76EHZurhcBbCCrjWqFT9GN22E5Zkp1OA1+ZH+dojBiDE8HubzYkn8Q8IJRCtnPsZLlQ==
X-Received: by 2002:a62:8182:0:b0:6e0:51a9:7c65 with SMTP id t124-20020a628182000000b006e051a97c65mr5171938pfd.21.1708108046585;
        Fri, 16 Feb 2024 10:27:26 -0800 (PST)
Received: from debian ([2601:641:300:14de:f1a:387c:5c5c:3099])
        by smtp.gmail.com with ESMTPSA id f10-20020a056a001aca00b006e1377847bdsm259051pfv.50.2024.02.16.10.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 10:27:26 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Fri, 16 Feb 2024 10:27:24 -0800
To: shiju.jose@huawei.com
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
	jonathan.cameron@huawei.com, tanxiaofei@huawei.com,
	prime.zeng@hisilicon.com, linuxarm@huawei.com, fan.ni@samsung.com
Subject: Re: [PATCH v3 2/3] hw/cxl/cxl-mailbox-utils: Add device patrol scrub
 control feature
Message-ID: <Zc-pDBKdWkkda04t@debian>
References: <20240215110146.1444-1-shiju.jose@huawei.com>
 <20240215110146.1444-3-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215110146.1444-3-shiju.jose@huawei.com>

On Thu, Feb 15, 2024 at 07:01:45PM +0800, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> CXL spec 3.1 section 8.2.9.9.11.1 describes the device patrol scrub control
> feature. The device patrol scrub proactively locates and makes corrections
> to errors in regular cycle. The patrol scrub control allows the request to
> configure patrol scrub input configurations.
> 
> The patrol scrub control allows the requester to specify the number of
> hours for which the patrol scrub cycles must be completed, provided that
> the requested number is not less than the minimum number of hours for the
> patrol scrub cycle that the device is capable of. In addition, the patrol
> scrub controls allow the host to disable and enable the feature in case
> disabling of the feature is needed for other purposes such as
> performance-aware operations which require the background operations to be
> turned off.
> 
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>  hw/cxl/cxl-mailbox-utils.c | 97 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 96 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index f761ac49b5..9557c38dd9 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -997,6 +997,7 @@ typedef struct CXLSupportedFeatureEntry {
>  } QEMU_PACKED CXLSupportedFeatureEntry;
>  
>  enum CXL_SUPPORTED_FEATURES_LIST {
> +    CXL_FEATURE_PATROL_SCRUB = 0,
>      CXL_FEATURE_MAX
>  };
>  
> @@ -1037,6 +1038,37 @@ enum CXL_SET_FEATURE_FLAG_DATA_TRANSFER {
>      CXL_SET_FEATURE_FLAG_DATA_TRANSFER_MAX
>  };
>  
> +/* CXL r3.1 section 8.2.9.9.11.1: Device Patrol Scrub Control Feature */
> +static const QemuUUID patrol_scrub_uuid = {
> +    .data = UUID(0x96dad7d6, 0xfde8, 0x482b, 0xa7, 0x33,
> +                 0x75, 0x77, 0x4e, 0x06, 0xdb, 0x8a)
> +};
> +
> +#define CXL_MEMDEV_PS_GET_FEATURE_VERSION    0x01
> +#define CXL_MEMDEV_PS_SET_FEATURE_VERSION    0x01
> +#define CXL_MEMDEV_PS_SCRUB_CYCLE_CHANGE_CAP_DEFAULT    BIT(0)
> +#define CXL_MEMDEV_PS_SCRUB_REALTIME_REPORT_CAP_DEFAULT    BIT(1)
> +#define CXL_MEMDEV_PS_CUR_SCRUB_CYCLE_DEFAULT    12
> +#define CXL_MEMDEV_PS_MIN_SCRUB_CYCLE_DEFAULT    1
> +#define CXL_MEMDEV_PS_ENABLE_DEFAULT    0
> +
> +/* CXL memdev patrol scrub control attributes */
> +struct CXLMemPatrolScrubReadAttrbs {
> +        uint8_t scrub_cycle_cap;
> +        uint16_t scrub_cycle;
> +        uint8_t scrub_flags;
> +} QEMU_PACKED cxl_memdev_ps_feat_read_attrbs;
> +
> +typedef struct CXLMemPatrolScrubWriteAttrbs {
> +    uint8_t scrub_cycle_hr;
> +    uint8_t scrub_flags;
> +} QEMU_PACKED CXLMemPatrolScrubWriteAttrbs;
> +
> +typedef struct CXLMemPatrolScrubSetFeature {
> +        CXLSetFeatureInHeader hdr;
> +        CXLMemPatrolScrubWriteAttrbs feat_data;
> +} QEMU_PACKED QEMU_ALIGNED(16) CXLMemPatrolScrubSetFeature;
> +
>  /* CXL r3.1 section 8.2.9.6.1: Get Supported Features (Opcode 0500h) */
>  static CXLRetCode cmd_features_get_supported(const struct cxl_cmd *cmd,
>                                               uint8_t *payload_in,
> @@ -1060,7 +1092,7 @@ static CXLRetCode cmd_features_get_supported(const struct cxl_cmd *cmd,
>      uint16_t feat_entries = 0;
>  
>      if (get_feats_in->count < sizeof(CXLSupportedFeatureHeader) ||
> -        get_feats_in->start_index > CXL_FEATURE_MAX) {
> +        get_feats_in->start_index >= CXL_FEATURE_MAX) {
>          return CXL_MBOX_INVALID_INPUT;
>      }
>      req_entries = (get_feats_in->count -
> @@ -1072,6 +1104,31 @@ static CXLRetCode cmd_features_get_supported(const struct cxl_cmd *cmd,
>      entry = 0;
>      while (entry < req_entries) {
>          switch (index) {
> +        case  CXL_FEATURE_PATROL_SCRUB:
> +            /* Fill supported feature entry for device patrol scrub control */
> +            get_feats_out->feat_entries[entry] =
> +                           (struct CXLSupportedFeatureEntry) {
> +                .uuid = patrol_scrub_uuid,
> +                .feat_index = index,
> +                .get_feat_size = sizeof(cxl_memdev_ps_feat_read_attrbs),
> +                .set_feat_size = sizeof(CXLMemPatrolScrubWriteAttrbs),
> +                /* Bit[0] : 1, feature attributes changeable */
> +                .attrb_flags = 0x1,
> +                .get_feat_version = CXL_MEMDEV_PS_GET_FEATURE_VERSION,
> +                .set_feat_version = CXL_MEMDEV_PS_SET_FEATURE_VERSION,
> +                .set_feat_effects = 0,
> +            };
> +            feat_entries++;
> +            /* Set default value for device patrol scrub read attributes */
> +            cxl_memdev_ps_feat_read_attrbs.scrub_cycle_cap =
> +                                CXL_MEMDEV_PS_SCRUB_CYCLE_CHANGE_CAP_DEFAULT |
> +                                CXL_MEMDEV_PS_SCRUB_REALTIME_REPORT_CAP_DEFAULT;
> +            cxl_memdev_ps_feat_read_attrbs.scrub_cycle =
> +                                CXL_MEMDEV_PS_CUR_SCRUB_CYCLE_DEFAULT |
> +                                (CXL_MEMDEV_PS_MIN_SCRUB_CYCLE_DEFAULT << 8);
> +            cxl_memdev_ps_feat_read_attrbs.scrub_flags =
> +                                CXL_MEMDEV_PS_ENABLE_DEFAULT;
> +            break;
>          default:
>              break;
>          }
> @@ -1112,6 +1169,21 @@ static CXLRetCode cmd_features_get_feature(const struct cxl_cmd *cmd,
>          return CXL_MBOX_INVALID_INPUT;
>      }
>  
> +    if (qemu_uuid_is_equal(&get_feature->uuid, &patrol_scrub_uuid)) {
> +        if (get_feature->offset >= sizeof(cxl_memdev_ps_feat_read_attrbs)) {
> +            return CXL_MBOX_INVALID_INPUT;
> +        }
> +        bytes_to_copy = sizeof(cxl_memdev_ps_feat_read_attrbs) -
> +                                             get_feature->offset;
> +        bytes_to_copy = (bytes_to_copy > get_feature->count) ?
> +                               get_feature->count : bytes_to_copy;
> +        memcpy(payload_out,
> +               &cxl_memdev_ps_feat_read_attrbs + get_feature->offset,
> +               bytes_to_copy);
> +    } else {
> +        return CXL_MBOX_UNSUPPORTED;
> +    }
> +
>      *len_out = bytes_to_copy;
>  
>      return CXL_MBOX_SUCCESS;
> @@ -1125,6 +1197,29 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
>                                             size_t *len_out,
>                                             CXLCCI *cci)
>  {
> +    CXLMemPatrolScrubWriteAttrbs *ps_write_attrbs;
> +    CXLMemPatrolScrubSetFeature *ps_set_feature;
> +    CXLSetFeatureInHeader *hdr = (void *)payload_in;
> +
> +    if (qemu_uuid_is_equal(&hdr->uuid, &patrol_scrub_uuid)) {
> +        if (hdr->version != CXL_MEMDEV_PS_SET_FEATURE_VERSION ||
> +            (hdr->flags & CXL_SET_FEATURE_FLAG_DATA_TRANSFER_MASK) !=
> +                               CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER) {
> +            return CXL_MBOX_UNSUPPORTED;
> +        }
> +
> +        ps_set_feature = (void *)payload_in;
> +        ps_write_attrbs = &ps_set_feature->feat_data;
> +        cxl_memdev_ps_feat_read_attrbs.scrub_cycle &= ~0xFF;
> +        cxl_memdev_ps_feat_read_attrbs.scrub_cycle |=
> +                          ps_write_attrbs->scrub_cycle_hr & 0xFF;
> +        cxl_memdev_ps_feat_read_attrbs.scrub_flags &= ~0x1;
> +        cxl_memdev_ps_feat_read_attrbs.scrub_flags |=
> +                          ps_write_attrbs->scrub_flags & 0x1;
> +    } else {
> +        return CXL_MBOX_UNSUPPORTED;
> +    }
> +
>      return CXL_MBOX_SUCCESS;
>  }
>  
> -- 
> 2.34.1
> 
