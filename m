Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12894CB8A4;
	Fri,  4 Sep 2026 16:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788538747; cv=none; b=LxFHAgUyjRaXF296nSV8+B04kwRJ5KW9aKeoEkizxVZXswD66ffZBSGe7pG04HkShNBq9Pg8CS3aPblmWrAtGSI/kkaTu5lbW2S0QVhGUdelQaPp1aCclGUz6jAhzKf9xZS/WvSJKZGQvB6NRSDfJ+/Wz4quVOYl6hz38g2rN4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788538747; c=relaxed/simple;
	bh=qDryCFrF2PK45D12pQeGGM+7Z0Y0OrJ7OARS0bEXlSc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=emdsXizx9ksH6GuLBMpvlRe3fFQUXcziHpkOtWnEBJ1+IISp+kPS8wy61b6nubaDcRYT4bghdPraDL5yqCcidlR1isZZgDJvm/nLhM7GxGXqmXLoCDsZ9XF2ykyLbcb+EnvjVN/qFU0wzYfGQR8Pfy6V4MFtyd+29qCZz0El8MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BgVWkPpn; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BgVWkPpn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788538746; x=1820074746;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qDryCFrF2PK45D12pQeGGM+7Z0Y0OrJ7OARS0bEXlSc=;
  b=BgVWkPpn67FTP/bN6LAV73F0cYu4zaPPWr/rBSF8ZI1vCjiFhiNFa90Y
   j7PINREA5NhvDkX/gMa5g16RUUR1JkT2fN9K+09TMf0LLMSgf/sDt35co
   yHv6CqWhzvIxeXFo2VD9aglze51wW6FSzwdtOrlGOEqmk2klEaKn8vwlT
   KvSc2ko7cQxUARGH5Cqb2mSBg2k+034/rU4cLrodvrFSnm5Gm2vn3gCoq
   jpV0VDMlFix7Awq/h6mq1jwF13fGjnDfGyc0j50H/xFSkdPmrTfukwoqN
   qdqWigalayjHzyY4j6SPxcLU1PsWxdZCM84BJ1HNAJXYrp6PglFd7sFVl
   g==;
X-CSE-ConnectionGUID: b7loGSr+SUmsYClLJIIkmQ==
X-CSE-MsgGUID: Zje6vJZORs+/CGSdPt8TMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="99702905"
X-IronPort-AV: E=Sophos;i="6.25,262,1779174000"; 
   d="scan'208";a="99702905"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2026 09:19:05 -0700
X-CSE-ConnectionGUID: PhYNtnMlSwCJfBTD/Pw0Ag==
X-CSE-MsgGUID: j8EdBELhSf2+8/7ku0ZiVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,262,1779174000"; 
   d="scan'208";a="274233529"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO [10.125.110.248]) ([10.125.110.248])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2026 09:19:04 -0700
Message-ID: <6131bafe-3d61-4f90-8370-f15ebf06a86f@intel.com>
Date: Fri, 4 Sep 2026 09:19:02 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/7] cxl: Sashiko bug fixes
To: Richard Cheng <icheng@nvidia.com>, dave@stgolabs.net, jic23@kernel.org,
 alison.schofield@intel.com, vishal.l.verma@intel.com
Cc: iweiny@kernel.org, ming.li@zohomail.com, gourry@gourry.net,
 rrichter@amd.com, linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 kees@kernel.org, newtonl@nvidia.com, kristinc@nvidia.com,
 kaihengf@nvidia.com, kobak@nvidia.com
References: <20260902053839.25595-1-icheng@nvidia.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260902053839.25595-1-icheng@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/1/26 10:38 PM, Richard Cheng wrote:
> Seven independent, pre-existing bugs in the CXL core, reported by
> sashiko.
> 
> Patch 1: Get/Set Feature derive each mailbox command's offset from the
> starting offset plus the amount of data already transferred, then store
> it in a 16-bit field. A large offset/count supplied through fwctl can
> cause a later offset to exceed the representable feature extent and be
> truncated by cpu_to_le16(), targeting the wrong feature data. Reject
> invalid ranges up front.
> 
> Change cxl_get_feature() to return ssize_t so invalid input and mailbox
> failures are reported as negative errno instead of being conflated with
> a zero-byte result. Update all EDAC callers for the signed return
> contract while preserving the existing fwctl RPC response behavior.
> 
> Patch 2: cxl_get_poison_unmapped() aborted its whole partition sweep on
> the first fully-mapped partition, silently skipping unmapped poison in
> all later partitions. Skip that partition instead.
> 
> Patch 3: the same function tolerated the -EFAULT a RAM partition returns
> for Get Poison List but left it in rc, so a benign fault on the last
> scanned partition surfaced as a spurious read failure. Clear rc, as
> poison_by_decoder() already does.
> 
> Patch 4: the same function also ignored the ctx->offset handoff from
> poison_by_decoder() and derived its scan start from the highest DPA
> allocation, so the DPA of allocated-but-uncommitted decoders was never
> scanned by either phase. Resume the sweep at ctx->offset.
> 
> Patch 5: cxl_get_poison_by_memdev() overwrote rc on each partition
> query, so an earlier partition's failure was masked by a later success
> and unscanned poison was reported as a clean list. Stop on any error
> not tolerated as a RAM -EFAULT.
> 
> Patch 6: poison_by_decoder() assumed every decoder with a DPA reservation
> was assigned to a partition. Malformed device DPA metadata can leave
> dpa_res set while part remains -1, causing a poison scan to access
> before the partition array. Reject such decoders before the lookup.
> 
> Patch 7: the Get and Set Feature fwctl handlers converted all helper
> failures into normal RPC responses, sometimes with a SUCCESS device
> status. Propagate delivery failures as ioctl errors while continuing to
> report actual device errors through rpc_out->retval.
> 
> A nonzero short Get Feature response is valid when Offset + Count runs
> past the end of the feature. Preserve the returned bytes as a successful
> partial transfer, reject unexpected zero-length success responses, and
> require fixed-format EDAC callers to receive their complete attribute
> structures before consuming them.
> 
> Changes since v6 [1]:
> - Patch 7: Remove redundant braces. (Dave Jiang)
> 
> [1]:
> https://lore.kernel.org/linux-cxl/20260826014508.9989-1-icheng@nvidia.com/
> 
> 
> Richard Cheng (7):
>   cxl/features: Reject feature offset that overflows 16-bit field
>   cxl/region: Scan all partitions for unmapped poison
>   cxl/region: Don't leak tolerated RAM -EFAULT from unmapped poison scan
>   cxl/region: Start unmapped poison scan at the committed decoder
>     boundary
>   cxl/memdev: Don't overwrite the error from an earlier partition poison
>     query
>   cxl/region: Reject poison scan for decoder without a partition
>   cxl/fwctl: Propagate feature RPC delivery errors
> 
>  drivers/cxl/core/core.h     |  8 +++---
>  drivers/cxl/core/edac.c     | 30 +++++++++++++-------
>  drivers/cxl/core/features.c | 56 ++++++++++++++++++++++++-------------
>  drivers/cxl/core/memdev.c   |  2 ++
>  drivers/cxl/core/region.c   | 15 +++++-----
>  5 files changed, 71 insertions(+), 40 deletions(-)
> 
> 
> base-commit: 7098e9cd98a05c0c5de2fae0c2465f9d966fdd07

Patches 1 and 7 applied to cxl/next
51493ff66ad6
3eb3376944ac


