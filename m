Received: from sgoci-sdnproxy-4.icoremail.net (sgoci-sdnproxy-4.icoremail.net [129.150.39.64])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A188261373;
	Thu, 13 Mar 2025 08:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.150.39.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741854721; cv=none; b=YqTi5ruRfxPLBSZwZoo0EDmHFmLV3i4QSmf572Xf2IxnsCe05ysDBLI+IwWw7goZSXaB013FqAjrDoDQ+VK0WFmuXzMJHSuyQh6Msl4P8gkSRbL4Dn2xqPIlRvFIz9TbpRtD5s6LXyKcZa8Bv/wgJrh9tnD5Yokcyi3eE/l72I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741854721; c=relaxed/simple;
	bh=XTTYnmNGgeyrE6yFYiIIQ9QKfgbzEm74hCOrvm7UyiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hP1D1Dlfncmj6vs5WJy6gGuOp/CjPlhQpDzM90nA3Kh1Ac9VJQ/mO232dm85S9n5scrOFabi+l2tE7gdrajY9w8bq+SzN1JLjoyLjRXDE6JpvnG6G88XeAZFduLbZrkv1rYs6kPMrbQW+ay8TEp2a20p9Ia5lnMWqNEw7VFiPjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=129.150.39.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwCHj6f0l9Jn3NB7CQ--.36558S2;
	Thu, 13 Mar 2025 16:31:48 +0800 (CST)
Received: from localhost (unknown [123.150.8.50])
	by mail (Coremail) with SMTP id AQAAfwCHiYXzl9JnkcVGAA--.16807S2;
	Thu, 13 Mar 2025 16:31:47 +0800 (CST)
Date: Thu, 13 Mar 2025 16:31:31 +0800
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: Gregory Price <gourry@gourry.net>
Cc: lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [LSF/MM] CXL Boot to Bash - Section 4: Interleave
Message-ID: <Z9KX4/zF6/yFdWLQ@phytium.com.cn>
References: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>
 <Z9DQnjPWbkjqrI9n@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9DQnjPWbkjqrI9n@gourry-fedora-PF4VCD3F>
X-CM-TRANSID:AQAAfwCHiYXzl9JnkcVGAA--.16807S2
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAIAWfR6CADVQAGsm
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvAXoW3CF4fGryxtFykArW7Kr4Uurg_yoW8GFW3Jo
	Wjvw1ruw48Wr15Cr1UCF1kJryUZryrJF1xXr47CrWUGFnrWF1UGryUWr4UGF98GF45GFW7
	J34xJw1DG34UJFs7n29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXasCq-sGcSsGvf
	J3UbIjqfuFe4nvWSU8nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_UU
	UUUUUUU==

