Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD587E571;
	Tue, 13 May 2025 00:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747094821; cv=none; b=LK5KsaiVYUmujLN1DLNRAMPlvz5IA+zwVur9TToSIjEPiAQidM9moaZxS7z3DR7kwaHgO88DBKMkD8pL8eXFbLDZw6yHjPXvX9FFf7mZhrvCUtRTyVHF/KWIk2NeCznfrrnSBr+P5XGh++yx8RwrWDMkCLyYk/bGndguBge9c00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747094821; c=relaxed/simple;
	bh=+VQ0wmtyeYsSG5oaxBcEeZJlBZKC9hen8ExVWEztkgc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QcS2UJ7jZM4sUbSIVXRy034nzDDWDNfjBtGvCoIA1d3QZ42xhlWOC9O0cyDWTaBzi62CSFMLnQ+6pFT8R5KR7c9OtzdLQv80S2aFryNsowNmntZZLOy8Oup1k2Vf9ma2JKpg6uZTNEYChqR9IXq60xSbRiL5HNtrkoSN8rb+/Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IQvGxLAf; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IQvGxLAf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747094819; x=1778630819;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+VQ0wmtyeYsSG5oaxBcEeZJlBZKC9hen8ExVWEztkgc=;
  b=IQvGxLAfOINcdG7BUhyrU7loovoK69jVrnelv2Pd9kZGEkBfDAtkxOLH
   MdwoP2iDo6apVZFOknD/D4oRPj029sUbVPTNAtr4ERif0H1zsza251Kwe
   0Os+0eDc23EIGF6qFiI9DU6hlMYbxDkRbeTRd7HPiSg/sPSCjOdY6j7Uh
   aOqhy7acHXVPJ2Jo6GM5L2tX3Q19WR9uXuJkpOWjkgBB9C1/GgoKTyLTF
   1qdg/LgaB14o6fOdHARgSYVSNMTL/wwTUtiDWaw0d5kod0+2WyjY1hqEc
   j6r3SOy6wPcw99wCpJkRIJYGjoTX7ikNe3W/E8QGbv/6M0C5TxZhCb2dL
   Q==;
X-CSE-ConnectionGUID: qy4v4xPIR2y2bhw9AaZUiQ==
X-CSE-MsgGUID: C6HLiAnnQVeyHU+TMtNgmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="48792612"
X-IronPort-AV: E=Sophos;i="6.15,283,1739865600"; 
   d="scan'208";a="48792612"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 17:05:14 -0700
X-CSE-ConnectionGUID: UhxHnWoeSAC42Ci8tQ3qiQ==
X-CSE-MsgGUID: Q7EdIZMiSeWBl2g2GCDzjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,283,1739865600"; 
   d="scan'208";a="168435327"
Received: from bjrankin-mobl3.amr.corp.intel.com (HELO [10.124.220.233]) ([10.124.220.233])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 17:05:14 -0700
Message-ID: <1913b048-1033-4cab-8e7e-119a685794ec@intel.com>
Date: Mon, 12 May 2025 17:05:10 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/17] cxl: docs/platform/example-configs documentation
To: Gregory Price <gourry@gourry.net>, linux-cxl@vger.kernel.org
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, corbet@lwn.net
References: <20250512162134.3596150-1-gourry@gourry.net>
 <20250512162134.3596150-7-gourry@gourry.net>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250512162134.3596150-7-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/12/25 9:21 AM, Gregory Price wrote:
