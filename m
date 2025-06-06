Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A0528A702
	for <linux-cxl@vger.kernel.org>; Fri,  6 Jun 2025 17:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749231056; cv=none; b=CEvrga4DcZuli6IrVEG94dj4/NyIIN4wncuk/8IKmGwXKAFiRYVQQFvBQ15BjOaUETVCPhRreunxTwrjBwO59cu76SHCcvj0Yf0TZrUa80Lnu9BMtrO5dC2VxN+lGcZvA5XOGb9a745sIlz1oDiqCUsCa1vy1XZRyzacO3P49vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749231056; c=relaxed/simple;
	bh=AeTjaRTFQDRB9uyO58eofZZb0BCGQATpJTDqmIkIiUY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OrtWj/8i4IrB0ypvGrx8nP8IxXVikulWEDBYF92g/pa3dGM1Lhv7UFbecFghwqrsZVDvrLK9f8s1AkjgqBbCLDx9fGbrDj50P5mb5AWP5IfM6N1OLpVRVj0fxWtWs7IKExso+eRXNyC2+rz8ch7044w9QAry+u8RCRe2RM4xH/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cEQRQ+ws; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cEQRQ+ws"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-31332cff2d5so1709116a91.1
        for <linux-cxl@vger.kernel.org>; Fri, 06 Jun 2025 10:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749231054; x=1749835854; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CxdNKgrqZ4mlo4Y16FRnlcHMC/6R6WSdYbc8k3t07Ig=;
        b=cEQRQ+wsuApFyrX+Z5SetsgmRvSd/wW7l6jbDFpz3UZrqveBJ0nqCNyaclfTrddxwN
         rH88KvhFZTDNWrRBvP4L91nUJ5RGKUjGPJYbDP3VG1vGQbMEVhn7Q4Zf5d+xZOzL8/P1
         1gJN+6HwKbc1WxSewjstJfYiuapGCizANm+QGhTKk4hdB90dj22W2nYLQ8bTIc20uKDw
         7MXYjPb1hZB+AgZybSdYtBZd69wejANsxwBGJPtJc1ahBvRM2HJVr6JcUf4psXOTCxTx
         T2XPnDQEuGleuiUqrw51VzS1W8aDP6rQjiodtyYXqfkKGJ8j1VUyhWSMddZTEynWFTZx
         yxZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749231054; x=1749835854;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CxdNKgrqZ4mlo4Y16FRnlcHMC/6R6WSdYbc8k3t07Ig=;
        b=eUD0s6jDWLyte7QciUfXu+4/sK2FOXmn2Ra3aMVaaYnkOKHCyskt/ZaFLxHfUFgiBp
         2SkqIQsSeV7SutC+wLvou1nPI6A9wbNJ+7UyGlHZ7idU/0Pd6yIOK5916WPyWjH5hrTl
         vS+k4plVRaEr1R8zuxYY/JjscxwiBI0dRI3BtvdFCIr7cWINidq8oT4EcRTDeSx6zcBP
         JkJxrRsfNh1JxInT1FXczzmrgY4HnO1FxucH69EUzXqYwZVRCHAzFLXR4ehlDK81Jtnk
         kHFe/+piQJWGvBJRaGS+hB4D5yetvgO34Cf7BNabn7vfbJIeBr2BGgVuPFmcEsYUgcfT
         o13A==
X-Forwarded-Encrypted: i=1; AJvYcCWgGzvarkpNQzQh7t9BW+6sTEPfvi6eLv4Rvp48Tb06Jqro56TWMbD+8+792L4in7tTogB5go/EkZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzza0uG9uCDN5GQ+DZzrNT2jdNjRL6Zu5c4a/PRDL+odXUDLip
	+BtzMJ2RjuXTSapOAzaa2+mHPF0Hy8rkf/S0S8ODk5WuYk7lCSg2o/3T1ogc7Q==
