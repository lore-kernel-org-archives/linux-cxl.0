Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63FF231852;
	Wed,  2 Jul 2025 08:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751444504; cv=none; b=BQnbP7XoRaS8Ft/qtBVdgGvuYlH77xSjJCa1Bu40HP7/2p5lqCpVIXxhFA54Tm0uwQgUumIIBkAKGq0yP3mb4aWo3Cep1yZVNmVcl6BNk5harmX+iNd1sQga2xYnJwIK6ilTkquP9eM7ADHkTrirWhZRXzRaCgp44JNbN6dFMQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751444504; c=relaxed/simple;
	bh=+up810cHE9O+T7UKyrUkxpgdfcii2TChtsm/XaXQ/2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J/H80HSFIrOur3B5jg1EQBT3+zsY/Dg1qtm5ZBlcoC+2RPqeTYoWfXID0TysYno5851xX9Y63wSjbIYeZ0FZ0/Bg7nyFO/AgZM+8NpVLN3AFiw/Uhiryd91y9DvyaepzGjK2VPmBzXo9r2QOdKfieTm9EElhx8O4qu1RtJyv5Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ie8e1bm5; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ie8e1bm5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751444503; x=1782980503;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+up810cHE9O+T7UKyrUkxpgdfcii2TChtsm/XaXQ/2E=;
  b=Ie8e1bm5HSPamVuwBUGLRzwInopK88QSl8P+xWQsN6XqZYnVjgglDWZF
   Jo3QHKqzWZOUq13PtFSnUkHzdJnrzS5Ljvi75hWaojus3oH9c0TnZ6K4I
   U2qSTwlidmSPIRYvcubMeN+XJx/fjSacSm6vRWaBcTosUhFno1PYvc13g
   ZkihYnciog6/45xv0XtM+35CZi78bfBJ8yRYleZqhM2E7QqlmvApJXWgN
   XrJek1wxD/RfiyHdlm9h9w1+tcsJcXeHlbaNOwGuXHUgXkmo9NOJNDxh4
   6uCADIhVNwNv32B5YDHzH5jtv8rIsBFcX1PprZlqc6mFlZIYki5tph49M
   Q==;
X-CSE-ConnectionGUID: BmJmrnb4T+acy1rGSlQIJA==
X-CSE-MsgGUID: rzL7It5TSXee7QFDEsk2uA==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="53822169"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="53822169"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 01:21:42 -0700
X-CSE-ConnectionGUID: d5S1VWadS3qnCedrAz87HA==
X-CSE-MsgGUID: TppCem06RHy+cCVDEtNwjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="159526233"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 01:21:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uWsil-0000000Brcv-3NYe;
	Wed, 02 Jul 2025 11:21:35 +0300
Date: Wed, 2 Jul 2025 11:21:35 +0300
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
Message-ID: <aGTsD4uFyvavYLnO@smile.fi.intel.com>
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

Hint: Use cover letter when you submit more than one patch. It will help a lot
in understanding what's going on. For example, I have a script [1] to submit
patches which makes me sure not to avoid that. Or you can try `b4 relay`...

[1]: https://github.com/andy-shev/home-bin-tools/blob/master/ge2maintainer.sh

-- 
With Best Regards,
Andy Shevchenko


