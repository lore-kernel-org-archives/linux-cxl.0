Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A0D37E2E1
	for <linux-cxl@vger.kernel.org>; Mon, 23 Feb 2026 23:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771887944; cv=none; b=Wvyu89eUOfNCBdbWfi1z4CcGRTbymojExKZqib9UaIXvFSGOmLGjOOG2x2tHYn/7ewUVQ1viy3wlDGf9pvZlVZtOl4dcVUwf7sXZUeIvHMsUcSFu6IbFZ05/nQe0eJ0SDl8VRejb5CyS+rfhi2QoLfpj2scaIQf7VhhYeP1ZEJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771887944; c=relaxed/simple;
	bh=FhE75U/1hjmwQC+kGQwbD5Y17OM1u9UwFMphycqRYKk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GglVier0zxgVw4b+hPTtOH5o17a3OOf6OQiQq7lKzFNAeqeAvmiyI8laKQFTTaiBcSu0NK+QRH0Fe9ylX1OlSPRP9a4STRDuC8BqCgYbUQnzuXHV5RMTMiYGvYwUwKHizMM39LQIJcetutL/4q0cBoDUrFrnG1TqNn9R0RGcTyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zxce6B6D; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zxce6B6D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771887943; x=1803423943;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FhE75U/1hjmwQC+kGQwbD5Y17OM1u9UwFMphycqRYKk=;
  b=Zxce6B6DLeaZ1VeIXYAH3Pf7L5KNMnQEJf8GKcJh75Q6Md9fhzeUxApM
   QM9WwNqFxbBnmUuLezNYtKfb08Vce9MHunwp8g6D1Ehz/zs/ZAMuosOmz
   vgSynBFiwW/x60YicSUZ41GIFwN5A/lMWtde/Je5vmgpsHsZNsyDxZEZh
   7D4VDsqTP6XfKU6Thj8P+ZETe9yG+/DjL1Ja772Y3EyVgYTq38OkAB23h
   HEDaezzoNLBSzzkLVpFWbc52mhhmfdsI5zi2LzWVLtOXIA35r70kbVXIw
   SBAiOsZBRk4sQxQeF8u9daD8lC2ERZSiGDZVzNVYASbVUkx+dFqFLpNtz
   g==;
X-CSE-ConnectionGUID: gv7fKCodRwOL687JXel4Lg==
X-CSE-MsgGUID: 58CJlvWOT0K+X+amq7ORiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="72600902"
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="72600902"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 15:05:43 -0800
X-CSE-ConnectionGUID: CMV9kg1KTZiY8mFTouN8/A==
X-CSE-MsgGUID: xVV+Q/bkQmCiC82p4WBzFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="215563971"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.110.227]) ([10.125.110.227])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 15:05:42 -0800
Message-ID: <d6ddf495-fa6e-4f99-b087-993810a81154@intel.com>
Date: Mon, 23 Feb 2026 16:05:40 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] cxl: Test CXL_DECODER_F_LOCK as a bitmask
To: Alison Schofield <alison.schofield@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
References: <98851c4770e4631753cf9f75b58a3a6daeca2ea2.1771873256.git.alison.schofield@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <98851c4770e4631753cf9f75b58a3a6daeca2ea2.1771873256.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/23/26 12:13 PM, Alison Schofield wrote:
> The CXL decoder flags are defined as bitmasks, not bit indices.
> Using test_bit() to check them interprets the mask value as a bit
> index, which is the wrong test.
> 
> For CXL_DECODER_F_LOCK the test reads beyond the defined bits, causing
> the test to always return false and allowing resets that should have
> been blocked.
> 
> Replace test_bit() with a bitmask check.
> 
> Fixes: 2230c4bdc412 ("cxl: Add handling of locked CXL decoder")
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Applied to cxl/fixes
8c0025ee29f03d74d34b77127192b9db8457564c

> ---
> 
> Changes in v2:
> Split patches to align w Fixes Tags for backport ease
> Rebased on 7.0-rc1
> 
>  drivers/cxl/core/hdm.c    | 2 +-
>  drivers/cxl/core/region.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index e3f0c39e6812..c222e98ae736 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -904,7 +904,7 @@ static void cxl_decoder_reset(struct cxl_decoder *cxld)
>  	if ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)
>  		return;
>  
> -	if (test_bit(CXL_DECODER_F_LOCK, &cxld->flags))
> +	if (cxld->flags & CXL_DECODER_F_LOCK)
>  		return;
>  
>  	if (port->commit_end == id)
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index fec37af1dfbf..780ec947ecf2 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1100,7 +1100,7 @@ static int cxl_rr_assign_decoder(struct cxl_port *port, struct cxl_region *cxlr,
>  static void cxl_region_setup_flags(struct cxl_region *cxlr,
>  				   struct cxl_decoder *cxld)
>  {
> -	if (test_bit(CXL_DECODER_F_LOCK, &cxld->flags)) {
> +	if (cxld->flags & CXL_DECODER_F_LOCK) {
>  		set_bit(CXL_REGION_F_LOCK, &cxlr->flags);
>  		clear_bit(CXL_REGION_F_NEEDS_RESET, &cxlr->flags);
>  	}
> 
> base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f

