Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40221EEA6;
	Thu, 24 Oct 2024 02:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729736079; cv=none; b=qd294s3yCu0n2+HuTg/MxuW+noSlCPUEgOcIGoL0FYwmg1ZXEvvWim/ldG+MJW68bEG7wg3reHgvPx2QS4+X6UIquKohJHcqnRrgfQBlOboLiszOGvCCOOMa1383EU7N4J7OUKL6dsbrrVQVai3kBIGjDQudMbAdcOQ6LD0vii4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729736079; c=relaxed/simple;
	bh=h1p/WI60gYppi0F2wi3wHK02AFQzr0j8HYPh4zbp6pw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cwOIrAw2uV/pCM/G7GrBuwMjrBDQpFRcuKT8LNYMjMkLYZsBhRRYcsHWn9UbYZPeTh0t/q4ZM4W1O7fN1Sa1YTS/bmXQw8Tk0adHCwzgQHBoIqg0d8xBSagDiHXxknllBMpUCpVvm47AFBG7AmFgXWP3W4yPw5mj+WWIZNUwH7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DduEMkc8; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DduEMkc8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729736076; x=1761272076;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=h1p/WI60gYppi0F2wi3wHK02AFQzr0j8HYPh4zbp6pw=;
  b=DduEMkc8eFhbIWFWFkGOUb1IYQIw1uVTYXUKT41DL81mxyS6PxELpIm3
   7EDPsfE9YIMZexEAsGjtaNtNB55qVJ2sh4jG7q/Pu/OlYY/4CoouRNP8+
   97lLNwRUPh8OEgCzsk5zZC1O8eGh9x2DEzPd1QfXEcE4rGAk0vLXNYivX
   XvjkeDA6Ko03PrfHJDmPAHPsm4xkkjey3KIAnqc4520ig4PFMbjAn7oop
   rlfLj6CMhpmVbeo03VXJDyCP7fMYhS/ZsLkcWaYARiZqx8i2ExA/jLdvj
   uP9tB+61+KslEQ7BUpRQtx2MnT6nZrwIdCpwWWhLNjoCBdjciozoJ/TPp
   Q==;
X-CSE-ConnectionGUID: +7+7PG/tSh2YjmshzVQG3A==
X-CSE-MsgGUID: m/ZLbLeMTFGFfeAOb962Cw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="33039234"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="33039234"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 19:14:35 -0700
X-CSE-ConnectionGUID: OYsoGVvpSmm4J/dKmoi73w==
X-CSE-MsgGUID: 4SQozAooSfOb95Ff6ZfpAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,227,1725346800"; 
   d="scan'208";a="81277341"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.110.250])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 19:14:35 -0700
Date: Wed, 23 Oct 2024 19:14:32 -0700
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
Message-ID: <ZxmtiOlYNklu4sKr@aschofie-mobl2.lan>
References: <20241018-cxl-pra-v1-0-7f49ba58208b@intel.com>
 <20241018-cxl-pra-v1-3-7f49ba58208b@intel.com>
 <ZxcCnbV8fsSbTeGf@aschofie-mobl2.lan>
 <67193e446b625_d944929428@iweiny-mobl.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67193e446b625_d944929428@iweiny-mobl.notmuch>

On Wed, Oct 23, 2024 at 01:19:48PM -0500, Ira Weiny wrote:
> Alison Schofield wrote:
> > On Fri, Oct 18, 2024 at 02:46:26PM -0500, Ira Weiny wrote:
> > > Now that there is a printf specifier for struct range use it to enhance
> > > the debug output of CDAT data.
> > > 
> > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > > ---
> > >  drivers/cxl/core/cdat.c | 8 ++++----
> > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> > > index ef1621d40f05..438869df241a 100644
> > > --- a/drivers/cxl/core/cdat.c
> > > +++ b/drivers/cxl/core/cdat.c
> > > @@ -247,8 +247,8 @@ static void update_perf_entry(struct device *dev, struct dsmas_entry *dent,
> > >  	dpa_perf->dpa_range = dent->dpa_range;
> > >  	dpa_perf->qos_class = dent->qos_class;
> > >  	dev_dbg(dev,
> > > -		"DSMAS: dpa: %#llx qos: %d read_bw: %d write_bw %d read_lat: %d write_lat: %d\n",
> > > -		dent->dpa_range.start, dpa_perf->qos_class,
> > > +		"DSMAS: dpa: %pra qos: %d read_bw: %d write_bw %d read_lat: %d write_lat: %d\n",
> > > +		&dent->dpa_range, dpa_perf->qos_class,
> > >  		dent->coord[ACCESS_COORDINATE_CPU].read_bandwidth,
> > >  		dent->coord[ACCESS_COORDINATE_CPU].write_bandwidth,
> > >  		dent->coord[ACCESS_COORDINATE_CPU].read_latency,
> > > @@ -279,8 +279,8 @@ static void cxl_memdev_set_qos_class(struct cxl_dev_state *cxlds,
> > >  			 range_contains(&pmem_range, &dent->dpa_range))
> > >  			update_perf_entry(dev, dent, &mds->pmem_perf);
> > >  		else
> > > -			dev_dbg(dev, "no partition for dsmas dpa: %#llx\n",
> > > -				dent->dpa_range.start);
> > > +			dev_dbg(dev, "no partition for dsmas dpa: %pra\n",
> > > +				&dent->dpa_range);
> > >  	}
> > >  }
> > 
> > This is a bit different than what I expected to find as the initial use case
> > because it wasn't printing a range.
> 
> The reason this was chosen was I was adding to this code and found the
> range to be advantageous while doing so.  But the patch was stand alone
> in the original DCD series so could be included here.
> 
> > With this change we go from printing only
> > the .start to printing the range.
> 
> Yes that is why I mentioned that %pra is used ...  "to enhance
> the debug output of CDAT data."
> 
> >
> > Seems the wording of the dev_ message could
> > change too since 'dpa' has been replaced with a 'dpa range'.
> 
> Could be but it made sense to me to read:
> 
> "... dpa [range 0x...-0x...]"
> 
> Because %pra adds 'range'.
> 
> > 
> > There are a few places that print the range now and can be cleaned up w this
> > specifier. Those are the real 'uglies' like this:
> 
> True this is ugly and I would like to clean this up.  But the cdat code
> was being modified and lead me to this particular call site.  But it was
> also stand alone enough to be used here.
> 
> > 
> > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > index 223c273c0cd1..85a121b7b2b5 100644
> > --- a/drivers/cxl/core/hdm.c
> > +++ b/drivers/cxl/core/hdm.c
> > @@ -941,8 +941,8 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
> >                 return rc;
> >         }
> > 
> > -       dev_dbg(&port->dev, "decoder%d.%d: range: %#llx-%#llx iw: %d ig: %d\n",
> > -               port->id, cxld->id, cxld->hpa_range.start, cxld->hpa_range.end,
> > +       dev_dbg(&port->dev, "decoder%d.%d: range: %pra iw: %d ig: %d\n",
> > +               port->id, cxld->id, &cxld->hpa_range,
> >                 cxld->interleave_ways, cxld->interleave_granularity);
> > 
> > 
> > I guess you could (ducks) pick them all up here, or we can leave it
> > for a future cleanup, or we can just say no cleanups and we'll use
> > %pra going forward only.
>  
> I would say we get the specifier in then look at any clean up which works
> for us going forward.  Like in this case where I was editing the code
> anyway.

Thanks for the info. LGTM!

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

> 
> Ira
