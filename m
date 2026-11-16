Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794867127;
	b=5IKWGH4/amqvZyMvmI6DowFZVW8BFLp4xzWdaFBotCP/rPFXadWJvDpU0mcq4aRAjS2w
	 tqgsE6Whg0HT9xJPwsx+Q5ypf0Z6tNw3zPNpG9vbkzplpqi3TMGOBgNksp+OwHL8jPm9D
	 LAiQKOUCedeu5lwn5QCWGsQrsTIAjZ53SPEz8fFfRn8xQfu6l1jN7e9OGVusPrqCkfqBB
	 hi9z+U+i4Mxll64XFFV/NRLQR3yKRixfMPFeGprPtywWs7LigGz+qOFaDrrEYWDJmCQ0E
	 xJxEr7WgTmkzGlo4NHJJEpF0dZ0vWvGfqg8Po6FU0GHtVZQINk3XVyPWlg2VYIQ80GQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794867127;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=V51Azc/0deU0Qn6b0g3DnT8VchKMF734reOpbz2WvfQ=;
	b=sd3FQWIixNg2dJz5HOW6BYl/YLnzkKtPX0P6QpERpfdm5SltbuU5u0DhBgFls/D6Ee54
	 ECNy7qUYVaN713Uoo3s/lmuqQ325sOdUN6emfcrS1alp3s+G3G7l3Lic1fdqu2UGJiXFB
	 1i3OTHrQnnlXT46peicweLF55Q0MpoiMz7/z111rPZw5QacfARH7sM9dSL5b9TTuI3Dg5
	 zFSlZtTeT/OvMhZ0Isx17IjmA5VccOnKwsUtozqj11qiAee0Gl3R6d7IXxuzr1jKf5746
	 dgmUTxPqiyxnbsDJK5jzTo0Ai0iCzmYvgOLCLVtdCyxRqHJqvxtxOYKp46SZeUOq1Hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KMb9Jmyx;
	arc=none smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9D5606A31C
	for <linux-cxl@vger.kernel.org>; Mon, 16 Nov 2026 22:12:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E9D5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KMb9Jmyx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794867127; x=1826403127;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9q3FyRGWBIKmfeVY+isAeqtAfcyuBAmN5VexUnO/W+U=;
  b=KMb9JmyxPBscfrHJCf0fyQpkWeusO5vYhy/pKvTdaTLsT6E+oMUwA8oX
   KyTuMpbmhRjTo4CMitIE/LwrMMNQoPtQkipuRQAZ4QJRZdWwJZt/LFqYo
   93PjeCyOkG+EXRmwySG5LU1kYPn1CnYeHYrydz0x9t10HYDeSMR6M5ucZ
   shT0G/Ug+3es/b+eWul4jPiRNV2HyBBRHLxM3IF0N/qtQNvtvH4UbEsiY
   DktlZg3d3d2TFRm5vigXbSKa9fVyFx36sOLUednNrCAewEOt/vUrj4BnA
   WxAUbn2dwdDgwoM0uxmWIQeF0E5htg02hohbqYoBtYz//yy6+AYUoqbNM
   A==;
X-CSE-ConnectionGUID: PkRA3VtlR/KYaGKdajOIKw==
X-CSE-MsgGUID: g4xhKM0NQE+B7+IPKz8ogQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3637046"
X-IronPort-AV: E=Sophos;i="6.27,217,1787036400"; 
   d="scan'208";a="3637046"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 14:12:07 -0800
X-CSE-ConnectionGUID: v8cawCjVSZqtTu1jXmE5WA==
X-CSE-MsgGUID: oJPP8u8NRmand6r1P0zCCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,217,1787036400"; 
   d="scan'208";a="9641508"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.108.118]) ([10.125.108.118])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 14:12:06 -0800
Message-ID: <8e2b99ab-9d2b-4fc3-863d-a97f3688f8ab@intel.com>
Date: Mon, 16 Nov 2026 15:12:05 -0700
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
Subject: Re: [PATCH v2] cxl/region: Restore a target's position from its slot
 after sorting
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: jic23@kernel.org, alison.schofield@intel.com, icheng@nvidia.com,
 ming.li@zohomail.com, benjamin.cheatham@amd.com, linux-cxl@vger.kernel.org
References: <20261106233711.2654827-1-dave@stgolabs.net>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20261106233711.2654827-1-dave@stgolabs.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/6/26 4:37 PM, Davidlohr Bueso wrote:
> Region auto-discovery records each arriving endpoint decoder in the
> first free @targets slot and sets cxled->pos to that slot. Once every
> member has arrived, cxl_region_sort_targets() calculates each one's
> interleave position and sorts the array by it. The original version of
> that function then restored cxled->pos from the member's slot in the
> sorted array, so that follow-on code could rely on
> p->targets[cxled->pos] naming the member, failed sort or not.
> 
> Commit 0cf36a85c140 ("cxl/region: Use cxl_calc_interleave_pos() for
> auto-discovery") dropped that restore. cxled->pos now keeps whatever
> cxl_calc_interleave_pos() returned, which on failure is a negative
> errno. A member that could not be placed is left in a region it cannot
> be detached from by position: deleting that region runs
> __cxl_decoder_detach(), which finds pos < 0 and triggers:
> 
>   cxl region0: expected mem0:decoder3.0 at position -6
>   WARNING: drivers/cxl/core/region.c:2314 at __cxl_decoder_detach+0x483/0x910
> 
> A decoder committed by firmware behind a switch whose own decoders
> were not committed for the range is enough to get there
> 
> The same stale position is what commit cbda6a2c2bec ("cxl/region: Fix
> out-of-bounds access in cxl_cancel_auto_attach()") had to work around
> by walking the array instead of indexing it.
> 
> Restore cxled->pos from the member's slot after the sort.
> 
> Fixes: 0cf36a85c140 ("cxl/region: Use cxl_calc_interleave_pos() for auto-discovery")
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

Applied to cxl/fixes
1731c729762b

> ---
> Found while battle testing BI changes.
> 
> Changes in v2:
>  - fix the hunk header
> 
>  drivers/cxl/core/region.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index a048bd5c06cb..d344bc4b5aab 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2045,6 +2045,14 @@ static int cxl_region_sort_targets(struct cxl_region *cxlr)
>  	sort(p->targets, p->nr_targets, sizeof(p->targets[0]),
>  	     cmp_interleave_pos, NULL);
>  
> +	/*
> +	 * Restore cxled->pos from its ->targets[] slot so that follow-on
> +	 * code paths can reliably do p->targets[cxled->pos] to
> +	 * self-reference their entry, whether or not the sort succeeded.
> +	 */
> +	for (i = 0; i < p->nr_targets; i++)
> +		p->targets[i]->pos = i;
> +
>  	dev_dbg(&cxlr->dev, "region sort %s\n", rc ? "failed" : "successful");
>  	return rc;
>  }

