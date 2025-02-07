Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AF9198E92;
	Fri,  7 Feb 2025 23:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738971647; cv=none; b=RuxJy4Z04ip5oytOntjHgS7jhNT2B/iIin4kMPtDRfm2RB+2XFCEkSGVYVxVLkWgXeXbH4qOz/XAd2Vx0R0s+fnDZNi6DclGDCddpmWM0pK9QDeKAXRAeKLl9jz9/ahy9I2cRm3zqWkRLF+G8Pmk85GHNF8jFPItI7ui6LAAPfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738971647; c=relaxed/simple;
	bh=QH5r4JcI1cCChUmKcNsD6sehF38Dm8WGxsDPduh0Ggs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GZ7IvbnbJ6TLNQGj6gYf2OhHsWX96UEAeO/hd1bCru+YR+xqcjIdWVvnrHTBr32QeOMEONDLiynpTgWx1LudycFmkc+FPh4JmEnJFgf1RVGF3vXcwWFY+7kU6cuHr0QNPvmU7BFySnob3Kv8/Q17PO/7vCi9PyU7YvDp5msoTt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jnGIA4K6; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jnGIA4K6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738971645; x=1770507645;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QH5r4JcI1cCChUmKcNsD6sehF38Dm8WGxsDPduh0Ggs=;
  b=jnGIA4K6JobkBTwxQSTeOUgMwTLjeX8QGYsHO/9ghHzD8O/Ig+acCJBs
   m+YfVNESDuKdAyXNYOjdrBgS1e1MhZnaXae7ObPX5pYj4O9A2oNV4U+Tr
   eIqPOGxH+2aS+jVuEQbORb9P0cpeWncc5145ZdXcpzPHviW4N82pIvOqr
   M3M0V9rkBoEQxzh+Hm7qM3q1SMZE0KgmtsM9I3R3VYlwFSnlhEdYtUoyN
   wGgoFcpNO+6TSopGZnd0g6jpR1PJQLeHYCutVe/rwQlsyIR7KJGF0961r
   5zxJE3ccy/wjXtlDZjHgKzDVzEU7hZzmq57U3quIgQZC63/wHAgK5f2Ii
   Q==;
X-CSE-ConnectionGUID: XQv2TnqyRfiS1r16XrVHgg==
X-CSE-MsgGUID: MMj/DO9mTAKC+V46KA0iXg==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="62101129"
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; 
   d="scan'208";a="62101129"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 15:40:45 -0800
X-CSE-ConnectionGUID: uJHF7WsUSESEh63Up+Y5/Q==
X-CSE-MsgGUID: mYHVh5Q5SC+nHvUiwtDbgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="116869432"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.111.82])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 15:36:47 -0800
Date: Fri, 7 Feb 2025 15:36:45 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Robert Richter <rrichter@amd.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gregory Price <gourry@gourry.net>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v2 16/18] cxl/region: Show message on broken target list
Message-ID: <Z6aZDYtWoRezYGG0@aschofie-mobl2.lan>
References: <20250207153753.418849-1-rrichter@amd.com>
 <20250207153753.418849-17-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207153753.418849-17-rrichter@amd.com>

On Fri, Feb 07, 2025 at 04:37:51PM +0100, Robert Richter wrote:
> Broken target lists are hard to discover as the driver fails at a
> later initialization stage. Add an error message for this.

Hi Richard - There's 3 of these patches in a row, so I'll share
the common ask here. How about replacing vague 'Show message'
with type of message like "Add [dev_dbg() | dev_warn() | dev_err()]...
I think there is one of each flavor.

For this one, are you able to append here what it looks like
when there is a broken target list during region creation.
ie...put in context how this message fits into the full spew.

> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> ---
>  drivers/cxl/core/region.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 606f5652114b..3b578ca167e5 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1790,6 +1790,13 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
>  	}
>  	put_device(dev);
>  
> +	if (rc)
> +		dev_err(port->uport_dev,
> +			"failed to find %s:%s in target list of %s\n",
> +			dev_name(&port->dev),
> +			dev_name(port->parent_dport->dport_dev),
> +			dev_name(&cxlsd->cxld.dev));
> +
>  	return rc;
>  }
>  
> -- 
> 2.39.5
> 
