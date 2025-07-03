Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C4942A9B
	for <linux-cxl@vger.kernel.org>; Thu,  3 Jul 2025 04:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751516255; cv=none; b=p1NE1Pu2c3GD6xaG8IaHiruzQy4BeTh0xGU+c7CzdKLooefH4OZvwuBhI5gK66YAImMA+J0NvREgpqagdUueGP28SrVNBc/TRw2nFKcPSKklYhRWWhxY3r7sarm/mapsKCS8LDpk0/Q9Ys4+hmYjUcUJaQ0XilVtRe2sKqYxx7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751516255; c=relaxed/simple;
	bh=eolOT2CMTKcnHSw8HGjt5BSJSUVRrjDtITmgObmWrLo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GYDHb4u1SAGECHOyVW0m7rtI+uF1NOnsJMTWGTb2BdpqP7L1x8yohFin46g3TJSYsBh9n1VU8/ZpE5dT3MV5l6Zbai/OTAF7HUHu0x5UsuLbd6OeNL90aRIOMuIB4P0qaG9x+6vO9veyYJzKapNRsv2OZ9+jBCHD75iezenT82s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HgpzSYaT; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HgpzSYaT"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2349f096605so63383835ad.3
        for <linux-cxl@vger.kernel.org>; Wed, 02 Jul 2025 21:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751516251; x=1752121051; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=08NQ+TjkxcZaFANSHy0nh1+PPk3TzQQAToiAVZBT/ME=;
        b=HgpzSYaTGSgD2Y4N1wzQUwgNZ5eSN5PQ8PsRBTiU6fF1EcORJtykE1TUYAADflPJxu
         WBRh7xWBxbB6KXLci3pp45Gi1S2g6l5F7vOFDFzXzzwFUp0LuUeUoUBzQcZL2O9bXFF5
         GNQgl7U5zWW5Ov8htiEqoJa6m2uTN1qZAxTndIzwmmKN9SBSZFIMhyi0CiqhqwhsT8kh
         mR45T6IZQ7oXRCYDSIp4v9MpXxU1vvY3lAkadX6xyVUEUwQZEc66IRg14yqDeqfigj8T
         4eVDz4dwrEshaUQJwJYCXZAItDxlmYExTSki0fqEMVfOGXdC3InY/fFmBa6FeqZzxCkQ
         i+Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751516251; x=1752121051;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=08NQ+TjkxcZaFANSHy0nh1+PPk3TzQQAToiAVZBT/ME=;
        b=rMoYl46V9lQMszDbLZYeKARtiDa2hOUZB2PxW3siA4z7baaq0rcL0Q8xacmMVbGi7c
         LeBbBSxgNgn0szliG7B6O3eQMpxzsznC2KV4G/djUtwF5vuKozDSYsjUkxr/00KAPZws
         bMLLRRSiPqjB8+D8fsH3WWEfv8mCoW1ffEM+/bTHni3zYA77cQ/uO1Bmo+wdqbWL1g9u
         ps0Jy0F+PogAXzW2B2hycPvrT5JZSFr4TDhBxDpXug+obGnj9GHAY1jt7DLw2cxXMFNv
         S+494Jh/x22fmynf9ptVf8GjNWyDvV3trlJaLXzUU+7IHy7ibuA+DSg9eB/YBKyFjngx
         UNrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJHEYUWCmaTTLwW6Fvg6gUkuPCVkOXx643r5rI0gaR5qB/SMyzRFqZO2mouhQgo8cQwSN1Bsc2iTM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyYSWO6znW6y7u7DHVlUd3kfPvqHx7JGUxWHvwnlmYYq1jiF76
	KQxAlSh+zq5gpvBuKqP/Y1Z7NFGkmsLXrKM2Aqy9QQVF8rlZ7XpVX9La
X-Gm-Gg: ASbGncvmD6sbRsG0R8MatO6kBxdRhmtv0q9XCAHvCS8l5LhS1f9lJ4WZ0IxsihMUCnC
	hZealMfUXCMkwqn7bfuMIQK7oOPES46v9I2185RxZxGsVAza5Y29nEbkjquDzgwuYiE0Ri2nIPh
	dq955LYfW6aAMPJuwVHILJLMN08R3MNd9IrN9ngVRpeZSHhU5cJc2UqBZJLhZ++Y9cHzGbSix92
	RX4IExSIdagil5A/szu3HDB2a4j0DebUKgQ6xPd1KC8n3Kg8vWP6I3qc53XjkbU1rFqWLPgc1BQ
	OGtIbEKlulkerNp6CoatE38GyqRgwcpUR1mPriRUQK2tfCWfzkpN5clmEau9bRYRVZmkt4GkYmO
	5
