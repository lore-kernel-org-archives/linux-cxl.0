Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35714202C4F
	for <linux-cxl@vger.kernel.org>; Wed,  5 Mar 2025 22:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741213258; cv=none; b=skeyyHRuB1dlRXeA/I6gp7bJ9YBdSIixCIGgHpYQKVsMIGuHMmb53vlz94nizXtrgcGsaGWWSJ2BVourLJMV9pucVfIOE8meLyFFsRhwRSDkXnskjYZNs/GoXr3Eo8BGYb0xhik6iKmhnrCBJGvfSHvyi3GUaGEwkFk2d0bxoso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741213258; c=relaxed/simple;
	bh=1D/zcCXONrzBkuomAV1YE06x7//rKwo5IXcy5VAGy2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=quNvr8WJ+L8tL6g9sn9xDswgXL3e3FxvkwO4vWzlza9pOB5+CIxMcR0c52iFMFy7u9jnLqR14ZtSbkS4bSv6VILK/fMlJ4RqyGZEX/04W1Z4ieYvUETT2/7lH21MkFg7nXYEa/8wn4/ZtxxqSpo7v01W7x4TTOqpDwsWbmCkEv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=B8Hu/jNY; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="B8Hu/jNY"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c3ca86e8c3so203358085a.1
        for <linux-cxl@vger.kernel.org>; Wed, 05 Mar 2025 14:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1741213255; x=1741818055; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BO0P4C0Cv5YPDEVOqjeYmeu2Ronxavw79A+lbaur1FI=;
        b=B8Hu/jNYESaO2xBBlqZsQtnEO0OCFY64t7NCW6WMMdbIr5uFUgdZswvEBdRCuXW0ON
         Ahp4DHajmO3tZ7D8o4h5/NiPqc6xFk1RceOOoyK9uVQj6rNfTGboHH/xV6m74B6Bv1lk
         LD4nAykNPsiQGcY0/ESnqnt6gXKU9IcrdGy934ImM1wru1xJB8FNSiR3AF0KTQ9oMEMw
         Ym5qaXv8ACCCrRJx05t1VWT4PhTvP3sUMaemB6VmTVqDe3mDBAAXVAaHNoCWWPh9Xx63
         YTikC6M5jw2HUXftv7jymgdTPVwTurBFh1OaYUdRRUfALLD0ps63IDKqk0Cwcg9mZ+US
         Jjqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741213255; x=1741818055;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BO0P4C0Cv5YPDEVOqjeYmeu2Ronxavw79A+lbaur1FI=;
        b=XMJ443YsuiLa+ADL4gO58KZQyyYdXY8b26PZ9QVu8S3CCfNeCwEbfr5PXwH4ZZfPUK
         4kk7tAK+idLLeD927jbEs8neBDcjFmbjmXEJKrFWeAmLL8SOb6mzmMPTR6Bq84hNh9mG
         ruPB03HyzajEY7YrXgXufnV0RTz2rP7r5BqsnhM817psDkfii/+IXwsOwUoRVTPBXGp7
         yCO85wAMTnlGa+9BH0n44lVxdfj/VfchHiz2QMztXERtnXSWSHmOI8+bqG5tRC47cuPe
         Aq5BlGZhFSi1EkyrK56Sum5I0rpRHWsDOdz0exMR/iTTFEa9XCCHZCTxMW9BicR/aMSV
         o8qg==
X-Forwarded-Encrypted: i=1; AJvYcCUUByB1hsm3A7zfzgIz0vXgP4p5gT2yk7GZ7RgqmAq7Fl9kNhrS6oJYoR7yWptTQQIhHY/krGrVNcE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlHHUr8jCKIYMY1RKDtQvMOLY/a8UwtiNl1DgO8IJfV1kFU4tf
	PiQe2yOjeiBxnsRDswa9kOf23Vw6L3eUMjA+FwwBUKDj3ELOHRrAVK8gMKLHbcI=
