Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A82813E898;
	Sun, 11 May 2025 02:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746932080; cv=none; b=VjbeA4kVDmMB0ZwrBwFeCmDvXwEWlCih3F2Pz9l8Ekn8l4ZOGjbRc0bi8Qkt+tocfZDembpYDPL4wA/qnvifAydGRpXv7WlJcPjPAwJNO9J6zWN55IduO1Bz4RUCVGlQxoh2amUqyY/x996XdW10/TwPYKF2XJme3ZlrVHp3cJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746932080; c=relaxed/simple;
	bh=IEEvh3JvV+l5F4j8MJqC9F3vQdI9e0b+9PInDCwaKa0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tpqvf2wDMqJ6ixRIBZGgcn3PZCGd2EK9Ujlrac+0dDXcTtm4+c6XZjmf9WCMUt0qM8R7E0glIoHRZCUf3/se3k/PqvY+NKOlJrxDqp4Tqc1+O/ZfYlFfq2AJ3pWoWD6znoPf2r/5b0OZbi/NlEPLugFxDlzyF4Skf5caPaeLBkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aYka45oT; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aYka45oT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=D+ILB60tTLxf/T57GiFI+wFMqcCa8oqAF8HpkB/MccM=; b=aYka45oTsygBeZ0INvB4YPD1vf
	uZCzaLtwvZhA8Z/wZ5EsmICw4ZwCW2ij8a9Cwsu7ckvR57u8gqdZe8if6z37XMeQI5KmCo5p/Yb5P
	PEqtLEPIh6GCyMWqbcj5XnOyrEh79dlKOQwIUsn/t0zJBvXXpnY35FfqxX9yHTvZXxuaUHizlevr/
	OLtp+GIxbJJvrsZfUTkFmBVP35RWF59Mo3/JQ9XnKPsQbOMg4QsPWKy3KNUXB7lhyzu1t6TB1JRsE
	lBllVNBo6GwalM9xViMbYmfxssrANf8x+dMOLwSGRS7kWsDR95Y1d6zJObD3KfLhpgdJiATAOLd+x
	FbizFu/g==;
Received: from [50.39.124.201] (helo=[192.168.254.17])
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1uDwpW-0000000GXXr-3T5U;
	Sun, 11 May 2025 02:54:20 +0000
Message-ID: <bb979120-cb57-4429-8438-a5713473403e@infradead.org>
Date: Sat, 10 May 2025 19:54:14 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 18/18] cxl: docs - add self-referencing cross-links
To: Gregory Price <gourry@gourry.net>, linux-cxl@vger.kernel.org
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 ira.weiny@intel.com, dan.j.williams@intel.com, corbet@lwn.net
References: <20250430181048.1197475-1-gourry@gourry.net>
 <20250430181048.1197475-19-gourry@gourry.net>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250430181048.1197475-19-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/30/25 11:10 AM, Gregory Price wrote:
> Add some crosslinks between pages in the CXL docs - mostly to the
> ACPI tables.
> 
> Signed-off-by: Gregory Price <gourry@gourry.net>
> ---
>  .../driver-api/cxl/devices/device-types.rst   |  2 +-
>  .../cxl/linux/access-coordinates.rst          |  8 +++--
>  .../driver-api/cxl/linux/cxl-driver.rst       | 36 ++++++++++---------
>  .../driver-api/cxl/linux/early-boot.rst       | 30 +++++++++-------
>  .../driver-api/cxl/platform/bios-and-efi.rst  | 13 +++----
>  .../example-configurations/flexible.rst       | 10 +++---
>  .../example-configurations/hb-interleave.rst  | 10 +++---
>  .../multi-dev-per-hb.rst                      | 10 +++---
>  .../example-configurations/one-dev-per-hb.rst | 10 +++---
>  9 files changed, 71 insertions(+), 58 deletions(-)
> 


> diff --git a/Documentation/driver-api/cxl/linux/access-coordinates.rst b/Documentation/driver-api/cxl/linux/access-coordinates.rst
> index b07950ea30c9..24db5b41716a 100644
> --- a/Documentation/driver-api/cxl/linux/access-coordinates.rst
> +++ b/Documentation/driver-api/cxl/linux/access-coordinates.rst
> @@ -24,7 +24,8 @@ asymmetry in properties does not happen and all paths to EPs are equal.
>  
>  There can be multiple switches under an RP. There can be multiple RPs under
>  a CXL Host Bridge (HB). There can be multiple HBs under a CXL Fixed Memory
> -Window Structure (CFMWS).
> +Window Structure (CFMWS) in the
> +Documentation/driver-api/cxl/platform/acpi/acpi/cedt.rst.
>  
>  An example hierarchy:
>  
> @@ -83,8 +84,9 @@ also the index for the resulting xarray.
>  
>  The next step is to take the min() of the per host bridge bandwidth and the
>  bandwidth from the Generic Port (GP). The bandwidths for the GP is retrieved

                                                                   are

