Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98841DFCB
	for <linux-cxl@vger.kernel.org>; Fri,  6 Jun 2025 18:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749234073; cv=none; b=Psgu3DF1U/jMixQEduaMnDRcRE6H29wifoLZWY+s8+mV9Pf/tGHIyTSHb/FfGEnWGtMxKKIwxl+JIOkJr93wmARlsTniY7GnaVndxZ4eDpUGvecLkc8QTzzN3cbWXmJW/1fOuf/O41hGG9eL9UvGcNEcG+pHhVp77dLzxSb0pM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749234073; c=relaxed/simple;
	bh=/bLozB2jLyD24LiaPjuFDCp+SnVjQqprqMrphGXGv40=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fKl92nhNZBRAH6dHIG3ARIOuvJkzNBfZ8GI1fuQaU2SIHUtcvJzZXJJqcIisWYzeaJWim6RkdybQpX//G+ZMJgFP8Hvgsb18mpiaUZJ4K2YpcDqRDPuYW9FU0bRYmbLJung1ReuER4Evld6JC2tU/e7L+GeFzAfwMuICoz9JGnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=drTIL6qf; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="drTIL6qf"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-742af84818cso1814975b3a.1
        for <linux-cxl@vger.kernel.org>; Fri, 06 Jun 2025 11:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749234071; x=1749838871; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tP/wQPBGjbbKyfTZfIc/iAV9m6jQ7fU2q5ZDYkmBio0=;
        b=drTIL6qfTj1ZtbxZxyUeCn+6IlbbOmdl64hnhLkhD4+FlCtNJ3/on1KQ9qgwMsYHFc
         mQ0Ibw9fvAOgJhDCZqToi15QqUi6bJq6hOR7MSOsycR7tPgSt0fioKHfQnMSKoIMNc9J
         bHpkKCuSpeyM0/KpGW2tw2E0IW9Do7kE2AYxLc5s9NBuXd+x9dw4SuBpFEM7WclHQTmN
         iLtslCCYgFn0WaaK7IhR+CihZiqvIwNWlqF60i3xOVcdcn6RqDa1+25ILfWuiYDBV+eI
         oWMHTTpoiESTnQRP5gAjAtwfXMqINTnq69KnvQ/p6HvoBoYlw+tBhmxqHfdx2lNazLJh
         hz7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749234071; x=1749838871;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tP/wQPBGjbbKyfTZfIc/iAV9m6jQ7fU2q5ZDYkmBio0=;
        b=nRKERnyP1IDh9zZgEjDJ9ATVOsTzOT2JbnM0DBV/9oHW+oMWfXH20zmiQ8Xk1AC/cc
         Vm/S9xecfDHOVZV3mJKU4qnWDViqg1QiNVmgsGERZzGJy8OuN81CoBhtDxvH/iJLnQnH
         rzpWkqiqYQMQEjj1VDyn4WIlVI00r4lGG7a18biW7cZ8qXPyvC36aTTtGwZArwxYDoni
         wL831+jlD3zHA+6ILRGUHriTBSBOAs6LD4dJ3lhqqBtElNqzC3RD/5EFzBvYbRxM1Ww+
         yQiDsuH+2vZHho+/jqsHQO33+Bpl6rS30BEkFHmCAPWHa97APMlGzlYk19ONFdj6bPpW
         4ZMA==
X-Forwarded-Encrypted: i=1; AJvYcCWHdvtfphM7ZFmeuCfO/3XP9EWgst5uFvNJmXa6AnWHZDYIFXj/uLHQL9laNCQsODgmskY1HMb4AT4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKzawCY8XY9912tRKKYH5SD9AJVjOCqEInUyTUFHg5q+F5HvhJ
	2tkO53ZAyTgfkhDVgG429UjfMjfeyYObycU+Es7067SUPWyct6LERy+pCwa83g==
X-Gm-Gg: ASbGncuMxytvlZPWANkWxKEsI98M+00zlNCOjuMiHn0Gksm6qAmzt7tTE5y8ZNtfbhQ
	SwZylq3LLSslIxWxCOXuEEgQpzqIWMAkfg+6cVC1DEGz4Uc0r5w9hvcs5uQTCL/UIspXx4ehEud
	eqFbsDRDteYDQcTtCie3RyvBrwRePSP3j2uThT85CfIm5pAwA55DwtH876jPq/QcRJK5ThOkPup
	HEzH+CTtD4ne75LiXqfOffI8vDdB0QwAMGXv40cS6f5vfTbm6ycpLzFOOYQPHqvhThnd6Cnx0WA
	RcgCtVs7hjOTCDeufWwrPJ8YrJbxOZn59toq6PIb2aibEPAeYOD2LfmN
