Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015673A2565;
	Wed, 11 Mar 2026 10:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773226435; cv=pass; b=Jvq4+Z/gQ6kGnJ2ppoa2pU51TmUvKiqnVM85TSpQFpdfCvcXCXSPLdAz5gZYB05cUr1lVMCJ9ppGEn1UQN9s3c4KldY84M34lXgglE2YkZZ9Hr/Uxq466j+wGhH4DVpBbHTXZCWShUxhnHfCBusOMOSpbEPXAV1vs3Vk37E0bqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773226435; c=relaxed/simple;
	bh=VrsuiiE+xhBns3p388KtITQD9klHbm1bEuMay3ub2Rw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X4Z7BqJ17x6ygwNMLw3pTXWvs85wvWQotkR0zp1tyToL4D11aRATzscKCQFi0dhRG993fDsVzaDSVQM4UZSJtYqT2KiuxafiqzE7yZuOryuJRz2WluDmF8deew/4NKxwcA9wAiS61rgQWVteZFrkRLA9dttxGonXpFikG7pFyfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=bi0nlZcp; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="bi0nlZcp"
ARC-Seal: i=1; a=rsa-sha256; t=1773226415; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=SEpK7piFPs8vR0nSjBcbQ5wUp2uizdFOk33p9wv7a42BPw+fbXkPsGqyI55nUbGMKZMMCgmRUq7suovVBheu/bQcsonKRRYWXrSUBOkDF6bSWK4Q95vgn7bWSUx/ufxyfZECH/o5pJHQ8Ojv5JDH+AVqx0E4DTiWzBJlnkjLRkQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773226415; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=+k6M33aJS1FmhUhMNkVgIqpm70vchF3r0b20NnXGL0I=; 
	b=RXWw7GMYFbHSbo/ysqRXAxDeJm/3PMYpTXKDikXGFN5gUQY/wpRcdc6cWQ6p6tocjS2OVWZ4XBURhWsUycr5R3moYFLol6FEw0Gyiadb28ojmbvhTnFUV0S8FX9ByuI712sP0UzEfhM3sNLslq+uzBvCn3ul3F0dMObfLvfS9Ak=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773226415;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=+k6M33aJS1FmhUhMNkVgIqpm70vchF3r0b20NnXGL0I=;
	b=bi0nlZcp9VP4c6UiE5AACgIFdUG7Vwc5gj3shMD9DnPHKqK76f4BF+bPCUFFnn1H
	hJpnZTRQux5DLHyV1PspeU93bgQpJFYawDB7A8FOflwuJTHvKhDgAelYI0u5cnpiVvM
	pQxF+XuxUxnNUCWNK+f/YHSumSJ/1m+wrfTTl/PA=
Received: by mx.zohomail.com with SMTPS id 1773226412781979.8038318000262;
	Wed, 11 Mar 2026 03:53:32 -0700 (PDT)
Message-ID: <530f0541-851a-4201-98f3-93439825c6c7@zohomail.com>
Date: Wed, 11 Mar 2026 18:53:26 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] cxl/memdev: Hold memdev lock during memdev poison
 injection/clear
To: Alison Schofield <alison.schofield@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Ben Cheatham
 <benjamin.cheatham@amd.com>, driver-core@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
References: <20260310-fix_access_endpoint_without_drv_check-v1-0-94fe919a0b87@zohomail.com>
 <20260310-fix_access_endpoint_without_drv_check-v1-2-94fe919a0b87@zohomail.com>
 <abCOZf9vkau0AyWL@aschofie-mobl2.lan>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <abCOZf9vkau0AyWL@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: rr080112280547ab2db34e6c8caa8f7e26000035be26303d5c722b3e40db3e8598275c29e9c361d94006299ac0:zu0801122717ac063e461905b9a2d5facc0000b0e450d345b098a96d0a4ac27e6be1c9d485eacab711760875:rf0801122d2fa5b53a886519588600b2dd00008ea4c4f2f4e5dce5559eaf14c1b43674c6e62db15d9b5b11382a0596b2c342:ZohoMail
