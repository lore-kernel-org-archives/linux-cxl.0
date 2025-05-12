Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993C11FC3;
	Mon, 12 May 2025 23:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747091311; cv=none; b=aMQNLFFCPp6VdAaUzpddNsXi2pFGQ7NjlA0nFOfk2WpDCSIIqhwIVCDVtySxJN1dwib8FxAZjHIUVF/LVkkEuVPrJab8VsrAhF8sXwiH/Y9J1Jw25Yvqc8yKQdjwdiHTcM+Uw6p8Cs5Is/P3CQQoLBEEIL5mKHMKpZ57wW0w6Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747091311; c=relaxed/simple;
	bh=VhcpFylbricmY0wjnSpGV795ap6LQHXK2Iw8clUyNM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m42FdbpI9baDVIMoxIEg7E+9GVTnfcsh0DHmJMku/nDZ/NCLvrL9JCZeBWvIlDK7gK5eU8m00VQFpsrvfXye8fxt1H3DizQWYxfPEIbcD0/GbJCbw9XCvQaXJOBYT5PQtEj1PaMtxDfqYZ5QPA6RdpYNb/HixM63ORwbQaFzouY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bN/0Lzpi; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bN/0Lzpi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747091309; x=1778627309;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VhcpFylbricmY0wjnSpGV795ap6LQHXK2Iw8clUyNM0=;
  b=bN/0Lzpilzq/68ElxUoIW3AdTOQHRV4RK+FfdwjE9MMCDi+c2iU/bel6
   tZlkca/tLxFp8C6S49E0SeQ9NFilBPmVsoZ5kGiDzKKcVM/nyn//5ujny
   gnCBaGiJBnOJen24Xf83cl96dXhqphCY156+Wit9WbvnL9hRNj0cpt6iH
   19HCjtiMva2JKBsf9ep/3IFWEfVWHiCrb7iARLg6sH/789QzrjspKf29C
   eA1DGHUXoYSKEJ8eP6sdG0g2iqB9wltZZ0p8RDIw7fKpuhO9DVL3jcmhk
   UBVSLvYH784XESjrBPAsz7ZnyRi8x36qujUmlb+LnawbkiPsxzNMTk1iv
   w==;
X-CSE-ConnectionGUID: q+NjWyFbQUCZrrUYlz0XEA==
X-CSE-MsgGUID: p+HRP/IYQtWoDds1dmUeEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="59550588"
X-IronPort-AV: E=Sophos;i="6.15,283,1739865600"; 
   d="scan'208";a="59550588"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 16:08:28 -0700
X-CSE-ConnectionGUID: WX34r/o+QQSrwSwoJNBteQ==
X-CSE-MsgGUID: GUXJ6QjcRR6xf4GAoWpSUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,283,1739865600"; 
   d="scan'208";a="142287079"
Received: from bjrankin-mobl3.amr.corp.intel.com (HELO [10.124.220.233]) ([10.124.220.233])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 16:08:26 -0700
Message-ID: <e5211a03-617b-43f8-8ba4-b75557e283da@intel.com>
Date: Mon, 12 May 2025 16:08:24 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/17] cxl: docs/devices - add cxl device and protocol
 reference
To: Gregory Price <gourry@gourry.net>, linux-cxl@vger.kernel.org
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, corbet@lwn.net
References: <20250512162134.3596150-1-gourry@gourry.net>
 <20250512162134.3596150-4-gourry@gourry.net>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250512162134.3596150-4-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/12/25 9:21 AM, Gregory Price wrote:
