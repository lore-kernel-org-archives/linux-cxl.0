Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFFA42BC4E;
	Tue, 14 Jul 2026 21:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784062922; cv=none; b=HYvSFGyKZtNL+yp/z7Yr1nrjKUF/lvXvzlE3DKMq9jWcYPCHHBr+4aYHN4n4Hpo+TdLwXWnKJgmFM9s7izVP98F6p5z16vxjxUmD0UpqPJmznC6j+mXeKTH3ZID7rnT29tb5sizpI/45NWlPfqYhn8dwNOeijHwMVX+ziph3LHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784062922; c=relaxed/simple;
	bh=Xi6or4dh8H4PTXV96ltf2jxn6bAlggKx7Vm9g/2NLYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UxHzB+7PtawFCS0YpVvDkZD1T4R0I7YJsPhDyORUNizfe7Zz2BA+/v/PIwHJas9FsJWdXdOJEsWwQ1477lb5NvrR7f3ew695WE8qqvGLmhbzXtCyw6ScP9aGbQh5s1BpuXVGFTIgqITE5K9FjXBxTLEr41rsg5GHu+9OejtvsEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jH/dbY6b; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jH/dbY6b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784062919; x=1815598919;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Xi6or4dh8H4PTXV96ltf2jxn6bAlggKx7Vm9g/2NLYI=;
  b=jH/dbY6b3dpa3Wk/s25B/kDxQX3pVIn7QG0ciR654HnVIYTI7buIMIqU
   yE5lwB6Gfd/31zbOEO3RzcXGwHHyCg1apLSgommGI//C0bi2vQLPs3Mi1
   vrweZP3DmSFjzLIwN+/7h5PmM0BJMZXsMweRqdopdFmXNlQuYHnEvHAay
   TgJJqZmQylgQWaAEF8RX4KcKACZv4ANprsvb2Iz7Y+Vhe6Sxr8tvfuZ0y
   tkWuHNWPcnre6IqNbiptRYuEETVPKz9zUjvHm2VG881ZqR8mAdBmXMcJF
   HnlLZadAOHQuYeN/0MwrKEGZKcSC7RFBftJCkmgtQtp5JXdX3PD4rd3ls
   A==;
X-CSE-ConnectionGUID: Jl7G3OSQS6+DselxZfulsg==
X-CSE-MsgGUID: +iiSc+S4RaOyQpVqQBrz0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="84716552"
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="84716552"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 14:01:58 -0700
X-CSE-ConnectionGUID: PEFqKM7oQoie96OFS7DkSQ==
X-CSE-MsgGUID: C2Nb8l4dQRuLY2eGKPcOuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="260267727"
Received: from aschende-mobl.amr.corp.intel.com (HELO [10.125.108.131]) ([10.125.108.131])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 14:01:57 -0700
Message-ID: <6f739416-2339-45ca-856b-4103eafb30db@intel.com>
Date: Tue, 14 Jul 2026 14:01:55 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] cxl/features: Bounds-check the fwctl feature
 commands
To: Richard Cheng <icheng@nvidia.com>, dave@stgolabs.net, jic23@kernel.org,
 alison.schofield@intel.com, vishal.l.verma@intel.com, djbw@kernel.org,
 danwilliams@nvidia.com
Cc: iweiny@kernel.org, ming.li@zohomail.com, kobak@nvidia.com,
 kaihengf@nvidia.com, kees@kernel.org, newtonl@nvidia.com,
 kristinc@nvidia.com, mochs@nvidia.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260626104102.53892-1-icheng@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260626104102.53892-1-icheng@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/26/26 3:40 AM, Richard Cheng wrote:
> The CXL fwctl feature handlers take buffer sizes from userspace, which is
> out_len, and from the device without fully checking them. This series
> adds the missing bounds checks.
> 
> Patch 1: reject a Get Feature whose count is larger than the output
>          buffer.
> Patch 2: reject a Set Feature whose output buffer is too small for the
>          reply header. A zero out_len makes kvzalloc() return
>          ZERO_SIZE_PTR, and the header write then corrupts memory.
> Patch 3: clamp the Get Feature read loop to the room left in the output
>          buffer, so a device that returns more than requested cannot
>          write past it.
> 
> A related gap is fixed separately by Zhenhao Wan's patch [1].
> 
> Changes since v2:
>     - Expand the single Get Feature fix into a series that also covers
>       the Set Feature output buffer and the Get Feature read loop.
> 
> [1]:
> https://lore.kernel.org/all/20260620-cxl-fwctl-oob-v1-1-5758e34d784a@gmail.com/
> 
> Richard Cheng (3):
>   cxl/features: Reject Get Feature count larger than the output buffer
>   cxl/features: Reject Set Features output buffer smaller than the
>     header
>   cxl/features: Clamp Get Feature output size to the remaining buffer
> 
>  drivers/cxl/core/features.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> 
> base-commit: ef0c9f75a19532d7675384708fc8621e10850104

Applied to cxl/next
2aeb21fe557e cxl/features: Clamp Get Feature output size to the remaining buffer
cde18d6c1d91 cxl/features: Reject Set Features output buffer smaller than the header
4bf6bac37507 cxl/features: Reject Get Feature count larger than the output buffer

There was a conflict for 2aeb21fe557e. May want to check that it applied correctly. 
