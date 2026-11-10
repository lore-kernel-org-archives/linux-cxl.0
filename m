Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794341962;
	b=ACx/vszT03UI4Zk+qir3uI8gy3es1jC1ndGQMoZs1oum5jaafar5+Qs5amRedO8FFMfT
	 7dUL7DqTtNSfPVMIkA/geOY7fLEVrpQcC1ICEfAMw0llO9mWYw5K2DoEwTaARURpqCrGd
	 8xxCfmRSSecqp1oqekakGaqMaUjnwKsxqk23Gv2ijHJRt0bl6UqFXoVuJQDeOVFO5SH/S
	 yK3VPEKufuSxoM/UahL68xzkgbwkh9Vbq84Df/ysYQI0ky0g0ZyTT191ZzqXMYOkdTUwB
	 maAYUsOkuk6Nwk8438/anNdG8U8HxfxGsqm9bC1nniN1k2saXPwH3JUdwNWjcjx2XvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794341962;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=bxC0tQjvGJ32LOVAJGqs1v9Nn1bokk2GzxMcNXzGygw=;
	b=OIV+ZNK0na7KDbJAKMgv9fow8zCvYh/SuOLmlBADUj0bpG8X6aywSzOIQ75wCdTaBT2a
	 y3U5xFuc3J8ZyM7VBoZlTegxpTDcu/nw+blbtQV/InrU+mqytZdBUwBl8KXLQWWyu2cTN
	 602NJjvXN123Ott5qHQgm7qR3MHMESyPtbQf90b+cIRriFmfJ/Fcn07pkK2eSVMAd34Ff
	 rr2ZX6WH+uv9DixQfkUlmzg04ckp2ERy0jE6AuaUbU23Zsv3aEtA1N9gmMQXKEv+9bDSj
	 oKkDIma0UKR9usxe0L0RDP6Ngdi016TKp/Nsmq878tIsz8drU2pTpNB/3P9szrGtwuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YHK4jkTn;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D78B606A31C;
	Tue, 10 Nov 2026 20:19:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D78B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YHK4jkTn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794341961; x=1825877961;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aIZoJnWUZZabiGIlVqkG56XCJTn8DALqmx3ZpU6AjV4=;
  b=YHK4jkTnjPHIgtN4eD41Nwi66wIVYa8poVSOlCHQ/XUsFv771nv5OoNu
   GHGuEmirVHjiUNMjY1a8vGFYr37iUrO3lIcuZJaQjnIXSnrdVCkxWVGD0
   h2unc6qoM0KCBpCEEjISe5oQjhdI8RUdo7afzEy8eFq1NoHc1yCdMYnZk
   qIimagMuq3mZqYqyixIWcHSSJSK1FUYNY7vNnij3CZ8khbiiML8qrURkL
   DbZYJ48ScvAjf1gYqMy/qXkEOdjz/Ka8mJUW9oBgOwM7J35j6HYLmgn+k
   YqVv4GND3VbmF5f/tzzjZJ+4YaXgoWXRAc7KA3bCQiPf+h0lqSPdlpkGy
   A==;
X-CSE-ConnectionGUID: TAl5hdIWRg6IGjPgboCpCw==
X-CSE-MsgGUID: VGe0upFBR5G48gBfVnTasw==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="3108146"
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; 
   d="scan'208";a="3108146"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 12:19:21 -0800
X-CSE-ConnectionGUID: fGyPdhbBTxizbrmChbo/Dg==
X-CSE-MsgGUID: LtZUAXl/Q1KP1k8Q8sIhMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; 
   d="scan'208";a="8573422"
Received: from dwoodwor-mobl2.amr.corp.intel.com (HELO [10.125.111.75]) ([10.125.111.75])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 12:19:19 -0800
Message-ID: <eef1fcd1-1827-4303-a960-68d6748f68e7@intel.com>
Date: Tue, 10 Nov 2026 13:19:18 -0700
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
Subject: Re: [PATCH] cxl/edac: Mask DPA flags in the event record cache key
To: Jongwon Lee <ai@linux.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>,
 Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>,
 Richard Cheng <icheng@nvidia.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261030072721.31970-1-ai@linux.com>
 <8afa233c-13c3-478e-89d2-1d3f87ec7c08@intel.com>
 <179340826284.3478.8780635809480680434@linux.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <179340826284.3478.8780635809480680434@linux.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/30/26 5:57 PM, Jongwon Lee wrote:
> On 10/30/26 10:44 AM, Dave Jiang wrote:
>>> Co-developed with Claude Code.
>>
>> You can drop this now. Or just put it under ---
> 
> Moved it under --- in v2.
> 
>>> Signed-off-by: Jongwon Lee <ai@linux.com>
>>
>> Is this a real email address? Please use your actual email.
> 
> Yes, it's my own address and I read it. It's a linux.com alias
> that forwards to my inbox, and it's the one I use for my other
> upstream work (rasdaemon). Happy to change it if it's a problem.

If it's your own address it's fine for me. Although you can understand ai@linux.com would raise some eyebrows with the increased instances of bots sending patches to linux mailing lists. I hope Linus won't give us grief over this email address.

> 
> Thanks for the review. I'll send v2 shortly.

