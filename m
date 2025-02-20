Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB51D214A99
	for <linux-cxl@vger.kernel.org>; Thu, 20 Feb 2025 17:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740071584; cv=none; b=dg6mUF+ka8wZAjywOjfUkil1av/Vj+pPLiHIU1GAbVJkw9FU0l1Ilzxs/2qStbjIq0Ba0m62E5Tqf6dxOpwN4RU3JZ/UnSDxkLzEE39JVuJNb23QixLHD43lHDLZnrbdCIwZzAKvxzpaCiRhsXaTuZXlMJF9R49GKnXBR/FKo3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740071584; c=relaxed/simple;
	bh=lV7TcScsIRAKPDlTrdQMI5rMpotWjokiuo1bDm/dhMU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KWcb3/WqdpGQIL1J/efwBYlnolmBDj1SjqHOdI0dQ6NicpS730nPpwwLRqX5m7kM4R0CXc+A+H6RUl71t7c/G+HQiKa8Z5/FWpCDfUkh3/GmEAmZoAaxQb+qdGlrg4L2SHFUxB33SqTV6hIFTiJWv9CJwsRtLywu4cW0P/+9Oyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YzKWx2yDRz67HSr;
	Fri, 21 Feb 2025 01:10:21 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 45AFD140B55;
	Fri, 21 Feb 2025 01:12:59 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 20 Feb
 2025 18:12:58 +0100
Date: Thu, 20 Feb 2025 17:12:57 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<alison.schofield@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <seven.yi.lee@gmail.com>, <ming.li@zohomail.com>,
	<a.manzanares@samsung.com>, <fan.ni@samsung.com>, <anisa.su@samsung.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/4] cxl/pmem: Rename cxl_dirty_shutdown_state()
Message-ID: <20250220171257.0000605f@huawei.com>
In-Reply-To: <20250220013604.263489-3-dave@stgolabs.net>
References: <20250220013604.263489-1-dave@stgolabs.net>
	<20250220013604.263489-3-dave@stgolabs.net>
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

On Wed, 19 Feb 2025 17:36:02 -0800
Davidlohr Bueso <dave@stgolabs.net> wrote:

> ... to a better suited 'cxl_arm_dirty_shutdown()'.

But it works on x86 as well! I'll cope I suppose.

Mind you why not let it take the state as a parameter
and always pass 1?  From a mailbox command point of
view 0 is valid. The text in table 8-152 has me a little confused
but I think it says you can set it to 1 and back to 0 and
then reset at which point the dirty shutdown count will
not increment.

No idea why you'd do that, but just passing a 1 into
this function would make a call of
cxl_set_dirty_shutdown_state(mds, 1)
seem reasonable, or pass a boolean.
 



> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Li Ming <ming.li@zohomail.com>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  drivers/cxl/core/mbox.c | 4 ++--
>  drivers/cxl/cxlmem.h    | 2 +-
>  drivers/cxl/pmem.c      | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index c5eedcae3b02..86d13f4a1c18 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1281,7 +1281,7 @@ int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_mem_dpa_fetch, "CXL");
>  
> -int cxl_dirty_shutdown_state(struct cxl_memdev_state *mds)
> +int cxl_arm_dirty_shutdown(struct cxl_memdev_state *mds)
>  {
>  	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
>  	struct cxl_mbox_cmd mbox_cmd;
> @@ -1297,7 +1297,7 @@ int cxl_dirty_shutdown_state(struct cxl_memdev_state *mds)
>  
>  	return cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
>  }
> -EXPORT_SYMBOL_NS_GPL(cxl_dirty_shutdown_state, "CXL");
> +EXPORT_SYMBOL_NS_GPL(cxl_arm_dirty_shutdown, "CXL");
>  
>  int cxl_set_timestamp(struct cxl_memdev_state *mds)
>  {

