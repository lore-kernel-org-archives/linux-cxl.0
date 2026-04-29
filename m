Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACE226FDAC
	for <linux-cxl@vger.kernel.org>; Wed, 29 Apr 2026 15:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777476954; cv=none; b=SCZq4vPHhNnylCSYL0qyFtkQafbJ1cuKL0sauUC2sTEg6l7/2n+7yAQ9hJY3aALKSYCf8uv2t5VSsDzGjQ4j6c+RZeQUAVYZYYFvBlR14Kph25DIPzZSdrqWbe0iBHKv2bSmmxv8+qrxNzb2XGDFaBMZYKSWKFfyN1ViO0KhVQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777476954; c=relaxed/simple;
	bh=/VZfYzaPjK9D2bnHdCcNfzkYt5+wjHgqvlUkEG1paqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=amYuBV/55Sq91CgH/Y+keZCbbLITS5+BTK+AinEeVzs6h84aueM/QOyBbN/U5FY5tv51plKVX9DYTU/RpxF/uKM7Zgn6frNMWSfUeh1lIfzQbTSbcvteuFhoGwcTuR0Bp8VB5qPaeUXxZantqzs10I5iCkFwDCxaCiI39xDaBPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VwQUscgM; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VwQUscgM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777476953; x=1809012953;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/VZfYzaPjK9D2bnHdCcNfzkYt5+wjHgqvlUkEG1paqw=;
  b=VwQUscgMsWoJ/bSpBmp6wCUmt0wPJz2yTs6SIMIcxLWnvwD8MrAVDzMK
   AiIQfabNNUbuewDxFIfLWWx6KSX9EjOtHU/8gPGt3zQ9BdUIO9BG4VVnc
   0eK+7BAJC06KKXrkOLYCfbigKT4Xk2KMyH4MLNGK18CaQFpAwDVzef+zp
   sN+4Cs2flswjIau78TkYzoazwq7kt670wySUpvM4CXCmEs/IGeBZ/43ze
   /QquTFkQitczI2vB6aXlcawaGPrkOCuatQRnA4G7NrhU2ro2/zKCoQx2o
   F7N0c5omT6+rl0VQdkPDQQEHjFFPyPL71uTOFz+t9BAa3Tpp/W8pPDNOF
   A==;
X-CSE-ConnectionGUID: CrMWGh+NRFeRkRkHesCaLQ==
X-CSE-MsgGUID: gU1qlgU5T+SKl6YlFD3zjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="101070520"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="101070520"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 08:35:52 -0700
X-CSE-ConnectionGUID: 5vsMYOSBRp+zTvRd8DZeuA==
X-CSE-MsgGUID: 5+yGeI/nTG6lA9WQWashXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="239329854"
Received: from jmaxwel1-mobl.amr.corp.intel.com (HELO [10.125.109.38]) ([10.125.109.38])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 08:35:52 -0700
Message-ID: <0c6fe274-c5ef-4b95-9676-bf32f810a45c@intel.com>
Date: Wed, 29 Apr 2026 08:35:50 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/mbox: Use guard() for mbox_mutex locking
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: jic23@kernel.org, alison.schofield@intel.com, ira.weiny@intel.com,
 djbw@kernel.org, linux-cxl@vger.kernel.org
References: <20260428212220.711160-1-dave@stgolabs.net>
 <b96ab07b-a134-4417-86a5-386c17829977@intel.com>
 <20260428224700.koa6ls7thc5ggw27@offworld>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260428224700.koa6ls7thc5ggw27@offworld>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/28/26 3:47 PM, Davidlohr Bueso wrote:
> On Tue, 28 Apr 2026, Dave Jiang wrote:
> 
>>
>> On 4/28/26 2:22 PM, Davidlohr Bueso wrote:
>>> Use the new helpers and simplify the code. No change in
>>> semantics.
>>>
>>> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
>>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>>
>> Is this in prep of media ops?
> 
> I found the open coded locking by doing the media ops
> patch, but ultimately these changes are independent.

May not be worth the churn if it's not part of ongoing work.

> 
> Thanks,
> Davidlohr

