Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467FD22128F
	for <linux-cxl@vger.kernel.org>; Thu, 24 Apr 2025 10:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745489499; cv=none; b=Hyu6qjXVja4p7cTM1tqAXxG8Nt0f+bZgo/jIFJ5+yXkPmz4YqyMwbLwH9wvpkNjAJNixDxzBy1RQWCJd9c2za6ysn3fBMSYD1uKGCFJAbMU+rqEo6FBswW/2ilcTeQHN3ojnojHMp3jZqFeX9/MmazRfYHE8YZXKL4tVZHIWDL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745489499; c=relaxed/simple;
	bh=ya1i4YYF/Cr8pdDEty37CDjOgy8rX9gJbW8Cloud5gw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m7WLSn2XHKzloSOag/EzPAScaEYJqzPqRWp5UnicQGlM4J+++TEcnDgHnyvuhoAbg+M6vadDzFkvxwj86AXvpBpir26wHU/Wb4s8qORPC6U5c2KwKrWyZFxw+SrHVNvZul1hxDodquG+CvBAN7hr1xZey8FofEHzuDcpv7/MoRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Zjs8p2W4xz6M4KQ;
	Thu, 24 Apr 2025 18:07:22 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id F2FBF1400DB;
	Thu, 24 Apr 2025 18:11:32 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 24 Apr
 2025 12:11:32 +0200
Date: Thu, 24 Apr 2025 11:11:31 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <anisa.su887@gmail.com>
CC: <qemu-devel@nongnu.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
	<linux-cxl@vger.kernel.org>, Anisa Su <anisa.su@samsung.com>
Subject: Re: [PATCH 1/9] cxl/type3: Add supported block sizes bitmask to
 CXLDCRegion struct
Message-ID: <20250424111131.00005ff2@huawei.com>
In-Reply-To: <20250317164204.2299371-2-anisa.su887@gmail.com>
References: <20250317164204.2299371-1-anisa.su887@gmail.com>
	<20250317164204.2299371-2-anisa.su887@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 17 Mar 2025 16:31:28 +0000
anisa.su887@gmail.com wrote:

> From: Anisa Su <anisa.su@samsung.com>
> 
> Add supported_blk_size field to CXLDCRegion struct in preparation for
> next patch. It is needed by command 0x5600 Get DC Region Config.
Hi Anisa,

Sorry it took me so long to your series!

Squash this with patch 2.  It isn't complex enough addition to justify
as separate patch where we need to explain it is there for that patch
in the cover letter.

> 
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
> ---
>  hw/mem/cxl_type3.c          | 3 +++
>  include/hw/cxl/cxl_device.h | 1 +
>  2 files changed, 4 insertions(+)
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 11c38a9292..731497ebda 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -8,6 +8,7 @@
>   *
>   * SPDX-License-Identifier: GPL-v2-only
>   */
> +#include <math.h>
>  
>  #include "qemu/osdep.h"
>  #include "qemu/units.h"
> @@ -766,6 +767,7 @@ static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
>      uint64_t region_len;
>      uint64_t decode_len;
>      uint64_t blk_size = 2 * MiB;
> +    uint64_t supported_blk_size_bitmask = BIT((int) log2(blk_size));

Isn't this going in circles?  I guess it sort of acts as documentation that it
is a bitmap but then the name is already doing that. 
Maybe set it to blk_size and add a comment that for now only a fixed block size
is supported?

I'm a little confused on what this is for given you don't check it in patch 6
which is changing the block size?

>      CXLDCRegion *region;
>      MemoryRegion *mr;
>      uint64_t dc_size;
> @@ -811,6 +813,7 @@ static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
>              .block_size = blk_size,
>              /* dsmad_handle set when creating CDAT table entries */
>              .flags = 0,
> +            .supported_blk_size_bitmask = supported_blk_size_bitmask,
>          };
>          ct3d->dc.total_capacity += region->len;
>          region->blk_bitmap = bitmap_new(region->len / region->block_size);
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index ca515cab13..bebed04085 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -608,6 +608,7 @@ typedef struct CXLDCRegion {
>      uint32_t dsmadhandle;
>      uint8_t flags;
>      unsigned long *blk_bitmap;
> +    uint64_t supported_blk_size_bitmask;
>  } CXLDCRegion;
>  
>  typedef struct CXLSetFeatureInfo {

