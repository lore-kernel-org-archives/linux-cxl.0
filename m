Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795018818;
	b=5f/GSDeaXVscPXM9mJfxbSdpCJ+GJ5I8hk/D7TFOUPL9barTS/amJoVgCTVUydDr1CoC
	 hce8AHlTGWIG3UeA8DG5rMpiQVMY59COstiI847VAJa8JKPy8R3IxXdiElZn801/WWCsM
	 gzHjp/1V3+l/oF4RRsp7RsTEdI9UTDMxvA88wJndIxzfYKnO/5qr9B0yDMFIVfyLSsbNX
	 X9WLTf0UIcX0M7JyIZQ4BoD8oUqfxN3veoHmxHxKDwfpgCRkeefVadE6SKtich/mgK/nb
	 xDgAa9mOq52NysWY7Bx00fpM4HN1axxoMndDVzhRdu8JzsyjO4hdPUMU3zDfQNzuTgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795018818;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=56ouFndn5wiI6Uwlus+E/QgzoFTFjnLdf7ld/cKEI8s=;
	b=dGf5Z6+Plj0bDeOhL8/8Ad9Rc4Nsyvsmve21DT3hIwAyMQuaKJXo/8FaYKMcLmpfzOrf
	 JRBIu5rxsQCUyUYV8xnr1amtJMq1yktz2++uPDxuc34iRUCIEmpsHZ5ies1RTfMuRve6X
	 3+R+meqYWZ0G6giZQ22J5aCw/ieG9MACh4WoWD9jUkEWgfcaBB0X9w7gLfm3feJ8kFmwd
	 OUxrGE7IS4T4v75mLIif45Q7/ynaeRGAgTQ/5642E7LuEGisIGgGKBc6TSHr2CGVKwhu4
	 SETNO9IoF/2jCzbh92RWcabOd/Cla+KP0VuKpxI4PAeTyDquYjRnsK8tEUQ318wNXuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GjPjh3XK;
	arc=none smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D096B606A32C;
	Wed, 18 Nov 2026 16:20:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D096B606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GjPjh3XK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795018818; x=1826554818;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/Ez9s2hEEvfq6Za+e/bLyAy1u7UFhOFcRdzMVq6WSII=;
  b=GjPjh3XKcZCZ+dRNR0W4nffkqHovJT82xHK8BGsEZuv4/DGeW+u71TTp
   nrP+zdQ7xKDzjSvJsorGd7iBQaiIFPkxPO15lIqIEHHNP/+/M39R/CHTv
   qSTfZoK4SqchmGMsQqo1tDDvs6PaWxIHg7Bh74dTDQqvxkYoyw2yuim+4
   qUgmgRQFfNZFHFXRTnzUxT7xDSXM6ky1h7XOjIujAhV06GBMThGTdxgRs
   93nTkl5uk7Ow8wgpubFb3Hz0Cb73/wSbexZmllp/qGtRZAs6neXVtAcdP
   VXmjlGY1ttJsPuT4IT9opGdhhFTXs1ounpzcEonPK+hDjVwIProcWB3wB
   A==;
X-CSE-ConnectionGUID: qQ2fR+N3QPqevDq6VBaI1g==
X-CSE-MsgGUID: NfodgGCbQHK5HHN+DswIfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3754921"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3754921"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 08:20:17 -0800
X-CSE-ConnectionGUID: kW7v2zLpTMq57LAb1hPIRw==
X-CSE-MsgGUID: dNmllit2TzKWow/KX9akwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="10578813"
Received: from jjgreens-desk24.amr.corp.intel.com (HELO [10.125.109.2]) ([10.125.109.2])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 08:20:16 -0800
Message-ID: <c24154fc-057f-45c4-891c-b091758107ac@intel.com>
Date: Wed, 18 Nov 2026 09:20:14 -0700
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
Subject: Re: [PATCH v5] cxl/edac: Fail ECS threshold read for reserved
 encodings
To: Yili Zhang <zhangyili01@baidu.com>, jic23@kernel.org
Cc: alison.schofield@intel.com, benjamin.cheatham@amd.com, dave@stgolabs.net,
 djbw@kernel.org, linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 shijujose2008@gmail.com, vishal.l.verma@intel.com
