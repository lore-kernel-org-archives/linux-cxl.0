Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384BD1805B;
	Tue, 13 May 2025 00:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747094946; cv=none; b=ViYpSbcTd3BGFFZYpEYFTCUq97Znn/WN1ooECcfgmUyQrOuY68qg1r1TJwbLCQgRONw4hNcf0CWveKKmOv5x3OxT++jP2OcpKkJRK9n6iOTUFLwApjC8ev9I/aVoLzUzpnT9w5WQ//VuDRsiC9uCAB/IGSGbXcba1ALhIJM8xmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747094946; c=relaxed/simple;
	bh=7ZtSxivjoK3M9fH9frt+xHwAgujTa7ewgoWYcEHRngQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lK4byBSjEZGl3u8zSLWomF8ZJ0q6LFq9nRDz3UrL/PMN5pVwiy1lMFf5KyqZyF0howRDqU6CqosHBfPwXWscYAwxN/Q2CDa7YO64fC5fCgOjgbsED7Gw/SIi7DAlorgqTWK2tZ2jHhhUZPiREFXgLWKCBKPECbAgdZ7x/t+XToo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TcfzYnTT; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TcfzYnTT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747094944; x=1778630944;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7ZtSxivjoK3M9fH9frt+xHwAgujTa7ewgoWYcEHRngQ=;
  b=TcfzYnTTl2Xo830J8AoM/Nq4I0Q2sAu8mAMMuqWebosa9qVeIXTEQFco
   4g8ZbmhksGKGE1aC9ysIyA9boIDv3oFFKA2cj+KF54I6d/e2m+D8x04LS
   uVdCQsI2S3GRJiZPHEup35hbmfxIfJDMhl3fG7xr2b15bqEiCd4FFTfd0
   CitvmjnHI1mZKk5PGv/OXTFHeGuz6Ih7qTPo3I4OsbssNf7son1jG2Z1V
   qJclDzo453iSyg+pox1pHgKarKxt+BKoTh5ZIM3H5OGqTaPXrZgVnX4jn
   NG+qOYWIE37fCOvqh04WXWvnc4tJuqbTq2ENG5aQ1QHhxsI5zPfPTN4fe
   g==;
X-CSE-ConnectionGUID: ddVq+PXkRFyPzp3Keg24uQ==
X-CSE-MsgGUID: 005j1EzzTCePd9TyUWkw6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="60255183"
X-IronPort-AV: E=Sophos;i="6.15,283,1739865600"; 
   d="scan'208";a="60255183"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 17:09:03 -0700
X-CSE-ConnectionGUID: vx8DaHZKTM6lKYNLqr0TuQ==
X-CSE-MsgGUID: nRaBNcnFQtmSyh1F8YdDcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,283,1739865600"; 
   d="scan'208";a="142711631"
Received: from bjrankin-mobl3.amr.corp.intel.com (HELO [10.124.220.233]) ([10.124.220.233])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 17:09:03 -0700
Message-ID: <0c753b5b-37e9-4f72-a27a-acd5b64752aa@intel.com>
Date: Mon, 12 May 2025 17:09:00 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/17] cxl: docs/linux - overview
To: Gregory Price <gourry@gourry.net>, linux-cxl@vger.kernel.org
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, corbet@lwn.net
References: <20250512162134.3596150-1-gourry@gourry.net>
 <20250512162134.3596150-8-gourry@gourry.net>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250512162134.3596150-8-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/12/25 9:21 AM, Gregory Price wrote:
