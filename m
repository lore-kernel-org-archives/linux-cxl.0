Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B2715B12F
	for <linux-cxl@vger.kernel.org>; Wed, 28 Aug 2024 11:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724845626; cv=none; b=jlXiOCr0XbglVK8jN943n8BrPeWmB587S2GpSaDrHdH3V5yRpolcX3pNbTBJ2yRhFT4BdixL+VUpMekzuY0G37OCzhsUH+0v0XO1DKGh6bBDSHNpXJlDpQ7YnJQiBzKCwrE8gmd5MX3rUlDdFU2x3AcWRh55uWcN+Bx9EeyUsgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724845626; c=relaxed/simple;
	bh=55KBMSCmGARRn/o5enKXXD46Xuh1olvNBB6EJmpXbRI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YTck5GS37QJxneAuhLmTGDhbKNDALgkFHkCS1t6lt3+wAcTQo5kTOei6jCayAph0gOvufe6gc1ndne+2Z2etnKvHMO4jga0TiDe8JLs11bduNK1QQqi0Ui8w+xZ4P9btTuFQk6UV/48N+odGVK/9AHByycrJhTkKanVkoLQP96g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Wv2cK2XLQz6J7rT;
	Wed, 28 Aug 2024 19:43:45 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 84D34140B67;
	Wed, 28 Aug 2024 19:47:01 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 28 Aug
 2024 12:47:01 +0100
Date: Wed, 28 Aug 2024 12:47:00 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <nifan.cxl@gmail.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>,
	<a.manzanares@samsung.com>, <dave@stgolabs.net>, <nmtadam.samsung@gmail.com>,
	Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH 1/2] hw/mem/cxl_type3: Fix More flag setting for dynamic
 capacity event records
Message-ID: <20240828124700.0000151d@Huawei.com>
In-Reply-To: <20240827164304.88876-2-nifan.cxl@gmail.com>
References: <20240827164304.88876-1-nifan.cxl@gmail.com>
	<20240827164304.88876-2-nifan.cxl@gmail.com>
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
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 27 Aug 2024 09:40:04 -0700
nifan.cxl@gmail.com wrote:

> From: Fan Ni <fan.ni@samsung.com>
> 
> Per cxl spec r3.1, for multiple dynamic capacity event records grouped via
> the More flag, the last record in the sequence should clear the More flag.
> 
> Before the change, the More flag of the event record is cleared before
> the loop of inserting records into the event log, which will leave the flag
> always set once it is set in the loop.
> 
> Signed-off-by: Fan Ni <fan.ni@samsung.com>
Oops.  I'll queue this up, though not sure I'll get a fixes series
out this week so it might only hit after the QEMU release.

Jonathan

> ---
>  hw/mem/cxl_type3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index d648192ab9..e616801c81 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -2060,11 +2060,11 @@ static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *path,
>      stw_le_p(&dCap.host_id, hid);
>      /* only valid for DC_REGION_CONFIG_UPDATED event */
>      dCap.updated_region_id = 0;
> -    dCap.flags = 0;
>      for (i = 0; i < num_extents; i++) {
>          memcpy(&dCap.dynamic_capacity_extent, &extents[i],
>                 sizeof(CXLDCExtentRaw));
>  
> +        dCap.flags = 0;
>          if (i < num_extents - 1) {
>              /* Set "More" flag */
>              dCap.flags |= BIT(0);

