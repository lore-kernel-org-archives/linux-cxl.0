Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1839519E83C
	for <linux-cxl@vger.kernel.org>; Fri, 25 Jul 2025 16:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753461334; cv=none; b=Lv4DdgF0u5jXPVWby79PoxMgYlp7ABMf6NiJo6/ixf+gqwIYOnEE3vVJ3ZrAZQ91EZ1Wuz7P/3x8YTc2Yu0M/O1kdg4zywu28YIuzs5KV4JAXnQqROkrEOhhxgzVEZ+GRxorfXD7sCa1fDH40eFnC5feK/xTlPIXEzzu+EOE2GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753461334; c=relaxed/simple;
	bh=d9jWZHAUAB3ilhRyQwasHrf8/j931YewnAlfeo/ZYtw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NFo3IxC1Uez0KEM7cR8EQxE6awdO3jzjHtFYu7AlBbf4wDKiw/BkVtEPildgGvArHVgfVq7e5QrQL6uao+uu1kaf1tbiVRNABbwPBJHZi02mHVpTSy9qgHN8zTjjWQ3zEXQpIknZkSlNNEJVqsR7+gYsFtcXe0URi5yXLjp9SB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KysR0kdN; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KysR0kdN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753461333; x=1784997333;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=d9jWZHAUAB3ilhRyQwasHrf8/j931YewnAlfeo/ZYtw=;
  b=KysR0kdNKgMDgzAbFUoYGWTBAt34mkRCINXddzkOI8v4Bu5UX9aEckWk
   n0HRr9JEoZtajphlbWWIuVWkJdGd9RQYehx9pfj07paBY4c2OEaV2/+ge
   x/8jq8l60h3Ttolm8ngjILS/ZXkOnrwsS3+z1qI4KH0aB38RYLptZySFp
   gfiZNzg8mt0VF09vTRbXrKfvvvJX7wU1CJwhvVFEylZdgHPhhsZZ23Y7W
   7TailMPWzJwhMAXSMXtZnkjtN/9tz7EetFLV2ZnY6m68MvCsx6y7r6KJI
   vLlbZaNum9bfWNAqf5h2aiHmEwKTylCd7hPyM+EdKK+/MNQ0G8ZqOR/0A
   Q==;
X-CSE-ConnectionGUID: NG5lqayDScOqgUDMMPUzog==
X-CSE-MsgGUID: W7yDa99KRBmPq7iI25/yJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11503"; a="78350829"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="78350829"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2025 09:32:50 -0700
X-CSE-ConnectionGUID: 6RaQ1+gFQLKcKJzHlk+TYw==
X-CSE-MsgGUID: gy5IyvLWSQm7gV9qOdWDdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="161333497"
Received: from bvivekan-mobl1.gar.corp.intel.com (HELO [10.247.118.216]) ([10.247.118.216])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2025 09:32:42 -0700
Message-ID: <86a015d5-7b49-4b23-8a26-2155871bd08e@intel.com>
Date: Fri, 25 Jul 2025 09:32:41 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 0/2] cxl: Support creation of a new CXL Host Bridge
To: wangyuquan <wangyuquan1236@phytium.com.cn>, jonathan.cameron@huawei.com,
 fan.ni@samsung.com, mst@redhat.com, marcel.apfelbaum@gmail.com
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org
References: <20250617040649.81303-1-wangyuquan1236@phytium.com.cn>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250617040649.81303-1-wangyuquan1236@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/16/25 9:06 PM, wangyuquan wrote:
> v2 -> v3:
> - Update the commit message
> - Fix some alignment and space problems
> - Add a SPDX header for the new file
> - Remove unnecessary comments
> - Add CXL_HOST_BRIDGE config
> v1 -> v2:
> - Move the code of new bridge to hw/pci-host/cxl.c
> - Fix and simplify some logic on handling the different bridge types

Hi Yuquan, can you please add qemu to your patch subject prefix in the future? i.e. [QEMU PATCH v4 0/2]. It would help the maintainers on linux-cxl to know they are not kernel patches. Thank you!

> 
> Background
> ==========
> Currently the base CXL support for arm platforms is only on Jonathan's
> patches[1]. Some platform like SBSA-REF can be more like a real machine,
> thus the support of CXL could be meaningful. However, the pxb-cxl-host
> realization on this platform seems not satisfying their requirements[2].
> 
> New CXL HOST design
> ===================
> Defines a new CXL host bridge type (TYPE_CXL_HOST). This is an
> independent CXL host bridge which combined GPEX features (ECAM, MMIO
> windows and irq) and CXL Host Bridge Component Registers (CHBCR).
> 
> The root bus path of CXL_HOST is "0001:00", that would not affect the
> original pcie host topology. In the previous, the pxb-cxl-host with
> any CXL root ports and CXL endpoint devices would occupy the BDF
> number of the original pcie domain. This new type provide a solution
> to resolve the problem.
> 
> Remaining problems
> ==================
> I tried to use 'object_resolve_path' but it could not work in
> 'cxl_fmws_link_targets', so I used 'TYPE_DEVICE' to match that.
> 
> Link:
> [1]: https://lore.kernel.org/linux-cxl/20220616141950.23374-1-Jonathan.Cameron@huawei.com/
> [2]: https://lists.nongnu.org/archive/html/qemu-arm/2024-11/msg00522.html
> 
> Yuquan Wang (2):
>   pci-host/cxl: Support creation of a new CXL Host Bridge
>   hw/pxb-cxl: Rename the pxb cxl host bridge
> 
>  hw/cxl/cxl-host-stubs.c               |   3 +
>  hw/cxl/cxl-host.c                     |  64 ++++++++---
>  hw/pci-bridge/pci_expander_bridge.c   |   8 +-
>  hw/pci-host/Kconfig                   |   4 +
>  hw/pci-host/cxl.c                     | 152 ++++++++++++++++++++++++++
>  hw/pci-host/meson.build               |   1 +
>  include/hw/cxl/cxl.h                  |   7 +-
>  include/hw/cxl/cxl_host.h             |   3 +
>  include/hw/pci-host/cxl_host_bridge.h |  23 ++++
>  9 files changed, 244 insertions(+), 21 deletions(-)
>  create mode 100644 hw/pci-host/cxl.c
>  create mode 100644 include/hw/pci-host/cxl_host_bridge.h
> 

