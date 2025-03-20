Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4FB226173;
	Thu, 20 Mar 2025 18:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742494218; cv=none; b=Hc6BrIlQJoR3QI4a+ExH5fdkIm4lbW579scXS0MuYzDSeDcLjy0RqJ9EjfJIxYTDngYJ8zNF7t5RXnJvNUNFElzKTW4LimKmFHPZhNJthBCccStC7BYvYXxX7f2kX72nrsx6nXhmFueNU7WUVDdckWYPHQSjuRrv8k9QuW8pmx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742494218; c=relaxed/simple;
	bh=0XE5j7HonW3/K6MVLuoFwJDm4LihR8UiKKPgJz8jojE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cDJb0FVH+M6ut8vEfVM2wYQxaB+gAs4QQM8HQ4Jh+Nt1xtKatu4bPdcRAVJJUivMaZpZ20DSZvbOMvfFet2jPDg3olPt5bpt+OLGNOxTeF0wcH6m0WtUoxhHD13PwO8M6z1qCm5/U07knsHuEQEVDnzMOn+H9pBQRSb9aPy1qOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dwGXOK3g; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dwGXOK3g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742494216; x=1774030216;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0XE5j7HonW3/K6MVLuoFwJDm4LihR8UiKKPgJz8jojE=;
  b=dwGXOK3gcpWrYOVFWKM2szn7oC9RcMCH06pWgmbrFo909nZMYxlqSCLD
   y5Wrt62J5vqLuZwLWb93ESyIrdnBEzjD5UlVnN1L+cgVCCfmTyO+AKoPD
   jGvZPCcED6ZLJ+hiuJMtxokP1ZNKHeXbQOnvua//htcywYk2Qrmqa4Ds8
   qFsVfvpdILW2ZdvBU/UMdUFA1IhVQxdqWNcELpatlIwD7orzyDgBCHY3b
   qpiMHo9m0BhzcVCs03T6zpT339X/wZlIZY7E0R/kgm6UjvlC9AAo0/7v0
   6piGVSihchK9GVHj36CtwjYMJcItVnm/5TRW12CwxzwZR15fCIYaBHGSK
   w==;
X-CSE-ConnectionGUID: TSSh0hgoRY2CFvBwQXb3vw==
X-CSE-MsgGUID: N3rFf88MQeiVnAZNQz+tmg==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="46500330"
X-IronPort-AV: E=Sophos;i="6.14,262,1736841600"; 
   d="scan'208";a="46500330"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 11:10:16 -0700
X-CSE-ConnectionGUID: fVkvj2NnRL2pq+E8EAiZ3w==
X-CSE-MsgGUID: zWiqKOAPR46y5A9YzDd3cA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,262,1736841600"; 
   d="scan'208";a="127332722"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.110.121])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 11:10:15 -0700
Date: Thu, 20 Mar 2025 11:10:13 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Robert Richter <rrichter@amd.com>, ming.li@zohomail.com,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 0/4 v3] cxl/core: Enable Region creation on x86 with Low
 Mem Hole
Message-ID: <Z9xaBaM8Mzc8rQ90@aschofie-mobl2.lan>
References: <20250314113708.759808-1-fabio.m.de.francesco@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314113708.759808-1-fabio.m.de.francesco@linux.intel.com>

On Fri, Mar 14, 2025 at 12:36:29PM +0100, Fabio M. De Francesco wrote:
> The CXL Fixed Memory Window Structure (CFMWS) describes zero or more Host
> Physical Address (HPA) windows that are associated with each CXL Host
> Bridge. Each window represents a contiguous HPA that may be interleaved
> with one or more targets (CXL v3.1 - 9.18.1.3).
> 
> The Low Memory Hole (LMH) of x86 is a range of addresses of physical low
> memory to which systems cannot send transactions. On those systems, BIOS
> publishes CFMWS which communicate the active System Physical Address (SPA)
> ranges that map to a subset of the Host Physical Address (HPA) ranges. The
> SPA range trims out the hole, and capacity in the endpoint is lost with no
> SPA to map to CXL HPA in that hole.
> 
> In the early stages of CXL Regions construction and attach on platforms
> with Low Memory Holes, the driver fails and returns an error because it
> expects that the CXL Endpoint Decoder range is a subset of the Root
> Decoder's (SPA >= HPA). On x86 with LMH's, it happens that SPA < HPA.
> 
> Therefore, detect x86 Low Memory Holes, match CXL Root and Endpoint
> Decoders or already made CXL Regions and Decoders to allow the
> construction of new CXL Regions and the attachment of Endpoint Decoders,
> even if SPA < HPA. If needed because of LMH's, adjust the Endpoint Decoder
> range end to match Root Decoder's.

Unless dev_dbg() is on, LMH handling won't be apparent. How about adding
a dev_info() that informs the user that a region was adjusted to account
for a LMH. I'm foreseeing looking at logs and divining a LMH, when a
simple log message would be a nice shortcut.

CXL subsystem is quiet with only 8 dev_info()'s, so if this breaks some
vow of silence, nevermind :)


-snip

> 
