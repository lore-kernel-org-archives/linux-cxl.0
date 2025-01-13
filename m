Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779A23A8D0;
	Mon, 13 Jan 2025 16:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736787163; cv=none; b=uRFCUWykl0iqcS6zSqCpGxIyY/JyXHYVdUXmrerfVtnBf9TWv/221w32kwHmMfqrPt1cMWHpEj6mJsmTo9kWOwh8XjcgEFJom/SmyB0pBIspk+KmvL8Xuf92zPv8qQFVde4IZ5Za9IEfDc05u7Hw7wweKTDKaxmmzFe0n66dicE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736787163; c=relaxed/simple;
	bh=IpVSPY9gRGx+pBvLrX7NSdLTbN17mXprsyFFfIDb6wY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cVLxC/bd8ZRaxULRNdyciDQxBvgZmbvqAm8aIs1G6ZEHrDgTlgvYRVwHmuPazsbRVPYUA7rkIZAZWCaBZoL+u+c+hmlvwBmC9c7gqmGdPEikEtcLH2EuEHEeyqkWMwPTONnOxDyH04ysM0cDLymaJGElnTs4fwmZlxZusX6GzOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YWyvM0K8Cz6L52x;
	Tue, 14 Jan 2025 00:51:11 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 4B7F9140A30;
	Tue, 14 Jan 2025 00:52:35 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 13 Jan
 2025 17:52:34 +0100
Date: Mon, 13 Jan 2025 16:52:33 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Robert Richter <rrichter@amd.com>
CC: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>
Subject: Re: [PATCH v1 05/29] cxl/region: Move find_cxl_root() to
 cxl_add_to_region()
Message-ID: <20250113165233.000067e3@huawei.com>
In-Reply-To: <20250107141015.3367194-6-rrichter@amd.com>
References: <20250107141015.3367194-1-rrichter@amd.com>
	<20250107141015.3367194-6-rrichter@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 7 Jan 2025 15:09:51 +0100
Robert Richter <rrichter@amd.com> wrote:

> When adding an endpoint to a region, the root port is determined
> first. Move this directly into cxl_add_to_region(). This is in
> preparation of the initialization of endpoints that iterates the port
> hierarchy from the endpoint up to the root port.
> 
> As a side-effect the root argument is removed from the argument lists
> of cxl_add_to_region() and related functions. Now, the endpoint is the
> only parameter to add a region. This simplifies the function
> interface.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
Seems reasonable to me.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/region.c |  6 ++++--
>  drivers/cxl/cxl.h         |  6 ++----
>  drivers/cxl/port.c        | 15 +++------------
>  3 files changed, 9 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 9b3efa841c8f..752440a5c162 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3307,9 +3307,11 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  	return ERR_PTR(rc);
>  }
>  
> -int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
> +int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
>  {
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +	struct cxl_port *port = cxled_to_port(cxled);
> +	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
>  	struct range *hpa = &cxled->cxld.hpa_range;
>  	struct cxl_decoder *cxld = &cxled->cxld;
>  	struct device *cxlrd_dev, *region_dev;
> @@ -3319,7 +3321,7 @@ int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
>  	bool attach = false;
>  	int rc;
>  
> -	cxlrd_dev = device_find_child(&root->dev, &cxld->hpa_range,
> +	cxlrd_dev = device_find_child(&cxl_root->port.dev, &cxld->hpa_range,
>  				      match_root_decoder_by_range);
>  	if (!cxlrd_dev) {
>  		dev_err(cxlmd->dev.parent,
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index fdac3ddb8635..5c1a55181e0f 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -872,8 +872,7 @@ struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(struct cxl_port *port);
>  #ifdef CONFIG_CXL_REGION
>  bool is_cxl_pmem_region(struct device *dev);
>  struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev);
> -int cxl_add_to_region(struct cxl_port *root,
> -		      struct cxl_endpoint_decoder *cxled);
> +int cxl_add_to_region(struct cxl_endpoint_decoder *cxled);
>  struct cxl_dax_region *to_cxl_dax_region(struct device *dev);
>  #else
>  static inline bool is_cxl_pmem_region(struct device *dev)
> @@ -884,8 +883,7 @@ static inline struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev)
>  {
>  	return NULL;
>  }
> -static inline int cxl_add_to_region(struct cxl_port *root,
> -				    struct cxl_endpoint_decoder *cxled)
> +static inline int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
>  {
>  	return 0;
>  }
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index d2bfd1ff5492..74587a403e3d 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -30,7 +30,7 @@ static void schedule_detach(void *cxlmd)
>  	schedule_cxl_memdev_detach(cxlmd);
>  }
>  
> -static int discover_region(struct device *dev, void *root)
> +static int discover_region(struct device *dev, void *unused)
>  {
>  	struct cxl_endpoint_decoder *cxled;
>  	int rc;
> @@ -49,7 +49,7 @@ static int discover_region(struct device *dev, void *root)
>  	 * Region enumeration is opportunistic, if this add-event fails,
>  	 * continue to the next endpoint decoder.
>  	 */
> -	rc = cxl_add_to_region(root, cxled);
> +	rc = cxl_add_to_region(cxled);
>  	if (rc)
>  		dev_dbg(dev, "failed to add to region: %#llx-%#llx\n",
>  			cxled->cxld.hpa_range.start, cxled->cxld.hpa_range.end);
> @@ -95,7 +95,6 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  	struct cxl_hdm *cxlhdm;
> -	struct cxl_port *root;
>  	int rc;
>  
>  	rc = cxl_dvsec_rr_decode(cxlds, &info);
> @@ -126,19 +125,11 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
>  	if (rc)
>  		return rc;
>  
> -	/*
> -	 * This can't fail in practice as CXL root exit unregisters all
> -	 * descendant ports and that in turn synchronizes with cxl_port_probe()
> -	 */
> -	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
> -
> -	root = &cxl_root->port;
> -
>  	/*
>  	 * Now that all endpoint decoders are successfully enumerated, try to
>  	 * assemble regions from committed decoders
>  	 */
> -	device_for_each_child(&port->dev, root, discover_region);
> +	device_for_each_child(&port->dev, NULL, discover_region);
>  
>  	return 0;
>  }

