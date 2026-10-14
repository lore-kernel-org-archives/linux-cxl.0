Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5AB5452BD;
	Wed, 14 Oct 2026 15:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791991862; cv=none; b=hrpnu2IVWbEiXkfhDZ1GrS0jcj+3PH1Qg8AWS3MmXpzpj+yfD+DUdLg+oic05ryql1Gmz3PLab2dV0OVhO3E2ydLaGyUyzbTqpWYSaPvRS4NIq6YqUGPi0jjWk2UegNXosJ1QWFQwOIZwyXkpBciRWvwL18twZe2l/6rbPVmBKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791991862; c=relaxed/simple;
	bh=FzHi1Cw4t+MGI7+l51bHFtFma8ZQ9UVkIljcQ1+i3ZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AKfUjgwK6PaslM7bVIiLLePyg/i2n/m1QXU+4CMTtqLsXI6Gz5xxTarVE7eiepHj5GKMXiZyjrJA2/x0n8NxsKsAReB8mlWDpNaWDZBA/kiAqAqNwQHPPn3SnXnM2u63y6keUTCK8HoxEBoKtXzxZbU5gGvbjTg78hLAU7MVzBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P46W/hni; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P46W/hni"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791991860; x=1823527860;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FzHi1Cw4t+MGI7+l51bHFtFma8ZQ9UVkIljcQ1+i3ZU=;
  b=P46W/hniQAn21EDNb4Cn+9nev+5RQwsQAALr6wgTSBKnOZFXxOTogLpW
   wa0+njdA1fv+b+VCUSo2kS9G9RhfFnJd4NUEbrzQebvqxMK11qN3n0wvH
   Zv9jGcsoCSy7gwnhafvJDpVTvqzpphUQ8Boer42BqsNwxFvezZpxHTVJD
   qQDybO/qPumi1VJ7/qIzSqdTbAj6fXLQs4HQ9LwwKXasdJUZ8sh4K7/+N
   ckWVm2oQICDgPuEHoWfT3msmI8Gail8wO1W0Vq+nSEko+WBudRPs7mEwD
   uK50Wy/uGEgqo+ME1EiVcIhHwCFbCAZlrtiofCRn9540D1LqLJtuyNegD
   A==;
X-CSE-ConnectionGUID: +QbGuP0nQoGLhuqG+bdb0w==
X-CSE-MsgGUID: AdIAkHCdRoKQ+NF9STtQJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="641801"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="641801"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 08:30:59 -0700
X-CSE-ConnectionGUID: hZXyl66FRrS9epym4iP06w==
X-CSE-MsgGUID: N18RU2L6SFCiwyrKJrwBuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="1474313"
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.110.36]) ([10.125.110.36])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 08:30:55 -0700
Message-ID: <73434314-6210-49d9-9355-60c4166a7117@intel.com>
Date: Wed, 14 Oct 2026 08:30:51 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/4] cxl: Repair poison enumeration regressions
To: Richard Cheng <icheng@nvidia.com>, jic23@kernel.org, dave@stgolabs.net,
 alison.schofield@intel.com, vishal.l.verma@intel.com
Cc: iweiny@kernel.org, ming.li@zohomail.com, kaihengf@nvidia.com,
 kobak@nvidia.com, newtonl@nvidia.com, kristinc@nvidia.com,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260922101129.52794-1-icheng@nvidia.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260922101129.52794-1-icheng@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 9/22/26 3:11 AM, Richard Cheng wrote:
> This series repairs four poison enumeration regressions introduced by
> commit be5cbd084027 ("cxl: Kill enum cxl_decoder_mode"). It groups the
> remaining poison fixes from v7 [1] into a poison repair set.
> 
> Patch 1: cxl_get_poison_unmapped() ends the partition walk when it
> encounters a fully mapped partition. Continue to the next partition
> instead, so unmapped poison in later partitions is still collected.
> 
> Patch 2: the unmapped scan tolerates -EFAULT for RAM partitions but
> leaves the error in rc. If no later query overwrites rc, enumeration
> incorrectly reports failure. Clear rc before continuing past the
> tolerated error.
> 
> Patch 3: use the ctx->offset handoff from the committed-decoder walk
> as the starting point for the unmapped scan. Starting after the highest
> DPA allocation leaves ranges allocated to uncommitted decoders
> unqueried. Resume at the committed boundary and scan later partitions
> from their beginning.
> 
> Patch 4: cxl_get_poison_by_memdev() can overwrite an earlier partition
> query failure with a later success. Stop on the first error that is
> not already tolerated as a RAM -EFAULT, preserving the failure.
> 
> In v7 [1] patch 6's review, Jonathan also noted that
> cxl_internal_send_cmd() documents -EFAULT as a hardware error.
> I will send a separate patch to clarify its mapping from the Invalid
> Physical Address device response.
> 
> Changes since v7 [1]:
> - Retain v7 patches 2–5, renumbered as patches 1–4, and rebase onto
>   current cxl/next.
> - Drop v7 patches 1 and 7, which have been applied to cxl/next.
> - Drop v7 patch 6 because the zero-sized HDM decoder series [2]
>   already fixes its negative partition-index access. Specifically,
>   commit 00f9ef9ad1ce ("cxl/hdm: Allow zero sized HDM decoders") [3]
>   guards the partition lookup while allowing the decoder walk to continue.
> - Expand patch 2's commit message to explain how a RAM poison query
>   produces -EFAULT and why that response is tolerated.
> 
> 
> [1]:
> https://lore.kernel.org/linux-cxl/20260902053839.25595-1-icheng@nvidia.com/
> [2]:
> https://lore.kernel.org/linux-cxl/20260914090858.19181-1-icheng@nvidia.com/
> [3]:
> https://lore.kernel.org/linux-cxl/20260914090858.19181-3-icheng@nvidia.com/
> 
> 
> Richard Cheng (4):
>   cxl/region: Scan all partitions for unmapped poison
>   cxl/region: Don't leak tolerated RAM -EFAULT from unmapped poison scan
>   cxl/region: Start unmapped poison scan at the committed decoder
>     boundary
>   cxl/memdev: Don't overwrite the error from an earlier partition poison
>     query
> 
>  drivers/cxl/core/memdev.c |  2 ++
>  drivers/cxl/core/region.c | 13 ++++++-------
>  2 files changed, 8 insertions(+), 7 deletions(-)
> 
> 
> base-commit: f2e9991100c903ec2d8eb62c3a1d6e0b9c67432e

Can you please rebase against a Linus tag? That's typically preferred. Thanks. Maybe you can address Alison and Davidlohr's comments when you rebase. 

