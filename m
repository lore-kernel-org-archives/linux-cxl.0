Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599E03D3CE6;
	Tue, 10 Mar 2026 18:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773166198; cv=none; b=iWhga3M4NSvUCn4Jlu2BVicrHISUWchKF5aOlSL24RC2By6K4WVamsp22mKZjS1BrmEkbGqydOW5te2SeDEP7qBtaoGOcIYRDbQiBZFMhpoWgz8QFmmobH9+jeiI7ISxWWMa1LwMZmXvtNshIE6ZQvazhijugLMdTNj7nkMFauQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773166198; c=relaxed/simple;
	bh=PdmdlIuv1YuPdutses6OledJE/Tq/fkGcGiOzCeGVuk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qnZCBlTsXjcCracbrlopw11ZcBToMlgr3iVvRfNriQPrsXZTQ0WOm2AIt5pudWpy/uQvAfGH+bSqEU02bLLjXLDscmRaN+TTElvilNk3a4C6xfubbJ45K1M1d2FXjc81p5qMLpTYt8Kz91CHYwSZ3k/dzUbdIxi5Ua0Txm3fMwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P5GRFLEA; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P5GRFLEA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773166195; x=1804702195;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PdmdlIuv1YuPdutses6OledJE/Tq/fkGcGiOzCeGVuk=;
  b=P5GRFLEAsRVt9CdY3HXw+ZNPW0wyDvnjghLH99WK5WVLknwbVgyhsSRK
   WnPPwS/2hWoY6FfS2q11xcdSmuoSLlR0Comg+R/LsmAA+ky81nR4jikxm
   9b4yFQbcHNbfe2LdhRw8FR1aNbhh0o3xdTuquVyp0YWDYhwzyvtTgIylD
   NhwOgrvmsAJQ7Mc2NjaAk0T6lQEtM/qVxUjpk69r16fyv9/1AcWewOle8
   hQm7+c5Eyq3JfP2IYf5PqreGXpyJYVanKmSQcq/VMAHbWiLP0BkVnG6BC
   UdHOTOb4lJtxDANWdpVFJNxQ1p2XZhlaCeQZFU6WbH3BYT3TTb+WCnKdB
   A==;
X-CSE-ConnectionGUID: wyQbm1RxSSC9WSrm+fe+Pg==
X-CSE-MsgGUID: lFx6C6GRSnOHf6+6EK3lfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="99691742"
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="99691742"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 11:09:55 -0700
X-CSE-ConnectionGUID: M/TRqfwKR8iJhKYVNHVzsw==
X-CSE-MsgGUID: CKYB2lj4QwywacyvSeSsCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="220162595"
Received: from aduenasd-mobl5.amr.corp.intel.com (HELO [10.125.110.11]) ([10.125.110.11])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 11:09:54 -0700
Message-ID: <43577d8d-f95a-4964-abe5-3e0b7155e99a@intel.com>
Date: Tue, 10 Mar 2026 11:09:52 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] driver core: Add conditional guard support for
 device_lock()
To: Danilo Krummrich <dakr@kernel.org>
Cc: Li Ming <ming.li@zohomail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Davidlohr Bueso
 <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Ben Cheatham <benjamin.cheatham@amd.com>,
 driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org
References: <20260310-fix_access_endpoint_without_drv_check-v1-0-94fe919a0b87@zohomail.com>
 <20260310-fix_access_endpoint_without_drv_check-v1-1-94fe919a0b87@zohomail.com>
 <127f99e8-f673-4cec-a573-be2257134f59@intel.com>
 <DGZAVHW9AW34.3UKJ8WV6QR8XI@kernel.org>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <DGZAVHW9AW34.3UKJ8WV6QR8XI@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/10/26 11:06 AM, Danilo Krummrich wrote:
> On Tue Mar 10, 2026 at 6:45 PM CET, Dave Jiang wrote:
>> On 3/10/26 8:57 AM, Li Ming wrote:
>>> Introduce conditional guard version of device_lock() for scenarios that
>>> require conditional device lock holding.
>>>
>>> Suggested-by: Dan Williams <dan.j.williams@intel.com>
>>> Signed-off-by: Li Ming <ming.li@zohomail.com>
>>> ---
>>>  include/linux/device.h | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/include/linux/device.h b/include/linux/device.h
>>> index 0be95294b6e6..4fafee80524b 100644
>>> --- a/include/linux/device.h
>>> +++ b/include/linux/device.h
>>> @@ -911,6 +911,7 @@ static inline void device_unlock(struct device *dev)
>>>  }
>>>  
>>>  DEFINE_GUARD(device, struct device *, device_lock(_T), device_unlock(_T))
>>> +DEFINE_GUARD_COND(device, _intr, device_lock_interruptible(_T), _RET == 0)
>>
>> Can you please just squash this small change to the same patch that is using it? Thanks!
> 
> Why? It is a single logical change and hence should be a separate patch, no?

For some reason I missed it's in linux/device.h. So sure ok. But typically I would like to see the usage if it's in the same sub-system.

DJ

> 
> We even tell contributors in the documentation [1] that adding new APIs and
> using them should be separate patches.
> 
> Additionally, in this case it affects another subsystem, so it also makes sense
> in terms of making the change obvious to the maintainers of the other subsystem.
> 
> [1] https://docs.kernel.org/process/submitting-patches.html#separate-your-changes

