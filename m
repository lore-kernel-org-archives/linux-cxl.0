Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741431940A2;
	Mon, 21 Oct 2024 07:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729494481; cv=none; b=Sh3J5PoCRbz5UqNQ6wQ+v1q9n7Yem4JgE9zqEOvJ5o+1z7g2dN0LpAkksX0WBZYakkhxBdicNQqyMY0+cXLItNdTLr6cjkm+HfwXCicuyYQlXY/Oo2DlGz1033crIeVzQcry3DTwS5QqGCgZW9cTXjVIHIDxSOUzfem3T0HX74c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729494481; c=relaxed/simple;
	bh=jgiYG0Ek2ZJK/rdl0cvnO5WUT2lSdDlxtVCEzXGPlM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GTR9E5tLPUNOyYlcdg76F7JiIMtpkHyLb/TKfXjvIDOdyFmOXMo5jGsYAEm6gdwpVCLtLN2Z6/kjLQyRwA7CmH2YeCAPVJVJHk0DiRYBv+mz2pZSRJy321HQ4/qNTblUTEY0pUYYUV98go56UvOgUmSo0T0acF/JLvLNXl7ttHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zqbzj7H9; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zqbzj7H9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729494480; x=1761030480;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jgiYG0Ek2ZJK/rdl0cvnO5WUT2lSdDlxtVCEzXGPlM4=;
  b=Zqbzj7H9jmiLeBxOO1POiwka8dTsXSkpqs3dKp8tIt6BO2uXbIiRfHY9
   ZVQX2znsXohsULOua7yFS/TH8AsRymg4Squ4Y/rki25lKKosaPQqqcV5V
   4Szt8fkyXC7AjQ8dsMKSLAQZ+ltTNmgZOu0ppinENVwf1Q9obaOgz7esH
   Akxx90Y1PbW2U77oupo8VBCKa/QabzBr4FdQsg0XYVi9H2zZu6xNCluAW
   9TMDjf7CR6TdOJe0gD1Kp9Ze1vFUUlyTetCCdbL8HAKf68xqh0AJOT0RM
   yLtKkQlfGni/AD/+WcPQIEYcLy+wcBJX6U57kM29uwYkuP+Zwq0JvFJvr
   g==;
X-CSE-ConnectionGUID: QGQz3Dt1S8GZyVQUZmByZg==
X-CSE-MsgGUID: XBBnkWyUQ4O5lC6FOH7+Yw==
X-IronPort-AV: E=McAfee;i="6700,10204,11231"; a="28398053"
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="28398053"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 00:07:59 -0700
X-CSE-ConnectionGUID: g8ZTj4VQRKGVGBiGDjDB5g==
X-CSE-MsgGUID: S4MppS4yTayb9wJK/YalEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="83433920"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 00:07:55 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t2mW7-00000005P6t-2fsQ;
	Mon, 21 Oct 2024 10:07:51 +0300
Date: Mon, 21 Oct 2024 10:07:51 +0300
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
Subject: Re: [PATCH 2/3] printf: Add print format (%pra) for struct range
Message-ID: <ZxX9x82ME7GRnVl9@smile.fi.intel.com>
References: <20241018-cxl-pra-v1-0-7f49ba58208b@intel.com>
 <20241018-cxl-pra-v1-2-7f49ba58208b@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018-cxl-pra-v1-2-7f49ba58208b@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Oct 18, 2024 at 02:46:25PM -0500, Ira Weiny wrote:
> The use of struct range in the CXL subsystem is growing.  In particular,
> the addition of Dynamic Capacity devices uses struct range in a number
> of places which are reported in debug and error messages.
> 
> To wit requiring the printing of the start/end fields in each print
> became cumbersome.  Dan Williams mentions in [1] that it might be time
> to have a print specifier for struct range similar to struct resource
> 
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

...

>  	case 'R':
>  	case 'r':
> -		return resource_string(buf, end, ptr, spec, fmt);
> +		return resource_and_range(fmt, buf, end, ptr, spec);

Since you are going to have a new version, I think this should be _or_ instead
of _and_.


-- 
With Best Regards,
Andy Shevchenko