X-Gm-Gg: ASbGnctSvwcTN5SRFtaO+UvVB1ojXRELF0/NQU+q9t6UrWFtN6YOgxwwgsY5Z4ZxYfb
	D17wz+80+hu5hsv0kNkSWklBTQ64sxIWA/dR9Ocgq8JLK4pxobvza2QYcl8fyHTHMkvH9UO+25J
	afjjX1LsyEoOQCaaTcQDjqBrblr15uiia+Z8EPoqUj6J3/MNaPl7KMiB1lC6o5tPPzT5fD55nWs
	bNdR5/tUePlCccAPAueys8arl8uQHOwqh8A4kewwzQ1NVbbBtPzRcuRRamVl4dwnMOWYx4y4PAC
	GuSiW65s/KBWIV/0AITE56p8R96XIzzdrn8K7TO/j2GH8PbAKcNlZQDWq4QgyvbogoHMShvIum3
	hbcGfcP5ja2e0CqPxZHtTk+09C+I=
X-Google-Smtp-Source: AGHT+IE8tBIvqNkBR0RqVk3FB2EWb5Dyn3WBPJBwmSSlDY+T4y6mohYuJuZsV1nkfng7jl+opX/Cwg==
X-Received: by 2002:a05:620a:601c:b0:7c0:a63e:4622 with SMTP id af79cd13be357-7c3d8def6fcmr890597285a.31.1741213254811;
        Wed, 05 Mar 2025 14:20:54 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3b8cd9d36sm480280285a.104.2025.03.05.14.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 14:20:54 -0800 (PST)
Date: Wed, 5 Mar 2025 17:20:52 -0500
From: Gregory Price <gourry@gourry.net>
To: lsf-pc@lists.linux-foundation.org
Cc: linux-mm@kvack.org, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [LSF/MM] CXL Boot to Bash - Section 0: ACPI and Linux Resources
Message-ID: <Z8jORKIWC3ZwtzI4@gourry-fedora-PF4VCD3F>
References: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>

--------------------
Part 0: ACPI Tables.
--------------------
I considered publishing this section first, or at least under
"Platform", but I've found this information largely useful in
debugging interleave configurations and tiering mechanisms -
which are higher level concepts.

Much of the information in this section is most relevant to
Interleave (yet to be published Section 4).

I promise not to simply regurgitate the entire ACPI specification
and limit this to necessary commentary to describe how these tables
relate to actual Linux resources (like numa nodes and tiers).

At the very least, if you find yourself trying to figure out why
your CXL system isn't producing NUMA nodes, memory tiers, root
decoders, memory regions - etc - I would check these tables
first for aberrations.  Almost all my personal strife has been
associated with ACPI table misconfiguration.


ACPI tables can be inspected with the `acpica-tools` package.
   mkdir acpi_tables && cd acpi_tables
   acpidump -b
   iasl -d *
   -- inpect the *.dsl files

====
CEDT
====
The CXL Early Discovery Table is generated by BIOS to describe
the CXL devices present and configured (to some extent) at boot
by the BIOS.

# CHBS
The CXL Host Bridge Structure describes CXL host bridges.  Other
than describing device register information, it reports the specific
host bridge UID for this host bridge.  These host bridge ID's will
be referenced in other tables.

Debug hint: check that the host bridge IDs between tables are
            consistent - stuff breaks oddly if they're not!

```
         Subtable Type : 00 [CXL Host Bridge Structure]
              Reserved : 00
                Length : 0020
Associated host bridge : 00000007    <- Host bridge _UID
 Specification version : 00000001
              Reserved : 00000000
         Register base : 0000010370400000
       Register length : 0000000000010000
```

# CFMWS
The CXL Fixed Memory Window structure describes a memory region
associated with one or more CXL host bridges (as described by the
CHBS).  It additionally describes any inter-host-bridge interleave
configuration that may have been programmed by BIOS. (Section 4)

```
           Subtable Type : 01 [CXL Fixed Memory Window Structure]
                Reserved : 00
                  Length : 002C
                Reserved : 00000000
     Window base address : 000000C050000000   <- Memory Region
             Window size : 0000003CA0000000
Interleave Members (2^n) : 01               <- Interleave configuration
   Interleave Arithmetic : 00
                Reserved : 0000
             Granularity : 00000000
            Restrictions : 0006
                   QtgId : 0001
            First Target : 00000007         <- Host Bridge _UID
             Next Target : 00000006         <- Host Bridge _UID
```

