Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EBF163;
	Wed,  2 Jul 2025 08:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751444205; cv=none; b=n6oYLxFWz8eOOQG3eUNQiEKApJADGdtz/i6/7g8+9ZCN8f+aWAljF8pnmGEwJNwlcygjjhvffYODL4sTRUfboAm1WZu3vz5oguvbTWUCle+Vkh2Y95XVs9/sVcm8kVEO7xlHktraP1k4egL0ybrxojd8XsP/hoOwSqBUhUqkGzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751444205; c=relaxed/simple;
	bh=pHIr2B4eiI4Yhzi7Dv+MEnDUoWmzizo3KmqRlm6oF5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fcyXG5KN5wtuHZ4nN84y23KafELztfSw/iXtZ6gQfrMQSX3TkfEbbR1el89QpU6FhnhBnwNB5ZVJmhAfSVMk/J2sDI+3ayv64Vlm4t+znSOfp/6vFJBwRj1F7oqDuhjIZkYK+GTBHHU5uvtKAszLkjV24lBQmCNQy7IX2kIWzRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TU+tapJh; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TU+tapJh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751444204; x=1782980204;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pHIr2B4eiI4Yhzi7Dv+MEnDUoWmzizo3KmqRlm6oF5g=;
  b=TU+tapJhRlI8f6/bwzLRdBso/sigS+IQ7RtU0tJ7IvPEKZu5++6Qkmo7
   NQn0hno/tsBGyCsrqowPm5P469qMlGNrAa1yRuZ1WMXqFiTluVAWq7hFj
   2etbfeSQvbuLTghe/YNT1Zsh5pFSG8UCzDuyCWcLnEadWScRJ36D9xvEj
   EddO9Re+6FeSkKuL6u0p0v7meFJ4Gg/SXBUJvMJg/y6fV/nqerzGuI/uR
   SRP2nZn2SYog56SGgqtuAQtpUTZX0GbQvyEUPM8NkFw8sUeo9mORyPlBu
   CGS0LDCCGgOpUYa+vlUZ0yTK/4gl/OulHP0RpNOBNcZDKmtn+2wUOu9Wd
   Q==;
X-CSE-ConnectionGUID: w+AlwKzoRRO4/VaT74kIwQ==
X-CSE-MsgGUID: dnipUXUPSvSGce8y6u0e/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="71156181"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="71156181"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 01:16:43 -0700
X-CSE-ConnectionGUID: l11DWTI0SuCyMVNzmR+7rg==
X-CSE-MsgGUID: BIqrAyRTQwCbUEFNzdrmzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="184956749"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 01:16:40 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uWsdw-0000000BrWE-3f8Z;
	Wed, 02 Jul 2025 11:16:36 +0300
Date: Wed, 2 Jul 2025 11:16:36 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Li Ming <ming.li@zohomail.com>
Cc: akpm@linux-foundation.org, bhelgaas@google.com,
	ilpo.jarvinen@linux.intel.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com,
	shiju.jose@huawei.com, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] resource: Introduce a new helper
 resource_contains_addr()
Message-ID: <aGTq5MKCYBO3H9Gg@smile.fi.intel.com>
References: <20250702072008.468371-1-ming.li@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702072008.468371-1-ming.li@zohomail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 02, 2025 at 03:20:06PM +0800, Li Ming wrote:
> In CXL subsystem, many functions need to check an address availability
> by checking if the resource range contains the address. Providing a new
> helper function resource_contains_addr() to check if the resource range
> contains the input address.

resources are about ranges and not addresses. At bare minimum naming sucks
here. Also there is no symmetry with the intersection API. But I would argue
to use resource_contains() and just provide necessary parameter with both
start and end to be set at the same value.

	struct resource r = DEFINE_RES...(addr);

	if (resource_contains, res, &r)
		...do stuff...

-- 
With Best Regards,
Andy Shevchenko


