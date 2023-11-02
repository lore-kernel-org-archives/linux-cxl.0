Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313542231D
	for <linux-cxl@vger.kernel.org>; Thu,  2 Nov 2023 22:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gKiWRuvW"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56D2138
	for <linux-cxl@vger.kernel.org>; Thu,  2 Nov 2023 15:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698965462; x=1730501462;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HSbu0yJ6sEyxrWkMlwG/CdlIMLfLou0hIS0NLrLqx0E=;
  b=gKiWRuvWOfKWJ3urdSAd0e+dAw0qjVyN+xeA323zcrTaMr6eJ6M0JnhY
   /sQqTGWzhsW3oLCpSj1n3U+tz+o3IhboqGMm5cmi3jiEpqlRjK54Xw5Br
   47JRJHANDjWhEchevo/N8pKJRhCiWxOsBO8WOUdioadu0kd4a6KcbyEla
   zcrpas5gwtgSHSJgoXKZAeblrhbHcAI+8+2Os56UznlO/WAmeccFOj06b
   HxormCfotONYy17cP3ic9gMo48dH0nA0uAJXjArng4X/BwEtyz4iZd8wK
   HfMP7dhuE0rwQHlXyYlw9CyiQ5pMB7RYEsV3gjCPBSuMC8fNPQiyM9PTu
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="387725262"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="387725262"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 15:51:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="878419591"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="878419591"
Received: from sanchitj-mobl.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.94.246])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 15:51:01 -0700
Date: Thu, 2 Nov 2023 15:51:00 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: vishal.l.verma@intel.com, linux-cxl@vger.kernel.org,
	nvdimm@lists.linux.dev, dan.j.williams@intel.com,
	yangx.jy@fujitsu.com
Subject: Re: [NDCTL PATCH v3] cxl/region: Add -f option for disable-region
Message-ID: <ZUQn1BmcmjGbEmlP@aschofie-mobl2>
References: <169878724592.82931.11180459815481606425.stgit@djiang5-mobl3>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169878724592.82931.11180459815481606425.stgit@djiang5-mobl3>

On Tue, Oct 31, 2023 at 02:20:45PM -0700, Dave Jiang wrote:

snip

> +	Attempt to disable-region even though memory cannot be offlined successfully.
> +	Will emit warning that operation will permanently leak phiscal address space
> +	and cannot be recovered until a reboot.

physical

With that,
Reviewed-by: Alison Schofield <alison.schofield@intel.com>

> 
> 
> 
