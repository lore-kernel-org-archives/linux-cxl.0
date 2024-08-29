Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCF7189F5A
	for <linux-cxl@vger.kernel.org>; Thu, 29 Aug 2024 22:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724968850; cv=none; b=iMVBezCTsPieNA9MzLkkPw6JKGtHuElYeKE8CP6j45VYByqt21SBFczMFrIPXGvLlVzV2pSgB/cQXce1uDVkLi38VIZv6cYWZywhvLXT8MhgtdfjjuleFGL3OGm3d4JooDkAXdJl2NdQnCkEjhzFZwoKI52jE/SJFJ5wMypoeno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724968850; c=relaxed/simple;
	bh=FPK6qBwYEaNDH8GRDWeSLsGLQvMHNi/U3ZSxTs8nIPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gK/TfTR6nOk5NY7brXCPP6FYE+yaznFZTGKAc4jRgDj0zdDatm312u2vkhmSzc/jXPB75BjP0oqahRtYPmcDjKq9pQqeDPerQMQ57ToYUEQ4nbPsh9rbod4kKZcty4Hoa2z/GmYXs2GqTcZN64l1ea/l4T3ceOHTfCHtk3bhk2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kGmPLcZu; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kGmPLcZu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724968849; x=1756504849;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FPK6qBwYEaNDH8GRDWeSLsGLQvMHNi/U3ZSxTs8nIPQ=;
  b=kGmPLcZuVn8uQJHQ3u0xUS6ZVYcwYfEHGIQaGojyIRKXwZMiCrwY37dl
   mjeb9NiVqI1Bp0E8ix2VHkCvj5JNrCw450B3on2hLsS5A1xSFExnQXGkE
   4DtVfgrS/qe38cQoARjTU5uQ/s75z5PxSnkg/mMVCdkHQeA+UkiaW9di9
   N2sispXAQd83TfBoUCH6S+byd7jHU50kL63KXuc7sv/nTvW83C3aTGHiU
   dqTbuGHdoir0D+Ye5aAjZx+ykdzCB2+FCVsQYPFIW6VENFrNAoHLY/i+U
   ig1wY/3ZR+7ev88QtaRQq6YJBCH9ZwohjZCk6iLNJNBEsPwjLsHbDh7B7
   A==;
X-CSE-ConnectionGUID: 1vkQTFR3RK+Be4LKoHVR9g==
X-CSE-MsgGUID: rDMQw7dgQBSCrCiGbt5r4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="23723511"
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="23723511"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 15:00:48 -0700
X-CSE-ConnectionGUID: CHMvqSoBSFGPhQhMhbCQBg==
X-CSE-MsgGUID: 3jra/1BsR3SPPs25pYr4Og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="63892402"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.111.219])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 15:00:47 -0700
Date: Thu, 29 Aug 2024 15:00:44 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Yanfei Xu <yanfei.xu@intel.com>
Cc: linux-cxl@vger.kernel.org, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, ming4.li@intel.com
Subject: Re: [v4 4/4] cxl/pci: simplify the check of mem_enabled in
 cxl_hdm_decode_init()
Message-ID: <ZtDvjDGuBeqHnuip@aschofie-mobl2.lan>
References: <20240828084231.1378789-1-yanfei.xu@intel.com>
 <20240828084231.1378789-5-yanfei.xu@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828084231.1378789-5-yanfei.xu@intel.com>

On Wed, Aug 28, 2024 at 04:42:31PM +0800, Yanfei Xu wrote:
> Cases can be divided into two categories which are DVSEC range enabled and
> not enabled when HDM decoders exist but is not enabled. To avoid checking
> info->mem_enabled, which indicates the enablement of DVSEC range, every
> time, we can check !info->mem_enabled once in advance. This simplification
> can make the code clearer.
> 
> No functional change intended.

Maybe s/simplify/Simplify in commit message upon applying.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Yanfei Xu <yanfei.xu@intel.com>
> ---

snip

