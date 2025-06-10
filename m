Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881621D90C8
	for <linux-cxl@vger.kernel.org>; Tue, 10 Jun 2025 15:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749568636; cv=none; b=LG7P7akm49fBFCpkf36PXIInDW5HXW7LPXJIJOtPegEE1Fw3z0Z9JRC70B/XXeeYvvIbTMLaABcPs5cL6dPOvsnZ/L/8gcU7P2oQ8aC0epUxo1uNq8Rr7LgQmOA5hv1XGX1R2eiL128sPEuxXC/uPcdwomABJFBseN3zmK/6TAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749568636; c=relaxed/simple;
	bh=gzOb7m5lMV3D0ybEYdcbFQWfOKrkIoAdXFLqpdsjAQ8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=umHe3ZD9FojJR6+mj5XTR/0+exMmfhte7UjMC5yrSmqyUYm1UD04QjjDn+Eq3pYfgLY3PEV9mpixWHaRoo1sk64Xk3MTWQRHKExLKvfsINHHHk6tmePMyKHUCA1/c8RBG+1xan1PwqLo6ZA6rWREWI+7mA+cCwPkVpHHpwpnLSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bGsp76D4bz6D8gq;
	Tue, 10 Jun 2025 23:16:47 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id D05271402FE;
	Tue, 10 Jun 2025 23:17:10 +0800 (CST)
Received: from localhost (10.122.19.247) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 10 Jun
 2025 17:17:10 +0200
Date: Tue, 10 Jun 2025 16:17:09 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Anisa Su <anisa.su887@gmail.com>
CC: ALOK TIWARI <alok.a.tiwari@oracle.com>, <qemu-devel@nongnu.org>,
	<nifan.cxl@gmail.com>, <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>
Subject: Re: [QEMU PATCH v3 8/9] cxl-mailbox-utils: 0x5604 - FMAPI Initiate
 DC Add
Message-ID: <20250610161709.000059f7@huawei.com>
In-Reply-To: <aEMly5F8kdziHWzO@deb-101020-bm01.eng.stellus.in>
References: <20250605234227.970187-1-anisa.su887@gmail.com>
	<20250605234227.970187-9-anisa.su887@gmail.com>
	<09aea84f-8c3f-4321-879d-35c8956b3573@oracle.com>
	<aEMly5F8kdziHWzO@deb-101020-bm01.eng.stellus.in>
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


> > > +/* CXL r3.2 Section 7.6.7.6.5 Initiate Dynamic Capacity Add (Opcode 5604h) */
> > > +static CXLRetCode cmd_fm_initiate_dc_add(const struct cxl_cmd *cmd,
> > > +                                         uint8_t *payload_in,
> > > +                                         size_t len_in,
> > > +                                         uint8_t *payload_out,
> > > +                                         size_t *len_out,
> > > +                                         CXLCCI *cci)
> > > +{
> > > +    struct {
> > > +        uint16_t host_id;
> > > +        uint8_t selection_policy;
> > > +        uint8_t reg_num;
> > > +        uint64_t length;
> > > +        uint8_t tag[0x10];
> > > +        uint32_t ext_count;
> > > +        CXLDCExtentRaw extents[];
> > > +    } QEMU_PACKED *in = (void *)payload_in;
> > > +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> > > +    CXLUpdateDCExtentListInPl *list;
> > > +    int i, rc;
> > > +
> > > +    switch (in->selection_policy) {
> > > +    case CXL_EXTENT_SELECTION_POLICY_PRESCRIPTIVE:
> > > +        /* Adding extents exceeds device's extent tracking ability. */
> > > +        if (in->ext_count + ct3d->dc.total_extent_count >
> > > +            CXL_NUM_EXTENTS_SUPPORTED) {
> > > +            return CXL_MBOX_RESOURCES_EXHAUSTED;
> > > +        }
> > > +
> > > +        list = calloc(1, (sizeof(*list) +
> > > +                          in->ext_count * sizeof(*list->updated_entries)));
> > > +        convert_raw_extents(in->extents, list, in->ext_count);
> > > +        rc = cxl_detect_malformed_extent_list(ct3d, list);
> > > +
> > > +        for (i = 0; i < in->ext_count; i++) {
> > > +            CXLDCExtentRaw ext = in->extents[i];
> > > +             /* Check requested extents do not overlap with pending extents. */
> > > +            if (cxl_extent_groups_overlaps_dpa_range(&ct3d->dc.extents_pending,
> > > +                                                     ext.start_dpa, ext.len)) {
> > > +                return CXL_MBOX_INVALID_EXTENT_LIST;
> > > +            }
> > > +            /* Check requested extents do not overlap with existing extents. */
> > > +            if (cxl_extents_overlaps_dpa_range(&ct3d->dc.extents,
> > > +                                               ext.start_dpa, ext.len)) {
> > > +                return CXL_MBOX_INVALID_EXTENT_LIST;
> > > +            }
> > > +        }
> > > +
> > > +        if (rc) {
> > > +            return rc;  
> > 
> > is list free not require ?
> >   
> oh yeah it's definitely required :( that was dumb of me, same for the
> next patch.

Use a g_autofree marking for this probably given it is just
a local temp array I think.

> 
> Thanks for catching that!
> -Anisa
> > > +        }
> > > +
> > > +        cxl_mbox_dc_add_to_pending(ct3d, in->ext_count, in->extents);
> > > +        cxl_mbox_create_dc_event_records_for_extents(ct3d,
> > > +                                                     DC_EVENT_ADD_CAPACITY,
> > > +                                                     in->extents,
> > > +                                                     in->ext_count);
> > > +
> > > +        return CXL_MBOX_SUCCESS;
> > > +    default:
> > > +        qemu_log_mask(LOG_UNIMP,
> > > +                      "CXL extent selection policy not supported.\n");
> > > +        return CXL_MBOX_INVALID_INPUT;
> > > +    }
> > > +
> > > +    return CXL_MBOX_SUCCESS;  
> > 
> > CXL_MBOX_SUCCESS, this is unreachable
> >   
> > > +}
> > > +
> > >   static const struct cxl_cmd cxl_cmd_set[256][256] = {
> > >       [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
> > >           cmd_infostat_bg_op_abort, 0, 0 },
> > > @@ -3667,6 +3812,13 @@ static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
> > >            CXL_MBOX_IMMEDIATE_DATA_CHANGE) },
> > >       [FMAPI_DCD_MGMT][GET_DC_REGION_EXTENT_LIST] = { "GET_DC_REGION_EXTENT_LIST",
> > >           cmd_fm_get_dc_region_extent_list, 12, 0 },
> > > +    [FMAPI_DCD_MGMT][INITIATE_DC_ADD] = { "INIT_DC_ADD",
> > > +        cmd_fm_initiate_dc_add, ~0,
> > > +        (CXL_MBOX_CONFIG_CHANGE_COLD_RESET |
> > > +        CXL_MBOX_CONFIG_CHANGE_CONV_RESET |
> > > +        CXL_MBOX_CONFIG_CHANGE_CXL_RESET |
> > > +        CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
> > > +        CXL_MBOX_IMMEDIATE_DATA_CHANGE) },
> > >   };  
> > 
> > 
> > Thanks,
> > Alok  

