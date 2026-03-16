Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23ADC30C37B;
	Mon, 16 Mar 2026 17:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773683829; cv=none; b=jlT6a3fOrW3fOkt6tvPfLtubU2kvJCAU5IKF3TD0xzk1rTh0s3mvr5C35BJymId8uylWtuztxQDEmZZDF4q8yqohrM9Q+m6nzqBDRydrXg63Nx2YzOoZ7PVJByLymltQ0oAJls2qOECuXg1X5lILg+POFbhqpi3Pr7CAeBjapIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773683829; c=relaxed/simple;
	bh=Nlplb5+HwGh8P6cDCekUQFDlxbYcp0XH6IADUuLUk1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rkL5Im46Kzs516rSHsEKhF8CVt+C3BHa6fPzP0dqOy/B0mXjYvBZ/ZNQiXfH/fVs+O7wA5hKddEpRHhV7rqUDOMqzqu1EBim3lWjqwHp+/x4PWc+bBAFQUVG0+0AZDob4StG0rVXaE/3r9CEpM9DYaYtL2YP4bN4EGzkEVSKFSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AI6qDLv9; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AI6qDLv9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773683827; x=1805219827;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Nlplb5+HwGh8P6cDCekUQFDlxbYcp0XH6IADUuLUk1c=;
  b=AI6qDLv9Gi2iegNylbrF/mXdRmhR9wTOC4z8vjIDo36M5TMjMzecWNr5
   CjdsEdpH2qcvOy2+UP2X7+DHTxrnY2cWEiRGsk90hOYPq56Gr1EolUahF
   ODJFT9behhkY8sOq+eiHNOVARiiuWBR0/rg250J7Dg+/+v4hPuGUhmRE1
   BN968fR6ST/NmrMKvtb4jYV98zWJ2ZfijPINWV9VXtDKCu32CDGxs5zsH
   yUfDljPShUmS2+Zo0NhKlVlJOjIsgqzlh3f+HAtOhFqjkhsTvPE/nmiO4
   7jO6O/LIaf8UeFHZ/m0iUKJ2VlePEeprIgqpOqVnXSPUdXHg9YMZ5qQDR
   Q==;
X-CSE-ConnectionGUID: BjrO2W7DR4KnAcNbPK5svw==
X-CSE-MsgGUID: ucAs/jdCQKCvqD1PPg2Gag==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="74414667"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="74414667"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 10:57:07 -0700
X-CSE-ConnectionGUID: trjGfTf9SS6uoracVSVxVw==
X-CSE-MsgGUID: wL+SxLvMQlSWZDUGbfPdMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="259888120"
Received: from lstrano-mobl6.amr.corp.intel.com (HELO [10.124.223.96]) ([10.124.223.96])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 10:57:05 -0700
Message-ID: <49d8215f-7a4b-4f0c-a062-3edf7d5c06c0@intel.com>
Date: Mon, 16 Mar 2026 10:57:04 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] cxl: Consolidate cxlmd->endpoint accessing
To: Li Ming <ming.li@zohomail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Ben Cheatham <benjamin.cheatham@amd.com>
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org
References: <20260314-fix_access_endpoint_without_drv_check-v2-0-4c09edf2e1db@zohomail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260314-fix_access_endpoint_without_drv_check-v2-0-4c09edf2e1db@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/14/26 12:06 AM, Li Ming wrote:
> Currently, CXL subsystem implementation has some functions that may
> access CXL memdev's endpoint before the endpoint initialization
> completed or without checking the CXL memdev endpoint validity. 
> This patchset fixes three scenarios as above description.
> 
> 1. cxl_dpa_to_region() is possible to access an invalid CXL memdev
>    endpoint.
>    there are two scenarios that can trigger this issue:
>    a. memdev poison injection/clearing debugfs interfaces:
>       devm_cxl_add_endpoint() is used to register CXL memdev endpoint
>       and update cxlmd->endpoint from -ENXIO to the endpoint structure.
>       memdev poison injection/clearing debugfs interfaces are registered
>       before devm_cxl_add_endpoint() is invoked in cxl_mem_probe().
>       There is a small window where user can use the debugfs interfaces
>       to access an invalid endpoint.
>    b. cxl_event_config() in the end of cxl_pci_probe():
>       cxl_event_config() invokes cxl_mem_get_event_record() to get
>       remain event logs from CXL device during cxl_pci_probe(). If CXL
>       memdev probing failed before that, it is also possible to access
>       an invalid endpoint.
>    To fix these two cases, cxl_dpa_to_region() requires callers holding
>    CXL memdev lock to access it and check if CXL memdev driver bingding
>    status. Holding CXL memdev lock ensures that CXL memdev probing has
>    completed, and if CXL memdev driver is bound, it will mean
>    cxlmd->endpoint is valid. (PATCH #1-#3)
> 
> 2. cxl_reset_done() callback in cxl_pci module.
>    cxl_reset_done() callback also accesses cxlmd->endpoint without any
>    checking. If CXL memdev probing fails, then cxl_reset_done() is
>    called by PCI subsystem, it will access an invalid endpoint. The
>    solution is adding a CXL memdev driver binding status inside
>    cxl_reset_done(). (PATCH #4)
> 
> ---
> Changes in v2:
> - Move hoding CXL memdev lock to cxl_debugfs_poison_inject/clear(). (Alison)
> - Drop device_lock_assert() in cxl_inject/clear_poison_locked(). (Alison)
> - Remove device_lock_assert() in cxl_dpa_to_region() to remove patch
>   "cxl/region: Hold memdev lock during region poison injection/clear". (Alison)
> - Squash patch "cxl/pci: Hold memdev lock in cxl_event_trace_record()"
>   and patch "cxl/region: Ensure endpoint is valid in cxl_dpa_to_region()". (Dan & Dave)
> - Remove patch "cxl/port: Reset cxlmd->endpoint to -ENXIO by default".
> - Link to v1: https://lore.kernel.org/r/20260310-fix_access_endpoint_without_drv_check-v1-0-94fe919a0b87@zohomail.com
> 
> ---
> Li Ming (4):
>       driver core: Add conditional guard support for device_lock()
>       cxl/memdev: Hold memdev lock during memdev poison injection/clear
>       cxl/pci: Hold memdev lock in cxl_event_trace_record()
>       cxl/pci: Check memdev driver binding status in cxl_reset_done()
> 
>  drivers/cxl/core/mbox.c   |  5 +++--
>  drivers/cxl/core/region.c |  8 +++++---
>  drivers/cxl/cxlmem.h      |  2 +-
>  drivers/cxl/mem.c         | 10 ++++++++++
>  drivers/cxl/pci.c         |  3 +++
>  include/linux/device.h    |  1 +
>  6 files changed, 23 insertions(+), 6 deletions(-)
> ---
> base-commit: 11439c4635edd669ae435eec308f4ab8a0804808
> change-id: 20260308-fix_access_endpoint_without_drv_check-f2e6ff4bdc48

Applied to cxl/next
43e4c205197e cxl/pci: Check memdev driver binding status in cxl_reset_done()
11ce2524b7f3 cxl/pci: Hold memdev lock in cxl_event_trace_record()
b227d1faed0a cxl/memdev: Hold memdev lock during memdev poison injection/clear
e5564e392075 Merge tag 'device_lock_cond_guard-7.1-rc1' into for-7.1/cxl-consolidate-endpoint

> 
> Best regards,

