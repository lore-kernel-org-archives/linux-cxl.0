Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120582512F4
	for <linux-cxl@vger.kernel.org>; Thu,  3 Apr 2025 16:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743698305; cv=none; b=KmMfUcd+NgQWeoI2f4LDaCrIknaF/4UF5KVWL+eXVYNDmMHMa06fA6D+2wAnU1z3NJjBu5ZsM1Hk4kbA5tG4ItIFdSD0ItB2wi109UvASYbx07HcDbxRJP8PyRyAUXWmMl1u5YnFTIcljCLz5ligwO/exyFtjhVtvPx88/vhdO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743698305; c=relaxed/simple;
	bh=5SabYIMEMRNPM3VOvrmN0vXXi9GCRbx+x5GirPmB6wY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=omfO70P6atFhLE3PLj/OIMxSw8wXoIWKOhfjHYlsAB/MiOP14zwmopWb4Yq7d/qU0MXAKfDv44JByX0HTqR1NXwz2q8mFoG1hAvyAXFT9U1BnrEV570ygryg2mb96Ufz1m726OZDCs1Zv/G08Pf9IZrzG20S0JEErucoNjz+N0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=iBIRRhN7; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="iBIRRhN7"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c59e7039eeso151593285a.2
        for <linux-cxl@vger.kernel.org>; Thu, 03 Apr 2025 09:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1743698302; x=1744303102; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8kHE37hxmRaBTotqSR2RNNVMRoKL4Qo16Blmg/ywGtk=;
        b=iBIRRhN7jeiUupb4562vIHcLU1nSp6n0E9U/inRMF23a+BRqfQ1H6WRIr6/wLEICrf
         hTC/kasHzv66wrl9W0KcjJ13Tx0GmlywkQalHy/fgUQIRzIauea1DrVLrxMoOp7bhLvM
         0yfjHpRmAGTpLDaHZcz7inWWX/IgtJ+R/ARCudeE6fdBlBUGnR/dmiRXN/fYlat756NQ
         Rq483Qxq5LYuEF7oT65wuIYKNG75xcdX5L8it5DPNU86GneqhBgdoisobL0rwmwN4zqS
         zm0BHrC4zYkqDEl+sRRgNjCAwjZPgnmlv9VpRmM6952vFNLURk5OwqsnqIzdDn1FB/vc
         wwtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743698302; x=1744303102;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8kHE37hxmRaBTotqSR2RNNVMRoKL4Qo16Blmg/ywGtk=;
        b=VJo76ldr+f/1Kis8ZH7h6Gt1Mv79QckVGhzJiUGi5RHK2xA5PK32OMQ91UwqK8rcOw
         zk8v9aod5xC+uAQq/s8kyAyRK0Meu7m39Ab1BdsJvEgbWCCw7iYhrXSW/J4MaJPlT67V
         vHHklmM4p/nQC9zGBJvESntp7Pb7PvvawKAgQwjXSusVI/nufxJGLSY7bGumC+GaGdkD
         oqx2f8n5EeOJdzVITSUZJEKZ5zmFOLw83QoT8OA2zQ+yikYpA07Cf3YRv6XPO4aqhPMC
         m51T4Qh27PEWeNe7sFETBfSUye4VSCljuc5rM1yCAcZCGc+rRMlaRko3BOhZvbv2wTAY
         Wi6w==
X-Forwarded-Encrypted: i=1; AJvYcCVdHVqvQh2iGCUfHtjyCQ1cgxhJZV1MAyTbtI2AB3pZ28Y58006BfHKnz96nIQM5fv7lNSgVPNsf10=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3eJJrN4xf+JSWver2d59UuOCVkzSikco7Yxw8iKfd4MOZ+E5l
	nrME6fXbNul6RQngVIphlDatI0SaYc8114O0bqJLG+kipJpzX54vOyo4Sxxb1Yg=
X-Gm-Gg: ASbGncvsvPBckmXL3KZl2Cl2Tk+318j5QZME5FjlXsu1DvyhggBfQ8LUl68VRubDZzc
	rGpKcR9PYjAUpkicIboB2/8jFUHSInNwq/W/7KysvxLDwJdZruKPfNkZhPepqHGPPC4GoPwqPD+
	78YFP931ipdg7C+cloe63VQZjHKCCUawrPhWLhXOpmv6OP0xsNKMripl5E+q9oMS75B9vzWnQQ/
	3oPnPMmmgat1WFZVBR6Bq+m/7hBo8L6CGxTbigNuXyt/cLsFwcZflbN4M4wcaDQCP7GirfqW233
	QuQ5dK4eGJAxTVC+S0EI0Dd3rQN3oO109PoXQgy0htA=
