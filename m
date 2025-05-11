Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C678E224FA;
	Sun, 11 May 2025 02:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746928946; cv=none; b=G8Ehk/IL1e2DfL5Q0+qf1WZ7e/Wuq7TyweWhjNI5guWKoBSpdmRQQTB4EGf3Ko1DvYvWYhqpAWRXRZFBKLBpF0/Amak83xrUnLovhB6fka84grcRBlSPgR/pimv1xpXmOSkiyGFv/U8Oh5hb5afvFKNQGHhzt1WDZ9u+JQoaNb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746928946; c=relaxed/simple;
	bh=byrn8Ac675XH8osN2cVPyvpe2PxHP47HjxBh76Nif4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UNCpjZ9zHhB7DHrRBPBtCLsd6UGvyUoXQ2rmTwFGRNtroz42Ko7f0JGeCaKRTsWxmhRZCveyVPxZoPf/LHhmPK71kF0wCMJgXpgGXaNtJg3WBu8fIEJ/V8tP5lWJIQ0u9g7W0o1OdR1O2ESnEe9n0yJbsp/IOzTaFTBzk3DRjjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=d7DAAY9F; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d7DAAY9F"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=LbnZqWbq1K7LGPTTf1882BwsFZA/mB3ydNLKf3ebTOM=; b=d7DAAY9FBAzpW2RWxPqy2dhY9K
	LUJGtmOj4CJOgXEUU2qFiC1NX+Il8ZFImGiqnuIg8GxVe0Y0pU3JnaDvDTxQcdarMXVNYzSpCReOM
	+h9sV20jepZD60wjEwfOjOlJk4gpsJovaCW8JuGLB7xQ/keLZ1VsNfA0NwUYP9gj8nYAOsv3roXjL
	qiB7zPOUOO6/9dvHHIPK01HMAgbhkMZe0aR5lqnLa1Jtr24SiWrb9DgIydML94n9KMLwGpGOuBygU
	XA+UNbtj5g8jKOKPPHHD2OtckWrL3BaLWvS4ml7r43Aoe6xXBKR6D6xsXkWzHkQnYoWXz20+KsKk2
	VIQs7pDg==;
Received: from [50.39.124.201] (helo=[192.168.254.17])
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1uDw1B-0000000GXKD-0t7W;
	Sun, 11 May 2025 02:02:19 +0000
Message-ID: <9b837087-c035-45de-baab-9b78aa29f576@infradead.org>
Date: Sat, 10 May 2025 19:02:12 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 04/18] cxl: docs/platform/acpi reference
 documentation
To: Gregory Price <gourry@gourry.net>, linux-cxl@vger.kernel.org
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 ira.weiny@intel.com, dan.j.williams@intel.com, corbet@lwn.net
References: <20250430181048.1197475-1-gourry@gourry.net>
 <20250430181048.1197475-5-gourry@gourry.net>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250430181048.1197475-5-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/30/25 11:10 AM, Gregory Price wrote:
> Add basic ACPI table information needed to understand the CXL
> driver probe process.
> 
> Signed-off-by: Gregory Price <gourry@gourry.net>
> ---
>  Documentation/driver-api/cxl/index.rst        |  1 +
>  .../driver-api/cxl/platform/acpi.rst          | 76 +++++++++++++++++++
>  .../driver-api/cxl/platform/acpi/cedt.rst     | 53 +++++++++++++
>  .../driver-api/cxl/platform/acpi/dsdt.rst     | 28 +++++++
>  .../driver-api/cxl/platform/acpi/hmat.rst     | 29 +++++++
>  .../driver-api/cxl/platform/acpi/slit.rst     | 18 +++++
>  .../driver-api/cxl/platform/acpi/srat.rst     | 38 ++++++++++
>  7 files changed, 243 insertions(+)
>  create mode 100644 Documentation/driver-api/cxl/platform/acpi.rst
>  create mode 100644 Documentation/driver-api/cxl/platform/acpi/cedt.rst
>  create mode 100644 Documentation/driver-api/cxl/platform/acpi/dsdt.rst
>  create mode 100644 Documentation/driver-api/cxl/platform/acpi/hmat.rst
>  create mode 100644 Documentation/driver-api/cxl/platform/acpi/slit.rst
>  create mode 100644 Documentation/driver-api/cxl/platform/acpi/srat.rst
> 
> diff --git a/Documentation/driver-api/cxl/index.rst b/Documentation/driver-api/cxl/index.rst
> index b8f82cdf1435..5e5699803d4c 100644
> --- a/Documentation/driver-api/cxl/index.rst
> +++ b/Documentation/driver-api/cxl/index.rst
> @@ -27,6 +27,7 @@ that have impacts on each other.  The docs here break up configurations steps.
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
> index 000000000000..c8f904603fc6
> --- /dev/null
> +++ b/Documentation/driver-api/cxl/platform/acpi/cedt.rst
> @@ -0,0 +1,53 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +================================
> +CEDT - CXL Early Discovery Table
> +================================
> +
> +The CXL Early Discovery Table is generated by BIOS to describe the CXL memory regions configured at boot by the BIOS.
> +
> +CHBS
> +====
> +The CXL Host Bridge Structure describes CXL host bridges.  Other than describing device register information, it reports the specific host bridge UID for this host bridge.  These host bridge ID's will be referenced in other tables.

