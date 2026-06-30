Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233271DDC37
	for <linux-cxl@vger.kernel.org>; Tue, 30 Jun 2026 20:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782852657; cv=none; b=s69OfjwS1N7vkRIqJpY2PvqUJlcxcvD4bolfl5uzGEYpxulhu6Fk3ezOV5OtFhutkFADICz/txJ3+wrRBdk4rcNx6xSeVYLUiD55IS1TNVXWEXABadwwWL6lYMVRsB99qwQAU94QQBBkG/SuQafXXsDI4VaDr5eSHJs9CnCX7Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782852657; c=relaxed/simple;
	bh=viem8ymb8XX+0nI7oUWH+5tPemjQ9jZJBX4SuXsJZ7s=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Wflg5GlNQurr9EYftZqLxK4FzcRE6l1fwd0Y/O0111+LgUpYE3HReWXlWdYUZfv9zzS62+dV+wrz1QlWNvin1t4u3H+7HbKDQdb5puN28CGNWSNS1EY6DzbsYQTerjJd7QwQhNyr1W9dDk7ou/+Vtd9LiFV6aEGejzWMXl4uPVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jAWOuTgv; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jAWOuTgv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782852655; x=1814388655;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=viem8ymb8XX+0nI7oUWH+5tPemjQ9jZJBX4SuXsJZ7s=;
  b=jAWOuTgv0sqRIfNusAFhItUGS+A6rTQgd/SM+4t60vjtjiQFJSWloJn+
   8YpArCrcyrchKoZb25HS8YWrSyQp6Uh30NJjTXF62GfF9WP42GBlZBloU
   HqqDpgCtzHn1Wdg6FMOJBO5/T8SIylxD8gJ4qlsttKPciZ2Hdez1iedFK
   o/jrYjBNEMOQSXa8bUKESJLzpCw4AzSloFHVD0wEJO4+xKlp/1cN+fdnv
   RnkTVD49DWUqWxC6nAvMxYNcuUsR9x3CzgjKAA9J6zUPIpZk6pcLPFJTR
   0ej48way/NsTrqa+OnvIeh3izdLBpbFBnyZzKjVW0K6vFfYuD9yPEEKKM
   Q==;
X-CSE-ConnectionGUID: eauBPwQxT2iSarOhal4YKg==
X-CSE-MsgGUID: 3R8TiVAtQYyR9X7Yaqg10g==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="106367578"
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; 
   d="scan'208";a="106367578"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 13:50:55 -0700
X-CSE-ConnectionGUID: yX4gzo/US1a3D2NJDcsLsw==
X-CSE-MsgGUID: /uZJD8qGRkWbNE/Kr9wEmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; 
   d="scan'208";a="252485842"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.109.254]) ([10.125.109.254])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 13:50:54 -0700
Message-ID: <9348b298-c3d4-4e32-b99d-7ebf1cc49d49@intel.com>
Date: Tue, 30 Jun 2026 13:50:53 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/7] cxl: Add CXL type2 accelerator support for
 cxl_test
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: djbw@kernel.org, dave@stgolabs.net, jic23@kernel.org,
 alison.schofield@intel.com, vishal.l.verma@intel.com
References: <20260629221104.3891733-1-dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260629221104.3891733-1-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/29/26 3:10 PM, Dave Jiang wrote:
> v7
> - Fixed sachiko raised issues
> 
> Based against v7.2-rc1 and sits on top of the the immutable branch [1]
> for type 2.
> 
> See individual patches for changes from previous version.
> Fixed up sashiko reported issues.
> 
> Series adds a 'type2_test' module parameter where it setup a mock type2
> hierarchy with a mock type2 accelerator device directly under a root
> port that has an auto region setup.
> 
> It also includes a CXL fix that was encountered when running tests with
> the new code.
> 
> [
>   {
>     "memdevs":[
>       {
>         "memdev":"mem0",
>         "ram_size":536870912,
>         "ram_qos_class":42,
>         "host":"cxl_type2_accel.0",
>         "poison_injectable":false
>       }
>     ]
>   },
>   {
>     "regions":[
>       {
>         "region":"region0",
>         "resource":70300293136384,
>         "size":536870912,
>         "type":"ram",
>         "interleave_ways":1,
>         "interleave_granularity":4096,
>         "decode_state":"commit"
>       }
>     ]
>   }
> ]
> 
>     "root decoders":[
>       {
>         "decoder":"decoder0.0",
>         "resource":70300293136384,
>         "size":1073741824,
>         "interleave_ways":1,
>         "accelmem_capable":true,
>         "qos_class":42,
>         "nr_targets":1
>       },
> 
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/log/?h=for-7.3/cxl-type2-support
> 
> Dave Jiang (7):
>   cxl/test: Add test for module parameters
>   cxl/test: Add type2 support for mock CFMWS0
>   cxl/test: Refactor platform device enumerations
>   cxl/test: Add hierarchy enumeration support for type2 device
>   cxl/test: Propagate -ENOMEM on platform_device_alloc() failures
>   cxl/test: Fixup hdm init for auto region to support type2
>   cxl/test: Add cxl_test accelerator driver
> 
>  tools/testing/cxl/test/Kbuild      |   2 +
>  tools/testing/cxl/test/accel.c     |  66 +++
>  tools/testing/cxl/test/cxl.c       | 850 ++++++++++++++++++++++-------
>  tools/testing/cxl/test/hmem_test.c |   3 +-
>  tools/testing/cxl/test/mock.h      |   2 +
>  5 files changed, 720 insertions(+), 203 deletions(-)
>  create mode 100644 tools/testing/cxl/test/accel.c
> 
> 
> base-commit: 96ddf1af34f5f9e29891a5bfb7a18dd0a5bab9d6

Applied to cxl/next with change from Alison
1c6b4ceafc3b cxl/test: Add cxl_test accelerator driver
b3df5a5a38c3 cxl/test: Fixup hdm init for auto region to support type2
98ba41c3236b cxl/test: Propagate -ENOMEM on platform_device_alloc() failures
6b2e585142e6 cxl/test: Add hierarchy enumeration support for type2 device
a6d37152d284 cxl/test: Refactor platform device enumerations
fc8fc576d909 cxl/test: Add type2 support for mock CFMWS0
afae0fa7c6b1 cxl/test: Add test for module parameters


