Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62992131722
	for <linux-cxl@vger.kernel.org>; Fri, 16 Feb 2024 18:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708107768; cv=none; b=p8vrgx/7e+oOkMzUWEAu+Ip5KZ09uLgVO754c1KP8utKVLcz6R5LvTuEJUdwOdQAzYLDpMJrzYYVxg3JH6Q9Pf9IWqn4mmAAh//tPc7W2pHnV2Rnn0BODMHJUpsmrfKX5p7yL+zhOllSGYSdk0AyVHkUoOgB3txMTjqnl11nWtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708107768; c=relaxed/simple;
	bh=bsW5OrKblXHWwAS/NX0mS9OMm6FgkVMQnNlaj1CizBQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Srr1n84wAUQB/CgGaT1BxNVyB/nRIHlyyhb+7/NzO/ckcCJRNdjLOALx42/bBwiIjjywdzj/BUk7Yqx+unFGTvhgqMf9b7Fiyygs6vjKJHK6rkhvDRiwuslG03rEQRTGuLooZB9lHAelOCgRIGCFkwLfYyUGjZ4XiZ5RZFvuTWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RjLqV5xU; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RjLqV5xU"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6da202aa138so1740480b3a.2
        for <linux-cxl@vger.kernel.org>; Fri, 16 Feb 2024 10:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708107765; x=1708712565; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mA+oIB66oyv0PhDsgns6Ewek9FofOXKVahYSdpTmAD4=;
        b=RjLqV5xUQeK6+10ARYabqgRVJeA+xNtVHddvxIEk9CdqkBd2ioW/3RV8nKYUV9TtrZ
         15vRDnfdPVCSqgIIn8IlSZ1MIsvFZp5+jhbKXsM5+Nc6ByWw+ouxLgWHBstCK6H6TUGG
         U8IFkAfTzpuDONnzOu/8fFHQQ882E1J+ZpdfBgLZzd+bBgYdM1i/E4OHFQYPOwn6Xrom
         6kxSu9+jD+SyMzm4NSx+rUVwfRsaQo1WInRpbqcWPUJv4oidVJjeuv+VMkTqynHlYvnY
         ydUaJXfv8ACEfY1jP5KKYkYyZi7qPTNb1gZRtOzBkv1ckodvmkVtzUh5Z2VbnKl912N8
         2nKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708107765; x=1708712565;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mA+oIB66oyv0PhDsgns6Ewek9FofOXKVahYSdpTmAD4=;
        b=cOllaGfGipjZxIo3BgwTIrd/h1GXS87ylbrMutLVC+sbpc1OH/vfCzPRSKw44Wb543
         DHynBQC/o0BerB8Hj0NFrNHPY6bCSKdNUbTr5tC1/F3gzRQ+uvKNybmCBbj4bdlWg1eW
         kpKr99n751RhmRSgS+Mbmaw4nk/EQHCoVPZO1gryJyA0ae0nZ0HNijlWY8nYCemi8bgh
         fimSQ5h5AOO7nx3E2g+3/YVXB9NadY9wfB0I5oQLpiqvouOUCklOHeAqSeP9aCZz0M/C
         Za/c+luysCClOoZx+jkt+Ngu8lKd5DApsC7yFx5GhY3rECv/UzLYaLXbQVIxwdSNOing
         mJwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEzupG7zo62strW7M9KVTiifz32hZ6tlReCMGAC3pi1equjbIai35SpeUVBjm4ThoBb6BQg9DKMeBBpwqDeEQ5BSqojK6Y1ul7
X-Gm-Message-State: AOJu0Yw8N4+QL3tqUTc479/nDbMO0Uwr7xTAJNDkqRkwVCzfg6fPPPEy
	QAvJIiKKW9hS1TlKK4FgBhnBKOwwCwVZt9CvnKcv8nreiuQR4kkE
X-Google-Smtp-Source: AGHT+IF7ItT+UiwAjNJo2gcUy85doJ0IrevLpgL3TAKMOoBw1svivBRBtexkTsAiJhBpIKEEV2kzZQ==
X-Received: by 2002:a05:6a20:9396:b0:19e:9f2d:9825 with SMTP id x22-20020a056a20939600b0019e9f2d9825mr7650393pzh.49.1708107765432;
        Fri, 16 Feb 2024 10:22:45 -0800 (PST)
