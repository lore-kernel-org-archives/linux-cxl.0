Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F371F4608;
	Tue, 13 May 2025 20:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747168722; cv=none; b=mqvx18XY9sSMTHaCfTuqDk4iWyvRnwDuQ2dw7Kmeb22Dfy0029Tzl6TekpcQtDueoUXp+BKrLI+Q3Hiw25syMByJhQ4w9myy6UfQldiSEcl9/cx3qVsmWrtZnCUx4wpytInaofBGwyvXfD+pcoRuGzWfTqYQK1G+oZ+8rtm17/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747168722; c=relaxed/simple;
	bh=ZnpLTXMGgaL0ezSeVq7ySrTFe18ZLCGWZe1umzT/glY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lnn0qnapn434E82ijScuNRz2UmMOqK9OtbCfQYqlSxc8CdxMF/1HTQdyT1FMMAyYYa0VwcfW8ll3C/8RwsnCPVmXZ0VaK6Fantg2RlzaSTevqN0EyL3UkOzwGYLH9BRHAcjfsbfWDD3RzLMTmJIspAUhg57nKNg7nbfV+pPn56Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QZi0cM4J; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QZi0cM4J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747168721; x=1778704721;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZnpLTXMGgaL0ezSeVq7ySrTFe18ZLCGWZe1umzT/glY=;
  b=QZi0cM4J6Q0mnQi+lRzGcyrBn7z5kF1SPyaIjwvATvexcTX9g9Lt6SgH
   4G7mgzR/eewLx40qHvACrfdb9wrT5hYzn/X8TD3BbAiMGZUY+roY1jhd0
   wuR8+6OZi0WVuMyAZ+uRlrVgogD2xnx2viIjiHoIZ+G8w3ZG/AwP6pu8H
   O/Nn5PpWi3s25RZ7q1ZwKP2Qw+ghiZmBFrWNy2Hx23PEjZ239FcVuxTxg
   VVuKm8YwpvsIWy9QcTsH56qeJNKJC6lJ2GH6+uWtI45omPL0Zf2bRGo1b
   lsAxcilbmO4adAVnsYROOlx/rreGS5wRaExPPEQ8g5M6vSigby9zXsmTg
   A==;
X-CSE-ConnectionGUID: +lAjIvjRSCSpF2mskBgRtg==
X-CSE-MsgGUID: 61l7WWOXSeSUi09pgIeltQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11432"; a="48147347"
X-IronPort-AV: E=Sophos;i="6.15,286,1739865600"; 
   d="scan'208";a="48147347"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 13:38:40 -0700
X-CSE-ConnectionGUID: vCPTIcmrTF6f8ibEeArQpQ==
X-CSE-MsgGUID: 7bDlUerqT46csmmto6AOdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,286,1739865600"; 
   d="scan'208";a="137697046"
Received: from ldmartin-desk2.corp.intel.com (HELO [10.125.109.16]) ([10.125.109.16])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 13:38:39 -0700
Message-ID: <c164b38f-f6ee-456b-b6f5-3aef943890fb@intel.com>
Date: Tue, 13 May 2025 13:38:37 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/17] CXL Boot to Bash Documentation
To: Gregory Price <gourry@gourry.net>, linux-cxl@vger.kernel.org
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, corbet@lwn.net,
 Joshua Hahn <joshua.hahnjy@gmail.com>
References: <20250512162134.3596150-1-gourry@gourry.net>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250512162134.3596150-1-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/12/25 9:21 AM, Gregory Price wrote:
> v3:
> - Cross-links (Bagas)
> - Grammar and spelling (Randy)
> - added fixups to access-coordinates (Bagas)
> - Drop TODO sections (use-case, memory-tiering, CDAT/UEFI, SRAT Genport)
>   I unfortunately won't be able to come back around to this for
>   a while, so I'd rather not let this rot.

Applied to cxl/next

