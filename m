Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF7D2D3733
	for <linux-cxl@vger.kernel.org>; Thu,  3 Jul 2025 09:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751533338; cv=none; b=m7IRWkYuSoXJQ1Rbhyd2zVfnU2AmXv5FjEUbUTW9HQ6VNUOMBgBb71FkFyqWtceMKTXPKAzGXLIsjIZPODHh5z4uLgtczK/dovTYXfxZoF8EBzAnEAxF1976w4b1t6lAdZrinikk+xefDqKrWwX2F/yySbyONQCCl+380Xbpqog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751533338; c=relaxed/simple;
	bh=ht7m6VqBjZyphdDNUAO1PCSo4qY94ab02DSWyau1VuQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d2KNSn8lIQllrD2Rww7RxJQgHGI5Svd9NISjqioZuJbhQDHwN/+gKtMG3Yl/ZztisbaHtBPcHed/6xjY4pwkVvnhmf7klB0oApZGJ0Aq9T+BmzLu/kSL2d+is+VIk/7cBGO24k88vKDtVRmVYsrtw+8FR1uRA9XyzGia5RWDVJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bXrNC64qxz6M4YY;
	Thu,  3 Jul 2025 17:01:15 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id B35731402FC;
	Thu,  3 Jul 2025 17:02:12 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 3 Jul
 2025 11:02:12 +0200
Date: Thu, 3 Jul 2025 10:02:10 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Fan Ni <nifan.cxl@gmail.com>
CC: <anisa.su887@gmail.com>, <qemu-devel@nongnu.org>, <dave@stgolabs.net>,
	<alok.a.tiwari@oracle.com>, <linux-cxl@vger.kernel.org>, Anisa Su
	<anisa.su@samsung.com>
Subject: Re: [QEMU PATCH v4 10/10] cxl-mailbox-utils: 0x5605 - FMAPI
 Initiate DC Release
Message-ID: <20250703100210.00001be5@huawei.com>
In-Reply-To: <aGYFRdm7SEGbE6pu@smc-140338-bm01>
References: <20250626222743.1766404-1-anisa.su887@gmail.com>
	<20250626222743.1766404-11-anisa.su887@gmail.com>
	<aGYFRdm7SEGbE6pu@smc-140338-bm01>
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

On Thu, 3 Jul 2025 04:21:25 +0000
Fan Ni <nifan.cxl@gmail.com> wrote:

> On Thu, Jun 26, 2025 at 10:23:33PM +0000, anisa.su887@gmail.com wrote:
> > From: Anisa Su <anisa.su@samsung.com>
> > 
> > FM DCD Management command 0x5605 implemented per CXL r3.2 Spec Section 7.6.7.6.6
> > 
> > Signed-off-by: Anisa Su <anisa.su@samsung.com>
> > ---  
> Minor comments inline ...
Hi Fan,


See below. I tweaked what you are commenting on in version I rebased and asked
Michael to consider picking up.

If you are happy with that, please give a tag on 
https://lore.kernel.org/qemu-devel/20250702160219.989731-12-Jonathan.Cameron@huawei.com/
> 
> >  hw/cxl/cxl-mailbox-utils.c | 79 ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 79 insertions(+)
> > 
> > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > index 787eeaa7b9..87f9535d46 100644
> > --- a/hw/cxl/cxl-mailbox-utils.c
> > +++ b/hw/cxl/cxl-mailbox-utils.c
> > @@ -123,6 +123,7 @@ enum {
> >          #define SET_DC_REGION_CONFIG        0x2
> >          #define GET_DC_REGION_EXTENT_LIST   0x3
> >          #define INITIATE_DC_ADD             0x4
> > +        #define INITIATE_DC_RELEASE         0x5
> >  };
> >  
> >  /* CCI Message Format CXL r3.1 Figure 7-19 */
> > @@ -3638,6 +3639,77 @@ static CXLRetCode cmd_fm_initiate_dc_add(const struct cxl_cmd *cmd,
> >      }
> >  }
> >  
> > +#define CXL_EXTENT_REMOVAL_POLICY_MASK 0x0F
> > +#define CXL_FORCED_REMOVAL_MASK (1 << 4)
> > +/* CXL r3.2 Section 7.6.7.6.6 Initiate Dynamic Capacity Release (Opcode 5605h) */  
> 
> /* CXL r3.2 Section 7.6.7.6.6: Initiate Dynamic Capacity Release (Opcode 5605h) */
This one I fixed.  Noticed it because the line is also over 80 chars so now
formatted as

