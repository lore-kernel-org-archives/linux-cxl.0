Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3869129A7F
	for <linux-cxl@vger.kernel.org>; Thu,  7 Mar 2024 12:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709816348; cv=none; b=gdW/VVirbwUt1uJ31X7BP27ZFXznMn34W97HLk2Da1o5sBNAaXEq2dCnppr4LdgNw2AlKOTAj161vw4pTfUg8XgZRbVje7sIaRa2WRukgFonUeaYD4bhpyswxQGnSb3lPvE00BVeSzkc3QiMG1q7ofUow3Vfp6z6rGNG3yf32/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709816348; c=relaxed/simple;
	bh=+yaYt8TzIzbbIvXAAvDLNhoX9FAHN3NObLVBVmh22SY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rcJdh6JEtbAS6Jpms57TP3rghkd6Uz3FJfhCLqCHk24+RXAh6MuGSl0yfAjQ2uYqEAMoGYExlBZjUJZ6Gh6D9rcPfxsjM17zvLWymZTyQmq5blPL+9hs3fC1j1he53rlAYAX8QXjwn6E9iLEykdWGkH/IKi7GrnFhfpdOkCcwEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tr8Qv51THz6K9Jr;
	Thu,  7 Mar 2024 20:55:03 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 0F3FD140CF4;
	Thu,  7 Mar 2024 20:59:02 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 7 Mar
 2024 12:59:01 +0000
Date: Thu, 7 Mar 2024 12:59:00 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>
Subject: Re: [PATCH v3 3/3] cxl: Add checks to access_coordinate calculation
 to fail missing data
Message-ID: <20240307125900.00003469@Huawei.com>
In-Reply-To: <20240306175204.1906538-3-dave.jiang@intel.com>
References: <20240306175204.1906538-1-dave.jiang@intel.com>
	<20240306175204.1906538-3-dave.jiang@intel.com>
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
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 6 Mar 2024 10:52:04 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Jonathan noted that when the coordinates for host bridge and switches
> can be 0s if no actual data are retrieved and the calculation continues.
> The resulting number would be inaccurate. Add checks to ensure that the
> calculation would complete only if the numbers are valid.
> 
> While not seen in the wild, issue may show up with a BIOS that reported
> CXL root ports via Generic Ports (via a PCI handle in the SRAT entry).
> 
> Fixes: 14a6960b3e92 ("cxl: Add helper function that calculate performance data for downstream ports")
> Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Looks nice and clean now., So subject to resolution of the philosophy question
inline...

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
> v3:
> - Simplify iteration loop in cxl_endpoint_get_perf_coordinates(). (Jonathan)
> ---
>  drivers/cxl/core/port.c | 33 +++++++++++++++++++++++----------
>  1 file changed, 23 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 6fa273677963..baaaeddae775 100644
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
I'm not sure on logic here. I agree in theory it's possible to have
only one coord presented but do we actually want to support that?
One of those cases where perhaps Linux should insist on sanity even
if the specifications do not. 

I'd demand them all and flip to coordinates_valid() perhaps?

	return c->readbandwidth && c->write_bandwidth &&
	       c->read_latency && c->write_latency;

Maybe there is a dubious argument that a host might not provide bandwidth
to the HB if it knows it is way bigger than anything beyond that point...

Doubtful..
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
> @@ -2133,23 +2147,22 @@ int cxl_endpoint_get_perf_coordinates(struct cxl_port *port,
>  	if (!is_cxl_endpoint(port))
>  		return -EINVAL;
>  
> -	dport = iter->parent_dport;
> -
>  	/*
> -	 * Exit the loop when the parent port of the current port is cxl root.
> -	 * The iterative loop starts at the endpoint and gathers the
> -	 * latency of the CXL link from the current iter to the next downstream
> -	 * port each iteration. If the parent is cxl root then there is
> -	 * nothing to gather.
> +	 * Exit the loop when the parent port of the current iter port is cxl
> +	 * root. The iterative loop starts at the endpoint and gathers the
> +	 * latency of the CXL link from the current device/port to the connected
> +	 * downstream port each iteration.
>  	 */
> -	while (!is_cxl_root(to_cxl_port(iter->dev.parent))) {
> +	do {
> +		dport = iter->parent_dport;
> +		if (coordinates_invalid(&dport->coord))
> +			return -EINVAL;
>  		combine_coordinates(&c, &dport->coord);
>  		c.write_latency += dport->link_latency;
>  		c.read_latency += dport->link_latency;
>  
>  		iter = to_cxl_port(iter->dev.parent);
> -		dport = iter->parent_dport;
> -	}
> +	} while (!parent_port_is_cxl_root(iter));
>  
>  	/* Get the calculated PCI paths bandwidth */
>  	pdev = to_pci_dev(port->uport_dev->parent);

