Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB452561AE;
	Fri, 14 Nov 2025 20:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763151586; cv=none; b=YNqm/Lvo0tsvd2oSKYkeV8yehCcMJ8VpDZ+CYJL+bpB6HPIKi2h796/ReUFtSxyAzJnS7D4bkRuWq2IVmlsk6FJiJD+eIKXYKZgc2XOxTsn8i1qPwwYV4soWB6EthrXNRXiOrSahM1nWpT42NKun+CIFiID9T1XBZnXw8BcWgUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763151586; c=relaxed/simple;
	bh=+Q2eYN2drEHuJXuMrOWlBpgmMcE1o5R44CIeGn/qvdo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sCgmJIIB9JjNIWofyOOVrf8WXUtXPkymHCCBnKkFmS3MsT1jyHyvQ/1JLbIHjcVnMgfCF9jhmWniKQwJxF1FxFHVLoa/CB0cwV4dZSzQfFZgVq1F99qPADXPb/jtBPXTUHeicAzYHj55XFY32cWVb/8bkxuFHIN5Mt6QG2gGmDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dDkROWD3; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dDkROWD3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763151585; x=1794687585;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+Q2eYN2drEHuJXuMrOWlBpgmMcE1o5R44CIeGn/qvdo=;
  b=dDkROWD3CMmcvoOTiNH31ArdhVbkcgz8Tni7Ye91FD8qCq2zG7pj2H0h
   udR/mEvLnn2thm7GDgXIMI//Zwyia1fRWiP+5pC7umBvSPhAcdz8hiFAJ
   +Ip7HbET/F3E6hYRELxxgtzkMZb4AhcYr+Uco8Z3TfdjQF2nmeGWx/2qS
   rBIEY1wRxITYt7eQ8nnxRGxWd5pfgJNNjboXiGpw3W8iURHmAvGFypEb8
   dyOSG7Xbz6uO9GgqesxP787LKoX3iEasnqiaWwmxMbt/QjebbDHY/h96G
   9ing3YaO+Y8ViTP+NcWVNMVfshBX0pkIOcwOkHsMYJ34d147Xq4Gv2Aw8
   g==;
X-CSE-ConnectionGUID: WOXTh/W0T4iK/zHgMl+LsA==
X-CSE-MsgGUID: Ar5RtBWiS0qBmAlWuiqaDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11613"; a="65138077"
X-IronPort-AV: E=Sophos;i="6.19,305,1754982000"; 
   d="scan'208";a="65138077"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2025 12:19:44 -0800
X-CSE-ConnectionGUID: /1w8hn3QQYWtd8duCV51/Q==
X-CSE-MsgGUID: IbdRxjBdTUaOc6XNoZn0yQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,305,1754982000"; 
   d="scan'208";a="189689460"
Received: from vverma7-desk1.amr.corp.intel.com (HELO [10.125.108.188]) ([10.125.108.188])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2025 12:19:43 -0800
Message-ID: <6d7941df-0ace-45df-aeec-fcf62e2cada4@intel.com>
Date: Fri, 14 Nov 2025 13:19:42 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] CXL updates for v6.19
To: Robert Richter <rrichter@amd.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Davidlohr Bueso <dave@stgolabs.net>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gregory Price <gourry@gourry.net>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Terry Bowman <terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>
References: <20251112205105.1271726-1-rrichter@amd.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20251112205105.1271726-1-rrichter@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/12/25 1:51 PM, Robert Richter wrote:
> Sending optional and rather independent patches from v5 of the CXL
> address translation series [1] separately in this series. The patches
> could be applied together with early pick up candidates from the
> address translation series (namely patch #1 to #4 or #5).
> 
> [1] https://patchwork.kernel.org/project/cxl/cover/20251112203143.1269944-1-rrichter@amd.com/
> 
> Robert Richter (3):
>   cxl: Simplify cxl_rd_ops allocation and handling
>   cxl/acpi: Group xor arithmetric setup code in a single block
>   cxl/region: Remove local variable @inc in cxl_port_setup_targets()
> 
>  drivers/cxl/acpi.c        | 15 ++++-----------
>  drivers/cxl/core/region.c | 25 +++++++------------------
>  drivers/cxl/cxl.h         |  2 +-
>  3 files changed, 12 insertions(+), 30 deletions(-)
> 

Series merged to cxl/next
7e71fa6e015e cxl/region: Remove local variable @inc in cxl_port_setup_targets()
c42a4d2ee3b2 cxl/acpi: Group xor arithmetric setup code in a single block
6123133ee90f cxl: Simplify cxl_rd_ops allocation and handling
