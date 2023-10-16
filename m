Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93D11C14
	for <linux-cxl@vger.kernel.org>; Mon, 16 Oct 2023 05:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GapP2adF"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FFA7E6
	for <linux-cxl@vger.kernel.org>; Sun, 15 Oct 2023 22:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697433601; x=1728969601;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2Fd/fgQDDuASk0lwiI8llWSVzO+2rXNtrX9AvjSDAuQ=;
  b=GapP2adFF445duP0AKeHgobAqzNqJsLOm3vGb+tL1hbtn5nckqqs23GG
   5kYjI0A+s80Y32Dg6O6E9ZEYGkNGbhJzl31neSqRfffxJou1/QZc5Kziw
   V5vFJb5fz3PpkX25zHAT1MXTnCSIa5nOZiSw9bBhVcQS+BKvaP03nI3cG
   Xp0CFQAQF0dQRMaDznIMjDLuxrhJaFLv9LGn5bE7j3uw3y45r1d4Mcemh
   cB1BH2TDkDvBFQVIANHl4nrPW2OsEWnUUUTH+epa8OMNYYto3Ng0zfe/E
   7K7JmZYJXyiO4OnsUvFlyQJz0hd8SdTa8CkmQN97/g2FfSggv6+V8F6fN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="384324014"
X-IronPort-AV: E=Sophos;i="6.03,228,1694761200"; 
   d="scan'208";a="384324014"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2023 22:20:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="846262576"
X-IronPort-AV: E=Sophos;i="6.03,228,1694761200"; 
   d="scan'208";a="846262576"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.62.161])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2023 22:20:00 -0700
Date: Sun, 15 Oct 2023 22:19:58 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
	Dmytro Adamenko <dmytro.adamenko@intel.com>
Subject: Re: [PATCH 2/3] cxl/region: Calculate a target position in a region
 interleave
Message-ID: <ZSzH/h/RtEbkoMnN@aschofie-mobl2>
References: <cover.1696550786.git.alison.schofield@intel.com>
 <5a7133e0ab7eb11f96daa73d88ec765f3536634a.1696550786.git.alison.schofield@intel.com>
 <ea3c2989-2fb9-4b0d-b696-a7fe737b5bed@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea3c2989-2fb9-4b0d-b696-a7fe737b5bed@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 12, 2023 at 04:49:15PM -0700, Dave Jiang wrote:
> 

Thanks for the review Dave -
I took all the commit msg updates w one exception noted below.

> 
> On 10/5/23 17:43, alison.schofield@intel.com wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > Introduce a calculation that determines a targets position in a region
> > interleave. Perform a selftest of the calculation on user-defined
> > regions.
> > 
> > The region driver users the kernel sort() function to put region
> 
> s/users/uses/
> 
> > targets in relative order. Positions are assigned based on each
> > targets index in that sorted list. That relative sort doesn't
> 
> s/targets/target/

"targets" was wrong because it is the plural noun, but I actually
want the possessive noun "target's", not the singular "target".

> 
> > consider the offset of a port into its parent port causing some
> 
> s/causing/which causes/
> 
> > autodiscovered regions to fail creation. In one failure case,
> 
> s/autodiscovered/auto-discovered/
> 
> > a 2 + 2 config (2 host bridges each with 2 endpoints), the sort
> > put all targets of one port ahead of another port, when they were
> 
> s/put/puts/
> s/targets/the targets/
> comma not needed
> 
> > expected to be interleaved.
> > 
> > In preparation for repairing the autodiscovery region assembly,
> 
> s/autodiscovery/auto-discovery/
> 
> > introduce a new method for discovering a target position in the
> > region interleave.
> > 
> > cxl_interleave_pos() offers a method to determine a targets position
> > by ascending from an endpoint to a root decoder. The calculation starts
> > with the endpoints local position and its position in its parents port.
> > Traversing towards the root decoder and examining position and ways,
> > allows the position to be refined all the way to the root decoder.
> 
> Please consider:
> It transverses towards the root decoder and examines both position and ways in order to allow the position to be refined all the way to the root decoder.
> 
> > 
> > This calculation, applied iteratively, yields the correct position:

..skip..


> > +
> > +	/* Exercise position calculator on user-defined regions */
> > +	for (int i = 0; i < p->nr_targets; i++) {
> > +		struct cxl_endpoint_decoder *cxled = p->targets[i];
> > +		int test_pos;
> > +
> > +		test_pos = calc_interleave_pos(cxled, p->interleave_ways);
> > +		dev_dbg(&cxled->cxld.dev,
> > +			"Interleave calc match %s test_pos:%d cxled->pos:%d\n",
> > +			(test_pos == cxled->pos) ? "Success" : "Fail",
> > +			test_pos, cxled->pos);
> 
> Mismatch from selftest does not cause error?

So I'm doing something weird here and am looking for input on how and
where this check might be inserted, if at all. Here I have inserted
the check at the end of the successful creation of a user-defined region. 
This tells us if the driver would have been able to create the same
region in the auto-discovery path. So for the region created at this
moment, everything is fine.

This is how I've been testing the various interleave flavors of
auto-discovered regions for this patchset. I create the regions as a
user and check that the new calculation finds the interleave positions.

I am imagining a less than finite set of interleave configs and thinking
this may give early warning to configs where the interleave calc fails.

I'm going to post a v2 without any change here and we can continue
this discussion in v2.

Alison

> 
> > +	}
> > +
> >  	return 0;
> >  
> >  err_decrement:
