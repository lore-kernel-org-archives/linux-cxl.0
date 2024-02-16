Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E719B12FF9B
	for <linux-cxl@vger.kernel.org>; Fri, 16 Feb 2024 17:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708104972; cv=none; b=mle+InK7e4ojaNmlzhHCWcGQmAEfz0YZWTZvzuQvJ1l/F51BpnB55sGyKMDbg4e4Lmy3TjgnKzrsHQwDrjMIdXw03TDxgZJhZt/imftBK5brGKDnR8EtaqsZPytgRi+Mt1CHtAvdaqAafEiGEt6sMnXBITrHbnzV6vAiLKuNlmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708104972; c=relaxed/simple;
	bh=bjFswSJtAsS4Uf0Itvyy1CEKPZJzt2WV4G1v0uXKuEM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DHOn8hvYKpBg330v/tPTRxbq6z4uXZ+6G5T6HWwhmAAWiMWPuRTBkxRgNPCsz66gseMvytpD1Qp8F22XhsjubgnRQefQxBS2W1C8N+Yy7fXQc14c4Fx1S14YE02QH1NZPIdubhK8DABlKAZU2kUuiIkHHW1j0KyDSANYn4hkWHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=STktj/9n; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="STktj/9n"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e0507eb60cso1581235b3a.3
        for <linux-cxl@vger.kernel.org>; Fri, 16 Feb 2024 09:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708104970; x=1708709770; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g3ZyChHdMolDJPWFg4CrXcpgpx/K2qPIY8LkU4Df2zU=;
        b=STktj/9n0sEUD6QsxReIv6+GoZKamGZYSk5/hD3ZoI6WCrKUgH/teILXWwoZfBRSGa
         BXm4sOJnxCNddftxsTys6hi4kQRNh6en+1TxMnhjtq7yJNVWmx1V7Ty9hBex6/2ADiDn
         Llm+lign3tG8l/054alkR9fYkjkZ48xBrPY+MfFUZmovfeLbJQ3SoY7rNvZfiJvG8QKT
         CyvfK4733DLlC/AjvO1nwqEazpzxwZZs673xVXOVddOHlgln3Vu59yxUDG97vFOl6M09
         l7/ZQdBN9LuRSkEz6zdV+GlxWFFWM/lldMXw+KPo7X08pGaS1OwJfghmnq/ijQwvGWAP
         Iisg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708104970; x=1708709770;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g3ZyChHdMolDJPWFg4CrXcpgpx/K2qPIY8LkU4Df2zU=;
        b=JGdc5cx2fe/Hwh5j7UAr7Xd5bMBrXnGNlvP8vw3d67o34PgJOYULIqaSwCjTb/pQLS
         TRb6IT9PYnZDaN4bBzHZN3nQ8b1cI3vz9FtbkMruy0/rAxFBZE7Ie2cnRbpEzBMpUeoH
         6wSOP8oPPNojM0X/5q2NGybDhRDPcdGr6o2I8n5oJ1Q6S5lcmfEMy2yrEBJdE9ktwe/2
         DqmhKVGoJiQPSlJCpB+L3TJuEQfDE0/lXb1EYGGYHAtGoXuGX85ix8kZVNYFqiUW02k9
         8FHUSLfDKdBAevFbPDIk7EA6s10WHB8ErArme7VehgJ0ndj9gWARZe9YDGNnN9y2j9wT
         ahpA==
X-Forwarded-Encrypted: i=1; AJvYcCViVGsp9+rhSRw9ZNa0BqmIsfS35jKuCs6icEJpE8u/HNSayRP5hSNPOmuEGSlc3o7ZYlx6PhqMrzlACRRKRXD+ZvB9oG0CCCVH
X-Gm-Message-State: AOJu0YxZzA3CXKPU7XbWjx4exjWq0F7fGeLtx0EVggqq08ZHUJPwBb37
	F/W1gIBLfuFEN2uMhM2MeMtv3rndJ1PG5tc2msCyCXc60FjaMWH8
X-Google-Smtp-Source: AGHT+IGiXDo4sudOp617jcz2uNbjAfR+LQhVZAEQWqcBgO038ZqakrZIrwEk6rNgkVQ+tggQ4spZiw==
X-Received: by 2002:a05:6a20:c704:b0:19f:2df0:1410 with SMTP id hi4-20020a056a20c70400b0019f2df01410mr6225517pzb.53.1708104970052;
        Fri, 16 Feb 2024 09:36:10 -0800 (PST)