> Add a simple device primer sufficient to understand the theory
> of operation documentation.
> 
> Signed-off-by: Gregory Price <gourry@gourry.net>
> ---
>  .../driver-api/cxl/devices/device-types.rst   | 165 ++++++++++++++++++
>  Documentation/driver-api/cxl/index.rst        |   6 +
>  2 files changed, 171 insertions(+)
>  create mode 100644 Documentation/driver-api/cxl/devices/device-types.rst
> 
> diff --git a/Documentation/driver-api/cxl/devices/device-types.rst b/Documentation/driver-api/cxl/devices/device-types.rst
> new file mode 100644
> index 000000000000..c70564cf0be3
> --- /dev/null
> +++ b/Documentation/driver-api/cxl/devices/device-types.rst
> @@ -0,0 +1,165 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=====================
> +Devices and Protocols
> +=====================
> +
> +The type of CXL device (Memory, Accelerator, etc) dictates many configuration steps. This section
> +covers some basic background on device types and on-device resources used by the platform and OS
> +which impact configuration.
> +
> +Protocols
> +=========
> +
> +There are three core protocols to CXL.  For the purpose of this documentation,
> +we will only discuss very high level definitions as the specific hardware
> +details are largely abstracted away from Linux.  See the CXL specification
> +for more details.
> +
> +CXL.io
> +------
> +The basic interaction protocol, similar to PCIe configuration mechanisms.
> +Typically used for initialization, configuration, and I/O access for anything
> +other than memory (CXL.mem) or cache (CXL.cache) operations.
> +
> +The Linux CXL driver exposes access to .io functionalty via the various sysfs
> +interfaces and /dev/cxl/ devices (which exposes direct access to device
> +mailboxes).
> +
> +CXL.cache
> +---------
> +The mechanism by which a device may coherently access and cache host memory.
> +
> +Largely transparent to Linux once configured.
> +
> +CXL.mem
> +---------
> +The mechanism by which the CPU may coherently access and cache device memory.
> +
> +Largely transparent to Linux once configured.
> +
> +
> +Device Types
> +============
> +
> +Type-1
> +------
> +
> +A Type-1 CXL device:
> +
> +* Supports cxl.io and cxl.cache protocols
> +* Implements a fully coherent cache
> +* Allows Device-to-Host coherence and Host-to-Device snoops.
> +* Does NOT have host-managed device memory (HDM)
> +
> +Typical examples of type-1 devices is a Smart NIC - which may want to
> +directly operate on host-memory (DMA) to store incoming packets. These
> +devices largely rely on CPU-attached memory.
> +
> +Type-2
> +------
> +
> +A Type-2 CXL Device:
> +
> +* Supports cxl.io, cxl.cache, and cxl.mem protocols
> +* Optionally implements coherent cache and Host-Managed Device Memory
> +* Is typically an accelerator device w/ high bandwidth memory.
> +
> +The primary difference between a type-1 and type-2 device is the presence
> +of host-managed device memory, which allows the device to operate on a
> +local memory bank - while the CPU sill has coherent DMA to the same memory.
> +
> +The allows things like GPUs to expose their memory via DAX devices or file
> +descriptors, allows drivers and programs direct access to device memory
> +rather than use block-transfer semantics.
> +
> +Type-3
> +------
> +
> +A Type-3 CXL Device
> +
> +* Supports cxl.io and cxl.mem
> +* Implements Host-Managed Device Memory
> +* May provide either Volatile or Persistent memory capacity (or both).
> +
> +A basic example of a type-3 device is a simple memory expander, whose
> +local memory capacity is exposed to the CPU for access directly via
> +basic coherent DMA.
> +
> +Switch
> +------
> +
> +A CXL switch is a device capacity of routing any CXL (and by extension, PCIe)
> +protocol between an upstream, downstream, or peer devices.  Many devices, such
> +as Multi-Logical Devices, imply the presence of switching in some manner.
> +
> +Logical Devices and Heads
> +-------------------------
> +
> +A CXL device may present one or more "Logical Devices" to one or more hosts
> +(via physical "Heads").
> +
> +A Single-Logical Device (SLD) is a device which presents a single device to
> +one or more heads.
> +
> +A Multi-Logical Device (MLD) is a device which may present multiple devices
> +to one or more devices.
> +
> +A Single-Headed Device exposes only a single physical connection.
> +
> +A Multi-Headed Device exposes multiple physical connections.
> +
> +MHSLD
> +~~~~~
> +A Multi-Headed Single-Logical Device (MHSLD) exposes a single logical
> +device to multiple heads which may be connected to one or more discrete
> +hosts.  An example of this would be a simple memory-pool which may be
> +statically configured (prior to boot) to expose portions of its memory
> +to Linux via the CEDT ACPI table.
> +
> +MHMLD
> +~~~~~
> +A Multi-Headed Multi-Logical Device (MHMLD) exposes multiple logical
> +devices to multiple heads which may be connected to one or more discrete
> +hosts.  An example of this would be a Dynamic Capacity Device or which
> +may be configured at runtime to expose portions of its memory to Linux.
> +
> +Example Devices
> +===============
> +
> +Memory Expander
> +---------------
> +The simplest form of Type-3 device is a memory expander.  A memory expander
> +exposes Host-Managed Device Memory (HDM) to Linux.  This memory may be
> +Volatile or Non-Volatile (Persistent).
> +
> +Memory Expanders will typically be considered a form of Single-Headed,
> +Single-Logical Device - as its form factor will typically be an add-in-card
> +(AIC) or some other similar form-factor.
> +
> +The Linux CXL driver provides support for static or dynamic configuration of
> +basic memory expanders.  The platform may program decoders prior to OS init
> +(e.g. auto-decoders), or the user may program the fabric if the platform
> +defers these operations to the OS.
> +
> +Multiple Memory Expanders may be added to an external chassis and exposed to
> +a host via a head attached to a CXL switch.  This is a "memory pool", and
> +would be considered an MHSLD or MHMLD depending on the management capabilities
> +provided by the switch platform.
> +
> +As of v6.14, Linux does not provide a formalized interface to manage non-DCD
> +MHSLD or MHMLD devices.
> +
> +Dynamic Capacity Device (DCD)
> +-----------------------------
> +
> +A Dynamic Capacity Device is a Type-3 device which provides dynamic management
> +of memory capacity. The basic premise of a DCD to provide an allocator-like
> +interface for physical memory capacity to a "Fabric Manager" (an external,
> +privileged host with privileges to change configurations for other hosts).
> +
> +A DCD manages "Memory Extents", which may be volatile or persistent. Extents
> +may also be exclusive to a single host or shared across multiple hosts.
> +
> +As of v6.14, Linux does not provide a formalized interface to manage DCD
> +devices, however there is active work on LKML targeting future release.

I wonder instead of referring to a kernel version, maybe refer to the CXL maturity map on support status.

DJ


> diff --git a/Documentation/driver-api/cxl/index.rst b/Documentation/driver-api/cxl/index.rst
> index fe1594dc6778..a2d1c5b18a8a 100644
> --- a/Documentation/driver-api/cxl/index.rst
> +++ b/Documentation/driver-api/cxl/index.rst
> @@ -15,6 +15,12 @@ that have impacts on each other.  The docs here break up configurations steps.
>     theory-of-operation
>     maturity-map
>  
> +.. toctree::
> +   :maxdepth: 2
> +   :caption: Device Reference
> +
> +   devices/device-types
> +
>  .. toctree::
>     :maxdepth: 1
>     :caption: Linux Kernel Configuration

