Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE82371CE2
	for <linux-cxl@vger.kernel.org>; Fri,  1 May 2026 22:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777672818; cv=none; b=EbsSl9qpDgdOjUhJv2o8oqDIB9kWdv86G3y7+QI+r9fSYame2JPvR5eSTLA0+QKEbttMOJfvQfr63aA269abtoOtr3fdEt+zZ8Us9RS+IpJq/7kqisoz/mN+E1pX5r1f7PzSsCc1atXuq2z9LdoW2Eg8gv13oJmSKsinDzMHDPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777672818; c=relaxed/simple;
	bh=HZMQXhrH+gFn1GHE3MmIZPFjuGT1da8cxfeAAxXMSWo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W80pulqRq/g7bLrOKUoiNQUEUZm4L10yMlTiYrKUGRgK1pwYZli2CqHggp4ECkZBvYHqzjmbNVg7zyMaeFgzIXFek2mnztUb7y6fSpDqR5gqbPobSa15X2w413ABXLKlhFcKjbO3LNYfGZGU6k6O1akFIbzbi/ALBbdunheMgFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iU5zMfOx; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iU5zMfOx"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-79885f4a8ffso25002237b3.3
        for <linux-cxl@vger.kernel.org>; Fri, 01 May 2026 15:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777672812; x=1778277612; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X/l2cktRE93U2qfSy1tTbG0Ksdvw5zB/NmRLo0A8LTk=;
        b=iU5zMfOxL9SbWPS+9Z9qj2o55czwHr1kM6uTXVNI7q50w95wY+QJ6UdEpu54JUmBxm
         yJcLK87NCmUzJCUwUbsn5VX4LCanay5RPaACAavga5iSOt0wMVF2dfOwAUoDLh8RBbb4
         +XLJKwuuZTKKhjqabi9kOb+HBSleEafKmqa5Yn6imn7/mWBJe/Z5ec13Lpm9/6uWaRGi
         rbN+ByToCr3syQDymQ13iTe7T4wDv58ZoOvs8KFK1QPTh5oEwvHbxW7Ui8CywMWDvmu4
         Qn1LMr2wxVogIMJVbhSTqAzaNYSv1LO1ZWiD/UIuPvRDLsLeM+H/RpH2DDDzHdZYetj1
         rjGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777672812; x=1778277612;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X/l2cktRE93U2qfSy1tTbG0Ksdvw5zB/NmRLo0A8LTk=;
        b=facNxoZ59U8ddIX0unJpZRhoHXPkIpIRIUvrEvho6AErF0Tu7MQbd3MF/PofVo0lDv
         8cRMepMrabb/G29BYzZoXz1FI16QboICDgfSNOFCNifpWQK+5U/9BYv/UNCIwQ8XrnRs
         anJj8JktkZigrl4Qk0+wQMyRrGhI1uABvmxIFhi8vAKgN1rOvxv1bU7kskYNDr2HcDfC
         eQJ0+7iiFElho+HCxEgyFaUVFvzCfmoP21ObzjfzjHUC/92DgzmeNkULMc+qs3Pu99rM
         RjePOTkqhlZySrx28hxPTEAwTvZB92ttSejd1IBGPy15MKXS68B0s1CCiKOFv5NrFyra
         +xjA==
X-Forwarded-Encrypted: i=1; AFNElJ+4C6XtNVheWxU+DyHa4AP9AhPZAb7tvRoLmxwparNj3MAHb7DNY5YrSQFVmyY/UWphtqFjE3TCv+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YysYbZSKfbAv4dlvalSsu99/9sEqVHwRc0jgczSQ/SmVX7sSv5E
	fv/yAx0rGMqreJEs2LjjYcozhiiSwaPFHw4gjgqMdt3OmmKnblXLVJEs
X-Gm-Gg: AeBDies2zx/zacWoCTzvImLxHeqLCwEbvx7stADOdu3chvRzj7xt4WR/NYSuCuqVqm5
	0fKXg+FY15Rx+FSLXXK8nMFSv2fRcetpgqcxNoY+Pctu7cZbvACnlVmrEEI36ACmxo5tN6nfefp
	uTz3m07NhdBqa635zNQVhmLwfoKIPpGTWTGOuezFW18SS6p0Ei4p9aRb+lvJYLCh75huoBqgUtG
	h6yry3qhYS/BEr6kqWMs5UtjkH1ZfrCU8ItlZvAzDR7TeoA7YwdApnjA2dVLrkeOPMHIiPdc5bv
	QO8H1jksI62x9UU9aBvotoC6YliAtyxEOAS7dBKl2c0dEFhA5Tk4EqWhqBXzx9YuHgsXKPy4BPW
	7wUdrXp2yNSs1ky3ddhnJJ0533bD6nZlqqjh/guLXfkNuXeuHuDPYzxWUxH45h11SPV3WvDGr74
	lxenjIZ4VJHdmijIvAtHdeDfjNtCXS9+gPMZIuM0Gq18b0Mi1R7Goy
