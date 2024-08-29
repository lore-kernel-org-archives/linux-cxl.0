Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0839015AD99
	for <linux-cxl@vger.kernel.org>; Thu, 29 Aug 2024 20:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724964663; cv=none; b=haTvLuyWpuhAbXUxoiIT3GNz+hGloZ/JhsO+jnykOlt1++5seDgr7nKVBYusQpyeBbBq8p+x0v9MOaaAG9opmqMjReVqo6T11LMzjpC1opWRNM/NGZg50231BQUq4gVQ3R024y0IaAnTzThLzVREvIJfnb9A4M6h4frS3+UEy08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724964663; c=relaxed/simple;
	bh=Ow5NqFRDcDk+6bdixlB26PL3yqQo/n74jxgrE1gu/uw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gUJbU6zu7dxIM72ffsGRcgEV/FxmE9/N9/FupMhupFvu18e89WMORmbrWhHq6jeM35CgaprvzVU7UhqH8jeMn5VBDzKQb7zKP9j4In5lll5c0o8qyhe5XGV+03RIExYFC9jTVpvs25ulrNmkVURjp4U0EWTPpC8vtCSYAGTU16s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gPAUhfS7; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gPAUhfS7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724964661; x=1756500661;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ow5NqFRDcDk+6bdixlB26PL3yqQo/n74jxgrE1gu/uw=;
  b=gPAUhfS7TM4k3qxjcgPev9izmWRdSVaWIGI7agvo3XXrbA2dpVxha/l0
   b1dIl7Q9JekAk5lDkXXcnIqJpGaywbSCPtTGf27AUeepDgT4If6LmyMkX
   fWtyR4B+2jdpMdvOaecbP1dDy6CmQ2nFX90zUgkyuDynWLdDhiAdnvGgt
   +6WYgRwwQXPIaxwdojGJh8sIGii9eb36mCG2Inqorr7Ej9/BSFWf3/Y69
   O6rxMh2kB/YJjLZqs4aNvT2/U+G8nWnMCiuUJazHgnYzqL4F8EY28FRSZ
   sI5tJDSNdQeIdXAt7taSLKe3RQHR40e0ulACAi/SKQUI2uPjAO2DoR6E9
   g==;
X-CSE-ConnectionGUID: h5+szsIRSJe4BVGb/bIeJA==
X-CSE-MsgGUID: N+jHt3XFRlamTEV7aJVmnA==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="46099414"
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="46099414"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 13:51:00 -0700
X-CSE-ConnectionGUID: /k2lPFn7QIuxYU1NFBnRqg==
X-CSE-MsgGUID: Anr2gB1gS3CIQWU0F3KH+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="64424566"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.111.219])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 13:51:01 -0700
Date: Thu, 29 Aug 2024 13:50:59 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org
Subject: Re: [ndctl PATCH 2/2] test/daxctl-create.sh: use CXL DAX regions
 instead of efi_fake_mem
Message-ID: <ZtDfM7xTqTjnxNG0@aschofie-mobl2.lan>
References: <cover.1724813664.git.alison.schofield@intel.com>
 <519161e23a43e530dbcffac203ecbbb897aa5342.1724813664.git.alison.schofield@intel.com>
 <66d0a81f531b8_47390294c7@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66d0a81f531b8_47390294c7@dwillia2-xfh.jf.intel.com.notmuch>

On Thu, Aug 29, 2024 at 09:55:59AM -0700, Dan Williams wrote:
> alison.schofield@ wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > This test tries to use DAX regions created from efi_fake_mem devices.
> > A recent kernel change removed efi_fake_mem support causing this test
> > to SKIP because no DAX regions can be found.
> > 
> > Alas, a new source of DAX regions is available: CXL. Use that now.
> > Other than selecting a different region provider, the functionality
> > of the test remains the same.
> 
> CXL looks like a useful replacement.
> 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> >  test/daxctl-create.sh | 18 +++++++-----------
> >  1 file changed, 7 insertions(+), 11 deletions(-)
> > 
> > diff --git a/test/daxctl-create.sh b/test/daxctl-create.sh
> > index d968e7bedd82..1ef70f2ff186 100755
> > --- a/test/daxctl-create.sh
> > +++ b/test/daxctl-create.sh
> > @@ -7,6 +7,9 @@ rc=77
> >  
> >  trap 'cleanup $LINENO' ERR
> >  
> > +modprobe -r cxl_test
> > +modprobe cxl_test
> > +
> >  cleanup()
> >  {
> >  	printf "Error at line %d\n" "$1"
> > @@ -18,18 +21,10 @@ find_testdev()
> >  {
> >  	local rc=77
> >  
> > -	# The hmem driver is needed to change the device mode, only
> > -	# kernels >= v5.6 might have it available. Skip if not.
> > -	if ! modinfo dax_hmem; then
> > -		# check if dax_hmem is builtin
> > -		if [ ! -d "/sys/module/device_hmem" ]; then
> > -			printf "Unable to find hmem module\n"
> > -			exit $rc
> > -		fi
> > -	fi
> > +	# find a victim region provided by cxl_test
> > +	bus="$("$CXL" list -b "$CXL_TEST_BUS" | jq -r '.[] | .bus')"
> > +	region_id="$("$DAXCTL" list -R | jq -r ".[] | select(.path | contains(\"$bus\")) | .id")"
> 
> Might as well skip using cxl-list and instead use the known
> platform device hosting the cxl_test CXL topology: "cxl_acpi.0"
> 
>     region_id="$("$DAXCTL" list -R | jq -r ".[] | select(.path | contains(\"cxl_acpi.0\")) | .id")"

Will do. Thanks for the review!

> 
> ...other than that you can add:
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