> 
> ---
> 
> This series converts CXL Boot to Bash Docs from LSFMM '25 to Linux
> Kernel Docs.  In brief, this document covers (almost) everything Linux
> expects from platforms to successfully bring volatile CXL memory
> capacity online as a DAX device and/or SystemRAM.
> 
> It covers:
> 
> - Platform configuration data (ACPI Tables, EFI Memory Map, EFI Configs)
> - Linux Build and Boot Parameters
> - Linux consumption of Platform, Build, and Boot params
> - Linux creation of base resources (NUMA nodes, memory tiers, etc)
> - CXL Driver probe process and sysfs structure
> - DAX Driver interactions between the CXL driver and memory hotplug
> - Memory hotplug interactions
> - Page allocator interactions (NUMA nodes, Memory Zones, Reclaim, etc).
> 
> Included are example platform configurations (ACPI tables) and cxl
> decoder configurations to guide platform developers on expected
> configurations (which may be more strict than the CXL spec).
> 
> Co-developed-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> Signed-off-by: Gregory Price <gourry@gourry.net>
> 
> Gregory Price (17):
>   cxl: update documentation structure in prep for new docs
>   cxl: docs - access-coordinates doc fixups
>   cxl: docs/devices - add cxl device and protocol reference
>   cxl: docs/platform/bios-and-efi documentation
>   cxl: docs/platform/acpi reference documentation
>   cxl: docs/platform/example-configs documentation
>   cxl: docs/linux - overview
>   cxl: docs/linux - early boot configuration
>   cxl: docs/linux - add cxl-driver theory of operation
>   cxl: docs/linux/cxl-driver - add example configurations
>   cxl: docs/linux/dax-driver documentation
>   cxl: docs/linux/memory-hotplug
>   cxl: docs/allocation/dax
>   cxl: docs/allocation/page-allocator
>   cxl: docs/allocation/reclaim
>   cxl: docs/allocation/hugepages
>   cxl: docs - add self-referencing cross-links
> 
>  .../driver-api/cxl/allocation/dax.rst         |  60 ++
>  .../driver-api/cxl/allocation/hugepages.rst   |  32 +
>  .../cxl/allocation/page-allocator.rst         |  85 +++
>  .../driver-api/cxl/allocation/reclaim.rst     |  51 ++
>  .../driver-api/cxl/devices/device-types.rst   | 165 +++++
>  Documentation/driver-api/cxl/index.rst        |  45 +-
>  .../cxl/{ => linux}/access-coordinates.rst    |  35 +-
>  .../driver-api/cxl/linux/cxl-driver.rst       | 630 ++++++++++++++++++
>  .../driver-api/cxl/linux/dax-driver.rst       |  43 ++
>  .../driver-api/cxl/linux/early-boot.rst       | 137 ++++
>  .../example-configurations/hb-interleave.rst  | 314 +++++++++
>  .../intra-hb-interleave.rst                   | 291 ++++++++
>  .../multi-interleave.rst                      | 401 +++++++++++
>  .../example-configurations/single-device.rst  | 246 +++++++
>  .../driver-api/cxl/linux/memory-hotplug.rst   |  78 +++
>  .../driver-api/cxl/linux/overview.rst         | 103 +++
>  .../driver-api/cxl/platform/acpi.rst          |  76 +++
>  .../driver-api/cxl/platform/acpi/cedt.rst     |  62 ++
>  .../driver-api/cxl/platform/acpi/dsdt.rst     |  28 +
>  .../driver-api/cxl/platform/acpi/hmat.rst     |  32 +
>  .../driver-api/cxl/platform/acpi/slit.rst     |  21 +
>  .../driver-api/cxl/platform/acpi/srat.rst     |  44 ++
>  .../driver-api/cxl/platform/bios-and-efi.rst  | 262 ++++++++
>  .../cxl/platform/example-configs.rst          |  13 +
>  .../example-configurations/flexible.rst       | 296 ++++++++
>  .../example-configurations/hb-interleave.rst  | 107 +++
>  .../multi-dev-per-hb.rst                      |  90 +++
>  .../example-configurations/one-dev-per-hb.rst | 136 ++++
>  ...ry-devices.rst => theory-of-operation.rst} |  10 +-
>  29 files changed, 3867 insertions(+), 26 deletions(-)
>  create mode 100644 Documentation/driver-api/cxl/allocation/dax.rst
>  create mode 100644 Documentation/driver-api/cxl/allocation/hugepages.rst
>  create mode 100644 Documentation/driver-api/cxl/allocation/page-allocator.rst
>  create mode 100644 Documentation/driver-api/cxl/allocation/reclaim.rst
>  create mode 100644 Documentation/driver-api/cxl/devices/device-types.rst
>  rename Documentation/driver-api/cxl/{ => linux}/access-coordinates.rst (84%)
>  create mode 100644 Documentation/driver-api/cxl/linux/cxl-driver.rst
>  create mode 100644 Documentation/driver-api/cxl/linux/dax-driver.rst
>  create mode 100644 Documentation/driver-api/cxl/linux/early-boot.rst
>  create mode 100644 Documentation/driver-api/cxl/linux/example-configurations/hb-interleave.rst
>  create mode 100644 Documentation/driver-api/cxl/linux/example-configurations/intra-hb-interleave.rst
>  create mode 100644 Documentation/driver-api/cxl/linux/example-configurations/multi-interleave.rst
>  create mode 100644 Documentation/driver-api/cxl/linux/example-configurations/single-device.rst
>  create mode 100644 Documentation/driver-api/cxl/linux/memory-hotplug.rst
>  create mode 100644 Documentation/driver-api/cxl/linux/overview.rst
>  create mode 100644 Documentation/driver-api/cxl/platform/acpi.rst
>  create mode 100644 Documentation/driver-api/cxl/platform/acpi/cedt.rst
>  create mode 100644 Documentation/driver-api/cxl/platform/acpi/dsdt.rst
>  create mode 100644 Documentation/driver-api/cxl/platform/acpi/hmat.rst
>  create mode 100644 Documentation/driver-api/cxl/platform/acpi/slit.rst
>  create mode 100644 Documentation/driver-api/cxl/platform/acpi/srat.rst
>  create mode 100644 Documentation/driver-api/cxl/platform/bios-and-efi.rst
>  create mode 100644 Documentation/driver-api/cxl/platform/example-configs.rst
>  create mode 100644 Documentation/driver-api/cxl/platform/example-configurations/flexible.rst
>  create mode 100644 Documentation/driver-api/cxl/platform/example-configurations/hb-interleave.rst
>  create mode 100644 Documentation/driver-api/cxl/platform/example-configurations/multi-dev-per-hb.rst
>  create mode 100644 Documentation/driver-api/cxl/platform/example-configurations/one-dev-per-hb.rst
>  rename Documentation/driver-api/cxl/{memory-devices.rst => theory-of-operation.rst} (98%)
> 

