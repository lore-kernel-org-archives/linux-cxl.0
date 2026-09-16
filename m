Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2B34B828B
	for <linux-cxl@vger.kernel.org>; Wed, 16 Sep 2026 16:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789577450; cv=none; b=gNfOYappvo6eBsRBiEn9wsFo3hNZkTu7dCL2Wqh+c+XiP6xGNpA6h0abeDrxNZlp+Zm0iFM5J2b6QQGKujQR0ixI0DCNALeZFE7id5NfhlvESrmYLVXX1ldl8xBCRoBomN0FCaT5a9uYMZp3wHSr96xPXKENjZaOUGLZbVdhvz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789577450; c=relaxed/simple;
	bh=GQ1ACmcDO68mz4E9htf6y2qKrryis5yPBmGuRW+ETbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y5MDnA/lnTQxtoachh3TzeVA8qbp/4Awp1UwgHfRQuhDCfofQYkqUbwSH34Z8Q855KjaVZ2eHv1BVGuHOtutumdGZFI4s1FGifn9EiLO625SdMj8nUREiKA9HCw1fO4Yuf6JsGLTnOGwNdiPf61N52nPPHJWlYrfJZqEPcPmIik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L5uEw5Dp; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L5uEw5Dp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789577443; x=1821113443;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GQ1ACmcDO68mz4E9htf6y2qKrryis5yPBmGuRW+ETbo=;
  b=L5uEw5DpM8eZ+GY6QvwFlsSCHiMcPyssiku7J+qr5Ufgly3MUqZ+iSH4
   TurWmL2/VQDrrtGG17Smdx4jo3TOaNOUFIwqonXrYTBT75dT/KLsTfAwc
   ywpBa772X/JYiP7xm3pSQT8tngeNMsSF8kKaqfHtBTheamwPEvpP+mu2D
   NUXFul6/i98z9GmtC1cDjZL99IviA9Nh+72YZTu54a94YbJ2+vNrWDp4a
   0fIIVInufbfh6G2OPoiiJYckxw2aXrmq3ipEBdTC7UeZ5VZAToWZoEzQo
   CgmdbLVV2l3JpXu+uhS0AsIF6EEizJ94nMZWKP2Z5S7bpuucG+Bzwp0Ma
   Q==;
X-CSE-ConnectionGUID: kNgtlKMrQJ6ie6hrAQ1USg==
X-CSE-MsgGUID: xJRjZoLqRKqI+SezKSx4ng==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="93834533"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="93834533"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 09:50:40 -0700
X-CSE-ConnectionGUID: DdOq+1JERvapoGJGnX6yVA==
X-CSE-MsgGUID: Z9Q0cID7QqWeYIIuA15rwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="298457265"
Received: from jjgreens-desk24.amr.corp.intel.com (HELO [10.125.109.0]) ([10.125.109.0])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 09:50:39 -0700
Message-ID: <b1eccffe-61a9-4bf8-abc4-03ee6e310316@intel.com>
Date: Wed, 16 Sep 2026 09:50:38 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/4] Harden HDM decoder enumeration
To: Alison Schofield <alison.schofield@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>,
 Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org, Srirangan Madhavan <smadhavan@nvidia.com>
References: <cover.1786143520.git.alison.schofield@intel.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <cover.1786143520.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/7/26 5:05 PM, Alison Schofield wrote:
> Changes in v5:
> Drop P2 of v4 as it changed what user sees in iw and ig attributes (Davidlohr)
> Renumbering: v4 P3 and P4 are now P2 and P3
> P1: Validate the target count once per port, not per decoder (Jonathan)
> P1: Move the zero-target reject back to cxl_switch_decoder_init() (Ming)
> P1: Drop the ways reset for uncommitted decoders (Jonathan, Davidlohr)
> P1: Declare cxlsd on one line (Jonathan)
> P1: Reword the CXL_HDM_DECODER0_TL_TARGETS comment (Jonathan)
> P2: Build the target IDs with put_unaligned_le32() (Jonathan)
> P2: Dropped all the tags on endian-ness patch
> P3: Commit log s/none committed/uncommitted/ (DaveJ)
> P4: New - bound switch decoder target array walks by nr_targets
> 
> Changes in v4:
> A new patch was inserted as Patch2, so now set is 4 patches.
>    Sashiko is likely to complain in Patch 1 for something fixed in
>    Patches 2 and 3, but reordering does not makes sense.
> P2: Only interpret interleave settings on committed decoders (Ming)
>     This is the newly inserted patch
> P4: Register reset w devm_add_action (Ming)
> P4: Fix up a kernel-doc comment issue (lkp)
> 
> Changes in v3:
> P1: Move zero-target reject to init_hdm_decoder() (RichardC)
> P3: Reset commit_end via a devres action after decoder teardown (RichardC)
> 
> Changes in v2:
> P1: Handle uncommitted decoders (Sashiko)
> P1: Reject switch decoders with zero targets (Sashiko)
> P1: Add in code comment clarifying target_count (Sashiko)
> P1: Update commit log
> P3: Reset commit_end on the failure path only (Sashiko)
> P3: Update commit log
> P2: No
> 
> 
> This set started as Sashiko reported cleanups. The patch added at v4 on
> Li Ming's review is dropped in v5. Davidlohr pointed out that it changes
> what interleave_ways and interleave_granularity report for an uncommitted
> decoder, and those are documented ABI. That is also the answer to Ming's
> v3 question that prompted the patch -  enumeration decodes those fields
> because userspace reads them, not because the driver needs them.
> 
> Only the first patch includes a link to the original Sashiko complaint,
> since the others did not originally appear on Lore for me to add public
> links.
> 
> Srirangan: I believe some of these patches address pre-existing issues
> Sashiko posted in reply to your reset series, but frankly, with the
> renumbering here, and the respin of your series, I no longer have 
> the exact patch to patch correlation.
> Alison Schofield (4):
>   cxl/hdm: Reject switch decoder interleave ways that overflow targets
>   cxl/hdm: Make switch decoder target parsing endian-safe
>   cxl/hdm: Restore commit_end when decoder enumeration fails
>   cxl/port: Bound switch decoder target array access by nr_targets
> 
>  drivers/cxl/core/hdm.c  | 62 +++++++++++++++++++++++++++++++++--------
>  drivers/cxl/core/port.c | 27 ++++++++++++------
>  drivers/cxl/cxl.h       |  2 ++
>  3 files changed, 72 insertions(+), 19 deletions(-)
> 
> 
> base-commit: 075b74841bd0065a3bda3440873c747938e69b68

Applied to cxl/next:
3696326ca14c
3f846646b3d3
7dae18c39e99
4e42c398af13

