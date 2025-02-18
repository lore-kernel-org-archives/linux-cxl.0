Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3701E51EC
	for <linux-cxl@vger.kernel.org>; Tue, 18 Feb 2025 18:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739905087; cv=none; b=CHznOsnN7zM9MwiFTpqTqaE0oMVwnU7yMThZH8N1IxIqLrVtySV6xUAOFiFp1bzZzix+M37I8ozUFeANdH5k1amb+mjb17EB8nWToggufJLoqZFk57xnb/nsniGLPaVvZDt+1tspMmZBAzaiwXgiiiUwX1rKsWA769XhmGdBINc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739905087; c=relaxed/simple;
	bh=cWrUss2vJEGD3EcuD6ly+BcEw+2KN2zfm3gmJpI3VyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DXOjnU2E9+qMxdyT/i7uc/EFBh8hG8ZbXIGGx+1vd35na8desnZti+hg60ifKg0eH2hhdpXi/8AeJvBdeVh0es83Feqh/iixI/bpcg6axZVb7APG1AR2KR1jp66Cr5QpUyYKysDqf7JNr9KTVK5K2p7skoaB7CTNespT/iWA9qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XnCSJs2g; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XnCSJs2g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739905085; x=1771441085;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cWrUss2vJEGD3EcuD6ly+BcEw+2KN2zfm3gmJpI3VyY=;
  b=XnCSJs2gmNI2eJ5/8qljnlh19Jh4di/JV06s4aYot2FUviOte4kjJUy1
   RJA0aPPT9FZOm2cIVQQwLUVqJLn4JJ6r+mf2Uo4DSBWkzY3NmODdBdZu/
   F/LFFJxaVpIGgrMcQeJa4mRmFFP+cWivsiZ0i/ywkqL+2kw68MCowmWZO
   Nnz/ZxloHTke6Ml0p0BvGc6H5fFRmTAjZvTMJqEIpFzMtKaaPlZunv6YG
   oSZjkuK1Y2j4NUy74lzuLRrKsE1h0KI7lQygUnoZlBV0EeNhxqd3Ky/ql
   noO/kUpYa/318acW9D5BgpXvDgcu1+F3u5InuS0xpXxS9qKBWZW7CqcLq
   A==;
X-CSE-ConnectionGUID: Lp8QWxUmRZudg47CmL3f5w==
X-CSE-MsgGUID: OZrjQBkPRpm0H4WBCbIWmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="51239204"
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; 
   d="scan'208";a="51239204"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 10:58:04 -0800
X-CSE-ConnectionGUID: K5A0beTSRMqR6/jCYV8Q9A==
X-CSE-MsgGUID: KYfqnJJqQG6iTQ77Ez++WA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118619457"
Received: from iherna2-mobl4.amr.corp.intel.com (HELO [10.125.109.187]) ([10.125.109.187])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 10:58:03 -0800
Message-ID: <7ff0d1a0-bd17-4089-afff-79ecb1ffc395@intel.com>
Date: Tue, 18 Feb 2025 11:58:02 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] cxl/pmem: Export dirty shutdown count via sysfs
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: dan.j.williams@intel.com, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 seven.yi.lee@gmail.com, a.manzanares@samsung.com, fan.ni@samsung.com,
 anisa.su@samsung.com, linux-cxl@vger.kernel.org
References: <20250205040842.1253616-1-dave@stgolabs.net>
 <20250205040842.1253616-2-dave@stgolabs.net>
 <49bf1136-c4b5-4c25-8b3f-2b9f68e23983@intel.com>
 <20250211045016.d4erlklhps5rud2b@offworld>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250211045016.d4erlklhps5rud2b@offworld>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2/10/25 9:50 PM, Davidlohr Bueso wrote:
> On Mon, 10 Feb 2025, Dave Jiang wrote:
> 
>> On 2/4/25 9:08 PM, Davidlohr Bueso wrote:
>>> @@ -542,6 +542,7 @@ struct cxl_nvdimm {
>>>     struct device dev;
>>>     struct cxl_memdev *cxlmd;
>>>     u8 dev_id[CXL_DEV_ID_LEN]; /* for nvdimm, string of 'serial' */
>>> +    long dirty_shutdown;
>>
>> Maybe consider using u64 and call it 'dirty_shutdowns'?
> 
> Imo signed type having -1 is more natural - are there any benefits in
> it being u64?

If it's a signed value and when it rolls over, it would show up as negative wouldn't it? Seems inconsistent with what the sysfs documentation says. Although that's a lot of dirty shutdowns for a system.... I suppose you can always force it to be unsigned when emit via sysfs. 

> 
> Thanks,
> Davidlohr

