Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F0A1E4BE;
	Thu, 20 Feb 2025 17:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740073523; cv=none; b=Z2pS8NOnkmFWHUQlMzHq/0z1s6iDO4Dzj7LB03UkE5sCfGWqXt+/skNZiQY8kJvcfvAeVpfJkfgz/izsiUKwopJc7O907EPBP4zXGKgFGpy/rjFztdJ9nrD3Gf6CASybysSSOjr0deeY79u9DTmEfdA3QLBzhG+5GWPSn0/xtz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740073523; c=relaxed/simple;
	bh=FRyLEQOvImjuJcCxe9IpLknE2A6wIIYzLraFhaPRycM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OkM7ZLW697c1EHVHLR2rqrEFR5Li5vVUwqIkAG++7CJl28SAyjVwWX4mUwOnIHtK5UJBuVSe+kPXziKBf7EAxtk1c5elERPQK2kCSfkdlfi4DSd14jl5eJLnFSMtvEKj9HNmHi6EgUIwbN8inAYje8CCQb6iWGL9LQRqWFasm7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VhXijt8b; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VhXijt8b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740073522; x=1771609522;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FRyLEQOvImjuJcCxe9IpLknE2A6wIIYzLraFhaPRycM=;
  b=VhXijt8bPv5J0nAAjS7HZsV88nJT5i8fuSzU9DtuwKWF28Hs8f5ROqZr
   lgmU2w3s4RHk0nFkGlsqG4Cb+vjlGGYiK6b2PiQloFs0tr7lryFMz3jDK
   cpbnM51RNwdYJo3ET489mblpHyaqcPFdlGxcMGoCIp9tqZbRCotf7ihnu
   4JpAS2Xv+piFvhd5jeRMZ7UKJBcOgby/7/EKplkTqIWKM5qLAyfjxxqvT
   DZIHoe9/yAyVympiM/iWoS177qZ7lPznL8ecqMeGZ7w3qQD87bSTbyOSa
   M1QG0WLgx9kVMvCe4teGcbEHwCAl5uU3+JI4t5goRLp0wc7QMzX6asWNp
   A==;
X-CSE-ConnectionGUID: lbN5JAeEQ7W4Uqk931AIrQ==
X-CSE-MsgGUID: 9Pt6OFDGSG2irPVPur4aAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="40582911"
X-IronPort-AV: E=Sophos;i="6.13,302,1732608000"; 
   d="scan'208";a="40582911"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 09:45:21 -0800
X-CSE-ConnectionGUID: a13ai/qEStKtU2LxXDqxtA==
X-CSE-MsgGUID: patW+wXYTWGOylL5EFbSRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,302,1732608000"; 
   d="scan'208";a="145967164"
Received: from puneetse-mobl.amr.corp.intel.com (HELO [10.125.110.112]) ([10.125.110.112])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 09:45:20 -0800
Message-ID: <fc1c2896-cd90-4e24-b211-41ad090aad6c@intel.com>
Date: Thu, 20 Feb 2025 10:45:17 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 17/18] cxl: Add a dev_dbg() when a decoder was added to
 a port
To: Robert Richter <rrichter@amd.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Davidlohr Bueso <dave@stgolabs.net>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gregory Price <gourry@gourry.net>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Terry Bowman <terry.bowman@amd.com>
References: <20250211095349.981096-1-rrichter@amd.com>
 <20250211095349.981096-18-rrichter@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250211095349.981096-18-rrichter@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/11/25 2:53 AM, Robert Richter wrote:
> Improve debugging by adding and unifying messages whenever a decoder
> was added to a port. It is especially useful to get the decoder
> mapping of the involved CXL host bridge or PCI device. This avoids a
> complex lookup of the decoder/port/device mappings in sysfs.
> 
> Example log messages:
> 
>   cxl_acpi ACPI0017:00: decoder0.0 added to root0
>   cxl_acpi ACPI0017:00: decoder0.1 added to root0
>   ...
>    pci0000:e0: decoder1.0 added to port1
>    pci0000:e0: decoder1.1 added to port1
>   ...
>   cxl_mem mem0: decoder5.0 added to endpoint5
>   cxl_mem mem0: decoder5.1 added to endpoint5
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Tested-by: Gregory Price <gourry@gourry.net>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/acpi.c     | 10 +++++++++-
>  drivers/cxl/core/hdm.c |  3 ++-
>  2 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index cb14829bb9be..3e75e612cbc4 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -421,7 +421,15 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
>  	rc = cxl_decoder_add(cxld, target_map);
>  	if (rc)
>  		return rc;
> -	return cxl_root_decoder_autoremove(dev, no_free_ptr(cxlrd));
> +
> +	rc = cxl_root_decoder_autoremove(dev, no_free_ptr(cxlrd));
> +	if (rc)
> +		return rc;
> +
> +	dev_dbg(root_port->dev.parent, "%s added to %s\n",
> +		dev_name(&cxld->dev), dev_name(&root_port->dev));
> +
> +	return 0;
>  }
>  
>  static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index d705dec1471e..467e4fef6a53 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -34,7 +34,8 @@ static int add_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  	if (rc)
>  		return rc;
>  
> -	dev_dbg(&cxld->dev, "Added to port %s\n", dev_name(&port->dev));
> +	dev_dbg(port->uport_dev, "%s added to %s\n",
> +		dev_name(&cxld->dev), dev_name(&port->dev));
>  
>  	return 0;
>  }

