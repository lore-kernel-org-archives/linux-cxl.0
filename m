Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0510616A959;
	Wed, 19 Feb 2025 18:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739990333; cv=none; b=NhuMszY+ZMV1expkFyzvmlqB6d+wtp4FF4ufa0bCCG6LJJza/HQnJH/W9NFHx/gIVua5dibqo06mJnRsWjJuFumBgm5K3sc5BHiXNd4D3bx6Z/SVvhjPynoyip9W9BANSjBf89wQQsCOoeDK+6EpBWP29w00badS8b1RZnX/MA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739990333; c=relaxed/simple;
	bh=kAyGgjSGCXLuYKifOkU4LbkISii7MiIKlSZtDiSu6/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ou9DYLUUq/ngPq1uaEIAPyUgccAXzObmF0jWvnVf29IUBplxbIUF/kpBulZh9FDvpngO4baYjfFa8MfJ2MmQE82Wfq28ZIZTjUlNdkZrRKooCK8ei61ibUxL/fQgZRUlSa42RB5z0VqsGokkt7/kjTUqJjLjMScHR74NBidrxKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F7a/4ocE; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F7a/4ocE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739990332; x=1771526332;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kAyGgjSGCXLuYKifOkU4LbkISii7MiIKlSZtDiSu6/c=;
  b=F7a/4ocEfl1PU6dfQ6BF9Hsp6xbpjNOUPk9/3kNtVc35eqL/NjkrgcbD
   d1CXQIxP+12/vKoYg4NTHhw8E6f+v4Gi8r56tN0zuQWcVv1sWm2itKTz0
   DN9RkpImT/ETQO0AmuQpwK8tmXdB2tiP6y8Z5Yw0MFRzhDh+SnHa5MKy5
   rWb0FHeRtaxidX/RSP3G13Pc/Jwhugd0Y1TIaBPFe33501uRGcwLOD8g6
   g4/JwqgZn2KXB6sdudbS2EtdvoUqSzCNbofSGY1AR+8gbE1HWKs+mO004
   GHbSceLIGfuU9PfX0hUU/XHEiKScu6Hq0GJ+ZPZMytLWXHpo8Aq7FYyfT
   A==;
X-CSE-ConnectionGUID: tUQZhUFUTBOCIdVyw42S2w==
X-CSE-MsgGUID: JdjDIRrnQYyA+Jw4gpMWhg==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="40759348"
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="40759348"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 10:38:51 -0800
X-CSE-ConnectionGUID: LVCmznmNQjqLeCUFp47u8Q==
X-CSE-MsgGUID: rhSY53TNRdSCRXs8pq4BBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="145683863"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.110.15])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 09:33:36 -0800
Date: Wed, 19 Feb 2025 09:33:29 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Li Ming <ming.li@zohomail.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/7] cxl/core: Use guard() to replace open-coded
 down_read/write()
Message-ID: <Z7YV6X-ipaQeJrrn@aschofie-mobl2.lan>
References: <20250217144828.30651-1-ming.li@zohomail.com>
 <20250217144828.30651-2-ming.li@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217144828.30651-2-ming.li@zohomail.com>

On Mon, Feb 17, 2025 at 10:48:22PM +0800, Li Ming wrote:
> Some down/up_read() and down/up_write() cases can be replaced by a
> guard() simply to drop explicit unlock invoked. It helps to align coding
> style with current CXL subsystem's.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Li Ming <ming.li@zohomail.com>
> ---

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

snip