Received: from debian ([2601:641:300:14de:f1a:387c:5c5c:3099])
        by smtp.gmail.com with ESMTPSA id p19-20020a056a0026d300b006e0e3ef5f23sm207277pfw.101.2024.02.16.09.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 09:36:09 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Fri, 16 Feb 2024 09:35:55 -0800
To: Shiju Jose <shiju.jose@huawei.com>
Cc: fan <nifan.cxl@gmail.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	tanxiaofei <tanxiaofei@huawei.com>,
	"Zengtao (B)" <prime.zeng@hisilicon.com>,
	Linuxarm <linuxarm@huawei.com>,
	"fan.ni@samsung.com" <fan.ni@samsung.com>
Subject: Re: [PATCH v2 2/3] hw/cxl/cxl-mailbox-utils: Add device patrol scrub
 control feature
Message-ID: <Zc-c-79gRJcyDugg@debian>
References: <20231124135338.1191-1-shiju.jose@huawei.com>
 <20231124135338.1191-3-shiju.jose@huawei.com>
 <Zc5cNLH9FS24qXTe@debian>
 <f6c14302e3f74fdc9eef41857b534e63@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6c14302e3f74fdc9eef41857b534e63@huawei.com>

On Fri, Feb 16, 2024 at 10:16:12AM +0000, Shiju Jose wrote:
> Hi Fan,
> 
> >-----Original Message-----
> >From: fan <nifan.cxl@gmail.com>
> >Sent: 15 February 2024 18:47
> >To: Shiju Jose <shiju.jose@huawei.com>
> >Cc: qemu-devel@nongnu.org; linux-cxl@vger.kernel.org; Jonathan Cameron
> ><jonathan.cameron@huawei.com>; tanxiaofei <tanxiaofei@huawei.com>;
> >Zengtao (B) <prime.zeng@hisilicon.com>; Linuxarm <linuxarm@huawei.com>;
> >fan.ni@samsung.com
> >Subject: Re: [PATCH v2 2/3] hw/cxl/cxl-mailbox-utils: Add device patrol scrub
> >control feature
> >
> >On Fri, Nov 24, 2023 at 09:53:36PM +0800, shiju.jose@huawei.com wrote:
> >> From: Shiju Jose <shiju.jose@huawei.com>
> >>
> >> CXL spec 3.1 section 8.2.9.9.11.1 describes the device patrol scrub
> >> control feature. The device patrol scrub proactively locates and makes
> >> corrections to errors in regular cycle. The patrol scrub control
> >> allows the request to configure patrol scrub input configurations.
> >>
> >> The patrol scrub control allows the requester to specify the number of
> >> hours for which the patrol scrub cycles must be completed, provided
> >> that the requested number is not less than the minimum number of hours
> >> for the patrol scrub cycle that the device is capable of. In addition,
> >> the patrol scrub controls allow the host to disable and enable the
> >> feature in case disabling of the feature is needed for other purposes
> >> such as performance-aware operations which require the background
> >> operations to be turned off.
> >>
> >> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> >> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> >> ---
> >
> >LGTM except for some minor comments inlined.
> >
> >
> >>  hw/cxl/cxl-mailbox-utils.c | 97
> >> +++++++++++++++++++++++++++++++++++++-
> >>  1 file changed, 96 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> >> index 1bbc9a48a6..5a6f4e4029 100644
> >> --- a/hw/cxl/cxl-mailbox-utils.c
> >> +++ b/hw/cxl/cxl-mailbox-utils.c
> >> @@ -809,6 +809,7 @@ typedef struct CXLSupportedFeatureEntry {  }
> >> QEMU_PACKED CXLSupportedFeatureEntry;
> >>
> >>  enum CXL_SUPPORTED_FEATURES_LIST {
> >> +    CXL_FEATURE_PATROL_SCRUB = 0,
> >>      CXL_FEATURE_MAX
> >>  };
> >>
> >> @@ -849,6 +850,37 @@ enum CXL_SET_FEATURE_FLAG_DATA_TRANSFER {
> >>      CXL_SET_FEATURE_FLAG_DATA_TRANSFER_MAX
> >>  };
> >>
> >> +/* CXL r3.1 section 8.2.9.9.11.1: Device Patrol Scrub Control Feature
> >> +*/ static const QemuUUID patrol_scrub_uuid = {
> >> +    .data = UUID(0x96dad7d6, 0xfde8, 0x482b, 0xa7, 0x33,
> >> +                 0x75, 0x77, 0x4e, 0x06, 0xdb, 0x8a) };
> >> +
> >> +#define CXL_MEMDEV_PS_GET_FEATURE_VERSION    0x01
> >> +#define CXL_MEMDEV_PS_SET_FEATURE_VERSION    0x01
> >> +#define CXL_MEMDEV_PS_SCRUB_CYCLE_CHANGE_CAP_DEFAULT    BIT(0)
> >> +#define CXL_MEMDEV_PS_SCRUB_REALTIME_REPORT_CAP_DEFAULT
> >BIT(1)
> >> +#define CXL_MEMDEV_PS_CUR_SCRUB_CYCLE_DEFAULT    12
> >> +#define CXL_MEMDEV_PS_MIN_SCRUB_CYCLE_DEFAULT    1
> >> +#define CXL_MEMDEV_PS_ENABLE_DEFAULT    0
> >> +
> >> +/* CXL memdev patrol scrub control attributes */ struct
> >> +CXLMemPatrolScrubReadAttrbs {
> >> +        uint8_t scrub_cycle_cap;
> >> +        uint16_t scrub_cycle;
> >> +        uint8_t scrub_flags;
> >> +} QEMU_PACKED cxl_memdev_ps_feat_read_attrbs;
> >> +
> >> +typedef struct CXLMemPatrolScrubWriteAttrbs {
> >> +    uint8_t scrub_cycle_hr;
> >> +    uint8_t scrub_flags;
> >> +} QEMU_PACKED CXLMemPatrolScrubWriteAttrbs;
> >> +
> >> +typedef struct CXLMemPatrolScrubSetFeature {
> >> +        CXLSetFeatureInHeader hdr;
> >> +        CXLMemPatrolScrubWriteAttrbs feat_data; } QEMU_PACKED
> >> +QEMU_ALIGNED(16) CXLMemPatrolScrubSetFeature;
> >> +
> >>  /* CXL r3.0 section 8.2.9.6.1: Get Supported Features (Opcode 0500h)
> >> */  static CXLRetCode cmd_features_get_supported(const struct cxl_cmd
> >*cmd,
> >>                                               uint8_t *payload_in, @@
> >> -872,7 +904,7 @@ static CXLRetCode cmd_features_get_supported(const
> >struct cxl_cmd *cmd,
> >>      uint16_t feat_entries = 0;
> >>
> >>      if (get_feats_in->count < sizeof(CXLSupportedFeatureHeader) ||
> >> -        get_feats_in->start_index > CXL_FEATURE_MAX) {
> >> +        get_feats_in->start_index >= CXL_FEATURE_MAX) {
> >
> >Not totally sure about this, the spec says "...Greater than..." although I also think
> >it should be >=. Similar things for the offset usage below.
> 
> Spec r3.1 described in Table 8-95. Get Supported Features Input Payload  as , 
> "Starting Feature Index: Index of the first requested Supported Feature Entry.
> Feature index is a zero-based value."
> Thus I believe get_feats_in->start_index >= CXL_FEATURE_MAX  is correct  because
> the feature index is zero-based value.
That is also my understanding.
> 
> Regarding the offset usage mentioned, can you point which code?
> Is it get_feature->offset? 
> 
Yea. Maybe not an issue as long as we keep all consistent.o

Fan
> >
> >Fan
> >
> >>          return CXL_MBOX_INVALID_INPUT;
> >>      }
> >>      req_entries = (get_feats_in->count - @@ -884,6 +916,31 @@ static
> >> CXLRetCode cmd_features_get_supported(const struct cxl_cmd *cmd,
> >>      entry = 0;
> >>      while (entry < req_entries) {
> >>          switch (index) {
> >> +        case  CXL_FEATURE_PATROL_SCRUB:
> >> +            /* Fill supported feature entry for device patrol scrub control */
> >> +            get_feats_out->feat_entries[entry] =
> >> +                           (struct CXLSupportedFeatureEntry) {
> >> +                .uuid = patrol_scrub_uuid,
> >> +                .feat_index = index,
> >> +                .get_feat_size = sizeof(cxl_memdev_ps_feat_read_attrbs),
> >> +                .set_feat_size = sizeof(CXLMemPatrolScrubWriteAttrbs),
> >> +                /* Bit[0] : 1, feature attributes changeable */
> >> +                .attrb_flags = 0x1,
> >> +                .get_feat_version = CXL_MEMDEV_PS_GET_FEATURE_VERSION,
> >> +                .set_feat_version = CXL_MEMDEV_PS_SET_FEATURE_VERSION,
> >> +                .set_feat_effects = 0,
> >> +            };
> >> +            feat_entries++;
> >> +            /* Set default value for device patrol scrub read attributes */
> >> +            cxl_memdev_ps_feat_read_attrbs.scrub_cycle_cap =
> >> +
> >CXL_MEMDEV_PS_SCRUB_CYCLE_CHANGE_CAP_DEFAULT |
> >> +
> >CXL_MEMDEV_PS_SCRUB_REALTIME_REPORT_CAP_DEFAULT;
> >> +            cxl_memdev_ps_feat_read_attrbs.scrub_cycle =
> >> +                                CXL_MEMDEV_PS_CUR_SCRUB_CYCLE_DEFAULT |
> >> +                                (CXL_MEMDEV_PS_MIN_SCRUB_CYCLE_DEFAULT << 8);
> >> +            cxl_memdev_ps_feat_read_attrbs.scrub_flags =
> >> +                                CXL_MEMDEV_PS_ENABLE_DEFAULT;
> >> +            break;
> >>          default:
> >>              break;
> >>          }
> >> @@ -924,6 +981,21 @@ static CXLRetCode cmd_features_get_feature(const
> >struct cxl_cmd *cmd,
> >>          return CXL_MBOX_INVALID_INPUT;
> >>      }
> >>
> >> +    if (qemu_uuid_is_equal(&get_feature->uuid, &patrol_scrub_uuid)) {
> >> +        if (get_feature->offset >= sizeof(cxl_memdev_ps_feat_read_attrbs)) {
> >> +            return CXL_MBOX_INVALID_INPUT;
> >> +        }
> >> +        bytes_to_copy = sizeof(cxl_memdev_ps_feat_read_attrbs) -
> >> +                                             get_feature->offset;
> >> +        bytes_to_copy = (bytes_to_copy > get_feature->count) ?
> >> +                               get_feature->count : bytes_to_copy;
> >> +        memcpy(payload_out,
> >> +               &cxl_memdev_ps_feat_read_attrbs + get_feature->offset,
> >> +               bytes_to_copy);
> >> +    } else {
> >> +        return CXL_MBOX_UNSUPPORTED;
> >> +    }
> >> +
> >>      *len_out = bytes_to_copy;
> >>
> >>      return CXL_MBOX_SUCCESS;
> >> @@ -937,6 +1009,29 @@ static CXLRetCode cmd_features_set_feature(const
> >struct cxl_cmd *cmd,
> >>                                             size_t *len_out,
> >>                                             CXLCCI *cci)  {
> >> +    CXLMemPatrolScrubWriteAttrbs *ps_write_attrbs;
> >> +    CXLMemPatrolScrubSetFeature *ps_set_feature;
> >> +    CXLSetFeatureInHeader *hdr = (void *)payload_in;
> >> +
> >> +    if (qemu_uuid_is_equal(&hdr->uuid, &patrol_scrub_uuid)) {
> >> +        if (hdr->version != CXL_MEMDEV_PS_SET_FEATURE_VERSION ||
> >> +            (hdr->flags & CXL_SET_FEATURE_FLAG_DATA_TRANSFER_MASK) !=
> >> +                               CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER) {
> >> +            return CXL_MBOX_UNSUPPORTED;
> >> +        }
> >> +
> >> +        ps_set_feature = (void *)payload_in;
> >> +        ps_write_attrbs = &ps_set_feature->feat_data;
> >> +        cxl_memdev_ps_feat_read_attrbs.scrub_cycle &= ~0xFF;
> >> +        cxl_memdev_ps_feat_read_attrbs.scrub_cycle |=
> >> +                          ps_write_attrbs->scrub_cycle_hr & 0xFF;
> >> +        cxl_memdev_ps_feat_read_attrbs.scrub_flags &= ~0x1;
> >> +        cxl_memdev_ps_feat_read_attrbs.scrub_flags |=
> >> +                          ps_write_attrbs->scrub_flags & 0x1;
> >> +    } else {
> >> +        return CXL_MBOX_UNSUPPORTED;
> >> +    }
> >> +
> >>      return CXL_MBOX_SUCCESS;
> >>  }
> >>
> >> --
> >> 2.34.1
> >>
> 
> Thanks,
> Shiju