X-Google-Smtp-Source: AGHT+IEEsdFf1LaMB2GezCtiKDLY6ywrkzjcE11zVM3JMzDGnvIDIL//sh7UXZqYvqqen1XIm32Nsw==
X-Received: by 2002:a05:620a:2617:b0:7c3:c3bb:2538 with SMTP id af79cd13be357-7c76df6874bmr420292985a.14.1743698301747;
        Thu, 03 Apr 2025 09:38:21 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c76ea9691asm95683085a.111.2025.04.03.09.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 09:38:21 -0700 (PDT)
Date: Thu, 3 Apr 2025 12:38:19 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Nhat Pham <nphamcs@gmail.com>
Cc: akpm@linux-foundation.org, yosry.ahmed@linux.dev,
	chengming.zhou@linux.dev, sj@kernel.org, linux-mm@kvack.org,
	kernel-team@meta.com, linux-kernel@vger.kernel.org,
	gourry@gourry.net, ying.huang@linux.alibaba.com,
	jonathan.cameron@huawei.com, dan.j.williams@intel.com,
	linux-cxl@vger.kernel.org, minchan@kernel.org,
	senozhatsky@chromium.org
Subject: Re: [PATCH v2] zsmalloc: prefer the the original page's node for
 compressed data
Message-ID: <20250403163819.GA368504@cmpxchg.org>
References: <20250402204416.3435994-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402204416.3435994-1-nphamcs@gmail.com>

On Wed, Apr 02, 2025 at 01:44:16PM -0700, Nhat Pham wrote:
> Currently, zsmalloc, zswap's and zram's backend memory allocator, does
> not enforce any policy for the allocation of memory for the compressed
> data, instead just adopting the memory policy of the task entering
> reclaim, or the default policy (prefer local node) if no such policy is
> specified. This can lead to several pathological behaviors in
> multi-node NUMA systems:
> 
> 1. Systems with CXL-based memory tiering can encounter the following
>    inversion with zswap/zram: the coldest pages demoted to the CXL tier
>    can return to the high tier when they are reclaimed to compressed
>    swap, creating memory pressure on the high tier.
> 
> 2. Consider a direct reclaimer scanning nodes in order of allocation
>    preference. If it ventures into remote nodes, the memory it
>    compresses there should stay there. Trying to shift those contents
>    over to the reclaiming thread's preferred node further *increases*
>    its local pressure, and provoking more spills. The remote node is
>    also the most likely to refault this data again. This undesirable
>    behavior was pointed out by Johannes Weiner in [1].
> 
> 3. For zswap writeback, the zswap entries are organized in
>    node-specific LRUs, based on the node placement of the original
>    pages, allowing for targeted zswap writeback for specific nodes.
> 
>    However, the compressed data of a zswap entry can be placed on a
>    different node from the LRU it is placed on. This means that reclaim
>    targeted at one node might not free up memory used for zswap entries
>    in that node, but instead reclaiming memory in a different node.
> 
> All of these issues will be resolved if the compressed data go to the
> same node as the original page. This patch encourages this behavior by
> having zswap and zram pass the node of the original page to zsmalloc,
> and have zsmalloc prefer the specified node if we need to allocate new
> (zs)pages for the compressed data.
> 
> Note that we are not strictly binding the allocation to the preferred
> node. We still allow the allocation to fall back to other nodes when
> the preferred node is full, or if we have zspages with slots available
> on a different node. This is OK, and still a strict improvement over
> the status quo:
> 
> 1. On a system with demotion enabled, we will generally prefer
>    demotions over compressed swapping, and only swap when pages have
>    already gone to the lowest tier. This patch should achieve the
>    desired effect for the most part.
> 
> 2. If the preferred node is out of memory, letting the compressed data
>    going to other nodes can be better than the alternative (OOMs,
>    keeping cold memory unreclaimed, disk swapping, etc.).
> 
> 3. If the allocation go to a separate node because we have a zspage
>    with slots available, at least we're not creating extra immediate
>    memory pressure (since the space is already allocated).
> 
> 3. While there can be mixings, we generally reclaim pages in
>    same-node batches, which encourage zspage grouping that is more
>    likely to go to the right node.
> 
> 4. A strict binding would require partitioning zsmalloc by node, which
>    is more complicated, and more prone to regression, since it reduces
>    the storage density of zsmalloc. We need to evaluate the tradeoff
>    and benchmark carefully before adopting such an involved solution.
> 
> [1]: https://lore.kernel.org/linux-mm/20250331165306.GC2110528@cmpxchg.org/
> 
> Suggested-by: Gregory Price <gourry@gourry.net>
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
