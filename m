Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F262DCBF8;
	Tue,  8 Jul 2025 13:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751980815; cv=none; b=MnPSjzn8xarELq8A8ff6QzoiXpxP0oxnCSZJ+7Nto/XTC++skRCWCXPMpP5q8yG3PKdAFrXet3qFjX1eIXNGemoo/1R7PzU0SW9neeLUkd3wkY54qGfW9ub7DMyV6ZNtupg6ATyG6GhKwW1bihqmtiAou3vtBPZ9sjVgsNHQN4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751980815; c=relaxed/simple;
	bh=vQqEALJz1ALwrLeBT9fr9YvvNd5OHwds3iUxLwPNThc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LzIXn8asK/yHL2CSE+hPFxEqcoFSB7hr7Nlc84N8xGGrUhmczMC2hwyxspVBk2bHTZCY9M9UX01nYVZaCSolfg7KzRp36cLo0nXEABaw3QL/mgJKu94sWPYFPQae8NFT6h38zsy+G1MkWZEgGPBb76T10k+WTdmh97LEZRGbx0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UtBZFjQz; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UtBZFjQz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751980813; x=1783516813;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vQqEALJz1ALwrLeBT9fr9YvvNd5OHwds3iUxLwPNThc=;
  b=UtBZFjQzH01e6VyN3kot2R1BhL9oQxI52Km5ImLL2NQybphSD1lNN0Al
   l+KhPSJuNnsXfYRstkLctOebyiiD9Ezalmmc7mxRG2vWCLXFJZE9xm2s2
   DQ3th4Dx0UENIIFmmDrf1LYH2YQ0OT22eggzkYMPVKhXFRp//vyJFOUZg
   jp+U5RXvvXufSpPkIaZYIO0o/yOPpNC6pJBxu/mwcMlZi8O91QIhtLJS2
   B4PLeto7nf27+eQ1XP0EntZR+gytEcOLoMcPODiUkoBYmY/qhJ1h5DeT1
   Vc5IlEdFsZVXk3cZOrR+W9rhGWgYPpBPJeNdT0u0RP881dPAaCTQHkCTQ
   Q==;
X-CSE-ConnectionGUID: dAa17gRCQE++pfhwnHIHXA==
X-CSE-MsgGUID: M9Pz/3StTL65Vss+LgKdiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="71664658"
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; 
   d="scan'208";a="71664658"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 06:20:13 -0700
X-CSE-ConnectionGUID: w92AbOAaRGK0YPLQCWr24w==
X-CSE-MsgGUID: q+MfXUyGR2CgRutqV6vVyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; 
   d="scan'208";a="161047985"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 06:20:10 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uZ8Ex-0000000DZyy-1V46;
	Tue, 08 Jul 2025 16:20:07 +0300
Date: Tue, 8 Jul 2025 16:20:07 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Li Ming <ming.li@zohomail.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com,
	shiju.jose@huawei.com, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] cxl/core: Introduce a new helper
 resource_contains_addr()
Message-ID: <aG0bB2hrIZkq3Uv1@smile.fi.intel.com>
References: <20250708051536.92119-1-ming.li@zohomail.com>
 <20250708051536.92119-2-ming.li@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708051536.92119-2-ming.li@zohomail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jul 08, 2025 at 01:15:34PM +0800, Li Ming wrote:
> In CXL subsystem, many functions need to check an address availability
> by checking if the resource range contains the address. Providing a new
> helper function resource_contains_addr() to check if the resource range
> contains the input address.

...

> +bool resource_contains_addr(const struct resource *res, const resource_size_t addr);

Right, the problem is that it collides with the resource namespace. Please, add a prefix.

bool cxl_resource_contains_addr(const struct resource *res, const resource_size_t addr);

...

> +bool resource_contains_addr(const struct resource *res, const resource_size_t addr)
> +{
> +	if (res->flags & IORESOURCE_MEM)

resource_type() ?

> +		return res->start <= addr && addr <= res->end;
> +
> +	return false;

I still think using DEFINE_RES_MEM() with resource_contains() is a better
approach.

> +}

-- 
With Best Regards,
Andy Shevchenko


