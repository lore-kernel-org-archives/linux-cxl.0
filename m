Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A5F79D2;
	Mon, 12 May 2025 23:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747093799; cv=none; b=ZQd4H4Ron/T9UAbssie4Y+t2nUwRyzwYNxS3qLyKElPRdy2Xeko9c8wbVc37fADZvma2500wfLltIsWp1D9eNQ477CUOMOmTJItHdKIx+7zzAEqnMuOX5eLvrvj0ad6xnaR3cjgziHheQSnkgvrzGNW+pzafyUyy1kRQT0FAf/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747093799; c=relaxed/simple;
	bh=3+RRuoMZRzW/nRhChWf3KKdctkQcViu85pNf+VNczng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KfJlggKHwgZwpZsXmFWsKFeLRRiHccCOeAtpFvyn077H8iure1urID3XzHxMYC+79BIkJIBZzGUgbtPVo+ZHXBt5oQb/PD2s1kVqNJ90LuKBlnxKhs/yjNOZI3UpY3mOM0EjAs+ijhWltCg+uoMjLjXKYCUhfHl603GXEKwqeJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=isBvFsiU; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="isBvFsiU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747093797; x=1778629797;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3+RRuoMZRzW/nRhChWf3KKdctkQcViu85pNf+VNczng=;
  b=isBvFsiU/vaxVAmBkUV4KV3Iw2v4pgY0qW7W2/XBF/WqxJNy+HOyUIu+
   vecs9+Y01GUB9n6YmFfZ4EO/E7EsQdnTfAg1gpr5RdlhnjZaxUqr7UmNo
   7b9EG0yI18sHUScvY1r8F4o0RwFTe/HL/EpYCrk2is+3Ue3C5lIOfJTtZ
   A+FiOUWM7UG92qDuUqYq638UO9pAvgLzjJdVjINMgarnnoiJQpW3quxki
   Wls5ruEM3cLRBWKpgEq3r9eCN7m4vF4elp7s6GwmPhvbzS2ixyGhha1F9
   1eQuCogMRxg7OWbhDRxYqZK1Wmddyu6lc1mLCjcZIk+4xGREM5Bh4T1BK
   Q==;
X-CSE-ConnectionGUID: wUAbV1p8TkG5Sc4VEYFFQA==
X-CSE-MsgGUID: qChjVWWKS0K44UL4TprAQg==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="48166272"
X-IronPort-AV: E=Sophos;i="6.15,283,1739865600"; 
   d="scan'208";a="48166272"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 16:49:55 -0700
X-CSE-ConnectionGUID: nVRfudQZTc+NvsR1uZuKGQ==
X-CSE-MsgGUID: RvKNHJ3dTkKm9K5e7u2hmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,283,1739865600"; 
   d="scan'208";a="138480470"
Received: from bjrankin-mobl3.amr.corp.intel.com (HELO [10.124.220.233]) ([10.124.220.233])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 16:49:54 -0700
Message-ID: <f4a0aa50-c0ce-4fb1-9a3f-0c68dd1fe46f@intel.com>
Date: Mon, 12 May 2025 16:49:53 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/17] cxl: docs/platform/acpi reference documentation
To: Gregory Price <gourry@gourry.net>, linux-cxl@vger.kernel.org
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, corbet@lwn.net
References: <20250512162134.3596150-1-gourry@gourry.net>
 <20250512162134.3596150-6-gourry@gourry.net>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250512162134.3596150-6-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/12/25 9:21 AM, Gregory Price wrote:
