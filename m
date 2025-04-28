Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4670D26ACD
	for <linux-cxl@vger.kernel.org>; Mon, 28 Apr 2025 20:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745872893; cv=none; b=dl1rMSFcccYHWkVTq10Rd8PKkK7vGeZBSn7HOI5bD6aM/Wf2c/DFjHCIRq9eFjNu9q/L3lBH1p9vSNBUCpHUn3LDsCg5xN/G0H9z4FSDrwmPhh20wlvQ2BKEuE/rPpgRiRCoAzla7oFvMrThqkCxtCqnstcYYTdTpyCVppCVJCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745872893; c=relaxed/simple;
	bh=OTA53xxSJ5vitQKTzLJnnqK/JEZJx/nBcf8w1EcU44k=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EHRkL1q6Jo3BjqyVfijdzpKMAE/c2gy69r1/8xO9FXp2tvSzOmvlpQ+o+65uydQ8V4UsVweyJCZbaSlpFZZpbTaj5leDTxwBCkMvIMg0LMBIPkhvjlHr6Jm7BuWbEJ2jTENmidfv2uLtCuMXgybuxpqneLpz8ndAmzT2llVLcDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lxlJ9l7b; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lxlJ9l7b"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c58974ed57so578330985a.2
        for <linux-cxl@vger.kernel.org>; Mon, 28 Apr 2025 13:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745872890; x=1746477690; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i3y1FOUgVsX87EjiOelwWpjlR6C+c3ULMgqt0TDK/U4=;
        b=lxlJ9l7bO+ALqE5bsPsyptTzYb6SbKvx5lWH4DQ51wu2LTLdt0bG+UU22KGEgidd7N
         CJgJZqjk07neP9IjhdjadVdNFrOOtOMjGP0shbNSfI+ZkDIX9ecQYre6aohRhZNanCt5
         0ECPW+iJClo/64ikfZ0B45Gv+/E5dBE3PHmfF+b4MTLtrNq83vHSVVKjYh6xxX0GggY4
         74+2hRUm06blTaOBFfJGWp4Yz/7aOkgHD5xV/12GTss9Ybo9fMu1WTWclVj870xHD54t
         yU0LxsM4UOvHBffR25zelTxUUDmcnUEpqYT56+zh2YNc+10zwZCljKvYhxu1n2eu6c+J
         +YtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745872890; x=1746477690;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i3y1FOUgVsX87EjiOelwWpjlR6C+c3ULMgqt0TDK/U4=;
        b=uilPyCqRnzAfy9w5m/4ohNjRo2BAR5HHZW/xBD4Hhx5vdobzJwgQAwgrU5q34GsM5B
         OaYc+wQDPMTrPTDWZ9m+iyzkZPfFPDJew5lCQaUlfUmc6NekAL2tNNSoRyRvN5leetL/
         W9Rx4GTkAub4yGVslYUK2ZI5fkw3U2/zjo5OSEa24sbJL9rHsPedVOY8eJLcp1hQsHjE
         DgxggIfVNMjPrL0no6188U9TNNHnoAE05Vhg+b/HeQN/8Z7TMI3294IHp497uhccdWCd
         xdvaCWwMggehInfr2ZNtJ7ju9SHZJWE9yYpLBXHl9k805SFt4dmYAmo1NEY1slZTk3Nk
         Wg7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWwWPE36ea60Tzww7Ad6JLZNm25WmFmF7FW+DU7MhsxeNALNGfNVWF3o6jt+Xco+pISfFj3MBOxWVU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyajmtO5o+jMV4da+C5HMKPC2R/rcXlxdljPwRUhw+VWcFKAU5C
	Q0amqeDrrvez/NlvIOJTDuzy/UndGXP7drdfPuozTm7yzybmduk7VeK3xw==
