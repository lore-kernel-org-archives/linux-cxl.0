Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3EA309A65
	for <linux-cxl@vger.kernel.org>; Fri,  4 Jul 2025 08:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751616772; cv=none; b=bPUrzfKZbnVn8GhLCHzleT+Auplg7dOzCZDASlMLzk1mItJqP/K0lcc0XDMlvDfs+KYCuKfdYd+FpQguHlb7bsqbk6YfB4bTRz6DUBsFntwU+ekbJPTDmvxzSd0LEn629rDS/W4Vzu76G84BDfpR60wDRYcHUHpbys+okIjrb08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751616772; c=relaxed/simple;
	bh=g+AKYNJQDIOhHOWzj8pSpKptRUZ4gsrLmsuMxNDVa/k=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bqH/wb5q19ipwvCMiiQlJzz/1EI+zLtxhr/86DuJQmQTLmZvRTqJ5UIG9OVxeXOTgju7JRccsmZiyjdomwet+1YENxbOFSjyzBIkWSScbpFfE6uzLTzvggi0v2OamB8IHCO+4Apzg2Ka3FpEM6n8S1kHc6Jlyeg2+R2qtAXlyjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bYRFB2ZNyz6L5cj;
	Fri,  4 Jul 2025 16:12:14 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id E21261404D8;
	Fri,  4 Jul 2025 16:12:45 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 4 Jul
 2025 10:12:45 +0200
Date: Fri, 4 Jul 2025 09:12:43 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Fan Ni <nifan.cxl@gmail.com>
CC: <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
	<linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>
Subject: Re: [PATCH qemu 10/11] hw/cxl: mailbox-utils: 0x5604 - FMAPI
 Initiate DC Add
Message-ID: <20250704091243.00001c31@huawei.com>
In-Reply-To: <aGaunVxcE8aOyg2V@smc-140338-bm01>
References: <20250702160219.989731-1-Jonathan.Cameron@huawei.com>
	<20250702160219.989731-11-Jonathan.Cameron@huawei.com>
	<aGaunVxcE8aOyg2V@smc-140338-bm01>
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

On Thu, 3 Jul 2025 16:23:57 +0000
Fan Ni <nifan.cxl@gmail.com> wrote:

> On Wed, Jul 02, 2025 at 05:02:16PM +0100, Jonathan Cameron wrote:
> > From: Anisa Su <anisa.su@samsung.com>
> > 
> > FM DCD Management command 0x5604 implemented per CXL r3.2 Spec Section 7.6.7.6.5
> > 
> > Signed-off-by: Anisa Su <anisa.su@samsung.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> 
> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> 
> Only a minor comment inline ...
Thanks! 

Michael, I'll let these sit for a little while but if it is helpful
for you if I do a v2 with the colon added just let me know.

Jonathan

> > ---
> >  include/hw/cxl/cxl_device.h |   4 ++
> >  hw/cxl/cxl-mailbox-utils.c  | 109 ++++++++++++++++++++++++++++++++++++
> >  hw/mem/cxl_type3.c          |   8 +--
> >  3 files changed, 117 insertions(+), 4 deletions(-)
> > 
> > diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> > index ed91e5387e..fdee60b977 100644
> > --- a/include/hw/cxl/cxl_device.h
> > +++ b/include/hw/cxl/cxl_device.h
> > @@ -728,4 +728,8 @@ void cxl_create_dc_event_records_for_extents(CXLType3Dev *ct3d,
> >                                               CXLDCEventType type,
> >                                               CXLDCExtentRaw extents[],
> >                                               uint32_t ext_count);
> > +bool cxl_extents_overlaps_dpa_range(CXLDCExtentList *list,
> > +                                    uint64_t dpa, uint64_t len);
> > +bool cxl_extent_groups_overlaps_dpa_range(CXLDCExtentGroupList *list,
> > +                                          uint64_t dpa, uint64_t len);
> >  #endif
> > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > index d0a1d63582..5ea0d07808 100644
> > --- a/hw/cxl/cxl-mailbox-utils.c
> > +++ b/hw/cxl/cxl-mailbox-utils.c
> > @@ -122,6 +122,7 @@ enum {
> >          #define GET_HOST_DC_REGION_CONFIG   0x1
> >          #define SET_DC_REGION_CONFIG        0x2
> >          #define GET_DC_REGION_EXTENT_LIST   0x3
> > +        #define INITIATE_DC_ADD             0x4
> >  };
> >  
> >  /* CCI Message Format CXL r3.1 Figure 7-19 */
> > @@ -3542,6 +3543,107 @@ static CXLRetCode cmd_fm_get_dc_region_extent_list(const struct cxl_cmd *cmd,
> >      return CXL_MBOX_SUCCESS;
> >  }
> >  
> > +/*
> > + * Helper function to convert CXLDCExtentRaw to CXLUpdateDCExtentListInPl
> > + * in order to reuse cxl_detect_malformed_extent_list() function which accepts
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
> 
> /* CXL r3.2 Section 7.6.7.6.5: Initiate Dynamic Capacity Add (Opcode 5604h) */
> 
> Fan
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
> > +                g_malloc0(sizeof(*list) +
> > +                    in->ext_count * sizeof(*list->updated_entries));
> > +
> > +            convert_raw_extents(in->extents, list, in->ext_count);
> > +            rc = cxl_detect_malformed_extent_list(ct3d, list);
> > +
> > +            for (i = 0; i < in->ext_count; i++) {
> > +                CXLDCExtentRaw *ext = &in->extents[i];
> > +
> > +                /* Check requested extents do not overlap with pending ones. */
> > +                if (cxl_extent_groups_overlaps_dpa_range(&ct3d->dc.extents_pending,
> > +                                                         ext->start_dpa,
> > +                                                         ext->len)) {
> > +                    return CXL_MBOX_INVALID_EXTENT_LIST;
> > +                }
> > +                /* Check requested extents do not overlap with existing ones. */
> > +                if (cxl_extents_overlaps_dpa_range(&ct3d->dc.extents,
> > +                                                   ext->start_dpa,
> > +                                                   ext->len)) {
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
> > +                CXLDCExtentRaw *ext = &in->extents[i];
> > +
> > +                group = cxl_insert_extent_to_extent_group(group, ext->start_dpa,
> > +                                                          ext->len, ext->tag,
> > +                                                          ext->shared_seq);
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
> > @@ -3669,6 +3771,13 @@ static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
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
> > -- 
> > 2.48.1
> >   
> 

