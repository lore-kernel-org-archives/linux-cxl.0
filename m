Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF9513329F
	for <linux-cxl@vger.kernel.org>; Tue, 16 Apr 2024 16:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713284843; cv=none; b=clTyn/NJZZOwu1K6AbG+vszoiTkLwnMs/buQw0/NA/Fpc91YCRckIxmiAoHYMCH0c2BP4FTONzbA52CATYDcACojbqwxHDPm6m/cwAnzawalMx8PlHjeWy9XC6/UlM7znc0q9X7iQ8RePP+5aaPn8zL8uX2uD5pcuGgXnF30ktQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713284843; c=relaxed/simple;
	bh=vJADZV05dA0ZIzyy+yg9r05kczyaLXq+URpajbQFUC8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cwyeR4LO7VbHerdBliOWQ1vPqjnWLfua2+bqvkDcOUd4YBsUr6SMHVYL0FPt3FxRN78NTYFOHmBtIYg5lAEoiHO8euI418ar6sehq+Hy8hJPFd2m29+o3pPA0sR4lIsxxt2KBOz/eAnfrvCQH1fjZrxWtoRCuKtxysAWRrwg+Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VU/yRtAS; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VU/yRtAS"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6ed2dc03df6so4100939b3a.1
        for <linux-cxl@vger.kernel.org>; Tue, 16 Apr 2024 09:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713284841; x=1713889641; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SBG/mQ4GfyCu+fuVFl2L3ZeD8uCGStI54PbBXpfreoY=;
        b=VU/yRtASJrlqe8wyXKq+hiZtZzTSQV84Fyv4sLQp5if9OS+JJGH2bsSdFj7B50e53l
         skqJmx4naeR5PTDIOYeprD1/d0c7Pa00L1sk0xrQJoi6rGoBKRucpRKRgwdHRipNFIj8
         Q+Q7XK/8s7iYZEWfXSzhIdsXz8uiFwhOEcSquuEWFdMpSM+05oPOmg5aWVcbR0qN5B+Z
         NA/HFjNC2ZnvRM3PKABcb5+OVxIzE1LzQoVMucb2/ofzh7NxqVkWe4/WTeCeBWrEgv71
         nX0YGjU7pz054ZWRQr1q9nmknGK2GUO6hz02IcLobgc8Ygxj4/EhltteBkWEkK2whe4s
         TIbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713284841; x=1713889641;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SBG/mQ4GfyCu+fuVFl2L3ZeD8uCGStI54PbBXpfreoY=;
        b=iscrqsSM/pHel/gtalkdm0lZDDN4WTYoiEcSRRXj17xDscMSnvRtYVmvs+iJStcX87
         EfCt4UI2P4AxUqHwQhU4mYTnBg221GIcz/cizqFx1XouLC+sB/W+qsEgJ9rQV/z9C6Zz
         TrGnc+FdZ05v64drqbwldlGvMv0aRLO25EO51b0TrGossPEqJd0FT5YQfTTbvLTxiRn6
         g3r4gBb+ktLJmosfGU1MXtjrwWNdB/I0WpkXwUJxDdZdfWVXnIQvVnWGg2MkF48WKRqG
         Ip5oPXDv0UitRN/DZmpDHw7XHgkKYnEf0w8BeDCb3InCqv66XfqyQ6EiCR2OjWsncdO1
         fJYA==
X-Forwarded-Encrypted: i=1; AJvYcCVXlFBK6tA+/ju0TgqXgcdNnsSlQW9hj7qFzek1wZrphsZfHgvYH1ApYrQOpXjVcN3rehcF5YJjIsL1aXDgDAMSOo4BNTvIdS10
X-Gm-Message-State: AOJu0YyLDDHiDylqPs3eyQoKhixWesfOxKhDK6ahOK3t0pouZOWBAABA
	hgarlmeRyJrewn3fa6+Ri8rN6PRhXj7NcJSBjqJxn1HghS2DkhDH