X-ZohoMailClient: External


在 2026/3/11 05:34, Alison Schofield 写道:
> On Tue, Mar 10, 2026 at 11:57:54PM +0800, Li Ming wrote:
>> CXL memdev poison injection/clearing debugfs interfaces are visible
>> before the CXL memdev endpoint initialization, If user accesses the
>> interfaces before cxlmd->endpoint updated, it is possible to access an
>> invalid endpoint in cxl_dpa_to_region().
>>
>> Hold CXL memdev lock at the beginning of the interfaces, this blocks the
>> interfaces until CXL memdev probing completed.
>>
>> The following patch will check the given endpoint validity in
>> cxl_dpa_to_region().
>>
>> Suggested-by: Dan Williams <dan.j.williams@intel.com>
>> Signed-off-by: Li Ming <ming.li@zohomail.com>
>> ---
>>   drivers/cxl/core/memdev.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>> index 273c22118d3d..8ebaf9e96035 100644
>> --- a/drivers/cxl/core/memdev.c
>> +++ b/drivers/cxl/core/memdev.c
>> @@ -295,6 +295,7 @@ int cxl_inject_poison_locked(struct cxl_memdev *cxlmd, u64 dpa)
>>   	if (!IS_ENABLED(CONFIG_DEBUG_FS))
>>   		return 0;
>>   
>> +	device_lock_assert(&cxlmd->dev);
>>   	lockdep_assert_held(&cxl_rwsem.dpa);
>>   	lockdep_assert_held(&cxl_rwsem.region);
> I'm having second thoughts about this since this call site is not
> the 'beginning of the interfaces' as the commit msg suggests.
>
> What about taking the device lock in the debugfs func, ie -
> mem.c : cxl_inject_poison. If the goal is to avoid using the debugfs
> interface before probe completes, that does it.
>
> At this callsite, we make sure nothing changes out from under us,
> no endpoints attach or detach during the work.
>
Thanks for taking time to dive into this issue.

But I don't quite understand your comment, do you mean that we don't 
need above device_lock_assert() in cxl_inject/clear_poison_locked()?

You mentioned that taking the device lock in cxl_inject_poison() to 
ensure endpoint won't be changed during the debugfs interfaces calling,

That is right and that is what this patch does. So I am a little bit 
confused.


Ming

>>   
>> @@ -331,6 +332,10 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
>>   {
>>   	int rc;
>>   
>> +	ACQUIRE(device_intr, devlock)(&cxlmd->dev);
>> +	if ((rc = ACQUIRE_ERR(device_intr, &devlock)))
>> +		return rc;
>> +
>>   	ACQUIRE(rwsem_read_intr, region_rwsem)(&cxl_rwsem.region);
>>   	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &region_rwsem)))
>>   		return rc;
>> @@ -355,6 +360,7 @@ int cxl_clear_poison_locked(struct cxl_memdev *cxlmd, u64 dpa)
>>   	if (!IS_ENABLED(CONFIG_DEBUG_FS))
>>   		return 0;
>>   
>> +	device_lock_assert(&cxlmd->dev);
>>   	lockdep_assert_held(&cxl_rwsem.dpa);
>>   	lockdep_assert_held(&cxl_rwsem.region);
>>   
>> @@ -400,6 +406,10 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
>>   {
>>   	int rc;
>>   
>> +	ACQUIRE(device_intr, devlock)(&cxlmd->dev);
>> +	if ((rc = ACQUIRE_ERR(device_intr, &devlock)))
>> +		return rc;
>> +
>>   	ACQUIRE(rwsem_read_intr, region_rwsem)(&cxl_rwsem.region);
>>   	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &region_rwsem)))
>>   		return rc;
>>
>> -- 
>> 2.43.0
>>
