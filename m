Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2BC500959;
	Thu,  8 Jan 2026 15:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767887525; cv=none; b=uZFbyP0lZ29a6df9IxX2CWayVc0gdECuE7ydxqYU3lqkUmSfYNyL5NDMAZbQozTAH3GU5XkXw+MkPqKfnLt5nOKjmns70wS7bqUZKXYJ9Sz72FEjWaCa4Yz7Kmbugj+PhsfxwCZ6VIU3KE6BHT5vcQr/BMVkVjJJkdxHE9UIsMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767887525; c=relaxed/simple;
	bh=UU2RqMlGpVyH6OLg7MUMpB67ilR3zVh7O0e56JESbHY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GTCsJSDaoZwwq1S7+IYxDgq8iIdBZQWtvJFNFg3IDzG/1sGdglHQkwkD1EhbbY0qKar1048hOaw8HffaEv+qEYk+1jGdpKaS17LMIayErevkA5PxWvE6c+NgB+fQpD5wYijnYk8+wFmAdolg9qcdFimU+xB8Rh3G88j37HlEOYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dn8Xk75mbzHnGhc;
	Thu,  8 Jan 2026 23:51:50 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 5CD0240086;
	Thu,  8 Jan 2026 23:51:59 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 8 Jan
 2026 15:51:57 +0000
Date: Thu, 8 Jan 2026 15:51:56 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Akinobu Mita <akinobu.mita@gmail.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <akpm@linux-foundation.org>,
	<axelrasmussen@google.com>, <yuanchu@google.com>, <weixugc@google.com>,
	<hannes@cmpxchg.org>, <david@kernel.org>, <mhocko@kernel.org>,
	<zhengqi.arch@bytedance.com>, <shakeel.butt@linux.dev>,
	<lorenzo.stoakes@oracle.com>, <Liam.Howlett@oracle.com>, <vbabka@suse.cz>,
	<rppt@kernel.org>, <surenb@google.com>, <bingjiao@google.com>
Subject: Re: [PATCH v3 2/3] mm: numa_emu: add document for NUMA emulation
Message-ID: <20260108155156.0000156b@huawei.com>
In-Reply-To: <20260108101535.50696-3-akinobu.mita@gmail.com>
References: <20260108101535.50696-1-akinobu.mita@gmail.com>
	<20260108101535.50696-3-akinobu.mita@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Thu,  8 Jan 2026 19:15:34 +0900
Akinobu Mita <akinobu.mita@gmail.com> wrote:

> Add a document with a brief explanation of numa emulation and how to use
> the newly added "numa_emulation.adistance=" kernel cmdline parameter.
> 
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
I'm not sure on the benefit of a NUMA emulation doc that only really covers
the new stuff in your series.  Feels like a more thorough doc with everything
in one place would be better.  Still, what you have here is good to have so
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
> v2:
> - added in v2
> 
>  Documentation/mm/index.rst          |  1 +
>  Documentation/mm/numa_emulation.rst | 30 +++++++++++++++++++++++++++++
>  2 files changed, 31 insertions(+)
>  create mode 100644 Documentation/mm/numa_emulation.rst
> 
> diff --git a/Documentation/mm/index.rst b/Documentation/mm/index.rst
> index 7aa2a8886908..7d628edd6a17 100644
> --- a/Documentation/mm/index.rst
> +++ b/Documentation/mm/index.rst
> @@ -24,6 +24,7 @@ see the :doc:`admin guide <../admin-guide/mm/index>`.
>     page_cache
>     shmfs
>     oom
> +   numa_emulation
>  
>  Unsorted Documentation
>  ======================
> diff --git a/Documentation/mm/numa_emulation.rst b/Documentation/mm/numa_emulation.rst
> new file mode 100644
> index 000000000000..dce9f607c031
> --- /dev/null
> +++ b/Documentation/mm/numa_emulation.rst
> @@ -0,0 +1,30 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +==============
> +NUMA emulation
> +==============
> +
> +If CONFIG_NUMA_EMU is enabled, you can create fake NUMA nodes with
> +``numa=fake=`` kernel cmdline option.
> +See Documentation/admin-guide/kernel-parameters.txt and
> +Documentation/arch/x86/x86_64/fake-numa-for-cpusets.rst for more information.
> +
> +
> +Multiple Memory Tiers Creation
> +==============================
> +
> +The "numa_emulation.adistance=" kernel cmdline option allows you to set
> +the abstract distance for each NUMA node.
> +
> +For example, you can create two fake nodes, each in a different memory
> +tier by booting with "numa=fake=2 numa_emulation.adistance=576,704".
> +Here, the abstract distances of node0 and node1 are set to 576 and 706,
> +respectively.
> +
> +Each memory tier covers an abstract distance chunk size of 128. Thus,
> +nodes with abstract distances between 512 and 639 are classified into the
> +same memory tier, and nodes with abstract distances between 640 and 767
> +are classified into the next slower memory tier.
> +
> +The abstract distance of fake nodes not specified in the parameter will
> +be the default DRAM abstract distance of 576.

