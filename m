Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D733ED132
	for <linux-cxl@vger.kernel.org>; Wed,  6 May 2026 14:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778079591; cv=none; b=OU/7pNqrScejhJHbf1spa8sw3NEvEMT68sveOgepYziUT/+0ParrW7DQXjxcXuIdIRwGEHT/VDXQIjFqnCfwp5YmhOZ6SFGp/Wz2ByS/62YdQqoCfZRCr+3Ek5mVdLvqK+/scYDbjuwvMyoSufFCI7ldrv51XDzr9iUTH6qhv+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778079591; c=relaxed/simple;
	bh=xkbWvi58K+u0jKOUzFYtTq17x5Cix/DrD9VHXp/VuR0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SWj2a2g6atMO0n7Xc91SARVp7Kqow4T+TnQ2hzvpAX+z9vajlFA8Smsx2GtcX+BDkEJuQ5AqkUCZcvcywoiQYNFiFFAjmqDi/44P4yM1DZAJlBHFAYAIqA+UAvCYlIPJhzGOEoeJw8hu2hvkcNYlUI5ZMDgo20BU+nGi64rnuDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=epQy6iBA; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="epQy6iBA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778079587; x=1809615587;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xkbWvi58K+u0jKOUzFYtTq17x5Cix/DrD9VHXp/VuR0=;
  b=epQy6iBArlbf20gimJFrEmr5uPLkEI/J4OsMsjHrIOOXkvIqcOsUh1AC
   2mSADYBMvHFkiIt8Kl0uhi+VSUeYaYC47XMSYld7K65rWzsarzRs/eOYF
   wnwIYl/+knSDj1u1Tt8EJrhtQgObwUOw3fcO6ktRzCNZJUyfiyP2nMRI5
   s2r3U7ZvgZz60RqLzSgepvmi/q255iNVjik4fNuP4ORoF9VgaXXRUm1NC
   gU/C4cbPV2+5RRgeKwCRxxXfeW6F9iTt9Kok4kfYKotPFq29+mDbtvchq
   y6El2TUfSLxYIOaF9Ziiy/E+7T/vV1Em51oAxMph2alJU8ZFfw2/FDvHj
   Q==;
X-CSE-ConnectionGUID: b1jZTZ/PQAmD0mp97CuqHA==
X-CSE-MsgGUID: 6mODOkBTSFepeGs8HJ8hmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="82882905"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="82882905"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 07:59:44 -0700
X-CSE-ConnectionGUID: dW7Dhp9yQ+KwyxDk7f9hZg==
X-CSE-MsgGUID: ZMWOhswyTXaWCpO4esePLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="236419974"
Received: from jmaxwel1-mobl.amr.corp.intel.com (HELO [10.125.110.159]) ([10.125.110.159])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 07:59:43 -0700
Message-ID: <13c78882-d3df-474c-8232-6b22ef1b44ec@intel.com>
Date: Wed, 6 May 2026 07:59:42 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] cxl: Add CXL type2 accelerator support for cxl_test
To: Alison Schofield <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org, dave@stgolabs.net, jic23@kernel.org,
 vishal.l.verma@intel.com, ira.weiny@intel.com, djbw@kernel.org,
 Davidlohr Bueso <dave@stgolabs.net>
References: <20260422230237.2599333-1-dave.jiang@intel.com>
 <afrBq3AIDrAkTTWR@aschofie-mobl2.lan>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <afrBq3AIDrAkTTWR@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/5/26 9:20 PM, Alison Schofield wrote:
> On Wed, Apr 22, 2026 at 04:02:30PM -0700, Dave Jiang wrote:
>> The series is based on v7.0-rc7 with Alejandro's type2 series [1] and
>> with Dan's follow on series [2].
>>
>> Series adds a 'type2_test' module parameter where it setup a mock type2
>> hierarchy with a mock type2 accelerator device directly under a root
>> port that has an auto region setup.
>>
>> It also includes a CXL fix that was encountered when running tests with
>> the new code.
>>
>> [
>>   {
>>     "memdevs":[
>>       {
>>         "memdev":"mem0",
>>         "ram_size":536870912,
>>         "ram_qos_class":42,
>>         "host":"cxl_type2_accel.0",
>>         "poison_injectable":false
>>       }
>>     ]
>>   },
>>   {
>>     "regions":[
>>       {
>>         "region":"region0",
>>         "resource":70300293136384,
>>         "size":536870912,
>>         "type":"ram",
>>         "interleave_ways":1,
>>         "interleave_granularity":4096,
>>         "decode_state":"commit"
>>       }
>>     ]
>>   }
>> ]
>>
>>     "root decoders":[
>>       {
>>         "decoder":"decoder0.0",
>>         "resource":70300293136384,
>>         "size":1073741824,
>>         "interleave_ways":1,
>>         "accelmem_capable":true,
> 
> FWIW - above was a pleasant surprise. We've had accelmem_capable plumbed in
> cxl list since 2022 !
> 
> That's a segway to a sanity check: is there anything else we want to
> display or do in the cxl-cli tooling that is special for Type 2 ?

Maybe back invalidate attributes? I don't remember if that's already there or if Davidlohr is adding that.

DJ

> 
> 
> 
>>         "qos_class":42,
>>         "nr_targets":1
>>       },
>>
>> [1]: https://lore.kernel.org/linux-cxl/20260330143827.1278677-1-alejandro.lucero-palau@amd.com/T/#t
>> [2]: https://lore.kernel.org/linux-cxl/20260403210050.1058650-1-dan.j.williams@intel.com/T/#t
>>
>>
>> Dave Jiang (7):
>>   cxl/test: Refactor mock_init_hdm_decoder() to prep for type2 decoder
>>   cxl/test: Add type2 support for mock CFMWS0
>>   cxl/test: Refactor platform device enumerations
>>   cxl/test: Add hierarchy enumeration support for type2 device
>>   cxl/test: Fixup hdm init for auto region to support type2
>>   cxl/test: Add cxl_test accelerator driver
>>   cxl: Fix double unregistration of CXL regions for type2 devices
>>
>>  drivers/cxl/core/region.c      |   3 +-
>>  tools/testing/cxl/test/Kbuild  |   2 +
>>  tools/testing/cxl/test/accel.c |  71 ++++
>>  tools/testing/cxl/test/cxl.c   | 717 ++++++++++++++++++++++++---------
>>  4 files changed, 605 insertions(+), 188 deletions(-)
>>  create mode 100644 tools/testing/cxl/test/accel.c
>>
>>
>> base-commit: 6fa897f2d9a917c4bd7b911b230fcfad05a952c2
>> -- 
>> 2.53.0
>>

