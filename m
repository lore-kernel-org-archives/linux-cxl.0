Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904AD190676;
	Mon, 28 Oct 2024 09:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730106437; cv=none; b=ahJThqo6FgoBtlx+ZSLfreMnhnnJmX6ZA2fuE4O3FH2q5lLbG4q66vgBAk6i47XDh4ZyN5Yd7tbRp2aB9qF0imjdhSuWP1UIIa4Rennms9f5lBn0BN8QK1vQa9cnSewQ5gJYxFhZrVZ+l/znNdBUOYe+N2Tv1iNLyO4lOVQ8nR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730106437; c=relaxed/simple;
	bh=Naxc3y4FABd852aPR9mjcknRF9y0zxHqM+ldzWUuEKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fx0/3+lk7OjjKW61si4xjkl6e+XCNOhtNvrzlW6xX9lj5b8ro8otJG37rJsEfS0lRpi+/SnSo5oikWXJVoOLgYcAbH53xMEXeuyLTI4hSbmIshjPB0CCgtADDCGMG+0jZo5IOKnQ91WX3BPSdyJP46Z8JtL1jYgvGWBpPfu/8dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M7jmgCUm; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M7jmgCUm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730106435; x=1761642435;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Naxc3y4FABd852aPR9mjcknRF9y0zxHqM+ldzWUuEKY=;
  b=M7jmgCUm4pjKs8YQAlYKqwAZIdl+n0JlEbo+XgVYA/LR86LUBKSS0ty2
   1eBrjl9lr1Kg0Fs418KCl6vCyuVLeqD8+G2TzV1UsfiKc9lrARSHW86H1
   VOmTFrVor+QqMeWCB2PL7TJGbZ0+3SwxrTHNFZhSqWNKlRIhXLC+SvTRV
   g3AU5Aa1PGMtZo8KwQY/LspBSccT3EvHAKIBvu9N/bFp7wmeYRNSIsTWl
   8aMA2X5PLlqgUXQHfnQHsl8tbVnWy0hdZYd89Yh7v8Hojckie4fU8jTim
   ve+uM8t/oRq4VFcmRDK4XMaNd5LKEdEHsHtJ41d+uEfKM7vglYhyBltyk
   g==;
X-CSE-ConnectionGUID: Kylu9J3qQNOhD9TwJMqJtQ==
X-CSE-MsgGUID: MNjxQWxxSaGiEHGWLjstkQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11238"; a="40271369"
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="40271369"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 02:07:07 -0700
X-CSE-ConnectionGUID: /HGdaufvQ+aRJ5cWieWNLg==
X-CSE-MsgGUID: U5DGNk2jRdqOpvlW82ydDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="112392227"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 02:07:04 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t5LiG-00000007t2b-2TNh;
	Mon, 28 Oct 2024 11:07:00 +0200
Date: Mon, 28 Oct 2024 11:07:00 +0200
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
Subject: Re: [PATCH v2 1/4] test printf: Add very basic struct resource tests
Message-ID: <Zx9UNA5Ht-RrWFIh@smile.fi.intel.com>
References: <20241025-cxl-pra-v2-0-123a825daba2@intel.com>
 <20241025-cxl-pra-v2-1-123a825daba2@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025-cxl-pra-v2-1-123a825daba2@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Oct 25, 2024 at 07:46:53PM -0500, Ira Weiny wrote:
> The printf tests for struct resource were stubbed out.  struct range
> printing will leverage the struct resource implementation.
> 
> To prevent regression add some basic sanity tests for struct resource.

...

> +	struct resource test_resource = {
> +		.start = 0xc0ffee00,
> +		.end = 0xc0ffee00,
> +		.flags = IORESOURCE_MEM,
> +	};
> +
> +	test("[mem 0xc0ffee00 flags 0x200]",
> +	     "%pr", &test_resource);
> +
> +	test_resource = (struct resource) {
> +		.start = 0xc0ffee,
> +		.end = 0xba5eba11,
> +		.flags = IORESOURCE_MEM,
> +	};
> +	test("[mem 0x00c0ffee-0xba5eba11 flags 0x200]",
> +	     "%pr", &test_resource);
> +
> +	test_resource = (struct resource) {
> +		.start = 0xba5eba11,
> +		.end = 0xc0ffee,
> +		.flags = IORESOURCE_MEM,
> +	};
> +	test("[mem 0xba5eba11-0x00c0ffee flags 0x200]",
> +	     "%pr", &test_resource);
> +
> +	test_resource = (struct resource) {
> +		.start = 0xba5eba11,
> +		.end = 0xba5eca11,
> +		.flags = IORESOURCE_MEM,
> +	};
> +
> +	test("[mem 0xba5eba11-0xba5eca11 flags 0x200]",
> +	     "%pr", &test_resource);
> +
> +	test_resource = (struct resource) {
> +		.start = 0xba11,
> +		.end = 0xca10,
> +		.flags = IORESOURCE_IO |
> +			 IORESOURCE_DISABLED |
> +			 IORESOURCE_UNSET,
> +	};

I know that I have given my tag, but I just realized that you may use
DEFINE_RES_*() macros here.

-- 
With Best Regards,
Andy Shevchenko


