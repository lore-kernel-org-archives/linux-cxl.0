Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC98E17C220
	for <linux-cxl@vger.kernel.org>; Mon,  5 May 2025 16:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746463223; cv=none; b=NdM5K6o24WGifKH8UeN0XQMqIM08cw+IMBEXATV4oVPbah0hGetZPm4xiEimHVpua1T4V+1/fLofckT2QC1XdRVYeOSQ7aFnIfjoc7otucyjHBYmsBrHkn81kxk9/dO+t0FA3Hgn+iFSsVqnISHcTmKTs3k3fGyQBMMZblogQI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746463223; c=relaxed/simple;
	bh=iFqE5aUDInTLI3gQHsSvSB+e5wpM5IH/Ocbfj/Umq7A=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XFL0/v0r6Cgt2l5SNnZj+W2MP2zG7A5zUuiKBWFiWbzC483gjohUpp19QO5rOuREh9tf/OdYBj05gkvorF2xB4TBKllyEFybh/IxwVqzzXMg54s190Ajt2GyLyB2VKzD3cn0cWVFRIdz/Wo86ubg0K1w0D/FXpD9JoQxSORfAzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kWh6I8sk; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kWh6I8sk"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2295d78b45cso60776655ad.0
        for <linux-cxl@vger.kernel.org>; Mon, 05 May 2025 09:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746463221; x=1747068021; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NjbPqPRRREtgZGw2PEbR9P44++hXXtzZ6VSCMtAfXpk=;
        b=kWh6I8skLxqZjEbyVI0/ai7w2ARYh0e31/82PZFTxsX3PoStNkTzFGqXYQBFAyu9xT
         LyKqkNzgwiY7t/DAbb38Uxs4qVF87fBwxKkabDVvjjXeMJ29Eh9OUuhpbfFkKtlBmoYV
         zVxoKGOHQxuDPtLD2soMffS4pStm4Z65ymhXlsO9w7opjRNNBKCNadRN1YxMRJHNQmFs
         Pffli2HpYTIgZaOWO8Ja2Jw+bJp1SpRgTLGmsG0TxXZy6j8BESycyk1jnz0PhAcX9m/X
         IRs42E820byZApWB6q+Rj3OOOw30u3jyJ982N5LMbMHFxEj/0hjyowS4dYFTBreh0kVn
         WuCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746463221; x=1747068021;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NjbPqPRRREtgZGw2PEbR9P44++hXXtzZ6VSCMtAfXpk=;
        b=dxhZCL9mhsYDMIJ9I15RPsb7W9xJPLbpF914BY54PNCVwGjGIF4/QVHm/QiZ8D5Bf9
         M5LTFFabZnlYVtXX0YrMn2hh2KLpmI3p5o99yv0ruEzknfS80EWeMpwJZYy05asprtRa
         28IZGRo5SbOcAaYDg5SGrsPfCKPag4hpjv1vjc9Jgu9N41L6Yxqb0Bk6I7pYL2Uh80pK
         K+jAGSJ9uFwtnqhweBnDbFSwyyzyNmTi1jokNOV6G/3xT/qbYXoD3dL3PpaQ2wT/Jk0n
         Jty2NN/vkHCyccBz2A9PYbmsaOatLzVRVbjXnWg1pVrrs9xB3HDUxDMjM16rHocqjJQA
         +dXw==
X-Forwarded-Encrypted: i=1; AJvYcCVqQ8PAkuT12LCMe9XHB4v1BbqfF77nBcBOHqOHrurHnxIGBeEBvmhDEAXuOqbSKXDoyqLQiMD0iVU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOS/4wrpTgJjR8+LKcrcfq/gh2Xk/92IVOWGgayczrRgnNoiSN
	fSDcPGlh0kKJIoYi4FaS+saSrWwjMHG+0mKWmy9QuriUo2P/ePQz
