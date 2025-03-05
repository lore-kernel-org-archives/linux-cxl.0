Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C9D2E339F;
	Wed,  5 Mar 2025 22:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741214657; cv=none; b=qQoIMXPVOrR25+Q+RBetprXxJRCxfW9xYb47+vi6m9J8XzirMBF4nHXUf7ZwsUxuWl9198nZHjxTFiboTtMsEmlGdz2JrQzUG2/f17xmvf22xgb1lc/j4KX4pzAF99OWaz9hQn0Ic6qIeSeHfzZQGKFm0tOCMI0Nd3ytUS4EUZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741214657; c=relaxed/simple;
	bh=sIWPNe1sDkCNXWyhYlSpIXOLZLQV67vXvBhITwEc69I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LpSgD4DFSOr6WTZNzkY3dSnJ+barUtqKHmazT84A5iv4G3pccjo2JiOMKppcGTJIm7iFc2FSaJ46QfTtKdwxQT6YxIgWPF6uMKkJGctNEJqICQyK6gl1XfX5rs9uEeUio+Hzn+JiSRIjI+ey9Q54LaIX7eBVrzPIa3m8ZEyc2B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X6GXA3bj; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X6GXA3bj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741214656; x=1772750656;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sIWPNe1sDkCNXWyhYlSpIXOLZLQV67vXvBhITwEc69I=;
  b=X6GXA3bjTfMa0K/LJupHySeCgTRULp9eTlEXoAPX6Jl+jBQ4MtZvtC7p
   PI2tKMFNLGLev6ic3S2b0onyKL/hWomuA6NU67pcmWPvpOite8a/oJotJ
   O38VpsKvxU498SH8Gf2S1YzANnqtyK/gq+2Hrb0GSdOSRxcAgqRsyX95P
   bFlplCh5ksFX5ytJ8APRoZtEsV4frlsWbgXko7PRi+PesMqQ+pFUtiUsc
   qXqX0JWySQWizAl/X+Fo9RIsfyapcf5XNEcql2i2GPhHHSZc8pGUtr44b
   ToOaRCyvmUxPjaoBhMeoNemIcOBXfTFnrZiycnpQgfEzCWWOy2N7c5ycH
   g==;
X-CSE-ConnectionGUID: HBDUAkbcSCKIFrKKMNPLqg==
X-CSE-MsgGUID: J2rziOB7TVaRuwnSVm0QKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="59610183"
X-IronPort-AV: E=Sophos;i="6.14,224,1736841600"; 
   d="scan'208";a="59610183"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 14:44:15 -0800
X-CSE-ConnectionGUID: KlF0OOMuQtS4DJ7Z5kCdXQ==
X-CSE-MsgGUID: xuJLBWHUTHWxHqd+neYSwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119330537"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.109.222]) ([10.125.109.222])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 14:44:14 -0800
Message-ID: <04e77063-5676-4435-854c-9488075114c5@intel.com>
Date: Wed, 5 Mar 2025 15:44:13 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM] CXL Boot to Bash - Section 0: ACPI and Linux Resources
To: Gregory Price <gourry@gourry.net>, lsf-pc@lists.linux-foundation.org
Cc: linux-mm@kvack.org, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>
 <Z8jORKIWC3ZwtzI4@gourry-fedora-PF4VCD3F>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <Z8jORKIWC3ZwtzI4@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/5/25 3:20 PM, Gregory Price wrote:
> --------------------
> Part 0: ACPI Tables.
> --------------------
> I considered publishing this section first, or at least under
> "Platform", but I've found this information largely useful in
> debugging interleave configurations and tiering mechanisms -
> which are higher level concepts.

Hi Gregory,
Thanks for detailing all this information. It has been a really good read.

Do you intend to also add CDAT information and device performance data calculation related to that? The SRAT/HMAT info only covers CXL memory that are already setup by the BIOS as system memory. Otherwise it only contains performance data for the Generic Port and not the rest of the path to the endpoint.

DJ  

