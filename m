Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF71417BBB;
	Mon,  1 Jul 2024 22:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719872251; cv=none; b=rs0yLgcEigLTbP3UeFo0XdYaWNW+LTd26tnCyaE8Su4LKq9En0sej99S5JwBUjNNA9NgC4q2ie5bs31jQiItCkJi3JYNUg7zAdpMT5yYJZdQCHLeTcmOTPIUAayIQbHANmRl7AwDufs1hB3q1h09B5nW0HKcm2L6Izq3k2wvwlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719872251; c=relaxed/simple;
	bh=ypln3xtfdY+qTlND/BUVBQNANbTWSfpm81vU+bhlhYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dHR6YTXnEfw92Wk2eKJryyAC1fmxDNpM1Hw2aQbZFg9YVDkehtjNw48cGbJ6wKy7jbU5PtC1q5ukVzdluzl+9Wi1N9vTRlW0b4rqpmxEuLS7i3WsRyFS7HLqHqXu9Mrsai+CQGG18JA1Xk6ZDmA9hVUVHRtuCzL4qhqDug/wIQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aYL9dcFW; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aYL9dcFW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719872249; x=1751408249;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ypln3xtfdY+qTlND/BUVBQNANbTWSfpm81vU+bhlhYg=;
  b=aYL9dcFWJbTGTY/rm3GqnVwJkMycxO1XiGKdv2Gpw9gB2SZYq3ld9Jua
   MtzZT0+ruLHpu01L5LC9dCj04SCnW27gkChE05C2LBOBCDlXpRiGvJSQT
   lLjqLDuXYwMwYy7TA3VY49thVk06Tue3H8kRAZPBXYhXy0pcslc1wZePX
   rSnb+A/CWhCOH4DFfGU1wZs2KWGwJ5jqv/7KvnDrI69fEU7jWXfSqtcTk
   DNPw8RXdugbBbEXrnNsjr10ZjlKQPcO5JzQz5g09jgCi5Dv9u71On428F
   OjS+OPSI2uQRFbtFr6QjkNcEhoefBjt4CxiN/AhxGzbRy0QQUKYgLFWW9
   w==;
X-CSE-ConnectionGUID: N5O2HxQsQhScm3eSSE/Mow==
X-CSE-MsgGUID: CsXMX+eoTNmw6GG3VRbgOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="20838028"
X-IronPort-AV: E=Sophos;i="6.09,177,1716274800"; 
   d="scan'208";a="20838028"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 15:17:28 -0700
X-CSE-ConnectionGUID: xtySfyyvQFiolTevKDyqWg==
X-CSE-MsgGUID: vn9xAMrHSru96ckgp0M8yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,177,1716274800"; 
   d="scan'208";a="50122807"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.105.13])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 15:17:27 -0700
Date: Mon, 1 Jul 2024 15:17:25 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2] cxl/acpi: Warn on mixed CXL VH and RCH/RCD Hierarchy
Message-ID: <ZoMq9TQoLTMaEPlJ@aschofie-mobl2>
References: <20240628175535.272472-1-fabio.m.de.francesco@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628175535.272472-1-fabio.m.de.francesco@linux.intel.com>

On Fri, Jun 28, 2024 at 07:48:07PM +0200, Fabio M. De Francesco wrote:
> Each Host Bridge instance has a corresponding CXL Host Bridge Structure
> (CHBS) ACPI table that identifies its capabilities. CHBS tables can be
> two types (CXL 3.1 Table 9-21): The PCIe Root Complex Register Block
> (RCRB) and CXL Host Bridge Component Registers (CHBCR).
> 
> If a Host Bridge is attached to a device that is operating in Restricted
> CXL Device Mode (RCD), BIOS publishes an RCRB with the base address of
> registers that describe its capabilities (CXL 3.1 sec. 9.11).
> 
> Instead, the new (CXL 2.0+) Component registers can only be accessed
> by means of a base address published with a CHBCR (CXL 3.1 sec. 9.12).
> 
> If an eRCD (a device that forces the host-bridge into CXL 1.1 Restricted
> CXL Host mode) is attached to a CXL 2.0+ Host-Bridge, the current CXL
> specification does not define a mechanism for finding CXL-2.0-only
> root-port component registers like HDM decoders and Extended Security
> capability.
> 
> An algorithm to locate a CHBCR associated with an RCRB, would be too
> invasive to land without some concrete motivation.
> 
> Therefore, just print a message to inform of unsupported config.
> 
> Count how many different CHBS "Version" types are detected by
> cxl_get_chbs_iter(). Then make cxl_get_chbs() print a warning if that sum
> is greater than 1.
> 
> Tested-by: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
> ---
> 
> --- Changes for v2 ---
> 
> 	- Rewrite the Subject line (Alison)
> 	- Address a bug found by Alison while testing (thanks!)

