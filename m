Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5241912E1C7
	for <linux-cxl@vger.kernel.org>; Thu, 15 Feb 2024 18:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708020349; cv=none; b=FJ48TNran+2Cz85zX3Vl1aZ+OngUkrtopQS3Dx0GJ94rrxxWVGWRBDKQRddiZ2w7rAFojWb++fq8prS27qGHLNKED6k7QLKHct9VtU/LR6MiS5mSidi+VGCIleBcKGz06cRsSzx0eY4npQ6RfgQIaVv2MkVtJA/udsLVnL66VCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708020349; c=relaxed/simple;
	bh=Is4UuTd8pE5Mvz1ymd5rz2FEtD3bNUh3knKnPs+OrSQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=csV5lCokxIEKaFqRR+U12uKlMfo44bOJvt510GTIsiVvRPiAUfCo0BoNc/r1kVfYC+HYiUOdejbwFp7k6x4YW9hH8hcBATKT8D9neeLgwQcVbWdWu5c3BuvoEm2EvbrO0RM6TJI+fYPo9Fs294mwsJI+4bDHauBrIZg1l4SaCGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XFvGvgv3; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XFvGvgv3"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5ce9555d42eso931053a12.2
        for <linux-cxl@vger.kernel.org>; Thu, 15 Feb 2024 10:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708020347; x=1708625147; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eIgUnvQyGxrS7Bai+vA7mlTK92iHDoU7YFwg30PgKhI=;
        b=XFvGvgv3e1nHfgEaLLdZ9e6nApnIqbOEKDne9e5/f5FA8MDj37xWAsBgpCVExxfZmJ
         xCR7+ESa6rqT9iaypEW6RDE7fUJoMJknLajOoKKFzwQo95F2nFUPOik5kMXFNkWk43DJ
         xsAfjTm0Y3ZWHNPYEgIJLdPP5i7cyrtdYdJzTpa4EpT4RcuZnKUCRK4X4xymsk8u8zQy
         3sVqs8AdkbVSlA6PK5+/iaXgbdYC+O6LQ42CIR/40hLoS5wmYZF5QlqEQ4qP9Vk4D738
         q2x+w43IZ5A0RPWFkz5pFxve9vQhZFb6MsUypyX1JXGQchSYJhAz/hemycRJ4NB4M32I
         hASQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708020347; x=1708625147;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eIgUnvQyGxrS7Bai+vA7mlTK92iHDoU7YFwg30PgKhI=;
        b=aeDDhm6bHrp99mYnS+E1sIe/DUlfu8XnFTObkbFMkCclTkvoyg9NgaDq+gdE01g2Vs
         auJymcRFI/6wIao/e+RRhScZ3m2m/IuBjOwIa53IAv3GxPYtyi0mRuu1w/ete9lur1t3
         wC7rTM+2t9OaRT9QhHrohi6Mm3I+4kQwESWwfBpU0fOSebARjEJOhez2sznjB2c82HJA
         XEf4vRBB1mJH3FQ46y0CbmhK1ZnQEYsVzr/7KmW9VRL7zgS+kgiNG+FzqlDxQL0lZAfg
         4zARZDV5WaQemlUDz0hBpYz+AbqFHpdgVMBYor5bdVsF85LrmDG8xLK0v2elIUp/loGx
         JUNg==
X-Forwarded-Encrypted: i=1; AJvYcCUUmDI058j7NK2gnnoEJnd+SlL2NEFmzYEMpD8vHyaiIB4pGg2dP6UrS91qUrYuXUwrynQLgHPg7opKL7trvAWVzQ2tzRULduqI
X-Gm-Message-State: AOJu0YwcdS73EuO6LsYHNR91qrXO490QGS+Cm5Ij0z/QdMi1y118/5nv
	lj1vajvWluEJUjY/Mc7DDtwbYi78VFytoLRE50gC1j8yjCauxx7x
X-Google-Smtp-Source: AGHT+IECJE3MLz7w7Lyqv6ZiFWFbf+iqHiChmFFdGq8n9fm5kb5aS+J3p74oZjP4nk9Kk8cbj2lDKQ==
X-Received: by 2002:a17:90a:b011:b0:298:c236:10c5 with SMTP id x17-20020a17090ab01100b00298c23610c5mr2448098pjq.10.1708020347414;
        Thu, 15 Feb 2024 10:05:47 -0800 (PST)
Received: from debian ([2601:641:300:14de:5279:cdf6:aaf1:e09c])
        by smtp.gmail.com with ESMTPSA id b3-20020a17090a800300b00298985d0147sm1747230pjn.7.2024.02.15.10.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 10:05:47 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Thu, 15 Feb 2024 10:05:32 -0800
To: shiju.jose@huawei.com
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
	jonathan.cameron@huawei.com, tanxiaofei@huawei.com,
	prime.zeng@hisilicon.com, linuxarm@huawei.com
