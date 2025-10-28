Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEB527A47F
	for <linux-cxl@vger.kernel.org>; Tue, 28 Oct 2025 16:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761668470; cv=none; b=cFXrIgSSjO2WszcmOKAB8/bh30Qked0v26ZtyRLfPS26dm1qUknTQLC9lr+RrKWhM9BYWT+JCvcvepN/KAE8huM3lIB0UlNTBJGE/EqFMFaifqL5PgLUDXK8dT1a1TYeLm6G2YDYR2/zYtT8OGqt1fsytISJTthxHrScZG01TXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761668470; c=relaxed/simple;
	bh=9TPJO+8i0CFLSMK+nIezoxJ+66BJy7wb+dGUCenTsR4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qGhJAwbOzG+73TyvQbeAHjaRue9azmgi0J0yGrImm2uyEMwuHOM2LgiwWCuDERZOggf2OIZiDtuIHJyAyPY3OiwEkKui8SwlgI5TuXVOVi8JV0oK+p+RqjrZ+6HHEzajbAlrCUuqFgMU2EUHu3FporHdOeGhfP7Z7TBpLIOoSmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cwwWF2hxhz6M4hV;
	Wed, 29 Oct 2025 00:17:13 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id C92391402EB;
	Wed, 29 Oct 2025 00:21:02 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 28 Oct
 2025 16:21:02 +0000
Date: Tue, 28 Oct 2025 16:21:00 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: <anisa.su887@gmail.com>
CC: <qemu-devel@nongnu.org>, <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	Anisa Su <anisa.su@samsung.com>
Subject: Re: [QEMU PATCH 1/1] hw/cxl/cxl-mailbox-utils: Enable FMAPI
 Initiate Add for MHSLD
Message-ID: <20251028162100.00006fa8@huawei.com>
In-Reply-To: <20250927002125.860668-2-anisa.su887@gmail.com>
References: <20250927002125.860668-1-anisa.su887@gmail.com>
	<20250927002125.860668-2-anisa.su887@gmail.com>
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
 dubpeml100005.china.huawei.com (7.214.146.113)

On Sat, 27 Sep 2025 00:18:07 +0000
anisa.su887@gmail.com wrote:

> From: Anisa Su <anisa.su@samsung.com>
> 
> Call mhd_reserve_extents in FMAPI Init Add (5604h)to enable sending
> FMAPI Add command to MHSLD.
> 
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
Hi Anisa,

I've not been quick on this one partly because it sits on top of the MHSLD
work that I think needs a proper revisit to establish what is an up streamable
path, but I haven't had time to do that :(

Anyhow in meantime I'll take a look.  I suppose nothing stops me carrying
this on top.

Just one minor comment inline.
> ---
>  hw/cxl/cxl-mailbox-utils.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index c5177dfd92..9ac60db4e1 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -24,6 +24,7 @@
>  #include "system/hostmem.h"
>  #include "qemu/range.h"
>  #include "qapi/qapi-types-cxl.h"
> +#include "hw/cxl/mhsld/mhsld.h"
>  
>  #define CXL_CAPACITY_MULTIPLIER   (256 * MiB)
>  #define CXL_DC_EVENT_LOG_SIZE 8
> @@ -4163,6 +4164,8 @@ static CXLRetCode cmd_fm_initiate_dc_add(const struct cxl_cmd *cmd,
>          CXLDCExtentRaw extents[];
>      } QEMU_PACKED *in = (void *)payload_in;
>      CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> +    CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(ct3d);
> +    CXLDCRegion *region = &ct3d->dc.regions[in->reg_num];
>      int i, rc;
>  
>      switch (in->selection_policy) {
> @@ -4201,6 +4204,28 @@ static CXLRetCode cmd_fm_initiate_dc_add(const struct cxl_cmd *cmd,
>                  return rc;
>              }
>  
> +            /* If this is an MHD, attempt to reserve the extents */
> +            if (cvc->mhd_reserve_extents) {
> +                g_autofree CxlDynamicCapacityExtentList *records =
> +                    g_malloc0(in->ext_count * sizeof(*records));

I think it makes sense to use g_malloc0_n for these

I changed this whilst applying it locally so it'll be there next time
I push out a tree.

Thanks,

Jonathan


> +                g_autofree CxlDynamicCapacityExtent *dc_exts =
> +                    g_malloc0(in->ext_count * sizeof(*dc_exts));
> +
> +                for (i = 0; i < in->ext_count; i++) {
> +                    CxlDynamicCapacityExtent *value = &dc_exts[i];
> +                    value->offset =
> +                        in->extents[i].start_dpa - region->base;
> +                    value->len = in->extents[i].len;
> +
> +                    records[i].value = value;
> +                    records[i].next = &records[i + 1];
> +                }
> +                records[in->ext_count - 1].next = NULL;
> +                if (!cvc->mhd_reserve_extents(&ct3d->parent_obj, records, in->reg_num)) {
> +                    return CXL_MBOX_INVALID_INPUT;
> +                }
> +            }
> +
>              CXLDCExtentGroup *group = NULL;
>              for (i = 0; i < in->ext_count; i++) {
>                  CXLDCExtentRaw *ext = &in->extents[i];

