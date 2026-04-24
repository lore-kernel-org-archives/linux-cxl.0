Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E5629ACCD
	for <linux-cxl@vger.kernel.org>; Fri, 24 Apr 2026 06:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777012488; cv=none; b=aZEHQus36KUk25SuAFO6J8s2id7rLRcDKNSJreH71pLVr281ig9OpQFrl2gwTbKyAQT9HpJ4rr61TEcaY/4RHI+flsfQB3fJppG2zg7+835yIlQz2YXvW97OwZGFpzCOWB7fEU/QwKlb0TGv88TFoB69j2BwTAeDIFbUrhEktEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777012488; c=relaxed/simple;
	bh=jgiJ3Y2SlkV9kwNakc1V6gDpr64iT7Y2FyUL/UeCM/M=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rh6Ed9weu410+U1cifB7aiOHjAMl3dMmKsgXQIMLQmkEhxdX6i7iU48SOvD0dvaJrdOvwgKbdTFC9e5huASP1gR+Bvbtvcw8Bs3tmlwWI4L4NOjIhCrLIY4iLXdaeD9K7Fhu6OHXl6e/FYKLIrDqOlamUGGmkx/WFBuBjtBVl4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qHRavv2m; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qHRavv2m"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2d96243c91fso11708583eec.1
        for <linux-cxl@vger.kernel.org>; Thu, 23 Apr 2026 23:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777012485; x=1777617285; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CjqjMDSnQiv+VdsVSEhmqx1RDmYUs+TDJJtITK0bPSw=;
        b=qHRavv2mXfRlEtdQYEBLCNPTSIemN6HjoqGxslhX6m0//IIdk3Q2XQpzZfVC/Cg4Mj
         VHZxDYvtMRR8gJnsZZeZSQVJPT/F5gVXmsMq7uckpU6xMeA7UZfOnWsLRm0NaifffAP7
         RvZVL+pGI0DdFwk8KEO2orU8hJeNvD1Wiw/ZUv1VSGFLQgmDiH8xyFZEJvqUdYX18qK6
         JsxB1M+vR+7/PByHL0rB8SRmDK7Q+V+o46VGuM9y/+oRe7qaptCeJjVg2wIuhjzLInjN
         dXT/yp7/pnoTOxLJg/e/mwhXape1uwFyuIKS+bR014vHHAaAD4viJijX/g80KkflNXDe
         zcAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777012485; x=1777617285;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CjqjMDSnQiv+VdsVSEhmqx1RDmYUs+TDJJtITK0bPSw=;
        b=hEE+TBcovWs7BiS+5ePefGoYSiJpnHYd03IjG/Jnm5P2GNhkhA+XfVPiWAeNXo8jq1
         PkYYsPKoS7X5UwbsSmQnXHWssvtj5SgAF8QQR9arK9ypP/pnEkjZKZxGhVS6qpBn5uld
         e6S1KoE3xgOBwNmJRSGWbpbdkwquRA/R4W2tYwYMfVPQWbSKFsfvN2Fg4piI2LqrexF/
         LpeN2aXq3Jw9VS8rQeYP2li8fZ0sjKEqgAu+JjAFbPswqzpQBXa13tbsrjUhED6ItD4u
         7OrwXzZ9a5bezvPyerzXOqgp9gYwvrz2xyiH2ZzQM9c70QlDoYTiEKuq8zQ5ZF7a1Ax6
         mkWw==
X-Forwarded-Encrypted: i=1; AFNElJ+c5VJXgOk/HErSi9MUGgF4Y/BXxUumnQnPfqCOC1sEPmGNJoK5X8IjYeHG5S62HwOFWoWtZDNAA4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEDeBH2wihDpL9rNGy9I+Q9YBDUP7zMtiThuw5eDQp5eqNdPwY
	dzmAJ7kAyGACk0zs4SZAJPaEgBvppC86A+Vn2dEVSW/JQyJl/+WVs/wh
X-Gm-Gg: AeBDietIizD22DNEscheMMxx+cNRPkKwaQtmYJmBGIjkf3fIKTx2HhK5f+5iArDKTc/
	T3tjIV7/WJuYUgjJrEWDjmLQRc9l667UJeDm803DVcvpOmZUeiovJBT4zVxuivGVaGPLFP6m13G
	kkLxq+rvl/XFURXmMYBxsNs6EvjTYzawz6ABrmstBGFCAjhtyuMVZLtRAbI5k1/udSbN/KBItK6
	xX7VNcKg6fLOY4cdHvrpEje5JxcnzqghvAJLIGhyhJHJZDmZ9r4H7p9nittoXkmhIkqwcgvrgdE
	ZV/xyq1vaHpBoc5bRZb9PiuDY74YxKkNi2Sbs+eVY2Gl/bGtvgO5vqHFK5F/62HbOVlTDMuPWhA
	H8/Hm/P7Wb3u2QgJ2e2GTPNeyQ2Wu35oIKZQbUDEt7kDmAJYWN4SzI+WDMVFggznVrGnad0Ln2E
	hHZuZkqDlUVoUpACcYHUuqX5Ewk0BWEgsdRGsE35oixkhvHpO+I4fqkEbf0sWyvqoYj9xVmRQVl
	CJgtrXCENrQ23w/z9jxjYU=