INTER-host-bridge interleave (multiple devices on one host bridge) is
NOT reported in this structure, and is solely defined via CXL device
decoder programming (host bridge and endpoint decoders).  This will be
described later (Section 4 - Interleave)


====
SRAT
====
The System/Static Resource Affinity Table describes resource (CPU,
Memory) affinity to "Proximity Domains". This table is technically
optional, but for performance information (see "HMAT") to be enumerated
by linux it must be present.


# Proximity Domain
A proximity domain is ROUGHLY equivalent to "NUMA Node" - though a
1-to-1 mapping is not guaranteed.  There are scenarios where "Proximity
Domain 4" may map to "NUMA Node 3", for example.  (See "NUMA Node Creation")

# Memory Affinity
Generally speaking, if a host does any amount of CXL fabric (decoder)
programming in BIOS - an SRAT entry for that memory needs to be present.

```
        Subtable Type : 01 [Memory Affinity]
               Length : 28
     Proximity Domain : 00000001          <- NUMA Node 1
            Reserved1 : 0000
         Base Address : 000000C050000000  <- Physical Memory Region
       Address Length : 0000003CA0000000
            Reserved2 : 00000000
Flags (decoded below) : 0000000B
             Enabled : 1
       Hot Pluggable : 1
        Non-Volatile : 0
```

# Generic Initiator / Port
In the scenario where CXL devices are not present or configured by
BIOS, we may still want to generate proximity domain configurations
for those devices.   The Generic Initiator interfaces are intended to
fill this gap, so that performance information can still be utilized
when the devices become available at runtime.

I won't cover the details here, for now, but I will link to the
proosal from Dan Williams and Jonathan Cameron if you would like
more information.
https://lore.kernel.org/all/e1a52da9aec90766da5de51b1b839fd95d63a5af.camel@intel.com/

====
HMAT
====
The Heterogeneous Memory Attributes Table contains information such as
cache attributes and bandwidth and latency details for memory proximity
domains.  For the purpose of this document, we will only discuss the
SSLIB entry.

# SLLBI
The System Locality Latency and Bandwidth Information records latency
and bandwidth information for proximity domains. This table is used by
Linux to configure interleave weights and memory tiers.

```
Heavily truncated for brevity
              Structure Type : 0001 [SLLBI]
                   Data Type : 00         <- Latency
Target Proximity Domain List : 00000000
Target Proximity Domain List : 00000001
                       Entry : 0080       <- DRAM LTC
                       Entry : 0100       <- CXL LTC

              Structure Type : 0001 [SLLBI]
                   Data Type : 03         <- Bandwidth
Target Proximity Domain List : 00000000
Target Proximity Domain List : 00000001
                       Entry : 1200       <- DRAM BW
                       Entry : 0200       <- CXL BW
```


---------------------------------
Part 00: Linux Resource Creation.
---------------------------------

==================
NUMA node creation
===================
NUMA nodes are *NOT* hot-pluggable.  All *POSSIBLE* NUMA nodes are
identified at `__init` time, more specifically during `mm_init`.

What this means is that the CEDT and SRAT must contain sufficient
`proximity domain` information for linux to identify how many NUMA
nodes are required (and what memory regions to associate with them).