X-Gm-Gg: ASbGncsci8uNmZIvabA6aZ2mOoEavpPbYWF5OAIJ6HleDxawJy9SaPv72dPcdnNqZ/t
	2sWXjYXWqx5MxZaFFGz1OiYc76su3BVO1E0HvNo/ulUOJIMGZ54/OcfvjJh1jIFpOtbjSjAwKqs
	BWbaQ8OR776qSklRVHcQVXJzaQ99nMacfV0lQQXa3swTq5fQ2oCNg6UkBapNfyWfW6+ZzkIPlPM
	f1YKfVsYb63/7Wev40RG/3DxAAv7wLYLwt/wWqwcxffAm+lNeD1Q8He2BDFE2puZBYmIQwfYMrZ
	0NosQZAv+v3e2r1HRGZiqPxae9pT2rR5zlNSQ0S+45MdGjk4vzy2yEpJBSX45RBpG1KVTiO+I/f
	Jig==
X-Google-Smtp-Source: AGHT+IFOzMA5Cqnh+K6VMneGojR2gXXdnew3bx5tBfjGhADyY6uKkwBXeWQzURg0+3lzGnsa85lbJA==
X-Received: by 2002:a17:90b:4990:b0:2fa:157e:c790 with SMTP id 98e67ed59e1d1-31346b0411emr5629239a91.5.1749231053576;
        Fri, 06 Jun 2025 10:30:53 -0700 (PDT)
Received: from deb-101020-bm01.eng.stellus.in ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31349fdfe58sm1562497a91.38.2025.06.06.10.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 10:30:53 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Fri, 6 Jun 2025 17:30:51 +0000
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: anisa.su887@gmail.com, qemu-devel@nongnu.org,
	Jonathan.Cameron@huawei.com, nifan.cxl@gmail.com, dave@stgolabs.net,
	linux-cxl@vger.kernel.org
Subject: Re: [QEMU PATCH v3 8/9] cxl-mailbox-utils: 0x5604 - FMAPI Initiate
 DC Add
Message-ID: <aEMly5F8kdziHWzO@deb-101020-bm01.eng.stellus.in>
References: <20250605234227.970187-1-anisa.su887@gmail.com>
 <20250605234227.970187-9-anisa.su887@gmail.com>
 <09aea84f-8c3f-4321-879d-35c8956b3573@oracle.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09aea84f-8c3f-4321-879d-35c8956b3573@oracle.com>

