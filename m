Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F231862A;
	Tue, 28 Oct 2025 16:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761667300; cv=none; b=kXsS5sljeYSjQ+A7jpNfeMBP//Z1wW2h+wMY1w1VQGdxIi0dxoQdTFSBqx4r2kSJ8ULXg2ldSkju7LVQr4c2PaGL15MfdkldWzelkG7pVjW9OnZFifpGlsbE9NyY7qiqZFamYx8s6klUT8AmF0IpvAoSJJSnK4VuHBiNi8lBDMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761667300; c=relaxed/simple;
	bh=Dx687kzusllViaObMvR4QwPo8tHehrbtHSv9Iud7y8Q=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nDkNwth2Z1DzQkDHrnTGVpJVoEWQJg3WD4eEAIWrURlPYlmms5sBEqB3KXzkokpJu+bwjaOXF+w8g7zHXBZzbhwlRDWmPpS4T1c7aVttGIU45lSFpDhh8lnRZtX0wIKhkJAmTwBTXpRnlHaD714o8frzalOt4V5d5pOozNMUwDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cww7C6ThYz6L4sZ;
	Tue, 28 Oct 2025 23:59:51 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 4E4B11402FF;
	Wed, 29 Oct 2025 00:01:35 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 28 Oct
 2025 16:01:34 +0000
Date: Tue, 28 Oct 2025 16:01:33 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Gregory Price <gourry@gourry.net>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Documentation/driver-api/cxl: remove page-allocator
 quirk section
Message-ID: <20251028160133.000004ca@huawei.com>
In-Reply-To: <20251003143233.1985150-1-gourry@gourry.net>
References: <20251003143233.1985150-1-gourry@gourry.net>
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
 dubpeml100005.china.huawei.com (7.214.146.113)

On Fri,  3 Oct 2025 10:32:32 -0400
Gregory Price <gourry@gourry.net> wrote:

> The node/zone quirk section of the cxl documentation is incorrect.
> The actual reason for fallback allocation misbehavior in the
> described configuration is due to a kswapd/reclaim thrashing scenario
> fixed by the linked patch.  Remove this section.
> 
> Link: https://lore.kernel.org/linux-mm/20250919162134.1098208-1-hannes@cmpxchg.org/
> Signed-off-by: Gregory Price <gourry@gourry.net>
Not looked into it in detail but I'll take your word for it that
the text below is wrong.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
>  .../cxl/allocation/page-allocator.rst         | 31 -------------------
>  1 file changed, 31 deletions(-)
> 
> diff --git a/Documentation/driver-api/cxl/allocation/page-allocator.rst b/Documentation/driver-api/cxl/allocation/page-allocator.rst
> index 7b8fe1b8d5bb..3fa584a248bd 100644
> --- a/Documentation/driver-api/cxl/allocation/page-allocator.rst
> +++ b/Documentation/driver-api/cxl/allocation/page-allocator.rst
> @@ -41,37 +41,6 @@ To simplify this, the page allocator will prefer :code:`ZONE_MOVABLE` over
>  will fallback to allocate from :code:`ZONE_NORMAL`.
>  
>  
> -Zone and Node Quirks
> -====================
> -Let's consider a configuration where the local DRAM capacity is largely onlined
> -into :code:`ZONE_NORMAL`, with no :code:`ZONE_MOVABLE` capacity present. The
> -CXL capacity has the opposite configuration - all onlined in
> -:code:`ZONE_MOVABLE`.
> -
> -Under the default allocation policy, the page allocator will completely skip
> -:code:`ZONE_MOVABLE` as a valid allocation target.  This is because, as of
> -Linux v6.15, the page allocator does (approximately) the following: ::
> -
> -  for (each zone in local_node):
> -
> -    for (each node in fallback_order):
> -
> -      attempt_allocation(gfp_flags);
> -
> -Because the local node does not have :code:`ZONE_MOVABLE`, the CXL node is
> -functionally unreachable for direct allocation.  As a result, the only way
> -for CXL capacity to be used is via `demotion` in the reclaim path.
> -
> -This configuration also means that if the DRAM ndoe has :code:`ZONE_MOVABLE`
> -capacity - when that capacity is depleted, the page allocator will actually
> -prefer CXL :code:`ZONE_MOVABLE` pages over DRAM :code:`ZONE_NORMAL` pages.
> -
> -We may wish to invert this priority in future Linux versions.
> -
> -If `demotion` and `swap` are disabled, Linux will begin to cause OOM crashes
> -when the DRAM nodes are depleted. See the reclaim section for more details.
> -
> -
>  CGroups and CPUSets
>  ===================
>  Finally, assuming CXL memory is reachable via the page allocation (i.e. onlined

