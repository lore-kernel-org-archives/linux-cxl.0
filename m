Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C881A83FB
	for <linux-cxl@vger.kernel.org>; Tue, 20 May 2025 18:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747764500; cv=none; b=Zi2yoF4ikfCIi7c0vki9Th7d8c3ghdDD5cy3c5ETpFSdvFseCAV+gtst83yzbwKq3HhcBnfzSRrARNqbqCtwGKh3NVPiPCkTnPDFIxr+Mg7dZEMLkdh/80hyuAPBT7y/Vqi3zndOo5qu3wdYTdhTLLkRf+yOV3pXIi4VtlKMwco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747764500; c=relaxed/simple;
	bh=UYiAF+1vgaILA6BD0u70V0tLLC0uyiweaV+QbTAJo0k=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mNPIRmwGRH3cFHd63jBmalLjdgrEMs7VhPIOENDym4ggRS8QSBPLoQqWl5KKgrGGOrB3v1FqDNOOluBOcejUfEaNC6i60xzmt3GIXCvzFtjNm3J5MMKl5lov/aKrauyXbX5N2/zeqLDzIRFBcN2RxKSlV7larbHfLQeYrJ729wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EKHnCEA4; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EKHnCEA4"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-742c96af71dso3689895b3a.0
        for <linux-cxl@vger.kernel.org>; Tue, 20 May 2025 11:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747764496; x=1748369296; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FGZOIKDHXfmlCpUXnw2zM5I9TqK9NU7ayWgoiqsfGqQ=;
        b=EKHnCEA4v176u9wVrKFR8LSaKU8tFKUiQyU9tgAw57vmv16EDN54b3HaHPMeOqSJbj
         9cQCbiCsxJ6xqtk1zxeSM0u2UeRUV5iZ28HfLMQntnmz+6RExQUcRhhKR5JlDwzUs3mt
         N6XYp+s/QqYM9Ku80mB96ijmBTyLl7d2FhIKvG1fNv2e0pnNL8QfQCxVomAjScG7L+g8
         RycTFEn+dRbs8prRqc4zzb6P4qM0r3g5IPlHWs73bNGI2kdVA6dA9eLwvl4R2RnH0kOa
         bHQ2urkGZ1el2mF0Y6hlihBz9oNEU4M661BietlngjHj2b/rEoW2Au7V+qsAzWSgmuyH
         NbIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747764496; x=1748369296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FGZOIKDHXfmlCpUXnw2zM5I9TqK9NU7ayWgoiqsfGqQ=;
        b=Xn7lYkGNQAx8p6KKOb2DXYUkd7xCOXdV1x3XyWcMbPFnulTJ9ZjtLLVPPVfI6xJVxV
         15+hYzoJ3GXrcV9kTHk3r+d/Hf6L0L+UirYAhSzrLIs9S6/gO9oRrWnztAb+Y6zOnmo0
         Iehb19ZYJMIxgoN1W7ugybjqErROA6O5nix2t9FFeDGVQtj1pHCyAJePYwXSQXyMK0Ej
         rAmv8xP70YF4mFWyyHu13MW9U6c51mgtS3SFtXEEKOyr0mTFNUtri5rNPetae+ILTmEi
         VSFOb2GUz0okGURf9/Ya6Hs2haLSeBea15jr40T8c733HANbL0E4Q3vURchEpa9jKzm+
         8LDw==
X-Forwarded-Encrypted: i=1; AJvYcCWT4mo/4J8R7JTUh4bheBWBRoc8mbnriLmStuuGjuVyvgvoCXUxHhEq6YQhg15p49tCsdZD+FCiR2U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvumxnJFP00xOt3pB4h9O7rhJMkkqs5ll4sTlITgjLGYDyOvik
	MnuGpI6aYRrKIiyfD4LG++HI7SrAPYVpI3FkqQpH4GcDIrSE2KvQmfAr
X-Gm-Gg: ASbGncv1rGsGG7dZTdWgMfjc/bzo+2AoBwrk4v+aJ+S/dBIR3uWpFsUeIDx92cV5krb
	Z1XjBOXHve0jGxy+dvT5pLomCitIzUJcdtLtHpY9NiYjG/klx6wtTVnOwyj16Z8P3RidkrKTlLN
	FQbuPieaqWkamxEUiylBR2Jcue54Z7P2CUvZYlPJrnZ90UY/MjHsTjeVPVrIzZdmi+BX3+OqdfO
	Ymgh/unF1UOyuc2BphufYlBYFqkRcD4Tf90XkvwVXvJyHjXZXjJMSHPgx6ytzdswVo0qU18CrKb
	z1E8Lc1CkTXFYNn+Ezw3MmuWlYAcWJD6PBpaMddCTQ==
