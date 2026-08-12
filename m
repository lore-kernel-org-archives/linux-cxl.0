Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C719240F729
	for <linux-cxl@vger.kernel.org>; Wed, 12 Aug 2026 11:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786535068; cv=pass; b=iul/c4go0cwG3oUK7BZiEc1vRB8hsGWnvTpfLup6idxZUbQGNt4+Y6kTQeqhdNUjejTLpLu10Ts19TkOu3ZVFSK8XnvH3hPwXeGMdlDNUMaC1gp+XCAxzzt1+f7i/jbht+xzKTWqiILQqJxGlbipkEO6hoy3R4ahGl/+aeG16Po=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786535068; c=relaxed/simple;
	bh=lrPAfXW/tpbbtUy8sKQeR5l3iggxWlNrJXpRFweN/ww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rOU7dYUjH/GRc2BB3juMyAF4rrLtYeJkoXw6RiYOeDmj+Z5/m0r63thPWwQa5IbQe8Zi8p2vsPfqRK72hlrh4fBRVYfXkAerSZUBrMk5gpm28SjVJ13Mu97BI/3SZMXzhYymL1G7t8whG1GqI2QtiMic8EMLv2IUN8UPbupgm9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=BVR2Ylqo; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="BVR2Ylqo"
ARC-Seal: i=1; a=rsa-sha256; t=1786535056; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=DaiQjeK7rQ9fHHh4e9NZLHKkos7eqos7PnVlHnBm8A9Ys8fP8clFTF8ihYLAuIYul+kyQ/GpUFmgn9mWdnHMU0Wgm81UWZXCblQ8R98NWGq5MbPCU1PF/EVGRyNVKA/vjvWIImVxTy4+GQWV/RjEKiWErvIgpgc9MylAx0sLYhE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1786535056; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Or7dfzrQ+jU+goad7gdaoXKc87AnPWm64gPqzTFSYRc=; 
	b=inzL0IvpbuvFxylF8F4y/dGMq+Fu6IX6mFQ9DbrGC1QtS/8p2/VftnVwS53STyqsbyOK59tOS7SlqqeRI8k8kcy+1if+jI0wnR6R9rekKdAJpu5xObOv9LDQNxNqMTBcBZKXRwB4IPi36J+LkyRDljgs24GFFX4lFPvAvDpLb8Q=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786535056;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=Or7dfzrQ+jU+goad7gdaoXKc87AnPWm64gPqzTFSYRc=;
	b=BVR2YlqoY4KWjK0iLO13V6uVfdusQowEKDIvosjzv0LJ/ZOWyGkj9+yhVPyHqPwH
	0Ob9GdEE3hiLnExUHMqrnsyEyoTmEdhbeUAzeox8uhByNnw3P9mIOYhIVcomzP4IUMp
	vpx4ihjy1q8+bZBo7+R/yC6U69lbH8TILc4EKm7w=
Received: by mx.zohomail.com with SMTPS id 1786535052702316.90688317257377;
	Wed, 12 Aug 2026 04:44:12 -0700 (PDT)
Message-ID: <51dc752d-e452-48e8-89e3-54947f215043@zohomail.com>
Date: Wed, 12 Aug 2026 19:44:09 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cxl/cdat: Fix uninitialized stack use in endpoint
 bandwidth gathering
To: Guixin Liu <kanie@linux.alibaba.com>, Davidlohr Bueso
 <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>,
 Ira Weiny <iweiny@kernel.org>
Cc: linux-cxl@vger.kernel.org
References: <20260812060912.54932-1-kanie@linux.alibaba.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20260812060912.54932-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: zu08011227f88eed4329538c9c8eadf97f00002246a238b473cf8564c71660e40d7b87d88825d6e34994e130:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External


在 2026/8/12 14:09, Guixin Liu 写道:
> cxl_endpoint_gather_bandwidth() declares three access_coordinate arrays on
> the stack - pci_coord, sw_coord and ep_coord - without initializing them,
> and relies on its helpers to fill every member. None of them does.
> cxl_pci_get_bandwidth() and cxl_port_get_switch_dport_bandwidth() assign
> only read_bandwidth and write_bandwidth, and
> __cxl_coordinates_combine() assigns an output bandwidth only when both
> input bandwidths are non-zero. Every member a producer declines to set is
> read back as whatever was on the stack.
>
> Both cases occur on real topologies. The latency members of pci_coord and
> sw_coord are never written, yet __cxl_coordinates_combine() sums them
> unconditionally, so the latency reads are undefined on every call. And a
> device whose CDAT DSLBIS reports no bandwidth for an access class leaves
> perf->cdat_coord zero for that class, which is exactly the condition that
> makes __cxl_coordinates_combine() skip the bandwidth assignment and leave
> the ep_coord entry untouched.
>
> The ep_coord case escapes the function: cxl_bandwidth_add() accumulates it
> into the per-upstream-port aggregate that is published through the region's
> access coordinate sysfs attributes, so stack contents are reported to
> userspace as a bandwidth figure. The latency sums are discarded by
> cxl_bandwidth_add() rather than published, but they are still computed from
> uninitialized memory.
>
> Zero initialize the three arrays. Zero is already the value this code uses
> for "not reported" - both the __cxl_coordinates_combine() guard and
> coordinates_valid() test for it - so a member no producer sets now reads
> back as unknown rather than as a plausible number.
>
> Fixes: a5ab0de0ebaa ("cxl: Calculate region bandwidth of targets with shared upstream link")
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
> ---
> This was patch 6/8 of the "cxl: Assorted fixes" series [1]. Per review
> feedback that series is not being reworked as a whole; the fixes are resent
> individually instead. Patches 1, 2 and 7 of the series are dropped, as those
> issues are already fixed in cxl/next.
>
> v1->v2:
> - rebase onto cxl/next
> - rewrite the commit message to describe the behaviour rather than narrate
>    the code change (Alison Schofield)
>
> [1] https://lore.kernel.org/linux-cxl/20260811113608.2815625-1-kanie@linux.alibaba.com/
>
>   drivers/cxl/core/cdat.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index 5c9f07262513..3c6a1537f89b 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -633,9 +633,9 @@ static int cxl_endpoint_gather_bandwidth(struct cxl_region *cxlr,
>   	struct cxl_port *endpoint = to_cxl_port(cxled->cxld.dev.parent);
>   	struct cxl_port *parent_port = to_cxl_port(endpoint->dev.parent);
>   	struct cxl_port *gp_port = to_cxl_port(parent_port->dev.parent);
> -	struct access_coordinate pci_coord[ACCESS_COORDINATE_MAX];
> -	struct access_coordinate sw_coord[ACCESS_COORDINATE_MAX];
> -	struct access_coordinate ep_coord[ACCESS_COORDINATE_MAX];
> +	struct access_coordinate pci_coord[ACCESS_COORDINATE_MAX] = { };
> +	struct access_coordinate sw_coord[ACCESS_COORDINATE_MAX] = { };
> +	struct access_coordinate ep_coord[ACCESS_COORDINATE_MAX] = { };
>   	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>   	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>   	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
>
> base-commit: 7098e9cd98a05c0c5de2fae0c2465f9d966fdd07
