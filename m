Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256591990CD
	for <linux-cxl@vger.kernel.org>; Sat,  1 Feb 2025 13:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738416572; cv=none; b=SVpwzcvAhIXrSRteAB5sUX4gB8TRqhnd+NKlz1iAYbBbcLvctJHkpJtrFinzA4BNzxFAvFBrIGLV/M1EzXs3x9+1f1vRtsECbHsBW1QAUmUxL7s7CC32PTzXvDHm232/jTBp2W1SGjMqI7wnHeNmRLzcvzE/P6UQV7P3fYW67p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738416572; c=relaxed/simple;
	bh=26GiATOYvWqruVT69oEmVVgTIoHAG3pJxatiD6zOnto=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=X9ADe2TcH+HF6bb5QyNv5ObVwwpFjwWz2uiwmNMA24MVaqqd9g1GMVhty6zy+4aRwhtuajN8aBE9pEkJ/fUCmcNSEX6e3nV6TUf+VkeULQyObEW7lJU7z3jzgRtODq4ytAW00iTEoDxBCi0yQlB1l85c7KT1NQ2D1eQuoyEFs2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RmvYhZp3; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RmvYhZp3"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-215770613dbso39235595ad.2
        for <linux-cxl@vger.kernel.org>; Sat, 01 Feb 2025 05:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738416570; x=1739021370; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lWLzyqeFTIZTY0IJD5DIWGpOzwUb+TSKnktWNSl3WSc=;
        b=RmvYhZp3Nj1UUODnWwg/EIuwT+QFTuELVeaSDXad7h+/GAYEpz8lo11eoZ3BKM4DNR
         OtzRemEKXSdlJQs31ZwyUT9yi5Hehqd4fn5rDAL7EgDXVv1YC5EFisNU40o5Ykkbun+2
         Oi/ao3dtHg0MyjQiJnVcYmlouEFpKtijkcwlC+wc2QxviTzi6jDx82IS4ZSG23ZqRx0Q
         chNgy5e6ycrW+e5ip6QB+MRhlG8YTLHVRAAkqX0LyfXfJ1vkHiu1I5alTK7v8/u5JDu9
         IXGji1Lt1iYu1qlGahGdQIhqUWStrl+rpPuNiuen8zFDGBYsMC1Tv0M7QLE2av+yXvr6
         GphA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738416570; x=1739021370;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lWLzyqeFTIZTY0IJD5DIWGpOzwUb+TSKnktWNSl3WSc=;
        b=ZLejTaVlKDqMgVbZwKmB1eUVgCnJgVQ0xUmtw/MFBhZ4c5tFUjqbXu6axsyo7tv5HW
         oiSoqZriwqTP1Y/qBBtU/fXjyqBklsHH+E5dVUUPf+t5cUlIWLbvJiNkwjOLE8XjD6ft
         1G02nJ4K6b28rOYo8hP4ediXTh8MS5nHceJJHrKQA2ivoQzhtPzbT9xNvu9xrvjlWyLz
         so9F61HXBp9RLGA387DqprmYqOOAllIAbx31hdSDVjD+QfXgB2Ux6Rt01LzZIcirdHZk
         0nYZ76qoVcZYcjrrOnrC5QagDf6rvZrCqk3T7cxH11nL6uwtlKyLiAavpz69gStBq8wY
         I0sA==
X-Gm-Message-State: AOJu0Yxvj7Wbskyxhi7bZuiVY0xey2sfuQwGExGiiKkCWVFmI2X8KDx/
	3sZqiPvC9R6WwjyaVQdfOm4J63QgaoQFk7YGnWZMh6t35RrsGbrU
X-Gm-Gg: ASbGnct1QSN6llq4JxEiZf7pYhbmzeXokn4FcMwwercpPf9pAc71LYbQcteQEdrN+GP
	8SmIqVN7f3reSNADAM0g4hPDHOl2pHD39Vbe+Hh+67apQ+DHvJkXNf1WOj9axvSVmdyKNxloozp
	HAUKvjDvcv/egw3fzoUwYRy1q86allzDkgzwxz+IVcWx+Z1/emZ98pe4Ax7eZnHbELReUJYwslt
	l7hyO6ZaaCKf1lkd3IhcEp014+wPhAnqeMkY7T8PDfvi/AEadoopkhg9oaooDtFBOIPdxkwzb9C
	+JPhe9D8quts6AdUjswxuBQ/oQ==
