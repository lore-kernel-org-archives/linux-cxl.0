Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7030E6F2F2;
	Thu, 13 Mar 2025 17:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741886411; cv=none; b=edDNT3EwUnzEYsRcACkjnJnNFgsAZzu6cnR1wjhNFe9oXpVPuFJCEYtUQ+irt7avGokhBtppoe+A7r8tz02W53a+2PKrQwVYga6x+c6RYzqoAQ+HOkPtI4yQutmzY0rLmMWWRphnGDZQ/Cw8kMFi0tNhHi0BwvIelC3MHpo5MO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741886411; c=relaxed/simple;
	bh=wUu2k/gOAC75lo1DbAQYafqLjazUfcLpetWtvNUoxEY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EdOI433AXsjGpeLVtjAJ2ESQDtpE/DyYX0dPjqu0IPcplbavD80v3EQyv3kpxDQQfJ2DlhEqXXgGFOPWQOQ2ezf5MU6LEVQCQAeHpZKcCNaWiu5SqGHHjBk9bXgB2q2QMYmfsCzHwb2xXB7vau+l2D6i8Xh57qquhVNndjSWT7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZDDgq5jzNz67MmR;
	Fri, 14 Mar 2025 01:16:55 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id CA15A140418;
	Fri, 14 Mar 2025 01:20:05 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 13 Mar
 2025 18:20:05 +0100
Date: Thu, 13 Mar 2025 17:20:04 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Gregory Price <gourry@gourry.net>
CC: <lsf-pc@lists.linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [LSF/MM] CXL Boot to Bash - Section 0a: CFMWS and NUMA
 Flexiblity
Message-ID: <20250313172004.00002236@huawei.com>
In-Reply-To: <Z8u4GTrr-UytqXCB@gourry-fedora-PF4VCD3F>
References: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>
	<Z8jORKIWC3ZwtzI4@gourry-fedora-PF4VCD3F>
	<Z8u4GTrr-UytqXCB@gourry-fedora-PF4VCD3F>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 7 Mar 2025 22:23:05 -0500
Gregory Price <gourry@gourry.net> wrote:

> In the last section we discussed how the CEDT CFMWS and SRAT Memory
> Affinity structures are used by linux to "create" NUMA nodes (or at
> least mark them as possible). However, the examples I used suggested
> that there was a 1-to-1 relationship between CFMWS and devices or
> host bridges.
> 
> This is not true - in fact, CFMWS are a simply a carve out of System
> Physical Address space which may be used to map any number of endpoint
> devices behind the associated Host Bridge(s).
> 
> The limiting factor is what your platform vendor BIOS supports.
> 
> This section describes a handful of *possible* configurations, what NUMA
> structure they will create, and what flexibility this provides.
> 
> All of these CFMWS configurations are made up, and may or may not exist
> in real machines. They are a conceptual teching tool, not a roadmap.
> 
> (When discussing interleave in this section, please note that I am
>  intentionally omitting details about decoder programming, as this
>  will be covered later.)
> 
> 
> -------------------------------
> One 2GB Device, Multiple CFMWS.
> -------------------------------
> Lets imagine we have one 2GB device attached to a host bridge.
> 
> In this example, the device hosts 2GB of persistent memory - but we
> might want the flexibility to map capacity as volatile or persistent.

Fairly sure we block persistent in a volatile CFMWS in the kernel.
Any bios actually does this?

You might have a variable partition device but I thought in kernel at
least we decided that no one was building that crazy?

Maybe a QoS split is a better example to motivate one range, two places?

