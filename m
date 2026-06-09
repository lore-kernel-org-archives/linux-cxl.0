Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0115480953;
	Tue,  9 Jun 2026 18:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781028499; cv=none; b=V1wjMOVcoZ1MbJ2qdBl0V003ecr8bfrZnKv9L1NZa7Z2CVr5H1CQ5OcMtiAlDwf4KJiPp/E/yZoHbNeQjYvypq62z5j8qMDo/qzEBABhiGwpGkreMDSJXjSSZgNdDUqO/KbWvn9c0Pz2SFBbh1saqt/OyPKi9UVes/kKzEBw714=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781028499; c=relaxed/simple;
	bh=EQ61T7oU+tPJYq9+2SgA137DFFPGrTzsQlULuT3wgGY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H1UKU7unZw+/YsFAeTvJZTNGUQN8wewMVuAzsAwUYzJHyZEcKTEV4fqq0GsCTLnJZ1oKds0UW8u9jqb/Gipi1iKPGKCgO0ekTWKCO0SQyeJgk7UWtWfcyp4AJWzsewmoy4uOgcQnyf88byY54ovz6YprLg2LNk19p+zFjGapnXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kxVR44b9; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kxVR44b9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781028499; x=1812564499;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EQ61T7oU+tPJYq9+2SgA137DFFPGrTzsQlULuT3wgGY=;
  b=kxVR44b9VFYdTf3BX4pbrKxeh5qeFkFJInnCMVsFLgI+YKfF5cXd5CE7
   gR2a72DVcaAzifbR9Ls5kZJqqJkQVQLrOHejzAaRYfW8j8YKpbfhZPFZf
   6mkFvh1yyHwf0JUzJgBqzugrgQai9m+tuesipxkHzjSV/qgoIwv5MNSxp
   QkKD5DyPCm47uZsOx0CybzALlq/5h9hCTxh/pbuCzL3XN/WX2jJ7xMKpu
   AiEC/HkeKdsv5BmT9GEKB2BIzMPcnWUP1NHMksTaJWW7mWYjzI8p5qL7n
   9lveJ+vSKcFtIyZrqOJz24JcUPBQiKWE6oZE/18UlaMXMckfoyxp0iQIg
   w==;
X-CSE-ConnectionGUID: 6fQEjOAsRbSS0PPtR9MZKw==
X-CSE-MsgGUID: 9bNn5AkATiOEIJDaGMskFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="81709151"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="81709151"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 11:08:18 -0700
X-CSE-ConnectionGUID: Jub5imoIT9GbP4QOJoWo5A==
X-CSE-MsgGUID: BfCisRVbREWYp/6GK3M2Gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="245089571"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.109.206]) ([10.125.109.206])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 11:08:17 -0700
Message-ID: <be106fd7-8a8c-4f29-980e-1b5d9455cab4@intel.com>
Date: Tue, 9 Jun 2026 11:08:15 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/test: reject wrapped GET_LOG offsets
To: Samuel Moelius <sam.moelius@trailofbits.com>,
 Davidlohr Bueso <dave@stgolabs.net>
Cc: Jonathan Cameron <jic23@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <djbw@kernel.org>, Eric Biggers <ebiggers@kernel.org>,
 Alejandro Lucero <alucerop@amd.com>,
 "open list:COMPUTE EXPRESS LINK (CXL)" <linux-cxl@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20260605142036.2062347-1-sam.moelius@trailofbits.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260605142036.2062347-1-sam.moelius@trailofbits.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/5/26 7:20 AM, Samuel Moelius wrote:
> The CXL mock mailbox GET_LOG handler validates the requested CEL slice
> with `offset + length > sizeof(mock_cel)`.  Both fields come from the
> userspace CXL_MEM_SEND_COMMAND payload and are 32-bit values, so an
> offset near U32_MAX can wrap the addition to a small value and pass the
> bounds check.
> 
> The wrapped request then uses the original large offset as the source
> address for memcpy(), reading far outside the mock CEL array.
> 
> Validate the offset first and compare the length against the remaining
> CEL size so the check cannot wrap.
> 
> Assisted-by: Codex:gpt-5.5-cyber-preview
> Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  tools/testing/cxl/test/mem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index 271c7ad8cc32..5dc9601a2a7e 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -584,7 +584,7 @@ static int mock_get_log(struct cxl_memdev_state *mds, struct cxl_mbox_cmd *cmd)
>  		return -EINVAL;
>  	if (length > cxl_mbox->payload_size)
>  		return -EINVAL;
> -	if (offset + length > sizeof(mock_cel))
> +	if (offset > sizeof(mock_cel) || length > sizeof(mock_cel) - offset)
>  		return -EINVAL;
>  	if (!uuid_equal(&gl->uuid, &uuid))
>  		return -EINVAL;

