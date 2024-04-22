Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3141B947
	for <linux-cxl@vger.kernel.org>; Mon, 22 Apr 2024 20:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713818638; cv=none; b=Rdody/mH7iGD6YcCRAqpiWoOxlloOFxy+9SEGCHNa8IBZw06ldmzMl4kHAzijNquVxFy2Ds7Y81iq33D+szAvg5zsF5yudV23tsWrrdBshBnEr8mnQd+/zYAKWvQTAxIdNXUlNELImcRmhkvsYEZyShg79b6vmhs2NtlybyvuFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713818638; c=relaxed/simple;
	bh=XbgYvkJaul1roQlzwWWAbdldkDI1YA3VDiolQBABVA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qcXib49s+76gBw5o6PkSbBLAN7XWNYwXTUvvNZdFqW+xNZaKJpahBO/N3PoGq13jwNUQWrRWbU8Fr27lR4z0EzlHYMPrAyvwb6sStz4DB9vlVOtRKfitrT0o3jMOZ8oSGIya7w+flW6awQaqv1Do2l2ZeB2CkFAtN0pnZt5lDWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ctsz3000; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ctsz3000"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713818637; x=1745354637;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XbgYvkJaul1roQlzwWWAbdldkDI1YA3VDiolQBABVA8=;
  b=ctsz30000tmr3c+KN9+7abBg07BkgIgopUDtTgbaatyKpfD8H6SGosjk
   n9yppNOgPVaPu8U1udTdJf8n6ZMG3oGNDVED4HBFutC020cYIJ9nwDRQE
   dnPqPrwh/ESwf5HvAq2fAR9RRY8u+fXxkge8TsRmVLY+vqPDQ7q6eITjd
   ag/aOo+zqbFigWJI/B8Fo4huZ4PMdGBTLrNl5Q/y1yqMjgGx7kmdr+kv9
   sEu6nDzcK+XBcj33ukwzsV2r1I6qiGWL0JntK7XNpC+I8Yox/zVIfYmuy
   9oosz5CEZZ8HLGy+9q5ImbFb9VcL8jAUDoicojaAZbZy/6151MvgmRbGS
   g==;
X-CSE-ConnectionGUID: gBCQFU9TRK+z5urJqLHYIA==
X-CSE-MsgGUID: 7thZ0eseQSmHXg2cEyq+zg==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="20527777"
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="20527777"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 13:43:56 -0700
X-CSE-ConnectionGUID: mYwU6Z1rQ3i0GTrfHyg2tg==
X-CSE-MsgGUID: 4qzfQft3SPeTSBpmfss8dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="55345900"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.73.120])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 13:43:55 -0700
Date: Mon, 22 Apr 2024 13:43:53 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: "Verma, Vishal L" <vishal.l.verma@intel.com>
Cc: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>
Subject: Re: [ndctl PATCH] cxl/test: use max_available_extent in
 cxl-destroy-region
Message-ID: <ZibMCY8G4rDb48Bp@aschofie-mobl2>
References: <20240327184642.2181254-1-alison.schofield@intel.com>
 <7a8214e2f84e333784cf9e7ecd851ccbbb93f3ec.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a8214e2f84e333784cf9e7ecd851ccbbb93f3ec.camel@intel.com>

On Mon, Apr 22, 2024 at 10:07:58AM -0700, Vishal Verma wrote:
> On Wed, 2024-03-27 at 11:46 -0700, alison.schofield@intel.com wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> >
> > Using .size in decoder selection can lead to a set_size failure with
> > these error messages:
> >
> > cxl region: create_region: region8: set_size failed: Numerical result out of range
> >
> > [] cxl_core:alloc_hpa:555: cxl region8: HPA allocation error (-34) for size:0x0000000020000000 in CXL Window 0 [mem 0xf010000000-0xf04fffffff flags 0x200]
> >
> > Use max_available_extent for decoder selection instead.
> >
> > The test overlooked the region creation failure because it used a
> > not 'null' comparison which always succeeds. Use the ! comparator
> > after create-region and for the ramsize check so that the test fails
> > or continues as expected.
> >
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> >  test/cxl-destroy-region.sh | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/test/cxl-destroy-region.sh b/test/cxl-destroy-region.sh
> > index cf0a46d6ba58..167fcc4a7ff9 100644
> > --- a/test/cxl-destroy-region.sh
> > +++ b/test/cxl-destroy-region.sh
> > @@ -22,7 +22,7 @@ check_destroy_ram()
> >       decoder=$2
> >
> >       region="$("$CXL" create-region -d "$decoder" -m "$mem" | jq -r ".region")"
> > -     if [ "$region" == "null" ]; then
> > +     if [[ ! $region ]]; then
> >               err "$LINENO"
> >       fi
> >       "$CXL" enable-region "$region"
> > @@ -38,7 +38,7 @@ check_destroy_devdax()
> >       decoder=$2
> >
> >       region="$("$CXL" create-region -d "$decoder" -m "$mem" | jq -r ".region")"
> > -     if [ "$region" == "null" ]; then
> > +     if [[ ! $region ]]; then
> 
> While these ! $region changes are correct (because cxl create-region)
> doesn't output any json if creation fails)..
> 
> >               err "$LINENO"
> >       fi
> >       "$CXL" enable-region "$region"
> > @@ -55,14 +55,14 @@ check_destroy_devdax()
> >  readarray -t mems < <("$CXL" list -b "$CXL_TEST_BUS" -M | jq -r '.[].memdev')
> >  for mem in "${mems[@]}"; do
> >          ramsize="$("$CXL" list -m "$mem" | jq -r '.[].ram_size')"
> > -        if [[ $ramsize == "null" ]]; then
> > +        if [[ ! $ramsize ]]; then
> 
> .. I think this check needs to check for both empty and "null" - a
> memdev that doesn't have ram_size but otherwise emits valid json will
> result in "null" here. e.g.:
> 
>   $ echo "" | jq -r ".region"
> 
>   $ echo "{ }" | jq -r ".region"
>   null
> 
> So this probably wants to be:
> 
>   if [[ $ramsize == "null" || ! $ram_size ]]; then
>   ...
> 

I see now!  Thanks Vishal.

-- Alison

