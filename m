Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1851758B
	for <linux-cxl@vger.kernel.org>; Tue,  7 Oct 2025 14:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759848754; cv=none; b=VR5YbvWhx3SrEJaW57KIZRkSyh7s1rXLRc9iChU+ag2Bnjw/Q1fxPnZsVeV6rZm3rtQs2z3+AGwuTOKmjqy8xqugZNawM5T3t6SRONrqb9czQ+vGn/xYrz4IMKa5vxRNXCR0eVHi+2Ua8QvVVBzigFgPfx6kLKhYFKV+PPfNWoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759848754; c=relaxed/simple;
	bh=Na8NZYlUHiXTs4VZQKdW7Y3nEr9AeulshI9CZTO5ij8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gacdOiqtyFLGsC2dErMSQOCBU5QAdv2Ca3Cr+WLW4b39utmRF8yFe/ZrJLpb3+gHQZ7m+umop4kVI9lHFNBZXa08AfQ15gPT8y2geaUyXFIKzhs8mF/6JmklA8FtHQ5LDY8pTibMl5i+pzPPVGkcn6OjUOM2UXPSfdzFHh07TzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cgzZH68S9z6L4x7;
	Tue,  7 Oct 2025 22:49:59 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 115AE1402CB;
	Tue,  7 Oct 2025 22:52:30 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 7 Oct
 2025 15:52:29 +0100
Date: Tue, 7 Oct 2025 15:52:27 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <nvdimm@lists.linux.dev>, <linux-cxl@vger.kernel.org>,
	<dan.j.williams@intel.com>, <vishal.l.verma@intel.com>, <ira.weiny@intel.com>
Subject: Re: [PATCH] dax/hmem: Fix lockdep warning for
 hmem_register_resource()
Message-ID: <20251007155227.00003bbe@huawei.com>
In-Reply-To: <20251007001252.2710860-1-dave.jiang@intel.com>
References: <20251007001252.2710860-1-dave.jiang@intel.com>
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


> The lock ordering can cause potential deadlock. There are instances
> where hmem_resource_lock is taken after (node_chain).rwsem, and vice
> versa. Narrow the scope of hmem_resource_lock in hmem_register_resource()
> to avoid the circular locking dependency. The locking is only needed when
> hmem_active needs to be protected.
> 
> Fixes: 7dab174e2e27 ("dax/hmem: Move hmem device registration to dax_hmem.ko")
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

One trivial thing...

> ---
>  drivers/dax/hmem/device.c | 42 +++++++++++++++++++++++----------------
>  1 file changed, 25 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/dax/hmem/device.c b/drivers/dax/hmem/device.c
> index f9e1a76a04a9..ab5977d75d1f 100644
> --- a/drivers/dax/hmem/device.c
> +++ b/drivers/dax/hmem/device.c
> @@ -33,21 +33,37 @@ int walk_hmem_resources(struct device *host, walk_hmem_fn fn)
>  }
>  EXPORT_SYMBOL_GPL(walk_hmem_resources);
>  
> -static void __hmem_register_resource(int target_nid, struct resource *res)
> +static struct resource *hmem_request_resource(int target_nid,
> +					      struct resource *res)
>  {
> -	struct platform_device *pdev;
>  	struct resource *new;
> -	int rc;
>  
> -	new = __request_region(&hmem_active, res->start, resource_size(res), "",
> -			       0);
> +	guard(mutex)(&hmem_resource_lock);
> +	new = __request_region(&hmem_active, res->start,
> +			       resource_size(res), "", 0);

Why the rewrap?  Arguably it is slightly prettier but original was 80 chars
(I think) and making this change adds noise to the real code in this patch.

>  	if (!new) {
>  		pr_debug("hmem range %pr already active\n", res);
> -		return;
> +		return ERR_PTR(-ENOMEM);
>  	}
>  
>  	new->desc = target_nid;
>  
> +	return new;
> +}