X-Gm-Gg: ASbGncuzaUAZieyCN69qg/nXk+U/UYHFhCOyHx6utBTb9vL7ZAuVgsvDObCsvjJown4
	eQInkaLeEd/8p9aiWU9wF/Xiy3cWqnWDY/MQKA60PsmbfcvB9jBjVEZW9sclK6xIfTA/nS0vwsB
	unUFH5yRx+QTAIIM9m8xShkOssqEQa0MKwlPAGJfaqPrdKh7DP4f8IM58lWHibK20Jrsww4YtuU
	AMh4vwPYbcOcJkE7G5jU8arBtj1UWDmKvizrtnRnKAR9cR3x/Nk8kT3mB1tad+tHzXLNQoklYtd
	CYpNHkNqL36DBPRYe+48Q00qYcODBCSjX5ithoX1pyymy7o=
X-Google-Smtp-Source: AGHT+IHNqNM0/K7R18Z+/wdJ5hnZgIUYtFZ42eZb2MV9sb2ddzPiGZ7AhaalPTbFX8922hmIw3OrhA==
X-Received: by 2002:a05:620a:17a3:b0:7c9:5ec2:a82c with SMTP id af79cd13be357-7cabe664730mr90461185a.53.1745872889935;
        Mon, 28 Apr 2025 13:41:29 -0700 (PDT)
Received: from debian ([2607:fb90:37e2:c851:8e4d:2d6e:a358:8db0])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c958e9fbcasm662133685a.99.2025.04.28.13.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 13:41:29 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Mon, 28 Apr 2025 13:41:24 -0700
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: anisa.su887@gmail.com, qemu-devel@nongnu.org, nifan.cxl@gmail.com,
	dave@stgolabs.net, linux-cxl@vger.kernel.org,
	Anisa Su <anisa.su@samsung.com>
Subject: Re: [PATCH 8/9] cxl-mailbox-utils: 0x5604 -  FMAPI Initiate DC Add
Message-ID: <aA_n9NMY8CxLNtr-@debian>
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
> > +            CXL_NUM_EXTENTS_SUPPORTED) {
> > +            return CXL_MBOX_RESOURCES_EXHAUSTED;
> > +        }
> > +        rc = cxl_mbox_dc_prescriptive_sanity_check(ct3d,
> > +                                                   in->host_id,
> > +                                                   in->ext_count,
> > +                                                   in->extents,
> > +                                                   DC_EVENT_ADD_CAPACITY);
> > +        if (rc) {
> > +            return rc;
> > +        }
> > +
> > +        /* Prepare extents for Event Record */
> > +        event_rec_exts = g_new0(CXLDCExtentRaw, in->ext_count);
> > +        for (i = 0; i < in->ext_count; i++) {
> > +            ext = in->extents[i];
> > +            event_rec_exts[i].start_dpa = ext.start_dpa;
> > +            event_rec_exts[i].len = ext.len;
> > +            memset(event_rec_exts[i].tag, 0, 0x10);
> > +            event_rec_exts[i].shared_seq = 0;
> > +
> > +            /* Check requested extents do not overlap with pending extents. */
> > +            if (cxl_extent_groups_overlaps_dpa_range(&ct3d->dc.extents_pending,
> > +                                                     ext.start_dpa, ext.len)) {
> > +                return CXL_MBOX_INVALID_EXTENT_LIST;
> > +            }

The logic here seems not right. We need to have a separate pass to ensure all
the extents are valid, meaning aligned and no overlap themselves, AND no overlap
with accepted as well as pending extents. There should be no early error exit
like above when inserting into pending extent group.

> > +
> > +            /* Create extent group to add to pending list. */
> > +            group = cxl_insert_extent_to_extent_group(group,
> > +                                                      event_rec_exts[i].start_dpa,
> > +                                                      event_rec_exts[i].len,
> > +                                                      event_rec_exts[i].tag,
> > +                                                      event_rec_exts[i].shared_seq);
> > +        }
> > +
> > +        /* Add requested extents to pending list. */
> > +        if (group) {
> > +            cxl_extent_group_list_insert_tail(&ct3d->dc.extents_pending, group);
> > +        }
> > +
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

As long as we make sure all the extents are valid, we should be able to do it
in one pass.

Fan
> 
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