On Fri, Jun 06, 2025 at 06:12:19PM +0530, ALOK TIWARI wrote:
> 
> 
> On 06-06-2025 05:12, anisa.su887@gmail.com wrote:
> > From: Anisa Su <anisa.su@samsung.com>
> > 
> > FM DCD Management command 0x5604 implemented per CXL r3.2 Spec Section 7.6.7.6.5
> > 
> > Signed-off-by: Anisa Su <anisa.su@samsung.com>
> > ---
> >   hw/cxl/cxl-mailbox-utils.c  | 152 ++++++++++++++++++++++++++++++++++++
> >   hw/mem/cxl_type3.c          |   8 +-
> >   include/hw/cxl/cxl_device.h |   4 +
> >   3 files changed, 160 insertions(+), 4 deletions(-)
> > 
> > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > index 004e502b22..7ee5be00bc 100644
> > --- a/hw/cxl/cxl-mailbox-utils.c
> > +++ b/hw/cxl/cxl-mailbox-utils.c
> > @@ -123,6 +123,7 @@ enum {
> >           #define GET_HOST_DC_REGION_CONFIG   0x1
> >           #define SET_DC_REGION_CONFIG        0x2
> >           #define GET_DC_REGION_EXTENT_LIST   0x3
> > +        #define INITIATE_DC_ADD             0x4
> >   };
> >   /* CCI Message Format CXL r3.1 Figure 7-19 */
> > @@ -3540,6 +3541,150 @@ static CXLRetCode cmd_fm_get_dc_region_extent_list(const struct cxl_cmd *cmd,
> >       return CXL_MBOX_SUCCESS;
> >   }
> > +static void cxl_mbox_dc_add_to_pending(CXLType3Dev *ct3d,
> > +                                       uint32_t ext_count,
> > +                                       CXLDCExtentRaw extents[])
> > +{
> > +    CXLDCExtentGroup *group = NULL;
> > +    int i;
> > +
> > +    for (i = 0; i < ext_count; i++) {
> > +        group = cxl_insert_extent_to_extent_group(group,
> > +                                                  extents[i].start_dpa,
> > +                                                  extents[i].len,
> > +                                                  extents[i].tag,
> > +                                                  extents[i].shared_seq);
> > +    }
> > +
> > +    cxl_extent_group_list_insert_tail(&ct3d->dc.extents_pending, group);
> > +    ct3d->dc.total_extent_count += ext_count;
> > +}
> > +
> > +static void cxl_mbox_create_dc_event_records_for_extents(CXLType3Dev *ct3d,
> > +                                                         CXLDCEventType type,
> > +                                                         CXLDCExtentRaw extents[],
> > +                                                         uint32_t ext_count)
> > +{
> > +    CXLEventDynamicCapacity event_rec = {};
> > +    int i;
> > +
> > +    cxl_assign_event_header(&event_rec.hdr,
> > +                            &dynamic_capacity_uuid,
> > +                            (1 << CXL_EVENT_TYPE_INFO),
> > +                            sizeof(event_rec),
> > +                            cxl_device_get_timestamp(&ct3d->cxl_dstate));
> > +    event_rec.type = type;
> > +    event_rec.validity_flags = 1;
> > +    event_rec.host_id = 0;
> > +    event_rec.updated_region_id = 0;
> > +    event_rec.extents_avail = CXL_NUM_EXTENTS_SUPPORTED -
> > +                              ct3d->dc.total_extent_count;
> > +
> > +    for (i = 0; i < ext_count; i++) {
> > +        memcpy(&event_rec.dynamic_capacity_extent,
> > +               &extents[i],
> > +               sizeof(CXLDCExtentRaw));
> > +        event_rec.flags = 0;
> > +        if (i < ext_count - 1) {
> > +            /* Set "More" flag */
> > +            event_rec.flags |= BIT(0);
> > +        }
> > +
> > +        if (cxl_event_insert(&ct3d->cxl_dstate,
> > +                             CXL_EVENT_TYPE_DYNAMIC_CAP,
> > +                             (CXLEventRecordRaw *)&event_rec)) {
> > +            cxl_event_irq_assert(ct3d);
> > +        }
> > +    }
> > +}
> > +
> > +/*
> > + * Helper function to convert CXLDCExtentRaw to CXLUpdateDCExtentListInPl
> > + * in order to reuse cxl_detect_malformed_extent_list() functin which accepts
> 
> typo functin
> 
> > + * CXLUpdateDCExtentListInPl as a parameter.
> > + */
> > +static void convert_raw_extents(CXLDCExtentRaw raw_extents[],
> > +                                CXLUpdateDCExtentListInPl *extent_list,
> > +                                int count)
> > +{
> > +    int i;
> > +
> > +    extent_list->num_entries_updated = count;
> > +
> > +    for (i = 0; i < count; i++) {
> > +        extent_list->updated_entries[i].start_dpa = raw_extents[i].start_dpa;
> > +        extent_list->updated_entries[i].len = raw_extents[i].len;
> > +    }
> > +}
> > +
> > +/* CXL r3.2 Section 7.6.7.6.5 Initiate Dynamic Capacity Add (Opcode 5604h) */
> > +static CXLRetCode cmd_fm_initiate_dc_add(const struct cxl_cmd *cmd,
> > +                                         uint8_t *payload_in,
> > +                                         size_t len_in,
> > +                                         uint8_t *payload_out,
> > +                                         size_t *len_out,
> > +                                         CXLCCI *cci)
> > +{
> > +    struct {
> > +        uint16_t host_id;
> > +        uint8_t selection_policy;
> > +        uint8_t reg_num;
> > +        uint64_t length;
> > +        uint8_t tag[0x10];
> > +        uint32_t ext_count;
> > +        CXLDCExtentRaw extents[];
> > +    } QEMU_PACKED *in = (void *)payload_in;
> > +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> > +    CXLUpdateDCExtentListInPl *list;
> > +    int i, rc;
> > +
> > +    switch (in->selection_policy) {
> > +    case CXL_EXTENT_SELECTION_POLICY_PRESCRIPTIVE:
> > +        /* Adding extents exceeds device's extent tracking ability. */
> > +        if (in->ext_count + ct3d->dc.total_extent_count >
> > +            CXL_NUM_EXTENTS_SUPPORTED) {
> > +            return CXL_MBOX_RESOURCES_EXHAUSTED;
> > +        }
> > +
> > +        list = calloc(1, (sizeof(*list) +
> > +                          in->ext_count * sizeof(*list->updated_entries)));
> > +        convert_raw_extents(in->extents, list, in->ext_count);
> > +        rc = cxl_detect_malformed_extent_list(ct3d, list);
> > +
> > +        for (i = 0; i < in->ext_count; i++) {
> > +            CXLDCExtentRaw ext = in->extents[i];
> > +             /* Check requested extents do not overlap with pending extents. */
> > +            if (cxl_extent_groups_overlaps_dpa_range(&ct3d->dc.extents_pending,
> > +                                                     ext.start_dpa, ext.len)) {
> > +                return CXL_MBOX_INVALID_EXTENT_LIST;
> > +            }
> > +            /* Check requested extents do not overlap with existing extents. */
> > +            if (cxl_extents_overlaps_dpa_range(&ct3d->dc.extents,
> > +                                               ext.start_dpa, ext.len)) {
> > +                return CXL_MBOX_INVALID_EXTENT_LIST;
> > +            }
> > +        }
> > +
> > +        if (rc) {
> > +            return rc;
> 
> is list free not require ?
> 
oh yeah it's definitely required :( that was dumb of me, same for the
next patch.

Thanks for catching that!
-Anisa
> > +        }
> > +
> > +        cxl_mbox_dc_add_to_pending(ct3d, in->ext_count, in->extents);
> > +        cxl_mbox_create_dc_event_records_for_extents(ct3d,
> > +                                                     DC_EVENT_ADD_CAPACITY,
> > +                                                     in->extents,
> > +                                                     in->ext_count);
> > +
> > +        return CXL_MBOX_SUCCESS;
> > +    default:
> > +        qemu_log_mask(LOG_UNIMP,
> > +                      "CXL extent selection policy not supported.\n");
> > +        return CXL_MBOX_INVALID_INPUT;
> > +    }
> > +
> > +    return CXL_MBOX_SUCCESS;
> 
> CXL_MBOX_SUCCESS, this is unreachable
> 
> > +}
> > +
> >   static const struct cxl_cmd cxl_cmd_set[256][256] = {
> >       [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
> >           cmd_infostat_bg_op_abort, 0, 0 },
> > @@ -3667,6 +3812,13 @@ static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
> >            CXL_MBOX_IMMEDIATE_DATA_CHANGE) },
> >       [FMAPI_DCD_MGMT][GET_DC_REGION_EXTENT_LIST] = { "GET_DC_REGION_EXTENT_LIST",
> >           cmd_fm_get_dc_region_extent_list, 12, 0 },
> > +    [FMAPI_DCD_MGMT][INITIATE_DC_ADD] = { "INIT_DC_ADD",
> > +        cmd_fm_initiate_dc_add, ~0,
> > +        (CXL_MBOX_CONFIG_CHANGE_COLD_RESET |
> > +        CXL_MBOX_CONFIG_CHANGE_CONV_RESET |
> > +        CXL_MBOX_CONFIG_CHANGE_CXL_RESET |
> > +        CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
> > +        CXL_MBOX_IMMEDIATE_DATA_CHANGE) },
> >   };
> 
> 
> Thanks,
> Alok