/*
 * CXL r3.2 Section 7.6.7.6.6:
 * Initiate Dynamic Capacity Release (Opcode 5605h) */
 */
> 
> Fan
> 
> > +static CXLRetCode cmd_fm_initiate_dc_release(const struct cxl_cmd *cmd,
> > +                                             uint8_t *payload_in,
> > +                                             size_t len_in,
> > +                                             uint8_t *payload_out,
> > +                                             size_t *len_out,
> > +                                             CXLCCI *cci)
> > +{
> > +    struct {
> > +        uint16_t host_id;
> > +        uint8_t flags;
> > +        uint8_t reg_num;
> > +        uint64_t length;
> > +        uint8_t tag[0x10];
> > +        uint32_t ext_count;
> > +        CXLDCExtentRaw extents[];
> > +    } QEMU_PACKED *in = (void *)payload_in;
> > +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> > +    int i, rc;
> > +
> > +    switch (in->flags & CXL_EXTENT_REMOVAL_POLICY_MASK) {
> > +        case CXL_EXTENT_REMOVAL_POLICY_PRESCRIPTIVE: {
> > +            CXLDCExtentList updated_list;
> > +            uint32_t updated_list_size;
> > +            g_autofree CXLUpdateDCExtentListInPl *list =
> > +                g_malloc0(sizeof(*list) +
> > +                    in->ext_count * sizeof(*list->updated_entries));
> > +
> > +            convert_raw_extents(in->extents, list, in->ext_count);
> > +            rc = cxl_detect_malformed_extent_list(ct3d, list);
> > +            if (rc) {
> > +                return rc;
> > +            }
> > +
> > +            /* Fail with Invalid PA if an extent is pending and Forced Removal
> > +             * flag not set
> > +             */
> > +            if (!(in->flags & CXL_FORCED_REMOVAL_MASK)) {
> > +                for (i = 0; i < in->ext_count; i++) {
> > +                    CXLDCExtentRaw ext = in->extents[i];
> > +                    /* Check requested extents don't overlap with pending extents. */
> > +                    if (cxl_extent_groups_overlaps_dpa_range(&ct3d->dc.extents_pending,
> > +                                                             ext.start_dpa, ext.len)) {
> > +                        return CXL_MBOX_INVALID_PA;
> > +                    }
> > +                }
> > +            }
> > +
> > +            rc = cxl_dc_extent_release_dry_run(ct3d,
> > +                                               list,
> > +                                               &updated_list,
> > +                                               &updated_list_size);
> > +            if (rc) {
> > +                return rc;
> > +            }
> > +            cxl_create_dc_event_records_for_extents(ct3d,
> > +                                                    DC_EVENT_RELEASE_CAPACITY,
> > +                                                    in->extents,
> > +                                                    in->ext_count);
> > +            return CXL_MBOX_SUCCESS;
> > +        }
> > +        default: {
> > +            qemu_log_mask(LOG_UNIMP,
> > +                "CXL extent removal policy not supported.\n");
> > +            return CXL_MBOX_INVALID_INPUT;
> > +        }
> > +    }
> > +}
> > +
> >  static const struct cxl_cmd cxl_cmd_set[256][256] = {
> >      [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
> >          cmd_infostat_bg_op_abort, 0, 0 },
> > @@ -3772,6 +3844,13 @@ static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
> >          CXL_MBOX_CONFIG_CHANGE_CXL_RESET |
> >          CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
> >          CXL_MBOX_IMMEDIATE_DATA_CHANGE) },
> > +    [FMAPI_DCD_MGMT][INITIATE_DC_RELEASE] = { "INIT_DC_RELEASE",
> > +        cmd_fm_initiate_dc_release, ~0,
> > +        (CXL_MBOX_CONFIG_CHANGE_COLD_RESET |
> > +         CXL_MBOX_CONFIG_CHANGE_CONV_RESET |
> > +         CXL_MBOX_CONFIG_CHANGE_CXL_RESET |
> > +         CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
> > +         CXL_MBOX_IMMEDIATE_DATA_CHANGE) },
> >  };
> >  
> >  /*
> > -- 
> > 2.47.2
> >   
> 