X-Google-Smtp-Source: AGHT+IEbGztOUWf5B7SpFHLemr8o7EKypKBByaiK87oOjUhC7qGuUyRY3Ci1wZazLCfp5+V8KPf0/w==
X-Received: by 2002:a17:902:e5cc:b0:234:c7e6:8459 with SMTP id d9443c01a7336-23c6e5023f8mr71405255ad.20.1751516251221;
        Wed, 02 Jul 2025 21:17:31 -0700 (PDT)
Received: from smc-140338-bm01 ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb2e219asm151676075ad.40.2025.07.02.21.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 21:17:30 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Thu, 3 Jul 2025 04:17:28 +0000
To: anisa.su887@gmail.com
Cc: qemu-devel@nongnu.org, Jonathan.Cameron@huawei.com, nifan.cxl@gmail.com,
	dave@stgolabs.net, alok.a.tiwari@oracle.com,
	linux-cxl@vger.kernel.org, Anisa Su <anisa.su@samsung.com>
Subject: Re: [QEMU PATCH v4 09/10] cxl-mailbox-utils: 0x5604 - FMAPI Initiate
 DC Add
Message-ID: <aGYEWDOGPbtncEmN@smc-140338-bm01>
References: <20250626222743.1766404-1-anisa.su887@gmail.com>
 <20250626222743.1766404-10-anisa.su887@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626222743.1766404-10-anisa.su887@gmail.com>

On Thu, Jun 26, 2025 at 10:23:32PM +0000, anisa.su887@gmail.com wrote:
> From: Anisa Su <anisa.su@samsung.com>
> 
> FM DCD Management command 0x5604 implemented per CXL r3.2 Spec Section 7.6.7.6.5
> 
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
> ---

Minor comments inline...

