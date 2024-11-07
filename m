Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A69C216DE8
	for <linux-cxl@vger.kernel.org>; Thu,  7 Nov 2024 18:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731002415; cv=none; b=EWyN2INM+ZSN/kd3HpVPYsLwkN/Nh40a9dfC8ezDUj2uq+hDUf2KY/z7PqTlZsw08dZYbCISF2MGWdbLOrGyWLO9gr3rx98/BIzZtVLgKqs5hN40ki+8+eDZ3U3mu2A+9yPcE4m3rSpuKLsfhKgDFquJDFaVGmVxhQSkmreAP28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731002415; c=relaxed/simple;
	bh=WsxZ53RjvOBINHqsu2X4toB9Qt9oOdplVRD4pMX+TyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B+9vnsYC/tlIj78qflPtJPcP08mlcS5GSwjgHOITHzeAIwCTYpELBjBYuEMHvV6YB1C1/ypCkpW7pfWpKAKCHW8bZOqMQjKFA2qlike4MI13LAwP0GoHOdoUg9XlxBvMpBWS5yZbk1TMLtlI5T13Lxe9r+0gwNlSAxMbAdz5MD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vp+TwJVb; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vp+TwJVb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731002414; x=1762538414;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WsxZ53RjvOBINHqsu2X4toB9Qt9oOdplVRD4pMX+TyU=;
  b=Vp+TwJVbcAL5CsCGNDWXiP2iQpRM5zWlWYvU8mP/wZuXKqSyvK8naNEH
   7ez+syji8iQF+6EhCkzirtPV8OwFY1E8/FuacMIDxGo3QJmrPlsLcrI7C
   qYsnXeUvt0FmGEJU7/iIOKTqcXLjpYuZnevZv5rqgQqBwT9O2xCrKDs2W
   cRxNEHOWvfHMmSgGS1VoAfD7E+7Yr3v/FCx3Z3BUADRENWKCsIOlVdV1A
   8nDbxozX69vwOYLzzccg5EGJtNi68Gv49Ia59Cnp1e+4vI7lmEc7WN/PE
   YVGdLOxnrycRndZ1s4knFiYZWIAkhyNAmXL1pOJRvThUjXL5NHzqxgToP
   Q==;
X-CSE-ConnectionGUID: DQAOSbYHSvWSsoQK8CRrxg==
X-CSE-MsgGUID: DgBPufjPSR6oaj1116pDkg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="31026679"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="31026679"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 10:00:14 -0800
X-CSE-ConnectionGUID: Y09Lzfm6ScuET2d94oFDuQ==
X-CSE-MsgGUID: PrrqJL8STnmapJPcMRwxRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,135,1728975600"; 
   d="scan'208";a="89819851"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.110.171])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 10:00:13 -0800
Date: Thu, 7 Nov 2024 10:00:11 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: ira.weiny@intel.com
Cc: Vishal Verma <vishal.l.verma@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Fan Ni <fan.ni@samsung.com>,
	Navneet Singh <navneet.singh@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
	nvdimm@lists.linux.dev, Sushant1 Kumar <sushant1.kumar@intel.com>
Subject: Re: [ndctl PATCH v2 4/6] cxl/region: Add creation of Dynamic
 capacity regions
Message-ID: <Zy0AK9FHMvst9fm3@aschofie-mobl2.lan>
References: <20241104-dcd-region2-v2-0-be057b479eeb@intel.com>
 <20241104-dcd-region2-v2-4-be057b479eeb@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104-dcd-region2-v2-4-be057b479eeb@intel.com>

