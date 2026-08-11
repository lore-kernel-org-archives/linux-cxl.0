Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DD1279DB6
	for <linux-cxl@vger.kernel.org>; Tue, 11 Aug 2026 15:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786462198; cv=none; b=JdeZstUUnCeqtsXTTncqWW8DUQDHdJko1mKccGGJuInIo4QjraQSv94Our2J9MKrPAL0uFTweh4q2tWXmn5rYKrianVdh0nN0abXfFEY3AKbNDOpwIrmwiqamU4iEeBXa4XnwgD9ljoH0G553CS0LVsksStqwA15LSsjpqQQNXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786462198; c=relaxed/simple;
	bh=5sz1zEi9BvjCQI+AyYQ/GCs7RA4pVHuBwfD3Zl8mX5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BRckv52BJx5JpwkVbowpeBNZ0LP24GGFG0e6wKmQX/WdG+HQ2nr3kITVDnMBBXVIj9+H4Ab4J42pO3Y/FW9Ypp5KcDHc9eLit6z8PKJSqeHC5mNFRBs8pjHNEs1Rmftq1hXs96PcwVYhbLEglxwbzLWQTCdHdbitmiZ1ma6HTfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dHw0Hrt4; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dHw0Hrt4"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7e6b5737bb2so50726a34.1
        for <linux-cxl@vger.kernel.org>; Tue, 11 Aug 2026 08:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786462195; x=1787066995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dMGzaTR2fG9A9c/MgSioyYDGHbbLKIjYxPc4ZGRn4m8=;
        b=dHw0Hrt4J80p+x5QU4R6e9diXZ4mbyM5lRH7BHS82Kjtqxed/RA+TL7yQAumMsw8bX
         3UpfH7r/ctKVECo4bZApQlE717NVap66ICcJfLe53H/mn+zLM1aoxNyiwajo+E0sZFoK
         uQVttK0FlQH8Oq6Gn7WqGuluEXLCz3EqoCdwEWkNpolldNIHN7gHA+EEbenNXTWJ62gz
         J8/hoV0GfPlFCpcCTDLQSDMBMp6vVyp5iak9NikEE/6SkI9Hh8oPGMm4pQtF+S849pEc
         fetLqyMMlJm712UyFN+0MoAoKQxheCr3VLfpKufDo7CFZSnCULUlr7KwWBteGye/ATyz
         vnkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786462195; x=1787066995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dMGzaTR2fG9A9c/MgSioyYDGHbbLKIjYxPc4ZGRn4m8=;
        b=j2nV4k3RyaS+1iYXZ9IHtiqnDvIB6Cv+G21Hrc6Z9hxl46eANhAnO/PLk/uOgIiSUv
         Vy6/+fbHJkE4ScpE+Xy8h7S83FvtpFC0EOkmu+VBB3z4wXVkif67iIycotzAqp1YfwMQ
         3FLn+69IDUemQKMYuTFT8O4ibQxLxm9ma5JkT4wUzRE3PzzmWOWx3uTUnHJkh+ifnmyf
         qkopTUVQ1rz0ezL2mflzRJdncfhsweCbwJh0Lso2OLS7Not4xKxzOEn5HUgAoX/LQdxe
         AjqCAHiqUHj/0ki7blGclp45AdhAr+eOhpK1cTu2YtaoKyewud2GUo4yEjEO5I1BoxsR
         Etlg==
X-Forwarded-Encrypted: i=1; AHgh+RoZdktR/d1Iq63XTSO+MXIL5VxYWpirdz6JtA9rQk+UsxHvtGOCAv8QcrRQg1AtTGjfFVptwLa+rhU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4fQvfH+TfomVvyR2Gok5JJ9jFr2Ne/tI6vbCp0upXDWFue/0a
	sMXiiONQFq1bF+SH4mRTApqECrDIXspoohiTDpPBjjKlNZ3s9+FbU+RISZ4PYw==