> Add type-3 device configuration overview that explains the probe
> process for a type-3 device from early-boot through memory-hotplug.
> 
> Signed-off-by: Gregory Price <gourry@gourry.net>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  Documentation/driver-api/cxl/index.rst        |   3 +-
>  .../driver-api/cxl/linux/overview.rst         | 103 ++++++++++++++++++
>  2 files changed, 105 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/driver-api/cxl/linux/overview.rst
> 
> diff --git a/Documentation/driver-api/cxl/index.rst b/Documentation/driver-api/cxl/index.rst
> index 6a5fb7e00c52..bc2228c77c32 100644
> --- a/Documentation/driver-api/cxl/index.rst
> +++ b/Documentation/driver-api/cxl/index.rst
> @@ -30,9 +30,10 @@ that have impacts on each other.  The docs here break up configurations steps.
>     platform/example-configs
>  
>  .. toctree::
> -   :maxdepth: 1
> +   :maxdepth: 2
>     :caption: Linux Kernel Configuration
>  
> +   linux/overview
>     linux/access-coordinates
>  
>  
> diff --git a/Documentation/driver-api/cxl/linux/overview.rst b/Documentation/driver-api/cxl/linux/overview.rst
> new file mode 100644
> index 000000000000..648beb2c8c83
> --- /dev/null
> +++ b/Documentation/driver-api/cxl/linux/overview.rst
> @@ -0,0 +1,103 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +========
> +Overview
> +========
> +
> +This section presents the configuration process of a CXL Type-3 memory device,
> +and how it is ultimately exposed to users as either a :code:`DAX` device or
> +normal memory pages via the kernel's page allocator.
> +
> +Portions marked with a bullet are points at which certain kernel objects
> +are generated.
> +
> +1) Early Boot
> +
> +  a) BIOS, Build, and Boot Parameters
> +
> +    i) EFI_MEMORY_SP
> +    ii) CONFIG_EFI_SOFT_RESERVE
> +    iii) CONFIG_MHP_DEFAULT_ONLINE_TYPE
> +    iv) nosoftreserve
> +
> +  b) Memory Map Creation
> +
> +    i) EFI Memory Map / E820 Consulted for Soft-Reserved
> +
> +      * CXL Memory is set aside to be handled by the CXL driver
> +
> +      * Soft-Reserved IO Resource created for CFMWS entry
> +
> +  c) NUMA Node Creation
> +
> +    * Nodes created from ACPI CEDT CFMWS and SRAT Proximity domains (PXM)
> +
> +  d) Memory Tier Creation
> +
> +    * A default memory_tier is created with all nodes.
> +
> +  e) Contiguous Memory Allocation
> +
> +    * Any requested CMA is allocated from Online nodes
> +
> +  f) Init Finishes, Drivers start probing
> +
> +2) ACPI and PCI Drivers
> +
> +  a) Detects PCI device is CXL, marking it for probe by CXL driver
> +
> +3) CXL Driver Operation
> +
> +  a) Base device creation
> +
> +    * root, port, and memdev devices created
> +    * CEDT CFMWS IO Resource creation
> +
> +  b) Decoder creation
> +
> +    * root, switch, and endpoint decoders created
> +
> +  c) Logical device creation
> +
> +    * memory_region and endpoint devices created
> +
> +  d) Devices are associated with each other
> +
> +    * If auto-decoder (BIOS-programmed decoders), driver validates
> +      configurations, builds associations, and locks configs at probe time.
> +
> +    * If user-configured, validation and associations are built at
> +      decoder-commit time.
> +
> +  e) Regions surfaced as DAX region
> +
> +    * dax_region created
> +
> +    * DAX device created via DAX driver
> +
> +4) DAX Driver Operation
> +
> +  a) DAX driver surfaces DAX region as one of two dax device modes
> +
> +    * kmem - dax device is converted to hotplug memory blocks
> +
> +      * DAX kmem IO Resource creation
> +
> +    * hmem - dax device is left as daxdev to be accessed as a file.
> +
> +      * If hmem, journey ends here.
> +
> +  b) DAX kmem surfaces memory region to Memory Hotplug to add to page
> +     allocator as "driver managed memory"
> +
> +5) Memory Hotplug
> +
> +  a) mhp component surfaces a dax device memory region as multiple memory
> +     blocks to the page allocator
> +
> +    * blocks appear in :code:`/sys/bus/memory/devices` and linked to a NUMA node
> +
> +  b) blocks are onlined into the requested zone (NORMAL or MOVABLE)
> +
> +    * Memory is marked "Driver Managed" to avoid kexec from using it as region
> +      for kernel updates

