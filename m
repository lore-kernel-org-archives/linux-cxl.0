Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5922D3A72
	for <linux-cxl@vger.kernel.org>; Thu,  3 Jul 2025 09:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751533538; cv=none; b=g4WVVvGKInOuDAUSmSwYtKzwEw/d12qlehDndg2UDzwTe4H6mWNAzKoRxBTEAUB+Tcxpa+caO9QXA8Ql9CC0n0q8UQREr+CT6CDLjASrlnYFjwDa2YImKjIGqwfZR5MPquV8MPxSTEGwol7NQtjVpfYSRTzu7TLMmGgdV0L8NCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751533538; c=relaxed/simple;
	bh=7s9pCNy73h69jRLEkDYrq/KMNXmqcIDA7pyYBInDUOs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fqlPmX+pO9PlXkGc7e6WvLhXthIROs7gxvKZJt2rp0XIccp5qh83z3rXnZ7ApKf7IvGe2nm43gcLzOxCFGMBC/AZrCboAH+nIfiosO9PY42eIt8aLDCjVfkLtT9QzGbkX6HjaqtFYfLlwFzdJw1PFw3E2JyvlU4F9qTv3AKpWf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bXrS35pb9z6M56f;
	Thu,  3 Jul 2025 17:04:35 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id AC8111404FE;
	Thu,  3 Jul 2025 17:05:32 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 3 Jul
 2025 11:05:32 +0200
Date: Thu, 3 Jul 2025 10:05:31 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Fan Ni <nifan.cxl@gmail.com>
CC: <anisa.su887@gmail.com>, <qemu-devel@nongnu.org>, <dave@stgolabs.net>,
	<alok.a.tiwari@oracle.com>, <linux-cxl@vger.kernel.org>, Anisa Su
	<anisa.su@samsung.com>
Subject: Re: [QEMU PATCH v4 09/10] cxl-mailbox-utils: 0x5604 - FMAPI
 Initiate DC Add
Message-ID: <20250703100531.000033f6@huawei.com>
In-Reply-To: <aGYEWDOGPbtncEmN@smc-140338-bm01>
References: <20250626222743.1766404-1-anisa.su887@gmail.com>
	<20250626222743.1766404-10-anisa.su887@gmail.com>
	<aGYEWDOGPbtncEmN@smc-140338-bm01>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 3 Jul 2025 04:17:28 +0000
Fan Ni <nifan.cxl@gmail.com> wrote:

> On Thu, Jun 26, 2025 at 10:23:32PM +0000, anisa.su887@gmail.com wrote:
> > From: Anisa Su <anisa.su@samsung.com>
> > 
> > FM DCD Management command 0x5604 implemented per CXL r3.2 Spec Section 7.6.7.6.5
> > 
> > Signed-off-by: Anisa Su <anisa.su@samsung.com>
> > ---  
> 
> Minor comments inline...

Oops. This raced with me sending out the version for Michael to
consider picking up.
https://lore.kernel.org/qemu-devel/20250702160219.989731-1-Jonathan.Cameron@huawei.com/

I did the lazy maintainer thing of just tweaking the small stuff to
avoid the round trip of another version (and increased chance of missing
the soft freeze).

Other than the g_autofree comment where I'm not sure what you mean,
the only outstanding one is the missing colon and I'd rather not respin
for that even if it is a bit ugly.

Take a look as well at the comments that you point out needed shortening.
I did so but with different text from your suggestion.


> > +
> > +/* CXL r3.2 Section 7.6.7.6.5 Initiate Dynamic Capacity Add (Opcode 5604h) */  
> 
> Keep the spec reference comments consistent like below,
> /* CXL r3.2 Section 7.6.7.6.5: Initiate Dynamic Capacity Add (Opcode 5604h) */

I missed this one. I'm not thinking this justifies a respin.