X-Google-Smtp-Source: AGHT+IEQKwEx2+/rddCXUF2Qea6AEuSEJ2Z4uB4eLOdmdV0gZL/ozRb0PlKzXwtLOLvwFDwZQdiaXw==
X-Received: by 2002:a05:6a20:3d8a:b0:215:e9ec:81d2 with SMTP id adf61e73a8af0-21ee686173bmr6007354637.32.1749234070773;
        Fri, 06 Jun 2025 11:21:10 -0700 (PDT)
Received: from debian ([2601:646:8f03:9fee:5e33:e006:dcd5:852d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482b091cc3sm1612701b3a.106.2025.06.06.11.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 11:21:10 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Fri, 6 Jun 2025 11:21:08 -0700
To: anisa.su887@gmail.com
Cc: qemu-devel@nongnu.org, Jonathan.Cameron@huawei.com, nifan.cxl@gmail.com,
	dave@stgolabs.net, linux-cxl@vger.kernel.org,
	Anisa Su <anisa.su@samsung.com>
Subject: Re: [QEMU PATCH v3 8/9] cxl-mailbox-utils: 0x5604 - FMAPI Initiate
 DC Add
Message-ID: <aEMxlAvukxhWXhw1@debian>
References: <20250605234227.970187-1-anisa.su887@gmail.com>
 <20250605234227.970187-9-anisa.su887@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250605234227.970187-9-anisa.su887@gmail.com>

On Thu, Jun 05, 2025 at 11:42:22PM +0000, anisa.su887@gmail.com wrote:
> From: Anisa Su <anisa.su@samsung.com>
> 
> FM DCD Management command 0x5604 implemented per CXL r3.2 Spec Section 7.6.7.6.5
> 
> Signed-off-by: Anisa Su <anisa.su@samsung.com>

See below...

> ---
>  hw/cxl/cxl-mailbox-utils.c  | 152 ++++++++++++++++++++++++++++++++++++
>  hw/mem/cxl_type3.c          |   8 +-
>  include/hw/cxl/cxl_device.h |   4 +
>  3 files changed, 160 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 004e502b22..7ee5be00bc 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -123,6 +123,7 @@ enum {
>          #define GET_HOST_DC_REGION_CONFIG   0x1
>          #define SET_DC_REGION_CONFIG        0x2
>          #define GET_DC_REGION_EXTENT_LIST   0x3
> +        #define INITIATE_DC_ADD             0x4
>  };
>  
>  /* CCI Message Format CXL r3.1 Figure 7-19 */
> @@ -3540,6 +3541,150 @@ static CXLRetCode cmd_fm_get_dc_region_extent_list(const struct cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
>  
> +static void cxl_mbox_dc_add_to_pending(CXLType3Dev *ct3d,

This naming can be improved here, not straightforward to me.
Maybe cxl_add_extents_to_pending_list() ?

> +                                       uint32_t ext_count,
> +                                       CXLDCExtentRaw extents[])
> +{
> +    CXLDCExtentGroup *group = NULL;
> +    int i;
> +
> +    for (i = 0; i < ext_count; i++) {
> +        group = cxl_insert_extent_to_extent_group(group,
> +                                                  extents[i].start_dpa,
> +                                                  extents[i].len,
> +                                                  extents[i].tag,
> +                                                  extents[i].shared_seq);
> +    }
> +
> +    cxl_extent_group_list_insert_tail(&ct3d->dc.extents_pending, group);
> +    ct3d->dc.total_extent_count += ext_count;
> +}

Also the code is duplicate with existing code in cxl_type3.c 
qmp_cxl_process_dynamic_capacity_prescriptive(). 
The function was simulating the behaviour of the mailbox command, so it is
behaviour will be smilar to what we have in this patch, 
find a way to reuse code, maybe extract common code as a helper function and use
it in both qmp interface and here.

> +
> +static void cxl_mbox_create_dc_event_records_for_extents(CXLType3Dev *ct3d,
cxl_create_dc_extent_records_for extents()?
> +                                                         CXLDCEventType type,
> +                                                         CXLDCExtentRaw extents[],
> +                                                         uint32_t ext_count)
> +{
> +    CXLEventDynamicCapacity event_rec = {};
> +    int i;
> +
> +    cxl_assign_event_header(&event_rec.hdr,
> +                            &dynamic_capacity_uuid,
> +                            (1 << CXL_EVENT_TYPE_INFO),
> +                            sizeof(event_rec),
> +                            cxl_device_get_timestamp(&ct3d->cxl_dstate));
> +    event_rec.type = type;
> +    event_rec.validity_flags = 1;
> +    event_rec.host_id = 0;
> +    event_rec.updated_region_id = 0;
> +    event_rec.extents_avail = CXL_NUM_EXTENTS_SUPPORTED -
> +                              ct3d->dc.total_extent_count;
> +
> +    for (i = 0; i < ext_count; i++) {
> +        memcpy(&event_rec.dynamic_capacity_extent,
> +               &extents[i],
> +               sizeof(CXLDCExtentRaw));
> +        event_rec.flags = 0;
> +        if (i < ext_count - 1) {
> +            /* Set "More" flag */
> +            event_rec.flags |= BIT(0);
> +        }
> +
> +        if (cxl_event_insert(&ct3d->cxl_dstate,
> +                             CXL_EVENT_TYPE_DYNAMIC_CAP,
> +                             (CXLEventRecordRaw *)&event_rec)) {
> +            cxl_event_irq_assert(ct3d);
> +        }
> +    }
> +}

Some issue here. A lot of duplicate code compared to
qmp_cxl_process_dynamic_capacity_prescriptive.

> +
> +/*
> + * Helper function to convert CXLDCExtentRaw to CXLUpdateDCExtentListInPl
> + * in order to reuse cxl_detect_malformed_extent_list() functin which accepts
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
> +    CXLUpdateDCExtentListInPl *list;
> +    int i, rc;
> +
> +    switch (in->selection_policy) {
> +    case CXL_EXTENT_SELECTION_POLICY_PRESCRIPTIVE:
> +        /* Adding extents exceeds device's extent tracking ability. */
> +        if (in->ext_count + ct3d->dc.total_extent_count >
> +            CXL_NUM_EXTENTS_SUPPORTED) {
> +            return CXL_MBOX_RESOURCES_EXHAUSTED;
> +        }
> +
> +        list = calloc(1, (sizeof(*list) +
> +                          in->ext_count * sizeof(*list->updated_entries)));

Use g_malloc() and g_free().

> +        convert_raw_extents(in->extents, list, in->ext_count);
> +        rc = cxl_detect_malformed_extent_list(ct3d, list);
> +
> +        for (i = 0; i < in->ext_count; i++) {
> +            CXLDCExtentRaw ext = in->extents[i];
> +             /* Check requested extents do not overlap with pending extents. */
> +            if (cxl_extent_groups_overlaps_dpa_range(&ct3d->dc.extents_pending,
> +                                                     ext.start_dpa, ext.len)) {
> +                return CXL_MBOX_INVALID_EXTENT_LIST;
> +            }
> +            /* Check requested extents do not overlap with existing extents. */
> +            if (cxl_extents_overlaps_dpa_range(&ct3d->dc.extents,
> +                                               ext.start_dpa, ext.len)) {
> +                return CXL_MBOX_INVALID_EXTENT_LIST;
> +            }
> +        }
> +
> +        if (rc) {
> +            return rc;
> +        }
> +
> +        cxl_mbox_dc_add_to_pending(ct3d, in->ext_count, in->extents);
> +        cxl_mbox_create_dc_event_records_for_extents(ct3d,
> +                                                     DC_EVENT_ADD_CAPACITY,
> +                                                     in->extents,
> +                                                     in->ext_count);
> +
> +        return CXL_MBOX_SUCCESS;
> +    default:
> +        qemu_log_mask(LOG_UNIMP,
> +                      "CXL extent selection policy not supported.\n");
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +

For all the case to return, instead of return directly set return code and jump
here, do two things:
1. g_free(list);
2. return rt;

Fan

> +    return CXL_MBOX_SUCCESS;
> +}
> +
>  static const struct cxl_cmd cxl_cmd_set[256][256] = {
>      [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
>          cmd_infostat_bg_op_abort, 0, 0 },
> @@ -3667,6 +3812,13 @@ static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
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
> index ee554a77be..ca9fe89e4f 100644
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
> index 76af75d2d0..d30f6503fa 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -724,4 +724,8 @@ bool ct3_test_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
>  void cxl_assign_event_header(CXLEventRecordHdr *hdr,
>                               const QemuUUID *uuid, uint32_t flags,
>                               uint8_t length, uint64_t timestamp);
> +bool cxl_extents_overlaps_dpa_range(CXLDCExtentList *list,
> +                                    uint64_t dpa, uint64_t len);
> +bool cxl_extent_groups_overlaps_dpa_range(CXLDCExtentGroupList *list,
> +                                          uint64_t dpa, uint64_t len);
>  #endif
> -- 
> 2.47.2
> 
