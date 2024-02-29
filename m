Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320C370AEE
	for <linux-cxl@vger.kernel.org>; Thu, 29 Feb 2024 17:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709228676; cv=none; b=h37ijvpeKPnR/18qfMicxETsFAS8g6b62NU6qJhUJScbBOrreRRf6DE0H0Jl2Iog2Jl2PhIWHrZ3hzHVt4DRf8iFeUEfUGJ0h+UL5XarS/Fn8HPeGueuWZHQlZ9OEvGOrBDTLVuGJT/xuisTXx8+DPqgYMIwMuzxy96GQMCnlzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709228676; c=relaxed/simple;
	bh=OSFETKNaM0bWxblTAmNXL7SMqRqmw7R4QckAgb70faM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QVC6FysWHI3DpyNgKrPaXdBKruN15rJzXCaeUGAO40EJ3QBF1l3C8jEIds8lJTiYjs5GSNpQ7tJ1WeryOVeXnjBEdHJPjbG6Tke2/1OW2I3NyIo4ZcM9Z40vx18vg2wR2PFAGwxKdyvCPTKOeNu1fK/qa9kPGwT9Lbtn7tXO8Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tlz4w3DQNz6K651;
	Fri,  1 Mar 2024 01:40:00 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 2972B140A35;
	Fri,  1 Mar 2024 01:44:29 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 29 Feb
 2024 17:44:28 +0000
Date: Thu, 29 Feb 2024 17:44:27 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>
Subject: Re: [PATCH 2/2] cxl: Add checks to access_coordinate calculation to
 fail missing data
Message-ID: <20240229174427.00000e9e@Huawei.com>
In-Reply-To: <20240229002542.634982-2-dave.jiang@intel.com>
References: <20240229002542.634982-1-dave.jiang@intel.com>
	<20240229002542.634982-2-dave.jiang@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 28 Feb 2024 17:25:42 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Jonathan noted that when the coordinates for host bridge and switches
> can be 0s if no actual data are retrieved and the calculation continues.
> The resulting number would be inaccurate. Add checks to ensure that the
> calculation would complete only if the numbers are valid.
> 
> Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Hi Dave,

Whilst I think the fix is right, it is getting hard to read. Maybe
a rethink is needed on how that iteration works?

> ---
>  drivers/cxl/core/port.c | 31 +++++++++++++++++++++++++++----
>  1 file changed, 27 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index e1d30a885700..2c82fe24b789 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -2110,6 +2110,20 @@ static void combine_coordinates(struct access_coordinate *c1,
>  		c1->read_latency += c2->read_latency;
>  }
>  
> +static bool coordinates_invalid(struct access_coordinate *c)
> +{
> +	if (!c->read_bandwidth && !c->write_bandwidth &&
> +	    !c->read_latency && !c->write_latency)
> +		return true;
> +
> +	return false;
> +}
> +
> +static bool parent_port_is_cxl_root(struct cxl_port *port)
> +{
> +	return is_cxl_root(to_cxl_port(port->dev.parent));
> +}
> +
>  /**
>   * cxl_endpoint_get_perf_coordinates - Retrieve performance numbers stored in dports
>   *				   of CXL path
> @@ -2142,16 +2156,25 @@ int cxl_endpoint_get_perf_coordinates(struct cxl_port *port,
>  	 * port each iteration. If the parent is cxl root then there is
>  	 * nothing to gather.
>  	 */
> -	while (!is_cxl_root(to_cxl_port(iter->dev.parent))) {
> -		combine_coordinates(&c, &dport->sw_coord);
> +	while (!parent_port_is_cxl_root(iter)) {
> +		iter = to_cxl_port(iter->dev.parent);
> +
> +		/* There's no CDAT for the host bridge, so skip if so. */

Comment refers to skipping whereas code is 'doing more' for the other case
so this is confusing to me.

The inverse of this only occurs on the last iteration I think.

Possibly a do / while instead of a while will do it.
I'm far from confident though as all the levels of look up have
me too confused.


	do {
		if (coordinates_invalid(&dport->sw_coord))
			return -EINVAL;

		combine_coordinates(&c, &dport->sw_coord);
		iter = to_cxl_port(iter->dev.parent);
  		dport = iter->parent_dport;
	} while (!parent_port_is_cxl_root(iter));
	/* Do final link updates */
	c.write_latency += dport->link_latency;
	c.read_latency += dport->link_latency;

> +		if (!parent_port_is_cxl_root(iter)) {
> +			if (coordinates_invalid(&dport->sw_coord))
> +				return -EINVAL;
> +
> +			combine_coordinates(&c, &dport->sw_coord);
> +		}
> +
>  		c.write_latency += dport->link_latency;
>  		c.read_latency += dport->link_latency;
> -
> -		iter = to_cxl_port(iter->dev.parent);
>  		dport = iter->parent_dport;
>  	}
>  
>  	/* Augment with the generic port (host bridge) perf data */
> +	if (coordinates_invalid(&dport->hb_coord))
> +		return -EINVAL;
>  	combine_coordinates(&c, &dport->hb_coord);
>  
>  	/* Get the calculated PCI paths bandwidth */

