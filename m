Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCA5265CA2;
	Mon,  5 Jan 2026 21:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767647451; cv=none; b=mY1Rt4yLgqxxoggRo0cYk+tX0TpXR1tB6q1tHw9ojqOooSJdqpXj1vLd8Xnscty26Q9MPQOJO1cRyZfJae7Cizt0wQ8s+npH6Awzxl7O85meRt6pIXqFhdHkzWp1StIzd+iSKGWRgwVzOUnR+kMKUFJyUm6alIv6ykSl9lfc7SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767647451; c=relaxed/simple;
	bh=K/MLEv800jeZGm8iAy2BhdCeur6VtWkHHjegTHjmSCI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nl6F6Js070EZFTPS1E7Pp2QpY6fYgDvxfjHxR7mws4XIbXdvb4B5M9CXhzMuwL0xdA0/lGMGUXoUKIqyBgJe+DR0s7pMfXbq2kWbkGcOfSON7TPjPkLkbVLGuwOX8jkpzZz2LSrXk3XxpRLIlSfIfdLKzRDgupUbql3RBZ5VEag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cu5tdoTL; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cu5tdoTL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767647449; x=1799183449;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=K/MLEv800jeZGm8iAy2BhdCeur6VtWkHHjegTHjmSCI=;
  b=Cu5tdoTLLLYGduvx1RETPt4GJYvM57MwuAfzC/DnK1AQ2AHii3PxIjxQ
   dmyVw19XgFp0/inGRvvJ0zx4VSPuSAa2eskdUAcvXyewofjmJZ6Blzacc
   45CsWVch+ympttKBItlkFw7bIfzB/GS/z3B+98t91SaHRMWZWjv1w8n5/
   MdFBo42ekxnQkLkI+ds7VwkUyoU6rUyO9HG+jcbZqZytxEvvbFDLezLw9
   YbtadBCLk1YZGKO3c9ALAoG004aKXw5uJ7FXYqucOI9u96L+RcTrYTFRk
   DCcVEFeIN8VRH7d1owcMsrmeLW9jiwjDFic08+iM+ZNXdj7nNbMC72y1R
   g==;
X-CSE-ConnectionGUID: wrALv6OHSha4iHA3Z0lMdw==
X-CSE-MsgGUID: ozk6m5NdQqyujMIcAmjAmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11662"; a="79322483"
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; 
   d="scan'208";a="79322483"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2026 13:10:47 -0800
X-CSE-ConnectionGUID: DSf3fdLiS7SQ2L74XHxOZw==
X-CSE-MsgGUID: jNVFjKMgTXq83i+a0KaoOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; 
   d="scan'208";a="206955734"
Received: from vverma7-desk1.amr.corp.intel.com (HELO [10.125.109.45]) ([10.125.109.45])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2026 13:10:46 -0800
Message-ID: <29e5de15-6e4f-4d0d-ae76-a39db99f9f59@intel.com>
Date: Mon, 5 Jan 2026 14:10:45 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] Documentation/driver-api/cxl: device hotplug
 section
To: Gregory Price <gourry@gourry.net>, linux-cxl@vger.kernel.org
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, corbet@lwn.net, rakuram.e96@gmail.com,
 alucerop@amd.com
References: <20251219170538.1675743-1-gourry@gourry.net>
 <20251219170538.1675743-3-gourry@gourry.net>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20251219170538.1675743-3-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/19/25 10:05 AM, Gregory Price wrote:
> Describe cxl memory device hotplug implications, in particular how the
> platform CEDT CFMWS must be described to support successful hot-add of
> memory devices.
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Gregory Price <gourry@gourry.net>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
> v3: Jonathan updates, change some italics to bold, add some bits about
>     Linux's expectations for BIOS/EFI behavior at runtime.
> 
>  Documentation/driver-api/cxl/index.rst        |   1 +
>  .../driver-api/cxl/platform/bios-and-efi.rst  |   3 +
>  .../cxl/platform/device-hotplug.rst           | 130 ++++++++++++++++++
>  3 files changed, 134 insertions(+)
>  create mode 100644 Documentation/driver-api/cxl/platform/device-hotplug.rst
> 
> diff --git a/Documentation/driver-api/cxl/index.rst b/Documentation/driver-api/cxl/index.rst
> index c1106a68b67c..5a734988a5af 100644
> --- a/Documentation/driver-api/cxl/index.rst
> +++ b/Documentation/driver-api/cxl/index.rst
> @@ -30,6 +30,7 @@ that have impacts on each other.  The docs here break up configurations steps.
>     platform/acpi
>     platform/cdat
>     platform/example-configs
> +   platform/device-hotplug
>  
>  .. toctree::
>     :maxdepth: 2
> diff --git a/Documentation/driver-api/cxl/platform/bios-and-efi.rst b/Documentation/driver-api/cxl/platform/bios-and-efi.rst
> index 9034c206cf8e..a4b44c018f09 100644
> --- a/Documentation/driver-api/cxl/platform/bios-and-efi.rst
> +++ b/Documentation/driver-api/cxl/platform/bios-and-efi.rst
> @@ -49,6 +49,9 @@ up without requiring CXL driver support.  These platform vendors should
>  test their configurations with the existing CXL driver and provide driver
>  support for their auto-configurations if features like RAS are required.
>  
> +Platforms requiring boot-time programming and/or locking of CXL fabric
> +components may prevent features, such as device hot-plug, from working.
> +
>  UEFI Settings
>  =============
>  If your platform supports it, the :code:`uefisettings` command can be used to
> diff --git a/Documentation/driver-api/cxl/platform/device-hotplug.rst b/Documentation/driver-api/cxl/platform/device-hotplug.rst
> new file mode 100644
> index 000000000000..e4a065fdd3ec
> --- /dev/null
> +++ b/Documentation/driver-api/cxl/platform/device-hotplug.rst
> @@ -0,0 +1,130 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +==================
> +CXL Device Hotplug
> +==================
> +
> +Device hotplug refers to *physical* hotplug of a device (addition or removal
> +of a physical device from the machine).
> +
> +BIOS/EFI software is expected to configure sufficient resources **at boot
> +time** to allow hotplugged devices to be configured by software (such as
> +proximity domains, HPA regions, and host-bridge configurations).
> +
> +BIOS/EFI is not expected (**nor suggested**) to configure hotplugged
> +devices at hotplug time (i.e. HDM decoders should be left unprogrammed).
> +
> +This document covers some examples of those resources, but should not
> +be considered exhaustive.
> +
> +Hot-Remove
> +==========
> +Hot removal of a device typically requires careful removal of software
> +constructs (memory regions, associated drivers) which manage these devices.
> +
> +Hard-removing a CXL.mem device without carefully tearing down driver stacks
> +is likely to cause the system to machine-check (or at least SIGBUS if memory
> +access is limited to user space).
> +
> +Memory Device Hot-Add
> +=====================
> +A device present at boot may be associated with a CXL Fixed Memory Window
> +reported in :doc:`CEDT<acpi/cedt>`.  That CFMWS may match the size of the
> +device, but the construction of the CEDT CFMWS is platform-defined.
> +
> +Hot-adding a memory device requires this pre-defined, **static** CFMWS to
> +have sufficient HPA space to describe that device.
> +
> +There are a few common scenarios to consider.
> +
> +Single-Endpoint Memory Device Present at Boot
> +---------------------------------------------
> +A device present at boot likely had its capacity reported in the
> +:doc:`CEDT<acpi/cedt>`.  If a device is removed and a new device hotplugged,
> +the capacity of the new device will be limited to the original CFMWS capacity.
> +
> +Adding capacity larger than the original device will cause memory region
> +creation to fail if the region size is greater than the CFMWS size.
> +
> +The CFMWS is **static** and cannot be adjusted.  Platforms which may expect
> +different sized devices to be hotplugged must allocate sufficient CFMWS space
> +**at boot time** to cover all future expected devices.
> +
> +Multi-Endpoint Memory Device Present at Boot
> +--------------------------------------------
> +Non-switch-based Multi-Endpoint devices are outside the scope of what the
> +CXL specification describes, but they are technically possible. We describe
> +them here for instructive reasons only - this does not imply Linux support.
> +
> +A hot-plug capable CXL memory device, such as one which presents multiple
> +expanders as a single large-capacity device, should report the **maximum
> +possible capacity** for the device at boot. ::
> +
> +                  HB0
> +                  RP0
> +                   |
> +     [Multi-Endpoint Memory Device]
> +              _____|_____
> +             |          |
> +        [Endpoint0]   [Empty]
> +
> +
> +Limiting the size to the capacity preset at boot will limit hot-add support
> +to replacing capacity that was present at boot.
> +
> +No CXL Device Present at Boot
> +-----------------------------
> +When no CXL memory device is present on boot, some platforms omit the CFMWS
> +in the :doc:`CEDT<acpi/cedt>`.  When this occurs, hot-add is not possible.
> +
> +This describes the base case for any given device not being present at boot.
> +If a future possible device is not described in the CEDT at boot, hot-add
> +of that device is either limited or not possible.
> +
> +For a platform to support hot-add of a full memory device, it must allocate
> +a CEDT CFMWS region with sufficient memory capacity to cover all future
> +potentially added capacity (along with any relevant CEDT CHBS entry).
> +
> +To support memory hotplug directly on the host bridge/root port, or on a switch
> +downstream of the host bridge, a platform must construct a CEDT CFMWS at boot
> +with sufficient resources to support the max possible (or expected) hotplug
> +memory capacity. ::
> +
> +         HB0                 HB1
> +      RP0    RP1             RP2
> +       |      |               |
> +     Empty  Empty            USP
> +                      ________|________
> +                      |    |    |     |
> +                     DSP  DSP  DSP   DSP
> +                      |    |    |    |
> +                         All  Empty
> +
> +For example, a BIOS/EFI may expose an option to configure a CEDT CFMWS with
> +a pre-configured amount of memory capacity (per host bridge, or host bridge
> +interleave set), even if no device is attached to Root Ports or Downstream
> +Ports at boot (as depicted in the figure above).
> +
> +
> +Interleave Sets
> +===============
> +
> +Host Bridge Interleave
> +----------------------
> +Host-bridge interleaved memory regions are defined **statically** in the
> +:doc:`CEDT<acpi/cedt>`.  To apply cross-host-bridge interleave, a CFMWS entry
> +describing that interleave must have been provided **at boot**.  Hotplugged
> +devices cannot add host-bridge interleave capabilities at hotplug time.
> +
> +See the :doc:`Flexible CEDT Configuration<example-configurations/flexible>`
> +example to see how a platform can provide this kind of flexibility regarding
> +hotplugged memory devices.  BIOS/EFI software should consider options to
> +present flexible CEDT configurations with hotplug support.
> +
> +HDM Interleave
> +--------------
> +Decoder-applied interleave can flexibly handle hotplugged devices, as decoders
> +can be re-programmed after hotplug.
> +
> +To add or remove a device to/from an existing HDM-applied interleaved region,
> +that region must be torn down an re-created.

