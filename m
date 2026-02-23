Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB44C5695
	for <linux-cxl@vger.kernel.org>; Mon, 23 Feb 2026 22:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771886262; cv=none; b=qD4qkDLgCFmA4KKxuWp2WZ/2zaSoHUDOCFSJWL4ekrYP3r5a2rGsUSCpNKC2LUvDQuXz7kDH61CYdXZqbVyAWKgGxXnfZ9H7Z/h2yjfEs5Rniwl1Jwz/pqGfWFL/b9js8oWCsEa5GEIN9gILdTLqsDiJgGRiQCjHSIkcPKU8Qf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771886262; c=relaxed/simple;
	bh=rYkrP3c3aa1mFsFOUsxSdPLocQmUBcOI37VeaTkUHkc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=n52PFXeBOwuV2PzKAGLvgDE/i3Gurx/DoQgKs046ypYgj0QlsBVKzXY2p3gUw43A4cOBr2xvKpKaKGUnIweX1ozmBwKVJu6gvgwgKwWCQmqGIOfLEBZpvyIekcJJyF5bvdxjLxwQoKF80L/w4Wb5vR8GfoOeusmEDIE2PtkJzBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bbbOLq1L; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bbbOLq1L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771886261; x=1803422261;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=rYkrP3c3aa1mFsFOUsxSdPLocQmUBcOI37VeaTkUHkc=;
  b=bbbOLq1Ldx2jucbi5nf0j+dZOoKlUwAfm4yYztNR5AVC+G0BZ+sivthi
   6SiryCkNYe6oNYqawFoOjFkcIDW2FOdpLcvKL1c5+2Rp6WdDDn04y42Rh
   KRtfldutczPGwWMea6dIT4+xiJXXgW/zK5/Ku2M6lJZLhJBsvncbn8ffj
   MTaffnJMExGOcu56FCfYht+DCSPwzuQ/mdj+kltearNUlPnWWNdrwICez
   Q9vSAWkB60cHzyCbOFQSbneor1RzDcrbPNhs7RM7X32YsgZPv7Y3idP4r
   7mXq9PhI4fIZiANDR8SKO8R6wxP27w2w4+K0nVGtgFW6FVg74UO4F7ZzC
   A==;
X-CSE-ConnectionGUID: Sz4vuX+NRc2noJ9QIBf4nw==
X-CSE-MsgGUID: 4qxNXAwYT1WqcqjdALYRTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="83216046"
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="83216046"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 14:37:41 -0800
X-CSE-ConnectionGUID: kcaWZaAbRU+nhKNSZipqoA==
X-CSE-MsgGUID: DIlak2QHQzmbzKem7vmbTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="213050142"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.110.227]) ([10.125.110.227])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 14:37:40 -0800
Message-ID: <23e7eadb-bdff-4fd9-9c1f-ac55e02f5664@intel.com>
Date: Mon, 23 Feb 2026 15:37:39 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] cxl: Fix nvdimm_bus race for nvdimm devices
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com
References: <20260213224038.549798-1-dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260213224038.549798-1-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/13/26 3:40 PM, Dave Jiang wrote:
> v3:
> - Just move the symbol of devm_cxl_add_nvdimm_bridge() with a wrapper function. (Dan)
> - Squash the functionality of patch 2 and 3. (Dan)
> - Introduce a flag to invalidate cxl_nvdimm when releasing nvdimm_bus. (Dan)
> - With cxl_nvdimm marked as "invalidated" no need the check in cxl_nvdimm_driver. (Dan)

Applied to cxl/fixes
16fb82cadd63 cxl: Fix race of nvdimm_bus object when creating nvdimm objects
e7e222ad73d9 cxl: Move devm_cxl_add_nvdimm_bridge() to cxl_pmem.ko

> 
> v2:
> - Try a different approach
> 
> A small series to address a race for nvdimm_bus object when using the
> nvdimm_bridge object.
> 
> Dave Jiang (2):
>   cxl: Move devm_cxl_add_nvdimm_bridge() to cxl_pmem.ko
>   cxl: Fix race of nvdimm_bus object when creating nvdimm objects
> 
>  drivers/cxl/core/pmem.c | 40 ++++++++++++++++++++++++++++++----------
>  drivers/cxl/cxl.h       |  7 +++++++
>  drivers/cxl/pmem.c      | 22 +++++++++++++++++++++-
>  3 files changed, 58 insertions(+), 11 deletions(-)
> 
> 
> base-commit: 63fbf275fa9f18f7020fb8acf54fa107e51d0f23