X-Gm-Gg: ASbGnctME/XCqvrYm4VDOtSL6lzM7A1uATGisj5gC+x8Yi/Wr0cT526c51xF1lpLCza
	ZQRe+2xm1SP44/11yoYcGe6+54P0X7NaWSnWVhnQrWC0f7u5E7dvi0n8IjIQaRlGke15T5nsv/r
	6UD2p7uAuSvlpmhRHlO26k/DBKGvbtuZ3F4gV3VlsXw2jtTQObrnAckyeofRIcuRgSx/IO2rNWL
	c0OO86xJ1MwbLWYw2AXm2TcmaKxAdG+HkEBMf15wSy8n57DoZekThPyVlqf6T4YM4p63Lp1TkwD
	+Fu7fhbS8Zm6nuW9hCchFf/v/SVR1QJv5oVjLBDMyFve+5ILlORETrZDcOtxyaKDv4o=
X-Google-Smtp-Source: AGHT+IFX+GkhdGN3ALtOcUgWKi2+CFDkTtzRi2oLKu2RTRWqF+s/bhhQYZZTj2P6nbS4nOc2cUhhVw==
X-Received: by 2002:a17:903:244e:b0:227:e6fe:2908 with SMTP id d9443c01a7336-22e3311e625mr683035ad.48.1746463220803;
        Mon, 05 May 2025 09:40:20 -0700 (PDT)
Received: from deb-101020-bm01.eng.stellus.in ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e1522948csm56957295ad.159.2025.05.05.09.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 09:40:20 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Mon, 5 May 2025 16:40:18 +0000
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: anisa.su887@gmail.com, qemu-devel@nongnu.org, nifan.cxl@gmail.com,
	dave@stgolabs.net, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 8/9] cxl-mailbox-utils: 0x5604 -  FMAPI Initiate DC Add
Message-ID: <aBjp8kvUDfwF-ksg@deb-101020-bm01.eng.stellus.in>
References: <20250317164204.2299371-1-anisa.su887@gmail.com>
 <20250317164204.2299371-9-anisa.su887@gmail.com>
 <20250424121959.0000042d@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424121959.0000042d@huawei.com>

