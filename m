Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BFF5028C
	for <linux-cxl@vger.kernel.org>; Tue, 21 Jan 2025 16:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737476658; cv=none; b=qnCC8gjaKhfYVX14t6PZpOmSLsRMIjzMP8t3wo8SGr4eyuAo0cJ/wcq459CiVcGcBvMHbbGFcRxw+y5e5B0NnFBOBARw4+z1dopXg/M5qRYryxft+3jYBmmygrC5n9u84YX6PIRVCG+Oar6SyHopryoj7nW0UE148FcByD3GuQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737476658; c=relaxed/simple;
	bh=CmwihuSoQUKQRPX0+D0qaxaqV/SCTNc9/6vSh9Owk5Y=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YxhtzqYtgLM6QCP5IWkxg9rw6LHh8bmsvsTxu1JpklcmML+YXUhgX8yBXss7ebgCG31HMVONUb74XnIkQqDKvk+yy4SXcBwb0xHUYnumXjGj0Qf9BatP90s/Uv1YHSyGcp+pSDmT9NxJUUyfXiOYHDr2sP2yXgI4M1NRq56ZoGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YcstL0p2dz6M4fG;
	Wed, 22 Jan 2025 00:22:18 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 7537B140A46;
	Wed, 22 Jan 2025 00:24:12 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 21 Jan
 2025 17:24:12 +0100
Date: Tue, 21 Jan 2025 16:24:10 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Hongjian Fan <hongjian.fan@seagate.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, <fan.ni@samsung.com>
Subject: Re: [PATCH v2] hw/mem: support zero memory size CXL device
Message-ID: <20250121162410.000009fa@huawei.com>
In-Reply-To: <20241204022618.1572959-1-hongjian.fan@seagate.com>
References: <20241203172328.00001a00@huawei.com>
	<20241204022618.1572959-1-hongjian.fan@seagate.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue,  3 Dec 2024 20:26:19 -0600
Hongjian Fan <hongjian.fan@seagate.com> wrote:

> This patch allows a CXL type3 device to be initialized with zero memory
> size, when there is no memory device property provided.
> 
> Signed-off-by: Hongjian Fan <hongjian.fan@seagate.com>
Hi Hongjian

Some remaining questions on the v1 thread.
We need to understand a little more on why this is useful to support.
It's adding another thing we need to test so whilst simple it's not
zero maintenance cost.

Thanks,

Jonathan

> ---
>  hw/mem/cxl_type3.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 5cf754b38f..4c9d6b8f17 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -159,7 +159,12 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
>      int len = 0;
>  
>      if (!ct3d->hostpmem && !ct3d->hostvmem && !ct3d->dc.num_regions) {
> -        return 0;
> +        /* zero memory size device. Build one entry with size 0 */
> +        table = g_malloc0(CT3_CDAT_NUM_ENTRIES * sizeof(*table));
> +        ct3_build_cdat_entries_for_mr(&(table[0]), dsmad_handle++,
> +                                0, false, false, 0);
> +        *cdat_table = g_steal_pointer(&table);
> +        return CT3_CDAT_NUM_ENTRIES;
>      }
>  
>      if (ct3d->hostvmem) {
> @@ -712,8 +717,11 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
>  
>      if (!ct3d->hostmem && !ct3d->hostvmem && !ct3d->hostpmem
>          && !ct3d->dc.num_regions) {
> -        error_setg(errp, "at least one memdev property must be set");
> -        return false;
> +        /* no memdev property provided. Default to zero memory size device */
> +        ct3d->cxl_dstate.pmem_size = 0;
> +        ct3d->cxl_dstate.vmem_size = 0;
> +        ct3d->cxl_dstate.static_mem_size = 0;
> +        return true;
>      } else if (ct3d->hostmem && ct3d->hostpmem) {
>          error_setg(errp, "[memdev] cannot be used with new "
>                           "[persistent-memdev] property");

