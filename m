Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C41518C929;
	Mon, 28 Oct 2024 09:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730106714; cv=none; b=lBf4fVOnLR2lY1Zf4Gzzu86ubVPmHpO3cobUzQphXiSQG4wc/iTEpSmukhddCoFwtJ3e3IxqtC8mFVCD150H7vyOBKegzlowozNPPDs3Qousy1H5GZrYGJImaeVQht4rFbKaQQO6Aas2d9WqZZGrVS+kIhzADfPK8omcFmz+/8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730106714; c=relaxed/simple;
	bh=aSNzBrjMK2CSsZPLj9iN+PiI2c28Q30O61oZemxAOGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UNfd5k+XL5MpuKMkGZ+qBxb7JoRkbqMDWSKOIdH4BL++Hk/XtsDTEWcTMhoXM8XkUXSkEgB26HqNup4N9albTpg7lsOQsSVzet98cR9wDpq658zYQomtRr1o0nx/XmEMmj1FWX5+C+9JP9YjAMy/SSbtkn1ZU/X8OFEZNtrxm+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b3OgIXQ0; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b3OgIXQ0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730106713; x=1761642713;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aSNzBrjMK2CSsZPLj9iN+PiI2c28Q30O61oZemxAOGI=;
  b=b3OgIXQ08I1kkS+InmQH5SiUGfFnCUOfE+FXZzwxRc1+dBw425mkmOwm
   aqB4YLBuLSsSV+i+i13Zc3bsLd2loMasdQJp6UIgFkNpZ3FrP4tx8iVa5
   2rxb8UbOK+dQEHyR+zfW32W3ZE3rWxfnd+4oQWWIm+7wdDB+e6SjPWNvJ
   rQCab2Z2rZlBUie5rsyBIsi/s2tVrg/0vyL4frTEYI47XEXJrRg6lcCb3
   Cmyco2zsFzLwgiJ9qeZEHiVYzMiuUQNvVWePT/ZZGkBCb7iMcTWoqYVwQ
   WZwVS5EmNclcLuq7olrSipKlUFd7ih1c8KPgyqJ6mmXIK5c0d+hCrzOe1
   g==;
X-CSE-ConnectionGUID: NfgXY+B7SHOLzaefsr5I6g==
X-CSE-MsgGUID: jb6BphvgT9a4PxRT0L2Srw==
X-IronPort-AV: E=McAfee;i="6700,10204,11238"; a="33606844"
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="33606844"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 02:11:52 -0700
X-CSE-ConnectionGUID: fv/Dtd8pRGOZKxiCPoavJA==
X-CSE-MsgGUID: ZktPL6jUQtqjbVWuWQpjeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="86130101"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 02:11:48 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t5Lmq-00000007t7M-3O4T;
	Mon, 28 Oct 2024 11:11:44 +0200
Date: Mon, 28 Oct 2024 11:11:44 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ira Weiny <ira.weiny@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Fan Ni <fan.ni@samsung.com>, Bagas Sanjaya <bagasdotme@gmail.com>,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 3/4] printf: Add print format (%pra) for struct range
Message-ID: <Zx9VUN7PpCf9vD2h@smile.fi.intel.com>
References: <20241025-cxl-pra-v2-0-123a825daba2@intel.com>
 <20241025-cxl-pra-v2-3-123a825daba2@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025-cxl-pra-v2-3-123a825daba2@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Oct 25, 2024 at 07:46:55PM -0500, Ira Weiny wrote:
> The use of struct range in the CXL subsystem is growing.  In particular,
> the addition of Dynamic Capacity devices uses struct range in a number
> of places which are reported in debug and error messages.
> 
> To wit requiring the printing of the start/end fields in each print
> became cumbersome.  Dan Williams mentions in [1] that it might be time
> to have a print specifier for struct range similar to struct resource

Missing period at the end.

> A few alternatives were considered including '%par', '%r', and '%pn'.
> %pra follows that struct range is similar to struct resource (%p[rR])
> but needs to be different.  Based on discussions with Petr and Andy
> '%pra' was chosen.[2]
> 
> Andy also suggested to keep the range prints similar to struct resource
> though combined code.  Add hex_range() to handle printing for both
> pointer types.
> 
> Finally introduce DEFINE_RANGE() as a parallel to DEFINE_RES_*() and use
> it in the tests.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


