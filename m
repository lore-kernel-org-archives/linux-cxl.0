Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0DC25760;
	Tue, 22 Oct 2024 01:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729561250; cv=none; b=pFTDN3ggz/mw2IGIKEClgjRUQHL+e9iPNKyxr1VeYFeIfi2w5mtRgTFf9zvbgynUSvCb3hj3WsC4RDGT8LJjCoM6oar+zIryltEl34AlXLCF9aoQ5AB0hVjB5i0925R/wxJ7+eBoPIkSVAWZZvMWF5tnrz5z8vLMnClNM190HFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729561250; c=relaxed/simple;
	bh=Gt/PVUYQV6El5J261GXUty1BMmEhHEOaIC9LhPGHzqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VVfLCiX6uhmt93fvn0yYPsEalXqw59dn+RNaWrCYcTq/soKAuG5BrYRwzPl2wT+768wsU/oX2uT+5oWkX0hzyEosz3b4324uupm+OYflsfMkWmHKYvUcmm9o/qGzDNaLuhxDoO8ahFVXvb5C6pNx/d8l7ouyCp8yZBPckfDflr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lGocdDBy; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lGocdDBy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729561249; x=1761097249;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Gt/PVUYQV6El5J261GXUty1BMmEhHEOaIC9LhPGHzqE=;
  b=lGocdDByzxcPfYUtvyGW1Sk7Fu1P3xcxx5EGmbImsnqasOf5amaypGBc
   lgwvDfdIiMngAZafLd986N++AQq81ycoUvzZ9ao/oZ/hIOGwtpAkzzQ0X
   tD8a8/0H2uSf9Kw1IM+3WIfU0teIgk4f2arhpoHVhTErX6B6AfAT2fv9V
   GGUGIjelKNZyeiAU0NZA7UiXfkpeVG68sQq5e66QEQ1nfH6Di/s9fF4yy
   ZW/0S5+AiDWOUo8voN+0Y3ipBJp0Yctf3sqfFvX5eE3Dm26DGeUHkpcc2
   xxGsr9Q61j81tryGDBxwDEtOj8SDS/oXudLKFGQgifo7yLZdRpDplv9Ue
   A==;
X-CSE-ConnectionGUID: W43EMA1WQCO7DOg3BVq4vg==
X-CSE-MsgGUID: Fa4pKtEpSlGWRjzSpW/eLQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39614924"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="39614924"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 18:40:48 -0700
X-CSE-ConnectionGUID: Ov7jbqTHRKKh7fWxhpNGLQ==
X-CSE-MsgGUID: z6t+j8m+Q32GhMOy8xLdTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="84517902"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.110.129])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 18:40:47 -0700
Date: Mon, 21 Oct 2024 18:40:45 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Ira Weiny <ira.weiny@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Fan Ni <fan.ni@samsung.com>, Bagas Sanjaya <bagasdotme@gmail.com>,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH 3/3] cxl/cdat: Use %pra for dpa range outputs
Message-ID: <ZxcCnbV8fsSbTeGf@aschofie-mobl2.lan>
References: <20241018-cxl-pra-v1-0-7f49ba58208b@intel.com>
 <20241018-cxl-pra-v1-3-7f49ba58208b@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018-cxl-pra-v1-3-7f49ba58208b@intel.com>

On Fri, Oct 18, 2024 at 02:46:26PM -0500, Ira Weiny wrote:
> Now that there is a printf specifier for struct range use it to enhance
> the debug output of CDAT data.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  drivers/cxl/core/cdat.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index ef1621d40f05..438869df241a 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -247,8 +247,8 @@ static void update_perf_entry(struct device *dev, struct dsmas_entry *dent,
>  	dpa_perf->dpa_range = dent->dpa_range;
>  	dpa_perf->qos_class = dent->qos_class;
>  	dev_dbg(dev,
> -		"DSMAS: dpa: %#llx qos: %d read_bw: %d write_bw %d read_lat: %d write_lat: %d\n",
> -		dent->dpa_range.start, dpa_perf->qos_class,
> +		"DSMAS: dpa: %pra qos: %d read_bw: %d write_bw %d read_lat: %d write_lat: %d\n",
> +		&dent->dpa_range, dpa_perf->qos_class,
>  		dent->coord[ACCESS_COORDINATE_CPU].read_bandwidth,
>  		dent->coord[ACCESS_COORDINATE_CPU].write_bandwidth,
>  		dent->coord[ACCESS_COORDINATE_CPU].read_latency,
> @@ -279,8 +279,8 @@ static void cxl_memdev_set_qos_class(struct cxl_dev_state *cxlds,
>  			 range_contains(&pmem_range, &dent->dpa_range))
>  			update_perf_entry(dev, dent, &mds->pmem_perf);
>  		else
> -			dev_dbg(dev, "no partition for dsmas dpa: %#llx\n",
> -				dent->dpa_range.start);
> +			dev_dbg(dev, "no partition for dsmas dpa: %pra\n",
> +				&dent->dpa_range);
>  	}
>  }

This is a bit different than what I expected to find as the initial use case
because it wasn't printing a range. With this change we go from printing only
the .start to printing the range. Seems the wording of the dev_ message could
change too since 'dpa' has been replaced with a 'dpa range'.

There are a few places that print the range now and can be cleaned up w this
specifier. Those are the real 'uglies' like this:

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 223c273c0cd1..85a121b7b2b5 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -941,8 +941,8 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
                return rc;
        }

-       dev_dbg(&port->dev, "decoder%d.%d: range: %#llx-%#llx iw: %d ig: %d\n",
-               port->id, cxld->id, cxld->hpa_range.start, cxld->hpa_range.end,
+       dev_dbg(&port->dev, "decoder%d.%d: range: %pra iw: %d ig: %d\n",
+               port->id, cxld->id, &cxld->hpa_range,
                cxld->interleave_ways, cxld->interleave_granularity);


I guess you could (ducks) pick them all up here, or we can leave it
for a future cleanup, or we can just say no cleanups and we'll use
%pra going forward only.

-- Alison

>  
> 
> -- 
> 2.47.0
> 