> 
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
> > +    int i, rc;
> > +
> > +    switch (in->selection_policy) {
> > +        case CXL_EXTENT_SELECTION_POLICY_PRESCRIPTIVE: {
> > +            /* Adding extents exceeds device's extent tracking ability. */
> > +            if (in->ext_count + ct3d->dc.total_extent_count >
> > +                CXL_NUM_EXTENTS_SUPPORTED) {
> > +                return CXL_MBOX_RESOURCES_EXHAUSTED;
> > +            }
> > +
> > +            g_autofree CXLUpdateDCExtentListInPl *list =  
> This seems not consistent with existing code style. Type declaration
> comes first.

I'm not following this comment. I grepped and unlike the kernel equivalent
it seems g_autofree is always first in qemu code.


> > +                g_malloc0(sizeof(*list) +
> > +                    in->ext_count * sizeof(*list->updated_entries));
> > +
> > +            convert_raw_extents(in->extents, list, in->ext_count);
> > +            rc = cxl_detect_malformed_extent_list(ct3d, list);
> > +
> > +            for (i = 0; i < in->ext_count; i++) {
> > +                CXLDCExtentRaw ext = in->extents[i];  
> Use pointer as Jonathan mentioned.
I tweaked this.

> > +                /* Check requested extents do not overlap with pending extents. */  
> shorten the comments like
> Extents to add cannot overlap with pending extents

Shortened them but slightly differently to this.

Check requested extents do not overlap with pending ones

If you don't feel strongly about the wording I'd rather leave that be. 

> > +                if (cxl_extent_groups_overlaps_dpa_range(&ct3d->dc.extents_pending,
> > +                                                         ext.start_dpa, ext.len)) {
> > +                    return CXL_MBOX_INVALID_EXTENT_LIST;
> > +                }
> > +                /* Check requested extents do not overlap with existing extents. */  
> Not allowed to add extents already existing
> > +                if (cxl_extents_overlaps_dpa_range(&ct3d->dc.extents,
> > +                                                   ext.start_dpa, ext.len)) {
> > +                    return CXL_MBOX_INVALID_EXTENT_LIST;
> > +                }
> > +            }
> > +
> > +            if (rc) {
> > +                return rc;
> > +            }
> > +
> > +            CXLDCExtentGroup *group = NULL;
> > +            for (i = 0; i < in->ext_count; i++) {
> > +                group = cxl_insert_extent_to_extent_group(group,
> > +                                                          in->extents[i].start_dpa,
> > +                                                          in->extents[i].len,
> > +                                                          in->extents[i].tag,
> > +                                                          in->extents[i].shared_seq);  
> Shorten the lines as Jonathan suggested. 

I did that in the version I posted.

Thanks,

Jonathan

> 
> Fan
> > +            }
> > +
> > +            cxl_extent_group_list_insert_tail(&ct3d->dc.extents_pending, group);
> > +            ct3d->dc.total_extent_count += in->ext_count;
> > +            cxl_create_dc_event_records_for_extents(ct3d,
> > +                                                    DC_EVENT_ADD_CAPACITY,
> > +                                                    in->extents,
> > +                                                    in->ext_count);
> > +
> > +            return CXL_MBOX_SUCCESS;
> > +        }
> > +        default: {
> > +            qemu_log_mask(LOG_UNIMP,
> > +                          "CXL extent selection policy not supported.\n");
> > +            return CXL_MBOX_INVALID_INPUT;
> > +        }
> > +    }
> > +}
> > +
> >  static const struct cxl_cmd cxl_cmd_set[256][256] = {
> >      [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
> >          cmd_infostat_bg_op_abort, 0, 0 },
> > @@ -3666,6 +3765,13 @@ static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
> >           CXL_MBOX_IMMEDIATE_DATA_CHANGE) },
> >      [FMAPI_DCD_MGMT][GET_DC_REGION_EXTENT_LIST] = { "GET_DC_REGION_EXTENT_LIST",
> >          cmd_fm_get_dc_region_extent_list, 12, 0 },
> > +    [FMAPI_DCD_MGMT][INITIATE_DC_ADD] = { "INIT_DC_ADD",
> > +        cmd_fm_initiate_dc_add, ~0,
> > +        (CXL_MBOX_CONFIG_CHANGE_COLD_RESET |
> > +        CXL_MBOX_CONFIG_CHANGE_CONV_RESET |
> > +        CXL_MBOX_CONFIG_CHANGE_CXL_RESET |
> > +        CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
> > +        CXL_MBOX_IMMEDIATE_DATA_CHANGE) },
> >  };
> >  
> >  /*
> > diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> > index 9c2b9d197b..7676d785c2 100644
> > --- a/hw/mem/cxl_type3.c
> > +++ b/hw/mem/cxl_type3.c
> > @@ -1885,8 +1885,8 @@ void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
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
> > @@ -1931,8 +1931,8 @@ bool cxl_extents_contains_dpa_range(CXLDCExtentList *list,
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
> > index 91ec1ba299..7be68d98c6 100644
> > --- a/include/hw/cxl/cxl_device.h
> > +++ b/include/hw/cxl/cxl_device.h
> > @@ -736,4 +736,8 @@ void cxl_create_dc_event_records_for_extents(CXLType3Dev *ct3d,
> >                                               CXLDCEventType type,
> >                                               CXLDCExtentRaw extents[],
> >                                               uint32_t ext_count);
> > +bool cxl_extents_overlaps_dpa_range(CXLDCExtentList *list,
> > +                                    uint64_t dpa, uint64_t len);
> > +bool cxl_extent_groups_overlaps_dpa_range(CXLDCExtentGroupList *list,
> > +                                          uint64_t dpa, uint64_t len);
> >  #endif
> > -- 
> > 2.47.2
> >   
> 