X-Received: by 2002:a05:7300:6c05:b0:2d4:2cc8:67e with SMTP id 5a478bee46e88-2e47a106ccfmr17594838eec.23.1777012484979;
        Thu, 23 Apr 2026 23:34:44 -0700 (PDT)
Received: from 4470NRD-ASU.ssi.samsung.com (c-73-170-217-179.hsd1.ca.comcast.net. [73.170.217.179])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53d9b056fsm40279171eec.29.2026.04.23.23.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 23:34:44 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Thu, 23 Apr 2026 23:34:42 -0700
To: John Groves <john@jagalactic.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	John Groves <John@groves.net>, Fan Ni <fan.ni@samsung.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	Robert Richter <rrichter@amd.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"dev.srinivasulu@gmail.com" <dev.srinivasulu@gmail.com>,
	"arramesh@micron.com" <arramesh@micron.com>,
	"ajayjoshi@micron.com" <ajayjoshi@micron.com>
Subject: Re: [RFC PATCH 0/4] cxl/extent: Enable and validate multi-extent DCDs
Message-ID: <aesPAvUION9Zsadu@4470NRD-ASU.ssi.samsung.com>
References: <20260423235108.3732424-1-john@jagalactic.com>
 <0100019dbcc13648-596853f3-0083-46e0-b654-396eedd657cb-000000@email.amazonses.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0100019dbcc13648-596853f3-0083-46e0-b654-396eedd657cb-000000@email.amazonses.com>

On Thu, Apr 23, 2026 at 11:51:12PM +0000, John Groves wrote:
> From: John Groves <john@groves.net>
> 
> This series fixes correctness issues in the DCD (Dynamic Capacity
> Device) add-capacity pipeline so that multi-tag allocations, sharable
> CDAT regions, and cross-partition checks work end-to-end.
> 
Thanks for the fixes, this makes way more sense. Let me see if I can squash
these nicely before LSFMM :)

One question based off the initial read:
When we do the actual dax device creation via daxctl create-device, would we
want to add an optional arg specifying uuid? I think right now, each
region_extent becomes a dax_resource of the sparse dax region and create-device
grabs any unused dax_resource if -s isn't specified. So if we want to limit to
1 tagged allocation/DAX device, we would want some way to specify that.
But let me double check tomorrow

Thanks,
Anisa

> Base
> ----
> 
> The series applies on top of Anisa Su's DCD stack — specifically the
> tip of famfs-v9-dcd on the 'anisa' remote
> (git@github.com:anisa-su993/anisa-linux-kernel.git).  That stack is
> the one posted to linux-cxl here:
> 
>   https://lore.kernel.org/linux-cxl/adnWg-60uKmduTsh@gourry-fedora-PF4VCD3F/T/#t
> 
> I started out commenting on prior series, then started modifying it,
> before settling on this initial approach of generalizing the
> functionality through additional patches. I'm hoping the stake holders
> will find this easy to follow - at least as easy to follow as something
> this tedious and nuanced can be.
> 
> Also, as one of the authors of the DCD spec: Now I get why this was hard
> to follow and implement. The implementation is pretty complicated.
> 
> Note that this RFC builds happily, but I have not tested it yet. This
> exercise has been about fleshing out the full logic.
> 
> The patches
> -----------
> 
>  1) cxl/extent: Promote cxlr_dax->region_extent to an xarray
> 
>     Infrastructure only.  Replaces the single-slot region_extent
>     pointer on struct cxl_dax_region with an xarray keyed by an
>     allocator-assigned u32.  No behavior change; prepares storage for
>     multiple tagged allocations per DAX-region shim.
> 
>  2) cxl/extent: Fix DCD add-capacity: per-tag assembly, ordering, and
>     integrity
> 
>     Rewrites the add-capacity pipeline around the tag as the unit of
>     allocation (not the More-chain).  Drops the DPA-contiguity reject,
>     assembles each tag group separately, stable-sorts by
>     shared_extn_seq, and adds cross-More-chain uniqueness,
>     sequence-integrity, and alignment gates.  Lifts the single-slot
>     "already onlined" gate now that (1) is in place.
> 
>  3) cxl/extent: Support extents in sharable CDAT regions
> 
>     Drops the per-extent rejection of shared_extn_seq != 0 and
>     replaces it with a partition-aware check driven by the DSMAS
>     SHAREABLE bit already exposed through cxl_dpa_partition.
> 
>  4) cxl/extent: Reject tagged extents that span DC partitions
> 
>     Adds a group-level check rejecting tagged allocations whose
>     extents resolve to different DC partitions.  A single host-visible
>     allocation cannot meaningfully straddle partitions whose CDAT
>     attributes disagree.
> 
> Signed-off-by: John Groves <John@Groves.net>
> 
> John Groves (4):
>   cxl/extent: Promote cxlr_dax->region_extent to an xarray
>   cxl/extent: Fix DCD add-capacity: per-tag assembly, ordering, and
>     integrity
>   cxl/extent: Support extents in sharable CDAT regions
>   cxl/extent: Reject tagged extents that span DC partitions
> 
>  drivers/cxl/core/extent.c |  93 +++---
>  drivers/cxl/core/mbox.c   | 628 +++++++++++++++++++++++++++++++-------
>  drivers/cxl/core/region.c |   2 +
>  drivers/cxl/cxl.h         |   9 +-
>  include/cxl/event.h       |   1 -
>  5 files changed, 584 insertions(+), 149 deletions(-)
> 
> -- 
> 2.53.0
> 
> 
