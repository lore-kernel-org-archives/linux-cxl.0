Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1447EEC4
	for <linux-cxl@vger.kernel.org>; Fri, 21 Jun 2024 03:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718940462; cv=none; b=bjLcxPua0xaWuObZgDTz3w5RUQNrIFMAfHr/8+aw812CCHVWa+fYgRzsG4N7J2YT51DVEfzyU33Ox1D8LxmpszuoKURde/ehPQwywpzPndGhvQk+OyDaPn0DkegG14rti54NK1sMbIwrQw04HYiuH3NOPfB5EL81LuvcY93Dm3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718940462; c=relaxed/simple;
	bh=17fw1GTBVOWHxEJoAbWu7804W8yc+O3OGKrAhzVIM98=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=L1h1qLVwNek1/NbWzKs86XvDuN58Rj/mm5L1SG9UYsTNEEzKe9UmlNvNDMyvgiWhT34t1I1zFHkRNXsrfUFoMdmuGGvZObX9dRSgsaxVM60No9hFYRf0o749x4uyxAW7ZfrKm8Lc3nPeTeRHwpcXErFvnESyLPW1vQIfY/YKiOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D9reD+mB; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D9reD+mB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718940459; x=1750476459;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=17fw1GTBVOWHxEJoAbWu7804W8yc+O3OGKrAhzVIM98=;
  b=D9reD+mBUl5M4V/Withwxi5keWyGJgrHEKNa8VyfqSwXRbvCbSptvEhc
   SNIGj+VHYR+QfH5C1nk92L+Jkr63MQJ3NkrEKfY+ucnWHynaMDLABvt81
   sNjw6P13DpIJ/4O4lDOX5chih0nWbt24rgeqCfNrglFba5o3HQxXbBSNh
   uI9dgzh6m16p4ixNja+3EvaN2pvqndArRUcaWCIwjvbYU5IkNH8TE8FV8
   Srql+ggG1kwx3XleRlb/DXYgzNEIbRXTLTP6rOr9XN6EeP2hgP1GQ6M+Z
   NLXEqvsXdJn/QthvzYyuHZfcx7apq+qY2OSOwLIJvn5SdtVKYUjFXZWE/
   A==;
X-CSE-ConnectionGUID: H202DhmmS8GJmdnyQfQ+6A==
X-CSE-MsgGUID: M3+8fQsaTyeKGKTrUdI8Tg==
X-IronPort-AV: E=McAfee;i="6700,10204,11109"; a="15790549"
X-IronPort-AV: E=Sophos;i="6.08,253,1712646000"; 
   d="scan'208";a="15790549"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 20:27:39 -0700
X-CSE-ConnectionGUID: bEA1P2dtShC0IpkoRsdbLQ==
X-CSE-MsgGUID: y7ZKXGvVSnO7AvN2dVbO7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,253,1712646000"; 
   d="scan'208";a="47391227"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 20:27:36 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: <imammedo@redhat.com>,  <mst@redhat.com>,  Markus Armbruster
 <armbru@redhat.com>,  <qemu-devel@nongnu.org>,  <ankita@nvidia.com>,
  <marcel.apfelbaum@gmail.com>,  <philmd@linaro.org>,  Richard Henderson
 <richard.henderson@linaro.org>,  <linuxarm@huawei.com>,  Dave Jiang
 <dave.jiang@intel.com>,  Paolo Bonzini <pbonzini@redhat.com>,
  <eduardo@habkost.net>,  <linux-cxl@vger.kernel.org>,  Michael Roth
 <michael.roth@amd.com>,  Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v3 qemu 00/11] acpi: NUMA nodes for CXL HB as GP +
 complex NUMA test