> -via ACPI tables SRAT/HMAT. The min bandwidth are aggregated under the same

s/min/minimum/ preferably.

> -ACPI0017 device to form a new xarray.
> +via ACPI tables Documentation/driver-api/cxl/platform/acpi/srat.rst and
> +Documentation/driver-api/cxl/platform/acpi/hmat.rst. The min bandwidth are
> +aggregated under the same ACPI0017 device to form a new xarray.
>  
>  Finally, the cxl_region_update_bandwidth() is called and the aggregated
>  bandwidth from all the members of the last xarray is updated for the

> diff --git a/Documentation/driver-api/cxl/linux/early-boot.rst b/Documentation/driver-api/cxl/linux/early-boot.rst
> index 275174d5b0bb..309cc6999c6b 100644
> --- a/Documentation/driver-api/cxl/linux/early-boot.rst
> +++ b/Documentation/driver-api/cxl/linux/early-boot.rst
> @@ -12,7 +12,8 @@ read EFI and ACPI information throughout this process to configure logical
>  representations of the devices.
>  
>  During Linux Early Boot stage (functions in the kernel that have the __init
> -decorator), the system takes the resources created by EFI/BIOS (ACPI tables)
> +decorator), the system takes the resources created by EFI/BIOS
> +(Documentation/driver-api/cxl/platform/acpi.rst)
>  and turns them into resources that the kernel can consume.
>  
>  
> @@ -69,13 +70,15 @@ significant impact performance depending on the memory capacity of the system.
>  NUMA Node Reservation
>  =====================
>  
> -Linux refers to the proximity domains (:code:`PXM`) defined in the SRAT to
> -create NUMA nodes in :code:`acpi_numa_init`. Typically, there is a 1:1 relation
> -between :code:`PXM` and NUMA node IDs.
> +Linux refers to the proximity domains (:code:`PXM`) defined in the
> +Documentation/driver-api/cxl/platform/acpi/srat.rst to create NUMA nodes in
> +:code:`acpi_numa_init`. Typically, there is a 1:1 relation between
> +:code:`PXM` and NUMA node IDs.
>  
> -SRAT is the only ACPI defined way of defining Proximity Domains. Linux chooses
> -to, at most, map those 1:1 with NUMA nodes. CEDT adds a description of SPA
> -ranges which Linux may wish to map to one or more NUMA nodes
> +The SRAT is the only ACPI defined way of defining Proximity Domains. Linux
> +chooses to, at most, map those 1:1 with NUMA nodes.
> +Documentation/driver-api/cxl/platform/acpi/cedt.rst
> +adds a description of SPA ranges which Linux may map to one or more NUMA nodes

Add ending period ('.') above.

>  
>  If there are CXL ranges in the CFMWS but not in SRAT, then a fake :code:`PXM`
>  is created (as of v6.15). In the future, Linux may reject CFMWS not described
> @@ -88,7 +91,7 @@ data for Linux to identify NUMA nodes their associated memory regions.
>  
>  The relevant code exists in: :code:`linux/drivers/acpi/numa/srat.c`.
>  
> -See the Example Platform Configurations section for more information.
> +See Documentation/driver-api/cxl/platform/example-configs.rst for more info.
>  
>  Memory Tiers Creation
>  =====================
> @@ -107,10 +110,13 @@ Tier membership can be inspected in ::
>    /sys/devices/virtual/memory_tiering/memory_tierN/nodelist
>    0-1
>  
> -If nodes are grouped which have clear difference in performance, check the HMAT
> -and CDAT information for the CXL nodes.  All nodes default to the DRAM tier,
> -unless HMAT/CDAT information is reported to the memory_tier component via
> -`access_coordinates`.
> +If nodes are grouped which have clear difference in performance, check the
> +Documentation/driver-api/cxl/platform/acpi/hmat.rst and CDAT
> +(Documentation/driver-api/cxl/devices/uefi.rst) information for the CXL nodes.
> +All nodes default to the DRAM tier, unless HMAT/CDAT information is reported
> +to the memory_tier component via `access_coordinates`.
> +
> +For more, see Documentation/driver-api/cxl/linux/access-coordinates.rst.
>  
>  Contiguous Memory Allocation
>  ============================


