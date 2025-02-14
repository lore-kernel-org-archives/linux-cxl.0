Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DEC263F40;
	Fri, 14 Feb 2025 15:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739548695; cv=none; b=pbZ0xLlRwKost7hEE+uytsfukalndwJUNcsnZRvpLKKs9EMXJR1OWkfEVbZWgJzOn49vXx3zUIEFf8CvqTzX3rYxwHXIo5usy23Wir3KFsSaYmuoqOsGXAXVV3wBLgGWwgNk7CN1g7eKtRiliBH4WD6I6P/ekDgAjcTVnUQe/l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739548695; c=relaxed/simple;
	bh=ITM1x9NbPIlmfCl9HfISxYBWAPCHPe8yHSWHXLcRJC0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CY5VAkmQs/eCBKY1YGSvPgt3Cn+NE8cZ2GBwlKPzCxn7snF8ZCbd6awAN3u8FOOvogNS7SmJZKGyPqG9M5hP5Sp1Kq/DkYrb7PFXY/NbScIr7wCifNwimn1ZBRL4MmVNT0E9f8KdGB18eav6viB2U+xY0a9NIgOQ9NK776nX+7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Yvc7q5Fm3z6L53m;
	Fri, 14 Feb 2025 23:55:03 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 9D47E140D26;
	Fri, 14 Feb 2025 23:58:10 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 14 Feb
 2025 16:58:10 +0100
Date: Fri, 14 Feb 2025 15:58:08 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Robert Richter <rrichter@amd.com>
CC: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>
Subject: Re: [PATCH v3 06/18] cxl/region: Rename function to
 cxl_find_decoder_early()
Message-ID: <20250214155808.00001e02@huawei.com>
In-Reply-To: <20250211095349.981096-7-rrichter@amd.com>
References: <20250211095349.981096-1-rrichter@amd.com>
	<20250211095349.981096-7-rrichter@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 11 Feb 2025 10:53:36 +0100
Robert Richter <rrichter@amd.com> wrote:

> Current function cxl_region_find_decoder() is used to find a port's
> decoder during region setup. The decoder is later used to attach the
> port to a region.
> 
> Rename function to cxl_find_decoder_early() to emphasize its use only
> during region setup in the early setup stage. Once a port is attached
> to a region, the region reference can be used to lookup a region's
> port and decoder configuration (see struct cxl_region_ref).

Early doesn't seem that well defined to me. Can we indicate what the state
is more explicitly?

Or does it actually matter?  Whilst there is a better way to get
it later, does this function then return the wrong answer?

Or if we have both cases of 'finding' it, can we just make this
code do both?

Jonathan

> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Tested-by: Gregory Price <gourry@gourry.net>
> ---
>  drivers/cxl/core/region.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 54afdb0fa61c..13e3ba984a53 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -850,10 +850,17 @@ static int match_auto_decoder(struct device *dev, const void *data)
>  	return 0;
>  }
>  
> +/*
> + * Use cxl_find_decoder_early() only during region setup in the early
> + * setup stage. Once a port is attached to a region, the region
> + * reference can be used to lookup a region's port and decoder
> + * configuration (see struct cxl_region_ref).
> +*/
> +
>  static struct cxl_decoder *
> -cxl_region_find_decoder(struct cxl_port *port,
> -			struct cxl_endpoint_decoder *cxled,
> -			struct cxl_region *cxlr)
> +cxl_find_decoder_early(struct cxl_port *port,
> +		       struct cxl_endpoint_decoder *cxled,
> +		       struct cxl_region *cxlr)
>  {
>  	struct device *dev;
>  
> @@ -917,7 +924,7 @@ alloc_region_ref(struct cxl_port *port, struct cxl_region *cxlr,
>  		if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
>  			struct cxl_decoder *cxld;
>  
> -			cxld = cxl_region_find_decoder(port, cxled, cxlr);
> +			cxld = cxl_find_decoder_early(port, cxled, cxlr);
>  			if (auto_order_ok(port, iter->region, cxld))
>  				continue;
>  		}
> @@ -1005,7 +1012,7 @@ static int cxl_rr_alloc_decoder(struct cxl_port *port, struct cxl_region *cxlr,
>  {
>  	struct cxl_decoder *cxld;
>  
> -	cxld = cxl_region_find_decoder(port, cxled, cxlr);
> +	cxld = cxl_find_decoder_early(port, cxled, cxlr);
>  	if (!cxld) {
>  		dev_dbg(&cxlr->dev, "%s: no decoder available\n",
>  			dev_name(&port->dev));

