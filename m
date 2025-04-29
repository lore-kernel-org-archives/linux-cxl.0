Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0630F6AD3;
	Tue, 29 Apr 2025 15:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745940690; cv=none; b=sJnwGgH176+oczvKce7Hqzvp4UYN2AS0+f9j0Nn/O2tyjc0TCyO2eNFbiK1GvSxjw+ZHSDfIbAGhi9wmQ6Q2kNA0Q14S0exB/B6PJ/YJp/ZBozQ7wd8U0yFWA5p+FCdAThzJ37yZnwp6/HNbFHNvv3a53xzJjS1c3ypTCiMxkKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745940690; c=relaxed/simple;
	bh=UvEBvrKrtxVjCOYAPkjpue470yU9uaszPGPMtbeBSfo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kqqnnHqKQIf4qjDkfJJXxKaJN1uHtGzpN/SdDMoAnyGWWFHAGSiKRpV6D8ACEEwWb11C1Fy0H3Ux7yyJQvfguTKkvyJhESUPoseV2iGOT/8cESx4Va98/uHXjPmZnDcK7Ic3aQ9UGUtyXGgw7D40+HzSJghV3xpy7i+6w/90+vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Zn41L6RXxz6M4ls;
	Tue, 29 Apr 2025 23:27:02 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 8AD27140518;
	Tue, 29 Apr 2025 23:31:21 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 29 Apr
 2025 17:31:20 +0200
Date: Tue, 29 Apr 2025 16:31:19 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Robert Richter <rrichter@amd.com>
CC: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>
Subject: Re: [PATCH v5 05/14] cxl/region: Rename function to
 cxl_port_pick_region_decoder()
Message-ID: <20250429163119.00001eba@huawei.com>
In-Reply-To: <20250428214318.1682212-6-rrichter@amd.com>
References: <20250428214318.1682212-1-rrichter@amd.com>
	<20250428214318.1682212-6-rrichter@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 28 Apr 2025 23:43:08 +0200
Robert Richter <rrichter@amd.com> wrote:

> Current function cxl_region_find_decoder() is used to find a port's
> decoder during region setup. In the region creation path the function
> is an allocator to find a free port. In the region assembly path, it
> is recalling the decoder that platform firmware picked for validation
> purposes.
> 
> Rename function to cxl_port_pick_region_decoder() that better
> describes its use and update the function's description.
> 
> The result of cxl_port_pick_region_decoder() is recorded in a 'struct
> cxl_region_ref' in @port for later recall when other endpoints might
> also be targets of the picked decoder.

I'm not convinced pick is really any clearer than find as it doesn't to me
imply 'get the one that was already allocated'.  I'm also not seeing
a lot of precedence in kernel for this use of pick.

I don't feel that strongly either way though and I guess I'll
get used to the term if we go with pick.

Alternative might just be to make it an or...

cxl_region_find_or_alloc_decoder()


> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Tested-by: Gregory Price <gourry@gourry.net>
> ---
>  drivers/cxl/core/region.c | 25 ++++++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index e35209168c9c..e104035e0855 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -865,10 +865,25 @@ static int match_auto_decoder(struct device *dev, const void *data)
>  	return 0;
>  }
>  
> +/**
> + * cxl_port_pick_region_decoder() - assign or lookup a decoder for a region
> + * @port: a port in the ancestry of the endpoint implied by @cxled
> + * @cxled: endpoint decoder to be, or currently, mapped by @port
> + * @cxlr: region to establish, or validate, decode @port
> + *
> + * In the region creation path cxl_port_pick_region_decoder() is an
> + * allocator to find a free port. In the region assembly path, it is
> + * recalling the decoder that platform firmware picked for validation
> + * purposes.
> + *
> + * The result is recorded in a 'struct cxl_region_ref' in @port for
> + * later recall when other endpoints might also be targets of the picked
> + * decoder.
> + */
>  static struct cxl_decoder *
> -cxl_region_find_decoder(struct cxl_port *port,
> -			struct cxl_endpoint_decoder *cxled,
> -			struct cxl_region *cxlr)
> +cxl_port_pick_region_decoder(struct cxl_port *port,
> +			     struct cxl_endpoint_decoder *cxled,
> +			     struct cxl_region *cxlr)
>  {
>  	struct device *dev;
>  
> @@ -932,7 +947,7 @@ alloc_region_ref(struct cxl_port *port, struct cxl_region *cxlr,
>  		if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
>  			struct cxl_decoder *cxld;
>  
> -			cxld = cxl_region_find_decoder(port, cxled, cxlr);
> +			cxld = cxl_port_pick_region_decoder(port, cxled, cxlr);
>  			if (auto_order_ok(port, iter->region, cxld))
>  				continue;
>  		}
> @@ -1020,7 +1035,7 @@ static int cxl_rr_alloc_decoder(struct cxl_port *port, struct cxl_region *cxlr,
>  {
>  	struct cxl_decoder *cxld;
>  
> -	cxld = cxl_region_find_decoder(port, cxled, cxlr);
> +	cxld = cxl_port_pick_region_decoder(port, cxled, cxlr);
>  	if (!cxld) {
>  		dev_dbg(&cxlr->dev, "%s: no decoder available\n",
>  			dev_name(&port->dev));

