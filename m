Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4682F4A;
	Wed,  2 Apr 2025 04:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743568481; cv=none; b=HaYO2AAtyw+LUuyD13VBmm4u6OaC3Kwej7dRpoN0q3AxBeEeaOVIv7nB4ZM77gNP73OG/RJQ7fj5BWEa/OvznZi340ljCVAAwJF0Dtpp3GZv3i/rklcbBe3DyY/9kEygzziroutKM1ZdzF89+h/ShMHXHfTJCJc1TNqLb79ocYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743568481; c=relaxed/simple;
	bh=MJaQ1koZV33oEWHVV0syWWnpxgiW/LMae7AKSpde3qM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=YNhYMRE4Gr4bga+xqA55wuhL1WFEDrrVQNsGaRQ5jAktbZ5mPx8jyFVhQc29XURdwYpQY4fvVxgfOHFUJqzTaD9C95zBaD6VPLz7BdHpkzc76o16eDRR1Jb0jJ4aiRxyIpX/7LiRekrS0836KFTUYncpVfmukew5Jxf1QVwlEr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=p4+DeTqB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="p4+DeTqB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22024C4CEDD;
	Wed,  2 Apr 2025 04:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1743568480;
	bh=MJaQ1koZV33oEWHVV0syWWnpxgiW/LMae7AKSpde3qM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=p4+DeTqBpqvjyqhqEstOTH4YCjtN26wVOAZNLo+k4ERzuZinQ0WWvNb1euqUCZohp
	 0nPMIvEmUSV4jcgOqaYDGtuIgmYFoYwKDcfkX8MOo2We43h20XvR11+tAa3ym1VkR0
	 4asQ/rWozPvyTp+RxRZwTDK7fwN6O09dyjFCbOMw=
Date: Tue, 1 Apr 2025 21:34:39 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Honggyu Kim <honggyu.kim@sk.com>
Cc: Rakie Kim <rakie.kim@sk.com>, gourry@gourry.net,
 kernel_team@skhynix.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org, joshua.hahnjy@gmail.com,
 dan.j.williams@intel.com, ying.huang@linux.alibaba.com, david@redhat.com,
 Jonathan.Cameron@huawei.com, yunjeong.mun@sk.com
Subject: Re: [PATCH v5 3/3] mm/mempolicy: Support memory hotplug in weighted
 interleave
Message-Id: <20250401213439.4e7a124d94aa42603d31d45e@linux-foundation.org>
In-Reply-To: <5462e706-5b29-495d-9af9-1945e8a5445e@sk.com>
References: <20250402014906.1086-1-rakie.kim@sk.com>
	<20250402014906.1086-4-rakie.kim@sk.com>
	<5462e706-5b29-495d-9af9-1945e8a5445e@sk.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 2 Apr 2025 13:18:51 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:

> This is to fix the following broken status.
> https://lore.kernel.org/linux-mm/b8ac8654-92bd-4c08-a3fc-e28a7be5e0e6@sk.com
> 
> So we must add the following tag for this patch.
> Fixes: fa3bea4e1f82 ("mm/mempolicy: introduce MPOL_WEIGHTED_INTERLEAVE for 
> weighted interleaving")
> 
> 
> Hi Gregory,
> 
> This patch is already in Andrew's tree. Is the current version okay for you?
> 
> 
> Hi Andrew,
> 
> I'm not sure if this is going to the final version but could you please add this
> patch to stable with Cc: <stable@vger.kernel.org>?
> We might need to bring the whole series to avoid conflicts to stable tree.

This is all rather confused.

Do we need to backport all three patches into -stable?  If so, all three
should have Fixes:.  Preferably they all have the same Fixes: so we
aren't backporting untested patch combinations.

I presently have:

Subject: mm/mempolicy: fix memory leaks in weighted interleave sysfs
Fixes: dce41f5ae253 ("mm/mempolicy: implement the sysfs-based weighted_interleave interface")
Cc: <stable@vger.kernel.org>

Subject: mm/mempolicy: support dynamic sysfs updates for weighted interleave
Cc: <stable@vger.kernel.org>

Subject: mm/mempolicy: support memory hotplug in weighted interleave
Fixes: fa3bea4e1f82 ("mm/mempolicy: introduce MPOL_WEIGHTED_INTERLEAVE for weighted interleaving")
Cc: <stable@vger.kernel.org>


[2/3] doesn't look like a fix.

Perhaps the whole thing should be redone: a two-patch bugfix series,
each with a Fixes: and a cc:stable and feature patch with neither a
Fixes: nor a cc:stable.



