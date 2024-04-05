Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AFB16D32D
	for <linux-cxl@vger.kernel.org>; Fri,  5 Apr 2024 13:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712323968; cv=none; b=rG2GC5lE9aCG4/W9Ghgslg6kBoJsCnR8oKoK2Bjym63sWUWjoJOfRinz8T4YK7sRm/miWJTIJGq51ZZxoJIqEx4/CUutLa/C78ITuppvUQQyvZqWr9pOeE4yu9UM6W+QNnQ6EH5SKOguqBWD5sUvfVwASeMOeVh2jJtKb6nsTTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712323968; c=relaxed/simple;
	bh=z6u9/MFi/6diwsTcL68mcimKfMbpmkxIZLIesyC4UO8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u9pktgk4XyX6q1EQw/6mBEGcrVrzf1J/RkLpH2y/GakSmpWV3Vq0PN3X/QHjGPL0j8ke/UBAuG+Cms3zeCM3xRRLQ6yvA2cxrqOvKFQ7Zpfpaer9+ZwJ9OBKiNYkiRe+tQuiIRl+a+abIVnbyWPPWjcbyMeDU9sa4cdPXmuu/Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V9zsL0vgxz6JBDw;
	Fri,  5 Apr 2024 21:31:18 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 1E0611400CD;
	Fri,  5 Apr 2024 21:32:43 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 5 Apr
 2024 14:32:42 +0100
Date: Fri, 5 Apr 2024 14:32:42 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>
Subject: Re: [PATCH v7 2/5] cxl: Fix retrieving of access_coordinates in
 PCIe path
Message-ID: <20240405143242.0000363a@Huawei.com>
In-Reply-To: <20240403154844.3403859-3-dave.jiang@intel.com>
References: <20240403154844.3403859-1-dave.jiang@intel.com>
	<20240403154844.3403859-3-dave.jiang@intel.com>
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
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 3 Apr 2024 08:47:13 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Current loop in cxl_endpoint_get_perf_coordinates() incorrectly assumes
> the Root Port (RP) dport is the one with generic port access_coordinate.
> However those coordinates are one level up in the Host Bridge (HB).
> Current code causes the computation code to pick up 0s as the coordinates
> and cause minimal bandwidth to result in 0.
> 
> Add check to skip RP when combining coordinates.
> 
> Fixes: 4d59ba915318 ("cxl: Fix retrieving of access_coordinates in PCIe path")
> Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

I've only tested this with direct connect, but can't see why it wouldn't work
with switches in the path. So

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/port.c | 35 ++++++++++++++++++++++-------------
>  1 file changed, 22 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 6cbde50a742b..7aadcec4fc64 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -2165,6 +2165,11 @@ int cxl_hb_get_perf_coordinates(struct cxl_port *port,
>  	return 0;
>  }
>  
> +static bool parent_port_is_cxl_root(struct cxl_port *port)
> +{
> +	return is_cxl_root(to_cxl_port(port->dev.parent));
> +}
> +
>  /**
>   * cxl_endpoint_get_perf_coordinates - Retrieve performance numbers stored in dports
>   *				   of CXL path
> @@ -2184,27 +2189,31 @@ int cxl_endpoint_get_perf_coordinates(struct cxl_port *port,
>  	struct cxl_dport *dport;
>  	struct pci_dev *pdev;
>  	unsigned int bw;
> +	bool is_cxl_root;
>  
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
> -		cxl_coordinates_combine(&c, &c, &dport->sw_coord);
> +	do {
> +		dport = iter->parent_dport;
> +		iter = to_cxl_port(iter->dev.parent);
> +		is_cxl_root = parent_port_is_cxl_root(iter);
> +
> +		/*
> +		 * There's no valid access_coordinate for a root port since RPs do not
> +		 * have CDAT and therefore needs to be skipped.
> +		 */
> +		if (!is_cxl_root)
> +			cxl_coordinates_combine(&c, &c, &dport->sw_coord);
>  		c.write_latency += dport->link_latency;
>  		c.read_latency += dport->link_latency;
> -
> -		iter = to_cxl_port(iter->dev.parent);
> -		dport = iter->parent_dport;
> -	}
> +	} while (!is_cxl_root);
>  
>  	/* Get the calculated PCI paths bandwidth */
>  	pdev = to_pci_dev(port->uport_dev->parent);