X-Google-Smtp-Source: AGHT+IEjlGtC8XDja5CbbL/XfYOy/ih8P9vPo+gLIc2jmZoqHOefGAxAqq0KsiPIy8MhoVCWrlSxjg==
X-Received: by 2002:a05:6a20:3d12:b0:1f5:59e5:8ada with SMTP id adf61e73a8af0-2162187a945mr24644341637.4.1747764496008;
        Tue, 20 May 2025 11:08:16 -0700 (PDT)
Received: from lg ([2601:646:8f03:9fee:2c89:c0cf:1cbd:96d3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eaf8ead7sm8292634a12.46.2025.05.20.11.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 11:08:15 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Tue, 20 May 2025 11:08:13 -0700
To: anisa.su887@gmail.com
Cc: qemu-devel@nongnu.org, Jonathan.Cameron@huawei.com, nifan.cxl@gmail.com,
	dave@stgolabs.net, linux-cxl@vger.kernel.org,
	Anisa Su <anisa.su@samsung.com>
Subject: Re: [PATCH v2 09/10] cxl-mailbox-utils: 0x5604 - FMAPI Initiate DC
 Add
Message-ID: <aCzFDaVWQoclyR0l@lg>
References: <20250508001754.122180-1-anisa.su887@gmail.com>
 <20250508001754.122180-10-anisa.su887@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508001754.122180-10-anisa.su887@gmail.com>

On Thu, May 08, 2025 at 12:01:05AM +0000, anisa.su887@gmail.com wrote:
> From: Anisa Su <anisa.su@samsung.com>
> 
> FM DCD Management command 0x5604 implemented per CXL r3.2 Spec Section 7.6.7.6.5
> 

This patch needs to fix. See comments below.

> Signed-off-by: Anisa Su <anisa.su@samsung.com>
> ---
>  hw/cxl/cxl-mailbox-utils.c   | 195 +++++++++++++++++++++++++++++++++++
>  hw/mem/cxl_type3.c           |   8 +-
>  include/hw/cxl/cxl_device.h  |   4 +
>  include/hw/cxl/cxl_opcodes.h |   1 +
>  4 files changed, 204 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index a897a34ef9..9b176dea08 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -3589,6 +3589,194 @@ static CXLRetCode cmd_fm_get_dc_region_extent_list(const struct cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
>  
> +static CXLRetCode cxl_mbox_dc_prescriptive_sanity_check(CXLType3Dev *dcd,
> +                                                        uint16_t host_id,
> +                                                        uint32_t ext_count,
> +                                                        CXLDCExtentRaw extents[],
> +                                                        CXLDCEventType type)
> +{
> +    CXLDCExtentRaw ext;
> +    CXLDCRegion *reg = NULL;
> +    int i, j;
> +
> +    if (host_id != 0) {
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +
> +    for (i = 0; i < ext_count; i++) {
> +        ext = extents[i];
> +
> +        if (ext.len == 0) {
> +            return CXL_MBOX_INVALID_EXTENT_LIST;
> +        }
> +
> +        reg = cxl_find_dc_region(dcd, ext.start_dpa, ext.len);
> +        if (!reg) {
> +            return CXL_MBOX_INVALID_EXTENT_LIST;
> +        }
> +
> +        if (ext.len % reg->block_size || ext.start_dpa % reg->block_size) {
> +            return CXL_MBOX_INVALID_EXTENT_LIST;
> +        }
> +
> +        /* Check requested extents do not overlap with each other. */
> +        for (j = i + 1; j < ext_count; j++) {
> +            if (ranges_overlap(ext.start_dpa, ext.len, extents[j].start_dpa,
> +                               extents[j].len)) {
> +                return CXL_MBOX_INVALID_EXTENT_LIST;
> +            }
> +        }
> +
> +        if (type == DC_EVENT_ADD_CAPACITY) {
> +            /* Check requested extents do not overlap with pending extents. */
> +            if (cxl_extent_groups_overlaps_dpa_range(&dcd->dc.extents_pending,
> +                ext.start_dpa, ext.len)) {
> +                return CXL_MBOX_INVALID_EXTENT_LIST;
> +            }
> +            /* Check requested extents do not overlap with existing extents. */
> +            if (cxl_extents_overlaps_dpa_range(&dcd->dc.extents,
> +                                               ext.start_dpa, ext.len)) {
> +                return CXL_MBOX_INVALID_EXTENT_LIST;
> +            }
> +        }
> +    }
> +
> +    return CXL_MBOX_SUCCESS;
> +}

Per the spec, we need to detect resource exhausted case.
"The command shall fail with Resources Exhausted if the Extent List would cause the
device to exceed its extent or tag tracking ability."

We need to make sure the total number of extents does not exceed the max
number of extents the device can maintain.


> +
> +static int cxl_mbox_get_pending_ext_count(CXLType3Dev *ct3d)
> +{
> +    CXLDCExtentGroup *group;
> +    CXLDCExtentList *list;
> +    CXLDCExtent *ent;
> +    int count = 0;
> +
> +    QTAILQ_FOREACH(group, &ct3d->dc.extents_pending, node) {
> +        list = &group->list;
> +        QTAILQ_FOREACH(ent, list, node) {
> +            count++;
> +        }
> +    }
> +
> +    return count;
> +}
> +
> +static int cxl_mbox_get_accepted_ext_count(CXLType3Dev *ct3d)
> +{
> +    CXLDCExtent *ent;
> +    int count = 0;
> +
> +    QTAILQ_FOREACH(ent, &ct3d->dc.extents, node) {
> +        count++;
> +    }
> +
> +    return count;
> +}
ct3d->total_extent_count is used to record number of accepted
extents.
So in below, the code logic is not correct.
> +
> +static void cxl_mbox_dc_add_to_pending(CXLType3Dev *ct3d,
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
> +}
> +
> +static void cxl_mbox_create_dc_event_records_for_extents(CXLType3Dev *ct3d,
> +                                                         CXLDCEventType type,
> +                                                         CXLDCExtentRaw extents[],
> +                                                         uint32_t ext_count)
> +{
> +    CXLEventDynamicCapacity event_rec = {};
> +    int i;
> +
> +    cxl_mbox_dc_event_create_record_hdr(ct3d, &event_rec.hdr);
> +    event_rec.type = type;
> +    event_rec.validity_flags = 1;
> +    event_rec.host_id = 0;
> +    event_rec.updated_region_id = 0;
> +    event_rec.extents_avail = ct3d->dc.total_extent_count -
> +                              cxl_mbox_get_accepted_ext_count(ct3d) -
> +                              cxl_mbox_get_pending_ext_count(ct3d);

This is not right.

As I mentioned total_extent_count only accounts for accepted extents
today.
Also, max number of extents to track is hardcoded to
CXL_NUM_EXTENTS_SUPPORTED.

The value for the above shoud be consistent with what we return for
command 5601h or 4800h.

Based on the spec cxl r3.2 9.13.3.3 Extent list Tracking.
We should take pending extents into account when considering the
tracking ability. So after this series gets in, we need to fix
"num_extents_available" field for 4800h.
Or a easier way, take pending list counting into total_extent_count.


Fan
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
> +    int rc;
> +
> +    switch (in->selection_policy) {
> +    case CXL_EXTENT_SELECTION_POLICY_PRESCRIPTIVE:
> +        /* Adding extents exceeds device's extent tracking ability. */
> +        if (in->ext_count + ct3d->dc.total_extent_count >
> +            CXL_NUM_EXTENTS_SUPPORTED) {
> +            return CXL_MBOX_RESOURCES_EXHAUSTED;
> +        }
> +        rc = cxl_mbox_dc_prescriptive_sanity_check(ct3d,
> +                                                   in->host_id,
> +                                                   in->ext_count,
> +                                                   in->extents,
> +                                                   DC_EVENT_ADD_CAPACITY);
> +        if (rc) {
> +            return rc;
> +        }
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
> +    return CXL_MBOX_SUCCESS;
> +}
> +
>  static const struct cxl_cmd cxl_cmd_set[256][256] = {
>      [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
>          cmd_infostat_bg_op_abort, 0, 0 },
> @@ -3724,6 +3912,13 @@ static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
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
> index edc29f1ccb..71fad3391c 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -1991,8 +1991,8 @@ void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
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
> @@ -2037,8 +2037,8 @@ bool cxl_extents_contains_dpa_range(CXLDCExtentList *list,
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
> index 22823e2054..93b6df0ccd 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -824,4 +824,8 @@ bool ct3_test_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
>  void cxl_assign_event_header(CXLEventRecordHdr *hdr,
>                               const QemuUUID *uuid, uint32_t flags,
>                               uint8_t length, uint64_t timestamp);
> +bool cxl_extents_overlaps_dpa_range(CXLDCExtentList *list,
> +                                    uint64_t dpa, uint64_t len);
> +bool cxl_extent_groups_overlaps_dpa_range(CXLDCExtentGroupList *list,
> +                                          uint64_t dpa, uint64_t len);
>  #endif
> diff --git a/include/hw/cxl/cxl_opcodes.h b/include/hw/cxl/cxl_opcodes.h
> index ad4e614daa..72ea0a7d44 100644
> --- a/include/hw/cxl/cxl_opcodes.h
> +++ b/include/hw/cxl/cxl_opcodes.h
> @@ -66,5 +66,6 @@ enum {
>          #define GET_HOST_DC_REGION_CONFIG 0x1
>          #define SET_DC_REGION_CONFIG 0x2
>          #define GET_DC_REGION_EXTENT_LIST 0x3
> +        #define INITIATE_DC_ADD           0x4
>      GLOBAL_MEMORY_ACCESS_EP_MGMT = 0X59
>  };
> -- 
> 2.47.2
> 

-- 
Fan Ni
