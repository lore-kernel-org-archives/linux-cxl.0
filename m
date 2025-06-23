Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4925C23D286;
	Mon, 23 Jun 2025 10:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750675991; cv=none; b=NzAp0sKr6HwdvaHQy35d9QoIWS1ROKDwaMn9ICvq03r900E9cebJG7Umua/ypvzU6Sqv1wzVRIaRDTyzAPH+XrnUbLJ3U3DLxXR8hUCcPa1rdcubjy7M9Iq4QAYBR6bRHyIHykqcFRR8GnAtbyoe0KNtPl1twiYjt807yRb9gLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750675991; c=relaxed/simple;
	bh=Tv3ZYfUFa/xK8PobRaNXT1vnz+JJp5obteZTMq8t78Y=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p5p9yL+OB4l1wAXjcTk46GtnjS4fLCkEALNxuftzSaI4s68dTLxfHWB9QrK9p5dK2RLgUJedLAlSLqdzqs3946QTyfuDv5bOUEmtaj2Tky9ExKwh5KDT4rfIC5kgQ3dwO2ZmVCuWGLpqJtt1H/ZbXq1YFQ7LIyg04gt8iBdeN/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bQlK43fB6z6L7DK;
	Mon, 23 Jun 2025 18:52:24 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 172A41402F6;
	Mon, 23 Jun 2025 18:53:07 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 23 Jun
 2025 12:53:06 +0200
Date: Mon, 23 Jun 2025 11:53:05 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Davidlohr
 Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>, Alison
 Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, "Ira Weiny" <ira.weiny@intel.com>
Subject: Re: [PATCH v2 4/8] cxl/decoder: Drop pointless locking
Message-ID: <20250623115305.0000382e@huawei.com>
In-Reply-To: <20250619050416.782871-5-dan.j.williams@intel.com>
References: <20250619050416.782871-1-dan.j.williams@intel.com>
	<20250619050416.782871-5-dan.j.williams@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 18 Jun 2025 22:04:12 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> cxl_dpa_rwsem coordinates changes to dpa allocation settings for a given
> decoder. cxl_decoder_reset() has no need for a consistent snapshot of the
> dpa settings since it is merely clearing out whatever was there previously.
> 
> Otherwise, cxl_region_rwsem protects against 'reset' racing 'setup'.
> 
> In preparationg for converting to rw_semaphore_acquire semantics, drop this

typo

> locking.
> 
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
>  drivers/cxl/core/hdm.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 81556d12e9b8..e9cb34e30248 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -914,7 +914,6 @@ static void cxl_decoder_reset(struct cxl_decoder *cxld)
>  			"%s: out of order reset, expected decoder%d.%d\n",
>  			dev_name(&cxld->dev), port->id, port->commit_end);
>  
> -	down_read(&cxl_dpa_rwsem);
>  	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
>  	ctrl &= ~CXL_HDM_DECODER0_CTRL_COMMIT;
>  	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> @@ -923,7 +922,6 @@ static void cxl_decoder_reset(struct cxl_decoder *cxld)
>  	writel(0, hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
>  	writel(0, hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
>  	writel(0, hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
> -	up_read(&cxl_dpa_rwsem);
>  
>  	cxld->flags &= ~CXL_DECODER_F_ENABLE;
>  

