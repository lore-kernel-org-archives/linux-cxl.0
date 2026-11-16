Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794872798;
	b=KkQX+FaeRtU3BT88H0bjODNeP24rvBEuPM07g4RvWGBJIGptBgbUIwdKQfUKE//Q7Pmb
	 GTUi3FDcOsldVrYSjv33IDVj8uEzR3xtmh4JwhJE7Tem8zm/7IAdT72nO0oDvMM5mgwgZ
	 TkPhGXMu6eAd8h6enP9FnpRvvZHdORMh9ELQwA/SCpWPAjDXZdv3DhsQhlMB2OWQudTzm
	 lLL7cH2shGjAkC2z9n3NiBxJWgE6Bq6urrkmfKDVYCBsV1u/Y8UqR2PLK86qWPsh7xSeM
	 sNx5ci9Uw4pAF6+OW4Z1bkl36I1FkHsHTOK+Zhyp3rJuScWtvXaVagr87MsrO0KI9ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794872798;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=9lp9dIPUj0Q8sjCz4aLKKgAc+qY55KnTpzUDV8wZiCI=;
	b=ZcRNxN2nzAXexmExkm5NQYoQk3vfpmBsQo7G1yPJcTLD0Knscd4VgsTRT8R7vjt/n3ff
	 ez/h9P1rgajQ6V+TQ4YoqxKUfNXhnAw+wz38g7J4eSUy6G4RR9/FKCnKooCNEbRt/ekAp
	 U511870Sv2dGbHB3zw3a2ZdDzZ1qUzshV0fl+COmZsNrvaUsf0ObDCOugT8DWWWfGBf5x
	 ILFwpxiCgRsdW2n8M6G3+U+FBnJlX5Gpl4xR0P9a7kcwW2I5iI+NHd2QIru2+gwdE79af
	 oMB4XVLdKEx3FkWAR9khm6fKj71fGrCvLo+9QWSQb/vcyVH4Y0XHr6cKACy4On0DuPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dxIFCflG;
	arc=none smtp.remote-ip=192.198.163.17
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AB0606A31C
	for <linux-cxl@vger.kernel.org>; Mon, 16 Nov 2026 23:46:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3AB0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dxIFCflG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794872798; x=1826408798;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3blMApxee7GChTIRJMLNAm+ON1JzkSaSRwpf5/DW9+U=;
  b=dxIFCflG3N+u7Qxuau4jdgl56nvp+mDUo8PSDGyzEuu82JnEn1rPqoDd
   KqyDMQ6yu527CLxyEtApuE/BuG6tRZu02zrF16EbR/cU+IIcB1NYOgB96
   O39qvDrt/+/nVFIHeQ6LDLwcXaLRUbA6NzHdoS5hr8Ktr3qoG9tItanoz
   yTSHHzhAFxtFe1OpbO0+RDlFmP+TF/r6cwVNGDehoHrafDTLYTJ8TCiwn
   StBIE/gmoOPQtpAMdYfvISkiHLOIgpST2k+c/bAio2eTDnWobdZGIJuQr
   PKaqLm1dsHycoQle2N2WWR69TwUjOeaSpCRBFlq7RdNpKzzdc2MwxNK59
   Q==;
X-CSE-ConnectionGUID: +RsiAu5STzKuJZTUdHLVIQ==
X-CSE-MsgGUID: rZ++IU59QhWjd7qWrlFVsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3618915"
X-IronPort-AV: E=Sophos;i="6.27,217,1787036400"; 
   d="scan'208";a="3618915"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 15:46:37 -0800
X-CSE-ConnectionGUID: WKBIEFdlQvqD8QU5VBDNcA==
X-CSE-MsgGUID: r6j34u8YQy6qfvivBbltfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,217,1787036400"; 
   d="scan'208";a="10006438"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.108.118]) ([10.125.108.118])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 15:46:36 -0800
Message-ID: <73a5950e-4118-42cc-9aa4-c0dcef1e2386@intel.com>
Date: Mon, 16 Nov 2026 16:46:34 -0700
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/5] CXL: Support region granularities finer than the
 root