> 
> The platform vendor may decide that they want to reserve two entirely
> separate system physical address ranges to represent the capacity.
> 
> ```
>            Subtable Type : 01 [CXL Fixed Memory Window Structure]
>                 Reserved : 00
>                   Length : 002C
>                 Reserved : 00000000
>      Window base address : 0000000100000000   <- Memory Region
>              Window size : 0000000080000000   <- 2GB
> Interleave Members (2^n) : 00
>    Interleave Arithmetic : 00
>                 Reserved : 0000
>              Granularity : 00000000
>             Restrictions : 0006               <- Bit(2) - Volatile
>                    QtgId : 0001
>             First Target : 00000007           <- Host Bridge _UID
> 
>            Subtable Type : 01 [CXL Fixed Memory Window Structure]
>                 Reserved : 00
>                   Length : 002C
>                 Reserved : 00000000
>      Window base address : 0000000200000000   <- Memory Region
>              Window size : 0000000080000000   <- 2GB
> Interleave Members (2^n) : 00
>    Interleave Arithmetic : 00
>                 Reserved : 0000
>              Granularity : 00000000
>             Restrictions : 000A               <- Bit(3) - Persistant
>                    QtgId : 0001
>             First Target : 00000007           <- Host Bridge _UID
> 
> NUMA effect: 2 nodes marked POSSIBLE (1 for each CFMWS)
> ```
> 
> You might have a CEDT with two CFMWS as above, where the base addresses
> are `0x100000000` and `0x200000000` respectively, but whose window sizes
> cover the entire 2GB capacity of the device.  This affords the user 
> flexibility in where the memory is mapped depending on if it is mapped
> as volatile or persistent while keeping the two SPA ranges separate.
> 
> This is allowed because the endpoint decoders commit device physical
> address space *in order*, meaning no two regions of device physical
> address space can be mapped to more than one system physical address.
> 
> i.e.: DPA(0) can only map to SPA(0x200000000) xor SPA(0x100000000)
> 
> (See Section 2a - decoder programming).
> 

> -------------------------------------------------------------
> Two Devices On One Host Bridge - With and Without Interleave.
> -------------------------------------------------------------
> What if we wanted some capacity on each endpoint hosted on its own NUMA
> node, and wanted to interleave a portion of each device capacity?

If anyone hits the lock on commit (i.e. annoying BIOS) the ordering
checks on HPA kick in here and restrict flexibility a lot
(assuming I understand them correctly that is)

This is a good illustration of why we should at some point revisit
multiple NUMA nodes per CFMWS.  We have to burn SPA space just
to get nodes.  From a spec point of view all that is needed here
is a single CFMWS. 

> 
> We could produce the following CFMWS configuration.
> ```
>            Subtable Type : 01 [CXL Fixed Memory Window Structure]
>                 Reserved : 00
>                   Length : 002C
>                 Reserved : 00000000
>      Window base address : 0000000100000000   <- Memory Region 1
>              Window size : 0000000080000000   <- 2GB
> Interleave Members (2^n) : 00
>    Interleave Arithmetic : 00
>                 Reserved : 0000
>              Granularity : 00000000
>             Restrictions : 0006               <- Bit(2) - Volatile
>                    QtgId : 0001
>             First Target : 00000007           <- Host Bridge _UID
> 
>            Subtable Type : 01 [CXL Fixed Memory Window Structure]
>                 Reserved : 00
>                   Length : 002C
>                 Reserved : 00000000
>      Window base address : 0000000200000000   <- Memory Region 2
>              Window size : 0000000080000000   <- 2GB
> Interleave Members (2^n) : 00
>    Interleave Arithmetic : 00
>                 Reserved : 0000
>              Granularity : 00000000
>             Restrictions : 0006               <- Bit(2) - Volatile
>                    QtgId : 0001
>             First Target : 00000007           <- Host Bridge _UID
> 
>            Subtable Type : 01 [CXL Fixed Memory Window Structure]
>                 Reserved : 00
>                   Length : 002C
>                 Reserved : 00000000
>      Window base address : 0000000300000000   <- Memory Region 3
>              Window size : 0000000100000000   <- 4GB
> Interleave Members (2^n) : 00
>    Interleave Arithmetic : 00
>                 Reserved : 0000
>              Granularity : 00000000
>             Restrictions : 0006               <- Bit(2) - Volatile
>                    QtgId : 0001
>             First Target : 00000007           <- Host Bridge _UID
> 
> NUMA effect: 3 nodes marked POSSIBLE (1 for each CFMWS)
> ```
> 
> In this configuration, we could still do what we did with the prior
> configuration (2 CFMWS), but we could also use the third root decoder
> to simplify decoder programming of interleave.
> 
> Since the third region has sufficient capacity (4GB) to cover both
> devices (2GB/each), we can actually associate the entire capacity of
> both devices in that region.
> 
> We'll discuss this decoder structure in-depth in Section 4.
> 

