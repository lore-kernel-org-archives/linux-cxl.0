Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B384DDAD;
	Sun, 11 May 2025 01:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746928651; cv=none; b=Co1XGDBx2Hk49jkG+yvzWbTEKkmwwvFsEh4lII9p1mzqI5LuBTGBTOJfScEmAeczp2bBKRpBRP3W7XoooGQn6TvAQW01UCvDrohxoee+RpsZYhuWFbgl8/xhVuCMF85a+ISzA0K3Cf3TmzSLSyDxtGyejtEGhQq7MUgMh6PZezg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746928651; c=relaxed/simple;
	bh=KdbX0jPiRd4tlxIfeYuW+jtn/LCXn3kN3RReU+jqVsY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XiYqgb7TTW17Dqk2XmbGvCyYGEp9N0OldwXkQ3UPBzbcO76ao6WmSQdGvNnjIZEYf76qd3JkRTJ8uak6S4cwPjVdiYH5quzEKN54rb92JOBQu+HOe5PtSsPuNX19dwoukycEWOrCfM6bFXHCf1yyYpv6hYyzk9xIwPSmdm8DEdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pQ8KXZD5; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pQ8KXZD5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=Rh2oUnvKD7/7pfEaaCaR8pSVJXctOtXLnyFrbhpv8Io=; b=pQ8KXZD53+ZUytlfH/st7V4ixo
	TZB8A0Q9zVngPf+vM6J8fva0Qx5sQDmKweGS0mSe6niePwFZFl0mDJHz2VT6sjWLNKuZE0FLpcPkV
	2AuMddOKE+7YblPM2jzpzBsZTQBU4O1EtcaUavLuXr01dvGhANjc+ggcX/b9/NDb/XsphfTr0b5qa
	wy14tNB4ChZO3TniTqZ7Ww4OxTzsEppJID3MPG1S6hR3aMTNgeKWeVF2/tgemnp4xEtFN+zm9BBat
	I9DzVL1Ys9G80sbAM9vIXgCqAJm+O/RY6QIhBIHY3teBj8wSROXVVJJ2gEB8YUSwwA9Awg19vO3vk
	hn5GOTBw==;
Received: from [50.39.124.201] (helo=[192.168.254.17])
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1uDvwI-0000000GXIf-3r8z;
	Sun, 11 May 2025 01:57:19 +0000
Message-ID: <d8eadf5e-1b9f-4020-95de-cde60e4bee48@infradead.org>
Date: Sat, 10 May 2025 18:57:05 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 02/18] cxl: docs/devices - device reference and
 uefi placeholder
To: Gregory Price <gourry@gourry.net>, linux-cxl@vger.kernel.org
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 ira.weiny@intel.com, dan.j.williams@intel.com, corbet@lwn.net
References: <20250430181048.1197475-1-gourry@gourry.net>
 <20250430181048.1197475-3-gourry@gourry.net>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250430181048.1197475-3-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/30/25 11:10 AM, Gregory Price wrote:
> Add a simple device primer sufficient to understand the theory
> of operation documentation.
> 
> Add carve-out for CDAT with a TODO.
> 
> Signed-off-by: Gregory Price <gourry@gourry.net>
> ---
>  .../driver-api/cxl/devices/device-types.rst   | 170 ++++++++++++++++++
>  Documentation/driver-api/cxl/devices/uefi.rst |  10 ++
>  Documentation/driver-api/cxl/index.rst        |   7 +
>  3 files changed, 187 insertions(+)
>  create mode 100644 Documentation/driver-api/cxl/devices/device-types.rst
>  create mode 100644 Documentation/driver-api/cxl/devices/uefi.rst
> 
> diff --git a/Documentation/driver-api/cxl/devices/device-types.rst b/Documentation/driver-api/cxl/devices/device-types.rst
> new file mode 100644
> index 000000000000..dfe8d4711987
> --- /dev/null
> +++ b/Documentation/driver-api/cxl/devices/device-types.rst
> @@ -0,0 +1,170 @@
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
> +* Allow Device-to-Host coherence and Host-to-Device snoops.

     Allows

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
> +A basic example of a type-3 device is a simple memory expanded, whose

                                                         expander  ?

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
> +may also be exclusive to a single host or shared across multiple.

                                                           multiple hosts.

> +
> +As of v6.14, Linux does not provide a formalized interface to manage DCD
> +devices, however there is active work on LKML targeting future release.
> +
> +Type-2 Device
> +-------------
> +
> +Todo


-- 
~Randy

