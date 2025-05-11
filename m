Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863882AD32;
	Sun, 11 May 2025 02:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746930687; cv=none; b=Rbqu3wYKcR/K7hSqxzlJQQ3q7ewqSZLeq1BoDtOOqlT7o1NBrNehhUeig4IaQWzo3X4mri/x93IQ6XGwvaxnCGUN+Uwswm3UiV4OTdkg9Puv8moN+CxHKqiRLJPCVr08O5J/YrwXU21xHXfUStBvX+jEUr8OwQ11v/UoI8ERffs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746930687; c=relaxed/simple;
	bh=Pui+gJ05zTBN0Y1TNBUQ6PtfD577tid1uux/0fpAa2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NwwfGl23w8dj41tDSwlws7P/0xnVnl0UzR3iX3YhQrvS8ElAxXcBSYZZc0U3rcPrWvBYZm3ya++s95LuiR/sx32ho2bqKqJXzwjGxdM1gvwHNaVk98MSadyarzo+ne6WJkeuvE+7vAujpnMiUzsuIZ8sm3omhKbCwTSUecXiDcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ADf3ZH6y; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ADf3ZH6y"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=WIHb4Z+2RBXZsRSuj2QOPOCrXdKzLJsFDY0oSlQl2Ww=; b=ADf3ZH6y8wXFvR1hTd3RNn9zW9
	+MKt+oW3jPUykuGaYA4IDZdQGBH8Ty8xrrxQXaLF1olNj0st0U4hV+bsfsQjqnkvGVkKpoV00E/bq
	U3nnWJg0WYbxxzLCX03oZuPw6kL3C4VtECwHRmC82320T7jrc/GE/SUcPQbOJfIHtQQ59BKqqVl01
	92l07vPtq5wVZRgOIC6Esjdpiulxg//sZ6msJ5PgD3ROht9Xa+B/eXDQvvWUp6JWmgg0yS07XF80X
	MUbnlLDPcRQs78lhpmWsm6/j6k36z8hqcf2Hu3PxbI+hBI2MsrBC0P4L0nd8SPqliMlnWAyY9Il9b
	o2mqeEyA==;
Received: from [50.39.124.201] (helo=[192.168.254.17])
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1uDwTJ-0000000GXRt-3U7G;
	Sun, 11 May 2025 02:31:22 +0000
Message-ID: <2abca2ae-d53a-4324-b74f-0f189b41f1ae@infradead.org>
Date: Sat, 10 May 2025 19:31:17 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 14/18] cxl: docs/allocation/reclaim
To: Gregory Price <gourry@gourry.net>, linux-cxl@vger.kernel.org
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 ira.weiny@intel.com, dan.j.williams@intel.com, corbet@lwn.net
References: <20250430181048.1197475-1-gourry@gourry.net>
 <20250430181048.1197475-15-gourry@gourry.net>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250430181048.1197475-15-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/30/25 11:10 AM, Gregory Price wrote:
> Document a bit about how reclaim interacts with various CXL
> configurations.
> 
> Signed-off-by: Gregory Price <gourry@gourry.net>
> ---
>  .../driver-api/cxl/allocation/reclaim.rst     | 51 +++++++++++++++++++
>  Documentation/driver-api/cxl/index.rst        |  1 +
>  2 files changed, 52 insertions(+)
>  create mode 100644 Documentation/driver-api/cxl/allocation/reclaim.rst
> 
> diff --git a/Documentation/driver-api/cxl/allocation/reclaim.rst b/Documentation/driver-api/cxl/allocation/reclaim.rst
> new file mode 100644
> index 000000000000..f37c8b1cc3bd
> --- /dev/null
> +++ b/Documentation/driver-api/cxl/allocation/reclaim.rst
> @@ -0,0 +1,51 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=======
> +Reclaim
> +=======
> +Another way CXL memory can be utilized *indirectly* is via the reclaim system
> +in :code:`mm/vmscan.c`.  Reclaim is engaged when memory capacity on the system
> +becomes pressured based on global and cgroup-local `watermark` settings.
> +
> +In this section we won't discuss the `watermark` configurations, just how CXL
> +memory can be consumed by various pieces of reclaim system.
> +
> +Demotion
> +========
> +By default, the reclaim system will prefer swap (or zswap) when reclaiming
> +memory.  Enabling :code:`kernel/mm/numa/demotion_enabled` will cause vmscan
> +to opportunistically prefer distant NUMA nodes to swap or zswap, if capacity
> +is available.
> +
> +Demotion engages the :code:`mm/memory_tier.c` component to determine the
> +next demotion node.  The next demotion node is based on the :code:`HMAT`
> +or :code:`CDAT` performance data.
> +
> +cpusets.mems_allowed quirk
> +--------------------------
> +In Linux v6.15 and below, demotion does not respect :code:`cpusets.mems_allowed`
> +when migrating pages.  As a result, if demotion is enabled, vmscan cannot
> +guarantee isolation of a container's memory from nodes not set in mems_allowed.
> +
> +In Linux v6.XX and up, demotion does attempt to respect
> +:code:`cpusets.mems_allowed`; however, certain classes of shared memory
> +originally instantiated by another cgroup (such as common libraries - e.g.
> +libc) may still be demoted.  As a result, the mems_allowed interface still
> +cannot provide perfect isolation from the remote nodes.
> +
> +ZSwap and Node Preference
> +=========================
> +In Linux v6.15 and below, ZSwap allocates memory from the local node of the
> +processor for the new pages being compressed.  Since pages being compressed
> +are typically cold, the result is a cold page becomes promoted - only to
> +be later demoted as it ages off the LRU.
> +
> +In Linux v6.XX, ZSwap tries to prefer the node of the page being compressed
> +as the allocation target for the compression page.  This helps prevernt

                                                                  prevent

> +thrashing.
> +
> +Demotion with ZSwap
> +===================
> +When enabling both Demotion and ZSwap, you create a situation where ZSwap
> +will prefer the slowest form of CXL memory by default until that tier of
> +memory is exausted.

             exhausted.


-- 
~Randy