Received: from debian ([2601:641:300:14de:f1a:387c:5c5c:3099])
        by smtp.gmail.com with ESMTPSA id v17-20020aa799d1000000b006e09ec69d7dsm259455pfi.98.2024.02.16.10.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 10:22:45 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Fri, 16 Feb 2024 10:22:32 -0800
To: shiju.jose@huawei.com
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
	jonathan.cameron@huawei.com, tanxiaofei@huawei.com,
	prime.zeng@hisilicon.com, linuxarm@huawei.com, fan.ni@samsung.com
Subject: Re: [PATCH v3 1/3] hw/cxl/cxl-mailbox-utils: Add support for feature
 commands (8.2.9.6)
Message-ID: <Zc-n6EBBPRaEFlDC@debian>
References: <20240215110146.1444-1-shiju.jose@huawei.com>
 <20240215110146.1444-2-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215110146.1444-2-shiju.jose@huawei.com>

On Thu, Feb 15, 2024 at 07:01:44PM +0800, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> CXL spec 3.1 section 8.2.9.6 describes optional device specific features.
> CXL devices supports features with changeable attributes.
> Get Supported Features retrieves the list of supported device specific
> features. The settings of a feature can be retrieved using Get Feature and
> optionally modified using Set Feature.
> 
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>

Reviewed-by: Fan Ni <fan.ni@samsung.com>

> ---
>  hw/cxl/cxl-mailbox-utils.c | 175 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 175 insertions(+)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 80a80f1ec2..f761ac49b5 100644
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
> @@ -965,6 +969,165 @@ static CXLRetCode cmd_logs_get_log(const struct cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
>  
> +/* CXL r3.1 section 8.2.9.6: Features */
> +/*
> + * Get Supported Features output payload
> + * CXL r3.1 section 8.2.9.6.1 Table 8-96
> + */
> +typedef struct CXLSupportedFeatureHeader {
> +    uint16_t entries;
> +    uint16_t nsuppfeats_dev;
> +    uint32_t reserved;
> +} QEMU_PACKED CXLSupportedFeatureHeader;
> +
> +/*
> + * Get Supported Features Supported Feature Entry
> + * CXL r3.1 section 8.2.9.6.1 Table 8-97
> + */
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
> +/* Get Feature CXL 3.1 Spec 8.2.9.6.2 */
> +/*
> + * Get Feature input payload
> + * CXL r3.1 section 8.2.9.6.2 Table 8-99
> + */
> +/* Get Feature : Payload in selection */
> +enum CXL_GET_FEATURE_SELECTION {
> +    CXL_GET_FEATURE_SEL_CURRENT_VALUE,
> +    CXL_GET_FEATURE_SEL_DEFAULT_VALUE,
> +    CXL_GET_FEATURE_SEL_SAVED_VALUE,
> +    CXL_GET_FEATURE_SEL_MAX
> +};
> +
> +/* Set Feature CXL 3.1 Spec 8.2.9.6.3 */
> +/*
> + * Set Feature input payload
> + * CXL r3.1 section 8.2.9.6.3 Table 8-101
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
> +    CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER,
> +    CXL_SET_FEATURE_FLAG_INITIATE_DATA_TRANSFER,
> +    CXL_SET_FEATURE_FLAG_CONTINUE_DATA_TRANSFER,
> +    CXL_SET_FEATURE_FLAG_FINISH_DATA_TRANSFER,
> +    CXL_SET_FEATURE_FLAG_ABORT_DATA_TRANSFER,
> +    CXL_SET_FEATURE_FLAG_DATA_TRANSFER_MAX
> +};
> +
> +/* CXL r3.1 section 8.2.9.6.1: Get Supported Features (Opcode 0500h) */
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
> +/* CXL r3.1 section 8.2.9.6.2: Get Feature (Opcode 0501h) */
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
> +/* CXL r3.1 section 8.2.9.6.3: Set Feature (Opcode 0502h) */
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
>  /* CXL r3.1 Section 8.2.9.9.1.1: Identify Memory Device (Opcode 4000h) */
>  static CXLRetCode cmd_identify_memory_device(const struct cxl_cmd *cmd,
>                                               uint8_t *payload_in,
> @@ -2166,6 +2329,18 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
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