To: Alison Schofield <alison.schofield@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>,
 Li Ming <ming.li@zohomail.com>, Robert Richter <rrichter@amd.com>,
 Richard Cheng <icheng@nvidia.com>, Ben Cheatham <benjamin.cheatham@amd.com>
Cc: linux-cxl@vger.kernel.org
References: <cover.1794000806.git.alison.schofield@intel.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <cover.1794000806.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/6/26 2:57 PM, Alison Schofield wrote:
> Changes in v7:
> - Rebase onto for-7.5/cxl-port-refactor
> - Patch 3: adjust unaligned translate to work w new layouts (Sashiko)
> - Patch 4: commit log wordsmith only
> v6: https://lore.kernel.org/linux-cxl/cover.1791863201.git.alison.schofield@intel.com/
> 
> 
> Begin Cover Letter:
> 
> Linux requires a region's interleave granularity to equal the interleave
> granularity of its interleaving root decoder. This series relaxes that one
> restriction: a region granularity may be finer than the root granularity,
> provided the interleave levels between them refine monotonically toward
> the endpoints.
> 
> This series does not add general support for every granularity arrangement
> the CXL Specification permits. A region granularity coarser than the root
> remains invalid, and configurations whose granularity refines and then
> coarsens along the decoder path remain unsupported. Of the Mod3
> configurations listed in CXL 4.0 Section 9.13.1.1, all are supported
> except Table 9-6 row 6, the refine-then-coarsen 12-way composition.
> 
> The use case driving this series is 6- and 12-way regions behind a 3-way
> host bridge interleave, CXL 4.0 Tables 9-6 and 9-7, which have no
> same-granularity alternative. Power-of-two regions finer than the root
> fall out of the same implementation.
> 
> Support applies to both firmware programmed auto regions and user created
> regions.
> 
> Two prior proposals addressed parts of this gap:
> 
> AlisonS introduced position arithmetic and sysfs gating for auto and
> user-created regions to support the 6- and 12-way interleave configurations
> without a same-granularity alternative [1].
> 
> RobertR introduced an HPA selector-bit model for auto regions that allows
> multi-level power-of-two interleaves regardless of granularity ordering [2].
> 
> Series structure in v7:
> -----------------------
> Patch 1 documents which region granularities Linux supports relative to the
> root and the monotonic refinement model.
> 
> Patch 2 generalizes endpoint position calculation to account for granularity
> changes between decoder levels.
> 
> Patch 3 enables auto regions with a granularity finer than the root and
> validates their decoder geometry.
> 
> Patch 4 enables user created regions with a granularity finer than the root
> by relaxing the existing root/region granularity restriction.
> 
> Patch 5 adds a cxl_test topology and coverage for region granularity finer
> than the root.
> 
> The companion NDCTL patchset that allows these regions in 'cxl create-region'
> and adds the unit test support is posted [3].
> 
> [1] https://lore.kernel.org/all/20250306232239.2609017-1-alison.schofield@intel.com/
> [2] https://lore.kernel.org/all/20251028094754.72816-1-rrichter@amd.com/
> [3] https://lore.kernel.org/linux-cxl/cover.1791863817.git.alison.schofield@intel.com/
> 
> 
> Alison Schofield (5):
>   Documentation/cxl: Describe region granularity finer than the root
>   cxl/region: Generalize endpoint position mapping
>   cxl/region: Support auto region granularity finer than the root
>   cxl/region: Support user region granularity finer than the root
>   cxl/test: Add a topology for region granularity finer than the root
> 
>  .../driver-api/cxl/linux/cxl-driver.rst       | 119 +++++
>  drivers/cxl/core/region.c                     | 224 +++++++---
>  tools/testing/cxl/test/cxl.c                  | 420 +++++++++++++++++-
>  3 files changed, 683 insertions(+), 80 deletions(-)
> 
> 
> base-commit: 0e3e8b653ca3ab145aced729861cf0d1a06da69e

Applied to cxl/next:
4e23c13ed6ec cxl/test: Add a topology for region granularity finer than the root
7413720a855a cxl/region: Support user region granularity finer than the root
25af7f1fc265 cxl/region: Support auto region granularity finer than the root
c03e78e9f6e6 cxl/region: Generalize endpoint position mapping
23bcea9a9877 Documentation/cxl: Describe region granularity finer than the roo

