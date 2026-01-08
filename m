Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522FF2DCBF3;
	Thu,  8 Jan 2026 17:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767894494; cv=none; b=tKj2G9m2OJL89iP/vRvpePWQkTF0x+4EWw52jsa6sxMzE2OCGPMhXe+LAUxamERk1KfPm8TZx9DTM0BrYxXxBZqs2Y0t0uaRtu9fsiItGtigzB5Xn6SUhZDC8kB/XM9L3q5eUO7Li68XN+eilNX6/V2NUrrFPE5Hz+ShMtP9ADI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767894494; c=relaxed/simple;
	bh=p4zq5TLeaIF9oBTh+MeDW7ixwfbdKuP/Hlh1oSPZ4OA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=a8xfJSwDRuK3GJfVwQIW1pwE1mrxq1kMDWT4ViD/nSsB2HfzveQc/SeGR51LuW++W1+wd3QvHWjlFzliy3ew1bGLBe6v1OzjN4BJWAP97vEo5CxB4a10B//EAO9bUdxYsuaI/moYvx8l88RrCOxrQW2IXQV2Brp+GubYN3lD/6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=M57mQ1lg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="M57mQ1lg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8476AC116C6;
	Thu,  8 Jan 2026 17:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1767894493;
	bh=p4zq5TLeaIF9oBTh+MeDW7ixwfbdKuP/Hlh1oSPZ4OA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M57mQ1lgAvcDoFKMJagLrAPDOPLRGYbL54K0eggKgRhi+HLPrzU/+ou4rdo9OGqeM
	 1ehjSVG0IY7mMD0hvPbVHFCjQl7f0aVtD6H/W9ELDFzfWT/yyWosIXwgaCmV7X3tEE
	 OkiPvmjt6tir0FKmyOWOYrpazHopBAj2Zc+UEQRg=
Date: Thu, 8 Jan 2026 09:48:12 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Cui Chao <cuichao1753@phytium.com.cn>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Mike Rapoport
 <rppt@kernel.org>, Wang Yinfeng <wangyinfeng@phytium.com.cn>,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 1/1] mm: numa_memblks: Identify the accurate NUMA ID
 of CFMW
Message-Id: <20260108094812.8757ce3ad8370668eaafb29c@linux-foundation.org>
In-Reply-To: <20260106031042.1606729-2-cuichao1753@phytium.com.cn>
References: <20260106031042.1606729-1-cuichao1753@phytium.com.cn>
	<20260106031042.1606729-2-cuichao1753@phytium.com.cn>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  6 Jan 2026 11:10:42 +0800 Cui Chao <cuichao1753@phytium.com.cn> wrote:

> In some physical memory layout designs, the address space of CFMW
> resides between multiple segments of system memory belonging to
> the same NUMA node. In numa_cleanup_meminfo, these multiple segments
> of system memory are merged into a larger numa_memblk. When
> identifying which NUMA node the CFMW belongs to, it may be incorrectly
> assigned to the NUMA node of the merged system memory.
> 
> Example memory layout:
> 
> Physical address space:
>     0x00000000 - 0x1FFFFFFF  System RAM (node0)
>     0x20000000 - 0x2FFFFFFF  CXL CFMW (node2)
>     0x40000000 - 0x5FFFFFFF  System RAM (node0)
>     0x60000000 - 0x7FFFFFFF  System RAM (node1)
> 
> After numa_cleanup_meminfo, the two node0 segments are merged into one:
>     0x00000000 - 0x5FFFFFFF  System RAM (node0) // CFMW is inside the range
>     0x60000000 - 0x7FFFFFFF  System RAM (node1)
> 
> So the CFMW (0x20000000-0x2FFFFFFF) will be incorrectly assigned to node0.
> 
> To address this scenario, accurately identifying the correct NUMA node
> can be achieved by checking whether the region belongs to both
> numa_meminfo and numa_reserved_meminfo.

Thanks.

Can you please help us understand the userspace-visible runtime effects
of this incorrect assignment?
