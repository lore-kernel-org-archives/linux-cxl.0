Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9317D198A29;
	Mon, 28 Oct 2024 09:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730106454; cv=none; b=jJMzJsAjM8TwGnUHyfjs/yZlPPDW6SPlssQVSOAKSfVHQWSeHNbjZVHnuIRVsx0m0TdkNKu+LwYY0m3Q6yw355rEc8C9CDabYdOQjWMNesqC/22Da+IRdS6kgiETQzBhdMoCF9e7RFQXa2WZ3Fy08ssyiS69inBhqEb9xaOgjLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730106454; c=relaxed/simple;
	bh=nku+OWXA2N6SdhsHrN73m4Q4sSWfvMWrHNCRuIzVunE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kAzMNVY5YwK1EHAVm8hzXdzqlQbBQ1GW7t7xG38OfZSESfi9KFbvpSAymSja1eh0Te70IooYAmqXunaR6qgol8qHnLOxWaFatgpHwtxfHEpx+Ybe5peZw77tn+GDgCuMpG6ZvMwcbe0UOx7NMxsyDEKUfdE1zh+xApMeHF/uJSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kjcy0Eex; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kjcy0Eex"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730106452; x=1761642452;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nku+OWXA2N6SdhsHrN73m4Q4sSWfvMWrHNCRuIzVunE=;
  b=kjcy0Eex1G8X2Ak2Gy/SiJor4UbIKRD9UlB7ofpFfxaK+oyngrS/XUdc
   cFSEMk+3st/a7FCboHBf7y0ij7Xv4XE7h9NC0xoDhxdPfKUVYK1/oZdkM
   pxkTP9tvSyedJOoBKpp8roBEfb4aAFB6OUe+KD0qJRgYbcLi8BEywBf6z
   ukClNO80ydq4vFLJBGM50xi06I+yyKANowB/P1ecgL1Ox7azfpjk2PaqW
   vFXmjuWTw0Ke8Zdwr3hUD5MjElir2hAH40+EAkiBqrIga/pSlXxBImuWm
   KKPp2/mXs0hUvAjDfdPt3mwA9rfPVXYcp3ghzfXvxXbgkjo4GTFyUsDwy
   w==;
X-CSE-ConnectionGUID: oHyOfj1kTVu8DiGahxjBVQ==
X-CSE-MsgGUID: rOZqyuVGQSyDj8s4PnFKuA==
X-IronPort-AV: E=McAfee;i="6700,10204,11238"; a="40271409"
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="40271409"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 02:07:31 -0700
X-CSE-ConnectionGUID: BNDQPOSWQg22SLv5SRT6kQ==
X-CSE-MsgGUID: 8lek/E2jSwCPRyMoGoS3sQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="112392321"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 02:07:28 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t5Lie-00000007t3A-3DyF;
	Mon, 28 Oct 2024 11:07:24 +0200
Date: Mon, 28 Oct 2024 11:07:24 +0200
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
Subject: Re: [PATCH v2 2/4] Documentation/printf: struct resource add start
 == end special case
Message-ID: <Zx9UTOWUYnN17dp0@smile.fi.intel.com>
References: <20241025-cxl-pra-v2-0-123a825daba2@intel.com>
 <20241025-cxl-pra-v2-2-123a825daba2@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025-cxl-pra-v2-2-123a825daba2@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Oct 25, 2024 at 07:46:54PM -0500, Ira Weiny wrote:
> The code when printing a struct resource will check for start == end and
> only print the start value.
> 
> Document this special case.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