On Thu, Apr 24, 2025 at 12:19:59PM +0100, Jonathan Cameron wrote:
> On Mon, 17 Mar 2025 16:31:35 +0000
> anisa.su887@gmail.com wrote:
> 
> > From: Anisa Su <anisa.su@samsung.com>
> > 
> > FM DCD Management command 0x5604 implemented per CXL r3.2 Spec Section 7.6.7.6.5
> > 
> > Signed-off-by: Anisa Su <anisa.su@samsung.com>
> > ---
...
> > +        /* Create event record and insert to event log */
> > +        cxl_mbox_dc_event_create_record_hdr(ct3d, &event_rec.hdr);
> > +        event_rec.type = DC_EVENT_ADD_CAPACITY;
> > +        /* FIXME: for now, validity flag is cleared */
> 
> This stuff is probably all valid.  If we can return remaining extents though we might
> as well.
> 
> > +        event_rec.validity_flags = 0;
> > +        /* FIXME: Currently only support 1 host */
> > +        event_rec.host_id = 0;
> > +        /* updated_region_id only valid for DC_EVENT_REGION_CONFIG_UPDATED */
> > +        event_rec.updated_region_id = 0;
> 
> The event_rec is zeroed anyway so probably just don't set this at all
> and no need for the comment.
> 
> > +        for (i = 0; i < in->ext_count; i++) {
> 
> Why can't we combine this with the earlier loop and avoid the
> need for separate storage of extents in event_rec_exts?
> 
I discussed with Fan and for add specifically, we will need 2 loops
because the pending list is of type CXLDCExtentGroupList. We must use the
first loop to create a CXLDCExtentGroup from all of the extents and
append the entire thing to the pending list before triggering any interrupts for
event records.
This is necessary to preserve the ordering/grouping in order for the
memdev_add_rsp command to know what to remove from the pending list if
no extents were accepted.
But the storage of extents in event_rec_exts is unnecessary and for
release, we only need 1 loop.

Thanks,
Anisa
> > +            memcpy(&event_rec.dynamic_capacity_extent,
> > +                   &event_rec_exts[i],
> > +                   sizeof(CXLDCExtentRaw));
> > +
> > +            event_rec.flags = 0;
> > +            if (i < in->ext_count - 1) {
> > +                /* Set "More" flag */
> > +                event_rec.flags |= BIT(0);
> > +            }
> > +
> > +            if (cxl_event_insert(&ct3d->cxl_dstate,
> > +                                 CXL_EVENT_TYPE_DYNAMIC_CAP,
> > +                                 (CXLEventRecordRaw *)&event_rec)) {
> > +                cxl_event_irq_assert(ct3d);
> > +            }
> > +        }
> > +
> > +        return CXL_MBOX_SUCCESS;
> > +    default:
> > +        qemu_log_mask(LOG_UNIMP,
> > +                      "CXL extent selection policy not supported.\n");
> > +        return CXL_MBOX_INVALID_INPUT;
> > +    }
> > +
> > +    return CXL_MBOX_SUCCESS;
> > +}
> > +
> >  static const struct cxl_cmd cxl_cmd_set[256][256] = {
> >      [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
> >          cmd_infostat_bg_op_abort, 0, 0 },
> > @@ -3804,6 +3970,13 @@ static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
> >           CXL_MBOX_IMMEDIATE_DATA_CHANGE)},
> >      [FMAPI_DCD_MGMT][GET_DC_REGION_EXTENT_LIST] = { "GET_DC_REGION_EXTENT_LIST",
> >          cmd_fm_get_dc_region_extent_list, 12, 0},
> > +    [FMAPI_DCD_MGMT][INITIATE_DC_ADD] = { "INIT_DC_ADD",
> > +        cmd_fm_initiate_dc_add, ~0,
> > +        (CXL_MBOX_CONFIG_CHANGE_COLD_RESET |
> > +        CXL_MBOX_CONFIG_CHANGE_CONV_RESET |
> > +        CXL_MBOX_CONFIG_CHANGE_CXL_RESET |
> > +        CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
> > +        CXL_MBOX_IMMEDIATE_DATA_CHANGE)},
> >  };
> >  
> >  /*
> > diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> > index b742b2bb8d..ccc619fe10 100644
> > --- a/hw/mem/cxl_type3.c
> > +++ b/hw/mem/cxl_type3.c
> > @@ -1982,8 +1982,8 @@ void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
> >   * the list.
> >   * Return value: return true if has overlaps; otherwise, return false
> >   */
> > -static bool cxl_extents_overlaps_dpa_range(CXLDCExtentList *list,
> > -                                           uint64_t dpa, uint64_t len)
> > +bool cxl_extents_overlaps_dpa_range(CXLDCExtentList *list,
> > +                                    uint64_t dpa, uint64_t len)
> >  {
> >      CXLDCExtent *ent;
> >      Range range1, range2;
> > @@ -2028,8 +2028,8 @@ bool cxl_extents_contains_dpa_range(CXLDCExtentList *list,
> >      return false;
> >  }
> >  
> > -static bool cxl_extent_groups_overlaps_dpa_range(CXLDCExtentGroupList *list,
> > -                                                 uint64_t dpa, uint64_t len)
> > +bool cxl_extent_groups_overlaps_dpa_range(CXLDCExtentGroupList *list,
> > +                                          uint64_t dpa, uint64_t len)
> >  {
> >      CXLDCExtentGroup *group;
> >  
> > diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> > index 217003a29d..1d5831a0b6 100644
> > --- a/include/hw/cxl/cxl_device.h
> > +++ b/include/hw/cxl/cxl_device.h
> > @@ -809,4 +809,8 @@ bool ct3_test_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
> >  void cxl_assign_event_header(CXLEventRecordHdr *hdr,
> >                               const QemuUUID *uuid, uint32_t flags,
> >                               uint8_t length, uint64_t timestamp);
> > +bool cxl_extents_overlaps_dpa_range(CXLDCExtentList *list,
> > +                                    uint64_t dpa, uint64_t len);
> > +bool cxl_extent_groups_overlaps_dpa_range(CXLDCExtentGroupList *list,
> > +                                          uint64_t dpa, uint64_t len);
> >  #endif
> 
