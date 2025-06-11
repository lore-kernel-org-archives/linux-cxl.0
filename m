Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0164C277011;
	Wed, 11 Jun 2025 13:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749647812; cv=none; b=HS4RFzfuriUMjnxJvEhHcsZPBuj1xLhqDg7KxLiGei7ARCCtdtNYzqTcIPlmZlcZ6lEBA5azDkKekcVI25cNJk/3DnQRBwf/4eYRl+1L7jEFhXoSCcNgpWYIo7dI6WRAQvudXZpK3Iy+dTIQWTFWCF9jgIE/UM8OwUPNylkVkbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749647812; c=relaxed/simple;
	bh=mOA2uHhLVAJnM0AAacilOeTj2Muvi2Yo8XU4SD/q028=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hkugqz7QqoSv1wbpnRdCVB6tSiQ7jD/b5lL5kduCcripfM4IuQmVd0o2qMQ2OtACH+ioQNMJvawm6ziyqsBJ1Lr2c0KZb5b5KqNWSLHu23fo1XEJwXNBKp7ABFiLcufnP/RpVT0vRKD4/xugYpPXQp0kbh5eYNcnnvnfqU043VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bHR2t0p0Wz6JB2J;
	Wed, 11 Jun 2025 21:14:46 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id BAD2C1402F4;
	Wed, 11 Jun 2025 21:16:38 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 11 Jun
 2025 15:16:38 +0200
Date: Wed, 11 Jun 2025 14:16:37 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Li Ming <ming.li@zohomail.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <shiju.jose@huawei.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] cxl/edac: Fix potential memory leak issues
Message-ID: <20250611141637.0000546b@huawei.com>
In-Reply-To: <20250611033542.96184-1-ming.li@zohomail.com>
References: <20250611033542.96184-1-ming.li@zohomail.com>
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
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 11 Jun 2025 11:35:42 +0800
Li Ming <ming.li@zohomail.com> wrote:

> In cxl_store_rec_gen_media() and cxl_store_rec_dram(), use kmemdup() to
> duplicate a cxl gen_media/dram event to store the event in a xarray by
> xa_store(). The cxl gen_media/dram event allocated by kmemdup() should
> be freed in the case that the xa_store() fails.
> 
> Fixes: 0b5ccb0de1e2 ("cxl/edac: Support for finding memory operation attributes from the current boot")
> Signed-off-by: Li Ming <ming.li@zohomail.com>
Good fine but I'm not sure this is the best fix.

> ---
> base-commit: 87b42c114cdda76c8ad3002f2096699ad5146cb3 cxl/fixes
> ---
>  drivers/cxl/core/edac.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
> index 2cbc664e5d62..b4c5c23a45d4 100644
> --- a/drivers/cxl/core/edac.c
> +++ b/drivers/cxl/core/edac.c
> @@ -1086,13 +1086,13 @@ static void cxl_del_overflow_old_recs(struct xarray *rec_xarray)
>  int cxl_store_rec_gen_media(struct cxl_memdev *cxlmd, union cxl_event *evt)
>  {
>  	struct cxl_mem_err_rec *array_rec = cxlmd->err_rec_array;
> -	struct cxl_event_gen_media *rec;
>  	void *old_rec;
>  
>  	if (!IS_ENABLED(CONFIG_CXL_EDAC_MEM_REPAIR) || !array_rec)
>  		return 0;
>  
> -	rec = kmemdup(&evt->gen_media, sizeof(*rec), GFP_KERNEL);
> +	struct cxl_event_gen_media *rec __free(kfree) =
> +		kmemdup(&evt->gen_media, sizeof(*rec), GFP_KERNEL);
>  	if (!rec)
>  		return -ENOMEM;
>  
> @@ -1106,6 +1106,7 @@ int cxl_store_rec_gen_media(struct cxl_memdev *cxlmd, union cxl_event *evt)
>  
>  	cxl_del_expired_gmedia_recs(&array_rec->rec_gen_media, rec);
>  	cxl_del_overflow_old_recs(&array_rec->rec_gen_media);
> +	retain_and_null_ptr(rec);
>  
>  	return 0;
>  }
> @@ -1114,13 +1115,13 @@ EXPORT_SYMBOL_NS_GPL(cxl_store_rec_gen_media, "CXL");
>  int cxl_store_rec_dram(struct cxl_memdev *cxlmd, union cxl_event *evt)
>  {
>  	struct cxl_mem_err_rec *array_rec = cxlmd->err_rec_array;
> -	struct cxl_event_dram *rec;
>  	void *old_rec;
>  
>  	if (!IS_ENABLED(CONFIG_CXL_EDAC_MEM_REPAIR) || !array_rec)
>  		return 0;
>  
> -	rec = kmemdup(&evt->dram, sizeof(*rec), GFP_KERNEL);
> +	struct cxl_event_dram *rec __free(kfree) =
> +		kmemdup(&evt->dram, sizeof(*rec), GFP_KERNEL);
>  	if (!rec)
>  		return -ENOMEM;
>  
> @@ -1134,6 +1135,7 @@ int cxl_store_rec_dram(struct cxl_memdev *cxlmd, union cxl_event *evt)
>  
>  	cxl_del_expired_dram_recs(&array_rec->rec_dram, rec);
>  	cxl_del_overflow_old_recs(&array_rec->rec_dram);
> +	retain_and_null_ptr(rec);

I'd move this up to immediately after we hand it over to the xa successfully.

Actually I'm not sure this is a good use of __free given we have a single
error path to handle it in and have to manually release it in a different
call to where it is passed to the xa_store() function.  Maybe better
to just kfree in the error path.


>  
>  	return 0;
>  }

