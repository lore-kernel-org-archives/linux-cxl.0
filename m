Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D505D3033DE
	for <linux-cxl@vger.kernel.org>; Wed, 17 Jun 2026 17:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781717353; cv=none; b=Ii6tjrUgEgnOnYiDO/DcOED6HdSAu2GW4zKzIL7YIpdKsdXA1mGYd341qxOd+YSccg+Saq7+X2g9g8kk9LIlNkIYkchweAYkZNPwxkMJbOuTqwWgmQKWepWRHhREoWM3qsQwocOCnc7ENaa5/YLUIdKC30pndthIBRS8+d8ZVkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781717353; c=relaxed/simple;
	bh=aI8AqA3QmLZ1OilUrSdTUScfMtSKL8yw+BaNBzN7eqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cUKAJEDGE6iBbqCVaKBDLJxeNnNldi6Br0bfq7brZiIJ50PyAaPpuSEioCdYGq1NBrjDFHXyx4F5YSv5DKoO8O/7AjnCRkLk2d8heVnYyQwpLYgkgZ7guxabzp9uZvprSCgftj4VNCsT5J7em2sbEf56Utg31aMG2vj1z3l9L9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iyoG6tYo; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iyoG6tYo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781717352; x=1813253352;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aI8AqA3QmLZ1OilUrSdTUScfMtSKL8yw+BaNBzN7eqo=;
  b=iyoG6tYoYZVlKSNuXsCIrC+OloKE6xEYV4pnmpxsuFruZyNwe58NMQwK
   g43f6wPdKgJkFKi4tie7itY1NYB09Q6zHo3P7TrLuN9tBv6rh1JvIgIwt
   tGPBBTqI1UGt31k7LhrVE8P02gas+3xuUFx6OPmBs1ELlJhf5PZ6yILok
   Aijn3yxWRlNjBEDVty7OSoT+/3OL1cMd6zZyY+RwOLDi8YK5FohrMQMp1
   zRaVFBJzAP6n8PJrhA6N7G73QW8KwROKLWGG4OhnVPuhWytIVvm9vJ5wm
   fkybQ6PR5f1pmZBY9p2PQ9z6sW34c65fjxdOmZtb2EaGTyTaVCHaT0Fut
   g==;
X-CSE-ConnectionGUID: ihrgv461S6CrNHVta3zjyQ==
X-CSE-MsgGUID: drB3cb13QPiIKMnlBWgmSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="86191442"
X-IronPort-AV: E=Sophos;i="6.24,210,1774335600"; 
   d="scan'208";a="86191442"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 10:29:11 -0700
X-CSE-ConnectionGUID: YV2WCLBFQWycZc71qDn/aw==
X-CSE-MsgGUID: HOvPrOxUTZiLShwRrlB+gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,210,1774335600"; 
   d="scan'208";a="250017776"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.111.162]) ([10.125.111.162])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 10:28:42 -0700
Message-ID: <8847c2e5-f896-42fc-a7e4-dd0aaf08c981@intel.com>
Date: Wed, 17 Jun 2026 10:28:41 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/6] cxl/test: Add cxl_test accelerator driver
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: linux-cxl@vger.kernel.org, djbw@kernel.org, dave@stgolabs.net,
 jic23@kernel.org, alison.schofield@intel.com, vishal.l.verma@intel.com
References: <20260611234409.256765-1-dave.jiang@intel.com>
 <20260611234409.256765-7-dave.jiang@intel.com> <ajKt3db8vA_SEvSX@monoceros>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <ajKt3db8vA_SEvSX@monoceros>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/17/26 7:24 AM, Uwe Kleine-König wrote:
> Hello,
> 
> On Thu, Jun 11, 2026 at 04:44:09PM -0700, Dave Jiang wrote:
>> +static const struct platform_device_id cxl_mock_accel_ids[] = {
>> +	{ .name = "cxl_type2_accel", 0 },
> 
> Please drop the 0 here (and the comma before it).

Ok will do. thanks.

> 
>> +	{ }
>> +};
> 
> Best regards
> Uwe

