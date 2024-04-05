Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2989D16D4FD
	for <linux-cxl@vger.kernel.org>; Fri,  5 Apr 2024 13:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712324911; cv=none; b=WlUP7fnJhLTh38+hnxRO6YlLYgGOmKHqXyeA/W7g+dASPfqXI4jBjSae5kqbBnB3RqYlzWdbvrCipEUpNrmOD3DoRjzOjgkNUMMqARBiQkZjqy21u5rSLvOa/PoLso1405GS81Q4QFgeUbQYkv0r+F7G9x+82F3j660nLbCvnBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712324911; c=relaxed/simple;
	bh=6u98lzhCDLwlJf5cp86N2kLqwmmf3WXbnBPWvJMBmO8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qgLa1rIhxszrRrmRUVESvPDpFXAHlTeaQVb4MehwyGZGTp/Axmi8FO4wQl8XoQTlCzxvWbkIa0ndJJvoT1Pzw/aDJ8wUWRcmpyrs1Au6dtJYRMkDqtV+sWZJK9ArQgqCIk2AO5J/J+KGx19+ZZGgllihsIS0T2ssDGBTMVPri1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VB07h5pVYz6K8wH;
	Fri,  5 Apr 2024 21:43:44 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 7B9271400DC;
	Fri,  5 Apr 2024 21:48:25 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 5 Apr
 2024 14:48:25 +0100
Date: Fri, 5 Apr 2024 14:48:24 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>
Subject: Re: [PATCH v7 3/5] cxl: Fix incorrect region perf data calculation
Message-ID: <20240405144824.00007e34@Huawei.com>
In-Reply-To: <20240403154844.3403859-4-dave.jiang@intel.com>
References: <20240403154844.3403859-1-dave.jiang@intel.com>
	<20240403154844.3403859-4-dave.jiang@intel.com>
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
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 3 Apr 2024 08:47:14 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Current math in cxl_region_perf_data_calculate divides the latency by 1000
> every time the function gets called. This causes the region latency to be
> divided by 1000 per memory device and the math is incorrect. This is user
> visible as the latency access_coordinate exposed via sysfs will show
> incorrect latency data.
> 
> Normalize values from CDAT to nanoseconds. Adjust sub-nanoseconds latency
> to at least 1. Remove adjustment of perf numbers from the generic target
> since hmat handling code has already normalized those numbers. Now all
> computation and stored numbers should be in nanoseconds.
> 
> cxl_hb_get_perf_coordinates() is removed and HB coords are calculated
> in the port access_coordinate calculation path since it no longer need
> to be treated special.
> 
> Fixes: 3d9f4a197230 ("cxl/region: Calculate performance data for a region")
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

I should stop reading this code... 

What happens with the bandwidth if the minimum point on path to EP is shared?
Gets more complex as maybe the shared bit wasn't the minimum bandwidth previously
but when it's 'split' across multiple paths it becomes so.
E.g. HEre the min on each path is 5, but the bottleneck is actually the RP to
switch at 8 once we are interleaving across EP0 and EP1.

     CPU
      |
     HB
      |
     RP
      |
  <min BW here = 8>
      |
    SWITCH
    |    |
<each of these BW 5>
   EP0  EP1


None of this mattered with traditional HMAT entries because they
are point to point so if such interleaving is going on it was
a problem for the BIOS writer...

Not related to what you are fixing here though so
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>



> @@ -521,17 +525,13 @@ void cxl_region_perf_data_calculate(struct cxl_region *cxlr,
>  				    struct cxl_endpoint_decoder *cxled)
>  {
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> -	struct cxl_port *port = cxlmd->endpoint;
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> -	struct access_coordinate hb_coord[ACCESS_COORDINATE_MAX];
> -	struct access_coordinate coord;
>  	struct range dpa = {
>  			.start = cxled->dpa_res->start,
>  			.end = cxled->dpa_res->end,
>  	};
>  	struct cxl_dpa_perf *perf;
> -	int rc;
>  
>  	switch (cxlr->mode) {
>  	case CXL_DECODER_RAM:
> @@ -549,35 +549,16 @@ void cxl_region_perf_data_calculate(struct cxl_region *cxlr,
>  	if (!range_contains(&perf->dpa_range, &dpa))
>  		return;
>  
> -	rc = cxl_hb_get_perf_coordinates(port, hb_coord);
> -	if (rc)  {
> -		dev_dbg(&port->dev, "Failed to retrieve hb perf coordinates.\n");
> -		return;
> -	}
> -
>  	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++) {
> -		/* Pickup the host bridge coords */
> -		cxl_coordinates_combine(&coord, &hb_coord[i], &perf->coord);
> -
>  		/* Get total bandwidth and the worst latency for the cxl region */

Worst latency from what set of choices? Perhaps useful to call that out (multiple EP
paths?)

>  		cxlr->coord[i].read_latency = max_t(unsigned int,
>  						    cxlr->coord[i].read_latency,
> -						    coord.read_latency);
> +						    perf->coord.read_latency);
>  		cxlr->coord[i].write_latency = max_t(unsigned int,
>  						     cxlr->coord[i].write_latency,
> -						     coord.write_latency);
> -		cxlr->coord[i].read_bandwidth += coord.read_bandwidth;
> -		cxlr->coord[i].write_bandwidth += coord.write_bandwidth;
> -
> -		/*
> -		 * Convert latency to nanosec from picosec to be consistent
> -		 * with the resulting latency coordinates computed by the
> -		 * HMAT_REPORTING code.
> -		 */
> -		cxlr->coord[i].read_latency =
> -			DIV_ROUND_UP(cxlr->coord[i].read_latency, 1000);
> -		cxlr->coord[i].write_latency =
> -			DIV_ROUND_UP(cxlr->coord[i].write_latency, 1000);
> +						     perf->coord.write_latency);
> +		cxlr->coord[i].read_bandwidth += perf->coord.read_bandwidth;
> +		cxlr->coord[i].write_bandwidth += perf->coord.write_bandwidth;

As above, this might be the same bandwidth we are double counting...

>  	}
>  }
>  
>