> 
> Much of the information in this section is most relevant to
> Interleave (yet to be published Section 4).
> 
> I promise not to simply regurgitate the entire ACPI specification
> and limit this to necessary commentary to describe how these tables
> relate to actual Linux resources (like numa nodes and tiers).
> 
> At the very least, if you find yourself trying to figure out why
> your CXL system isn't producing NUMA nodes, memory tiers, root
> decoders, memory regions - etc - I would check these tables
> first for aberrations.  Almost all my personal strife has been
> associated with ACPI table misconfiguration.
> 
> 
> ACPI tables can be inspected with the `acpica-tools` package.
>    mkdir acpi_tables && cd acpi_tables
>    acpidump -b
>    iasl -d *
>    -- inpect the *.dsl files
> 
> ====
> CEDT
> ====
> The CXL Early Discovery Table is generated by BIOS to describe
> the CXL devices present and configured (to some extent) at boot
> by the BIOS.
> 
> # CHBS
> The CXL Host Bridge Structure describes CXL host bridges.  Other
> than describing device register information, it reports the specific
> host bridge UID for this host bridge.  These host bridge ID's will
> be referenced in other tables.
> 
> Debug hint: check that the host bridge IDs between tables are
>             consistent - stuff breaks oddly if they're not!
> 
> ```
>          Subtable Type : 00 [CXL Host Bridge Structure]
>               Reserved : 00
>                 Length : 0020
> Associated host bridge : 00000007    <- Host bridge _UID
>  Specification version : 00000001
>               Reserved : 00000000
>          Register base : 0000010370400000
>        Register length : 0000000000010000
> ```
> 
> # CFMWS
> The CXL Fixed Memory Window structure describes a memory region
> associated with one or more CXL host bridges (as described by the
> CHBS).  It additionally describes any inter-host-bridge interleave
> configuration that may have been programmed by BIOS. (Section 4)
> 
> ```
>            Subtable Type : 01 [CXL Fixed Memory Window Structure]
>                 Reserved : 00
>                   Length : 002C
>                 Reserved : 00000000
>      Window base address : 000000C050000000   <- Memory Region
>              Window size : 0000003CA0000000
> Interleave Members (2^n) : 01               <- Interleave configuration
>    Interleave Arithmetic : 00
>                 Reserved : 0000
>              Granularity : 00000000
>             Restrictions : 0006
>                    QtgId : 0001
>             First Target : 00000007         <- Host Bridge _UID
>              Next Target : 00000006         <- Host Bridge _UID
> ```
> 
> INTER-host-bridge interleave (multiple devices on one host bridge) is
> NOT reported in this structure, and is solely defined via CXL device
> decoder programming (host bridge and endpoint decoders).  This will be
> described later (Section 4 - Interleave)
> 
> 
> ====
> SRAT
> ====
> The System/Static Resource Affinity Table describes resource (CPU,
> Memory) affinity to "Proximity Domains". This table is technically
> optional, but for performance information (see "HMAT") to be enumerated
> by linux it must be present.
> 
> 
> # Proximity Domain
> A proximity domain is ROUGHLY equivalent to "NUMA Node" - though a
> 1-to-1 mapping is not guaranteed.  There are scenarios where "Proximity
> Domain 4" may map to "NUMA Node 3", for example.  (See "NUMA Node Creation")
> 
> # Memory Affinity
> Generally speaking, if a host does any amount of CXL fabric (decoder)
> programming in BIOS - an SRAT entry for that memory needs to be present.
> 
> ```
>         Subtable Type : 01 [Memory Affinity]
>                Length : 28
>      Proximity Domain : 00000001          <- NUMA Node 1
>             Reserved1 : 0000
>          Base Address : 000000C050000000  <- Physical Memory Region
>        Address Length : 0000003CA0000000
>             Reserved2 : 00000000
> Flags (decoded below) : 0000000B
>              Enabled : 1
>        Hot Pluggable : 1
>         Non-Volatile : 0
> ```
> 
> # Generic Initiator / Port
> In the scenario where CXL devices are not present or configured by
> BIOS, we may still want to generate proximity domain configurations
> for those devices.   The Generic Initiator interfaces are intended to
> fill this gap, so that performance information can still be utilized
> when the devices become available at runtime.
> 
> I won't cover the details here, for now, but I will link to the
> proosal from Dan Williams and Jonathan Cameron if you would like
> more information.
> https://lore.kernel.org/all/e1a52da9aec90766da5de51b1b839fd95d63a5af.camel@intel.com/
> 
> ====
> HMAT
> ====
> The Heterogeneous Memory Attributes Table contains information such as
> cache attributes and bandwidth and latency details for memory proximity
> domains.  For the purpose of this document, we will only discuss the
> SSLIB entry.
> 
> # SLLBI
> The System Locality Latency and Bandwidth Information records latency
> and bandwidth information for proximity domains. This table is used by
> Linux to configure interleave weights and memory tiers.
> 
> ```
> Heavily truncated for brevity
>               Structure Type : 0001 [SLLBI]
>                    Data Type : 00         <- Latency
> Target Proximity Domain List : 00000000
> Target Proximity Domain List : 00000001
>                        Entry : 0080       <- DRAM LTC
>                        Entry : 0100       <- CXL LTC
> 
>               Structure Type : 0001 [SLLBI]
>                    Data Type : 03         <- Bandwidth
> Target Proximity Domain List : 00000000
> Target Proximity Domain List : 00000001
>                        Entry : 1200       <- DRAM BW
>                        Entry : 0200       <- CXL BW
> ```
> 
> 
> ---------------------------------
> Part 00: Linux Resource Creation.
> ---------------------------------
> 
> ==================
> NUMA node creation
> ===================
> NUMA nodes are *NOT* hot-pluggable.  All *POSSIBLE* NUMA nodes are
> identified at `__init` time, more specifically during `mm_init`.
> 
> What this means is that the CEDT and SRAT must contain sufficient
> `proximity domain` information for linux to identify how many NUMA
> nodes are required (and what memory regions to associate with them).
> 
> The relevant code exists in: linux/drivers/acpi/numa/srat.c
> ```
> static int __init
> acpi_parse_memory_affinity(union acpi_subtable_headers *header,
>                            const unsigned long table_end)
> {
> ... heavily truncated for brevity
>         pxm = ma->proximity_domain;
>         node = acpi_map_pxm_to_node(pxm);
>         if (numa_add_memblk(node, start, end) < 0)
>             ....
>         node_set(node, numa_nodes_parsed);    <--- mark node N_POSSIBLE
> }
> 
> static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
>                                    void *arg, const unsigned long table_end)
> {
> ... heavily truncated for brevity
>         /*
>          * The SRAT may have already described NUMA details for all,
>          * or a portion of, this CFMWS HPA range. Extend the memblks
>          * found for any portion of the window to cover the entire
>          * window.
>          */
>         if (!numa_fill_memblks(start, end))
>                 return 0;
> 
>         /* No SRAT description. Create a new node. */
>         node = acpi_map_pxm_to_node(*fake_pxm);
>         if (numa_add_memblk(node, start, end) < 0)
> 	        ....
>         node_set(node, numa_nodes_parsed);    <--- mark node N_POSSIBLE
> }
> 
> int __init acpi_numa_init(void)
> {
> ...
>     if (!acpi_table_parse(ACPI_SIG_SRAT, acpi_parse_srat)) {
>         cnt = acpi_table_parse_srat(ACPI_SRAT_TYPE_MEMORY_AFFINITY,
>                                     acpi_parse_memory_affinity, 0);
>     }
>     /* fake_pxm is the next unused PXM value after SRAT parsing */
>     acpi_table_parse_cedt(ACPI_CEDT_TYPE_CFMWS, acpi_parse_cfmws,
>                           &fake_pxm);
> 
> ```
> 
> Basically, the heuristic is as follows:
> 1) Add one NUMA node per Proximity Domain described in SRAT
> 2) If the SRAT describes all memory described by all CFMWS
>    - do not create nodes for CFMWS
> 3) If SRAT does not describe all memory described by CFMWS
>    - create a node for that CFMWS
> 
> Generally speaking, you will see one NUMA node per Host bridge, unless
> inter-host-bridge interleave is in use (see Section 4 - Interleave).
> 
> 
> ============
> Memory Tiers
> ============
> The `abstract distance` of a node dictates what tier it lands in (and
> therefore, what tiers are created).  This is calculated based on the
> following heuristic, using HMAT data:
> 
> ```
> int mt_perf_to_adistance(struct access_coordinate *perf, int *adist)
> {
>  ...
>     /*
>      * The abstract distance of a memory node is in direct proportion to
>      * its memory latency (read + write) and inversely proportional to its
>      * memory bandwidth (read + write).  The abstract distance, memory
>      * latency, and memory bandwidth of the default DRAM nodes are used as
>      * the base.
>      */
>     *adist = MEMTIER_ADISTANCE_DRAM *
>         (perf->read_latency + perf->write_latency) /
>         (default_dram_perf.read_latency + default_dram_perf.write_latency) *
>         (default_dram_perf.read_bandwidth + default_dram_perf.write_bandwidth) /
>         (perf->read_bandwidth + perf->write_bandwidth);
>     return 0;
> }
> ```
> 
> Debugging hint: If you have DRAM and CXL memory in separate numa nodes
>                 but only find 1 memory tier, validate the HMAT!
> 
> 
> ============================
> Memory Tier Demotion Targets
> ============================
> When `demotion` is enabled (see Section 5 - allocation), the reclaim
> system may opportunistically demote a page from one memory tier to
> another.  The selection of a `demotion target` is partially based on
> Abstract Distance and Performance Data.
> 
> ```
> An example of demotion targets from memory-tiers.c
> /* Example 1:
>  *
>  * Node 0 & 1 are CPU + DRAM nodes, node 2 & 3 are PMEM nodes.
>  *
>  * node distances:
>  * node   0    1    2    3
>  *    0  10   20   30   40
>  *    1  20   10   40   30
>  *    2  30   40   10   40
>  *    3  40   30   40   10
>  *
>  * memory_tiers0 = 0-1
>  * memory_tiers1 = 2-3
>  *
>  * node_demotion[0].preferred = 2
>  * node_demotion[1].preferred = 3
>  * node_demotion[2].preferred = <empty>
>  * node_demotion[3].preferred = <empty>
>  */
> ```
> 
> =============================
> Mempolicy Weighted Interleave
> =============================
> The `weighted interleave` functionality of `mempolicy` utilizes weights
> to distribute memory across NUMA nodes according to some set weight.
> There is a proposal to auto-configure these weights based on HMAT data.
> 
> https://lore.kernel.org/linux-mm/20250305200506.2529583-1-joshua.hahnjy@gmail.com/T/#u
> 
> See Section 4 - Interleave, for more information on weighted interleave.
> 
> 
> 
> --------------
> Build Options.
> --------------
> We can add these build configurations to our complexity picture.
> 
> CONFIG_NUMA        - req for ACPI numa, mempolicy, and memory tiers
> CONFIG_ACPI_NUMA   -- enables srat and cedt parsing
> CONFIG_ACPI_HMAT   -- enables hmat parsing
> 
> 
> ~Gregory
> 