> diff --git a/Documentation/driver-api/cxl/platform/example-configurations/flexible.rst b/Documentation/driver-api/cxl/platform/example-configurations/flexible.rst
> index 13a97c03e25a..b2559d2de225 100644
> --- a/Documentation/driver-api/cxl/platform/example-configurations/flexible.rst
> +++ b/Documentation/driver-api/cxl/platform/example-configurations/flexible.rst
> @@ -18,7 +18,7 @@ Things to note:
>  * This SRAT describes one-node for each of the above CFMWS.

                         one node

>  * The HMAT describes performance for each node in the SRAT.
>  
> -CEDT ::
> +Documentation/driver-api/cxl/platform/acpi/cedt.rst ::
>  
>              Subtable Type : 00 [CXL Host Bridge Structure]
>                   Reserved : 00
> @@ -137,7 +137,7 @@ CEDT ::
>                      QtgId : 0001
>               First Target : 00000006
>  
> -SRAT ::
> +Documentation/driver-api/cxl/platform/acpi/srat.rst ::
>  
>           Subtable Type : 01 [Memory Affinity]
>                  Length : 28
> @@ -223,7 +223,7 @@ SRAT ::
>         Hot Pluggable : 1
>          Non-Volatile : 0
>  
> -HMAT ::
> +Documentation/driver-api/cxl/platform/acpi/hmat.rst ::
>  
>                 Structure Type : 0001 [SLLBI]
>                      Data Type : 00   [Latency]
> @@ -263,7 +263,7 @@ HMAT ::
>                          Entry : 0100
>                          Entry : 0100
>  
> -SLIT ::
> +Documentation/driver-api/cxl/platform/acpi/slit.rst ::
>  
>       Signature : "SLIT"    [System Locality Information Table]
>      Localities : 0000000000000003
> @@ -276,7 +276,7 @@ SLIT ::
>    Locality   6 : FF FF FF FF FF FF 0A FF
>    Locality   7 : FF FF FF FF FF FF FF 0A
>  
> -DSDT ::
> +Documentation/driver-api/cxl/platform/acpi/dsdt.rst ::
>  
>    Scope (_SB)
>    {
> diff --git a/Documentation/driver-api/cxl/platform/example-configurations/hb-interleave.rst b/Documentation/driver-api/cxl/platform/example-configurations/hb-interleave.rst
> index fa0885d82deb..9cbf3dd44b0f 100644
> --- a/Documentation/driver-api/cxl/platform/example-configurations/hb-interleave.rst
> +++ b/Documentation/driver-api/cxl/platform/example-configurations/hb-interleave.rst
> @@ -13,7 +13,7 @@ Things to note:
>  * This SRAT describes one-node for both host bridges.

                         one node

>  * The HMAT describes a single node's performance.
>  
> -CEDT ::
> +Documentation/driver-api/cxl/platform/acpi/cedt.rst ::
>  
>              Subtable Type : 00 [CXL Host Bridge Structure]
>                   Reserved : 00
> @@ -48,7 +48,7 @@ CEDT ::
>               First Target : 00000007
>              Second Target : 00000006
>  
> -SRAT ::
> +Documentation/driver-api/cxl/platform/acpi/srat.rst ::
>  
>           Subtable Type : 01 [Memory Affinity]
>                  Length : 28
> @@ -62,7 +62,7 @@ SRAT ::
>         Hot Pluggable : 1
>          Non-Volatile : 0
>  
> -HMAT ::
> +Documentation/driver-api/cxl/platform/acpi/hmat.rst ::
>  
>                 Structure Type : 0001 [SLLBI]
>                      Data Type : 00   [Latency]
> @@ -80,14 +80,14 @@ HMAT ::
>                          Entry : 1200
>                          Entry : 0400
>  
> -SLIT ::
> +Documentation/driver-api/cxl/platform/acpi/slit.rst ::
>  
>       Signature : "SLIT"    [System Locality Information Table]
>      Localities : 0000000000000003
>    Locality   0 : 10 20
>    Locality   1 : FF 0A
>  
> -DSDT ::
> +Documentation/driver-api/cxl/platform/acpi/dsdt.rst ::
>  
>    Scope (_SB)
>    {
> diff --git a/Documentation/driver-api/cxl/platform/example-configurations/multi-dev-per-hb.rst b/Documentation/driver-api/cxl/platform/example-configurations/multi-dev-per-hb.rst
> index 6adf7c639490..fa24243968ac 100644
> --- a/Documentation/driver-api/cxl/platform/example-configurations/multi-dev-per-hb.rst
> +++ b/Documentation/driver-api/cxl/platform/example-configurations/multi-dev-per-hb.rst
> @@ -14,7 +14,7 @@ Things to note:
>  * This CEDT/SRAT describes one node for both devices.
>  * There is only one proximity domain the HMAT for both devices.
>  
> -CEDT ::
> +Documentation/driver-api/cxl/platform/acpi/cedt.rst ::
>  
>              Subtable Type : 00 [CXL Host Bridge Structure]
>                   Reserved : 00
> @@ -39,7 +39,7 @@ CEDT ::
>                      QtgId : 0001
>               First Target : 00000007
>  
> -SRAT ::
> +Documentation/driver-api/cxl/platform/acpi/srat.rst ::
>  
>           Subtable Type : 01 [Memory Affinity]
>                  Length : 28
> @@ -53,7 +53,7 @@ SRAT ::
>         Hot Pluggable : 1
>          Non-Volatile : 0
>  
> -HMAT ::
> +Documentation/driver-api/cxl/platform/acpi/hmat.rst ::
>  
>                 Structure Type : 0001 [SLLBI]
>                      Data Type : 00   [Latency]
> @@ -69,14 +69,14 @@ HMAT ::
>                          Entry : 1200
>                          Entry : 0200
>  
> -SLIT ::
> +Documentation/driver-api/cxl/platform/acpi/slit.rst ::
>  
>       Signature : "SLIT"    [System Locality Information Table]
>      Localities : 0000000000000003
>    Locality   0 : 10 20
>    Locality   1 : FF 0A
>  
> -DSDT ::
> +Documentation/driver-api/cxl/platform/acpi/dsdt.rst ::
>  
>    Scope (_SB)
>    {
> diff --git a/Documentation/driver-api/cxl/platform/example-configurations/one-dev-per-hb.rst b/Documentation/driver-api/cxl/platform/example-configurations/one-dev-per-hb.rst
> index 8b732dc8c5b6..ee65b3364c5b 100644
> --- a/Documentation/driver-api/cxl/platform/example-configurations/one-dev-per-hb.rst
> +++ b/Documentation/driver-api/cxl/platform/example-configurations/one-dev-per-hb.rst
> @@ -14,7 +14,7 @@ Things to note:
>  * This CEDT/SRAT describes one-node per device

                              one node

>  * The expanders have the same performance and will be in the same memory tier.
>  
> -CEDT ::
> +Documentation/driver-api/cxl/platform/acpi/cedt.rst ::
>  
>              Subtable Type : 00 [CXL Host Bridge Structure]
>                   Reserved : 00
> @@ -62,7 +62,7 @@ CEDT ::
>                      QtgId : 0001
>               First Target : 00000006
>  
> -SRAT ::
> +Documentation/driver-api/cxl/platform/acpi/srat.rst ::
>  
>           Subtable Type : 01 [Memory Affinity]
>                  Length : 28
> @@ -88,7 +88,7 @@ SRAT ::
>         Hot Pluggable : 1
>          Non-Volatile : 0
>  
> -HMAT ::
> +Documentation/driver-api/cxl/platform/acpi/hmat.rst ::
>  
>                 Structure Type : 0001 [SLLBI]
>                      Data Type : 00   [Latency]
> @@ -108,7 +108,7 @@ HMAT ::
>                          Entry : 0200
>                          Entry : 0200
>  
> -SLIT ::
> +Documentation/driver-api/cxl/platform/acpi/slit.rst ::
>  
>       Signature : "SLIT"    [System Locality Information Table]
>      Localities : 0000000000000003
> @@ -116,7 +116,7 @@ SLIT ::
>    Locality   1 : FF 0A FF
>    Locality   2 : FF FF 0A
>  
> -DSDT ::
> +Documentation/driver-api/cxl/platform/acpi/dsdt.rst ::
>  
>    Scope (_SB)
>    {

-- 
~Randy

