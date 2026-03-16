Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE9619ADB0
	for <linux-cxl@vger.kernel.org>; Mon, 16 Mar 2026 15:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773674378; cv=none; b=f99PMvJ/ZX9ShJUVJwIv0bDCYMWTQnYfK80Ao1f+rpQGnYNJDSNkAFO/1Ysy2kQDPFIxiXNFigFuRnK6lwhP5bXQZmUea+C+PCCYUIXgBNOlhjt0tYd69VtMyDF6AFplRF7Wn+tr57eVHBT2D/8MT2XJYzPS7e1I1qutNXC/73I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773674378; c=relaxed/simple;
	bh=+SDK+ILsKmipkaVQAvqWVrbDqxQl7+mGIn9WdMBmieI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RV4EuDH0SUayXqkb8RwDGbs6RtVLI758b7iyljSxZvc//GxOedgChkghqK1Sqs5jSBwbx3SkYwPou2gOIMzlRIZ3teJ2hy9M04iiWghO61tjKJLi2vjR+kdfCKw4VlyMErI4pooaOTyj7xmFpAZjE5Vnspoux8GpKXW/cypUhMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A6sUBcQn; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A6sUBcQn"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7d751ef36ccso2635900a34.0
        for <linux-cxl@vger.kernel.org>; Mon, 16 Mar 2026 08:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773674376; x=1774279176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m2chYU1ux6ZQIx4otnZe8opROVQFDtOWN8KCrqkEk7A=;
        b=A6sUBcQnz01R62fVF+h6Y6xT6yY3o5L1kGXy0jZvYHoim57O1YYCsHL5HPXo1Aqw43
         4y+97PfxZ/2UEJ2fAzaIaIJw+TMgd4MV/lofejcuL346Gwo7RV4VTgYpACsLTm8qdwQI
         Zu3nCXUDaPgvxyFC32qCXmXb6bu74+W40oQb/GC54Ms/yK/bpVSZVqyIAvs1z6jTNEb2
         K8sx3jTzc3VPY+/WdvBtkorYVhBovt/qb7UJD+aB4/4q17yBdqPf/XGJ06cN+V3M69YC
         qRy0u0rAZr9XDBbAxCU3FMklq1fcE/QDjO5fto3UIR9e0elW8uRC5KPz4Bk7rggo/hbr
         YK+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773674376; x=1774279176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m2chYU1ux6ZQIx4otnZe8opROVQFDtOWN8KCrqkEk7A=;
        b=WDj5QunK+Q6mtUfoHZeJezV5ULdjyADfNHLiMPt1CJGllg/OKJmse9R/qhQnOAdjij
         aidO557xdHPg06tB+AjoGf/umGpy6uo990PbL3tfy2agPpg2X//1hVXhsjZx5XkHIx0J
         Y40QRkGAhM+vZ6EsAs+9GN8XUTOCOYML6m1CP3C/0gk3LIpJL3ZUEoPt9m23wRQruw9D
         KQZQF9DK142b0fPsHhF+9olEqqMEvnw+mpFTg3f+SfdFx7u6WmeQuyljNTY8HPKRPf1J
         /n2qPYGZ+LGW7g3p4BXJMA2+XwPPB+aQXqZM0T/K61ixh/T9VtQQrTJMgz9h885Z1bCF
         I8VQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnEgFPQcsG9bZDCjY/sdyP7tM7QLAXWZN/tL+8jyjp4/TYZRmC8+CnCye2itq08I0hhmGzIOmZhts=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVoVY8UC39JLWYyDBCaSV9CbdZEP9DXwzfdXCJwyWT+kHHwNMe
	Hg/diUHiv51zSlQpOJq8TDBEjILOZ4XzaNQcLfV8i+O/1xGeR7BFyg2A
X-Gm-Gg: ATEYQzxczf5tP6ywppQTcWyIMbJXd8OQECIRabDmETbbqFtJBLEKlyJIOQ4CdlZoib1
	Lshu5F98QGe0Ad9boKFAGSxkDKZMg2DCq/yVGyLVL0v7nE1AHwRZXRswYXwmPULCQuWw3ahwCuL
	cJkfcQxH2jGTUD7YifzBQY86RQBKEcrL5mkAGGouE/IpBIj5EfAD6EBDDEDuGWZ9UA4Q+0fBX12
	1wrLMImNK65dkC+esoVysEinhAEsC6EiR5nWHHpFz6hF6aVmmlO9h1UGmxqNSNqii+DEVLparPX
	DYN17dPedyt40aYEl9oq/nSHgY8xZYrcZTNzsnUBIWNfxJeRTrz9otgnp96hXHDjH/SRsm4nuDw
	hlui3Gl5Fap8dBrhJNUMP0EOur4NhOncs/Z+1JQPTnRdq8/R8DieGbUcNvN8SMbX3Xn0EClDVGQ
	+lNnbzzgrriNBXFNfYQviHHQ==