X-Received: by 2002:a05:690c:c513:b0:7b3:401f:2e45 with SMTP id 00721157ae682-7bd77144be0mr13225337b3.44.1777672811911;
        Fri, 01 May 2026 15:00:11 -0700 (PDT)
Received: from 4470NRD-ASU.ssi.samsung.com ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65c2e1bb5adsm1780292d50.7.2026.05.01.15.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 15:00:11 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Fri, 1 May 2026 15:00:07 -0700
To: John Groves <john@jagalactic.com>, Gregory Price <gourry@gourry.net>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, Dan Williams <djbw@kernel.org>,
	John Groves <John@groves.net>, Shiju Jose <shiju.jose@huawei.com>,
	Robert Richter <rrichter@amd.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"dev.srinivasulu@gmail.com" <dev.srinivasulu@gmail.com>,
	"arramesh@micron.com" <arramesh@micron.com>,
	"ajayjoshi@micron.com" <ajayjoshi@micron.com>
Subject: Re: [RFC PATCH 0/4] cxl/extent: Enable and validate multi-extent DCDs
Message-ID: <afUiZ27UtF3589IR@4470NRD-ASU.ssi.samsung.com>
References: <20260423235108.3732424-1-john@jagalactic.com>
 <0100019dbcc13648-596853f3-0083-46e0-b654-396eedd657cb-000000@email.amazonses.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0100019dbcc13648-596853f3-0083-46e0-b654-396eedd657cb-000000@email.amazonses.com>

On Thu, Apr 23, 2026 at 11:51:12PM +0000, John Groves wrote:
> From: John Groves <john@groves.net>
> 
> This series fixes correctness issues in the DCD (Dynamic Capacity
> Device) add-capacity pipeline so that multi-tag allocations, sharable
> CDAT regions, and cross-partition checks work end-to-end.
> 
[snip] 
Hi John,

I've already squashed your branches to a GH branch so they're just hanging out
until we get some more feedback.
But I do have some food for thought relating to the DAX layer changes that would
be required to make this patchset function the way it's intended:

Currently DAX device creation is not tag-aware. This patchset only affects the
conditions of when we choose to accept/reject extents. But accepted extents just
hang out under the region until a DAX device is created and
claims resources on the region.

Currently, doing daxctl create-device on a dynamic_ram_a type region does 2
things:

daxctl create-device -r region0 -s requested_size
1. create a 0-sized dev_dax seed:
	- create_store()
	- extents must have been added to the region already, otherwise returns
	  -ENOSPC
		avail = dax_region_avail_size(dax_region);
		if (avail == 0)
			rc = -ENOSPC;
	- creates a 0-sized DAX device seed (Sparse DAX region devices must be
	  created initially with 0 size)

2. resize the empty dev_dax to requested_size or the size of the region if -s
not specified
	- size_store(to_alloc = requested_size ? requested_size :
	  dax_region_avail_size(dax_region))
	- dev_dax_resize()
	- iterates over each child resource of the region to find unused
	  resources and claims them up to min(available_size, to_alloc)
	- for sparse regions, each child resource = 1 region extent
		- *note*: in Ira's original patchset, each region_extent = 1
		  device extent.
		  Thus each resource under the resource tree of the dax_region
		  corresponds to 1 device extent
		- In the current version: 1 region_extent --> 1 tagged
		  allocation (1+ extents w/the same tag)
		- this should also be cleared up

If we want each DAX device to correspond to a specific tag (tag-aware DAX device
creation):
1. Add tag to struct dax_resource
/**
 * struct dax_resource - For sparse regions; an active resource
 * @region: dax_region this resources is in
 * @res: resource
 * @use_cnt: count the number of uses of this resource
 *
 * Changes to the dax_region and the dax_resources within it are protected by
 * dax_region_rwsem
 *
 * dax_resource's are not intended to be used outside the dax layer.
 */
struct dax_resource {
	struct dax_region *region;
	struct resource *res;
	unsigned int use_cnt;
+	uuid_t tag;
};

2. In the resizing operation:
	- only allow dax device to claim a resource if it has the right tag
	- all resources with that tag must be claimed by that device
	- currently, the logic allows for a DAX device partially claim an extent 
	  if requested_size_to_alloc < size_of_free_extent(s); would need to be
	  disallowed for tagged extents

3. ? New sysfs interface to allow for something like "echo [tag_abcd] >
/sys/.../daxX.Y/tag"

4. If we allow non-tagged extents (as this patchset allows):
	- can non-tagged extents be partially claimed by a DAX device that
	  doesn't have a specified tag?

Ira's original patchset introduced minimal changes to DAX logic. Introducing
tag-awareness to
DAX resize logic may require adding more conditional statements, 
especially if we allow both NULL and non-NULL tags (but there might be a nice
way to do it;
This is just my initial impression, I haven't tried implementing it, and I could
certainly look into it more)

TLDR; some topics for discussion:
1. region_extent to device extent relationship
	- Ira said w/o interleaving, it should remain 1:1, not 1:many for
	  grouping device extents by tag

2. tag-aware DAX device creation
	- changes needed & their implications
	- what to do with non-tagged extents

See you at LSFMM :)

Thanks,
Anisa
 
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
