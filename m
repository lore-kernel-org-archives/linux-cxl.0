Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D07326BD8E;
	Tue, 11 Feb 2025 17:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739294799; cv=none; b=rOcDHhsAO5MWEboFvDQmgloqywdnG25aZe6T7WaAlobcGNnibLZijio2zGFQtayNLhB7E9t8Tj2DKdix29aMbFjgRhswZQoTG0jjTvCZSdnXn8gWtyVr+/9i3xz9TKXC8kEbqwSIA0BwFAjaQDmX99SUFFcjZp3UaeJvrH76NsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739294799; c=relaxed/simple;
	bh=5cU+Vpo1UfVf6yBmz7gKTmJhl1QfDDKO2mILu40rFZM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mOd4E/Sul0V3zlS4nSHYOQTLEtTc7xXEHqXN70DBgNsPCgtVLXwrusE7Amw2hAtEgk8G6uecRgcudMGuUKP1Cmsm+q8x8KUiEBBkZjTyfwyLKklGDAIrY/OuSw6O61LJkjJ/bOcExjUYf0w17xpW1Mueafanl8g02E6JO0XnBRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YspG14DzLz6H8Yg;
	Wed, 12 Feb 2025 01:24:09 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id A8C011402A4;
	Wed, 12 Feb 2025 01:26:33 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 11 Feb
 2025 18:26:33 +0100
Date: Tue, 11 Feb 2025 17:26:31 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Li Ming <ming.li@zohomail.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/7] cxl/core: Use guard() to replace open-coded
 down_read/write()
Message-ID: <20250211172631.00001a34@huawei.com>
In-Reply-To: <20250211075727.351895-2-ming.li@zohomail.com>
References: <20250211075727.351895-1-ming.li@zohomail.com>
	<20250211075727.351895-2-ming.li@zohomail.com>
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

On Tue, 11 Feb 2025 15:57:21 +0800
Li Ming <ming.li@zohomail.com> wrote:

> Some down/up_read() and down/up_write() cases can be replaced by a
> guard() simply to drop explicit unlock invoked. It helps to align coding
> style with current CXL subsystem's.
> 
> Signed-off-by: Li Ming <ming.li@zohomail.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

I wondered if it was worth doing some early returns and dropping
local variables, but on balance think it isn't worth doing.


> @@ -364,10 +362,9 @@ resource_size_t cxl_dpa_size(struct cxl_endpoint_decoder *cxled)
>  {
>  	resource_size_t size = 0;
>  
> -	down_read(&cxl_dpa_rwsem);
> +	guard(rwsem_read)(&cxl_dpa_rwsem);
>  	if (cxled->dpa_res)
>  		size = resource_size(cxled->dpa_res);

Could return resource_size() here and return 0 below.
I'm not sure it gains us much though. 

> -	up_read(&cxl_dpa_rwsem);
>  
>  	return size;
>  }
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index e8d11a988fd9..e3bb33109ced 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3216,10 +3216,9 @@ static int match_region_by_range(struct device *dev, const void *data)
>  	cxlr = to_cxl_region(dev);
>  	p = &cxlr->params;
>  
> -	down_read(&cxl_region_rwsem);
> +	guard(rwsem_read)(&cxl_region_rwsem);
>  	if (p->res && p->res->start == r->start && p->res->end == r->end)
>  		rc = 1;

could do return 1 here and return 0 but it doesn't gain us much.

> -	up_read(&cxl_region_rwsem);
>  
>  	return rc;
>  }

