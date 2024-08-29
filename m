Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753741B2EF1
	for <linux-cxl@vger.kernel.org>; Thu, 29 Aug 2024 15:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724946081; cv=none; b=ZJEz7UMqTiAHfvtlCZJVU6IcqEjQ4zlJ1p+u15Dw66WMaswmq1YRj3Vho2C6TTAdorkjo7AuVHcAEEJnRTX4ZCvQkeqcHy4vGgZmXzs9gPNqzdvldU4E1A67rF1KJWZnFFz9ImRLD7MUB0UasplEW044GPs83T3yhyAJc0PbeM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724946081; c=relaxed/simple;
	bh=sA7SINszmZLjDAezKNHUvN8MIo8AWnJ0wY4YZB21JbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EA/ZFXA61OypqcgOLkUK4IkZupp5x/0X6Sq8WKw5N6A1M2dR+0ib2FSbShM7Mjjy0Z0d7dIim9hQan0cD+FByckmqaWXj0/sMHkQEUSDlYC9AafymD3XLmn9tc66N2Fglgy0FkFxE8TYMss8TioYS+H7f6/+FXVWrorEtuLUksI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CWcqgNOU; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CWcqgNOU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724946080; x=1756482080;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sA7SINszmZLjDAezKNHUvN8MIo8AWnJ0wY4YZB21JbQ=;
  b=CWcqgNOUV9Li2JIDX4qRUD5WBfabKqd1i+MTRR8b5YRWbCf9khhNfG8/
   WQlACsjH+fJ2B8jHv1Fns1QffOX3s4t3Ya8TRfRF6hZovRt2xBVp3xews
   mjLqsiJWLRhVNZs/AW2T4GqY123j2LczrG2xPWh4HN8u6jacX4XBb10mF
   Z+EUFX9xDhV8WkIFWZH1aPiifzsF2OJiVTZb1hPO2alrjnpYJX7VCjAxS
   LdiEPffQyoiI8adYzfcYWWuQS02BK2ffTmEC4Hm5lKkKUPrsbzU3SlCaC
   xVSyynh+fGWrvUH+wXbQAFYuZfKcpEAMcLfOvuR/wFoRKRPUSP9z1B95f
   Q==;
X-CSE-ConnectionGUID: qybHaozJT6KZi2kVv8fjHQ==
X-CSE-MsgGUID: aaSp56fHQIapWyXWhcigVQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="34714713"
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="34714713"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 08:41:18 -0700
X-CSE-ConnectionGUID: 47sogBf/QH+Yo/6lOuf5uQ==
X-CSE-MsgGUID: kfllvFyaRPSatV3w55aplg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="63668569"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.111.219])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 08:41:15 -0700
Date: Thu, 29 Aug 2024 08:41:12 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, alejandro.lucero-palau@amd.com,
	dan.j.williams@intel.com, ira.weiny@intel.com,
	vishal.l.verma@intel.com, Jonathan.Cameron@huawei.com,
	dave@stgolabs.net, fan.ni@samsung.com,
	Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v2 1/2] cxl: Move mailbox related bits to the same context
Message-ID: <ZtCWmAxX8766Blpj@aschofie-mobl2.lan>
References: <20240827215116.536126-1-dave.jiang@intel.com>
 <20240827215116.536126-2-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827215116.536126-2-dave.jiang@intel.com>

On Tue, Aug 27, 2024 at 02:49:49PM -0700, Dave Jiang wrote:
> Create a new 'struct cxl_mailbox' and move all mailbox related bits to
> it. This allows isolation of all CXL mailbox data in order to export
> some of the calls to external callers and avoid exporting of CXL driver
> specific bits such has device states. The allocation of
> 'struct cxl_mailbox' is also split out with cxl_mailbox_create() so the
> mailbox can be created independently.

The reasoning for this mentions 'external callers' yet this new struct
is added to a header file that is still internal to the kernel. It's
now available outside the CXL driver but not externally.

Does it belong in to include/uapi/linux/  and need to be documented
in the driver-api/cxl/ (same as cxl_mem.h)

If it stays internal to include/linux/ note that cxl-event.h 
already exists there w no 'cxl' subdir'. Maybe skip the subdir
addition, or mv cxl-event.h along with.

--Alison

snip

