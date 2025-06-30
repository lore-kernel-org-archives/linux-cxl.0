Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D86A28C2B3
	for <linux-cxl@vger.kernel.org>; Mon, 30 Jun 2025 17:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751303209; cv=none; b=g464gP/yHxiCVFTRWUysKxlePKXyrJIQyQRYjMJn0sGcv+pxR/DLD8bTKaZ2Xss7G9SoJqW+9/wNmRNIZ4PIoF0u+A9wwY0BSXLKm37czyc2x1MVQTZyeKOFusyM6JSx33EMqr7f50O9gy0775DwAMLDQYbBM5UZVJi217kV4P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751303209; c=relaxed/simple;
	bh=NRovVznRHz6NX1kMr8bjZkOcuM4gCS9Fk7EaOvfc0wo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WH3sudo50/v3zNJvl1GEbmoJjRspEe6Mq4EqYHBSOyxKrH9Yyuybm/CIDFl99S/kde09thVnn3viKhbjY4vzomuYeRgBbqDsQStzYIrcImAC0w4UcTCdcuGM1QKPv+fSoPXglxOUsIAP2ytbKAlxyMB9EjLHQN7FRXFjqiT6R4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bWCDV0hZxz6L5Qs;
	Tue,  1 Jul 2025 01:03:54 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 2479A1402FC;
	Tue,  1 Jul 2025 01:06:42 +0800 (CST)
Received: from localhost (10.122.19.247) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 30 Jun
 2025 19:06:41 +0200
Date: Mon, 30 Jun 2025 18:06:40 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <anisa.su887@gmail.com>
CC: <qemu-devel@nongnu.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
	<alok.a.tiwari@oracle.com>, <linux-cxl@vger.kernel.org>, Anisa Su
	<anisa.su@samsung.com>
Subject: Re: [QEMU PATCH v4 10/10] cxl-mailbox-utils: 0x5605 - FMAPI
 Initiate DC Release
Message-ID: <20250630180640.00001fad@huawei.com>
In-Reply-To: <20250626222743.1766404-11-anisa.su887@gmail.com>
References: <20250626222743.1766404-1-anisa.su887@gmail.com>
	<20250626222743.1766404-11-anisa.su887@gmail.com>
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

On Thu, 26 Jun 2025 22:23:33 +0000
anisa.su887@gmail.com wrote:

> From: Anisa Su <anisa.su@samsung.com>
> 
> FM DCD Management command 0x5605 implemented per CXL r3.2 Spec Section 7.6.7.6.6
> 
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
A few more long line related tweaks.

> ---
>  hw/cxl/cxl-mailbox-utils.c | 79 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 79 insertions(+)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 787eeaa7b9..87f9535d46 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -123,6 +123,7 @@ enum {
>          #define SET_DC_REGION_CONFIG        0x2
>          #define GET_DC_REGION_EXTENT_LIST   0x3
>          #define INITIATE_DC_ADD             0x4
> +        #define INITIATE_DC_RELEASE         0x5
>  };
>  
>  /* CCI Message Format CXL r3.1 Figure 7-19 */
> @@ -3638,6 +3639,77 @@ static CXLRetCode cmd_fm_initiate_dc_add(const struct cxl_cmd *cmd,
>      }
>  }
>  
> +#define CXL_EXTENT_REMOVAL_POLICY_MASK 0x0F
> +#define CXL_FORCED_REMOVAL_MASK (1 << 4)
> +/* CXL r3.2 Section 7.6.7.6.6 Initiate Dynamic Capacity Release (Opcode 5605h) */

Added a colon and wrapped after the number.

> +static CXLRetCode cmd_fm_initiate_dc_release(const struct cxl_cmd *cmd,
> +                                             uint8_t *payload_in,
> +                                             size_t len_in,
> +                                             uint8_t *payload_out,
> +                                             size_t *len_out,
> +                                             CXLCCI *cci)
> +{
> +    struct {
> +        uint16_t host_id;
> +        uint8_t flags;
> +        uint8_t reg_num;
> +        uint64_t length;
> +        uint8_t tag[0x10];
> +        uint32_t ext_count;
> +        CXLDCExtentRaw extents[];
> +    } QEMU_PACKED *in = (void *)payload_in;
> +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> +    int i, rc;
> +
> +    switch (in->flags & CXL_EXTENT_REMOVAL_POLICY_MASK) {
> +        case CXL_EXTENT_REMOVAL_POLICY_PRESCRIPTIVE: {
> +            CXLDCExtentList updated_list;
> +            uint32_t updated_list_size;
> +            g_autofree CXLUpdateDCExtentListInPl *list =
> +                g_malloc0(sizeof(*list) +
> +                    in->ext_count * sizeof(*list->updated_entries));
> +
> +            convert_raw_extents(in->extents, list, in->ext_count);
> +            rc = cxl_detect_malformed_extent_list(ct3d, list);
> +            if (rc) {
> +                return rc;
> +            }
> +
> +            /* Fail with Invalid PA if an extent is pending and Forced Removal

/*
 * Fail...

> +             * flag not set
> +             */
> +            if (!(in->flags & CXL_FORCED_REMOVAL_MASK)) {
> +                for (i = 0; i < in->ext_count; i++) {
> +                    CXLDCExtentRaw ext = in->extents[i];
> +                    /* Check requested extents don't overlap with pending extents. */
Made this a multiline comment. 

> +                    if (cxl_extent_groups_overlaps_dpa_range(&ct3d->dc.extents_pending,
This is quite a bit too far over so I just went with the ugly
                    if (cxl_extent_groups_overlaps_dpa_range(
                            &ct3d->dc.extents_pending,

> +                                                             ext.start_dpa, ext.len)) {
> +                        return CXL_MBOX_INVALID_PA;


