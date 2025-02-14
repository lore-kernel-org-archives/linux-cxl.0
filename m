Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98FD2673AB;
	Fri, 14 Feb 2025 16:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739549269; cv=none; b=uGlGww18DhXvklDJVc+JeI3CVqLI6BnMGdmrtr2XTATRLxNpla98zgQCsEOqp83iv7ojaoxivto2aJuVmTPKEJeoCewpQ+eryAEToyKz8CahEWLd1HQ/FUYe4d3R+b7EKJcTfR0HjR+yfL5aBTooVDSkVeKA04bNZvjLBbVCYWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739549269; c=relaxed/simple;
	bh=Ao7LE4+tbfQL8T8CQHg0pXYdVblJlSaOPMAuV6uc1GI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GtXK4GRqzBUv6l3QD3VXe2/K3jBO4m7XgD/G25equV3pz4EEbwclRvGPmAa00h0KvBGOqolQGwPcbjdudSTAMTXQw19QNJL61ARTr8SMoRJ0zWH0aIvCeN3fUZvOfbEAhOjRWgcm8cYTHix58lJjhf89quGF9U5KmoH9zktXuFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YvcMH13hZz6H7YC;
	Sat, 15 Feb 2025 00:04:59 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 7BA1F140A77;
	Sat, 15 Feb 2025 00:07:27 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 14 Feb
 2025 17:07:26 +0100
Date: Fri, 14 Feb 2025 16:07:25 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Robert Richter <rrichter@amd.com>
CC: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>
Subject: Re: [PATCH v3 07/18] cxl/region: Avoid duplicate call of
 cxl_find_decoder_early()
Message-ID: <20250214160725.0000662f@huawei.com>
In-Reply-To: <20250211095349.981096-8-rrichter@amd.com>
References: <20250211095349.981096-1-rrichter@amd.com>
	<20250211095349.981096-8-rrichter@amd.com>
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

On Tue, 11 Feb 2025 10:53:37 +0100
Robert Richter <rrichter@amd.com> wrote:

> Function cxl_find_decoder_early() is called twice, in
> alloc_region_ref() and cxl_rr_alloc_decoder(). Move it out there and

out where?  I'd make it clear that both these calls are in
cxl_port_attach_region()

> instead pass the decoder as function argument to both.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Tested-by: Gregory Price <gourry@gourry.net>

I think this is fine but it's not immediately obvious so a request
inline for some more details in this description.

> ---
>  drivers/cxl/core/region.c | 31 +++++++++++++++----------------
>  1 file changed, 15 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 13e3ba984a53..b8201c2faa87 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -908,7 +908,8 @@ static bool auto_order_ok(struct cxl_port *port, struct cxl_region *cxlr_iter,
>  
>  static struct cxl_region_ref *
>  alloc_region_ref(struct cxl_port *port, struct cxl_region *cxlr,
> -		 struct cxl_endpoint_decoder *cxled)
> +		 struct cxl_endpoint_decoder *cxled,
> +		 struct cxl_decoder *cxld)
>  {
>  	struct cxl_region_params *p = &cxlr->params;
>  	struct cxl_region_ref *cxl_rr, *iter;
> @@ -922,9 +923,6 @@ alloc_region_ref(struct cxl_port *port, struct cxl_region *cxlr,
>  			continue;
>  
>  		if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
> -			struct cxl_decoder *cxld;
> -
> -			cxld = cxl_find_decoder_early(port, cxled, cxlr);


This is buried a little deep to be obviously fine to lift out.
Seems like it should always have been done outside the xa_for_each()
loop in here.  So I think this is fine but maybe some more in the
patch description is needed to make that point.

>  			if (auto_order_ok(port, iter->region, cxld))
>  				continue;
>  		}
> @@ -1008,17 +1006,9 @@ static int cxl_rr_ep_add(struct cxl_region_ref *cxl_rr,
>  
>  static int cxl_rr_alloc_decoder(struct cxl_port *port, struct cxl_region *cxlr,
>  				struct cxl_endpoint_decoder *cxled,
> -				struct cxl_region_ref *cxl_rr)
> +				struct cxl_region_ref *cxl_rr,
> +				struct cxl_decoder *cxld)
>  {
> -	struct cxl_decoder *cxld;
> -
> -	cxld = cxl_find_decoder_early(port, cxled, cxlr);
> -	if (!cxld) {
> -		dev_dbg(&cxlr->dev, "%s: no decoder available\n",
> -			dev_name(&port->dev));
> -		return -EBUSY;
> -	}
> -
>  	if (cxld->region) {
>  		dev_dbg(&cxlr->dev, "%s: %s already attached to %s\n",
>  			dev_name(&port->dev), dev_name(&cxld->dev),
> @@ -1109,7 +1099,16 @@ static int cxl_port_attach_region(struct cxl_port *port,
>  			nr_targets_inc = true;
>  		}
>  	} else {
> -		cxl_rr = alloc_region_ref(port, cxlr, cxled);
> +		struct cxl_decoder *cxld;
> +
> +		cxld = cxl_find_decoder_early(port, cxled, cxlr);
> +		if (!cxld) {
> +			dev_dbg(&cxlr->dev, "%s: no decoder available\n",
> +				dev_name(&port->dev));
> +			return -EBUSY;
> +		}
> +
> +		cxl_rr = alloc_region_ref(port, cxlr, cxled, cxld);
>  		if (IS_ERR(cxl_rr)) {
>  			dev_dbg(&cxlr->dev,
>  				"%s: failed to allocate region reference\n",
> @@ -1118,7 +1117,7 @@ static int cxl_port_attach_region(struct cxl_port *port,
>  		}
>  		nr_targets_inc = true;
>  
> -		rc = cxl_rr_alloc_decoder(port, cxlr, cxled, cxl_rr);
> +		rc = cxl_rr_alloc_decoder(port, cxlr, cxled, cxl_rr, cxld);
>  		if (rc)
>  			goto out_erase;
>  	}

