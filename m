Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE0240F8F8;
	Tue, 15 Sep 2026 16:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789488070; cv=none; b=mZrTMUsjq3ZO1C5trMF423oC3FsYYa96HPW/uVQAMw8EcvsPt0TAiKrxUS3UGPD8R+GrVJnbIXp1JPiw8ITsSm+g4QuGILFp6k1C8ebvUfkVjsOTPbuQqeuLDs5/1D3ducQmWZaoNRcfnQH6dFcU3Rhf+qBiMt5/u6Ky/Eh64WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789488070; c=relaxed/simple;
	bh=PB1yceFjWeCqfa6rjL80BB6h/HYLGuvETNZIdbClL3Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d22LwDsMbJc5IXLw1iDb+eOovtwsIN1G8N0HPKVDEL2lP5PxTMoktk6KG/6YBa6ugmz9IgxL8xly6i0J4oVpsTXyMeLB6/Ju5orYFN11hMUsRqhAEK44FSameQBQLRksgkeWwI590gzEelePrI6hl+hDPevylH9GmAuCN42yMmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fhczkw8l; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fhczkw8l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789488069; x=1821024069;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PB1yceFjWeCqfa6rjL80BB6h/HYLGuvETNZIdbClL3Q=;
  b=Fhczkw8lH3DPVoTqi4ND1C1X2Z+xzmJuopQ1uQhF0bZANF9IqMiPTbn/
   yv4xml2CrE1s+3EnfzQXBx2vrr+E/6WbfYXL1gZlROqH9mR2uMmlJSty9
   DiAbSBV/bB55qwN7oBNS5DIXQNxEXP1t8u9na95ihjUAoUAMZgKVoKput
   lylhki6lnDT5Prh0ZLikjp2jtUpPONsiXQHBfGxHGc+I6r+4rjfaaAjGq
   KV5pwcoKpVFM7jaIJdpsOCY/Sv98W/9S8rHKjfj5cN7qrrBiwUsCmm4s5
   ExrTrkzMbiJplEfvA0y7Zz6uKwNjwt9ZemdtzrJiT39z4e914/mOQ12JX
   A==;
X-CSE-ConnectionGUID: QjfPcNS+TcKY9maYSsry0w==
X-CSE-MsgGUID: EgYpbGbDTjOK5n7vMD7NXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="101374072"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="101374072"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 09:01:08 -0700
X-CSE-ConnectionGUID: sfeft0puT22gUaGyx+68eA==
X-CSE-MsgGUID: AibJa8UsT0WeRaXSZUtpDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="302939802"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.108.195]) ([10.125.108.195])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 09:01:07 -0700
Message-ID: <8a889714-f492-4975-b326-bb2ee866c6a1@intel.com>
Date: Tue, 15 Sep 2026 09:01:06 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 0/3] Support zero-sized HDM decoders
To: Richard Cheng <icheng@nvidia.com>, jic23@kernel.org, dave@stgolabs.net,
 vishal.l.verma@intel.com, alison.schofield@intel.com
Cc: iweiny@kernel.org, ming.li@zohomail.com, kaihengf@nvidia.com,
 kobak@nvidia.com, vaslot@nvidia.com, newtonl@nvidia.com, mochs@nvidia.com,
 kristinc@nvidia.com, linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260914090858.19181-1-icheng@nvidia.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260914090858.19181-1-icheng@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 9/14/26 2:08 AM, Richard Cheng wrote:
> 
> CXL r4.0 §8.2.4.20.12 ("Committing Decoder Programming") and
> §14.13.10 ("CXL HDM Decoder Zero Size Commit") permit committing an
> HDM decoder with size 0. Firmware may commit and lock such decoders so
> the OS cannot program regions through them; this is a platform design
> choice rather than a specification requirement.
> 
> The kernel currently rejects these decoders with -ENXIO during port
> enumeration and aborts enumeration of the entire port. On affected
> systems, this prevents the CXL topology from appearing in userspace.
> 
> This series enumerates empty committed decoders into the topology while
> keeping them out of region assembly.
> 
> Patch 1 is a preparatory cleanup with no functional change. It clarifies
> the error handling and iteration control in poison_by_decoder(), and
> shares the check for a forgiven -EFAULT on a RAM partition with
> cxl_get_poison_unmapped().
> 
> Patch 2 makes zero-size DPA reservations first-class. Since the resource
> tree cannot represent an empty range, an empty decoder is backed by a
> separately allocated resource. This keeps port->hdm_end, skip handling,
> and in-order DPA accounting consistent. Operations requiring non-empty
> capacity, including region attachment and poison queries, are guarded
> appropriately.
> 
> Patch 3 adds the mock_zero_size_decoders cxl_test module parameter,
> disabled by default. When enabled, it installs committed, locked,
> zero-sized endpoint, switch, and host-bridge decoders under
> host-bridge0.
> 
> Testing:
> 
> As reported in v9, the series was tested on arm64 with cxl_test and
> the ndctl v85 unit suite, with KASAN and lockdep enabled. With
> mock_zero_size_decoders disabled, the full CXL suite reported 15 tests
> passed and 1 skipped.
> 
> cxl-poison.sh was skipped because its unaligned translation section
> was unreachable; both run_poison_test() rounds passed. Details:
> https://lore.kernel.org/linux-cxl/anKpY6Y1Sqne1f7Y@MWDK4CY14F/
> 
> The core patch was also previously validated on a Montage CXL Type 3
> device.
> 
> The corresponding ndctl test:
> https://lore.kernel.org/linux-cxl/20260709022857.18732-1-icheng@nvidia.com/
> 
> Runtime-tested v10 on a CXL Type 3 device and confirmed that normal
> device operation continues to work with the series applied.
> 
> Changelog:
> 
> v9->v10 (Alison Schofield):
> - Patch 2: propagate -ENOMEM when allocation of the standalone
>   zero-sized resource fails.
> - Patch 2: retain the original !cxled->dpa_res guard in cxl_dpa_free().
>   An existing zero-sized reservation must reach the region,
>   enabled-state, and release-order checks.
> - Patch 2: update the commit message.
> - Patches 1 and 3 are unchanged.
> 
> Previous version:
> https://lore.kernel.org/linux-cxl/20260805055524.22311-1-icheng@nvidia.com/
> 
> 
> Richard Cheng (3):
>   cxl/region: Simplify poison_by_decoder() error handling
>   cxl/hdm: Allow zero sized HDM decoders
>   tools/testing/cxl: Enable zero sized decoders under hb0
> 
>  drivers/cxl/core/hdm.c       |  58 +++++++++++++------
>  drivers/cxl/core/mbox.c      |   3 +
>  drivers/cxl/core/region.c    |  69 ++++++++++++++--------
>  drivers/cxl/cxl.h            |  10 ++++
>  drivers/cxl/port.c           |   3 +
>  tools/testing/cxl/test/cxl.c | 109 ++++++++++++++++++++++++++++++-----
>  6 files changed, 195 insertions(+), 57 deletions(-)
> 
> 
> base-commit: 899648a2707d0405f573dfc7fe15385d9ba3af55

Applied to cxl/next:
057dc2892d1f
00f9ef9ad1ce
fef22d37d470

