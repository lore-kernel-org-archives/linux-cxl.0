Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F79A3F9D2
	for <linux-cxl@vger.kernel.org>; Tue, 12 Aug 2025 18:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755022293; cv=none; b=PsTMpTtBQFGrr4Z6Heatza+FoAT+p5oS/lMmYSLk3JXey8hrrQcaC0Zi3UNIVu/GjUoTb0c51Dke25jBelqUuoaSfaBB766vaccKhS6vKiKdSarNI9aS2iIXPXHWYeu75z4nmV/y/rivupXDqcUdCyiYCHY6oy7WlFymL8WatLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755022293; c=relaxed/simple;
	bh=YJJbV+qrcr/yH0PkDoWywFmaJcbADJ+cuppnjz+/3w8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UWDGJP7PFnqQ8RrTPWeyyXkZuMe77X1nNeFWRviGfAVp3o5D/B41UoBNzORlL/L3pYpPKOmzbhPzLFTcnSFCj0LnRs2FA7zw/qcM9qSfCkMiA7mdmT/EuUpx6UBYUnfnRt1azSYgwprpzkihfR9PsSfFoYYB7V4NH0O4+2DITCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G/rAfNN+; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G/rAfNN+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755022291; x=1786558291;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YJJbV+qrcr/yH0PkDoWywFmaJcbADJ+cuppnjz+/3w8=;
  b=G/rAfNN+Sdf6ZH9GORu1oX/kK83o5isjACu0guLn/glXBQo7g7uGfb73
   anZ82uvcdNLg3G0818NjWcM9V1l6aFCJqWHDmH2V9svt8CWPDregRTwui
   Iy5yM0WCAeNXhEVW7cOteVgEHCtktf2o88xN5sXtYtQhLrf7vn/CqsWra
   +p0RVW+ISe3LJIRqvEBiLud3zJiOKy3zuzdgQmWz+9sZTWXnuyE/cWAKg
   iRljajwG/VzAeRmC66mcS5a6Ws5+iTA/98bX5roz2wFm0kn/ZOH4fxg40
   AcQIAVveGGwpjivv5eNDF3cbM+DL6QqHQUDAjzffbQXeK80P0tIyc1JtW
   Q==;
X-CSE-ConnectionGUID: PKNh6AijS568IkR0drUUkw==
X-CSE-MsgGUID: goi6WFNrRwuy/UBKEGtEIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="57455450"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="57455450"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 11:11:31 -0700
X-CSE-ConnectionGUID: galnTJxkQPiDSwGoxYnx1w==
X-CSE-MsgGUID: OK86H8UTQRquvJ1rTF4ejg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="170462029"
Received: from anmitta2-mobl3.gar.corp.intel.com (HELO [10.247.119.148]) ([10.247.119.148])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 11:11:26 -0700
Message-ID: <151cb0e4-8ca4-461b-9d60-81c0e4504bbe@intel.com>
Date: Tue, 12 Aug 2025 11:11:21 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 04/10] cxl: Defer dport allocation for switch ports
To: dan.j.williams@intel.com, linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com
References: <20250714223527.461147-1-dave.jiang@intel.com>
 <20250714223527.461147-5-dave.jiang@intel.com>
 <687fb33bc294d_134cc7100b1@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <687fb33bc294d_134cc7100b1@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/22/25 8:50 AM, dan.j.williams@intel.com wrote:

<--snip-->

>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index 3f1695c96abc..de7883747555 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -403,6 +403,7 @@ struct cxl_endpoint_decoder {
>>   * struct cxl_switch_decoder - Switch specific CXL HDM Decoder
>>   * @cxld: base cxl_decoder object
>>   * @nr_targets: number of elements in @target
>> + * @target_map: map of target dport ids to interleave positions
>>   * @target: active ordered target list in current decoder configuration
>>   *
>>   * The 'switch' decoder type represents the decoder instances of cxl_port's that
>> @@ -414,6 +415,7 @@ struct cxl_endpoint_decoder {
>>  struct cxl_switch_decoder {
>>  	struct cxl_decoder cxld;
>>  	int nr_targets;
>> +	int target_map[CXL_DECODER_MAX_INTERLEAVE];
> 
> This can save space by being a u8 since hardware port ids are 8-bits.
> 
> I would do a lead-in patch to introduce this and drop the @target_map
> argument to cxl_decoder_add() and its helpers.
> 
> It might help to clarify somewhere that this is a cached copy of the
> hardware port-id list and that it is available at init even before all
> @dport objects have been discovered / instantiated.
> 

This actually needs to be u32 and cannot be u8. Mainly because CFMWS interleave targets is 4 bytes. And if we set this to u8, it'll break things later on when we do region decoder matching for the root port (took couple days for me to chase that on hardware).
