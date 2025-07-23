Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBE21F1909
	for <linux-cxl@vger.kernel.org>; Wed, 23 Jul 2025 22:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753308868; cv=none; b=nr/GtURD3CEEqjLRMxerWEypadYPoK6gtw6g1TC5XxpdtbE5GtU+lTHCU7vfiJ05bhdYgH471yktC9U8FnkyAPLmDup0uD1EiGMU2wBE12/GrAY9KelExdXf73E9CRRROkUMmQfk6Yjf8896mc/5Hk5t5tRPP7X1YaLraBO97q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753308868; c=relaxed/simple;
	bh=tqblKCBDsP5FDhqPJzbpLrE8Xw6IZohgY0D1iptzamc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RXutVY067wOr0A9kSIUYueiKb7kLyh33SqujUYg9+8qZl3m2jUokoDCjl/UASaYAp7evCcTU6jGg9qFdXOnq3Cq0LClPiq1QLfDITT6VqEaNv2Pb3DuLqUyF/LyxgCrW+ddrbLkE+NPWO8q4zH18e70jhE9Cgmw4NvJVK9txcmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HF9ZIg/r; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HF9ZIg/r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753308867; x=1784844867;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tqblKCBDsP5FDhqPJzbpLrE8Xw6IZohgY0D1iptzamc=;
  b=HF9ZIg/rhH3z5Fh9ACoRifURv7CswKhBlxvBp7Wz0FsqrbZf8+WrZyjJ
   jVJTgmcHCBaFaPS/GMSIHpzg86bZ4MxIGrQG/GvQ7JZQveaQSmeVs4l+a
   QhUWkIlCikbP1CUrhsPxXLq24qIrOXkc8RrN1PnKSDi+ldv37rOBjgY6F
   ODrSgc//aRhFnalSYeR0uxgMskwV0Ty+L/DhWWtdAsy5xo5eyELslz+jP
   Lqaw50N2lAoNEgXJlGF8/rw4dUJI38tHYNISsfuALCYyrQheCJfd7k1oL
   URNLA+FCuLn6Mpq+e82fwNOTa14Jp/amnvD92eupNY2GOYzHxsP4aGfom
   w==;
X-CSE-ConnectionGUID: Ee7WetMoQ6uChh2FvO5HoA==
X-CSE-MsgGUID: BGyh/LC1R4KA1ehXxwsxSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="59409974"
X-IronPort-AV: E=Sophos;i="6.16,335,1744095600"; 
   d="scan'208";a="59409974"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 15:14:27 -0700
X-CSE-ConnectionGUID: /w7qZDHTSuagNtFyb6pbpQ==
X-CSE-MsgGUID: UWzZXhsORRO05TwxNNe3iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,335,1744095600"; 
   d="scan'208";a="160492161"
Received: from dustinle-mobl1.gar.corp.intel.com (HELO [10.247.118.179]) ([10.247.118.179])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 15:14:21 -0700
Message-ID: <d84c5b2a-5160-40a6-8cf9-066aeceda5a2@intel.com>
Date: Wed, 23 Jul 2025 15:14:15 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cxl: Remove ifdef blocks of CONFIG_PCIEAER_CXL from
 core/pci.c
To: dan.j.williams@intel.com, "Bowman, Terry" <terry.bowman@amd.com>,
 linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 Robert Richter <rrichter@amd.com>
References: <20250721170415.285961-1-dave.jiang@intel.com>
 <12646336-9be3-4bc2-adf9-bfd59c589251@amd.com>
 <f1ddcc99-56d1-4887-ad91-714d59b9e9a3@intel.com>
 <400534e9-7763-4364-afb3-5ab9d11cde1c@amd.com>
 <baea9af7-d76e-4d17-9a7d-2363d4f6626b@intel.com>
 <68812fc03518d_14c35610053@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <68812fc03518d_14c35610053@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/23/25 11:53 AM, dan.j.williams@intel.com wrote:
> Dave Jiang wrote:
> [..]
>>> I don't think we want to combine the os-first and fw-first code in a
>>> single file. The separation leveraging the Makefile conditional
>>> compile is good because fw-first doesn't use PCIEAER_CXL while
>>> os-first does.  I think core/ras.c is good as-is.
>>>
>>> cxl_aer.c is in the drivers/pci/pcie directory and is logically part
>>> of the AER service driver. This file includes the kfifo and logic
>>> for offloading CXL RAS errors to the CXL driver. I think the
>>> cxl_aer.c naming is fine but understand it could be argued to use
>>> cxl_ras.c instead. My concern was in the CXL driver AER-RAS naming
>>> but the same rules could be applied here as well. 
>>>
>>> To improve the original situation mentioned I recommend we use 'ras'
>>> in what is named pci_aer.c here?  Maybe 'pci_ras.c' instead? It's
>>> not perfect but would be more precise. This feels somewhat nitpicky
>>> on my part and will not be an issue if we leave as-is. Thanks for
>>> considering.
>>
>> Thanks for the detailed explanation. I'll rename it to pci_ras.c.
> 
> Hey guys, please trim your responses.
> 
> Between RAS, AER, and EDAC there is significant overlap. You could say
> that pci_ras.c is also misnamed because the error details being reported
> are CXL not PCI. I am ok with "RAS" for anything that handles decorating
> an AER notification with extra information, and "EDAC" for all the other
> error notification / reporting / and management flows that handled
> separately from AER.

I wonder if we should rename ras.c to cper.c and move the new code to ras.c.... or cxl_ras.c.