X-Google-Smtp-Source: AGHT+IGjgJM/7O8I2xkrmZ1xJ4IrMggF295ewGFg+Yp6YAmV0wtPLdd/Wxbh07JxqxNL/k+vFbsKeA==
X-Received: by 2002:a17:902:cf01:b0:215:7446:2151 with SMTP id d9443c01a7336-21dd7c4c15dmr263409365ad.4.1738416570151;
        Sat, 01 Feb 2025 05:29:30 -0800 (PST)
Received: from localhost.localdomain ([1.245.180.67])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de3320ec8sm45682435ad.248.2025.02.01.05.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Feb 2025 05:29:29 -0800 (PST)
Date: Sat, 1 Feb 2025 22:29:23 +0900
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
To: lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org
Cc: linux-cxl@vger.kernel.org, Byungchul Park <byungchul@sk.com>,
	Honggyu Kim <honggyu.kim@sk.com>
Subject: [LSF/MM/BPF TOPIC] Restricting or migrating unmovable kernel
 allocations from slow tier
Message-ID: <Z54hUTXRsw0LYQ8b@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Byungchul and I would like to suggest a topic about the performance impact of
kernel allocations on CXL memory.

As CXL-enabled servers and memory devices are being developed, CXL-supported
hardware is expected to continue emerging in the coming years.

The Linux kernel supports hot-plugging CXL memory via dax/kmem functionality.
The hot-plugged memory allows either unmovable kernel allocations
(ZONE_NORMAL), or restricts them to movable allocations (ZONE_MOVABLE)
depending on the hot-plug policy.

Recently, Byungchul and I observed a measurable performance degradation with
memhp_default_state=online compared to memhp_default_state=online_movable
on a server where the ratio of memory capacity between DRAM and CXL is 1:2
when running the llama.cpp workload with the default mempolicy.
The workload performs LLM inference and pressures the memory subsystem
due to its large working set size.

Obviously, allowing kernel allocations from CXL memory degrades performance
because kernel memory like page tables, kernel stacks, and slab allocations,
is accessed frequently and may reside in physical memory with significantly
higher access latency.

However, as far as I can tell there are at least two reasons why we need to
support ZONE_NORMAL for CXL memory (please add if there are more):
  1. When hot-plugging a huge amount of CXL memory, the size of
     the struct page array might not fit into DRAM
     -> This could be relaxed with memmap_on_memory
  2. To hot-unplug CXL memory, pages in CXL memory should be migrated to DRAM,
     which means sometimes some portion of CXL memory should be ZONE_NORMAL.

So, there are certain cases where we want CXL memory to include ZONE_NORMAL,
but this also degrades performance if we allow _all_ kinds of kernel
allocations to be served from CXL memory.

For ideal performance, it would be beneficial to either:
  1) Restrict allocating certain types (e.g. page tables, kernel stacks,
     slabs) of kernel memory from slow tier, or
  2) Allow migrating certain types of kernel memory from slow tier to
     fast tier.

At LSF/MM/BPF, I would like to discuss potential directions for addressing
this problem, ensuring the enablement of CXL memory while minimizing its
performance degradation.

Restricting certain types of kernel allocations from slow tier
==============================================================

We could restrict some kernel allocations to fast tier by passing a
nodemask to __alloc_pages() (with only nodes in fast tier set) or
using a GFP flag like __GFP_FAST_TIER which does the same thing.

This prevents kernel allocations from slow tier and thus avoids
performance degradation due to the high access latency of CXL.
However, binding all leaf page tables to fast tier might not be ideal
due to 1) increased latency from premature reclamation
and 2) premature OOM kill [1].

Migrating certain types of kernel allocations from slow to fast tier
====================================================================

Rather than binding kernel allocations to fast tier and causing premature
reclamation & OOM kill, policies for migrating kernel pages may be more
effective, such as:
  - Migrating page tables to fast tier,
    triggered by data-page promotion [1]
  - Migrating to fast tier when there is low memory pressure:
    - Migrating slab movable objects [2]
    - Migrating kernel stacks (if that's feasible)

although this sounds more intrusive and we need to think about robust policies
that do not degrade existing traditional memory systems.

Any opinions will be appreciated.
Thanks!

[1] https://dl.acm.org/doi/10.1145/3459898.3463907
[2] https://lore.kernel.org/linux-mm/20190411013441.5415-1-tobin@kernel.org
