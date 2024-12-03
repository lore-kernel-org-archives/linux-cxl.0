Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5F51E570E
	for <linux-cxl@vger.kernel.org>; Tue,  3 Dec 2024 17:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733246615; cv=none; b=itt7Vfl7A/+AFZMmGogF4K5nmpAwcld68ryoqBOgxnUYilGtmNHZ1R/T51a0Ii6XL7ShXOqHwy+9uhrNFii/dsnHbLOWEH6Uakj3IaaY0OzjijEEpr02RXS+VlSEOB6mdTHNUi+4YeHRFRDrAHdpBYHQJQCczDZlWr3PejqmeHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733246615; c=relaxed/simple;
	bh=z39UDX9o1V2XcbH7aMI26HFWfz696/DSBf8+//1ZCE0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uFGEDlX14ZHFUw9I/4m7CVLobsKhlzcbbGd2Z4VrIHsdX9+/PxpyIJMZvLJTiqbNe7px0sH8gPN8uSQVbxzRQf0ayb87c6UOA5iRIqMtqaCOEwYFerp4cicpDmGQxHMALXI2hnUiI9SGcv7zlIMWfyeQgFuOE7DYl7lFXdTwOt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Y2nVD1RF9z6K9Db;
	Wed,  4 Dec 2024 01:20:36 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 89BE41401F4;
	Wed,  4 Dec 2024 01:23:30 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 3 Dec
 2024 18:23:30 +0100
Date: Tue, 3 Dec 2024 17:23:28 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Hongjian Fan <hongjian.fan@seagate.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, <fan.ni@samsung.com>
Subject: Re: [PATCH] hw/mem: support zero memory size CXL device
Message-ID: <20241203172328.00001a00@huawei.com>
In-Reply-To: <20241202230310.1531219-1-hongjian.fan@seagate.com>
References: <20241202230310.1531219-1-hongjian.fan@seagate.com>
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

On Mon,  2 Dec 2024 17:03:11 -0600
Hongjian Fan <hongjian.fan@seagate.com> wrote:

> According to CXL 3.1 specification, 8.1.3.8 DVSEC CXL Range Registers "A CXL.mem-capable device is permitted to report zero memory size."
> This patch will allow a CXL type3 device to be initialized with zero memory size, when there is no memory device property provided ( neither volatile, persistent, nor dynamic region).
Wrap at less than 75 chars.

I'm curious.  Why do you want to emulate such a device?

There are many things the CXL spec allows that we don't emulate.
I'd normally count this as just another one of those.

Jonathan


> 
> Signed-off-by: Hongjian Fan <hongjian.fan@seagate.com>
> ---
>  hw/mem/cxl_type3.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 5cf754b38f..35caa186ca 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -159,7 +159,12 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
>      int len = 0;
>  
>      if (!ct3d->hostpmem && !ct3d->hostvmem && !ct3d->dc.num_regions) {
> -        return 0;
> +        // zero memory size device. Build one entry with size 0

Comment syntax /* */

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
> +        // no memdev property provided. Default to zero memory size device
> +        ct3d->cxl_dstate.pmem_size = 0;
> +        ct3d->cxl_dstate.vmem_size = 0;
> +        ct3d->cxl_dstate.static_mem_size = 0;
> +        return true;
>      } else if (ct3d->hostmem && ct3d->hostpmem) {
>          error_setg(errp, "[memdev] cannot be used with new "
>                           "[persistent-memdev] property");