X-Received: by 2002:a05:6830:648b:b0:7d7:4074:3382 with SMTP id 46e09a7af769-7d78248b731mr8382454a34.10.1773674375662;
        Mon, 16 Mar 2026 08:19:35 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:41::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d76ac8ce73sm13670944a34.11.2026.03.16.08.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 08:19:35 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Rakie Kim <rakie.kim@sk.com>
Cc: akpm@linux-foundation.org,
	gourry@gourry.net,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	byungchul@sk.com,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	kernel_team@skhynix.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com
Subject: Re: [LSF/MM/BPF TOPIC] [RFC PATCH 0/4] mm/mempolicy: introduce socket-aware weighted interleave
Date: Mon, 16 Mar 2026 08:19:32 -0700
Message-ID: <20260316151933.3093626-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260316051258.246-1-rakie.kim@sk.com>
References: 
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Rakie! I hope you have been doing well. Thank you for this
RFC, I think it is a very interesting idea. 

[...snip...]

> Consider a dual-socket system:
> 
>           node0             node1
>         +-------+         +-------+
>         | CPU 0 |---------| CPU 1 |
>         +-------+         +-------+
>         | DRAM0 |         | DRAM1 |
>         +---+---+         +---+---+
>             |                 |
>         +---+---+         +---+---+
>         | CXL 0 |         | CXL 1 |
>         +-------+         +-------+
>           node2             node3
> 
> Assuming local DRAM provides 300 GB/s and local CXL provides 100 GB/s,
> the effective bandwidth varies significantly from the perspective of
> each CPU due to inter-socket interconnect penalties.
> 
> Local device capabilities (GB/s) vs. cross-socket effective bandwidth:
> 
>          0     1     2     3
> CPU 0  300   150   100    50
> CPU 1  150   300    50   100
> 
> A reasonable global weight vector reflecting the base capabilities is:
> 
>      node0=3 node1=3 node2=1 node3=1
> 
> However, because these configured node weights do not account for
> interconnect degradation between sockets, applying them flatly to all
> sources yields the following effective map from each CPU's perspective:
> 
>          0     1     2     3
> CPU 0    3     3     1     1
> CPU 1    3     3     1     1
> 
> This does not account for the interconnect penalty (e.g., node0->node1
> drops 300->150, node0->node3 drops 100->50) and thus forces allocations
> that cause a mismatch with actual performance.
> 
> This patch makes weighted interleave socket-aware. Before weighting is
> applied, the candidate nodes are restricted to the current socket; only
> if no eligible local nodes remain does the policy fall back to the
> wider set.

So when I saw this, I thought the idea was that we would attempt an
allocation with these socket-aware weights, and upon failure, fall back
to the global weights that are set so that we can try to fulfill the
allocation from cross-socket nodes.

However, reading the implementation in 4/4, it seems like what is meant
by "fallback" here is not in the sense of a fallback allocation, but
in the sense of "if there is a misconfiguration and the intersection
between policy nodes and the CPU's package is empty, use the global
nodes instead". 

Am I understanding this correctly? 

And, it seems like what this also means is that under sane configurations,
there is no more cross socket memory allocation, since it will always
try to fulfill it from the local node. 

> Even if the configured global weights remain identically set:
> 
>      node0=3 node1=3 node2=1 node3=1
> 
> The resulting effective map from the perspective of each CPU becomes:
> 
>          0     1     2     3
> CPU 0    3     0     1     0
> CPU 1    0     3     0     1

> Now tasks running on node0 prefer DRAM0(3) and CXL0(1), while tasks on
> node1 prefer DRAM1(3) and CXL1(1). This aligns allocation with actual
> effective bandwidth, preserves NUMA locality, and reduces cross-socket
> traffic.

In that sense I thought the word "prefer" was a bit confusing, since I
thought it would mean that it would try to fulfill the alloactions
from within a packet first, then fall back to remote packets if that
failed. (Or maybe I am just misunderstanding your explanation. Please
do let me know if that is the case : -) )

If what I understand is the case , I think this is the same thing as
just restricting allocations to be socket-local. I also wonder if
this idea applies to other mempolicies as well (i.e. unweighted interleave)

I think we should consider what the expected and desirable behavior is
when one socket is fully saturated but the other socket is empty. In my
mind this is no different from considering within-packet remote NUMA
allocations; the tradeoff becomes between reclaiming locally and
keeping allocations local, vs. skipping reclaiming and consuming
free memory while eating the remote access latency, similar to
zone_reclaim mode (packet_reclaim_mode? ; -) )

In my mind (without doing any benchmarking myself or looking at the numbers)
I imagine that there are some scenarios where we actually do want cross
socket allocations, like in the example above when we have very asymmetric
saturations across sockets. Is this something that could be worth
benchmarking as well?

I will end by saying that in the normal case (sockets have similar saturation)
I think this series is a definite win and improvement to weighted interleave.
I just was curious whether we can handle the worst-case scenarios.

Thank you again for the series. Have a great day!
Joshua
