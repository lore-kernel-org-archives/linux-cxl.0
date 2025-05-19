Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF28D28A407;
	Mon, 19 May 2025 16:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747671191; cv=none; b=FgNvi/TM1vXmfmIaDVaVFlHXMDV+annzQbwsqZoFbKnOHsjUmzAtuEVIjW2d3OflaURT+heGXG56Cz9KMPmL7ia5HdNOJc8r9lG27FLduaYsbB3iuOcZoZ3b9P5nzFCgN4+J7HUErhWeJcWDyuopBKsv86jxM0xxzHoDBtR5O4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747671191; c=relaxed/simple;
	bh=zyAOQzMJMFgeGz+lNh/1K4UspxtyA4S0tXwY70o42jA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dyrW++c9OXinE2RCs7+czIpR5NuglnQdO9fFCyWWRQv9ImgN/wTASBpcXoAAvlhtiTjaa97KX1S/cjsexk8/QaWmKuOouMNFknmIIPQEQYcDz41Lo7zZNLEbF+iLYyV/9AOtT5oX4OMnHl65VK6oep62Zjzlg33Y50iN/G5mxWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C7minFsw; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C7minFsw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747671191; x=1779207191;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zyAOQzMJMFgeGz+lNh/1K4UspxtyA4S0tXwY70o42jA=;
  b=C7minFswC+IAH1vHL9ERFaDAUnN9ptO6JtJ2OA13Fu/AcAtgtACjny6c
   S0NT1Nxk0PRHijk2mG7sYKYK7yGwbJA1qj4GkO9ocN15QeaL+XBAJkR0Q
   LcKdmAR6QrTI9K/AE+KWw2IneJYuD2np9DdJ4bqKNXlq2F0n0pH6ec2WN
   kCftLT2JHEvyd2Haaq2y/OoGC4Jnc0CHfY6Q4wB4jIjXkPMlEW9NxHzsR
   jPt6y8RybBd9963zziqpT+5Tax2vaSglyso9NOMtsDq3eNOTdZhtbaldq
   cljXJ0aJiYcrcKOmMHLHjMVPajKCsC8MODxhQL8lTdPVuzQVpqmMMgK+9
   Q==;
X-CSE-ConnectionGUID: dkrD6QWQR0uocvQrI46bRA==
X-CSE-MsgGUID: EMF2aXT6RUegsfIc6q1Q3g==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="49642073"
X-IronPort-AV: E=Sophos;i="6.15,301,1739865600"; 
   d="scan'208";a="49642073"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 09:13:10 -0700
X-CSE-ConnectionGUID: L13enZ45Tgm8M7LnrBNVYQ==
X-CSE-MsgGUID: XMT03/vcQ12CNqz8cPu6sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,301,1739865600"; 
   d="scan'208";a="139301096"
Received: from tjmaciei-mobl5.ger.corp.intel.com (HELO [10.125.109.80]) ([10.125.109.80])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 09:13:08 -0700
Message-ID: <63c3fc2b-2c04-4f44-9e69-4569d3e91017@intel.com>
Date: Mon, 19 May 2025 09:13:05 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: ABI: Fix "firwmare" to "firmware"
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Sumanth Gavini <sumanth.gavini@yahoo.com>
Cc: skhan@linuxfoundation.org, ira.weiny@intel.com, dave@stgolabs.net,
 ming.li@zohomail.com, linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
References: <20250517110332.1289718-1-sumanth.gavini.ref@yahoo.com>
 <20250517110332.1289718-1-sumanth.gavini@yahoo.com>
 <20250519105550.000051ab@huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250519105550.000051ab@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/19/25 2:55 AM, Jonathan Cameron wrote:
> On Sat, 17 May 2025 04:03:16 -0700
> Sumanth Gavini <sumanth.gavini@yahoo.com> wrote:
> 
>> Fix misspelling reported by codespell
>>
>> Signed-off-by: Sumanth Gavini <sumanth.gavini@yahoo.com>
> +CC linux-cxl
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Applied to cxl/next

> 
>> ---
>>  Documentation/ABI/testing/sysfs-bus-cxl | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
>> index 99bb3faf7a0e..d0d58b74f382 100644
>> --- a/Documentation/ABI/testing/sysfs-bus-cxl
>> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
>> @@ -242,7 +242,7 @@ Description:
>>  		decoding a Host Physical Address range. Note that this number
>>  		may be elevated without any regionX objects active or even
>>  		enumerated, as this may be due to decoders established by
>> -		platform firwmare or a previous kernel (kexec).
>> +		platform firmware or a previous kernel (kexec).
>>  
>>  
>>  What:		/sys/bus/cxl/devices/decoderX.Y
> 