On Tue, Mar 11, 2025 at 08:09:02PM -0400, Gregory Price wrote:
> 
> -----------------------------
> Intra-Host-Bridge Interleave.
> -----------------------------
> Now lets consider a system where we've placed 2 CXL devices on the same
> Host Bridge.  Maybe each CXL device is only capable of x8 PCIE, and we
> want to make full use of a single x16 link.
> 
> This setup only requires the BIOS to create a CEDT CFMWS which reports
> the entire capacity of all devices under the host bridge, but does not
> need to set up any interleaving.
> 
> In the follow case, the BIOS has configured as single 4GB memory region
> which only targets the single host bridge, but maps the entire memory
> capacity of both devices (2GB).
> 
> ```
> CFMWS:
>           Subtable Type : 01 [CXL Fixed Memory Window Structure]
>                 Reserved : 00
>                   Length : 002C
>                 Reserved : 00000000
>      Window base address : 0000000300000000   <- Memory Region
>              Window size : 0000000080000000   <- 2GB

I think is "Window size : 0000000100000000   <- 4GB" here.

> Interleave Members (2^n) : 00                 <- No host bridge interleave
>    Interleave Arithmetic : 00
>                 Reserved : 0000
>              Granularity : 00000000
>             Restrictions : 0006               <- Bit(2) - Volatile
>                    QtgId : 0001
>             First Target : 00000007           <- Host Bridge _UID
> ```
> 
> Assuming no other CEDT or SRAT entries exist, this will result in linux
> creating the following NUMA topology, where all CXL memory is in Node 1.
> 
> ```
> NUMA Structure:
>         ---------     --------   |    ----------
>         | cpu0  |-----| DRAM |---|----| Node 0 |
>         ---------     --------   |    ----------
>             |                    |
>          -------                 |    ----------
>          | HB0 |-----------------|----| Node 1 |
>          -------                 |    ----------
>         /       \                |
>    CXL Dev     CXL Dev           |
> ```
> 
> In this scenario, we program the decoders like so:
> ```
> Decoders
>                            CXL Root
>                               |
>                           decoder0.0
>                          IW:1  IG:256
>                   [0x300000000, 0x3FFFFFFFF]
>                               |
>                           Host Bridge
>                               |
>                           decoder1.0
>                          IW:2  IG:256
>                    [0x300000000, 0x3FFFFFFFF]
>                              /   \
>                    Endpoint 0     Endpoint 1
>                        |              |
>                    decoder2.0     decoder3.0
>                  IW:2  IG:256     IW:2  IG:256
>     [0x300000000, 0x3FFFFFFFF]    [0x300000000, 0x3FFFFFFFF]
> ```
> 
> The root decoder in this scenario does not participate in interleave,
> it simply forwards all accesses in this range to the host bridge.
> 
> The host bridge then applies the interleave across its connected devices
> and the decodes apply translation accordingly.
> 
> -----------------------
> Combination Interleave.
> -----------------------
> Lets consider now a system where 2 Host Bridges have 2 CXL devices each,
> and we want to interleave the entire set.  This requires us to make use
> of both inter and intra host bridge interleave.
> 
> First, we can interleave this with the a single CEDT entry, the same as
> the first inter-host-bridge CEDT (now assuming 1GB per device).
> 
> ```
>            Subtable Type : 01 [CXL Fixed Memory Window Structure]
>                 Reserved : 00
>                   Length : 002C
>                 Reserved : 00000000
>      Window base address : 0000000300000000   <- Memory Region
>              Window size : 0000000100000000   <- 4GB
> Interleave Members (2^n) : 01                 <- 2-way interleave
>    Interleave Arithmetic : 00
>                 Reserved : 0000
>              Granularity : 00000000
>             Restrictions : 0006               <- Bit(2) - Volatile
>                    QtgId : 0001
>             First Target : 00000007           <- Host Bridge _UID
>              Next Target : 00000006           <- Host Bridge _UID
> ```
> 
> This gives us a NUMA structure as follows:
> ```
> NUMA Structure:
> 
>          ----------     --------    |   ----------
>          |  cpu0  |-----| DRAM |----|---| Node 0 |
>          ----------     --------    |   ----------
>         /         \                 |
>     -------     -------             |   ----------
>     | HB0 |-----| HB1 |-------------|---| Node 1 |
>     -------     -------             |   ----------
>       / \         / \               |
>   CXL0   CXL1  CXL2  CXL3           |
> ```
> 
> And the respective decoder programming looks as follows
> ```
> Decoders:
>                              CXL  Root
>                                  |
>                              decoder0.0
>                             IW:2   IG:256
>                       [0x300000000, 0x3FFFFFFFF]
>                              /         \
>                 Host Bridge 7           Host Bridge 6
>                 /                                    \
>            decoder1.0                             decoder2.0
>           IW:2   IG:512                          IW:2   IG:512
>   [0x300000000, 0x3FFFFFFFFF]             [0x300000000, 0x3FFFFFFFF]
>             /    \                                  /    \
>    endpoint0      endpoint1                endpoint2      endpoint3
>       |               |                       |               |
>   decoder3.0      decoder4.0              decoder5.0      decoder6.0
>           IW:4  IG:256                            IW:4  IG:256
>   [0x300000000, 0x3FFFFFFFF]              [0x300000000, 0x3FFFFFFFF]
> ```
> 
> Notice at both the root and the host bridge, the Interleave Ways is 2.
> There are two targets at each level.  The host bridge has a granularity
> of 512 to capture its parent's ways and granularity (`2*256`).
> 
> Each decoder is programmed with the total number of targets (4) and the
> overall granularity (256B).

