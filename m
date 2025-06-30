Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB7615E5C2
	for <linux-cxl@vger.kernel.org>; Mon, 30 Jun 2025 17:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751302879; cv=none; b=MRAr8YC9MvYdHSGWMbbRgGmOeIg6Wn5KZ4nW0EdDoW+i+8Opxh2QozV2GsCU2jOCT/uX3bQniF8//fM2edVCtPL5J98BNy86uMPegZhP5iy5h3eRwmeip9dF9EZPaqbyZcyAwbnYh7AQW8ZxPo8iSVR2bjB0PjH1GsTpwkAv3kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751302879; c=relaxed/simple;
	bh=y4mbGLk91sO4vmIyPUxihXD5kc9b5Irv9w+irJBg9GA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qYsDSTlItPYktUz3kZTM7qRkz0Gru2/HSniwAXTpC75xc+NgsWpmGN67NQcUV9rAP76d1ml8NcU9Jx5zBOQCLEAK8JIW9252lSimJs9vJ3OLlWTTXIhD91lJvs08lDWqUgWKg34T9xRtp4KePvV1FoFnw2yFrjnhAP/5I/nlfyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bWC8M08ZRz6M55w;
	Tue,  1 Jul 2025 01:00:19 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id DD4581400CA;
	Tue,  1 Jul 2025 01:01:11 +0800 (CST)
Received: from localhost (10.122.19.247) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 30 Jun
 2025 19:01:11 +0200
Date: Mon, 30 Jun 2025 18:01:10 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <anisa.su887@gmail.com>
CC: <qemu-devel@nongnu.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
	<alok.a.tiwari@oracle.com>, <linux-cxl@vger.kernel.org>, Anisa Su
	<anisa.su@samsung.com>
Subject: Re: [QEMU PATCH v4 09/10] cxl-mailbox-utils: 0x5604 - FMAPI
 Initiate DC Add
Message-ID: <20250630180110.0000060d@huawei.com>
In-Reply-To: <20250626222743.1766404-10-anisa.su887@gmail.com>
References: <20250626222743.1766404-1-anisa.su887@gmail.com>
	<20250626222743.1766404-10-anisa.su887@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 26 Jun 2025 22:23:32 +0000
anisa.su887@gmail.com wrote:

> From: Anisa Su <anisa.su@samsung.com>
> 
> FM DCD Management command 0x5604 implemented per CXL r3.2 Spec Section 7.6.7.6.5

There are a few long lines in here check patch doesn't like.


I tweaked as described inline whilst picking them up.


> 
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
> ---
>  hw/cxl/cxl-mailbox-utils.c  | 106 ++++++++++++++++++++++++++++++++++++
>  hw/mem/cxl_type3.c          |   8 +--
>  include/hw/cxl/cxl_device.h |   4 ++
>  3 files changed, 114 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 382c41c025..787eeaa7b9 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c


> +/* CXL r3.2 Section 7.6.7.6.5 Initiate Dynamic Capacity Add (Opcode 5604h) */
> +static CXLRetCode cmd_fm_initiate_dc_add(const struct cxl_cmd *cmd,
> +                                         uint8_t *payload_in,
> +                                         size_t len_in,
> +                                         uint8_t *payload_out,
> +                                         size_t *len_out,
> +                                         CXLCCI *cci)
> +{
> +    struct {
> +        uint16_t host_id;
> +        uint8_t selection_policy;
> +        uint8_t reg_num;
> +        uint64_t length;
> +        uint8_t tag[0x10];
> +        uint32_t ext_count;
> +        CXLDCExtentRaw extents[];
> +    } QEMU_PACKED *in = (void *)payload_in;
> +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> +    int i, rc;
> +
> +    switch (in->selection_policy) {
> +        case CXL_EXTENT_SELECTION_POLICY_PRESCRIPTIVE: {
> +            /* Adding extents exceeds device's extent tracking ability. */
> +            if (in->ext_count + ct3d->dc.total_extent_count >
> +                CXL_NUM_EXTENTS_SUPPORTED) {
> +                return CXL_MBOX_RESOURCES_EXHAUSTED;
> +            }
> +
> +            g_autofree CXLUpdateDCExtentListInPl *list =
> +                g_malloc0(sizeof(*list) +
> +                    in->ext_count * sizeof(*list->updated_entries));
> +
> +            convert_raw_extents(in->extents, list, in->ext_count);
> +            rc = cxl_detect_malformed_extent_list(ct3d, list);
> +
> +            for (i = 0; i < in->ext_count; i++) {
> +                CXLDCExtentRaw ext = in->extents[i];

Using a pointer here avoids copying data for no particular reason.

> +                /* Check requested extents do not overlap with pending extents. */
This is a touch long.   I tweaked to end with ... pending ones.
Given we are talking extents that should be clear.

> +                if (cxl_extent_groups_overlaps_dpa_range(&ct3d->dc.extents_pending,
This is the one case I'll leave as it is not nice to wrap it anywhere different.

> +                                                         ext.start_dpa, ext.len)) {
wrapped this

> +                    return CXL_MBOX_INVALID_EXTENT_LIST;
> +                }
> +                /* Check requested extents do not overlap with existing extents. */
exiting ones. */
> +                if (cxl_extents_overlaps_dpa_range(&ct3d->dc.extents,
> +                                                   ext.start_dpa, ext.len)) {
Wrapped this.

> +                    return CXL_MBOX_INVALID_EXTENT_LIST;
> +                }
> +            }
> +
> +            if (rc) {
> +                return rc;
> +            }
> +
> +            CXLDCExtentGroup *group = NULL;
> +            for (i = 0; i < in->ext_count; i++) {

Used
                   CXLDCExtentRaw *ext = &in->extents[i];

> +                group = cxl_insert_extent_to_extent_group(group,
> +                                                          in->extents[i].start_dpa,

To shorten all these (similar to previous loop)

> +                                                          in->extents[i].len,
> +                                                          in->extents[i].tag,
> +                                                          in->extents[i].shared_seq);
> +            }
> +
> +            cxl_extent_group_list_insert_tail(&ct3d->dc.extents_pending, group);
> +            ct3d->dc.total_extent_count += in->ext_count;
> +            cxl_create_dc_event_records_for_extents(ct3d,
> +                                                    DC_EVENT_ADD_CAPACITY,
> +                                                    in->extents,
> +                                                    in->ext_count);
> +
> +            return CXL_MBOX_SUCCESS;
> +        }
> +        default: {
> +            qemu_log_mask(LOG_UNIMP,
> +                          "CXL extent selection policy not supported.\n");
> +            return CXL_MBOX_INVALID_INPUT;
> +        }
> +    }
> +}


