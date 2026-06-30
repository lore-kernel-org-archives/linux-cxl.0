Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C990158DCF
	for <linux-cxl@vger.kernel.org>; Tue, 30 Jun 2026 17:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782840501; cv=none; b=qyPQgqywRxX5b7YQgwxu+wqKAABbMdJjguQ2c0pxevKNvKVmrRUDIH89hzZvnvSDfg6xhgV7z7Id+vMeFOBcsMPnAXiCJHOvalVNcTbJtg+f11A3bu8KmS52ANHcTqXmzIYD30J7/8yjdynoqoLCllWDD0k/zNiU44jUmPSokpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782840501; c=relaxed/simple;
	bh=OqqeFERiCYF/jNCvc7JnCAdFux6cZeM5Fe+D91SyGGk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rtPyf97YtGu2q2vC45iDhlKLhMRqfUHsz8zrmjZ+tKK5vljwSTVMV1vWpG4XWZ5Wj5TC8lX3kn3hwXSAr0UPFt8VdURlEFhipAsC9fKG+SZiFjRQXkld5f42cZ1FoXvSDU7of73vpmpKFuqY0N7fRF0iTA8xKh5zO5ScW5lRDPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D74N4BcW; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D74N4BcW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782840500; x=1814376500;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OqqeFERiCYF/jNCvc7JnCAdFux6cZeM5Fe+D91SyGGk=;
  b=D74N4BcWuyYzkkJEIf3Ksul5XlwSw0EgIdZ57obl9WeFoL633z+Z/7Hn
   XIupH6kIn0vvgMj11kkXkW4hSmQuuUzVWNcpk4/jrtFrgaPL+dpY92NNA
   cNo87Ab/y5r5L1EEQJJ0pqCohHYum2t6HhXka8ZFhFSGmSQOGia1v0BJ5
   59W9pg1zSCRq8pZmJey/qkBMQKKaoLF2Id1lUL3Pj6u40Nw/K82O5YnMs
   h2YxPJZJOdNib8mfE4OX+NQPcXpRbjzGGf/XIdAwO8FFCSjCsDUfuHQ+E
   k2dR1XAyD1hivP1rWWw+IvdLQySVxXygDyZHqRURXYOfkPzl9VSq4CT3Z
   g==;
X-CSE-ConnectionGUID: 4QiBgm8eQVCdTPmSQi79pA==
X-CSE-MsgGUID: ilTUbfchRzm9hN4XAoDvdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="94161687"
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; 
   d="scan'208";a="94161687"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 10:28:20 -0700
X-CSE-ConnectionGUID: 8PMPD6+WRpKjmRbk53F9hA==
X-CSE-MsgGUID: l6YdPQPiR/mRq21xpFckFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; 
   d="scan'208";a="251911538"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.109.254]) ([10.125.109.254])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 10:28:19 -0700
Message-ID: <04ba8663-ca6a-4f6f-8e53-432ddfa887d0@intel.com>
Date: Tue, 30 Jun 2026 10:28:18 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/7] cxl/test: Add test for module parameters
To: Alison Schofield <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org, djbw@kernel.org, dave@stgolabs.net,
 jic23@kernel.org, vishal.l.verma@intel.com
References: <20260629221104.3891733-1-dave.jiang@intel.com>
 <20260629221104.3891733-2-dave.jiang@intel.com>
 <akP7C0oFiqxxi6fK@aschofie-mobl2.lan>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <akP7C0oFiqxxi6fK@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/30/26 10:21 AM, Alison Schofield wrote:
> On Mon, Jun 29, 2026 at 03:10:58PM -0700, Dave Jiang wrote:
>> Add a test for module paraters during module init to make sure that
>> only one is activated.
>>
>> Suggested-by: Alison Schofield <alison.schofield@intel.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>  tools/testing/cxl/test/cxl.c       | 20 ++++++++++++++++++++
>>  tools/testing/cxl/test/hmem_test.c |  3 ++-
>>  tools/testing/cxl/test/mock.h      |  2 ++
>>  3 files changed, 24 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
>> index ef92dd35e030..198a128181b9 100644
>> --- a/tools/testing/cxl/test/cxl.c
>> +++ b/tools/testing/cxl/test/cxl.c
>> @@ -1827,11 +1827,31 @@ static struct attribute *cxl_acpi_attrs[] = {
>>  };
>>  ATTRIBUTE_GROUPS(cxl_acpi);
>>  
>> +static bool __init have_multiple_modparms(void)
>> +{
>> +	int count = 0;
>> +
>> +	if (interleave_arithmetic)
>> +		count++;
>> +	if (extended_linear_cache)
>> +		count++;
>> +	if (fail_autoassemble)
>> +		count++;
>> +	if (hmem_test)
>> +		count++;
>> +
>> +	return count > 1;
>> +}
> 
> fail_autoassemble is a modifier of hmem_test, not a standalone mode.
> Needs to be dropped from above func for cxl-dax-hmem.sh to run.
> 
> Tested with this diff:
>  --- a/tools/testing/cxl/test/cxl.c
>   +++ b/tools/testing/cxl/test/cxl.c
>   @@ -2081,8 +2081,6 @@ static bool __init have_multiple_modparms(void)
>                 count++;
>         if (extended_linear_cache)
>                 count++;
>   -     if (fail_autoassemble)
>   -             count++;
>         if (hmem_test)
>                 count++;
>         if (type2_test)
> 

ok will drop
