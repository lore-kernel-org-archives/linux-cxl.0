Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A998194A49;
	Mon, 21 Oct 2024 06:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729492616; cv=none; b=oG7rRjgZZywEpe/ypiKlYiC1uFdjUMT7nmMliA5aYEfAjx1Zq9yo+SiStU+e9cYRjtOyVp+l0iCIWZv2N/aYuDlraRbSBvkT/rfFv8v9zleY2lZh7ZMdMgNAmvc+hUkkzhqCBP7/eO/Ky31NmwiNXUthLAmzv2KCbyfzHzHDJFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729492616; c=relaxed/simple;
	bh=r8Y1zyu4RvBdryMzhceEsx+cQKkc+1PuhMnt3cv/Dc8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hB4qUizNayBKORmKJDHBu+3RkgaPMbVEdz8uopPNRKAh+4BrY26mA8I5ofj33VuUon6CAgqSZ4JPkxxF0lfUmXXpT4lhHU366/nkqiZB56s857zdhUe2MTRMxUnldKCw8abpYRKnArafLf/trTXfHB6ZZBFW26FJbV13nlwWPTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xguos8CT; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xguos8CT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729492615; x=1761028615;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=r8Y1zyu4RvBdryMzhceEsx+cQKkc+1PuhMnt3cv/Dc8=;
  b=Xguos8CT3381gJP8blvCc6Fyk+dUzz/uw3HRMBumuJ9Qh8Mewyr5oePr
   vXB9WqK6dpMu50lI1NWFHondMv1s1VzFX7pp6WecvCR514TJSS76Gy/mE
   1KHlcld9XQb6JF14tkcP8Mo0xAS5jCt7PpU40ly63Em5AdVSJRBS0ZGeQ
   jm5OamEBk+jxHDW1q5sHtd5dlSYxG9CpH+cL6qZsC6xwQm6viYpMlZkZ+
   KwWFDUHha8rEtE5QiG/58Cie0bhfEnwOv1rvFhxbTHUECw0Oad/+1Dz20
   bQmDNjsB5UmQ9n7fw87CcAjB7Ga+q8Si270DGuwOZCf8E9Nt6tQhIHmPJ
   g==;
X-CSE-ConnectionGUID: 5LefrVy7SPWoIdAo0915jg==
X-CSE-MsgGUID: uQIsQevURnWIktK+VwTNHw==
X-IronPort-AV: E=McAfee;i="6700,10204,11231"; a="40329309"
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="40329309"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2024 23:36:54 -0700
X-CSE-ConnectionGUID: ALpJtLuERPe8PB9buqQm1A==
X-CSE-MsgGUID: sDWXCQTUQx6onzTxI7N0dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="80246044"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2024 23:36:51 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>,  linux-cxl@vger.kernel.org,
  linux-kernel@vger.kernel.org,  Gregory Price <gourry@gourry.net>,
  Davidlohr Bueso <dave@stgolabs.net>,  Jonathan Cameron
 <jonathan.cameron@huawei.com>,  Alison Schofield
 <alison.schofield@intel.com>,  Vishal Verma <vishal.l.verma@intel.com>,
  Ira Weiny <ira.weiny@intel.com>,  Alejandro Lucero <alucerop@amd.com>,
  Ben Cheatham <benjamin.cheatham@amd.com>
Subject: Re: [PATCH 4/5] cxl: Set type of region to that of the first endpoint
In-Reply-To: <6712d0f737037_10a0329441@dwillia2-mobl3.amr.corp.intel.com.notmuch>
	(Dan Williams's message of "Fri, 18 Oct 2024 14:19:51 -0700")
References: <20241015065713.308671-1-ying.huang@intel.com>
	<20241015065713.308671-5-ying.huang@intel.com>
	<6711909cd5d83_3f14294e@dwillia2-xfh.jf.intel.com.notmuch>
	<877ca57vlb.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<6712d0f737037_10a0329441@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Date: Mon, 21 Oct 2024 14:33:18 +0800
Message-ID: <87y12i55jl.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Dan Williams <dan.j.williams@intel.com> writes:

> Huang, Ying wrote:
>> Dan Williams <dan.j.williams@intel.com> writes:
>> 
>> > Huang Ying wrote:
>> 
>> [snip]
>> 
>> >> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> >> index 21b877d8582f..d709738ada61 100644
>> >> --- a/drivers/cxl/core/region.c
>> >> +++ b/drivers/cxl/core/region.c
>> >> @@ -1926,7 +1926,10 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>> >>  		return -ENXIO;
>> >>  	}
>> >>  
>> >> -	if (cxled->cxld.target_type != cxlr->type) {
>> >> +	/* Set the type of region to that of the first endpoint */
>> >> +	if (cxlr->type == CXL_DECODER_INVALID) {
>> >> +		cxlr->type = cxled->cxld.target_type;
>> >> +	} else if (cxled->cxld.target_type != cxlr->type) {
>> >
>> > No, the type of the region is determined by the caller and should be
>> > gated by the region capability. For type-2 region creation I doubt
>> > userspace is going to be creating those vs the accelerator so this all
>> > seems backwards to me.
>> 
>> How do we determine the type of the endpoint?  Specify it in type2/type3
>> device driver?
>
> Why does the endpoint type matter? Memory expansion can be supported by
> HDM-D[B], and an accelerator could have one or more HDM-H decoders.
>
>> If so, we will specify the type of both the endpoint and the region in
>> type2/type3 device driver.  Then, why not only specify the type of the
>> endpoint?  The type of region can be determined from the type of the
>> endpoint.
>
> Because CXL HDM protocol is per decoder not per device.

Sorry for confusing.  When I said endpoint, I wanted to say "endpoint
decoder" actually.  IIUC, the coherence type of region should be same as
that of all endpoint decoders participating the region.  If we specify
the coherence type of the endpoint decoders, the coherence type of the
region should be same, so we don't need to specify it again?  We need to
check root decoder capability as you pointed out.

Best Regards,
Huang, Ying