In-Reply-To: <20240620160324.109058-1-Jonathan.Cameron@huawei.com> (Jonathan
	Cameron's message of "Thu, 20 Jun 2024 17:03:08 +0100")
References: <20240620160324.109058-1-Jonathan.Cameron@huawei.com>
Date: Fri, 21 Jun 2024 11:25:44 +0800
Message-ID: <87jzij0yfb.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Hi, Jonathan,

Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:

> v3: Thanks to Richard for help debugging BE issue and to Igor for
>     finding a bunch of other thing to improve via the context in
>     the fix patch.
>     
> - Fix the big endian host/little endian guest issue in the HID being
>   written to the Generic Port Affinity Structure ACPI Device Handle.
> - Fix a bug in the ordering of bus vs devfn in the BDF field which is
>   reversed in the ACPI table wrt to QEMU's internal handling. Note the
>   fix is minimal and refactored later in the series.
> - Move original GI code to hw/acpi/aml-build.c and hw/acpi/pc.c as
>   no need for a separate file and this keeps the SRAT entry building
>   all in one place.
> - Use properties for the pci bus number and the ACPI UID to avoid
>   using pci internal implementation details in hw/acpi.
> - Drop the GenericNode base object as much less code is unified with
>   the new approach to the aml building and that approach did not bring
>   sufficient advantages to be worthwhile after other refactors.
>   A little more duplication occurs in v3 but the code is easier to read.
>
> ACPI 6.5 introduced Generic Port Affinity Structures to close a system
> description gap that was a problem for CXL memory systems.
> It defines an new SRAT Affinity structure (and hence allows creation of an
> ACPI Proximity Node which can only be defined via an SRAT structure)
> for the boundary between a discoverable fabric and a non discoverable
> system interconnects etc.
>
> The HMAT data on latency and bandwidth is combined with discoverable
> information from the CXL bus (link speeds, lane counts) and CXL devices
> (switch port to port characteristics and USP to memory, via CDAT tables
> read from the device).  QEMU has supported the rest of the elements
> of this chain for a while but now the kernel has caught up and we need
> the missing element of Generic Ports (this code has been used extensively
> in testing and debugging that kernel support, some resulting fixes
> currently under review).
>
> Generic Port Affinity Structures are very similar to the recently
> added Generic Initiator Affinity Structures (GI) so this series
> factors out and reuses much of that infrastructure for reuse
> There are subtle differences (beyond the obvious structure ID change).
>
> - The ACPI spec example (and linux kernel support) has a Generic
>   Port not as associated with the CXL root port, but rather with
>   the CXL Host bridge. As a result, an ACPI handle is used (rather
>   than the PCI SBDF option for GIs). In QEMU the easiest way
>   to get to this is to target the root bridge PCI Bus, and
>   conveniently the root bridge bus number is used for the UID allowing
>   us to construct an appropriate entry.
>
> A key addition of this series is a complex NUMA topology example that
> stretches the QEMU emulation code for GI, GP and nodes with just
> CPUS, just memory, just hot pluggable memory, mixture of memory and CPUs.
>
> A similar test showed up a few NUMA related bugs with fixes applied for
> 9.0 (note that one of these needs linux booted to identify that it
> rejects the HMAT table and this test is a regression test for the
> table generation only).
>
> https://lore.kernel.org/qemu-devel/2eb6672cfdaea7dacd8e9bb0523887f13b9f85ce.1710282274.git.mst@redhat.com/
> https://lore.kernel.org/qemu-devel/74e2845c5f95b0c139c79233ddb65bb17f2dd679.1710282274.git.mst@redhat.com/

When developing the Linux kernel patchset "[PATCH v3 0/3] cxl/region:
Support to calculate memory tier abstract distance" as in [1].

[1] https://lore.kernel.org/linux-cxl/20240618084639.1419629-1-ying.huang@intel.com/

I use this patchset to test my kernel patchset and it works great!
Thanks!

Feel free to add my

Tested-by: "Huang, Ying" <ying.huang@intel.com>

in the future versions.

>
> Jonathan Cameron (11):
>   hw/acpi: Fix ordering of BDF in Generic Initiator PCI Device Handle.
>   hw/acpi/GI: Fix trivial parameter alignment issue.
>   hw/acpi: Move AML building code for Generic Initiators to aml_build.c
>   hw/acpi: Rename build_all_acpi_generic_initiators() to
>     build_acpi_generic_initiator()
>   hw/pci: Add a bus property to pci_props and use for acpi/gi
>   acpi/pci: Move Generic Initiator object handling into acpi/pci.*
>   hw/pci-bridge: Add acpi_uid property to CXL PXB
>   hw/acpi: Generic Port Affinity Structure support
>   bios-tables-test: Allow for new acpihmat-generic-x test data.
>   bios-tables-test: Add complex SRAT / HMAT test for GI GP
>   bios-tables-test: Add data for complex numa test (GI, GP etc)
>
>  qapi/qom.json                               |  34 +++
>  include/hw/acpi/acpi_generic_initiator.h    |  30 +--
>  include/hw/acpi/aml-build.h                 |   8 +
>  include/hw/acpi/pci.h                       |   7 +
>  include/hw/pci/pci_bridge.h                 |   1 +
>  hw/acpi/acpi_generic_initiator.c            | 132 +++++++++---
>  hw/acpi/aml-build.c                         |  84 ++++++++
>  hw/acpi/pci.c                               | 226 ++++++++++++++++++++
>  hw/arm/virt-acpi-build.c                    |   3 +-
>  hw/i386/acpi-build.c                        |   3 +-
>  hw/pci-bridge/pci_expander_bridge.c         |  18 +-
>  hw/pci/pci.c                                |  14 ++
>  tests/qtest/bios-tables-test.c              |  96 +++++++++
>  hw/acpi/meson.build                         |   1 -
>  tests/data/acpi/q35/APIC.acpihmat-generic-x | Bin 0 -> 136 bytes
>  tests/data/acpi/q35/CEDT.acpihmat-generic-x | Bin 0 -> 68 bytes
>  tests/data/acpi/q35/DSDT.acpihmat-generic-x | Bin 0 -> 10849 bytes
>  tests/data/acpi/q35/HMAT.acpihmat-generic-x | Bin 0 -> 360 bytes
>  tests/data/acpi/q35/SRAT.acpihmat-generic-x | Bin 0 -> 520 bytes
>  19 files changed, 597 insertions(+), 60 deletions(-)
>  create mode 100644 tests/data/acpi/q35/APIC.acpihmat-generic-x
>  create mode 100644 tests/data/acpi/q35/CEDT.acpihmat-generic-x
>  create mode 100644 tests/data/acpi/q35/DSDT.acpihmat-generic-x
>  create mode 100644 tests/data/acpi/q35/HMAT.acpihmat-generic-x
>  create mode 100644 tests/data/acpi/q35/SRAT.acpihmat-generic-x

--
Best Regards,
Huang, Ying
