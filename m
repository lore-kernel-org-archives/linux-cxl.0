Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536387443E
	for <linux-cxl@vger.kernel.org>; Wed, 24 Apr 2024 19:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713988679; cv=none; b=mMGWi3sJCRmit9QclCwYXqsEr4crxGWaYrfKNRstjLIPJnENiiwuOvwzuVhxAB1bLqaur6PGsWHXOVlbVQrABWEASV++919ZyXX0MKqyN8PcFj5hVt8pOFAfBgbl0DBSzCP4cCQiknSJpHR81ieVFyekv893Tqdwt8NkeKDAD1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713988679; c=relaxed/simple;
	bh=IKscEVNuZETqQCc3Acbu3UUxXKADq/A26TKtVARswNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ndyYvjQkctitShSotYbjhF/ducXL2yaI15iDsfPamcFjDvh7cvAz3e7y5Ft4+EqJtHiAWz8OTKKvmCpf8lTOCk2scQVb8EUH1xlmaS/c7UST1Az5rZzJhKxPvXs1Xyf0DhzRZM3K+4r0a93+3kCqRD1bG0EsVJTXb9w32BrBoaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UDyDjJ5T; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UDyDjJ5T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713988677; x=1745524677;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IKscEVNuZETqQCc3Acbu3UUxXKADq/A26TKtVARswNs=;
  b=UDyDjJ5Tt0bd+XqtHOhTbJbGMJD4ZEM5sTPOO2CC+HwMxVoDoIyYLouR
   CBa2up5ujyEpjmm/NxOED7ZhR7AV6+q3l9jCUQ1vXR63ms4o4rQb2HpeN
   2/OCTBgIb5fmpfxJT2G5CHpoBGjTEfAS8v+q2FWaKLBs6sAQWtxURnMYK
   0DjGypECKr5WNCrmvmKQ0/+saP9mZls7fdgUZ59KbtHvWsuV0F6sGTfFE
   EJVK1nJsRT+pfi2210gz6d2odImMSZds6TqaaL96pBxWTRO7JFk/szGVt
   S03GMmFfZZsFfAIwvguT1PjN5A7wtYUebmUdP8GMBHdoTPRcRDW2uLAKP
   w==;
X-CSE-ConnectionGUID: Tk31MKnnQ4yRi+A6sJd54Q==
X-CSE-MsgGUID: uhl5sRegTkOil7XTd5vLRw==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="20791523"
X-IronPort-AV: E=Sophos;i="6.07,227,1708416000"; 
   d="scan'208";a="20791523"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 12:57:56 -0700
X-CSE-ConnectionGUID: nLwLIE3zQ8WvqAZCv9R3Hg==
X-CSE-MsgGUID: zK9jth84Ry2XrkI3Cqk7Ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,227,1708416000"; 
   d="scan'208";a="29621966"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.186.94])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 12:57:55 -0700
Date: Wed, 24 Apr 2024 12:57:54 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 4/4] cxl/core: Remove cxlr dependency from cxl_poison
 trace events
Message-ID: <ZilkQnc7++83d74B@aschofie-mobl2>
References: <cover.1713842838.git.alison.schofield@intel.com>
 <9a125b4bbf6556b9dda5727a4fad3e7ab25a1e1a.1713842838.git.alison.schofield@intel.com>
 <66289991202c4_a96f29484@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66289991202c4_a96f29484@dwillia2-mobl3.amr.corp.intel.com.notmuch>

On Tue, Apr 23, 2024 at 10:33:05PM -0700, Dan Williams wrote:
> alison.schofield@ wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > cxl_poison trace events pass a pointer to a struct cxl_region
> > when poison is discovered in a mapped endpoint. This made for
> > easy look up of region name, uuid, and was useful in starting
> > the dpa->hpa translation.
> > 
> > Another set of trace helpers is now available that eliminates
> > the need to pass on that cxlr. (It was passed along a lot!)
> > 
> > In addition to tidying up the cxl_poison calling path, shifting
> > to the new helpers also means all CXL trace events will share
> > the same code in that regard.
> > 
> > Switch from a uuid array to the field_struct type uuid_t to
> > align on one uuid format in all CXL trace events. That is useful
> > when sharing region uuid lookup helpers.
> > 
> > No externally visible naming changes are made to cxl_poison trace
> > events.
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> > ---
> >  drivers/cxl/core/mbox.c   |  5 ++---
> >  drivers/cxl/core/memdev.c |  8 ++++----
> >  drivers/cxl/core/region.c |  8 ++++----
> >  drivers/cxl/core/trace.h  | 27 +++++++++++----------------
> >  drivers/cxl/cxlmem.h      |  3 +--
> >  5 files changed, 22 insertions(+), 29 deletions(-)
> 
> A lot of the thrash here is about removing cxlr as an argument, and per
> the comment on patch3 I think it is cleaner to go the other way and
> always pass it in.

I still think we can mimic what is done for general_media and dram
trace events. ie. lookup the region only if trace_cxl_poison_enabled().
as you suggested in previous patch.

I can see why you call it thrash. I'll counter that with the fact that
it is a fairly easy to read diff, and the fact that removing the passed
along cxlr param, is pretty much 'tested' when it compiles.

-- Alison


