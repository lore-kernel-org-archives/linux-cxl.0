Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D52D204096;
	Wed, 13 Aug 2025 12:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755089533; cv=none; b=lOpBJ/XLjIXGwP64GShYvS5MalUp6hrSfLD4O60qzLV7Yl78GmXHdUXdZjSzs/uLsDKyAk4M8rS9unsr4NCrN3Ct7ugnOngmCNOCk0DWeyQrSQ1MU1jErcbYfsy8PYsVYXeqtWq+QaX9u42Kv8DRIfBVlK47cgys4FVbnVx8ev8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755089533; c=relaxed/simple;
	bh=l8A1f19/7rafjCS8KEHZsUMDwrECBCi+qU+KxMF3r+o=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qrsF9UyXuXxmoF4AfP5ED9HS1KHOtvw+tBXsPqQONDI0D4Utq0SJHdx9A6Yk/wN8WgNX8ayKIkWx864PXniBEyyIEOhtTEo2p/6KqaUQpZXRx7tPgsYkxCDrLoo3811AAiaVC/qG2ViAqxmshmEyvDbwkrO9h5z+1iOQjH2B7eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4c27Vc4C18z6L50X;
	Wed, 13 Aug 2025 20:49:28 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 614691402FF;
	Wed, 13 Aug 2025 20:52:09 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 13 Aug
 2025 14:52:08 +0200
Date: Wed, 13 Aug 2025 13:52:07 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <darshanrathod475@gmail.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <shiju.jose@huawei.com>, <ming.li@zohomail.com>,
	<peterz@infradead.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl: remove assignment from if condition in
 cxl_mem_get_poison
Message-ID: <20250813135207.00000727@huawei.com>
In-Reply-To: <20250813115554.388368-1-darshanrathod475@gmail.com>
References: <20250813115554.388368-1-darshanrathod475@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 13 Aug 2025 17:25:54 +0530
darshanrathod475@gmail.com wrote:

> From: Darshan Rathod <darshanrathod475@gmail.com>
> 
> Refactor cxl_mem_get_poison() to assign the return value of
> ACQUIRE_ERR() before the conditional check, instead of performing the
> assignment inside the if condition. This resolves a checkpatch.pl
> warning ("do not use assignment in if condition") and improves
> readability.
> 
> Signed-off-by: Darshan Rathod <darshanrathod475@gmail.com>
See:
https://lore.kernel.org/all/20250813003821.2891532-1-alison.schofield@intel.com/

Which stops checkpatch complaining about this.
Let's see where that discussion ends up before considering 'fixing' this.

Jonathan

> ---
>  drivers/cxl/core/mbox.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index fa6dd0c94656..9c5066631896 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1426,7 +1426,9 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
>  	int rc;
>  
>  	ACQUIRE(mutex_intr, lock)(&mds->poison.mutex);
> -	if ((rc = ACQUIRE_ERR(mutex_intr, &lock)))
> +
> +	rc = ACQUIRE_ERR(mutex_intr, &lock);
> +	if (rc)
>  		return rc;
>  
>  	po = mds->poison.list_out;

