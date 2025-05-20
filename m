Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E432459C9
	for <linux-cxl@vger.kernel.org>; Tue, 20 May 2025 13:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747748055; cv=none; b=ehu/aiDMdtOeydku5zRlpjfg00hG9KRe4M8zWSqMHKPjPt3ZcXkEnEpRQmXei9sCmL+rL9vGNic8Nl8XK0iN2EMktpQUa+F6+BRBXNySit/sCtilq4MCx1doTaCNH28L2Gi8bu5+ax7fjmYqfphnhBUOrq3CwBAkdJWMFxB0A6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747748055; c=relaxed/simple;
	bh=aXjEIuhKY85m9rL7sOGKlpcSAx6GWzhnqeGa6gQpgQA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H4J4YVwibBVVLTDpiclP5ZDIaf6D3zEzICyGfjkYKzPu56tliYoCKl3yO9+LhPqMq8q+hLlmyNnuy9qsTcVcg3lIjdOhmiTfYd5piIK8fupgqhIIQy7kiApXXPHPwUKrem7gd4X0mtEE+xaAyBgU9VIujmbBG9MvjO/YuUVnPkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b1wRp1Mxjz6L5H6;
	Tue, 20 May 2025 21:31:02 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 77B7C14050C;
	Tue, 20 May 2025 21:34:10 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 20 May
 2025 15:34:10 +0200
Date: Tue, 20 May 2025 14:34:08 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <anisa.su887@gmail.com>
CC: <qemu-devel@nongnu.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
	<linux-cxl@vger.kernel.org>, Anisa Su <anisa.su@samsung.com>
Subject: Re: [PATCH v2 09/10] cxl-mailbox-utils: 0x5604 - FMAPI Initiate DC
 Add
Message-ID: <20250520143408.00003237@huawei.com>
In-Reply-To: <20250508001754.122180-10-anisa.su887@gmail.com>
References: <20250508001754.122180-1-anisa.su887@gmail.com>
	<20250508001754.122180-10-anisa.su887@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu,  8 May 2025 00:01:05 +0000
anisa.su887@gmail.com wrote:

> From: Anisa Su <anisa.su@samsung.com>
> 
> FM DCD Management command 0x5604 implemented per CXL r3.2 Spec Section 7.6.7.6.5
> 
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
A few really minor things inline.

> ---
>  hw/cxl/cxl-mailbox-utils.c   | 195 +++++++++++++++++++++++++++++++++++
>  hw/mem/cxl_type3.c           |   8 +-
>  include/hw/cxl/cxl_device.h  |   4 +
>  include/hw/cxl/cxl_opcodes.h |   1 +
>  4 files changed, 204 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index a897a34ef9..9b176dea08 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -3589,6 +3589,194 @@ static CXLRetCode cmd_fm_get_dc_region_extent_list(const struct cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
>  
> +static CXLRetCode cxl_mbox_dc_prescriptive_sanity_check(CXLType3Dev *dcd,
> +                                                        uint16_t host_id,
> +                                                        uint32_t ext_count,
> +                                                        CXLDCExtentRaw extents[],
> +                                                        CXLDCEventType type)
> +{
> +    CXLDCExtentRaw ext;
> +    CXLDCRegion *reg = NULL;

I'd move reg declaration into the loop and not initialize it to NULL.
Probably also j and ext.


> +    int i, j;
> +
> +    if (host_id != 0) {
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +
> +    for (i = 0; i < ext_count; i++) {
> +        ext = extents[i];
> +
> +        if (ext.len == 0) {
> +            return CXL_MBOX_INVALID_EXTENT_LIST;
> +        }
> +
> +        reg = cxl_find_dc_region(dcd, ext.start_dpa, ext.len);
> +        if (!reg) {
> +            return CXL_MBOX_INVALID_EXTENT_LIST;
> +        }
> +
> +        if (ext.len % reg->block_size || ext.start_dpa % reg->block_size) {
> +            return CXL_MBOX_INVALID_EXTENT_LIST;
> +        }
> +
> +        /* Check requested extents do not overlap with each other. */
> +        for (j = i + 1; j < ext_count; j++) {
> +            if (ranges_overlap(ext.start_dpa, ext.len, extents[j].start_dpa,
> +                               extents[j].len)) {
> +                return CXL_MBOX_INVALID_EXTENT_LIST;
> +            }
> +        }
> +
> +        if (type == DC_EVENT_ADD_CAPACITY) {
> +            /* Check requested extents do not overlap with pending extents. */
> +            if (cxl_extent_groups_overlaps_dpa_range(&dcd->dc.extents_pending,
> +                ext.start_dpa, ext.len)) {

Misaligned parameters.

> +                return CXL_MBOX_INVALID_EXTENT_LIST;
> +            }
> +            /* Check requested extents do not overlap with existing extents. */
> +            if (cxl_extents_overlaps_dpa_range(&dcd->dc.extents,
> +                                               ext.start_dpa, ext.len)) {
> +                return CXL_MBOX_INVALID_EXTENT_LIST;
> +            }
> +        }
> +    }
> +
> +    return CXL_MBOX_SUCCESS;
> +}
