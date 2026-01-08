Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46F12D1936;
	Thu,  8 Jan 2026 19:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767898803; cv=none; b=HBn5bulGaoPMPvNvShA4xine+1rZzodf4WnMukQe+FJoKZSxt0z+pJpmlWTY1r0AlCA+uRxIvXKdfkCHWXbCTpOjLdS7Ra8ziLHCvWVPp/xyu5cRA8ejzNX1oh5rqnURgl+OK7ipPtqBTmiC+SFU9aSXuO05o+MFnozwTAhi5Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767898803; c=relaxed/simple;
	bh=xkljrQctX/mDR/GQ0S6dpucNB4l1Deu7SRu2NiGbgrk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=On2ubkhBDvOd5XySwzYtbTBN13YmQx3I4lXSrf7QSzsyyaQF/DCsfPaBvE7OUTZYupHoUqTYDcRy2Y5J8mc6SAMKPrNV3l3yBNcVQXHUIETQx4CE8rP4AUSonKtNJ56oYGVOdDwNvVmCtOLhKdLrgfwxqITLedH+mFwGT28ncuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=nW2I81WM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="nW2I81WM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A10FDC116C6;
	Thu,  8 Jan 2026 19:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1767898802;
	bh=xkljrQctX/mDR/GQ0S6dpucNB4l1Deu7SRu2NiGbgrk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nW2I81WM9wUmLIIPFZa19mVDuK9NRqwfQSn5RUb20kkn+FwyrfyZcAgthN5+smrmJ
	 G5iKUuWaRNvWROYo096Pu3T5sid8zoIavJGJxbYMU+OdkncGLo9nNttqoGp6BpYjFJ
	 tYTgy2lorSD1O7g6oAGXBYqSHUKuWFUj9MFHR70g=
Date: Thu, 8 Jan 2026 11:00:00 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, axelrasmussen@google.com, yuanchu@google.com,
 weixugc@google.com, hannes@cmpxchg.org, david@kernel.org,
 mhocko@kernel.org, zhengqi.arch@bytedance.com, shakeel.butt@linux.dev,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, bingjiao@google.com, David Rientjes
 <rientjes@google.com>
Subject: Re: [PATCH v3 3/3] mm/vmscan: don't demote if there is not enough
 free memory in the lower memory tier
Message-Id: <20260108110000.dc6e3be63e8b9f401c8c429b@linux-foundation.org>
In-Reply-To: <20260108101535.50696-4-akinobu.mita@gmail.com>
References: <20260108101535.50696-1-akinobu.mita@gmail.com>
	<20260108101535.50696-4-akinobu.mita@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  8 Jan 2026 19:15:35 +0900 Akinobu Mita <akinobu.mita@gmail.com> wrote:

> On systems with multiple memory-tiers consisting of DRAM and CXL memory,
> the OOM killer is not invoked properly.
> 
> Here's the command to reproduce:
> 
> $ sudo swapoff -a
> $ stress-ng --oomable -v --memrate 20 --memrate-bytes 10G \
>     --memrate-rd-mbs 1 --memrate-wr-mbs 1
> 
> The memory usage is the number of workers specified with the --memrate
> option multiplied by the buffer size specified with the --memrate-bytes
> option, so please adjust it so that it exceeds the total size of the
> installed DRAM and CXL memory.
> 
> If swap is disabled, you can usually expect the OOM killer to terminate
> the stress-ng process when memory usage approaches the installed memory
> size.
> 
> However, if multiple memory-tiers exist (multiple
> /sys/devices/virtual/memory_tiering/memory_tier<N> directories exist) and
> /sys/kernel/mm/numa/demotion_enabled is true, the OOM killer will not be
> invoked and the system will become inoperable, regardless of whether MGLRU
> is enabled or not.
> 
> This issue can be reproduced using NUMA emulation even on systems with
> only DRAM.  You can create two-fake memory-tiers by booting a single-node
> system with "numa=fake=2 numa_emulation.adistance=576,704" kernel
> parameters.
> 
> The reason for this issue is that memory allocations do not directly
> trigger the oom-killer, assuming that if the target node has an underlying
> memory tier, it can always be reclaimed by demotion.
> 
> So this change avoids this issue by not attempting to demote if the
> underlying node has less free memory than the minimum watermark, and the
> oom-killer will be triggered directly from memory allocations.
> 

Thanks.

An oom-killer fix which doesn't touch mm/oom-kill.c Hopefully
David/Shakeel/Michal can take a look.

> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -358,7 +358,21 @@ static bool can_demote(int nid, struct scan_control *sc,
>  
>  	/* Filter out nodes that are not in cgroup's mems_allowed. */
>  	mem_cgroup_node_filter_allowed(memcg, &allowed_mask);
> -	return !nodes_empty(allowed_mask);
> +	if (nodes_empty(allowed_mask))
> +		return false;
> +
> +	for_each_node_mask(nid, allowed_mask) {
> +		int z;
> +		struct zone *zone;
> +		struct pglist_data *pgdat = NODE_DATA(nid);
> +
> +		for_each_managed_zone_pgdat(zone, pgdat, z, MAX_NR_ZONES - 1) {
> +			if (zone_watermark_ok(zone, 0, min_wmark_pages(zone),
> +						ZONE_MOVABLE, 0))
> +				return true;
> +		}
> +	}
> +	return false;
>  }

It would be nice to have a code comment in here to explain to readers
why we're doing this.
