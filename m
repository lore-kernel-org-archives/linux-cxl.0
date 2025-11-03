Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807A930170E;
	Mon,  3 Nov 2025 23:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762213303; cv=none; b=sd0kQxzSOHsiYC/A3f7f62LGC1uzpMaUM3guNpKVs6ypUQIu9BI90s0koc4S7h6UBJkIjo07VNdPy9MJlImC6pyU+wSlGbVDq+B3xJBpuJ5PQIxwAt/8etdOp0b127qDvDdywzFSWrjsJEtSPrI2Km5VZyYnRPN0c0BaxmKxe80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762213303; c=relaxed/simple;
	bh=jVRAA8qAJIzzApHK408LFFTCp9iTcAoJE66Qtkzpc5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r6WB59HMKPEYOSJDLBR1OsE0igeIPCfPbvwbgVxLneg1sfvPvbLxuAjQ3honCCODu/Z7MCNe2uIJ0WO8UbQxph9C5eoJq0dDGVtr0IYIT7CN864ux5+OmSkTaSiAgEv7CyMRy9H5pVBmpE9UewBktWcei4g715ncTMhHfbj8pw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nKR0zZyG; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nKR0zZyG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762213301; x=1793749301;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jVRAA8qAJIzzApHK408LFFTCp9iTcAoJE66Qtkzpc5A=;
  b=nKR0zZyGGM2FGykUdkJOSXiGGK1vool6Hv66qsVsD8lSK24QvEzisaNd
   5fbAVUP4GITrmQ3Y5uHjU2D9trTiAP4vYWPmEzPtiODWAix4HoVpr+8uM
   VQvrmXdHBWf6zzdiFZMQFiXM+OjPjLlYG0d9SZXH/FO1ghfAwj79HhfI9
   6TXM9GjTZT//eawkULyIKg6pL9OP3spfXVaCn7bvPxtohHR/bgWHPdvZK
   ocRW2/4r/QeRmg7odWlWp0O2o+lamlARwkl2RFpoDiyx1fRkdGV1/Fqhp
   Ul7VS3FcTTNNicrToI+PDjrx2zu1VExTk8v0Vf2tLC/noncMGAaZhqeC9
   A==;
X-CSE-ConnectionGUID: bs4KV95IT5mcqwQY9Qyr2w==
X-CSE-MsgGUID: iC0sK0ZfSzqpfssZkmcVog==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="66912936"
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="scan'208";a="66912936"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 15:41:41 -0800
X-CSE-ConnectionGUID: 8fzjJ0eYQ++gx5BiV6hCFQ==
X-CSE-MsgGUID: Ph8PIjS2QqCVlalDT5Uw3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="scan'208";a="186678304"
Received: from dwesterg-mobl1.amr.corp.intel.com (HELO [10.125.110.133]) ([10.125.110.133])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 15:41:40 -0800
Message-ID: <8bf25572-1efa-4b0e-a4d4-74f292562c08@intel.com>
Date: Mon, 3 Nov 2025 16:41:39 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation/driver-api/cxl: remove page-allocator quirk
 section
To: Gregory Price <gourry@gourry.net>, linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, corbet@lwn.net, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251003143233.1985150-1-gourry@gourry.net>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20251003143233.1985150-1-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/3/25 7:32 AM, Gregory Price wrote:
> The node/zone quirk section of the cxl documentation is incorrect.
> The actual reason for fallback allocation misbehavior in the
> described configuration is due to a kswapd/reclaim thrashing scenario
> fixed by the linked patch.  Remove this section.
> 
> Link: https://lore.kernel.org/linux-mm/20250919162134.1098208-1-hannes@cmpxchg.org/
> Signed-off-by: Gregory Price <gourry@gourry.net>

Applied to cxl/next
82b5d7e30b24b7df5dbf10aea97292be38daf88d

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

