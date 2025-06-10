Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E331D90C8
	for <linux-cxl@vger.kernel.org>; Tue, 10 Jun 2025 15:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749569216; cv=none; b=EO5wq/tmzTy5E/UspyzGGw3MMjmPHqjN7eNRk+oCSywBZd4WZ1Y18ROa+5JiJPYSCiafsGCQWFhC173yS2b2KXA8MF3MMLzfPgy0apDwxtYkXfFNfAG2WVizn0QS5EjhVO/A35Abpwp9vW8KDGDxzcsyf5uYNxGrKKms8PK2AMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749569216; c=relaxed/simple;
	bh=HjrrgPWL64ZUaMkmvYyuqP7+Gl15jSQMpUKivHUBjs4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YGQEgZtx5U+9BREGlV0rbJe2CPN32rN1+NXYoL/MkhpSoSVZ252EsjJR9r9+cEFmLIQxyihQoa0bXXx+1HWRPG4jYa2PvnT68aKUwwDHH2o6laWwEdyt3IJUv/N6ns4BPtqakaOwUDVlDZz9+DgkaKiuLJs743R8gVicodRT1bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bGszc06Nkz6HJlk;
	Tue, 10 Jun 2025 23:25:00 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 0F115140373;
	Tue, 10 Jun 2025 23:26:50 +0800 (CST)
Received: from localhost (10.122.19.247) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 10 Jun
 2025 17:26:49 +0200
Date: Tue, 10 Jun 2025 16:26:48 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Fan Ni <nifan.cxl@gmail.com>
CC: <anisa.su887@gmail.com>, <qemu-devel@nongnu.org>, <dave@stgolabs.net>,
	<linux-cxl@vger.kernel.org>, Anisa Su <anisa.su@samsung.com>
Subject: Re: [QEMU PATCH v3 8/9] cxl-mailbox-utils: 0x5604 - FMAPI Initiate
 DC Add
Message-ID: <20250610162648.000071a2@huawei.com>
In-Reply-To: <aEMxlAvukxhWXhw1@debian>
References: <20250605234227.970187-1-anisa.su887@gmail.com>
	<20250605234227.970187-9-anisa.su887@gmail.com>
	<aEMxlAvukxhWXhw1@debian>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 6 Jun 2025 11:21:08 -0700
Fan Ni <nifan.cxl@gmail.com> wrote:

> On Thu, Jun 05, 2025 at 11:42:22PM +0000, anisa.su887@gmail.com wrote:
> > From: Anisa Su <anisa.su@samsung.com>
> > 
> > FM DCD Management command 0x5604 implemented per CXL r3.2 Spec Section 7.6.7.6.5
> > 
> > Signed-off-by: Anisa Su <anisa.su@samsung.com>  
> 
> See below...
A few follow ups.
> 
> > ---
> >  hw/cxl/cxl-mailbox-utils.c  | 152 ++++++++++++++++++++++++++++++++++++
> >  hw/mem/cxl_type3.c          |   8 +-
> >  include/hw/cxl/cxl_device.h |   4 +
> >  3 files changed, 160 insertions(+), 4 deletions(-)
> > 
> > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > index 004e502b22..7ee5be00bc 100644
> > --- a/hw/cxl/cxl-mailbox-utils.c
> > +++ b/hw/cxl/cxl-mailbox-utils.c
> > @@ -123,6 +123,7 @@ enum {
> >          #define GET_HOST_DC_REGION_CONFIG   0x1
> >          #define SET_DC_REGION_CONFIG        0x2
> >          #define GET_DC_REGION_EXTENT_LIST   0x3
> > +        #define INITIATE_DC_ADD             0x4
> >  };
> >  
> >  /* CCI Message Format CXL r3.1 Figure 7-19 */
> > @@ -3540,6 +3541,150 @@ static CXLRetCode cmd_fm_get_dc_region_extent_list(const struct cxl_cmd *cmd,
> >      return CXL_MBOX_SUCCESS;
> >  }
> >  
> > +static void cxl_mbox_dc_add_to_pending(CXLType3Dev *ct3d,  
> 
> This naming can be improved here, not straightforward to me.
> Maybe cxl_add_extents_to_pending_list() ?
> 
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
> 
> Also the code is duplicate with existing code in cxl_type3.c 
> qmp_cxl_process_dynamic_capacity_prescriptive(). 
> The function was simulating the behaviour of the mailbox command, so it is
> behaviour will be smilar to what we have in this patch, 
> find a way to reuse code, maybe extract common code as a helper function and use
> it in both qmp interface and here.
> 
> > +
> > +static void cxl_mbox_create_dc_event_records_for_extents(CXLType3Dev *ct3d,  
> cxl_create_dc_extent_records_for extents()?
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
> 
> Some issue here. A lot of duplicate code compared to
> qmp_cxl_process_dynamic_capacity_prescriptive.
> 
I'm not going to refactor this on my tree.  Given the level of feedback,
Anisa can you spin a new patch to replace what I'm carrying (which is
modified version of this with a bit of rebasing).

I'll push out a tree once I've caught up with reviewing this a bit more.

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
> 
> Use g_malloc() and g_free().

g_malloc0() I think.

> 
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
> 
> For all the case to return, instead of return directly set return code and jump
> here, do two things:
> 1. g_free(list);
> 2. return rt;

I'd prefer this which I think has same effect. I like direct returns ;)
Don't forget the {} to define scope though - I did and you get odd error
messages :)



