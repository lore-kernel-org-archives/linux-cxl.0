Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABF5A29
	for <linux-cxl@vger.kernel.org>; Mon,  8 Jul 2024 20:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720471430; cv=none; b=JSsyIgrc4+HaUfCH24zwf+dBvJH9VifRVVI9u7dhmvNzMpvnc8AJ2hycD4mu3S1oSPikYRf6zf1vi15Oy3US2ZhJZe5HCDKq207S6F7ae2b+S3BRfkU9tcXWF+qz1nik8dkQUZdkzHqH2NDTRkEmNuORFCxxhU4xaHG4VsQa/WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720471430; c=relaxed/simple;
	bh=oyD3Puw9qz8lM8yjmqqH1jA7et9WYKoo/lI6rS/UdZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s/A4qgpjyrjUVGsCdRWSoylfLMBOImXaFzADO511npYQoOQfpGsLG/1aigvivumaQop/0nPJ7Ng/NvEU8Nn3DlcgtoSm/BPm8qACrg3Gq5DW2k23C6lMZ7NAxxFCZDLDIWYsWqSpIAZcIII15VbCoNv85qxGjKR1pjBjS3Y3v2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eJPrtxx7; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eJPrtxx7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720471429; x=1752007429;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oyD3Puw9qz8lM8yjmqqH1jA7et9WYKoo/lI6rS/UdZQ=;
  b=eJPrtxx7MlrEQwSbiU3AMgauO320+oN/P20HN/cz94IPygZzoeWxeSRE
   pBCDRfm4W4pFZVWPKrzVMkMsHuQRGIhOzo3cwnhrclleI6U/OeOEhx88O
   W8gxueN3fYrd+5OMCac9hq85KHA2hPvkQ8+WwfRKZqJ9SXbeDcnd424Kc
   +02674jJ5FImxHNmBqjJvd9adaF1tLb81OYcCkJaMwGNEU9hc7k3zDOUH
   Hqd3XyqYLS1WpcVptqVN6kzZwUZ30mj6TsZTwbXBtRHSr/2D7XjPh5N3X
   DoM3MG2DkaVWsTRDO/ifFJ9t07dtPkCBWpbQkBKWzZOp//QOtL9DtKODX
   A==;
X-CSE-ConnectionGUID: DAlurQvwQz+CnTyu9/exjA==
X-CSE-MsgGUID: ItKj9NB5T8+7wGpBFmZJMg==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="17331818"
X-IronPort-AV: E=Sophos;i="6.09,193,1716274800"; 
   d="scan'208";a="17331818"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 13:43:48 -0700
X-CSE-ConnectionGUID: F7AEXU99Q66cECo6pOW/0g==
X-CSE-MsgGUID: xHVVG0C9QcWBN8wfoR0Asg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,193,1716274800"; 
   d="scan'208";a="47587800"
Received: from slee81-mobl.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.105.241])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 13:43:47 -0700
Date: Mon, 8 Jul 2024 13:43:45 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org, Adam Manzanares <a.manzanares@samsung.com>,
	dave.jiang@intel.com, Jonathan.Cameron@huawei.com,
	ira.weiny@intel.com
Subject: Re: [PATCH v2] Documentation: CXL Maturity Map
Message-ID: <ZoxPgc1Tzt3bWOmR@aschofie-mobl2>
References: <172005486862.2048248.6668794717827294862.stgit@dwillia2-xfh.jf.intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172005486862.2048248.6668794717827294862.stgit@dwillia2-xfh.jf.intel.com>

On Wed, Jul 03, 2024 at 06:01:35PM -0700, Dan Williams wrote:
> Provide a survey of the work-in-progress maturity (implementation
> status) of various aspects of the CXL subsystem.
> 
> Clarify that in addition to ongoing upkeep relative to specification
> updates, there are some long running themes in the driver that respond
> to the discovery of new corner cases (bugs) and new use cases (feature
> extensions).
> 
> The primary audience is distribution maintainers, but it also serves as
> a guide for kernel developers to understand what aspects of the CXL
> subsystem need more help. It is a landing page to document ongoing
> progress, and a guide to discern exposure to work-in-progress features.
> 
> Reviewed-by: Adam Manzanares <a.manzanares@samsung.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Alison Schofield <alison.schofield@intel.com>
