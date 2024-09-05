Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C7818A6B0
	for <linux-cxl@vger.kernel.org>; Thu,  5 Sep 2024 20:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725567677; cv=none; b=JLG778GUzR1C0+cWyLt468qVvUs7KY25VRIpJ61sF74eAQYphyjsSkLR7QRdJYm6aRV1hdn3r8UNYh42DzEJmaxD1SEYc1w6yhqN2e4WXRuU2fG6O24O5qHvk+L/4IACAMArO5G2AKinWcBDFRFS3PVlNjpUl1Zuott647PTxV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725567677; c=relaxed/simple;
	bh=EIRtWb2tUKGRiQU3P8soLfWgJnlmbRQ8pcuZLSZIMR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gEEL9pe5rYcrtQWBK3vfIg3UDtw/KzSSCtrLVSkoK2fblZuQKoQGZbXzd7SU9mFFgZG9VKwblDSGrdD5HAnDK9onZL13ZmJkSvK7MblrZp9zPQfFsByUUD2GLlmXzc4GyPBt+e/gDRcR+zv02+OMGJYsHAILsNO8u6kzq/hIghQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EmzqvZ4y; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EmzqvZ4y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725567675; x=1757103675;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EIRtWb2tUKGRiQU3P8soLfWgJnlmbRQ8pcuZLSZIMR4=;
  b=EmzqvZ4yBjBtmvJhOL37pSgVMOMzOzmokxoAnDmcCDF24MVei6SUtUPO
   h6a8AIvweAMSxa+NmNvVa7PBMceqKIUpcwG6GNxQ1il4JpyK7Y+bi5sD9
   9+gL6vwrTAADnKD4FrZ6uFdlrG9AK/uhU0O8RCiiPgih4z/QvQBZScBs8
   BbiprkMQ1b3wdrc8dTjWJu3mMmQqQI4wPd2/New8Tk3OjTDLe5wrLxPyU
   kTxl8cW6Hmm4e7/lrsHBFiosUJd0sEM+SBebwEG3OozK6Ur7nQlk51coc
   IDD4dr646N1ni8xjdVxbuZyhqwXn/7kwY5w62fAB4Bz25prfu3EVr169J
   w==;
X-CSE-ConnectionGUID: SycTmo0MSQ+1N0onGy2FaQ==
X-CSE-MsgGUID: yhDamyRsScaWPZeouoBbcw==
X-IronPort-AV: E=McAfee;i="6700,10204,11186"; a="27234249"
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="27234249"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 13:21:15 -0700
X-CSE-ConnectionGUID: xgP2XYzSSLyfLrKYQF1nBw==
X-CSE-MsgGUID: JuuACiVtQyePJcHywd/rdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="70546340"
Received: from iweiny-mobl.amr.corp.intel.com (HELO [10.125.110.30]) ([10.125.110.30])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 13:21:14 -0700
Message-ID: <779b7a90-92fb-44f3-9fd9-39009dcd6709@intel.com>
Date: Thu, 5 Sep 2024 13:21:13 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] cxl: move cxl headers to new linux/cxl/ directory
To: Alejandro Lucero Palau <alucerop@amd.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc: alejandro.lucero-palau@amd.com, ira.weiny@intel.com,
 vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net, fan.ni@samsung.com
References: <20240904000020.1686611-1-dave.jiang@intel.com>
 <20240904000020.1686611-4-dave.jiang@intel.com>
 <e6cdb731-c2f1-5791-79ff-ff5835009475@amd.com>
 <66d91d844003d_286b294cf@dwillia2-xfh.jf.intel.com.notmuch>
 <d86d41ca-923d-0c90-1480-8f48efac07e4@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <d86d41ca-923d-0c90-1480-8f48efac07e4@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/4/24 11:51 PM, Alejandro Lucero Palau wrote:
> 
> On 9/5/24 03:55, Dan Williams wrote:
>> Alejandro Lucero Palau wrote:
>>> On 9/4/24 00:59, Dave Jiang wrote:
>>>> Group all cxl related kernel headers into include/linux/cxl directory.
>>>
>>> I tried to do this in the RFC for Type2 support.
>>>
>>> I was told to just move the required bits for accel drivers able to do
>>> CXL initialization,
>>>
>>> What has changed since then?
>> I saw this subject line fly by and had the same thought, but now that I
>> come to read it there is a significant difference.
>>
>> This is not "move cxl headers to new linux/cxl/ directory" this is
>> "rename existing cxl headers in include/linux/ to include/linux/cxl/".
>>
>> Compare that to the proposal to move all drivers/cxl/*.h headers to
>> include/linux/.
> 
> 
> Right. My bad. I did just pay attention to the commit message.
> 
> 
>>
>> Now, I do not think it makes sense to place these cross-driver cxl headers under
>> include/linux/cxl/, just place them under include/cxl/.
> 
> 
> Not sure you are telling this to me or to Dave.

I think he's telling me. I chatted with Dan offline. I'm going to send v4 and move stuff to include/cxl/. Sorry about the churn.

> 
> FWIW:
> 
> I have almost ready v3 and I'm adding headers to include/linux/cxl after this directory was created after v2.
> 
> As I understand it, include/linux implies headers to be used by kernel code, with headers to just include those to be used by user space.
> 
> The headers added in v3 are for accel drivers so it makes sense to me to be include/linux/cxl.
> 
> 
>> However, I do not understand the motivation. It's not like a new header
>> is being added and that is the final straw that merits moving the
>> existing headers. Most include/$subsys/ directories have more than 2
>> header files.
>>
>> So what is the pain motivating this move?
