Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57D22698AF
	for <linux-cxl@vger.kernel.org>; Tue, 20 May 2025 16:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747757600; cv=none; b=pxUEe7PSCEdjRHiOgUNJsfoP7l/ejuu/FA2JA+TmMLWLlttT4xIjxm/zXS1H0owrmUdkmSO5B6ogiAWsS7yhFlBvVUXqr9+RRrxkMOKmsA2G6Ob8qh8cP3DKXbTFw2wRQ16snFfb/ApPApk56H9oFgUF6uUyV/CA0JDRxAu2IeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747757600; c=relaxed/simple;
	bh=98ITOsNZtG49hbpzspqniLLJXZMFmA39rVpkyKk0Jbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QWSy+FoZ2bEsG9ghcawKw1AxQbs+9PcTRsuewVXgXWkFll0n8tKKZlOpnLOtSxSnACpV55tLnS/jXtYjQztWi4rK/pXTgBZg6Zm+Il9ygbAfCMlmHsMkEd3PHdaEWaKLIPUATEokACNloRmmKjDQafqzmuqSP+7K/KWJVkJliMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M29nrdIz; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M29nrdIz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747757596; x=1779293596;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=98ITOsNZtG49hbpzspqniLLJXZMFmA39rVpkyKk0Jbk=;
  b=M29nrdIzVP5rN57Ad17H+15bjhBRrOpaQPPz668xrjNfl4zuf/kbk2tL
   7TfyqZ2P8PrHNbeO4v02HsJPoSwwgNN/WqfKC5ppZBwGXwyRnlLl3Ou7d
   ngEJ/Ys+S0InA6yhVC/f2BmoOYX9W3vsSG+SfXodq4UIsbmRwyCGzxxkq
   +HUWtnMTwbLQId2f8PGX0AvzA3Ne3LLi6QmlvfwqISUw1LCKEoxCXlGki
   me0AcbYVyd/luN41i28WXL9WS+iefYm3CIVADudbyJZhylNyoqgjnO+R7
   rW8Op/rpXnjUDz0vTLi9YO7yXfSwOsjkXaFMuUckqbkVuPZXqVb4sp3UM
   g==;
X-CSE-ConnectionGUID: 022r2/XQQsmI4xikMecs8g==
X-CSE-MsgGUID: LYPcHBgPQySjJ6/7YdK/Ng==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="49575512"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="49575512"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 09:13:15 -0700
X-CSE-ConnectionGUID: triiw9GWTtuxELaj+UmzlQ==
X-CSE-MsgGUID: GYadJ5P8TFq0sxuAXwv7gQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="144871789"
Received: from inaky-mobl1.amr.corp.intel.com (HELO [10.125.109.92]) ([10.125.109.92])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 09:13:14 -0700
Message-ID: <ea910462-d217-4c69-973c-231d47eb4c10@intel.com>
Date: Tue, 20 May 2025 09:13:13 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/10] cxl/region: Add decoder check to
 check_commit_order()
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
 dave@stgolabs.net, alison.schofield@intel.com, ira.weiny@intel.com,
 rrichter@amd.com, ming.li@zohomail.com
References: <20250507004310.3536991-1-dave.jiang@intel.com>
 <20250507004310.3536991-2-dave.jiang@intel.com>
 <20250520121415.000026db@huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250520121415.000026db@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/20/25 4:14 AM, Jonathan Cameron wrote:
> On Tue, 6 May 2025 17:43:01 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> check_commit_order() attempts to convert a device to a decoder without
>> making sure the device is a decoder. So far this has been working due
>> to pure luck. Issue discovered while doing deferred dport probing when
>> child ports are now in the midst of decoders due to ordering change
>> of child port additions. Add a check before attempting to do decoder
>> conversion.
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks Jonathan
> 
> Stands on it's own so maybe queue this up even if later patches
> are still under discussion?
> 
> I'm keen to reduce what is floating around in a good state!

I originally submitted this stand alone and Dan said to include it with the series. The issue does not show up until we change the behavior of port enumeration.

DJ

> 
> Jonathan
> 
>> ---
>>  drivers/cxl/core/region.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index c3f4dc244df7..a91d4eb061e4 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -788,7 +788,12 @@ static size_t show_targetN(struct cxl_region *cxlr, char *buf, int pos)
>>  
>>  static int check_commit_order(struct device *dev, void *data)
>>  {
>> -	struct cxl_decoder *cxld = to_cxl_decoder(dev);
>> +	struct cxl_decoder *cxld;
>> +
>> +	if (!is_switch_decoder(dev))
>> +		return 0;
>> +
>> +	cxld = to_cxl_decoder(dev);
>>  
>>  	/*
>>  	 * if port->commit_end is not the only free decoder, then out of
>>
>> base-commit: 3c746d4821f507304b08789e3c7c151554fc2356
> 