> Add example ACPI Table configurations for different sample platforms.
> 
> Signed-off-by: Gregory Price <gourry@gourry.net>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  Documentation/driver-api/cxl/index.rst        |   1 +
>  .../cxl/platform/example-configs.rst          |  13 +
>  .../example-configurations/flexible.rst       | 296 ++++++++++++++++++
>  .../example-configurations/hb-interleave.rst  | 107 +++++++
>  .../multi-dev-per-hb.rst                      |  90 ++++++
>  .../example-configurations/one-dev-per-hb.rst | 136 ++++++++
>  6 files changed, 643 insertions(+)
>  create mode 100644 Documentation/driver-api/cxl/platform/example-configs.rst
>  create mode 100644 Documentation/driver-api/cxl/platform/example-configurations/flexible.rst
>  create mode 100644 Documentation/driver-api/cxl/platform/example-configurations/hb-interleave.rst
>  create mode 100644 Documentation/driver-api/cxl/platform/example-configurations/multi-dev-per-hb.rst
>  create mode 100644 Documentation/driver-api/cxl/platform/example-configurations/one-dev-per-hb.rst
> 
> diff --git a/Documentation/driver-api/cxl/index.rst b/Documentation/driver-api/cxl/index.rst
> index 336322dc35a0..6a5fb7e00c52 100644
> --- a/Documentation/driver-api/cxl/index.rst
> +++ b/Documentation/driver-api/cxl/index.rst
> @@ -27,6 +27,7 @@ that have impacts on each other.  The docs here break up configurations steps.
>  
>     platform/bios-and-efi
>     platform/acpi
> +   platform/example-configs
>  
>  .. toctree::
>     :maxdepth: 1
> diff --git a/Documentation/driver-api/cxl/platform/example-configs.rst b/Documentation/driver-api/cxl/platform/example-configs.rst
> new file mode 100644
> index 000000000000..90a10d7473c6
> --- /dev/null
> +++ b/Documentation/driver-api/cxl/platform/example-configs.rst
> @@ -0,0 +1,13 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +Example Platform Configurations
> +###############################
> +
> +.. toctree::
> +   :maxdepth: 1
> +   :caption: Contents
> +
> +   example-configurations/one-dev-per-hb.rst
> +   example-configurations/multi-dev-per-hb.rst
> +   example-configurations/hb-interleave.rst
> +   example-configurations/flexible.rst
> diff --git a/Documentation/driver-api/cxl/platform/example-configurations/flexible.rst b/Documentation/driver-api/cxl/platform/example-configurations/flexible.rst
> new file mode 100644
> index 000000000000..e39daba65fa0
> --- /dev/null
> +++ b/Documentation/driver-api/cxl/platform/example-configurations/flexible.rst
> @@ -0,0 +1,296 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=====================
> +Flexible Presentation
> +=====================
> +This system has a single socket with two CXL host bridges. Each host bridge
> +has two CXL memory expanders with a 4GB of memory (32GB total).
> +
> +On this system, the platform designer wanted to provide the user flexibility
> +to configure the memory devices in various interleave or NUMA node
> +configurations.  So they provided every combination.
> +
> +Things to note:
> +
> +* Cross-Bridge interleave is described in one CFMWS that covers all capacity.
> +* One CFMWS is also described per-host bridge.
> +* One CFMWS is also described per-device.
> +* This SRAT describes one node for each of the above CFMWS.
> +* The HMAT describes performance for each node in the SRAT.
> +
> +CEDT ::
> +
> +            Subtable Type : 00 [CXL Host Bridge Structure]
> +                 Reserved : 00
> +                   Length : 0020
> +   Associated host bridge : 00000007
> +    Specification version : 00000001
> +                 Reserved : 00000000
> +            Register base : 0000010370400000
> +          Register length : 0000000000010000
> +
> +            Subtable Type : 00 [CXL Host Bridge Structure]
> +                 Reserved : 00
> +                   Length : 0020
> +   Associated host bridge : 00000006
> +    Specification version : 00000001
> +                 Reserved : 00000000
> +            Register base : 0000010380800000
> +          Register length : 0000000000010000
> +
> +            Subtable Type : 01 [CXL Fixed Memory Window Structure]
> +                 Reserved : 00
> +                   Length : 002C
> +                 Reserved : 00000000
> +      Window base address : 0000001000000000
> +              Window size : 0000000400000000
> + Interleave Members (2^n) : 01
> +    Interleave Arithmetic : 00
> +                 Reserved : 0000
> +              Granularity : 00000000
> +             Restrictions : 0006
> +                    QtgId : 0001
> +             First Target : 00000007
> +            Second Target : 00000006
> +
> +            Subtable Type : 01 [CXL Fixed Memory Window Structure]
> +                 Reserved : 00
> +                   Length : 002C
> +                 Reserved : 00000000
> +      Window base address : 0000002000000000
> +              Window size : 0000000200000000
> + Interleave Members (2^n) : 00
> +    Interleave Arithmetic : 00
> +                 Reserved : 0000
> +              Granularity : 00000000
> +             Restrictions : 0006
> +                    QtgId : 0001
> +             First Target : 00000007
> +
> +            Subtable Type : 01 [CXL Fixed Memory Window Structure]
> +                 Reserved : 00
> +                   Length : 002C
> +                 Reserved : 00000000
> +      Window base address : 0000002200000000
> +              Window size : 0000000200000000
> + Interleave Members (2^n) : 00
> +    Interleave Arithmetic : 00
> +                 Reserved : 0000
> +              Granularity : 00000000
> +             Restrictions : 0006
> +                    QtgId : 0001
> +             First Target : 00000006
> +
> +            Subtable Type : 01 [CXL Fixed Memory Window Structure]
> +                 Reserved : 00
> +                   Length : 002C
> +                 Reserved : 00000000
> +      Window base address : 0000003000000000
> +              Window size : 0000000100000000
> + Interleave Members (2^n) : 00
> +    Interleave Arithmetic : 00
> +                 Reserved : 0000
> +              Granularity : 00000000
> +             Restrictions : 0006
> +                    QtgId : 0001
> +             First Target : 00000007
> +
> +            Subtable Type : 01 [CXL Fixed Memory Window Structure]
> +                 Reserved : 00
> +                   Length : 002C
> +                 Reserved : 00000000
> +      Window base address : 0000003100000000
> +              Window size : 0000000100000000
> + Interleave Members (2^n) : 00
> +    Interleave Arithmetic : 00
> +                 Reserved : 0000
> +              Granularity : 00000000
> +             Restrictions : 0006
> +                    QtgId : 0001
> +             First Target : 00000007
> +
> +            Subtable Type : 01 [CXL Fixed Memory Window Structure]
> +                 Reserved : 00
> +                   Length : 002C
> +                 Reserved : 00000000
> +      Window base address : 0000003200000000
> +              Window size : 0000000100000000
> + Interleave Members (2^n) : 00
> +    Interleave Arithmetic : 00
> +                 Reserved : 0000
> +              Granularity : 00000000
> +             Restrictions : 0006
> +                    QtgId : 0001
> +             First Target : 00000006
> +
> +            Subtable Type : 01 [CXL Fixed Memory Window Structure]
> +                 Reserved : 00
> +                   Length : 002C
> +                 Reserved : 00000000
> +      Window base address : 0000003300000000
> +              Window size : 0000000100000000
> + Interleave Members (2^n) : 00
> +    Interleave Arithmetic : 00
> +                 Reserved : 0000
> +              Granularity : 00000000
> +             Restrictions : 0006
> +                    QtgId : 0001
> +             First Target : 00000006
> +
> +SRAT ::
> +
> +         Subtable Type : 01 [Memory Affinity]
> +                Length : 28
> +      Proximity Domain : 00000001
> +             Reserved1 : 0000
> +          Base Address : 0000001000000000
> +        Address Length : 0000000400000000
> +             Reserved2 : 00000000
> + Flags (decoded below) : 0000000B
> +             Enabled : 1
> +       Hot Pluggable : 1
> +        Non-Volatile : 0
> +
> +         Subtable Type : 01 [Memory Affinity]
> +                Length : 28
> +      Proximity Domain : 00000002
> +             Reserved1 : 0000
> +          Base Address : 0000002000000000
> +        Address Length : 0000000200000000
> +             Reserved2 : 00000000
> + Flags (decoded below) : 0000000B
> +             Enabled : 1
> +       Hot Pluggable : 1
> +        Non-Volatile : 0
> +
> +         Subtable Type : 01 [Memory Affinity]
> +                Length : 28
> +      Proximity Domain : 00000003
> +             Reserved1 : 0000
> +          Base Address : 0000002200000000
> +        Address Length : 0000000200000000
> +             Reserved2 : 00000000
> + Flags (decoded below) : 0000000B
> +             Enabled : 1
> +       Hot Pluggable : 1
> +        Non-Volatile : 0
> +
> +         Subtable Type : 01 [Memory Affinity]
> +                Length : 28
> +      Proximity Domain : 00000004
> +             Reserved1 : 0000
> +          Base Address : 0000003000000000
> +        Address Length : 0000000100000000
> +             Reserved2 : 00000000
> + Flags (decoded below) : 0000000B
> +             Enabled : 1
> +       Hot Pluggable : 1
> +        Non-Volatile : 0
> +
> +         Subtable Type : 01 [Memory Affinity]
> +                Length : 28
> +      Proximity Domain : 00000005
> +             Reserved1 : 0000
> +          Base Address : 0000003100000000
> +        Address Length : 0000000100000000
> +             Reserved2 : 00000000
> + Flags (decoded below) : 0000000B
> +             Enabled : 1
> +       Hot Pluggable : 1
> +        Non-Volatile : 0
> +
> +         Subtable Type : 01 [Memory Affinity]
> +                Length : 28
> +      Proximity Domain : 00000006
> +             Reserved1 : 0000
> +          Base Address : 0000003200000000
> +        Address Length : 0000000100000000
> +             Reserved2 : 00000000
> + Flags (decoded below) : 0000000B
> +             Enabled : 1
> +       Hot Pluggable : 1
> +        Non-Volatile : 0
> +
> +         Subtable Type : 01 [Memory Affinity]
> +                Length : 28
> +      Proximity Domain : 00000007
> +             Reserved1 : 0000
> +          Base Address : 0000003300000000
> +        Address Length : 0000000100000000
> +             Reserved2 : 00000000
> + Flags (decoded below) : 0000000B
> +             Enabled : 1
> +       Hot Pluggable : 1
> +        Non-Volatile : 0
> +
> +HMAT ::
> +
> +               Structure Type : 0001 [SLLBI]
> +                    Data Type : 00   [Latency]
> + Target Proximity Domain List : 00000000
> + Target Proximity Domain List : 00000001
> + Target Proximity Domain List : 00000002
> + Target Proximity Domain List : 00000003
> + Target Proximity Domain List : 00000004
> + Target Proximity Domain List : 00000005
> + Target Proximity Domain List : 00000006
> + Target Proximity Domain List : 00000007
> +                        Entry : 0080
> +                        Entry : 0100
> +                        Entry : 0100
> +                        Entry : 0100
> +                        Entry : 0100
> +                        Entry : 0100
> +                        Entry : 0100
> +                        Entry : 0100
> +
> +               Structure Type : 0001 [SLLBI]
> +                    Data Type : 03   [Bandwidth]
> + Target Proximity Domain List : 00000000
> + Target Proximity Domain List : 00000001
> + Target Proximity Domain List : 00000002
> + Target Proximity Domain List : 00000003
> + Target Proximity Domain List : 00000004
> + Target Proximity Domain List : 00000005
> + Target Proximity Domain List : 00000006
> + Target Proximity Domain List : 00000007
> +                        Entry : 1200
> +                        Entry : 0400
> +                        Entry : 0200
> +                        Entry : 0200
> +                        Entry : 0100
> +                        Entry : 0100
> +                        Entry : 0100
> +                        Entry : 0100
> +
> +SLIT ::
> +
> +     Signature : "SLIT"    [System Locality Information Table]
> +    Localities : 0000000000000003
> +  Locality   0 : 10 20 20 20 20 20 20 20
> +  Locality   1 : FF 0A FF FF FF FF FF FF
> +  Locality   2 : FF FF 0A FF FF FF FF FF
> +  Locality   3 : FF FF FF 0A FF FF FF FF
> +  Locality   4 : FF FF FF FF 0A FF FF FF
> +  Locality   5 : FF FF FF FF FF 0A FF FF
> +  Locality   6 : FF FF FF FF FF FF 0A FF
> +  Locality   7 : FF FF FF FF FF FF FF 0A
> +
> +DSDT ::
> +
> +  Scope (_SB)
> +  {
> +    Device (S0D0)
> +    {
> +        Name (_HID, "ACPI0016" /* Compute Express Link Host Bridge */)  // _HID: Hardware ID
> +        ...
> +        Name (_UID, 0x07)  // _UID: Unique ID
> +    }
> +    ...
> +    Device (S0D5)
> +    {
> +        Name (_HID, "ACPI0016" /* Compute Express Link Host Bridge */)  // _HID: Hardware ID
> +        ...
> +        Name (_UID, 0x06)  // _UID: Unique ID
> +    }
> +  }
> diff --git a/Documentation/driver-api/cxl/platform/example-configurations/hb-interleave.rst b/Documentation/driver-api/cxl/platform/example-configurations/hb-interleave.rst
> new file mode 100644
> index 000000000000..ce07e6162f26
> --- /dev/null
> +++ b/Documentation/driver-api/cxl/platform/example-configurations/hb-interleave.rst
> @@ -0,0 +1,107 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +============================
> +Cross-Host-Bridge Interleave
> +============================
> +This system has a single socket with two CXL host bridges. Each host bridge
> +has a single CXL memory expander with a 4GB of memory.
> +
> +Things to note:
> +
> +* Cross-Bridge interleave is described.
> +* The expanders are described by a single CFMWS.
> +* This SRAT describes one node for both host bridges.
> +* The HMAT describes a single node's performance.
> +
> +CEDT ::
> +
> +            Subtable Type : 00 [CXL Host Bridge Structure]
> +                 Reserved : 00
> +                   Length : 0020
> +   Associated host bridge : 00000007
> +    Specification version : 00000001
> +                 Reserved : 00000000
> +            Register base : 0000010370400000
> +          Register length : 0000000000010000
> +
> +            Subtable Type : 00 [CXL Host Bridge Structure]
> +                 Reserved : 00
> +                   Length : 0020
> +   Associated host bridge : 00000006
> +    Specification version : 00000001
> +                 Reserved : 00000000
> +            Register base : 0000010380800000
> +          Register length : 0000000000010000
> +
> +            Subtable Type : 01 [CXL Fixed Memory Window Structure]
> +                 Reserved : 00
> +                   Length : 002C
> +                 Reserved : 00000000
> +      Window base address : 0000001000000000
> +              Window size : 0000000200000000
> + Interleave Members (2^n) : 01
> +    Interleave Arithmetic : 00
> +                 Reserved : 0000
> +              Granularity : 00000000
> +             Restrictions : 0006
> +                    QtgId : 0001
> +             First Target : 00000007
> +            Second Target : 00000006
> +
> +SRAT ::
> +
> +         Subtable Type : 01 [Memory Affinity]
> +                Length : 28
> +      Proximity Domain : 00000001
> +             Reserved1 : 0000
> +          Base Address : 0000001000000000
> +        Address Length : 0000000200000000
> +             Reserved2 : 00000000
> + Flags (decoded below) : 0000000B
> +             Enabled : 1
> +       Hot Pluggable : 1
> +        Non-Volatile : 0
> +
> +HMAT ::
> +
> +               Structure Type : 0001 [SLLBI]
> +                    Data Type : 00   [Latency]
> + Target Proximity Domain List : 00000000
> + Target Proximity Domain List : 00000001
> + Target Proximity Domain List : 00000002
> +                        Entry : 0080
> +                        Entry : 0100
> +
> +               Structure Type : 0001 [SLLBI]
> +                    Data Type : 03   [Bandwidth]
> + Target Proximity Domain List : 00000000
> + Target Proximity Domain List : 00000001
> + Target Proximity Domain List : 00000002
> +                        Entry : 1200
> +                        Entry : 0400
> +
> +SLIT ::
> +
> +     Signature : "SLIT"    [System Locality Information Table]
> +    Localities : 0000000000000003
> +  Locality   0 : 10 20
> +  Locality   1 : FF 0A
> +
> +DSDT ::
> +
> +  Scope (_SB)
> +  {
> +    Device (S0D0)
> +    {
> +        Name (_HID, "ACPI0016" /* Compute Express Link Host Bridge */)  // _HID: Hardware ID
> +        ...
> +        Name (_UID, 0x07)  // _UID: Unique ID
> +    }
> +    ...
> +    Device (S0D5)
> +    {
> +        Name (_HID, "ACPI0016" /* Compute Express Link Host Bridge */)  // _HID: Hardware ID
> +        ...
> +        Name (_UID, 0x06)  // _UID: Unique ID
> +    }
> +  }
> diff --git a/Documentation/driver-api/cxl/platform/example-configurations/multi-dev-per-hb.rst b/Documentation/driver-api/cxl/platform/example-configurations/multi-dev-per-hb.rst
> new file mode 100644
> index 000000000000..6adf7c639490
> --- /dev/null
> +++ b/Documentation/driver-api/cxl/platform/example-configurations/multi-dev-per-hb.rst
> @@ -0,0 +1,90 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +================================
> +Multiple Devices per Host Bridge
> +================================
> +
> +In this example system we will have a single socket and one CXL host bridge.
> +There are two CXL memory expanders with 4GB attached to the host bridge.
> +
> +Things to note:
> +
> +* Intra-Bridge interleave is not described here.
> +* The expanders are described by a single CEDT/CFMWS.
> +* This CEDT/SRAT describes one node for both devices.
> +* There is only one proximity domain the HMAT for both devices.
> +
> +CEDT ::
> +
> +            Subtable Type : 00 [CXL Host Bridge Structure]
> +                 Reserved : 00
> +                   Length : 0020
> +   Associated host bridge : 00000007
> +    Specification version : 00000001
> +                 Reserved : 00000000
> +            Register base : 0000010370400000
> +          Register length : 0000000000010000
> +
> +            Subtable Type : 01 [CXL Fixed Memory Window Structure]
> +                 Reserved : 00
> +                   Length : 002C
> +                 Reserved : 00000000
> +      Window base address : 0000001000000000
> +              Window size : 0000000200000000
> + Interleave Members (2^n) : 00
> +    Interleave Arithmetic : 00
> +                 Reserved : 0000
> +              Granularity : 00000000
> +             Restrictions : 0006
> +                    QtgId : 0001
> +             First Target : 00000007
> +
> +SRAT ::
> +
> +         Subtable Type : 01 [Memory Affinity]
> +                Length : 28
> +      Proximity Domain : 00000001
> +             Reserved1 : 0000
> +          Base Address : 0000001000000000
> +        Address Length : 0000000200000000
> +             Reserved2 : 00000000
> + Flags (decoded below) : 0000000B
> +             Enabled : 1
> +       Hot Pluggable : 1
> +        Non-Volatile : 0
> +
> +HMAT ::
> +
> +               Structure Type : 0001 [SLLBI]
> +                    Data Type : 00   [Latency]
> + Target Proximity Domain List : 00000000
> + Target Proximity Domain List : 00000001
> +                        Entry : 0080
> +                        Entry : 0100
> +
> +               Structure Type : 0001 [SLLBI]
> +                    Data Type : 03   [Bandwidth]
> + Target Proximity Domain List : 00000000
> + Target Proximity Domain List : 00000001
> +                        Entry : 1200
> +                        Entry : 0200
> +
> +SLIT ::
> +
> +     Signature : "SLIT"    [System Locality Information Table]
> +    Localities : 0000000000000003
> +  Locality   0 : 10 20
> +  Locality   1 : FF 0A
> +
> +DSDT ::
> +
> +  Scope (_SB)
> +  {
> +    Device (S0D0)
> +    {
> +        Name (_HID, "ACPI0016" /* Compute Express Link Host Bridge */)  // _HID: Hardware ID
> +        ...
> +        Name (_UID, 0x07)  // _UID: Unique ID
> +    }
> +    ...
> +  }
> diff --git a/Documentation/driver-api/cxl/platform/example-configurations/one-dev-per-hb.rst b/Documentation/driver-api/cxl/platform/example-configurations/one-dev-per-hb.rst
> new file mode 100644
> index 000000000000..b89ba3cab98f
> --- /dev/null
> +++ b/Documentation/driver-api/cxl/platform/example-configurations/one-dev-per-hb.rst
> @@ -0,0 +1,136 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +==========================
> +One Device per Host Bridge
> +==========================
> +
> +This system has a single socket with two CXL host bridges. Each host bridge
> +has a single CXL memory expander with a 4GB of memory.
> +
> +Things to note:
> +
> +* Cross-Bridge interleave is not being used.
> +* The expanders are in two separate but adjascent memory regions.
> +* This CEDT/SRAT describes one node per device
> +* The expanders have the same performance and will be in the same memory tier.
> +
> +CEDT ::
> +
> +            Subtable Type : 00 [CXL Host Bridge Structure]
> +                 Reserved : 00
> +                   Length : 0020
> +   Associated host bridge : 00000007
> +    Specification version : 00000001
> +                 Reserved : 00000000
> +            Register base : 0000010370400000
> +          Register length : 0000000000010000
> +
> +            Subtable Type : 00 [CXL Host Bridge Structure]
> +                 Reserved : 00
> +                   Length : 0020
> +   Associated host bridge : 00000006
> +    Specification version : 00000001
> +                 Reserved : 00000000
> +            Register base : 0000010380800000
> +          Register length : 0000000000010000
> +
> +            Subtable Type : 01 [CXL Fixed Memory Window Structure]
> +                 Reserved : 00
> +                   Length : 002C
> +                 Reserved : 00000000
> +      Window base address : 0000001000000000
> +              Window size : 0000000100000000
> + Interleave Members (2^n) : 00
> +    Interleave Arithmetic : 00
> +                 Reserved : 0000
> +              Granularity : 00000000
> +             Restrictions : 0006
> +                    QtgId : 0001
> +             First Target : 00000007
> +
> +            Subtable Type : 01 [CXL Fixed Memory Window Structure]
> +                 Reserved : 00
> +                   Length : 002C
> +                 Reserved : 00000000
> +      Window base address : 0000001100000000
> +              Window size : 0000000100000000
> + Interleave Members (2^n) : 00
> +    Interleave Arithmetic : 00
> +                 Reserved : 0000
> +              Granularity : 00000000
> +             Restrictions : 0006
> +                    QtgId : 0001
> +             First Target : 00000006
> +
> +SRAT ::
> +
> +         Subtable Type : 01 [Memory Affinity]
> +                Length : 28
> +      Proximity Domain : 00000001
> +             Reserved1 : 0000
> +          Base Address : 0000001000000000
> +        Address Length : 0000000100000000
> +             Reserved2 : 00000000
> + Flags (decoded below) : 0000000B
> +             Enabled : 1
> +       Hot Pluggable : 1
> +        Non-Volatile : 0
> +
> +         Subtable Type : 01 [Memory Affinity]
> +                Length : 28
> +      Proximity Domain : 00000002
> +             Reserved1 : 0000
> +          Base Address : 0000001100000000
> +        Address Length : 0000000100000000
> +             Reserved2 : 00000000
> + Flags (decoded below) : 0000000B
> +             Enabled : 1
> +       Hot Pluggable : 1
> +        Non-Volatile : 0
> +
> +HMAT ::
> +
> +               Structure Type : 0001 [SLLBI]
> +                    Data Type : 00   [Latency]
> + Target Proximity Domain List : 00000000
> + Target Proximity Domain List : 00000001
> + Target Proximity Domain List : 00000002
> +                        Entry : 0080
> +                        Entry : 0100
> +                        Entry : 0100
> +
> +               Structure Type : 0001 [SLLBI]
> +                    Data Type : 03   [Bandwidth]
> + Target Proximity Domain List : 00000000
> + Target Proximity Domain List : 00000001
> + Target Proximity Domain List : 00000002
> +                        Entry : 1200
> +                        Entry : 0200
> +                        Entry : 0200
> +
> +SLIT ::
> +
> +     Signature : "SLIT"    [System Locality Information Table]
> +    Localities : 0000000000000003
> +  Locality   0 : 10 20 20
> +  Locality   1 : FF 0A FF
> +  Locality   2 : FF FF 0A
> +
> +DSDT ::
> +
> +  Scope (_SB)
> +  {
> +    Device (S0D0)
> +    {
> +        Name (_HID, "ACPI0016" /* Compute Express Link Host Bridge */)  // _HID: Hardware ID
> +        ...
> +        Name (_UID, 0x07)  // _UID: Unique ID
> +    }
> +    ...
> +    Device (S0D5)
> +    {
> +        Name (_HID, "ACPI0016" /* Compute Express Link Host Bridge */)  // _HID: Hardware ID
> +        ...
> +        Name (_UID, 0x06)  // _UID: Unique ID
> +    }
> +  }