'Address' a bug doesn't descibe what changed from v1 especially for
folks who reviewed v1.

I'm not asking you to rev this patch, just explain the saved_version
change.

Thanks
-- Alison

> 	- Add reference to CXL 3.1 Spec. (Alison)
> 	- Extend the commit messages by borrowing comments to v1 (Dan)
> 	- Rename field "count" to "nr_versions" (Alison)
> 	- Add brackets to oneline 'if' statement in precence of comments
> 	  (Dan)
> 
> --- Link to v1 ---
> 
> https://lore.kernel.org/linux-cxl/20240619125949.167936-1-fabio.m.de.francesco@linux.intel.com/
> 
>  drivers/cxl/acpi.c | 34 +++++++++++++++++++++++++++-------
>  1 file changed, 27 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 571069863c62..f9035dbabb1c 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -482,6 +482,8 @@ struct cxl_chbs_context {
>  	unsigned long long uid;
>  	resource_size_t base;
>  	u32 cxl_version;
> +	int nr_versions;
> +	u32 saved_version;
>  };
>  
>  static int cxl_get_chbs_iter(union acpi_subtable_headers *header, void *arg,
> @@ -490,22 +492,31 @@ static int cxl_get_chbs_iter(union acpi_subtable_headers *header, void *arg,
>  	struct cxl_chbs_context *ctx = arg;
>  	struct acpi_cedt_chbs *chbs;
>  
> -	if (ctx->base != CXL_RESOURCE_NONE)
> -		return 0;
> -
>  	chbs = (struct acpi_cedt_chbs *) header;
>  
> -	if (ctx->uid != chbs->uid)
> +	if (chbs->cxl_version == ACPI_CEDT_CHBS_VERSION_CXL11 &&
> +	    chbs->length != CXL_RCRB_SIZE)
>  		return 0;
>  
> -	ctx->cxl_version = chbs->cxl_version;
>  	if (!chbs->base)
>  		return 0;
>  
> -	if (chbs->cxl_version == ACPI_CEDT_CHBS_VERSION_CXL11 &&
> -	    chbs->length != CXL_RCRB_SIZE)
> +	if (ctx->saved_version != chbs->cxl_version) {
> +		/*
> +		 * cxl_version cannot be overwritten before the next two
> +		 * checks, then use saved_version
> +		 */
> +		ctx->saved_version = chbs->cxl_version;
> +		ctx->nr_versions++;
> +	}
> +
> +	if (ctx->base != CXL_RESOURCE_NONE)
> +		return 0;
> +
> +	if (ctx->uid != chbs->uid)
>  		return 0;
>  
> +	ctx->cxl_version = chbs->cxl_version;
>  	ctx->base = chbs->base;
>  
>  	return 0;
> @@ -529,10 +540,19 @@ static int cxl_get_chbs(struct device *dev, struct acpi_device *hb,
>  		.uid = uid,
>  		.base = CXL_RESOURCE_NONE,
>  		.cxl_version = UINT_MAX,
> +		.saved_version = UINT_MAX,
>  	};
>  
>  	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CHBS, cxl_get_chbs_iter, ctx);
>  
> +	if (ctx->nr_versions > 1) {
> +		/*
> +		 * Disclaim eRCD support given some component register may
> +		 * only be found via CHBCR
> +		 */
> +		dev_info(dev, "Unsupported platform config, mixed Virtual Host and Restricted CXL Host hierarchy.");
> +	}
> +
>  	return 0;
>  }
>  
> -- 
> 2.45.2
> 
