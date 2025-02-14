Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A4D7E0ED;
	Fri, 14 Feb 2025 16:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739550833; cv=none; b=DeXnacj6yP6I8zcNxToay+jPbW356uUghilJME8R8bkLp3jWKZo+gE3eG5eYqhx9VtVda6utX/baIzgIig02IGncqyWOIG5tPaxB+jKn2V4Wm5A3Q9hzbwfiSKt6tX9GGJ1eET4rEkJhxCWVQ0Nk4m2lUdVZcde0nkKPWY9PdVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739550833; c=relaxed/simple;
	bh=gFDaOmwQbOF+QYMqI3l9zMjrHfJ7vsGvcdEoLzNNtHE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=baxzOQLTRBeWuRJWgGCrbD6RvbXAO/aASenUyuMKBSQIKuP31pF9tjq4XHcDBMFoyxuPNax4KptpNeyC/gZ2WSQcqv769vdizRHj+R9iGksQVIuqsViBBrPbWvBS+cG4h56VXQMm0r6RNKVjRkO9olC9TG1u7X9oewFifby7RyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Yvcwx6P7Vz6L531;
	Sat, 15 Feb 2025 00:30:41 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id CC39C140B39;
	Sat, 15 Feb 2025 00:33:48 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 14 Feb
 2025 17:33:48 +0100
Date: Fri, 14 Feb 2025 16:33:46 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Robert Richter <rrichter@amd.com>
CC: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>
Subject: Re: [PATCH v3 14/18] cxl/region: Unfold cxl_find_root_decoder()
 into cxl_endpoint_decoder_initialize()
Message-ID: <20250214163346.00007ade@huawei.com>
In-Reply-To: <20250211095349.981096-15-rrichter@amd.com>
References: <20250211095349.981096-1-rrichter@amd.com>
	<20250211095349.981096-15-rrichter@amd.com>
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

On Tue, 11 Feb 2025 10:53:44 +0100
Robert Richter <rrichter@amd.com> wrote:

> To determine other endpoint parameters such as interleaving parameters
> during endpoint initialization, the iterator function in
> cxl_find_root_decoder() can be used. Unfold this function into
> cxl_endpoint_decoder_initialize() and make the iterator available
> there.
I'm not following this description at all. Perhaps this needs
to wait until you have code that is reusing this to find those
interleave parameters and similar.

For now it just looks like a sensible bit of cleanup where there
was just a single caller of cxl_find_root_decoder()

> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Tested-by: Gregory Price <gourry@gourry.net>
> ---
>  drivers/cxl/core/region.c | 24 +++++-------------------
>  1 file changed, 5 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 72e991e7d9ab..ebcfbfe9eafc 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3220,8 +3220,7 @@ cxl_port_find_switch_decoder(struct cxl_port *port, struct range *hpa)
>  	return cxld_dev ? to_cxl_decoder(cxld_dev) : NULL;
>  }
>  
> -static struct cxl_root_decoder *
> -cxl_find_root_decoder(struct cxl_endpoint_decoder *cxled)
> +static int cxl_endpoint_decoder_initialize(struct cxl_endpoint_decoder *cxled)
>  {
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>  	struct cxl_port *iter = cxled_to_port(cxled);
> @@ -3232,7 +3231,7 @@ cxl_find_root_decoder(struct cxl_endpoint_decoder *cxled)
>  		iter = to_cxl_port(iter->dev.parent);
>  
>  	if (!iter)
> -		return NULL;
> +		return -ENXIO;
>  
>  	root = cxl_port_find_switch_decoder(iter, hpa);
>  	if (!root) {
> @@ -3240,12 +3239,12 @@ cxl_find_root_decoder(struct cxl_endpoint_decoder *cxled)
>  			"%s:%s no CXL window for range %#llx:%#llx\n",
>  			dev_name(&cxlmd->dev), dev_name(&cxld->dev),
>  			cxld->hpa_range.start, cxld->hpa_range.end);
> -		return NULL;
> +		return -ENXIO;
>  	}
>  
> +	cxled->cxlrd = to_cxl_root_decoder(&root->dev);
>  
> -
> -	return to_cxl_root_decoder(&root->dev);
> +	return 0;
>  }
>  
>  static int match_region_by_range(struct device *dev, const void *data)
> @@ -3370,19 +3369,6 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  	return ERR_PTR(rc);
>  }
>  
> -static int cxl_endpoint_decoder_initialize(struct cxl_endpoint_decoder *cxled)
> -{
> -	struct cxl_root_decoder *cxlrd;
> -
> -	cxlrd = cxl_find_root_decoder(cxled);
> -	if (!cxlrd)
> -		return -ENXIO;
> -
> -	cxled->cxlrd = cxlrd;
> -
> -	return 0;
> -}
> -
>  static int cxl_endpoint_decoder_add(struct cxl_endpoint_decoder *cxled)
>  {
>  	struct range *hpa = &cxled->cxld.hpa_range;

