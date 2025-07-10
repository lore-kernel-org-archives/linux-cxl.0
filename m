Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007522949ED;
	Thu, 10 Jul 2025 09:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752139008; cv=none; b=DrhUwwWc05N5gCV+8LJiy+xjPGoCcZapOY3duBZJased/z3mdj8SdkgjQ/auF4ueW0dSazGi4ST8TFD/eA/cKMKCnIokhDRiJ22nNBRzapuFuhf5F00lBuwGRRPz8KDaKNfxCcV+2QJcq7bhLXOM/E+67ITZ1+UrIHULiOZqOVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752139008; c=relaxed/simple;
	bh=t+b3LzD3BtJWEEtg/wMiNAbd2/L39v/nsGL6ZPI+0ks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AwDMuuibfrNBOyXZsEApcNKSMO5sYa/cdKn+3MzW+0a35dWYyPWrzNbiWzaUKkc/lt0gj7mhP5LAR/YYMiHE0yzpbiPIit239mpKrJrWrwg0kvEX40AGW9IshSHMB2nh1QvH0UW/M2Q1rUieA5DSw2MectzDXyF2WwB7xVuwSyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M0j5eKH+; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M0j5eKH+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752139008; x=1783675008;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=t+b3LzD3BtJWEEtg/wMiNAbd2/L39v/nsGL6ZPI+0ks=;
  b=M0j5eKH+LiSGjmsVfERAXA8Eq/3/oMTvWLsK3/SopgPSzM+eWwdQeg9b
   TFUyNkFEEsPafFvy7F218+m/j7ycuRg/FMTv88gXH4W1nxTFMRBnC6i/q
   H9gSkZKYWTpTWQ0cpb7/OzhrMI1o94DPh+Z4FiLtqDC7afgNA6v/9Omzf
   oD86Nhyx3ZWvTIfOdllbtg1xOwO8xbNVkJnS85SleMZOuGWlZUqETX4ln
   7BTFuHY7gUHAlvHX1FjwdjiIT+/sZxGtYadDLEywo+4NP2iud0OLV0FkY
   /x/8GLGLFSxX+u6AbRU1PtdhnOumK/ulzj/Fu1OP8pB0KueFvQ58yma8V
   A==;
X-CSE-ConnectionGUID: 0tmqLDuDSS6IBCB4VusTzQ==
X-CSE-MsgGUID: CaV+HBsGQt+nUfUvwS7O4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="65863516"
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="65863516"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 02:16:47 -0700
X-CSE-ConnectionGUID: H97EeAYqSTyuTVqo+amh6w==
X-CSE-MsgGUID: bZcTMtHQRTWEpbBizvH6Lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="156751530"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 02:16:43 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uZnOS-0000000E9ZR-2wf1;
	Thu, 10 Jul 2025 12:16:40 +0300
Date: Thu, 10 Jul 2025 12:16:40 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Li Ming <ming.li@zohomail.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com,
	shiju.jose@huawei.com, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] cxl/core: Introduce a new helper
 cxl_resource_contains_addr()
Message-ID: <aG-E-FgezviXdq3t@smile.fi.intel.com>
References: <20250710065647.98094-1-ming.li@zohomail.com>
 <20250710065647.98094-2-ming.li@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710065647.98094-2-ming.li@zohomail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jul 10, 2025 at 02:56:45PM +0800, Li Ming wrote:
> In CXL subsystem, many functions need to check an address availability
> by checking if the resource range contains the address. Providing a new
> helper function cxl_resource_contains_addr() to check if the resource
> range contains the input address.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks for following my review comments!

-- 
With Best Regards,
Andy Shevchenko