Subject: Re: [PATCH v2 1/3] hw/cxl/cxl-mailbox-utils: Add support for feature
 commands (8.2.9.6)
Message-ID: <Zc5SbEn1J-Bk0tYg@debian>
References: <20231124135338.1191-1-shiju.jose@huawei.com>
 <20231124135338.1191-2-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124135338.1191-2-shiju.jose@huawei.com>

On Fri, Nov 24, 2023 at 09:53:35PM +0800, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> CXL spec 3.0 section 8.2.9.6 describes optional device specific features.
> CXL devices supports features with changeable attributes.
> Get Supported Features retrieves the list of supported device specific
> features. The settings of a feature can be retrieved using Get Feature and
> optionally modified using Set Feature.
> 
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> ---

Updated the references to align with cxl spec r3.1, other than that looks
good to me.

Fan

>  hw/cxl/cxl-mailbox-utils.c | 167 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 167 insertions(+)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 6184f44339..1bbc9a48a6 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -66,6 +66,10 @@ enum {
>      LOGS        = 0x04,
>          #define GET_SUPPORTED 0x0
>          #define GET_LOG       0x1
> +    FEATURES    = 0x05,
> +        #define GET_SUPPORTED 0x0
> +        #define GET_FEATURE   0x1
> +        #define SET_FEATURE   0x2
>      IDENTIFY    = 0x40,
>          #define MEMORY_DEVICE 0x0
>      CCLS        = 0x41,
> @@ -785,6 +789,157 @@ static CXLRetCode cmd_logs_get_log(const struct cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
>  
> +/* CXL r3.0 section 8.2.9.6: Features */
> +typedef struct CXLSupportedFeatureHeader {
> +    uint16_t entries;
> +    uint16_t nsuppfeats_dev;
> +    uint32_t reserved;
> +} QEMU_PACKED CXLSupportedFeatureHeader;
> +
> +typedef struct CXLSupportedFeatureEntry {
> +    QemuUUID uuid;
> +    uint16_t feat_index;
> +    uint16_t get_feat_size;
> +    uint16_t set_feat_size;
> +    uint32_t attrb_flags;
> +    uint8_t get_feat_version;
> +    uint8_t set_feat_version;
> +    uint16_t set_feat_effects;
> +    uint8_t rsvd[18];
> +} QEMU_PACKED CXLSupportedFeatureEntry;
> +
> +enum CXL_SUPPORTED_FEATURES_LIST {
> +    CXL_FEATURE_MAX
> +};
> +
> +/* Get Feature CXL 3.0 Spec 8.2.9.6.2 */
> +/*
> + * Get Feature input payload
> + * CXL rev 3.0 section 8.2.9.6.2; Table 8-79
> + */
> +/* Get Feature : Payload in selection */
> +enum CXL_GET_FEATURE_SELECTION {
> +    CXL_GET_FEATURE_SEL_CURRENT_VALUE = 0x0,
> +    CXL_GET_FEATURE_SEL_DEFAULT_VALUE = 0x1,
> +    CXL_GET_FEATURE_SEL_SAVED_VALUE = 0x2,
> +    CXL_GET_FEATURE_SEL_MAX
> +};
> +
> +/* Set Feature CXL 3.0 Spec 8.2.9.6.3 */
> +/*
> + * Set Feature input payload
> + * CXL rev 3.0 section 8.2.9.6.3; Table 8-81
> + */
> +typedef struct CXLSetFeatureInHeader {
> +        QemuUUID uuid;
> +        uint32_t flags;
> +        uint16_t offset;
> +        uint8_t version;
> +        uint8_t rsvd[9];
> +} QEMU_PACKED QEMU_ALIGNED(16) CXLSetFeatureInHeader;
> +
> +/* Set Feature : Payload in flags */
> +#define CXL_SET_FEATURE_FLAG_DATA_TRANSFER_MASK   0x7
> +enum CXL_SET_FEATURE_FLAG_DATA_TRANSFER {
> +    CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER = 0x0,
> +    CXL_SET_FEATURE_FLAG_INITIATE_DATA_TRANSFER = 0x1,
> +    CXL_SET_FEATURE_FLAG_CONTINUE_DATA_TRANSFER = 0x2,
> +    CXL_SET_FEATURE_FLAG_FINISH_DATA_TRANSFER = 0x3,
> +    CXL_SET_FEATURE_FLAG_ABORT_DATA_TRANSFER = 0x4,
> +    CXL_SET_FEATURE_FLAG_DATA_TRANSFER_MAX
> +};
> +
> +/* CXL r3.0 section 8.2.9.6.1: Get Supported Features (Opcode 0500h) */
> +static CXLRetCode cmd_features_get_supported(const struct cxl_cmd *cmd,
> +                                             uint8_t *payload_in,
> +                                             size_t len_in,
> +                                             uint8_t *payload_out,
> +                                             size_t *len_out,
> +                                             CXLCCI *cci)
> +{
> +    struct {
> +        uint32_t count;
> +        uint16_t start_index;
> +        uint16_t reserved;
> +    } QEMU_PACKED QEMU_ALIGNED(16) * get_feats_in = (void *)payload_in;
> +
> +    struct {
> +        CXLSupportedFeatureHeader hdr;
> +        CXLSupportedFeatureEntry feat_entries[];
> +    } QEMU_PACKED QEMU_ALIGNED(16) * get_feats_out = (void *)payload_out;
> +    uint16_t index;
> +    uint16_t entry, req_entries;
> +    uint16_t feat_entries = 0;
> +
> +    if (get_feats_in->count < sizeof(CXLSupportedFeatureHeader) ||
> +        get_feats_in->start_index > CXL_FEATURE_MAX) {
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +    req_entries = (get_feats_in->count -
> +                   sizeof(CXLSupportedFeatureHeader)) /
> +                   sizeof(CXLSupportedFeatureEntry);
> +    req_entries = MIN(req_entries, CXL_FEATURE_MAX);
> +    index = get_feats_in->start_index;
> +
> +    entry = 0;
> +    while (entry < req_entries) {
> +        switch (index) {
> +        default:
> +            break;
> +        }
> +        index++;
> +        entry++;
> +    }
> +
> +    get_feats_out->hdr.nsuppfeats_dev = CXL_FEATURE_MAX;
> +    get_feats_out->hdr.entries = feat_entries;
> +    *len_out = sizeof(CXLSupportedFeatureHeader) +
> +                      feat_entries * sizeof(CXLSupportedFeatureEntry);
> +
> +    return CXL_MBOX_SUCCESS;
> +}
> +
> +/* CXL r3.0 section 8.2.9.6.2: Get Feature (Opcode 0501h) */
> +static CXLRetCode cmd_features_get_feature(const struct cxl_cmd *cmd,
> +                                           uint8_t *payload_in,
> +                                           size_t len_in,
> +                                           uint8_t *payload_out,
> +                                           size_t *len_out,
> +                                           CXLCCI *cci)
> +{
> +    struct {
> +        QemuUUID uuid;
> +        uint16_t offset;
> +        uint16_t count;
> +        uint8_t selection;
> +    } QEMU_PACKED QEMU_ALIGNED(16) * get_feature;
> +    uint16_t bytes_to_copy = 0;
> +
> +    get_feature = (void *)payload_in;
> +
> +    if (get_feature->selection != CXL_GET_FEATURE_SEL_CURRENT_VALUE) {
> +        return CXL_MBOX_UNSUPPORTED;
> +    }
> +    if (get_feature->offset + get_feature->count > cci->payload_max) {
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +
> +    *len_out = bytes_to_copy;
> +
> +    return CXL_MBOX_SUCCESS;
> +}
> +
> +/* CXL r3.0 section 8.2.9.6.3: Set Feature (Opcode 0502h) */
> +static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
> +                                           uint8_t *payload_in,
> +                                           size_t len_in,
> +                                           uint8_t *payload_out,
> +                                           size_t *len_out,
> +                                           CXLCCI *cci)
> +{
> +    return CXL_MBOX_SUCCESS;
> +}
> +
>  /* 8.2.9.5.1.1 */
>  static CXLRetCode cmd_identify_memory_device(const struct cxl_cmd *cmd,
>                                               uint8_t *payload_in,
> @@ -1954,6 +2109,18 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
>      [LOGS][GET_SUPPORTED] = { "LOGS_GET_SUPPORTED", cmd_logs_get_supported,
>                                0, 0 },
>      [LOGS][GET_LOG] = { "LOGS_GET_LOG", cmd_logs_get_log, 0x18, 0 },
> +    [FEATURES][GET_SUPPORTED] = { "FEATURES_GET_SUPPORTED",
> +                                  cmd_features_get_supported, 0x8, 0 },
> +    [FEATURES][GET_FEATURE] = { "FEATURES_GET_FEATURE",
> +                                cmd_features_get_feature, 0x15, 0 },
> +    [FEATURES][SET_FEATURE] = { "FEATURES_SET_FEATURE",
> +                                cmd_features_set_feature,
> +                                ~0,
> +                                (CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
> +                                 CXL_MBOX_IMMEDIATE_DATA_CHANGE |
> +                                 CXL_MBOX_IMMEDIATE_POLICY_CHANGE |
> +                                 CXL_MBOX_IMMEDIATE_LOG_CHANGE |
> +                                 CXL_MBOX_SECURITY_STATE_CHANGE)},
>      [IDENTIFY][MEMORY_DEVICE] = { "IDENTIFY_MEMORY_DEVICE",
>          cmd_identify_memory_device, 0, 0 },
>      [CCLS][GET_PARTITION_INFO] = { "CCLS_GET_PARTITION_INFO",
> -- 
> 2.34.1
> 