@@ -3674,19 +3674,19 @@ static CXLRetCode cmd_fm_initiate_dc_add(const struct cxl_cmd *cmd,
         CXLDCExtentRaw extents[];
     } QEMU_PACKED *in = (void *)payload_in;
     CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
-    CXLUpdateDCExtentListInPl *list;
     int i, rc;

     switch (in->selection_policy) {
-    case CXL_EXTENT_SELECTION_POLICY_PRESCRIPTIVE:
-        /* Adding extents exceeds device's extent tracking ability. */
+    case CXL_EXTENT_SELECTION_POLICY_PRESCRIPTIVE: {
+         /* Adding extents exceeds device's extent tracking ability. */
         if (in->ext_count + ct3d->dc.total_extent_count >
             CXL_NUM_EXTENTS_SUPPORTED) {
             return CXL_MBOX_RESOURCES_EXHAUSTED;
         }

-        list = calloc(1, (sizeof(*list) +
-                          in->ext_count * sizeof(*list->updated_entries)));
+        g_autofree CXLUpdateDCExtentListInPl *list =
+             g_malloc0(sizeof(*list) +
+                      in->ext_count * sizeof(*list->updated_entries));
         convert_raw_extents(in->extents, list, in->ext_count);
         rc = cxl_detect_malformed_extent_list(ct3d, list);

@@ -3715,13 +3715,12 @@ static CXLRetCode cmd_fm_initiate_dc_add(const struct cxl_cmd *cmd,
                                                      in->ext_count);

         return CXL_MBOX_SUCCESS;
+    }
     default:
         qemu_log_mask(LOG_UNIMP,
                       "CXL extent selection policy not supported.\n");
         return CXL_MBOX_INVALID_INPUT;
     }
-
-    return CXL_MBOX_SUCCESS;
 }
> 
> Fan
> 
> > +    return CXL_MBOX_SUCCESS;
> > +}
> > +
> >  static const struct cxl_cmd cxl_cmd_set[256][256] = {
> >      [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
> >          cmd_infostat_bg_op_abort, 0, 0 },
> > @@ -3667,6 +3812,13 @@ static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
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
> > index ee554a77be..ca9fe89e4f 100644
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
> > index 76af75d2d0..d30f6503fa 100644
> > --- a/include/hw/cxl/cxl_device.h
> > +++ b/include/hw/cxl/cxl_device.h
> > @@ -724,4 +724,8 @@ bool ct3_test_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
> >  void cxl_assign_event_header(CXLEventRecordHdr *hdr,
> >                               const QemuUUID *uuid, uint32_t flags,
> >                               uint8_t length, uint64_t timestamp);
> > +bool cxl_extents_overlaps_dpa_range(CXLDCExtentList *list,
> > +                                    uint64_t dpa, uint64_t len);
> > +bool cxl_extent_groups_overlaps_dpa_range(CXLDCExtentGroupList *list,
> > +                                          uint64_t dpa, uint64_t len);
> >  #endif
> > -- 
> > 2.47.2
> >   

