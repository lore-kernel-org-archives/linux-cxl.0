Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4753CF5E;
	Wed, 22 May 2024 15:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716390488; cv=none; b=GjB8buRxE6HlJRxQnCM4Vp6W5+W+rRE9g5nNfcz8M/Ae1ggfbyFmdme1YppCNTpvT/igLILmkhLpAhyiZUPOd7FLYQGElse3hldIOFxP9XpxeWmz0ajG3pzo0J3Wov7dU1zBT2D1g5upCt6C3TJHQjCbsoDFs77hf/LJvGlqFWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716390488; c=relaxed/simple;
	bh=6IRdBy3FEtebXbSzks+rilS62GNYMlbFebw5/l+vRl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mij528UALMr5N9puwyCRmbZIkwf9jP/Q+k+6EaoqBbiIKb2+qxe/3SBknLvUKhkt53fK5sVnRA1xea9h6WGEKOpg1kUx6oAj6xSWoTGlDM3r9deGcT89Efl3EhAVUN8YC/hYQUKee2c232JVDMX4IaqpcPcyAThzJRXGwumESwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IUBB4+ZW; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IUBB4+ZW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716390487; x=1747926487;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6IRdBy3FEtebXbSzks+rilS62GNYMlbFebw5/l+vRl4=;
  b=IUBB4+ZWUUkyu1gvKppEDBFac3eyP+iwYpV0F1D4mBnGWP97OYBN4dyu
   ix9lzDLcaoNbG5HglHOSMiWeKSRHXToox9jvg3lS3sPKU/lFERCkEJe7t
   ecrFPH/ftFfuDLdn1TIQiMWmefko+81gwfJwsh7/xPRw9PNmEVYDSCbjQ
   ZZZcZWw2C0t0sMtbn+mSMxDW2n6ZHOwYgM/ztmSgPFWxSqTDrSmE1kDI1
   v11jZNHqQdNVdzGJjIoQIygBd4EMie4mSGn1LHPVb93HQzRFVy+7dXg0B
   bhgzSrUsJ8NS2U4hE+Z+2Kc49q9fLXQNYVq3ClEwT0PdvR2fb/bF75B2C
   g==;
X-CSE-ConnectionGUID: p+xX7/wdR1y0+8WtZZVsXw==
X-CSE-MsgGUID: hmJ/5HicRle1dZaFEp8/ww==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="11647743"
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="11647743"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 08:08:07 -0700
X-CSE-ConnectionGUID: 0SSeRQuvTpC/UP3YNlEMWA==
X-CSE-MsgGUID: xeVkXVYZRAeIRpaBlWDSrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="37797831"
Received: from ttiasha-mobl1.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.68.11])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 08:08:07 -0700
Date: Wed, 22 May 2024 08:08:04 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] cxl/events: Use a common struct for DRAM and General
 Media events
Message-ID: <Zk4KVLG7zQfesBAE@aschofie-mobl2>
References: <20240521140750.26035-1-fabio.m.de.francesco@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240521140750.26035-1-fabio.m.de.francesco@linux.intel.com>

On Tue, May 21, 2024 at 04:05:08PM +0200, Fabio M. De Francesco wrote:
> cxl_event_common was an unfortunate naming choice and caused confusion with
> the existing Common Event Record. Furthermore, its fields didn't map all
> the common information between DRAM and General Media Events.
> 
> Remove cxl_event_common and introduce cxl_event_media_hdr to record common
> information between DRAM and General Media events.
> 
> cxl_event_media_hdr, which is embedded in both cxl_event_gen_media and
> cxl_event_dram, leverages the commonalities between the two events to
> simplify their respective handling.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

> ---
> 