X-Gm-Gg: AR+sD115ckYVMlxfJrKq+3NQ9UjX9wCbLTyay+gFDCUelTiYiaVun/xquOGV6jpwC3C
	R7hWi0u+VR1L5KP22H59wDh3TZPe9V94Fjd9Mhd2gNrPFN91cbwMOcUf7RkXfGI6feF2DLzOOzx
	PB65sDd55OQNBTrqDi5y02w28K8BcMY71txoOK2Y7WDJNGeTu2Hf3WybAjY4EoegHOPgedVe7+T
	RCI0LCGdKcY7CFayoagskAN5/p6hjEjxHVwQXDxCa8jGfA48lVaBlxC0fqfeCtPyf15bs3zlVBu
	mNAjqooJKBTf45n9ASn/71Me43zR2Y+C6WLLzNsPdx4hDShOvWnyFW9DvuU2ei/I4RaKYXsyjsI
	nW0+RPxregJAcjNmc2DldRtCpKVKCVA6jrQCzBEoQ5N/VWQ+rIRFYOgusaQ8BarRAldOAa8FXwc
	ljXRdfjuEfl8otb33zruG/m7e2geX0ZlBTUroObN2d2XqVkISaN0KDZMkORPeXdB1QV0Q+PmQhI
	BYbOJmNn208tCab2TCUCPKpI3yA7Q==
X-Received: by 2002:a05:6830:6617:b0:7e7:16b9:e274 with SMTP id 46e09a7af769-7f3a8203291mr3055974a34.8.1786462195335;
        Tue, 11 Aug 2026 08:29:55 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:48::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f3b34266f3sm81980a34.24.2026.08.11.08.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 08:29:54 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Rakie Kim <rakie.kim@sk.com>
Cc: akpm@linux-foundation.org,
	gourry@gourry.net,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	nvdimm@lists.linux.dev,
	ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	byungchul@sk.com,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	dave@stgolabs.net,
	jic23@kernel.org,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	harry@kernel.org,
	kernel_team@skhynix.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com
Subject: Re: [PATCH 0/4] mm/mempolicy: introduce package-aware weighted interleave
Date: Tue, 11 Aug 2026 08:29:51 -0700
Message-ID: <20260811152951.195315-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806080936.421-1-rakie.kim@sk.com>
References: 
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu,  6 Aug 2026 17:09:31 +0900 Rakie Kim <rakie.kim@sk.com> wrote:

> Package-aware weighted interleave places a task's weighted-interleave
> pages on the NUMA nodes of its local package, so that interleave traffic
> does not have to cross the interconnect to another package. This keeps
> each node's weight aligned with the bandwidth the task actually gets
> from it, so effective bandwidth holds up on a system that has more than
> one package. (A package is a CPU socket together with the memory
> attached to it.)
> 
> Changes from RFC:
> https://lore.kernel.org/all/20260316051258.246-1-rakie.kim@sk.com/
> - Added an opt-in sysfs toggle (off by default) and a read-only sysfs
>   view of the package topology
> - Added topology validation with a clean fallback to plain weighted
>   interleave on unsupported topologies
> - Hardened the allocation, device-teardown, and node-hotplug paths

Hello Rakie,

I hope you are doing well! Sorry for the late repsonse.

I have a few thoughts, some of which are carry-overs from the RFC
discussion we had before! I think there are still some open questions,
and I wanted to get your opinion on some of them.

My first question is whether we want cross-socket allocations at all.
The examples you gave seem to line up with node-restricted interleave,
as opposed to cross-socket interleave. I think the wording that you
use to describe the feature in 4/4 (which I will copy below)

> The resolved mask is by construction a subset of the policy nodemask, which
> mempolicy already restricts to the task's cpuset; package mode can only
> narrow that set, never widen it, so cpusets and the task nodemask remain
> authoritative.

is 100% the right way to treat these package-aware (socket-aware)
interleaving allocations, but the example below

[...snip...]

> Applied the same way to every source, these weights give the map:
> 
>               node0  node1  node2  node3
> global:         2      2      1      1

