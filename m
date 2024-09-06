Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A1A8C0B
	for <linux-cxl@vger.kernel.org>; Fri,  6 Sep 2024 00:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725581875; cv=none; b=cD7dzqkHyYrDeG2jFAgPef1R/6JstYlOCWH8O0xJigHjpA4FZXa13qUxxHzeRjhuIm6yUCPGGYPB7WK7epgsqxikVw9JQCtmbKRqatyAzVh4ZLTBD3H2JdmsQTYQb+1YeRVRfbPGoeCAS3Ign9M5RpzZEI1XzI3nd6aZzpoomZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725581875; c=relaxed/simple;
	bh=Iz04eG2dQyKiKp+KVvju5KPYHyarPVhTq7GkluWIXiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NmFGEDR8wE5eXUoBxeYjzvdEqqbMrJJsz4BOSh1FJfZ1asVq2qUz04D22occilkm9RgB/2x+oeyq/L4ppSL/GVoBmWqSP6dirMsbWXLvpYid71aF/R9022XP8mUu2aWiuwwJTFFNQDiMVM3N9xpJbEaOEinn04+5hwy7CUNarXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g3h86q3n; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g3h86q3n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725581873; x=1757117873;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Iz04eG2dQyKiKp+KVvju5KPYHyarPVhTq7GkluWIXiY=;
  b=g3h86q3nt6BozdPbctnmT1vMweE5q4am0DRvkpGfY/ECXAVgkRxDswmN
   aJgqng6ZHLomt0aYQWD1xzor4dl6Pl1ecaC+DZ7E8o8RKZTVAPbtC3UMI
   acE6Es7Yw2AHFAmt5SXn+7NH82LySikFEIDlyVIDR56gFXRgB6j2IH41w
   j8lb2HGe8oZkFfTsb4RCg4sMlZZf6dKOVm0BWnjUbspGJI0VQhJX9UC02
   C64zWhaU+a3i6tKOT8rpBJxQUKbzUy5JonSbcpVp7DCA6iutnAmdSqq3T
   Usj3eBM+nmkLRjwkj/cOPMEQMzRc9JolLBGqIWzoyYyYWi2uZ1eRGc+VJ
   Q==;
X-CSE-ConnectionGUID: hLiVzrCKR/e1ttjz+l1uTA==
X-CSE-MsgGUID: QaQkiqHYTXGwF96ogbKwkg==
X-IronPort-AV: E=McAfee;i="6700,10204,11186"; a="34907714"
X-IronPort-AV: E=Sophos;i="6.10,206,1719903600"; 
   d="scan'208";a="34907714"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 17:17:53 -0700
X-CSE-ConnectionGUID: xkFcSmncTVqlDd71BkqNug==
X-CSE-MsgGUID: rKn6+EfARbWL/zhJyej1YA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,206,1719903600"; 
   d="scan'208";a="66532380"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.110.91])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 17:17:52 -0700
Date: Thu, 5 Sep 2024 17:17:50 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, alejandro.lucero-palau@amd.com,
	dan.j.williams@intel.com, ira.weiny@intel.com,
	vishal.l.verma@intel.com, Jonathan.Cameron@huawei.com,
	dave@stgolabs.net, fan.ni@samsung.com
Subject: Re: [PATCH v4 1/3] cxl: move cxl headers to new include/cxl/
 directory
Message-ID: <ZtpKLuudU3MHYWFm@aschofie-mobl2.lan>
References: <20240905223711.1990186-1-dave.jiang@intel.com>
 <20240905223711.1990186-2-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905223711.1990186-2-dave.jiang@intel.com>

On Thu, Sep 05, 2024 at 03:35:45PM -0700, Dave Jiang wrote:
> Group all cxl related kernel headers into include/cxl/ directory.


Applied set to rc6 and LGTM!
Reviewed-by: Alison Schofield <alison.schofield@intel.com>

> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v4:
> - Move to 1/3 (Dan)
> - Move to include/cxl/ (Dan)
> ---

snip

> 
