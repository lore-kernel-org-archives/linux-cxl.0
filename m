Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838F82E62AC
	for <linux-cxl@vger.kernel.org>; Thu,  5 Feb 2026 21:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770326927; cv=none; b=Z+qgj5mA4dk/5CRmAEd8HNc+Ddv1kbyF34pENCL5v+Ez5jvVj+tdcNosrT8LHgGPXSdohUY2i5Z21wbAzaQKSnHumBW9/Xhkaei9C3RyIUHhm0uqsQT9gas5exDfDV4k7YHCAmjNh2gQ+gxeAmysDFup07PLi10I60OYYvmgyrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770326927; c=relaxed/simple;
	bh=WIOV4tNodZ9sBRjSy86kC2EUw8fDSJdPTa0L87exgHk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Xgt8atWR6XGKu5vEev99wyrjOQol+BJdBoUEymQKueTDv7a4h4LNDeF84y0qRTqposMEBMtRYMHdhlBbN69bFbWgWiIFK7UScmLBpHY2fXRMI1jGow1zXHQDpoj85v/7khZEP5aut966CGDXT6BKsk+VzBXKqImmZ568q2R25oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iU0/7Wrd; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iU0/7Wrd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770326928; x=1801862928;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=WIOV4tNodZ9sBRjSy86kC2EUw8fDSJdPTa0L87exgHk=;
  b=iU0/7WrdzDTEIDCeMnTLHjJ7hUCcaqMSx7Mw8DVAdUnKo+3sv9Sz2lap
   PzpDhDgEUIk5y4C4kCR5j4qQbd+vyHrUmtUZwMtTFtoS6Ta2fVB7t1sfe
   mnLTKKZTMCAZqNnbnbASLwfG69SJcNreLwEODk46HFvZzxFKJx4A4FFJX
   Ju4wL2Y/TxACn/XysgNrH33yP5xrE+wLWP/H/ItjjEr0bFP5y/IaV4xvI
   V9IRFkkSVmShygyP8lg8Lyu0Dv4wtXV96bPGS4PIoXicBFf9t+wEki4Hv
   HkZDe6T/lpR7BeohD9PzqtszuUGapYkev444BGrll9k+BEQvnCimik/sG
   Q==;
X-CSE-ConnectionGUID: tyMAKJiYT7yaRgDSu/2Ymg==
X-CSE-MsgGUID: Fm4SxTPIRXCzggk9IT1AEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11692"; a="70731839"
X-IronPort-AV: E=Sophos;i="6.21,275,1763452800"; 
   d="scan'208";a="70731839"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 13:28:47 -0800
X-CSE-ConnectionGUID: 7/d6YiWiRFeINW9DO/bkqw==
X-CSE-MsgGUID: B2Qw5txrT7u6ic0vcEtG3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,275,1763452800"; 
   d="scan'208";a="215203183"
Received: from tfalcon-desk.amr.corp.intel.com (HELO [10.125.111.97]) ([10.125.111.97])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 13:28:46 -0800
Message-ID: <08099ff7-95f5-4539-9c57-f42c55f9b0b1@intel.com>
Date: Thu, 5 Feb 2026 14:28:45 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] cxl: Fix nvdimm_bus race for nvdimm_bridge
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com
References: <20260205001633.1813643-1-dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260205001633.1813643-1-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/4/26 5:16 PM, Dave Jiang wrote:
> A small series to address a race for nvdimm_bus object when using the
> nvdimm_bridge object.
> 
> 
> Dave Jiang (2):
>   cxl/test: Removal of nvdimm_bus_register() wrapper in cxl_test
>   cxl: Fix race of nvdimm_bus for the nvdimm_bridge object
> 
>  drivers/cxl/core/pmem.c       | 236 +++++++++++++++++++++++++++++++---
>  drivers/cxl/pmem.c            | 199 +---------------------------
>  include/linux/libnvdimm.h     |   2 +-
>  tools/testing/cxl/Kbuild      |   1 -
>  tools/testing/cxl/test/mock.c |  15 ---
>  5 files changed, 221 insertions(+), 232 deletions(-)
> 
> 
> base-commit: 18f7fcd5e69a04df57b563360b88be72471d6b62

Don't bother reviewing this. Going to try a different approach. 
