Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A30D284B46
	for <linux-cxl@vger.kernel.org>; Tue,  6 May 2025 16:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746550509; cv=none; b=cimU5d/mbjVKpiksuVk5Jrtr0E6K1PICQQ4uSP3myxR6fDp2XLvV7qS9ICR6TdTMU/3gBtHVP4qorC9ho096vdKH+GVtqFxGBU+kSCLBSXVI3vpeSBPwCJhA+pc0+kSXTO4s9ZiH1n0dtGqoNULAIj6BC+LbCqT5rQJ2AA9o8SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746550509; c=relaxed/simple;
	bh=sUimS78+SbWJLSQMb51fTED8921Te6EuWozwguv6GMA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BZ4VezD0Jifhbz8IMhTRyUC9SLc+8M9KgQCK6Gutow7qbY/L/Xa69BYGI8cZAcgIGeT7zU/TSUmUOZXnAas3QIYAcc3zSekYT+YT8+NVBuaMjZ/aa1i2JOteE2lvP9081vAbEql2zAYdP+u5mTbIoG2NKGp0LpmMTdXUVNeKzQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZsPXT2tDHz6M4f4;
	Wed,  7 May 2025 00:50:33 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 382FF1400D3;
	Wed,  7 May 2025 00:55:03 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 6 May
 2025 18:55:02 +0200
Date: Tue, 6 May 2025 17:55:01 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Anisa Su <anisa.su887@gmail.com>
CC: <qemu-devel@nongnu.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 8/9] cxl-mailbox-utils: 0x5604 -  FMAPI Initiate DC Add
Message-ID: <20250506175501.00001281@huawei.com>
In-Reply-To: <aBjp8kvUDfwF-ksg@deb-101020-bm01.eng.stellus.in>
References: <20250317164204.2299371-1-anisa.su887@gmail.com>
	<20250317164204.2299371-9-anisa.su887@gmail.com>
	<20250424121959.0000042d@huawei.com>
	<aBjp8kvUDfwF-ksg@deb-101020-bm01.eng.stellus.in>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 5 May 2025 16:40:18 +0000
Anisa Su <anisa.su887@gmail.com> wrote:

> On Thu, Apr 24, 2025 at 12:19:59PM +0100, Jonathan Cameron wrote:
> > On Mon, 17 Mar 2025 16:31:35 +0000
> > anisa.su887@gmail.com wrote:
> >   
> > > From: Anisa Su <anisa.su@samsung.com>
> > > 
> > > FM DCD Management command 0x5604 implemented per CXL r3.2 Spec Section 7.6.7.6.5
> > > 
> > > Signed-off-by: Anisa Su <anisa.su@samsung.com>
> > > ---  
> ...
> > > +        /* Create event record and insert to event log */
> > > +        cxl_mbox_dc_event_create_record_hdr(ct3d, &event_rec.hdr);
> > > +        event_rec.type = DC_EVENT_ADD_CAPACITY;
> > > +        /* FIXME: for now, validity flag is cleared */  
> > 
> > This stuff is probably all valid.  If we can return remaining extents though we might
> > as well.
> >   
> > > +        event_rec.validity_flags = 0;
> > > +        /* FIXME: Currently only support 1 host */
> > > +        event_rec.host_id = 0;
> > > +        /* updated_region_id only valid for DC_EVENT_REGION_CONFIG_UPDATED */
> > > +        event_rec.updated_region_id = 0;  
> > 
> > The event_rec is zeroed anyway so probably just don't set this at all
> > and no need for the comment.
> >   
> > > +        for (i = 0; i < in->ext_count; i++) {  
> > 
> > Why can't we combine this with the earlier loop and avoid the
> > need for separate storage of extents in event_rec_exts?
> >   
> I discussed with Fan and for add specifically, we will need 2 loops
> because the pending list is of type CXLDCExtentGroupList. We must use the
> first loop to create a CXLDCExtentGroup from all of the extents and
> append the entire thing to the pending list before triggering any interrupts for
> event records.
> This is necessary to preserve the ordering/grouping in order for the
> memdev_add_rsp command to know what to remove from the pending list if
> no extents were accepted.

Ah. That makes sense. Thanks!

> But the storage of extents in event_rec_exts is unnecessary and for
> release, we only need 1 loop.
> 
> Thanks,
> Anisa
> > > +            memcpy(&event_rec.dynamic_capacity_extent,
> > > +                   &event_rec_exts[i],
> > > +                   sizeof(CXLDCExtentRaw));
> > > +
> > > +            event_rec.flags = 0;
> > > +            if (i < in->ext_count - 1) {
> > > +                /* Set "More" flag */
> > > +                event_rec.flags |= BIT(0);
> > > +            }
> > > +
> > > +            if (cxl_event_insert(&ct3d->cxl_dstate,
> > > +                                 CXL_EVENT_TYPE_DYNAMIC_CAP,
> > > +                                 (CXLEventRecordRaw *)&event_rec)) {
> > > +                cxl_event_irq_assert(ct3d);
> > > +            }
> > > +        }
> > > +
> > > +        return CXL_MBOX_SUCCESS;
> > > +    default:
> > > +        qemu_log_mask(LOG_UNIMP,
> > > +                      "CXL extent selection policy not supported.\n");
> > > +        return CXL_MBOX_INVALID_INPUT;
> > > +    }
> > > +
> > > +    return CXL_MBOX_SUCCESS;
> > > +}
> > > +
> > >  static const struct cxl_cmd cxl_cmd_set[256][256] = {
> > >      [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
> > >          cmd_infostat_bg_op_abort, 0, 0 },
> > > @@ -3804,6 +3970,13 @@ static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
> > >           CXL_MBOX_IMMEDIATE_DATA_CHANGE)},
> > >      [FMAPI_DCD_MGMT][GET_DC_REGION_EXTENT_LIST] = { "GET_DC_REGION_EXTENT_LIST",
> > >          cmd_fm_get_dc_region_extent_list, 12, 0},
> > > +    [FMAPI_DCD_MGMT][INITIATE_DC_ADD] = { "INIT_DC_ADD",
> > > +        cmd_fm_initiate_dc_add, ~0,
> > > +        (CXL_MBOX_CONFIG_CHANGE_COLD_RESET |
> > > +        CXL_MBOX_CONFIG_CHANGE_CONV_RESET |
> > > +        CXL_MBOX_CONFIG_CHANGE_CXL_RESET |
> > > +        CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
> > > +        CXL_MBOX_IMMEDIATE_DATA_CHANGE)},
> > >  };
> > >  
> > >  /*
> > > diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> > > index b742b2bb8d..ccc619fe10 100644
> > > --- a/hw/mem/cxl_type3.c
> > > +++ b/hw/mem/cxl_type3.c
> > > @@ -1982,8 +1982,8 @@ void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
> > >   * the list.
> > >   * Return value: return true if has overlaps; otherwise, return false
> > >   */
> > > -static bool cxl_extents_overlaps_dpa_range(CXLDCExtentList *list,
> > > -                                           uint64_t dpa, uint64_t len)
> > > +bool cxl_extents_overlaps_dpa_range(CXLDCExtentList *list,
> > > +                                    uint64_t dpa, uint64_t len)
> > >  {
> > >      CXLDCExtent *ent;
> > >      Range range1, range2;
> > > @@ -2028,8 +2028,8 @@ bool cxl_extents_contains_dpa_range(CXLDCExtentList *list,
> > >      return false;
> > >  }
> > >  
> > > -static bool cxl_extent_groups_overlaps_dpa_range(CXLDCExtentGroupList *list,
> > > -                                                 uint64_t dpa, uint64_t len)
> > > +bool cxl_extent_groups_overlaps_dpa_range(CXLDCExtentGroupList *list,
> > > +                                          uint64_t dpa, uint64_t len)
> > >  {
> > >      CXLDCExtentGroup *group;
> > >  
> > > diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> > > index 217003a29d..1d5831a0b6 100644
> > > --- a/include/hw/cxl/cxl_device.h
> > > +++ b/include/hw/cxl/cxl_device.h
> > > @@ -809,4 +809,8 @@ bool ct3_test_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
> > >  void cxl_assign_event_header(CXLEventRecordHdr *hdr,
> > >                               const QemuUUID *uuid, uint32_t flags,
> > >                               uint8_t length, uint64_t timestamp);
> > > +bool cxl_extents_overlaps_dpa_range(CXLDCExtentList *list,
> > > +                                    uint64_t dpa, uint64_t len);
> > > +bool cxl_extent_groups_overlaps_dpa_range(CXLDCExtentGroupList *list,
> > > +                                          uint64_t dpa, uint64_t len);
> > >  #endif  
> >   
> 