> Add basic ACPI table information needed to understand the CXL
> driver probe process.
> 
> Signed-off-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  Documentation/driver-api/cxl/index.rst        |  1 +
>  .../driver-api/cxl/platform/acpi.rst          | 76 +++++++++++++++++++
>  .../driver-api/cxl/platform/acpi/cedt.rst     | 62 +++++++++++++++
>  .../driver-api/cxl/platform/acpi/dsdt.rst     | 28 +++++++
>  .../driver-api/cxl/platform/acpi/hmat.rst     | 32 ++++++++
>  .../driver-api/cxl/platform/acpi/slit.rst     | 21 +++++
>  .../driver-api/cxl/platform/acpi/srat.rst     | 44 +++++++++++
>  7 files changed, 264 insertions(+)
>  create mode 100644 Documentation/driver-api/cxl/platform/acpi.rst
>  create mode 100644 Documentation/driver-api/cxl/platform/acpi/cedt.rst
>  create mode 100644 Documentation/driver-api/cxl/platform/acpi/dsdt.rst
>  create mode 100644 Documentation/driver-api/cxl/platform/acpi/hmat.rst
>  create mode 100644 Documentation/driver-api/cxl/platform/acpi/slit.rst
>  create mode 100644 Documentation/driver-api/cxl/platform/acpi/srat.rst
> 
> diff --git a/Documentation/driver-api/cxl/index.rst b/Documentation/driver-api/cxl/index.rst
> index ffa0462ad950..336322dc35a0 100644
> --- a/Documentation/driver-api/cxl/index.rst
> +++ b/Documentation/driver-api/cxl/index.rst
> @@ -26,6 +26,7 @@ that have impacts on each other.  The docs here break up configurations steps.
>     :caption: Platform Configuration
>  
>     platform/bios-and-efi
> +   platform/acpi
>  
>  .. toctree::
>     :maxdepth: 1
> diff --git a/Documentation/driver-api/cxl/platform/acpi.rst b/Documentation/driver-api/cxl/platform/acpi.rst
> new file mode 100644
> index 000000000000..ee7e6bd4c43d
> --- /dev/null
> +++ b/Documentation/driver-api/cxl/platform/acpi.rst
> @@ -0,0 +1,76 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +===========
> +ACPI Tables
> +===========
> +
> +ACPI is the "Advanced Configuration and Power Interface", which is a standard
> +that defines how platforms and OS manage power and configure computer hardware.
> +For the purpose of this theory of operation, when referring to "ACPI" we will
> +usually refer to "ACPI Tables" - which are the way a platform (BIOS/EFI)
> +communicates static configuration information to the operation system.
> +
> +The Following ACPI tables contain *static* configuration and performance data
> +about CXL devices.
> +
> +.. toctree::
> +   :maxdepth: 1
> +
> +   acpi/cedt.rst
> +   acpi/srat.rst
> +   acpi/hmat.rst
> +   acpi/slit.rst
> +   acpi/dsdt.rst
> +
> +The SRAT table may also contain generic port/initiator content that is intended
> +to describe the generic port, but not information about the rest of the path to
> +the endpoint.
> +
> +Linux uses these tables to configure kernel resources for statically configured
> +(by BIOS/EFI) CXL devices, such as:
> +
> +- NUMA nodes
> +- Memory Tiers
> +- NUMA Abstract Distances
> +- SystemRAM Memory Regions
> +- Weighted Interleave Node Weights
> +
> +ACPI Debugging
> +==============
> +
> +The :code:`acpidump -b` command dumps the ACPI tables into binary format.
> +
> +The :code:`iasl -d` command disassembles the files into human readable format.
> +
> +Example :code:`acpidump -b && iasl -d cedt.dat` ::
> +
> +   [000h 0000   4]   Signature : "CEDT"    [CXL Early Discovery Table]
> +
> +Common Issues
> +-------------
> +Most failures described here result in a failure of the driver to surface
> +memory as a DAX device and/or kmem.
> +
> +* CEDT CFMWS targets list UIDs do not match CEDT CHBS UIDs.
> +* CEDT CFMWS targets list UIDs do not match DSDT CXL Host Bridge UIDs.
> +* CEDT CFMWS Restriction Bits are not correct.
> +* CEDT CFMWS Memory regions are poorly aligned.
> +* CEDT CFMWS Memory regions spans a platform memory hole.
> +* CEDT CHBS UIDs do not match DSDT CXL Host Bridge UIDs.
> +* CEDT CHBS Specification version is incorrect.
> +* SRAT is missing regions described in CEDT CFMWS.
> +
> +  * Result: failure to create a NUMA node for the region, or
> +    region is placed in wrong node.
> +
> +* HMAT is missing data for regions described in CEDT CFMWS.
> +
> +  * Result: NUMA node being placed in the wrong memory tier.
> +
> +* SLIT has bad data.
> +
> +  * Result: Lots of performance mechanisms in the kernel will be very unhappy.
> +
> +All of these issues will appear to users as if the driver is failing to
> +support CXL - when in reality they are all the failure of a platform to
> +configure the ACPI tables correctly.
> diff --git a/Documentation/driver-api/cxl/platform/acpi/cedt.rst b/Documentation/driver-api/cxl/platform/acpi/cedt.rst
> new file mode 100644
> index 000000000000..1d9c9d3592dc
> --- /dev/null
> +++ b/Documentation/driver-api/cxl/platform/acpi/cedt.rst
> @@ -0,0 +1,62 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +================================
> +CEDT - CXL Early Discovery Table
> +================================
> +
> +The CXL Early Discovery Table is generated by BIOS to describe the CXL memory
> +regions configured at boot by the BIOS.
> +
> +CHBS
> +====
> +The CXL Host Bridge Structure describes CXL host bridges.  Other than describing
> +device register information, it reports the specific host bridge UID for this
> +host bridge.  These host bridge ID's will be referenced in other tables.
> +
> +Example ::
> +
> +          Subtable Type : 00 [CXL Host Bridge Structure]
> +               Reserved : 00
> +                 Length : 0020
> + Associated host bridge : 00000007    <- Host bridge _UID
> +  Specification version : 00000001
> +               Reserved : 00000000
> +          Register base : 0000010370400000
> +        Register length : 0000000000010000
> +
> +CFMWS
> +=====
> +The CXL Fixed Memory Window structure describes a memory region associated
> +with one or more CXL host bridges (as described by the CHBS).  It additionally
> +describes any inter-host-bridge interleave configuration that may have been
> +programmed by BIOS.
> +
> +Example ::
> +
> +            Subtable Type : 01 [CXL Fixed Memory Window Structure]
> +                 Reserved : 00
> +                   Length : 002C
> +                 Reserved : 00000000
> +      Window base address : 000000C050000000   <- Memory Region
> +              Window size : 0000003CA0000000
> + Interleave Members (2^n) : 01                 <- Interleave configuration
> +    Interleave Arithmetic : 00
> +                 Reserved : 0000
> +              Granularity : 00000000
> +             Restrictions : 0006
> +                    QtgId : 0001
> +             First Target : 00000007           <- Host Bridge _UID
> +              Next Target : 00000006           <- Host Bridge _UID
> +
> +The restriction field dictates what this SPA range may be used for (memory type,
> +voltile vs persistent, etc). One or more bits may be set. ::
> +
> +  Bit[0]: CXL Type 2 Memory
> +  Bit[1]: CXL Type 3 Memory
> +  Bit[2]: Volatile Memory
> +  Bit[3]: Persistent Memory
> +  Bit[4]: Fixed Config (HPA cannot be re-used)
> +
> +INTRA-host-bridge interleave (multiple devices on one host bridge) is NOT
> +reported in this structure, and is solely defined via CXL device decoder
> +programming (host bridge and endpoint decoders).
> diff --git a/Documentation/driver-api/cxl/platform/acpi/dsdt.rst b/Documentation/driver-api/cxl/platform/acpi/dsdt.rst
> new file mode 100644
> index 000000000000..b4583b01d67d
> --- /dev/null
> +++ b/Documentation/driver-api/cxl/platform/acpi/dsdt.rst
> @@ -0,0 +1,28 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +==============================================
> +DSDT - Differentiated system Description Table
> +==============================================
> +
> +This table describes what peripherals a machine has.
> +
> +This table's UIDs for CXL devices - specifically host bridges, must be
> +consistent with the contents of the CEDT, otherwise the CXL driver will
> +fail to probe correctly.
> +
> +Example Compute Express Link Host Bridge ::
> +
> +    Scope (_SB)
> +    {
> +        Device (S0D0)
> +        {
> +            Name (_HID, "ACPI0016" /* Compute Express Link Host Bridge */)  // _HID: Hardware ID
> +            Name (_CID, Package (0x02)  // _CID: Compatible ID
> +            {
> +                EisaId ("PNP0A08") /* PCI Express Bus */,
> +                EisaId ("PNP0A03") /* PCI Bus */
> +            })
> +            ...
> +            Name (_UID, 0x05)  // _UID: Unique ID
> +            ...
> +      }
> diff --git a/Documentation/driver-api/cxl/platform/acpi/hmat.rst b/Documentation/driver-api/cxl/platform/acpi/hmat.rst
> new file mode 100644
> index 000000000000..095a26f02a37
> --- /dev/null
> +++ b/Documentation/driver-api/cxl/platform/acpi/hmat.rst
> @@ -0,0 +1,32 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +===========================================
> +HMAT - Heterogeneous Memory Attribute Table
> +===========================================
> +
> +The Heterogeneous Memory Attributes Table contains information such as cache
> +attributes and bandwidth and latency details for memory proximity domains.
> +For the purpose of this document, we will only discuss the SSLIB entry.
> +
> +SLLBI
> +=====
> +The System Locality Latency and Bandwidth Information records latency and
> +bandwidth information for proximity domains.
> +
> +This table is used by Linux to configure interleave weights and memory tiers.
> +
> +Example (Heavily truncated for brevity) ::
> +
> +               Structure Type : 0001 [SLLBI]
> +                    Data Type : 00         <- Latency
> + Target Proximity Domain List : 00000000
> + Target Proximity Domain List : 00000001
> +                        Entry : 0080       <- DRAM LTC
> +                        Entry : 0100       <- CXL LTC
> +
> +               Structure Type : 0001 [SLLBI]
> +                    Data Type : 03         <- Bandwidth
> + Target Proximity Domain List : 00000000
> + Target Proximity Domain List : 00000001
> +                        Entry : 1200       <- DRAM BW
> +                        Entry : 0200       <- CXL BW
> diff --git a/Documentation/driver-api/cxl/platform/acpi/slit.rst b/Documentation/driver-api/cxl/platform/acpi/slit.rst
> new file mode 100644
> index 000000000000..a56768e8fe41
> --- /dev/null
> +++ b/Documentation/driver-api/cxl/platform/acpi/slit.rst
> @@ -0,0 +1,21 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +========================================
> +SLIT - System Locality Information Table
> +========================================
> +
> +The system locality information table provides "abstract distances" between
> +accessor and memory nodes.  Node without initiators (cpus) are infinitely (FF)
> +distance away from all other nodes.
> +
> +The abstract distance described in this table does not describe any real
> +latency of bandwidth information.
> +
> +Example ::
> +
> +    Signature : "SLIT"    [System Locality Information Table]
> +   Localities : 0000000000000004
> + Locality   0 : 10 20 20 30
> + Locality   1 : 20 10 30 20
> + Locality   2 : FF FF 0A FF
> + Locality   3 : FF FF FF 0A
> diff --git a/Documentation/driver-api/cxl/platform/acpi/srat.rst b/Documentation/driver-api/cxl/platform/acpi/srat.rst
> new file mode 100644
> index 000000000000..56d7bbb18c3b
> --- /dev/null
> +++ b/Documentation/driver-api/cxl/platform/acpi/srat.rst
> @@ -0,0 +1,44 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=====================================
> +SRAT - Static Resource Affinity Table
> +=====================================
> +
> +The System/Static Resource Affinity Table describes resource (CPU, Memory)
> +affinity to "Proximity Domains". This table is technically optional, but for
> +performance information (see "HMAT") to be enumerated by linux it must be
> +present.
> +
> +There is a careful dance between the CEDT and SRAT tables and how NUMA nodes are
> +created.  If things don't look quite the way you expect - check the SRAT Memory
> +Affinity entries and CEDT CFMWS to determine what your platform actually
> +supports in terms of flexible topologies.
> +
> +The SRAT may statically assign portions of a CFMWS SPA range to a specific
> +proximity domains.  See linux numa creation for more information about how
> +this presents in the NUMA topology.
> +
> +Proximity Domain
> +================
> +A proximity domain is ROUGHLY equivalent to "NUMA Node" - though a 1-to-1
> +mapping is not guaranteed.  There are scenarios where "Proximity Domain 4" may
> +map to "NUMA Node 3", for example.  (See "NUMA Node Creation")
> +
> +Memory Affinity
> +===============
> +Generally speaking, if a host does any amount of CXL fabric (decoder)
> +programming in BIOS - an SRAT entry for that memory needs to be present.
> +
> +Example ::
> +
> +         Subtable Type : 01 [Memory Affinity]
> +                Length : 28
> +      Proximity Domain : 00000001          <- NUMA Node 1
> +             Reserved1 : 0000
> +          Base Address : 000000C050000000  <- Physical Memory Region
> +        Address Length : 0000003CA0000000
> +             Reserved2 : 00000000
> + Flags (decoded below) : 0000000B
> +              Enabled : 1
> +        Hot Pluggable : 1
> +         Non-Volatile : 0

