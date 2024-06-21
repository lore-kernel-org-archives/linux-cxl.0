Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2730B1607B3;
	Fri, 21 Jun 2024 20:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719003459; cv=none; b=vC05LmF8N/UBul2s+yTX6ZL3YA4c0RR9QsYQuEfIpDPQah8tmbA/98GCi2Jre7UtlHzQXCfQqUYBDZdcfIzV0ZprA+LrFQ/Ikurxo4Dak9I2chwJJ1VGnzo9+O74cQ1ESS20rMIlQL2+7qy8j5mEgyuxUlS1IYiaQfRORZ9kgaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719003459; c=relaxed/simple;
	bh=2UYSm+OuTKQvO73eRpd2wGw7T/UPQzUjqIp9bW8MHfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EbpN13gdp8T4fsSerxPa2HJt9CkB5nuGt7SJoAWheqCmebdej4Uz+IsrEpH8ZlpWbPjHbVwEE9E2VFZqJEJxncyZbiSYjQXdlZTp9IJARdJ1OhW+XSmGQsOueaJ20j0S4/7R16G95H511h8EOZdiAZq/CNOjrooqOHpIcCWoFqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RacLbu9e; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RacLbu9e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719003457; x=1750539457;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2UYSm+OuTKQvO73eRpd2wGw7T/UPQzUjqIp9bW8MHfU=;
  b=RacLbu9eB8N5quXeBVynlsoy4or1Xe4RFpNQXbcgYrymY2/ANUez2g5X
   66VNZq7W86efAk0w8rMRYt8sg8JkeFL+sUl0kC8EzgomxZlplULyN/AyV
   oeVixxvKslgvVBrHj/0mKjEppnBZCL/bXvHbCACgfHcCtAauJneAwlLz/
   iDTEOhEl4l/NhcTXl3wk+R0Z+BEQB4biQSNrmattxoJ/Ca7ms27Kvroyk
   XBFuR2y4f1XTV6Xw1dQ/KIB6STPudYsrcrpuV8CQG9FRqo6jTBZ7g5I4v
   1jvklnEXy0dLHOZa4+gSOkGH92p0JiV+XrAlEuIFmL8upf5p1wSj2Pl/9
   A==;
X-CSE-ConnectionGUID: owV2I+GDRMOPkWLE4DFg+Q==
X-CSE-MsgGUID: ddUNMALjTOSdOltY5TgjOg==
X-IronPort-AV: E=McAfee;i="6700,10204,11110"; a="16171311"
X-IronPort-AV: E=Sophos;i="6.08,255,1712646000"; 
   d="scan'208";a="16171311"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2024 13:57:37 -0700
X-CSE-ConnectionGUID: n46erGAoTNGCQfKSZ0mOKA==
X-CSE-MsgGUID: C0TYepGcTRqTNNDzlzSMDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,255,1712646000"; 
   d="scan'208";a="65948774"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.102.249])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2024 13:57:35 -0700
Date: Fri, 21 Jun 2024 13:57:32 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cxl/acpi: Warn on unsupported platform config detection
Message-ID: <ZnXpPGV57o7v4xYT@aschofie-mobl2>
References: <20240619125949.167936-1-fabio.m.de.francesco@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619125949.167936-1-fabio.m.de.francesco@linux.intel.com>

On Wed, Jun 19, 2024 at 02:59:41PM +0200, Fabio M. De Francesco wrote:

Hi Fabio,
You've written such a detailed commit msg, that it pulls me in,
and now I want to understand more....


> Each Host Bridge instance has a corresponding CXL Host Bridge Structure
> (CHBS) ACPI table that identifies its capabilities. CHBS tables can be
> two types: RCRB and CHBCR.

Is there a spec reference for this?
While you're spelling things out, please expand RCRB and CHBCR

> 
> If a Host Bridge is attached to a device that is operating in Restricted
> CXL Device Mode (RCD), BIOS publishes an RCRB with the base address of
> registers that describe its capabilities.
> 
> However, the new (CXL 2.0+) Component registers (e.g., Extended Security
> Capability), can only be accessed by means of a base address published
> with a CHBCR.
> 
> An algorithm to locate a CHBCR associated with an RCRB would be too
> invasive to land without some concrete motivation.
> 
> Therefore, just print a message to inform of unsupported config.
> 


Were users seeing this and confused by this silent failure?
What did it look like before?


> Count how many different CHBS "Version" types are detected by
> cxl_get_chbs_iter(). Then make cxl_get_chbs() print a warning if that sum
> is greater than 1.
> 
> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
> ---
>  drivers/cxl/acpi.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 571069863c62..9e226a65a5ea 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -482,6 +482,7 @@ struct cxl_chbs_context {
>  	unsigned long long uid;
>  	resource_size_t base;
>  	u32 cxl_version;
> +	int count;

Maybe s/count/nr_versions to be more explicit of what it counts.

-- Alison
>  };
>  
snip
> 