X-Google-Smtp-Source: AGHT+IHGJV5CAsGQuYftg0YM8Z3RHPvXox35s2OBpa48nnHBotCg/3bZwRMsN39fmE7KL5L2sFmjog==
X-Received: by 2002:a05:6a21:8cc7:b0:1aa:5a22:5eca with SMTP id ta7-20020a056a218cc700b001aa5a225ecamr1367732pzb.31.1713284840845;
        Tue, 16 Apr 2024 09:27:20 -0700 (PDT)
Received: from debian ([2601:641:300:14de:b278:701:b83f:cdc])
        by smtp.gmail.com with ESMTPSA id b25-20020a63a119000000b005e840ad9aaesm9037741pgf.30.2024.04.16.09.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 09:27:20 -0700 (PDT)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Tue, 16 Apr 2024 09:27:06 -0700
To: =?iso-8859-1?Q?J=F8rgen?= Hansen <Jorgen.Hansen@wdc.com>
Cc: fan <nifan.cxl@gmail.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"gregory.price@memverge.com" <gregory.price@memverge.com>,
	"ira.weiny@intel.com" <ira.weiny@intel.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"a.manzanares@samsung.com" <a.manzanares@samsung.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>,
	"nmtadam.samsung@gmail.com" <nmtadam.samsung@gmail.com>,
	"jim.harris@samsung.com" <jim.harris@samsung.com>,
	"wj28.lee@gmail.com" <wj28.lee@gmail.com>,
	Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v6 08/12] hw/cxl/cxl-mailbox-utils: Add mailbox commands
 to support add/release dynamic capacity response
Message-ID: <Zh6m2nRZEzxBhN2s@debian>
References: <20240325190339.696686-1-nifan.cxl@gmail.com>
 <20240325190339.696686-9-nifan.cxl@gmail.com>
 <9e4207aa-be50-40ca-9fda-30e4fabf6e98@wdc.com>
 <Zh1qRCV9EciuQsPi@debian>
 <7a530a19-58e7-4847-ad29-699fc9e11a4f@wdc.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7a530a19-58e7-4847-ad29-699fc9e11a4f@wdc.com>