References: <20261118120736.7181-1-zhangyili01@baidu.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20261118120736.7181-1-zhangyili01@baidu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/18/26 5:07 AM, Yili Zhang wrote:
> cxl_get_ecs_threshold() extracts a 3-bit index (0-7) from the
> device-supplied Error Check Scrub (ECS) config word and uses it to
> index ecs_supp_threshold[], which only has 6 elements. A device
> reporting index 6 or 7 causes a read beyond the end of the array,
> and the driver reports the resulting value to userspace through
> the EDAC 'threshold' sysfs attribute.
> 
> The threshold count field also has reserved encodings 0-2, which
> currently read as 0 from the sparse lookup table. That behavior is
> not intentional; it is just an artifact of the array's implicit
> zero-fill. The ABI documentation only lists 256, 1024 and 4096 as
> supported values, and the write side (cxl_set_ecs_threshold())
> rejects everything else, so a reserved encoding can only come from
> the device reporting it. Rather than documenting 0 as well, make the
> read fail for all reserved encodings and only ever report the
> documented values.
> 
> None of these encodings can be written through the sysfs write path,
> and no device is known to report them, so this is hardening against
> a device returning values not covered by the spec rather than a fix
> for known hardware.
> 
> Convert the cxl_get_ecs_*() helpers to return an int and write the
> attribute value through an output parameter (u32 * to match the
> macro), so that errors propagate through the shared
> CXL_ECS_GET_ATTR() macro to the sysfs read.
> 
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Yili Zhang <zhangyili01@baidu.com>

Applied to cxl/next:
a15688352fe7

> ---
> v5: Drop "adjacent .rodata" and "small info leak" from the commit
> message, since what sits beyond the array depends on compiler and
> linker layout (Alison Schofield), and add her Reviewed-by. The
> diff is unchanged, so Ben's Reviewed-by carries over from v4.
> 
> v4: Spell out Error Check Scrub (ECS) on first use (Ben Cheatham)
> and drop the Suggested-by tag (Alison Schofield). The diff is
> unchanged, so the Reviewed-by is carried over from v3.
> 
> v3: Per review feedback, drop the Fixes tag and reword the
> description to make clear this is hardening against a device
> reporting values not covered by the spec rather than a fix
> (Jonathan Cameron).
> 
> v2: Per review feedback, fail the read with -EINVAL for all reserved
> encodings instead of returning 0, converting the cxl_get_ecs_*()
> getters to an int return with an output parameter so the error
> reaches the sysfs read (Alison Schofield).
> 
> v1: https://lore.kernel.org/all/20260928073553.85669-1-zhangyili01@baidu.com/
> v2: https://lore.kernel.org/all/20260930095627.32616-1-zhangyili01@baidu.com/
> v3: https://lore.kernel.org/all/20261021152053.85322-1-zhangyili01@baidu.com/
> v4: https://lore.kernel.org/all/20261029131013.85983-1-zhangyili01@baidu.com/
> 
>  drivers/cxl/core/edac.c | 26 +++++++++++++++++---------
>  1 file changed, 17 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
> index b321971fef58..fd6612dde7f1 100644
> --- a/drivers/cxl/core/edac.c
> +++ b/drivers/cxl/core/edac.c
> @@ -624,21 +624,31 @@ static int cxl_mem_ecs_set_attrbs(struct device *dev,
>  			       0, NULL);
>  }
>  
> -static u8 cxl_get_ecs_log_entry_type(u8 log_cap, u16 config)
> +static int cxl_get_ecs_log_entry_type(u8 log_cap, u16 config, u32 *val)
>  {
> -	return FIELD_GET(CXL_ECS_LOG_ENTRY_TYPE_MASK, log_cap);
> +	*val = FIELD_GET(CXL_ECS_LOG_ENTRY_TYPE_MASK, log_cap);
> +
> +	return 0;
>  }
>  
> -static u16 cxl_get_ecs_threshold(u8 log_cap, u16 config)
> +static int cxl_get_ecs_threshold(u8 log_cap, u16 config, u32 *val)
>  {
>  	u8 index = FIELD_GET(CXL_ECS_THRESHOLD_COUNT_MASK, config);
>  
> -	return ecs_supp_threshold[index];
> +	if (index >= ARRAY_SIZE(ecs_supp_threshold) ||
> +	    !ecs_supp_threshold[index])
> +		return -EINVAL;
> +
> +	*val = ecs_supp_threshold[index];
> +
> +	return 0;
>  }
>  
> -static u8 cxl_get_ecs_count_mode(u8 log_cap, u16 config)
> +static int cxl_get_ecs_count_mode(u8 log_cap, u16 config, u32 *val)
>  {
> -	return FIELD_GET(CXL_ECS_COUNT_MODE_MASK, config);
> +	*val = FIELD_GET(CXL_ECS_COUNT_MODE_MASK, config);
> +
> +	return 0;
>  }
>  
>  #define CXL_ECS_GET_ATTR(attrb)						    \
> @@ -655,9 +665,7 @@ static u8 cxl_get_ecs_count_mode(u8 log_cap, u16 config)
>  		if (ret)						    \
>  			return ret;					    \
>  									    \
> -		*val = cxl_get_ecs_##attrb(log_cap, config);		    \
> -									    \
> -		return 0;						    \
> +		return cxl_get_ecs_##attrb(log_cap, config, val);	    \
>  	}
>  
>  CXL_ECS_GET_ATTR(log_entry_type)

