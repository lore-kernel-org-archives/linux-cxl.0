Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84281DF26A
	for <linux-cxl@vger.kernel.org>; Thu, 17 Oct 2024 15:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729180650; cv=none; b=rEsh9DhB+kV15aMz2MX6aeWTzrdXehjCUkI9c9W2HHVFMSkeeee1DKzpYBfdScwU1Ga+/bwdlw4kn/FFYr6o5ORPLPtnK53vuzG3e7qpXt9fsgVRyJhuMb3rDRh7b8nkhUJ5SRxyl0QWSpZV1ftokmDvh0J4pX1F98Iw/LQwTis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729180650; c=relaxed/simple;
	bh=4VAPn3WRq+YsCLUuVV3qydyX7oiYljVWbatJUVu2hY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HKbCWQB6fAAwMA0bujHYEkPH3d+I6bOaDIuRforEv+1YM1g0FMv0RwcJhSKCv14gUbSH+6lA7eEZUp565J6ir9mBxHai+6VCQdf27YgVr/lpt/aIgaFcCJdHKNJobDP7wa/qxByOlnGZctti8T3MiGe+NNHBKdfsqMiMaeRmEuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jl/QxkVu; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jl/QxkVu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729180646; x=1760716646;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=4VAPn3WRq+YsCLUuVV3qydyX7oiYljVWbatJUVu2hY0=;
  b=jl/QxkVurthIysTMezYdDjaNaSAtp+KmzZ567l8aS/Geq4q8c03D2mqL
   Dtixb0qmTJsfKdde1MK7GFjcIdkNizD6pqtSDdRebom/W1DyJ+at8YyWs
   +BZdTX58bQWe3zBZUjxLsadwOgctgo12fqetd4iDB/sY0mzjETu3IQeJf
   FH5GzQLZRvjvhfXnDuDUgjMti4+kaZ6wnYSOaXY5cdfCIGamUkbCn9DJu
   gsBz3GxNgSmh6toC3tLg5WYUnatWYBfjSoT2tt+5TJkSwgNJbnqwO+Sie
   Eulra3HdGLmU+RATXwfqilBQm42HKEZku8H0WME38CbEIt1M2GSw2fp8c
   w==;
X-CSE-ConnectionGUID: qoWkTzPaT6C0QjOnnUIP7A==
X-CSE-MsgGUID: is8094sER0CsAaqwLFvXLg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="51218774"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="51218774"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 08:57:26 -0700
X-CSE-ConnectionGUID: mGP8n+ZBS06j2arMO3fHTA==
X-CSE-MsgGUID: 137syKEsSCiJoTD2yTbm5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,211,1725346800"; 
   d="scan'208";a="83352394"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.109.53])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 08:57:25 -0700
Date: Thu, 17 Oct 2024 08:57:23 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: "Verma, Vishal L" <vishal.l.verma@intel.com>
Cc: "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [ndctl PATCH v2] test/monitor.sh: Fix 2 bash syntax errors
Message-ID: <ZxEz405SSzBN22AG@aschofie-mobl2.lan>
References: <20241016052042.1138320-1-lizhijian@fujitsu.com>
 <92fec0671d491ce6eecc075233cc0e09ddea52e8.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <92fec0671d491ce6eecc075233cc0e09ddea52e8.camel@intel.com>

On Wed, Oct 16, 2024 at 10:45:48PM +0000, Vishal Verma wrote:
> On Wed, 2024-10-16 at 13:20 +0800, Li Zhijian wrote:
> > $ grep -w line build/meson-logs/testlog.txt
> > test/monitor.sh: line 99: [: too many arguments
> > test/monitor.sh: line 99: [: nmem0: binary operator expected
> > test/monitor.sh: line 149: 40.0: syntax error: invalid arithmetic operator (error token is ".0")
> > 
> > - monitor_dimms could be a string with multiple *spaces*, like: "nmem0 nmem1 nmem2"
> > - inject_value is a float value, like 40.0, which need to be converted to
> >   integer before operation: $((inject_value + 1))
> > 
> > Some features have not been really verified due to these errors
> > 
> > Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> > ---
> > V1:
> >  V1 has a mistake which overts to integer too late.
> >  Move the conversion forward before the operation
> > ---
> >  test/monitor.sh | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/test/monitor.sh b/test/monitor.sh
> > index c5beb2c..7809a7c 100755
> > --- a/test/monitor.sh
> > +++ b/test/monitor.sh
> > @@ -96,7 +96,7 @@ test_filter_region()
> >  	while [ $i -lt $count ]; do
> >  		monitor_region=$($NDCTL list -R -b $smart_supported_bus | jq -r .[$i].dev)
> >  		monitor_dimms=$(get_monitor_dimm "-r $monitor_region")
> > -		[ ! -z $monitor_dimms ] && break
> > +		[ ! -z "$monitor_dimms" ] && break
> 
> [ ! -z "..." ] is a bit of a double negative, while we are changing
> this, I'd suggest cleaning up a bit more such as:
> 
>    if [[ "$monitor_dimms" ]]; then
>    	break
>    fi
> 
> Other than that looks good,
> 
> Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>

BTW - I second Vishal's suggestion here.
Shellcheck is catching bad syntax but may not be suggesting the
best syntax as an alternative. 

--Alison

snip
