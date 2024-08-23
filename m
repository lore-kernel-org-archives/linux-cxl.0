Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F8418A6DD
	for <linux-cxl@vger.kernel.org>; Fri, 23 Aug 2024 15:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724426084; cv=none; b=JbCmuOhEsMfEPWqDrVo5p9F7CkM4AcnKDPw/Ga8z4MkTF58u5r7DQznFaRfbo/Z7XyIZXYHiG7Ve7LlRCymwugW905IlS3pcGwDghYbd/NQZAS1YIOONZ03S3ivr+YFDCRpI1WQ6z9DmAJXwVuaiQg1Iu6UelC+XknQ0MOkPdFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724426084; c=relaxed/simple;
	bh=D3razoRfG0wJO2/nFIsxABv9w2Atz+5GiMot4wCGH/8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QiJrnGkgSeQKCTOTq6fhYSWfXhzFwOeyLFG/QSSjsQZD4YtSuuBRNC061qri/GuLsyMQR890UVCX5QFDaTYzcfuyTFdRjLTz0ZenIrAcXUtI3Xtc5a9JcrDsNB0UUq2NPNTZ7LpFDYci/hyIhLgV2d4x50U/CY1O7D4YIRsYUSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Wr3SL3PHlz6K934;
	Fri, 23 Aug 2024 23:11:30 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 4CBC1140B18;
	Fri, 23 Aug 2024 23:14:35 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 23 Aug
 2024 16:14:35 +0100
Date: Fri, 23 Aug 2024 16:14:34 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: peng guo <engguopeng@buaa.edu.cn>
CC: <fan.ni@samsung.com>, <linux-cxl@vger.kernel.org>, Davidlohr Bueso
	<dave@stgolabs.net>
Subject: Re: [RESEND] hw/cxl: fix the determination of illegal physical
 addresses
Message-ID: <20240823161434.00004b30@Huawei.com>
In-Reply-To: <20240819120317.12505-1-engguopeng@buaa.edu.cn>
References: <20240819120317.12505-1-engguopeng@buaa.edu.cn>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 19 Aug 2024 20:03:17 +0800
peng guo <engguopeng@buaa.edu.cn> wrote:

> When physical address range in the input payload of scan media command
> exceeds static_mem_size but does not exceed the sum of static and dynamic
> memory, the scan media mailbox command unexpectedly returns an error code
> which is CXL_MBOX_INVALID_PA.
> 
> This patch determines whether the physical address is valid in two cases. 
> If dynamic memory exists, check whether the address range of the request 
> exceeds the range of static memory and dynamic memory.If dynamic memory 
> does not exist, then check whether the address range of the request 
> exceeds the static memory size.
> 
> Fixes: d61cc5b6a8d3 ("hw/cxl: Add get scan media capabilities cmd support")
Is that the right one, this code is affecting cmd_media_scan_media()
not the capabilities one which always limits to static_mem_size and
hence also looks wrong.

> Signed-off-by: peng guo <engguopeng@buaa.edu.cn>

As with the other patch, this needs to go to qemu-devel list
+ both should have gone to Davidlohr as author the patch you
are fixing (sort of it, it's mostly down to what order patches
landed in I think).

Fan, Davidlohr, do we want to just cover the DCD regions as
well with all the scan_media commands?


> ---
>  hw/cxl/cxl-mailbox-utils.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 3ebbd32e10..b23c6b9b0b 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -1943,11 +1943,12 @@ static CXLRetCode cmd_media_scan_media(const struct cxl_cmd *cmd,
>      }
>      query_length = ldq_le_p(&in->length) * CXL_CACHE_LINE_SIZE;
>  
> -    if (query_start + query_length > cxl_dstate->static_mem_size) {
> -        return CXL_MBOX_INVALID_PA;
> -    }
> -    if (ct3d->dc.num_regions && query_start + query_length >=
> +    if (ct3d->dc.num_regions) {
> +        if (query_start + query_length >=
>              cxl_dstate->static_mem_size + ct3d->dc.total_capacity) {
> +                return CXL_MBOX_INVALID_PA;
> +            }
> +    } else if (query_start + query_length > cxl_dstate->static_mem_size) {
>          return CXL_MBOX_INVALID_PA;
>      }
Can we not rely on dc.total_capacity == 0 if num_regions == 0/

>  

