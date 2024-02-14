Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0985C139561
	for <linux-cxl@vger.kernel.org>; Wed, 14 Feb 2024 21:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707947352; cv=none; b=l+j7v4ujFWyI3BBnhDTd21YPQS2K29Sukm2uv7dmifV6vjTWEIODuqpx1Xj7rQXUwS1VSBdXDcyTe2IEbvXf5rB4XLmTDUg1tZk92ydw9YvmbUJFYx7UGUMuLKnktmiRBkFt88heq542QfuXrTR5tWIbVOw007KU62v4s9ej+Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707947352; c=relaxed/simple;
	bh=HmCzQDPafKuoCeTvxTWUi7Y6UVUqFSDXU7PJ2/LmmcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sx7RgiAP2Mc24scEvafEvmkNTsTPZuBX2YSbxZOqsT0Yssvv4/W27r2LrW50PCLDEfSYEZ3sL3HXaISOW1hQsIT1y7rufoMG+I0uBvp+uF2cLTSf+lh1Bl2x6kc81SBX6C23WyL2DypB41MKZWK7DDYncsATQcUcLw2is3wzMNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QKyJegIr; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QKyJegIr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707947351; x=1739483351;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HmCzQDPafKuoCeTvxTWUi7Y6UVUqFSDXU7PJ2/LmmcM=;
  b=QKyJegIrwCHNqUO4gbq0GEq2mxxwGah34Jp7kp8MGIpv4lDwR95pBGl4
   BD5rQGJ6XhCClTf9eE0NxMtm6q+i6rT0Bc2fYxwD6jLOoL7i401mFkAvC
   o8UJ8H3vUgpRJ5cgvsst9/Q+4Osb9JHoQk6+SHFYahXo4OTdVEaPA4LoE
   GwhUqbdQYOLNHyw872keogTz+47qKP/n4Pur7h7Y9vPBrzaLEC/KqLCTR
   1XHe9Ozy8feuoeF5iNU00mXhoqGNMER5ZMFO2TC7EN/84Iygb17QfSCrx
   0wZGeXJAFwr50MElcUIfKnzBemyEfNeFBHpsBkBjtytD6exQutm53CUTr
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="1889311"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="1889311"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 13:49:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="7935697"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.27.144])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 13:49:09 -0800
Date: Wed, 14 Feb 2024 13:49:07 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: "Verma, Vishal L" <vishal.l.verma@intel.com>
Cc: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>
Subject: Re: [ndctl PATCH] cxl/test: Add 3-way HB interleave testcase to
 cxl-xor-region.sh
Message-ID: <Zc01UzUBAKdZdAK9@aschofie-mobl2>
References: <20240214071447.1918988-1-alison.schofield@intel.com>
 <3740aad81564f41c7d4e175682a1881253fc2cd6.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3740aad81564f41c7d4e175682a1881253fc2cd6.camel@intel.com>

On Wed, Feb 14, 2024 at 11:28:45AM -0800, Vishal Verma wrote:
> On Tue, 2024-02-13 at 23:14 -0800, alison.schofield@intel.com wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> >
> > cxl-xor-region.sh includes test cases for 1 & 2 way host bridge
> > interleaves. Add a new test case to exercise the modulo math
> > function the CXL driver uses to find positions in a 3-way host
> > bridge interleave.
> >
> > Skip this test case, don't fail, if the new 3-way XOR decoder
> > is not present in cxl/test.
> >
> > Add the missing check_dmesg helper before exiting this test.
> >
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> >  test/cxl-xor-region.sh | 33 +++++++++++++++++++++++++++++++++
> >  1 file changed, 33 insertions(+)
> >
> > diff --git a/test/cxl-xor-region.sh b/test/cxl-xor-region.sh
> > index 117e7a4bba61..2f3b4aa5208a 100644
> > --- a/test/cxl-xor-region.sh
> > +++ b/test/cxl-xor-region.sh
> > @@ -86,11 +86,44 @@ setup_x4()
> >          memdevs="$mem0 $mem1 $mem2 $mem3"
> >  }
> >
> > +setup_x3()
> > +{
> > +        # find an x3 decoder
> > +        decoder=$($CXL list -b cxl_test -D -d root | jq -r ".[] |
> > +          select(.pmem_capable == true) |
> > +          select(.nr_targets == 3) |
> > +          .decoder")
> 
> Are these lines..
> 
> > +
> > +     if [[ ! $decoder ]]; then
> > +             echo "no x3 decoder found, skipping xor-x3 test"
> > +             return
> > +     fi
> > +
> > +        # Find a memdev for each host-bridge interleave position
> > +        port_dev0=$($CXL list -T -d "$decoder" | jq -r ".[] |
> > +            .targets | .[] | select(.position == 0) | .target")
> > +        port_dev1=$($CXL list -T -d "$decoder" | jq -r ".[] |
> > +            .targets | .[] | select(.position == 1) | .target")
> > +        port_dev2=$($CXL list -T -d "$decoder" | jq -r ".[] |
> > +            .targets | .[] | select(.position == 2) | .target")
> 
> ..and these mis-indented?

Thanks for calling it out. I'll tidy up white space in a new revision.

snip

> 
