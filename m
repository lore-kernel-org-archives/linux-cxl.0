Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7B318E02
	for <linux-cxl@vger.kernel.org>; Thu, 15 Feb 2024 18:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708022841; cv=none; b=DvpYOG9vbDtaah2+aj+USvasxRDH1FwsVzxETu76Y4XPUvTH/QnWFhfgJC5BRxB/xUeRkqW/mf250rjsywoeOXD0CXDByHmaQ2gVMq6iNkyHM4lDPuilX+N2lhKxIsG49FLGJPIW1TIBT6Q6BIuy9GLAd4f0ZChQK+yL3E1FTXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708022841; c=relaxed/simple;
	bh=gnHeNyDbmtLodTXH3TH6lo7yRL9VWky80/A8sjtjIhU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hfd4WKf6tGGJAyTkUWhHoRKYNSURNiSRqSE/4qKXbE46rXGZM9wiDR/YABNhql42OmDyiXoBRPVwsUjolp6gvQdFCYrArdutDyxvLznLL7BEgISyILlD36vGBqsF9vynoj7RkX20M02AXvmXqKV9EltIKlZYetNIjhS87pigXsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S8mxsWIN; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S8mxsWIN"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5d3907ff128so1026799a12.3
        for <linux-cxl@vger.kernel.org>; Thu, 15 Feb 2024 10:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708022839; x=1708627639; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3z90p2xOKMarDgjIWEH3zhzvAjpbfMyeAijBDDuA6uE=;
        b=S8mxsWINwtdJU8ge6qsUVkWfHtnNUh7EKEogyyTZxmU5IYKeSIqqEf+UWLrE++4OHK
         Wpl/txPGAQDf88DT6KQib5rHZSRTl4pCtUw4SiuAkQ49x8CWbiswVZNYKiG0u+Dohmve
         KqgxXt86HL0X96USZEVS6CWKeA6eAb5ZsQq7GS3W7Fq+T0NF7ud2i3mTZ67dMcfWlmEY
         ybblUz8yeGUXkxOjYfxBy9dh8g2EaIYEe8rIGaFsAHFExmT03jY5YIx/s+6nJh525yiS
         XhOsMGu2LDbfUUoDhLTXZi1XAvsoz/+W0DVRDk7VxfaJIyP6WQnU7pqwhmh/v1AyyrYS
         IoUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708022839; x=1708627639;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3z90p2xOKMarDgjIWEH3zhzvAjpbfMyeAijBDDuA6uE=;
        b=LPVt1AWls/nkyTRAdxLsoVBxZek9OhRHhApRdPk9bTcttF9miTCSq3gp+quDqaGjPr
         fkukFMQdzIR9Cgjb8LGUOxOigSLrgEsgRcnRoy59h+bsKrUBTo9tSXK7vcu15GZ7RhSb
         9jBKlEmnZ3M/vU7s07RK+hK9iIiuekgq/z6VwYPZsfDDq0TXblV2bEowN5wAhWipUlSH
         FrNGWl//qx5U68uBeYUcU0QWlfPyKMMJcx5LgBYVlAlrvntyCREOYhPlHHIwRjhUS9Nl
         kXy2uhr34k8I3hO5Tsu29WaYRV7cSXOK9HO8oy5uYXuC/vmCaRNbfzO1XpVIPh3RJYtb
         +nzw==
X-Forwarded-Encrypted: i=1; AJvYcCVviu7maBzikF5wiRZFEaOPhBpeiO5nTJhSxT2qeE9DB9rm66w7Vj1DsJQA3+S2v2GIwXsP5MD+70OybjmDsSjQn6EpYKUGP2Du
X-Gm-Message-State: AOJu0YwtWAzqSJRLt4eLsz3Gvp/3F08WubvuGtaoJu82ljiG+UrwBOZ4
	bsB7oh2tm7PB1X2+BQKsGc4SfISAHUJe7o0veKUNcWaRGno23Tl0
X-Google-Smtp-Source: AGHT+IFYHxcxC5K///xN8TdhvcV0L0S4HqGrm6Owjo8OMKvGaqisRg+RzbGDo9m7iGenBVoNKQmouQ==
X-Received: by 2002:a05:6a20:d493:b0:19e:3ccd:6f86 with SMTP id im19-20020a056a20d49300b0019e3ccd6f86mr3412887pzb.43.1708022839161;
        Thu, 15 Feb 2024 10:47:19 -0800 (PST)
Received: from debian ([2601:641:300:14de:5279:cdf6:aaf1:e09c])
        by smtp.gmail.com with ESMTPSA id d128-20020a633686000000b005dc884e9f5bsm1726394pga.38.2024.02.15.10.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 10:47:18 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Thu, 15 Feb 2024 10:47:16 -0800
To: shiju.jose@huawei.com
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
	jonathan.cameron@huawei.com, tanxiaofei@huawei.com,
	prime.zeng@hisilicon.com, linuxarm@huawei.com, fan.ni@samsung.com
Subject: Re: [PATCH v2 2/3] hw/cxl/cxl-mailbox-utils: Add device patrol scrub
 control feature
Message-ID: <Zc5cNLH9FS24qXTe@debian>
References: <20231124135338.1191-1-shiju.jose@huawei.com>
 <20231124135338.1191-3-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124135338.1191-3-shiju.jose@huawei.com>

On Fri, Nov 24, 2023 at 09:53:36PM +0800, shiju.jose@huawei.com wrote:
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

LGTM except for some minor comments inlined.


>  hw/cxl/cxl-mailbox-utils.c | 97 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 96 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 1bbc9a48a6..5a6f4e4029 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -809,6 +809,7 @@ typedef struct CXLSupportedFeatureEntry {
>  } QEMU_PACKED CXLSupportedFeatureEntry;
>  
>  enum CXL_SUPPORTED_FEATURES_LIST {
> +    CXL_FEATURE_PATROL_SCRUB = 0,
>      CXL_FEATURE_MAX
>  };
>  
> @@ -849,6 +850,37 @@ enum CXL_SET_FEATURE_FLAG_DATA_TRANSFER {
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
>  /* CXL r3.0 section 8.2.9.6.1: Get Supported Features (Opcode 0500h) */
>  static CXLRetCode cmd_features_get_supported(const struct cxl_cmd *cmd,
>                                               uint8_t *payload_in,
> @@ -872,7 +904,7 @@ static CXLRetCode cmd_features_get_supported(const struct cxl_cmd *cmd,
>      uint16_t feat_entries = 0;
>  
>      if (get_feats_in->count < sizeof(CXLSupportedFeatureHeader) ||
> -        get_feats_in->start_index > CXL_FEATURE_MAX) {
> +        get_feats_in->start_index >= CXL_FEATURE_MAX) {

Not totally sure about this, the spec says "...Greater than..." although I
also think it should be >=. Similar things for the offset usage below.

Fan

>          return CXL_MBOX_INVALID_INPUT;
>      }
>      req_entries = (get_feats_in->count -
> @@ -884,6 +916,31 @@ static CXLRetCode cmd_features_get_supported(const struct cxl_cmd *cmd,
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
> @@ -924,6 +981,21 @@ static CXLRetCode cmd_features_get_feature(const struct cxl_cmd *cmd,
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
> @@ -937,6 +1009,29 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
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
