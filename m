Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919F6132103
	for <linux-cxl@vger.kernel.org>; Thu, 21 Nov 2024 18:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732213599; cv=none; b=pmnQag7BXiWWe3CiqwRkQnqcYjuWN9BRVBtTGvHFHNHPaXKolxjBSkfRN2AK9cVX3aTRARlqtm7C9cTnJgRUJEhiinGlXq3E9ZFxn809kS7JzQmeUWGamK3MV8mx5AhQLmbkGTQciZ8SFP+X/RqQv/JJT+zTSfHSSj8GRk9R6i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732213599; c=relaxed/simple;
	bh=YEmT/PAJuMAjL4HUDV1xNdtuZoHbNs6dO9FXC+Zx0Ak=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S04OKzdXHBg71Ias0yU7Yn0moHVHVmcqXPiWcvu7/Ruc8b4beqTWVb0q5zU3bmvYbAr2O6QJicuP1EKaISvFaG1z77wxQ6EeMihHeaGmsd1NF46DkJX7ISJ2L0S4oLnQkhDLqnIyRaJqS24YAwTGwGMXb37UTU+44Kc9sgABex0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XvRT941SGz6K9BH;
	Fri, 22 Nov 2024 02:24:13 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 1BF7F140A70;
	Fri, 22 Nov 2024 02:26:34 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 21 Nov
 2024 19:26:33 +0100
Date: Thu, 21 Nov 2024 18:26:32 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [RFC PATCH v2 13/20] fwctl/cxl: Add hw_info callback
Message-ID: <20241121182632.00005410@huawei.com>
In-Reply-To: <20241115212745.869552-14-dave.jiang@intel.com>
References: <20241115212745.869552-1-dave.jiang@intel.com>
	<20241115212745.869552-14-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 15 Nov 2024 14:25:46 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

Needs a bit more info.


> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Otherwise trivial comment inline.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> diff --git a/drivers/fwctl/cxl/cxl.c b/drivers/fwctl/cxl/cxl.c
> index 5eb5eabf2bff..ce8960a9beaa 100644
> --- a/drivers/fwctl/cxl/cxl.c
> +++ b/drivers/fwctl/cxl/cxl.c
> @@ -53,6 +53,30 @@ static void *cxlctl_info(struct fwctl_uctx *uctx, size_t *length)
>  	return info;
>  }
>  
> +static void *cxlctl_hw_info(struct fwctl_uctx *uctx, int commands, size_t *out_len)
> +{
> +	struct cxlctl_uctx *cxlctl_uctx =
> +		container_of(uctx, struct cxlctl_uctx, uctx);
Some of this container stuff is starting to look very familiar.
Maybe worth some macros?

> +	struct fwctl_device *fwctl = uctx->fwctl;
> +	struct cxlctl_dev *cxlctl =
> +		container_of(fwctl, struct cxlctl_dev, fwctl);
> +	int rc;
> +
> +	if (commands > cxlctl_uctx->nr_commands)
> +		return ERR_PTR(-EINVAL);
> +
> +	void *out __free(kvfree) = kvzalloc(*out_len, GFP_KERNEL);
> +	if (!out)
> +		return ERR_PTR(-ENOMEM);
> +
> +	rc = cxl_mailbox_user_commands_info_get(cxlctl->mbox,
> +						commands, out, out_len);
> +	if (rc)
> +		return ERR_PTR(rc);
> +
> +	return_ptr(out);
> +}
> +