>  hw/cxl/cxl-mailbox-utils.c  | 106 ++++++++++++++++++++++++++++++++++++
>  hw/mem/cxl_type3.c          |   8 +--
>  include/hw/cxl/cxl_device.h |   4 ++
>  3 files changed, 114 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 382c41c025..787eeaa7b9 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -122,6 +122,7 @@ enum {
>          #define GET_HOST_DC_REGION_CONFIG   0x1
>          #define SET_DC_REGION_CONFIG        0x2
>          #define GET_DC_REGION_EXTENT_LIST   0x3
> +        #define INITIATE_DC_ADD             0x4
>  };
>  
>  /* CCI Message Format CXL r3.1 Figure 7-19 */
> @@ -3539,6 +3540,104 @@ static CXLRetCode cmd_fm_get_dc_region_extent_list(const struct cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
>  
> +/*
> + * Helper function to convert CXLDCExtentRaw to CXLUpdateDCExtentListInPl
> + * in order to reuse cxl_detect_malformed_extent_list() function which accepts
> + * CXLUpdateDCExtentListInPl as a parameter.
> + */
> +static void convert_raw_extents(CXLDCExtentRaw raw_extents[],
> +                                CXLUpdateDCExtentListInPl *extent_list,
> +                                int count)
> +{
> +    int i;
> +
> +    extent_list->num_entries_updated = count;
> +
> +    for (i = 0; i < count; i++) {
> +        extent_list->updated_entries[i].start_dpa = raw_extents[i].start_dpa;
> +        extent_list->updated_entries[i].len = raw_extents[i].len;
> +    }
> +}
> +
> +/* CXL r3.2 Section 7.6.7.6.5 Initiate Dynamic Capacity Add (Opcode 5604h) */

Keep the spec reference comments consistent like below,
/* CXL r3.2 Section 7.6.7.6.5: Initiate Dynamic Capacity Add (Opcode 5604h) */

> +static CXLRetCode cmd_fm_initiate_dc_add(const struct cxl_cmd *cmd,
> +                                         uint8_t *payload_in,
> +                                         size_t len_in,
> +                                         uint8_t *payload_out,
> +                                         size_t *len_out,
> +                                         CXLCCI *cci)
> +{
> +    struct {
> +        uint16_t host_id;
> +        uint8_t selection_policy;
> +        uint8_t reg_num;
> +        uint64_t length;
> +        uint8_t tag[0x10];
> +        uint32_t ext_count;
> +        CXLDCExtentRaw extents[];
> +    } QEMU_PACKED *in = (void *)payload_in;
> +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> +    int i, rc;
> +
> +    switch (in->selection_policy) {
> +        case CXL_EXTENT_SELECTION_POLICY_PRESCRIPTIVE: {
> +            /* Adding extents exceeds device's extent tracking ability. */
> +            if (in->ext_count + ct3d->dc.total_extent_count >
> +                CXL_NUM_EXTENTS_SUPPORTED) {
> +                return CXL_MBOX_RESOURCES_EXHAUSTED;
> +            }
> +
> +            g_autofree CXLUpdateDCExtentListInPl *list =
This seems not consistent with existing code style. Type declaration
comes first.
> +                g_malloc0(sizeof(*list) +
> +                    in->ext_count * sizeof(*list->updated_entries));
> +
> +            convert_raw_extents(in->extents, list, in->ext_count);
> +            rc = cxl_detect_malformed_extent_list(ct3d, list);
> +
> +            for (i = 0; i < in->ext_count; i++) {
> +                CXLDCExtentRaw ext = in->extents[i];
Use pointer as Jonathan mentioned.
> +                /* Check requested extents do not overlap with pending extents. */
shorten the comments like
Extents to add cannot overlap with pending extents
> +                if (cxl_extent_groups_overlaps_dpa_range(&ct3d->dc.extents_pending,
> +                                                         ext.start_dpa, ext.len)) {
> +                    return CXL_MBOX_INVALID_EXTENT_LIST;
> +                }
> +                /* Check requested extents do not overlap with existing extents. */
Not allowed to add extents already existing
> +                if (cxl_extents_overlaps_dpa_range(&ct3d->dc.extents,
> +                                                   ext.start_dpa, ext.len)) {
> +                    return CXL_MBOX_INVALID_EXTENT_LIST;
> +                }
> +            }
> +
> +            if (rc) {
> +                return rc;
> +            }
> +
> +            CXLDCExtentGroup *group = NULL;
> +            for (i = 0; i < in->ext_count; i++) {
> +                group = cxl_insert_extent_to_extent_group(group,
> +                                                          in->extents[i].start_dpa,
> +                                                          in->extents[i].len,
> +                                                          in->extents[i].tag,
> +                                                          in->extents[i].shared_seq);
Shorten the lines as Jonathan suggested. 

Fan
> +            }
> +
> +            cxl_extent_group_list_insert_tail(&ct3d->dc.extents_pending, group);
> +            ct3d->dc.total_extent_count += in->ext_count;
> +            cxl_create_dc_event_records_for_extents(ct3d,
> +                                                    DC_EVENT_ADD_CAPACITY,
> +                                                    in->extents,
> +                                                    in->ext_count);
> +
> +            return CXL_MBOX_SUCCESS;
> +        }
> +        default: {
> +            qemu_log_mask(LOG_UNIMP,
> +                          "CXL extent selection policy not supported.\n");
> +            return CXL_MBOX_INVALID_INPUT;
> +        }
> +    }
> +}
> +
>  static const struct cxl_cmd cxl_cmd_set[256][256] = {
>      [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
>          cmd_infostat_bg_op_abort, 0, 0 },
> @@ -3666,6 +3765,13 @@ static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
>           CXL_MBOX_IMMEDIATE_DATA_CHANGE) },
>      [FMAPI_DCD_MGMT][GET_DC_REGION_EXTENT_LIST] = { "GET_DC_REGION_EXTENT_LIST",
>          cmd_fm_get_dc_region_extent_list, 12, 0 },
> +    [FMAPI_DCD_MGMT][INITIATE_DC_ADD] = { "INIT_DC_ADD",
> +        cmd_fm_initiate_dc_add, ~0,
> +        (CXL_MBOX_CONFIG_CHANGE_COLD_RESET |
> +        CXL_MBOX_CONFIG_CHANGE_CONV_RESET |
> +        CXL_MBOX_CONFIG_CHANGE_CXL_RESET |
> +        CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
> +        CXL_MBOX_IMMEDIATE_DATA_CHANGE) },
>  };
>  
>  /*
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 9c2b9d197b..7676d785c2 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -1885,8 +1885,8 @@ void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
>   * the list.
>   * Return value: return true if has overlaps; otherwise, return false
>   */
> -static bool cxl_extents_overlaps_dpa_range(CXLDCExtentList *list,
> -                                           uint64_t dpa, uint64_t len)
> +bool cxl_extents_overlaps_dpa_range(CXLDCExtentList *list,
> +                                    uint64_t dpa, uint64_t len)
>  {
>      CXLDCExtent *ent;
>      Range range1, range2;
> @@ -1931,8 +1931,8 @@ bool cxl_extents_contains_dpa_range(CXLDCExtentList *list,
>      return false;
>  }
>  
> -static bool cxl_extent_groups_overlaps_dpa_range(CXLDCExtentGroupList *list,
> -                                                 uint64_t dpa, uint64_t len)
> +bool cxl_extent_groups_overlaps_dpa_range(CXLDCExtentGroupList *list,
> +                                          uint64_t dpa, uint64_t len)
>  {
>      CXLDCExtentGroup *group;
>  
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index 91ec1ba299..7be68d98c6 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -736,4 +736,8 @@ void cxl_create_dc_event_records_for_extents(CXLType3Dev *ct3d,
>                                               CXLDCEventType type,
>                                               CXLDCExtentRaw extents[],
>                                               uint32_t ext_count);
> +bool cxl_extents_overlaps_dpa_range(CXLDCExtentList *list,
> +                                    uint64_t dpa, uint64_t len);
> +bool cxl_extent_groups_overlaps_dpa_range(CXLDCExtentGroupList *list,
> +                                          uint64_t dpa, uint64_t len);
>  #endif
> -- 
> 2.47.2
> 

-- 
Fan Ni (From gmail)
