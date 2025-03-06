Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net (zg8tmja5ljk3lje4ms43mwaa.icoremail.net [209.97.181.73])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C90F17E473;
	Thu,  6 Mar 2025 01:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.181.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741225119; cv=none; b=lwlWqpNq+z5SLEpImLCMF4z30Xofao9gAnvg9uCnjjeTw7pPCKWhP38f6qSqL2NBQkmcdirjE6e/nqjWilgdncawDU26bKvJwPru97xlCPIQUEhpb/YmvRxUpDq9PdvWalqIoOPN8o1ZrXCUbXzfAlpq8CY1LT/l1wguff52+VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741225119; c=relaxed/simple;
	bh=n37GYU1TrA94POxtjoQVj6BwqVafhkocGlcUk6vjz1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FWq923YOB7Yxx1iftrz7zf/PE+nmzKskJpBcU46/FY2pk/jvdHT6fNIKvl36xL9zCrMsC2pUZvoKsM1tWlqsOn+uUVhdCw8T1QOdNrdQgB1XQ2vpWDAFQ2Ood6ilvTRPFRPGU9T5JoBfxs3QSC9AtVNnsBfH+rxaOlDv6AoCywU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=209.97.181.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwA3vS2L_MhnlAzuBg--.29477S2;
	Thu, 06 Mar 2025 09:38:19 +0800 (CST)
Received: from localhost (unknown [123.150.8.50])
	by mail (Coremail) with SMTP id AQAAfwBHS4d9_MhnaOY7AA--.2066S2;
	Thu, 06 Mar 2025 09:38:15 +0800 (CST)
Date: Thu, 6 Mar 2025 09:37:49 +0800
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: Gregory Price <gourry@gourry.net>
Cc: lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [LSF/MM] CXL Boot to Bash - Section 0: ACPI and Linux Resources
Message-ID: <Z8j8bZ5TS+gDV8+M@phytium.com.cn>
References: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>
 <Z8jORKIWC3ZwtzI4@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z8jORKIWC3ZwtzI4@gourry-fedora-PF4VCD3F>
X-CM-TRANSID:AQAAfwBHS4d9_MhnaOY7AA--.2066S2
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQABAWfIrdcBhQAAsQ
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW3Ww1UWr1UZryxGFW3Kr48WFg_yoWfJF4fpF
	s3JrZ7Krs3GrWxCw1xtay09w1fJa4xCayUJryxGryxCws09ryjvr43K3W8ZFWDGryUCF15
	Xa17tF1jvay8AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU

On Wed, Mar 05, 2025 at 05:20:52PM -0500, Gregory Price wrote:
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
Hi, Gregory.

Recently, I found a corner case in CXL numa node creation.

Condition:
1) A UMA/NUMA system that SRAT is absence, but it keeps CEDT.CFMWS
2）Enable CONFIG_ACPI_NUMA

Results:
1) acpi_numa_init: the fake_pxm will be 0 and send to acpi_parse_cfmws()
2）If dynamically create cxl ram region, the cxl memory would be assigned
to node0 rather than a fake new node.

Confusions:
1) Does CXL memory usage require a numa system with SRAT? As you
mentioned in SRAT section: 

"This table is technically optional, but for performance information
to be enumerated by linux it must be present."

Hence, as I understand it, it seems a bug in kernel.

2) If it is a bug, could  we forbid this situation by adding fake_pxm
check and returning error in acpi_numa_init()?

3）If not,  maybe we can add some kernel logic to allow create these fake
nodes on a system without SRAT?

Yuquan
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