Is there any relationship between endpoints'decoder setup(IW&IG) and
others decoder?

> 
> We might use this setup if each CXL device is capable of x8 PCIE, and
> we have 2 Host Bridges capable of full x16 - utilizing all bandwidth
> available.
> 
> ---------------------------------------------
> Nuance: Hardware Interleave and Memory Holes.
> ---------------------------------------------
> You may encounter a system which cannot place the entire memory capacity
> into a single contiguous System Physical Address range.  That's ok,
> because we can just use multiple decoders to capture this nuance.
> 
> Most CXL devices allow for multiple decoders.
> 
> This may require an SRAT entry to keep these regions on the same node.
> (Obviously the relies on your platform vendor's BIOS)
> 
> ```
> CFMWS:
>          Subtable Type : 01 [CXL Fixed Memory Window Structure]
>                 Reserved : 00
>                   Length : 002C
>                 Reserved : 00000000
>      Window base address : 0000000300000000   <- Memory Region
>              Window size : 0000000080000000   <- 2GB
> Interleave Members (2^n) : 00                 <- No host bridge interleave
>    Interleave Arithmetic : 00
>                 Reserved : 0000
>              Granularity : 00000000
>             Restrictions : 0006               <- Bit(2) - Volatile
>                    QtgId : 0001
>             First Target : 00000007           <- Host Bridge 7
> 
>          Subtable Type : 01 [CXL Fixed Memory Window Structure]
>                 Reserved : 00
>                   Length : 002C
>                 Reserved : 00000000
>      Window base address : 0000000400000000   <- Memory Region
>              Window size : 0000000080000000   <- 2GB
> Interleave Members (2^n) : 00                 <- No host bridge interleave
>    Interleave Arithmetic : 00
>                 Reserved : 0000
>              Granularity : 00000000
>             Restrictions : 0006               <- Bit(2) - Volatile
>                    QtgId : 0001
>             First Target : 00000007           <- Host Bridge 7
> 
> SRAT:
>         Subtable Type : 01 [Memory Affinity]
>                Length : 28
>      Proximity Domain : 00000001          <- NUMA Node 1
>             Reserved1 : 0000
>          Base Address : 0000000300000000  <- Physical Memory Region
>        Address Length : 0000000080000000  <- first 2GB
> 
>         Subtable Type : 01 [Memory Affinity]
>                Length : 28
>      Proximity Domain : 00000001          <- NUMA Node 1
>             Reserved1 : 0000
>          Base Address : 0000000400000000  <- Physical Memory Region
>        Address Length : 0000000080000000  <- second 2GB
> ```
> 
> The SRAT entries allow us to keep the regions attached to the same node.
> ```
> 
> NUMA Structure:
>         ---------     --------   |    ----------
>         | cpu0  |-----| DRAM |---|----| Node 0 |
>         ---------     --------   |    ----------
>             |                    |
>          -------                 |    ----------
>          | HB0 |-----------------|----| Node 1 |
>          -------                 |    ----------
>         /       \                |
>    CXL Dev     CXL Dev           |
> ```
>
Hi, Gregory

Seeing this, I have an assumption to discuss.

If the same system uses tables like below:

CFMWS:
         Subtable Type : 01 [CXL Fixed Memory Window Structure]
                Reserved : 00
                  Length : 002C
                Reserved : 00000000
     Window base address : 0000000300000000   <- Memory Region
             Window size : 0000000080000000   <- 2GB
Interleave Members (2^n) : 00                 <- No host bridge interleave
   Interleave Arithmetic : 00
                Reserved : 0000
             Granularity : 00000000
            Restrictions : 0006               <- Bit(2) - Volatile
                   QtgId : 0001
            First Target : 00000007           <- Host Bridge 7

         Subtable Type : 01 [CXL Fixed Memory Window Structure]
                Reserved : 00
                  Length : 002C
                Reserved : 00000000
     Window base address : 0000000400000000   <- Memory Region
             Window size : 0000000080000000   <- 2GB
Interleave Members (2^n) : 00                 <- No host bridge interleave
   Interleave Arithmetic : 00
                Reserved : 0000
             Granularity : 00000000
            Restrictions : 0006               <- Bit(2) - Volatile
                   QtgId : 0001
            First Target : 00000007           <- Host Bridge 7

SRAT:
        Subtable Type : 01 [Memory Affinity]
               Length : 28
     Proximity Domain : 00000000          <- NUMA Node 0
            Reserved1 : 0000
         Base Address : 0000000300000000  <- Physical Memory Region
       Address Length : 0000000080000000  <- first 2GB

        Subtable Type : 01 [Memory Affinity]
               Length : 28
     Proximity Domain : 00000001          <- NUMA Node 1
            Reserved1 : 0000
         Base Address : 0000000400000000  <- Physical Memory Region
       Address Length : 0000000080000000  <- second 2GB


The first 2GB cxl memory region would locate at node0 with DRAM.

NUMA Structure:

        ---------     --------   |            ----------
        | cpu0  |-----| DRAM |---|------------| Node 0 |
        ---------     --------   |   /        ----------
            |                    |  /first 2GB
         -------                 | /          ----------
         | HB0 |-----------------|------------| Node 1 |
         -------                 |second 2GB  ----------
        /       \                |
   CXL Dev     CXL Dev           |
```

Is above configuration and structure valid?

Yuquan
> And the decoder programming would look like so
> ```
> Decoders:
>                                CXL  Root
>                              /           \
>                     decoder0.0           decoder0.1
>                   IW:1  IG:256           IW:1  IG:256
>     [0x300000000, 0x37FFFFFFF]           [0x400000000, 0x47FFFFFFF]
>                              \           /
>                               Host Bridge
>                              /           \
>                     decoder1.0           decoder1.1
>                   IW:2  IG:256           IW:2  IG:256
>     [0x300000000, 0x37FFFFFFF]           [0x400000000, 0x47FFFFFFF]
>               /   \                                /   \
>     Endpoint 0     Endpoint 1            Endpoint 0     Endpoint 1
>         |              |                     |              |
>     decoder2.0     decoder3.0            decoder2.1     decoder3.1
>             IW:2 IG:256                          IW:2 IG:256
>     [0x300000000, 0x37FFFFFFF]           [0x400000000, 0x47FFFFFFF]
> ```
> 
> Linux manages decoders in relation to the associated component, so
> decoders are N.M where N is the component and M is the decoder number.
> 
> If you look, you'll see each side of this tree looks individually
> equivalent to the intra-host-bridge interleave example, just with one
> half of the total memory each (matching the CFMWS ranges).
> 
> Each of the root decoders still has an interleave width of 1 because
> they both only target one host bridge (despite it being the same one).
> 
> 
> --------------------------------
> Software Interleave (Mempolicy).
> --------------------------------
> Linux provides a software mechanism to allow tasks to to interleave its
> memory across NUMA nodes - which may have different performance
> characteristics.  This component is called `mempolicy`, and is primarily
> operated on with the `set_mempolicy()` and `mbind()` syscalls.
> 
> These syscalls take a nodemask (bitmask representing NUMA node ids) as
> an argument to describe the intended allocation policy of the task.
> 
> The following policies are presently supported (as of v6.13)
> ```
> enum {
>         MPOL_DEFAULT,
>         MPOL_PREFERRED,
>         MPOL_BIND,
>         MPOL_INTERLEAVE,
>         MPOL_LOCAL,
>         MPOL_PREFERRED_MANY,
>         MPOL_WEIGHTED_INTERLEAVE,
> };
> ```
> 
> Let's look at `MPOL_INTERLEAVE` and `MPOL_WEIGHTED_INTERLEAVE`.
> 
> To quote the man page:
> ```
> MPOL_INTERLEAVE
>     This  mode  interleaves  page  allocations  across the nodes specified
>     in nodemask in numeric node ID order.  This optimizes for bandwidth
>     instead of latency by spreading out pages and memory accesses to those
>     pages across multiple nodes.  However, accesses to a single page will
>     still be limited to the memory bandwidth of a single node.
> 
> MPOL_WEIGHTED_INTERLEAVE (since Linux 6.9)
>     This mode interleaves page allocations across the nodes specified in
>     nodemask according to the weights in
>         /sys/kernel/mm/mempolicy/weighted_interleave
>     For example, if bits 0, 2, and 5 are set in nodemask and the contents of
>         /sys/kernel/mm/mempolicy/weighted_interleave/node0
>         /sys/ ... /node2
>         /sys/ ... /node5
>     are 4, 7, and 9, respectively, then pages in this region will be
>     allocated on nodes 0, 2, and 5 in a 4:7:9 ratio.
> ```
> 
> To put it simply, MPOL_INTERLEAVE will interleave allocations at a page
> granularity (4KB, 2MB, etc) across nodes in a 1:1 ratio, while
> MPOL_WEIGHTED_INTERLEAVE takes into account weights - which presumably
> map to the bandwidth of each respective node.
> 
> Or more concretely:
> 
> MPOL_INTERLEAVE
>     1:1 Interleave between two nodes.
>     malloc(4096)  ->  node0
>     malloc(4096)  ->  node1
>     malloc(4096)  ->  node0
>     malloc(4096)  ->  node1
>     ... and so on ...
> 
> MPOL_WEIGHTED_INTERLEAVE
>     2:1 Interleave between two nodes.
>     malloc(4096)  ->  node0
>     malloc(4096)  ->  node0
>     malloc(4096)  ->  node1
>     malloc(4096)  ->  node0
>     malloc(4096)  ->  node0
>     malloc(4096)  ->  node1
>     ... and so on ...
> 
> This is the preferred mechanism for *heterogeneous interleave* on Linux,
> as it allows for predictable performance based on the explicit (and
> visible) placement of memory.
> 
> It also allows for memory ZONE restrictions to enable better performance
> predictability (e.g. keeping kernel locks out of CXL while allowing
> workloads to leverage it for expansion or bandwidth).
> 
> ======================
> Mempolicy Limitations.
> ======================
> Mempolicy is a *per-task* allocation policy that is inherited by
> child-tasks on clone/fork. It can only be changed by the task itself,
> though cgroups may affect the effective nodemask via cpusets.
> 
> This means once a task has been launched, and external actor cannot
> change the policy of a running task - except possibly by migrating that
> task between cgroups or changing the cpusets.mems value of the cgroup
> the task lives in.
> 
> Additionally, If capacity on a given node is not available, allocations
> will fall back to another node in the node mask - which may cause
> interleave to become unbalanced.
> 
> ================================
> Hardware Interleave Limitations.
> ================================
> Granularities:
>    granularities are limited on hardware
>    (typically 256B up to 16KB by power of 2)
> 
> Ways:
>    Ways are limited by the CXL configuration to:
>    2,4,8,16,3,6,12
> 
> Balance:
>    Linux does not allow imbalanced interleave configurations
>    (e.g. 3-way interleave where 2 targets are on 1 HB and 1 on another)
> 
> Depending on your platform vendor and type of interleave, you may not
> be able to deconstruct an interleave region at all (decoders may be
> locked).  In this case, you may not have the flexiblity to convert
> operation from interleaved to non-interleave via the driver interface.
> 
> In the scenario where your interleave configuration is entirely driver
> managed, you cannot adjust the size of an interleave set without
> deconstructing the entire set.
> 
> ------------------------------------------------------------------------
> 
> Next we'll discuss how memory allocations occur in a CXL-enabled system,
> which may be affected by things like Reclaim and Tiering systems.
> 
> ~Gregory