The relevant code exists in: linux/drivers/acpi/numa/srat.c
```
static int __init
acpi_parse_memory_affinity(union acpi_subtable_headers *header,
                           const unsigned long table_end)
{
... heavily truncated for brevity
        pxm = ma->proximity_domain;
        node = acpi_map_pxm_to_node(pxm);
        if (numa_add_memblk(node, start, end) < 0)
            ....
        node_set(node, numa_nodes_parsed);    <--- mark node N_POSSIBLE
}

static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
                                   void *arg, const unsigned long table_end)
{
... heavily truncated for brevity
        /*
         * The SRAT may have already described NUMA details for all,
         * or a portion of, this CFMWS HPA range. Extend the memblks
         * found for any portion of the window to cover the entire
         * window.
         */
        if (!numa_fill_memblks(start, end))
                return 0;

        /* No SRAT description. Create a new node. */
        node = acpi_map_pxm_to_node(*fake_pxm);
        if (numa_add_memblk(node, start, end) < 0)
	        ....
        node_set(node, numa_nodes_parsed);    <--- mark node N_POSSIBLE
}

int __init acpi_numa_init(void)
{
...
    if (!acpi_table_parse(ACPI_SIG_SRAT, acpi_parse_srat)) {
        cnt = acpi_table_parse_srat(ACPI_SRAT_TYPE_MEMORY_AFFINITY,
                                    acpi_parse_memory_affinity, 0);
    }
    /* fake_pxm is the next unused PXM value after SRAT parsing */
    acpi_table_parse_cedt(ACPI_CEDT_TYPE_CFMWS, acpi_parse_cfmws,
                          &fake_pxm);

```

Basically, the heuristic is as follows:
1) Add one NUMA node per Proximity Domain described in SRAT
2) If the SRAT describes all memory described by all CFMWS
   - do not create nodes for CFMWS
3) If SRAT does not describe all memory described by CFMWS
   - create a node for that CFMWS

Generally speaking, you will see one NUMA node per Host bridge, unless
inter-host-bridge interleave is in use (see Section 4 - Interleave).


============
Memory Tiers
============
The `abstract distance` of a node dictates what tier it lands in (and
therefore, what tiers are created).  This is calculated based on the
following heuristic, using HMAT data:

```
int mt_perf_to_adistance(struct access_coordinate *perf, int *adist)
{
 ...
    /*
     * The abstract distance of a memory node is in direct proportion to
     * its memory latency (read + write) and inversely proportional to its
     * memory bandwidth (read + write).  The abstract distance, memory
     * latency, and memory bandwidth of the default DRAM nodes are used as
     * the base.
     */
    *adist = MEMTIER_ADISTANCE_DRAM *
        (perf->read_latency + perf->write_latency) /
        (default_dram_perf.read_latency + default_dram_perf.write_latency) *
        (default_dram_perf.read_bandwidth + default_dram_perf.write_bandwidth) /
        (perf->read_bandwidth + perf->write_bandwidth);
    return 0;
}
```

Debugging hint: If you have DRAM and CXL memory in separate numa nodes
                but only find 1 memory tier, validate the HMAT!


============================
Memory Tier Demotion Targets
============================
When `demotion` is enabled (see Section 5 - allocation), the reclaim
system may opportunistically demote a page from one memory tier to
another.  The selection of a `demotion target` is partially based on
Abstract Distance and Performance Data.

```
An example of demotion targets from memory-tiers.c
/* Example 1:
 *
 * Node 0 & 1 are CPU + DRAM nodes, node 2 & 3 are PMEM nodes.
 *
 * node distances:
 * node   0    1    2    3
 *    0  10   20   30   40
 *    1  20   10   40   30
 *    2  30   40   10   40
 *    3  40   30   40   10
 *
 * memory_tiers0 = 0-1
 * memory_tiers1 = 2-3
 *
 * node_demotion[0].preferred = 2
 * node_demotion[1].preferred = 3
 * node_demotion[2].preferred = <empty>
 * node_demotion[3].preferred = <empty>
 */
```

=============================
Mempolicy Weighted Interleave
=============================
The `weighted interleave` functionality of `mempolicy` utilizes weights
to distribute memory across NUMA nodes according to some set weight.
There is a proposal to auto-configure these weights based on HMAT data.

https://lore.kernel.org/linux-mm/20250305200506.2529583-1-joshua.hahnjy@gmail.com/T/#u

See Section 4 - Interleave, for more information on weighted interleave.



--------------
Build Options.
--------------
We can add these build configurations to our complexity picture.

CONFIG_NUMA        - req for ACPI numa, mempolicy, and memory tiers
CONFIG_ACPI_NUMA   -- enables srat and cedt parsing
CONFIG_ACPI_HMAT   -- enables hmat parsing


~Gregory
