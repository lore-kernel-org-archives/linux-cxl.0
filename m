Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209F22EAE5
	for <linux-cxl@vger.kernel.org>; Fri, 22 Dec 2023 22:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LtO1xCRI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703282604; x=1734818604;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q840XwHwe8cFyPwyYDOb5h1xzeJkrwCJ+Q1c5O3Qd08=;
  b=LtO1xCRIJUg4ffCEbFFAGbjYXqXmICWTegAW6JjlZ6EX1kut4XD2Izhr
   9gOmQIYHSWkLUkmsOFoIxBASUJaJhYIy9MSfw8UFtpY7tH/cTbsnHT2HV
   f/BnxgCqpaOgbK7EqxCOfCWNXKurBaucf/mkWl7Pp4hYAwfqWQ8Vys2ep
   62qoJACbU5xQAM+Rpami/SSY9JkYxpNqFj60ick8d3JA0T8ZiFFYhOlL5
   57bjf++H9hdX8OED4DBpRyIFd5IXSKFQB2Dc3NT8Tbjeqiq/ylOjs8Dmp
   bNFyabu1PvocdMduGWJ36u1AR4eWTox8CbYCcSExPfIbZazh78ocEFC9B
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="14843285"
X-IronPort-AV: E=Sophos;i="6.04,297,1695711600"; 
   d="scan'208";a="14843285"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 14:03:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="867729989"
X-IronPort-AV: E=Sophos;i="6.04,297,1695711600"; 
   d="scan'208";a="867729989"
Received: from jbjohns2-mobl1.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.160.53])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 14:03:23 -0800
Date: Fri, 22 Dec 2023 14:03:20 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: Re: [PATCH] cxl/port: Fix missing target list lock
Message-ID: <ZYYHqFmthxW8Gazu@aschofie-mobl2>
References: <170322553909.110939.1669280651596703652.stgit@dwillia2-xfh.jf.intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170322553909.110939.1669280651596703652.stgit@dwillia2-xfh.jf.intel.com>

On Thu, Dec 21, 2023 at 10:12:19PM -0800, Dan Williams wrote:
> cxl_port_setup_targets() modifies the ->targets[] array of a switch
> decoder. target_list_show() expects to be able to emit a coherent
> snapshot of that array by holding by holding ->target_lock. The
> target_lock is held for write during initialization of the ->targets[]
> array, but it is not held for write during cxl_port_setup_targets().
> 
> The ->target_lock() predates the introduction of @cxl_region_rwsem. That
> semaphore protects changes to host-physical-address (HPA) decode which
> is precisely what writes to a switch decoder's target list affects.
> 
> Replace ->target_lock with @cxl_region_rwsem.
> 
> Now the side-effect of snapshotting a unstable view of a decoder's
> target list is likely benign so the Fixes: tag is presumptive.
> 
> Fixes: 27b3f8d13830 ("cxl/region: Program target lists")
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