We still try to limit doc (.rst) files to line length <= 80 when possible, please.

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
> +The CXL Fixed Memory Window structure describes a memory region associated with one or more CXL host bridges (as described by the CHBS).  It additionally describes any inter-host-bridge interleave configuration that may have been programmed by BIOS.

Ditto.

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
> +The restriction field dictates what this SPA range may be used for (memory type, voltile vs persistent, etc). One or more bits may be set. ::

Ditto.

> +
> +  Bit[0]: CXL Type 2 Memory
> +  Bit[1]: CXL Type 3 Memory
> +  Bit[2]: Volatile Memory
> +  Bit[3]: Persistent Memory
> +  Bit[4]: Fixed Config (HPA cannot be re-used)
> +
> +INTRA-host-bridge interleave (multiple devices on one host bridge) is NOT reported in this structure, and is solely defined via CXL device decoder programming (host bridge and endpoint decoders).

Ditto.

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
> index 000000000000..a6a6ec9f2a32
> --- /dev/null
> +++ b/Documentation/driver-api/cxl/platform/acpi/hmat.rst
> @@ -0,0 +1,29 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +===========================================
> +HMAT - Heterogeneous Memory Attribute Table
> +===========================================
> +
> +The Heterogeneous Memory Attributes Table contains information such as cache attributes and bandwidth and latency details for memory proximity domains.  For the purpose of this document, we will only discuss the SSLIB entry.

Ditto.

> +
> +SLLBI
> +=====
> +The System Locality Latency and Bandwidth Information records latency and bandwidth information for proximity domains.

Same.

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
> index 000000000000..8fd61b40a66c
> --- /dev/null
> +++ b/Documentation/driver-api/cxl/platform/acpi/slit.rst
> @@ -0,0 +1,18 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +========================================
> +SLIT - System Locality Information Table
> +========================================
> +
> +The system locality information table provides "abstract distances" between accessor and memory nodes.  Node without initiators (cpus) are infinitely (FF) distance away from all other nodes.

Same.

> +
> +The abstract distance described in this table does not describe any real latency of bandwidth information.

Same.

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
> index 000000000000..552a70969769
> --- /dev/null
> +++ b/Documentation/driver-api/cxl/platform/acpi/srat.rst
> @@ -0,0 +1,38 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=====================================
> +SRAT - Static Resource Affinity Table
> +=====================================
> +

Same here:

> +The System/Static Resource Affinity Table describes resource (CPU, Memory) affinity to "Proximity Domains". This table is technically optional, but for performance information (see "HMAT") to be enumerated by linux it must be present.
> +
> +There is a careful dance between the CEDT and SRAT tables and how NUMA nodes are created.  If things don't look quite the way you expect - check the SRAT Memory Affinity entries and CEDT CFMWS to determine what your platform actually supports in terms of flexible topologies.
> +
> +The SRAT may statically assign portions of a CFMWS SPA range to a specific proximity domains.  See linux numa creation for more information about how this presents in the NUMA topology.
> +
> +Proximity Domain
> +================
> +A proximity domain is ROUGHLY equivalent to "NUMA Node" - though a 1-to-1 mapping is not guaranteed.  There are scenarios where "Proximity Domain 4" may map to "NUMA Node 3", for example.  (See "NUMA Node Creation")
> +
> +Memory Affinity
> +===============
> +Generally speaking, if a host does any amount of CXL fabric (decoder) programming in BIOS - an SRAT entry for that memory needs to be present.
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
> +
> +Generic Initiator / Port
> +========================
> +
> +todo

-- 
~Randy