On Tue, Apr 16, 2024 at 10:02:53AM +0000, Jørgen Hansen wrote:
> On 4/15/24 19:56, fan wrote:
> >  From 4b9695299d3d4b22f83666f8ab79099ec9f9817f Mon Sep 17 00:00:00 2001
> > From: Fan Ni <fan.ni@samsung.com>
> > Date: Tue, 20 Feb 2024 09:48:30 -0800
> > Subject: [PATCH 08/13] hw/cxl/cxl-mailbox-utils: Add mailbox commands to
> >   support add/release dynamic capacity response
> > 
> > Per CXL spec 3.1, two mailbox commands are implemented:
> > Add Dynamic Capacity Response (Opcode 4802h) 8.2.9.9.9.3, and
> > Release Dynamic Capacity (Opcode 4803h) 8.2.9.9.9.4.
> > 
> > For the process of the above two commands, we use two-pass approach.
> > Pass 1: Check whether the input payload is valid or not; if not, skip
> >          Pass 2 and return mailbox process error.
> > Pass 2: Do the real work--add or release extents, respectively.
> > 
> > Signed-off-by: Fan Ni <fan.ni@samsung.com>
> > ---
> >   hw/cxl/cxl-mailbox-utils.c  | 396 ++++++++++++++++++++++++++++++++++++
> >   hw/mem/cxl_type3.c          |  11 +
> >   include/hw/cxl/cxl_device.h |   4 +
> >   3 files changed, 411 insertions(+)
> > 
> > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > index 1915959015..cd9092b6bf 100644
> > --- a/hw/cxl/cxl-mailbox-utils.c
> > +++ b/hw/cxl/cxl-mailbox-utils.c
> 
> snip
> 
> > +/*
> > + * Copy extent list from src to dst
> > + * Return value: number of extents copied
> > + */
> > +static uint32_t copy_extent_list(CXLDCExtentList *dst,
> > +                                 const CXLDCExtentList *src)
> > +{
> > +    uint32_t cnt = 0;
> > +    CXLDCExtent *ent;
> > +
> > +    if (!dst || !src) {
> > +        return 0;
> > +    }
> > +
> > +    QTAILQ_FOREACH(ent, src, node) {
> > +        cxl_insert_extent_to_extent_list(dst, ent->start_dpa, ent->len,
> > +                                         ent->tag, ent->shared_seq);
> > +        cnt++;
> > +    }
> > +    return cnt;
> > +}
> > +
> > +static CXLRetCode cxl_dc_extent_release_dry_run(CXLType3Dev *ct3d,
> > +        const CXLUpdateDCExtentListInPl *in, CXLDCExtentList *updated_list,
> > +        uint32_t *updated_list_size)
> > +{
> > +    CXLDCExtent *ent, *ent_next;
> > +    uint64_t dpa, len;
> > +    uint32_t i;
> > +    int cnt_delta = 0;
> > +    CXLRetCode ret = CXL_MBOX_SUCCESS;
> > +
> > +    QTAILQ_INIT(updated_list);
> > +    copy_extent_list(updated_list, &ct3d->dc.extents);
> > +
> > +    for (i = 0; i < in->num_entries_updated; i++) {
> > +        Range range;
> > +
> > +        dpa = in->updated_entries[i].start_dpa;
> > +        len = in->updated_entries[i].len;
> > +
> > +        while (len > 0) {
> > +            QTAILQ_FOREACH(ent, updated_list, node) {
> > +                range_init_nofail(&range, ent->start_dpa, ent->len);
> > +
> > +                if (range_contains(&range, dpa)) {
> > +                    uint64_t len1, len2 = 0, len_done = 0;
> > +                    uint64_t ent_start_dpa = ent->start_dpa;
> > +                    uint64_t ent_len = ent->len;
> > +
> > +                    len1 = dpa - ent->start_dpa;
> > +                    /* Found the extent or the subset of an existing extent */
> > +                    if (range_contains(&range, dpa + len - 1)) {
> > +                        len2 = ent_start_dpa + ent_len - dpa - len;
> > +                    } else {
> > +                        /*
> > +                         * TODO: we reject the attempt to remove an extent
> > +                         * that overlaps with multiple extents in the device
> > +                         * for now. We will allow it once superset release
> > +                         * support is added.
> > +                         */
> > +                        ret = CXL_MBOX_INVALID_PA;
> > +                        goto free_and_exit;
> > +                    }
> > +                    len_done = ent_len - len1 - len2;
> > +
> > +                    cxl_remove_extent_from_extent_list(updated_list, ent);
> > +                    cnt_delta--;
> > +
> > +                    if (len1) {
> > +                        cxl_insert_extent_to_extent_list(updated_list,
> > +                                                         ent_start_dpa,
> > +                                                         len1, NULL, 0);
> > +                        cnt_delta++;
> > +                    }
> > +                    if (len2) {
> > +                        cxl_insert_extent_to_extent_list(updated_list,
> > +                                                         dpa + len,
> > +                                                         len2, NULL, 0);
> > +                        cnt_delta++;
> > +                    }
> > +
> > +                    if (cnt_delta + ct3d->dc.total_extent_count >
> > +                            CXL_NUM_EXTENTS_SUPPORTED) {
> > +                        ret = CXL_MBOX_RESOURCES_EXHAUSTED;
> > +                        goto free_and_exit;
> > +                    }
> > +
> > +                    len -= len_done;
> > +                    /* len == 0 here until superset release is added */
> > +                    break;
> > +                }
> > +            }
> > +            if (len) {
> > +                ret = CXL_MBOX_INVALID_PA;
> > +                goto free_and_exit;
> > +            }
> > +        }
> > +    }
> > +free_and_exit:
> > +    if (ret != CXL_MBOX_SUCCESS) {
> > +        QTAILQ_FOREACH_SAFE(ent, updated_list, node, ent_next) {
> > +            cxl_remove_extent_from_extent_list(updated_list, ent);
> > +        }
> > +        *updated_list_size = 0;
> > +    } else {
> > +        *updated_list_size = ct3d->dc.total_extent_count + cnt_delta;
> > +    }
> > +
> > +    return ret;
> > +}
> > +
> > +/*
> > + * CXL r3.1 section 8.2.9.9.9.4: Release Dynamic Capacity (Opcode 4803h)
> > + */
> > +static CXLRetCode cmd_dcd_release_dyn_cap(const struct cxl_cmd *cmd,
> > +                                          uint8_t *payload_in,
> > +                                          size_t len_in,
> > +                                          uint8_t *payload_out,
> > +                                          size_t *len_out,
> > +                                          CXLCCI *cci)
> > +{
> > +    CXLUpdateDCExtentListInPl *in = (void *)payload_in;
> > +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> > +    CXLDCExtentList updated_list;
> > +    CXLDCExtent *ent, *ent_next;
> > +    uint32_t updated_list_size;
> > +    CXLRetCode ret;
> > +
> > +    if (in->num_entries_updated == 0) {
> > +        return CXL_MBOX_INVALID_INPUT;
> > +    }
> > +
> > +    ret = cxl_detect_malformed_extent_list(ct3d, in);
> > +    if (ret != CXL_MBOX_SUCCESS) {
> > +        return ret;
> > +    }
> > +
> > +    ret = cxl_dc_extent_release_dry_run(ct3d, in, &updated_list,
> > +                                        &updated_list_size);
> > +    if (ret != CXL_MBOX_SUCCESS) {
> > +        return ret;
> > +    }
> > +
> > +    /*
> > +     * If the dry run release passes, the returned updated_list will
> > +     * be the updated extent list and we just need to clear the extents
> > +     * in the accepted list and copy extents in the updated_list to accepted
> > +     * list and update the extent count;
> > +     */
> > +    QTAILQ_FOREACH_SAFE(ent, &ct3d->dc.extents, node, ent_next) {
> > +        cxl_remove_extent_from_extent_list(&ct3d->dc.extents, ent);
> > +    }
> > +    copy_extent_list(&ct3d->dc.extents, &updated_list);
> > +    QTAILQ_FOREACH_SAFE(ent, &updated_list, node, ent_next) {
> > +        cxl_remove_extent_from_extent_list(&ct3d->dc.extents, ent);
> > +    }
> 
> Instead of doing a copy-delete, it should be simple to just relink the 
> list pointers of updated_list to ct3d->dc.extents - similar to the 
> QSIMPLEQ_CONCAT operation for QSIMPLEQ (unfortunately there isn't one 
> defined already for QTAILQ, but you could add one :)
> 
> Otherwise, looks great to me. Thanks for the update,
> Jørgen

Hi Jorgen,
Thanks for the suggestion. The issue here is we will introduce a bitmap
indicating which DPA range is backed with added extents in the next
patch, for the add/release processing, we need to update the bitmap to
reflect the update-to-date extent information. The remove and add action here
provides a natural way to update the bitmap like below 


   QTAILQ_FOREACH_SAFE(ent, &ct3d->dc.extents, node, ent_next) {
        ct3_clear_region_block_backed(ct3d, ent->start_dpa, ent->len);
        cxl_remove_extent_from_extent_list(&ct3d->dc.extents, ent);
    }
    copy_extent_list(&ct3d->dc.extents, &updated_list);
    QTAILQ_FOREACH_SAFE(ent, &updated_list, node, ent_next) {
        ct3_set_region_block_backed(ct3d, ent->start_dpa, ent->len);
        cxl_remove_extent_from_extent_list(&updated_list, ent);
    }

Fan
> 
> > +    ct3d->dc.total_extent_count = updated_list_size;
> > +
> > +    return CXL_MBOX_SUCCESS;
> > +}
> > +
> >   #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
> >   #define IMMEDIATE_DATA_CHANGE (1 << 2)
> >   #define IMMEDIATE_POLICY_CHANGE (1 << 3)
> > @@ -1448,6 +1838,12 @@ static const struct cxl_cmd cxl_cmd_set_dcd[256][256] = {
> >       [DCD_CONFIG][GET_DYN_CAP_EXT_LIST] = {
> >           "DCD_GET_DYNAMIC_CAPACITY_EXTENT_LIST", cmd_dcd_get_dyn_cap_ext_list,
> >           8, 0 },
> > +    [DCD_CONFIG][ADD_DYN_CAP_RSP] = {
> > +        "DCD_ADD_DYNAMIC_CAPACITY_RESPONSE", cmd_dcd_add_dyn_cap_rsp,
> > +        ~0, IMMEDIATE_DATA_CHANGE },
> > +    [DCD_CONFIG][RELEASE_DYN_CAP] = {
> > +        "DCD_RELEASE_DYNAMIC_CAPACITY", cmd_dcd_release_dyn_cap,
> > +        ~0, IMMEDIATE_DATA_CHANGE },
> >   };
> > 
> >   static const struct cxl_cmd cxl_cmd_set_sw[256][256] = {
> > diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> > index 48cce3bb13..2d4b6242f0 100644
> > --- a/hw/mem/cxl_type3.c
> > +++ b/hw/mem/cxl_type3.c
> > @@ -671,6 +671,15 @@ static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
> >       return true;
> >   }
> > 
> > +static void cxl_destroy_dc_regions(CXLType3Dev *ct3d)
> > +{
> > +    CXLDCExtent *ent, *ent_next;
> > +
> > +    QTAILQ_FOREACH_SAFE(ent, &ct3d->dc.extents, node, ent_next) {
> > +        cxl_remove_extent_from_extent_list(&ct3d->dc.extents, ent);
> > +    }
> > +}
> > +
> >   static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
> >   {
> >       DeviceState *ds = DEVICE(ct3d);
> > @@ -867,6 +876,7 @@ err_free_special_ops:
> >       g_free(regs->special_ops);
> >   err_address_space_free:
> >       if (ct3d->dc.host_dc) {
> > +        cxl_destroy_dc_regions(ct3d);
> >           address_space_destroy(&ct3d->dc.host_dc_as);
> >       }
> >       if (ct3d->hostpmem) {
> > @@ -888,6 +898,7 @@ static void ct3_exit(PCIDevice *pci_dev)
> >       cxl_doe_cdat_release(cxl_cstate);
> >       g_free(regs->special_ops);
> >       if (ct3d->dc.host_dc) {
> > +        cxl_destroy_dc_regions(ct3d);
> >           address_space_destroy(&ct3d->dc.host_dc_as);
> >       }
> >       if (ct3d->hostpmem) {
> > diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> > index 6aec6ac983..df3511e91b 100644
> > --- a/include/hw/cxl/cxl_device.h
> > +++ b/include/hw/cxl/cxl_device.h
> > @@ -551,4 +551,8 @@ void cxl_event_irq_assert(CXLType3Dev *ct3d);
> > 
> >   void cxl_set_poison_list_overflowed(CXLType3Dev *ct3d);
> > 
> > +CXLDCRegion *cxl_find_dc_region(CXLType3Dev *ct3d, uint64_t dpa, uint64_t len);
> > +
> > +void cxl_remove_extent_from_extent_list(CXLDCExtentList *list,
> > +                                        CXLDCExtent *extent);
> >   #endif
> > --
> > 2.43.0
> > 
