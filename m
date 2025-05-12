Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E0F23C4FF;
	Mon, 12 May 2025 22:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747090015; cv=none; b=cCCtZD/W8H1J6h2XkIf5/zT6FDng4I0IzZjU/7F8dHVHGAPtVKWBi+uhGtabKQ7mIgiX/ee6DW9B2Yt93cv/GSJcMKSu5X6aqfnYM6iNn0TDqWSKWiCHOodkJuU1955NB0bJI9nj5CLf99TZSV4QtPXP1e4ba92Q5zevZ7+tzMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747090015; c=relaxed/simple;
	bh=EeRfwzC1JiUE5kUIdyXj4LNyN2100r3ZCQQfiX8WnDY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L1RYZCXLNmV5nrXKPzVTy3hauurhA7YmAUGNoDhCGKOfG/cBgELiPyRpTDC4sOSn16k3ct+IzL19rrNvBeiNIRazwXtqR6NLkSVJJWD8l+tjH/2tO/cDa+xfRSgz1NGTe2UpaROI1rkP2EW7Q8gbmVnQOhcXxNBoKuCF9ckVLYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e1dqmfNj; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e1dqmfNj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747090014; x=1778626014;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EeRfwzC1JiUE5kUIdyXj4LNyN2100r3ZCQQfiX8WnDY=;
  b=e1dqmfNjPRcnc8GLDnmXnUi7fB8Vjzap0NjiW1scJtDLSKtZbKQoYBe/
   0Qt7uu4xV2PJS8uRM+wuarWq+0AECn8bU/b8xK/Ev6iRRKw5kOYYyZ0vT
   0hM9Wtf2vKM9tpgKOf4L4PZlVjMlf49j5SZMN9HIufiDIl7fO46C8dc5p
   t75R7z92cSWf8KuV8DhbjA+Ue/LTmihTAFacWitDnHnLHDPXdgPBET9tC
   RO/U8wAcjgLzbJuFHud79G4aIkQSfhemutolY2FaHFPjs+PkIPb5gdZn9
   OeeVUYUk1O0Hc9VvNj71VO4qR5fbPCofObBLyQRixaTzPodmSqTiIFP4K
   w==;
X-CSE-ConnectionGUID: pzGA0RFqR5uEu17XGfo+uQ==
X-CSE-MsgGUID: 5WNR+12CT3KCi/3QkarUAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="52563636"
X-IronPort-AV: E=Sophos;i="6.15,283,1739865600"; 
   d="scan'208";a="52563636"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 15:46:53 -0700
X-CSE-ConnectionGUID: 8TqOciTUTpuR/28U8cUwWg==
X-CSE-MsgGUID: FfZ1qQ0eSYSajwQQfJtwPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,283,1739865600"; 
   d="scan'208";a="137530769"
Received: from bjrankin-mobl3.amr.corp.intel.com (HELO [10.124.220.233]) ([10.124.220.233])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 15:46:52 -0700
Message-ID: <a962493d-0b68-4b37-88e4-57c3a199c1f8@intel.com>
Date: Mon, 12 May 2025 15:46:52 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/17] cxl: update documentation structure in prep for
 new docs
To: Gregory Price <gourry@gourry.net>, linux-cxl@vger.kernel.org
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, corbet@lwn.net
References: <20250512162134.3596150-1-gourry@gourry.net>
 <20250512162134.3596150-2-gourry@gourry.net>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250512162134.3596150-2-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/12/25 9:21 AM, Gregory Price wrote:
> Restructure the cxl folder to make adding docs per-page cleaner.
> 
> Signed-off-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  Documentation/driver-api/cxl/index.rst           | 16 +++++++++++++---
>  .../cxl/{ => linux}/access-coordinates.rst       |  0
>  ...emory-devices.rst => theory-of-operation.rst} | 10 +++++-----
>  3 files changed, 18 insertions(+), 8 deletions(-)
>  rename Documentation/driver-api/cxl/{ => linux}/access-coordinates.rst (100%)
>  rename Documentation/driver-api/cxl/{memory-devices.rst => theory-of-operation.rst} (98%)
> 
> diff --git a/Documentation/driver-api/cxl/index.rst b/Documentation/driver-api/cxl/index.rst
> index 965ba90e8fb7..fe1594dc6778 100644
> --- a/Documentation/driver-api/cxl/index.rst
> +++ b/Documentation/driver-api/cxl/index.rst
> @@ -4,12 +4,22 @@
>  Compute Express Link
>  ====================
>  
> +CXL device configuration has a complex handoff between platform (Hardware,
> +BIOS, EFI), OS (early boot, core kernel, driver), and user policy decisions
> +that have impacts on each other.  The docs here break up configurations steps.
> +
> +.. toctree::
> +   :maxdepth: 2
> +   :caption: Overview
> +
> +   theory-of-operation
> +   maturity-map
> +
>  .. toctree::
>     :maxdepth: 1
> +   :caption: Linux Kernel Configuration
>  
> -   memory-devices
> -   access-coordinates
> +   linux/access-coordinates
>  
> -   maturity-map
>  
>  .. only::  subproject and html
> diff --git a/Documentation/driver-api/cxl/access-coordinates.rst b/Documentation/driver-api/cxl/linux/access-coordinates.rst
> similarity index 100%
> rename from Documentation/driver-api/cxl/access-coordinates.rst
> rename to Documentation/driver-api/cxl/linux/access-coordinates.rst
> diff --git a/Documentation/driver-api/cxl/memory-devices.rst b/Documentation/driver-api/cxl/theory-of-operation.rst
> similarity index 98%
> rename from Documentation/driver-api/cxl/memory-devices.rst
> rename to Documentation/driver-api/cxl/theory-of-operation.rst
> index d732c42526df..32739e253453 100644
> --- a/Documentation/driver-api/cxl/memory-devices.rst
> +++ b/Documentation/driver-api/cxl/theory-of-operation.rst
> @@ -1,9 +1,9 @@
>  .. SPDX-License-Identifier: GPL-2.0
>  .. include:: <isonum.txt>
>  
> -===================================
> -Compute Express Link Memory Devices
> -===================================
> +===============================================
> +Compute Express Link Driver Theory of Operation
> +===============================================
>  
>  A Compute Express Link Memory Device is a CXL component that implements the
>  CXL.mem protocol. It contains some amount of volatile memory, persistent memory,
> @@ -14,8 +14,8 @@ that optionally define a device's contribution to an interleaved address
>  range across multiple devices underneath a host-bridge or interleaved
>  across host-bridges.
>  
> -CXL Bus: Theory of Operation
> -============================
> +The CXL Bus
> +===========
>  Similar to how a RAID driver takes disk objects and assembles them into a new
>  logical device, the CXL subsystem is tasked to take PCIe and ACPI objects and
>  assemble them into a CXL.mem decode topology. The need for runtime configuration