[...snip...]

>               node0  node1  node2  node3
> from CPU 0:     2      0      1      0
> from CPU 1:     0      2      0      1

Is essentially the existing weighted interleave mechanism with a 
nodemask/cpuset applied. With that said, I think a more interesting and
illustrative example would be if the user truly would want to allow some
allocations to go through cross-socket, but be able to control the
ratio at which these slip through.

              node0  node1  node2  node3
from CPU 0:     3      1      2      0
from CPU 1:     0      3      1      2

Maybe even more illustrative of the true capabilities of this series
would be if you have an asymmetric system where you bind some
host-level monitoring / logging workloads to one node (say, node0) and
want that to be able to cross through to the other socket, but not the
other way around:

              node0  node1  node2  node3
from CPU 0:     3      1      2      0
from CPU 1:     0      2      0      1

Anyways, these are just super hypothetical scenarios and I don't even
know if the configuration that I'm listing would really be beneficial
for the system. I think that coming up with some illustrative usecases
which are now made possible by this series could help motivate why we
would want to interleave across sockets. 

> A task on CPU 0 now places pages on node0 (weight 2) and node2
> (weight 1) at 2:1, which matches their effective bandwidth of 300:150;
> a task on CPU 1 places on node1 and node3 the same way. Placement
> follows the bandwidth each task actually sees, NUMA locality is
> preserved, and interleave traffic stays off the interconnect.
> 
> To make this possible the kernel needs a notion of which nodes share a
> package. The NUMA distance model offers only relative latencies and no
> structural grouping, which is especially limiting for CXL memory nodes
> that come online without an explicit package association.
> 
> The series adds a package-aware topology layer that groups CPU and
> memory-only nodes into a "memory package", built from the physical
> package ids firmware reports and, for a memory-only node, an initiator
> CPU node or SLIT distances. A package can contain more than one CPU node
> or more than one memory-only node, so the layer maps a package to a set
> of nodes rather than to a single node or a single CXL device.
> 
> The feature is off by default and opt-in through a sysfs toggle. The
> package topology itself is exposed read-only under
> /sys/devices/system/package/; there is deliberately no writable
> override, since a machine whose firmware describes its topology
> incorrectly should be fixed in firmware. On a topology that does not
> have the symmetric shape the placement relies on, enabling is refused
> and any active mode degrades cleanly to the original flat behavior.

I was also hoping to see what this interface looks like and maybe
discuss how we should relay the information to the users, since this
seems to be a new addition from the RFC.

> Measured results:
> 
> System Configuration:
> - Processor: Dual-Socket Intel Xeon 6980P (Granite Rapids)

I think a description of this system's topology would help me understand
the results below a bit better : -)

> 1) Throughput (System Bandwidth)
>    - DRAM Only: 966 GB/s
>    - Weighted Interleave: 903 GB/s (7% decrease compared to DRAM Only)
>    - Package-Aware Weighted Interleave: 1329 GB/s (1.33 TB/s)
>      (38% increase compared to DRAM Only,
>       47% increase compared to Weighted Interleave)
> 
> 2) Loaded Latency (Under High Bandwidth)
>    - DRAM Only: 544 ns
>    - Weighted Interleave: 545 ns
>    - Package-Aware Weighted Interleave: 436 ns
>      (20% reduction compared to both)

Really awesome results!

> A small CXL driver change registers a CXL memory node into its package
> as the node comes online, using the initiator the driver resolves for
> the region; this is where the package layer gets the CPU-side
> association that plain NUMA distance does not carry.
> 
> The memory_package layer offers a broader interface for grouping and
> querying package topology - usable by memory tiering as well - and
> package-aware weighted interleave uses the subset it needs.

I was hoping you could expand on this a bit more. Aside from the
alloction-time placement strategy, did you have other ideas in mind for
who could ingest the package information to make tiering decisions?

I definitely think this series makes a lot of sense and I am
hoping to hear more about it. Thank you, I hope you have a great day!

Joshua
