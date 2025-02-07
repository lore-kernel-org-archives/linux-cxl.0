Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831308479;
	Fri,  7 Feb 2025 22:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738966931; cv=none; b=uL03/ByX9eKI2pgerhBHKRlu73aKaoFv7qKPmiqXtke8Dj0nQxF60hcU1vmCxbq9DlE6z69WMIPLP5mtPz698vhyBMFD1rSpFGeS9CX5DkcYiKtaPhxoo1tvanXjvtpg5A1DZ1dBPX7aUIYqJQd3GE7ngWifsfNQChTpVwJ/4KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738966931; c=relaxed/simple;
	bh=4IoCEk/tAjd8JEMqSopgO2Y7+eRV8cqL0jxI6XMXQvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PDnRUgRxRYTcbUAPMRKFvqvS8saFNMdxxC8a8Klk0ynCxxuEagU9X2yXontkZxq2TlCpXjN6qym/0PvoL5bnT/mwfV//wnRwOLrmZu44hcG0jjXaI55jrK1xCnM4q/+lH4ogQOgezSy8D+AZsaVBgxTl08sPXsM3ikBiFqG8Hyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LR0KJWkG; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LR0KJWkG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738966929; x=1770502929;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4IoCEk/tAjd8JEMqSopgO2Y7+eRV8cqL0jxI6XMXQvs=;
  b=LR0KJWkG/taAK1HyQs0k74oQ1NhK+lbSmx2DTsMQ98acW2Z3hLp5jKSa
   EZt2wulFW8ta7ihT2Z5IE4wlDzHU9fFo14vzSZ4e7FS1Czhtagjd7XbyR
   VJqlQzyBfDrmRXEaKQtN4XKScFpcb10YZ8L0LWs8DKsLjyx0sjpBANiBf
   zw7KkRUy8POOKevPWMA8aDrDo56mnQdZfghUqTSbgF6FqkGwXE2npvd9+
   1+27pPgb42wm5IUX8SxOvqE2FLDGflsAE3ImLhDOMx1FkZUMS570cuKGW
   hktthWWUrTNT173BBVb02ysRDZar4Cy/cpxFYhk42WTdsuqCM8rJfYYao
   A==;
X-CSE-ConnectionGUID: Gbu9IdBvRVmtVYWmoT+Scg==
X-CSE-MsgGUID: 4/OX13T6RS2sQ3mS4g9h3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="42462550"
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; 
   d="scan'208";a="42462550"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 14:22:08 -0800
X-CSE-ConnectionGUID: 5dvWo4bCQTW+52ds4wUF3A==
X-CSE-MsgGUID: W3F1OP9GQJyiWjnCKPCYTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; 
   d="scan'208";a="111414811"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.111.82])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 14:22:08 -0800
Date: Fri, 7 Feb 2025 14:22:06 -0800
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
Subject: Re: [PATCH v2 13/18] cxl/region: Add function to find a port's
 switch decoder by range
Message-ID: <Z6aHjiROdVotsZt5@aschofie-mobl2.lan>
References: <20250207153753.418849-1-rrichter@amd.com>
 <20250207153753.418849-14-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207153753.418849-14-rrichter@amd.com>

On Fri, Feb 07, 2025 at 04:37:48PM +0100, Robert Richter wrote:
> Factor out code to find the switch decoder of a port for a specific
> address range. Reuse the code to search a root decoder, create the
> function cxl_port_find_switch_decoder() and rework
> match_root_decoder_by_range() to be usable for switch decoders too.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/core/region.c | 46 +++++++++++++++++++++++----------------
>  1 file changed, 27 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index cfcd235f311e..15286acdf6d1 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c

snip


> @@ -3218,9 +3234,8 @@ cxl_find_root_decoder(struct cxl_endpoint_decoder *cxled)
>  	if (!iter)
>  		return NULL;
>  
> -	cxlrd_dev = device_find_child(&iter->dev, hpa,
> -				      match_root_decoder_by_range);
> -	if (!cxlrd_dev) {
> +	cxld = cxl_port_find_switch_decoder(iter, hpa);
> +	if (!cxld) {
>  		dev_err(cxlmd->dev.parent,
>  			"%s:%s no CXL window for range %#llx:%#llx\n",
>  			dev_name(&cxlmd->dev), dev_name(&cxld->dev),

The dev_err() needs cleanup to align with !cxld.
As it is now, fails w NULL ptr dereference.

--snip
