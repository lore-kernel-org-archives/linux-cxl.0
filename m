Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2D125CC6D
	for <linux-cxl@vger.kernel.org>; Wed, 26 Feb 2025 22:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740608353; cv=none; b=pLZzOZnjzJ8Yi7UBfig8I6hFUIIbTY3X8i9xt/kvrM6hh+PcuToZGws5808HeKeg5OY0iaAiP1tBDJl/VvCaWXLpWWuUgl+E0Cdx6bPQ92fLAL0IXyAFaXb/bN3e+BbHAdjAbhzVmmJ4hUpPq8vvILuXB+b1YqbfJGscjRBZa8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740608353; c=relaxed/simple;
	bh=jEOFg8frT8YJYi7OlQkEwTDcm8s14AZi1RF7mROuwHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gsBOli80ewQEEiJe1Nxjkd9+h7WE6R0SXVUOuMMKWmbzQCKTVGelCATGjmsUM5RTHViVLVI2Y/iLoqKWyRrEznkloeC5b679IwYHWKu2TeAs0T+mRkhL5PPQiNWjriL84nApRzMCf8kz16uZbNMLvGzC8qYqTQimroG91a+7Kto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JCb6CjyV; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JCb6CjyV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740608351; x=1772144351;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jEOFg8frT8YJYi7OlQkEwTDcm8s14AZi1RF7mROuwHY=;
  b=JCb6CjyVEvztDcc65/2pUCmvfhwnJ+ow8I0GcYDasz/zAiwyZ0i4o+DB
   5+aoVfOoQ8XTeqUssg8CMVOkSxuLWahMGazeU1/zF0cqlOTqQFaghlxVi
   fD6u7mitQI+jsKwwDAF8z2H2JIkcfLkNik2AlTGmNzW86BmY+9bzhpyXF
   ZUB5ZIk8H3tak6G7F3XZelnGSdkJiRMmgDSzKJN0oxg9utHv7lQDIwK+L
   XNrLp0FxzTnB/ctwdzAo7THeJskFD0jYGJEtOME8DjjTAOZNpdaS/Aots
   u1H+mQ+V0U0Z+p4RU0pe0gWo8lW8BIxKdo44SLo1TkrWhoAKFalhdmmeX
   g==;
X-CSE-ConnectionGUID: f5fTdfvFTT2AggwuuiMgsw==
X-CSE-MsgGUID: qzcL9vbASwighlwlNRzxog==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="52893856"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="52893856"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 14:19:09 -0800
X-CSE-ConnectionGUID: DSI7+0FJSDuoM8abZ7PnzQ==
X-CSE-MsgGUID: oIamJs8iRRSDCBy4gdf9bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="120956361"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.108.13])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 14:19:09 -0800
Date: Wed, 26 Feb 2025 14:19:07 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Ira Weiny <ira.weiny@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH] cxl/test: Define a CFMWS capable of a 3 way HB interleave
Message-ID: <Z7-TWwA6q6fBoJIB@aschofie-mobl2.lan>
References: <20250224235032.2259058-1-alison.schofield@intel.com>
 <67bf7a8a66180_5bbaf29425@iweiny-mobl.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67bf7a8a66180_5bbaf29425@iweiny-mobl.notmuch>

On Wed, Feb 26, 2025 at 02:33:14PM -0600, Ira Weiny wrote:
> alison.schofield@ wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > The CXL unit test cxl-xor-region.sh is skipping a 1+1+1 region
> > interleave test case because the window is not defined.
> > 
> > Additionally, upcoming expansion of 3 way HB interleave test cases
> > (like 2+2+2) require the same window.
> > 
> > Replace an unused CFMWS with a 3-way capable CFMWS in the set of
> > CFMWS's loaded when interleave_arithmetic=1.
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> >  tools/testing/cxl/test/cxl.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> > index 083a66a52731..e5cd874614d2 100644
> > --- a/tools/testing/cxl/test/cxl.c
> > +++ b/tools/testing/cxl/test/cxl.c
> > @@ -331,14 +331,14 @@ static struct {
> >  				.length = sizeof(mock_cedt.cfmws8),
> >  			},
> >  			.interleave_arithmetic = ACPI_CEDT_CFMWS_ARITHMETIC_XOR,
> > -			.interleave_ways = 2,
> > -			.granularity = 0,
> > +			.interleave_ways = 8,
> > +			.granularity = 1,
> >  			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
> >  					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
> >  			.qtg_id = FAKE_QTG_ID,
> > -			.window_size = SZ_256M * 16UL,
> > +			.window_size = SZ_512M * 6UL,
> >  		},
> > -		.target = { 0, 1, 0, 1, },
> > +		.target = { 0, 1, 2, },
> 
> Minor nit:
Not a nit. Thanks, revving!

> 
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> 
> Should this also include:
> 
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index cc8948f49117..f0b5b7b8d1d0 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -155,7 +155,7 @@ static struct {
>         } cfmws7;
>         struct {
>                 struct acpi_cedt_cfmws cfmws;
> -               u32 target[4];
> +               u32 target[3];
>         } cfmws8;
>         struct {
>                 struct acpi_cedt_cxims cxims;