On Mon, Nov 04, 2024 at 08:10:48PM -0600, Ira Weiny wrote:
> From: Navneet Singh <navneet.singh@intel.com>
> 
> CXL Dynamic Capacity Devices (DCDs) optionally support dynamic capacity
> with up to eight partitions (Regions) (dc0-dc7).  CXL regions can now be
> spare and defined as dynamic capacity (dc).
> 
> Add support for DCD devices.  Query for DCD capabilities.  Add the
> ability to add DC partitions to a CXL DC region.
> 
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> Co-authored-by: Sushant1 Kumar <sushant1.kumar@intel.com>
> Signed-off-by: Sushant1 Kumar <sushant1.kumar@intel.com>
> Co-authored-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes:
> [Fan: Properly initialize index]
> ---
>  cxl/json.c         | 26 +++++++++++++++
>  cxl/lib/libcxl.c   | 95 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  cxl/lib/libcxl.sym |  3 ++
>  cxl/lib/private.h  |  6 +++-
>  cxl/libcxl.h       | 55 +++++++++++++++++++++++++++++--
>  cxl/memdev.c       |  7 +++-
>  cxl/region.c       | 49 ++++++++++++++++++++++++++--
>  7 files changed, 234 insertions(+), 7 deletions(-)
> 
> diff --git a/cxl/json.c b/cxl/json.c
> index dcd3cc28393faf7e8adf299a857531ecdeaac50a..915b2716a524fa8929ed34b01a7cb6590b61d4b7 100644
> --- a/cxl/json.c
> +++ b/cxl/json.c
> @@ -754,10 +754,12 @@ err_free:
>  	return jpoison;
>  }
>  
> +#define DC_SIZE_NAME_LEN 64
>  struct json_object *util_cxl_memdev_to_json(struct cxl_memdev *memdev,
>  		unsigned long flags)
>  {
>  	const char *devname = cxl_memdev_get_devname(memdev);
> +	char size_name[DC_SIZE_NAME_LEN];
>  	struct json_object *jdev, *jobj;
>  	unsigned long long serial, size;
>  	const char *fw_version;
> @@ -800,6 +802,17 @@ struct json_object *util_cxl_memdev_to_json(struct cxl_memdev *memdev,
>  		}
>  	}
>  
> +	for (int index = 0; index < MAX_NUM_DC_REGIONS; index++) {
> +		size = cxl_memdev_get_dc_size(memdev, index);
> +		if (size) {
> +			jobj = util_json_object_size(size, flags);
> +			if (jobj) {
> +				sprintf(size_name, "dc%d_size", index);
> +				json_object_object_add(jdev,
> +						       size_name, jobj);
> +			}
> +		}
> +	}

how about reducing above indentation -

		if (!size)
			continue;
		jobj = util_json_object_size(size, flags);
		if (!jobj)
			continue;
		sprintf(size_name, "dc%d_size", index);
		json_object_object_add(jdev, size_name, jobj);




>  	if (flags & UTIL_JSON_HEALTH) {
>  		jobj = util_cxl_memdev_health_to_json(memdev, flags);
>  		if (jobj)
> @@ -948,11 +961,13 @@ struct json_object *util_cxl_bus_to_json(struct cxl_bus *bus,
>  	return jbus;
>  }
>  
> +#define DC_CAPABILITY_NAME_LEN 16
>  struct json_object *util_cxl_decoder_to_json(struct cxl_decoder *decoder,
>  					     unsigned long flags)
>  {
>  	const char *devname = cxl_decoder_get_devname(decoder);
>  	struct cxl_port *port = cxl_decoder_get_port(decoder);
> +	char dc_capable_name[DC_CAPABILITY_NAME_LEN];
>  	struct json_object *jdecoder, *jobj;
>  	struct cxl_region *region;
>  	u64 val, size;
> @@ -1059,6 +1074,17 @@ struct json_object *util_cxl_decoder_to_json(struct cxl_decoder *decoder,
>  				json_object_object_add(
>  					jdecoder, "volatile_capable", jobj);
>  		}
> +		for (int index = 0; index < MAX_NUM_DC_REGIONS; index++) {
> +			if (cxl_decoder_is_dc_capable(decoder, index)) {
> +				jobj = json_object_new_boolean(true);
> +				if (jobj) {
> +					sprintf(dc_capable_name, "dc%d_capable", index);
> +					json_object_object_add(jdecoder,
> +							       dc_capable_name,
> +							       jobj);
> +				}
> +			}

and similar above.


snip

