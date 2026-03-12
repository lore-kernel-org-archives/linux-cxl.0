Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8F4359A6C;
	Thu, 12 Mar 2026 10:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773312364; cv=pass; b=S5zsi/BHtLMzg/xRGCW8HQ242+8bA6sWFpXrWPtVJgZRM3LPHVJQr2cDVxmYYZ/VzDGfo/oKWzIsMy6roqXvy8RUXv1dNycF/lx809LzZv830hYWUhHSzobWUCD1hWD7ZnVIe2PWyHE0bxieoF9JzOGRTtdPKQRv8RcjljnFQGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773312364; c=relaxed/simple;
	bh=ib2azcB45rykD4WCSQuYUaYpoHmNoOAdlZ24E96ltUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JUVfC0omzcEdKht27eU0+VdsoA/9DwHWAt4MyrQBvtkXudPXJcZXuiK8ijGdnaStK2ToCJiP5LwkCePpQciR9leckHKQiGgfgYl3InqHmrxJ4bjpCEoUt9y9ZEnXbeaudrJdP9khw+W8nEfnKC+mX3PcTjwdt9SVQdWIwkGlSlg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=FmJ/ii+R; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="FmJ/ii+R"
ARC-Seal: i=1; a=rsa-sha256; t=1773312340; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Ee4+jJs5r4hLWEmnBORasq1vqS9GUq870K8zuySo0+nj8E1CEhF4FhOlMNiOHPcpuNm43iqWKjwYYFcwPwp/5GA+z0En4KxsbzitP92YDDytspcO1isy9d8YOhnXdnCDgphnQ2wXyFSqFNVUDTvBKLEJmXxt1ayyZQ1LFS8XGik=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773312340; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=6le+Umu5ShQgMTwQqCqPJCiPEPbCR/gc5k2zDVuJEGs=; 
	b=NvZqzLf6xdkcxBQD/JHvgPhqZFo1r98+I4jKnreA+Mvs3/uC8uLayPJaeDm4kW8uz1+H5IQg8ni460murpVtXXUFe+q/aKcwuNoSUApq973e+j3V7ZjGMJEZP+4ZypbJ0qqY6zGyzcmBJZAPORHBW4EQ2hmxPuuBp6/YDXWNwEQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773312340;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=6le+Umu5ShQgMTwQqCqPJCiPEPbCR/gc5k2zDVuJEGs=;
	b=FmJ/ii+R/PUnq3LF6c6dT/mvF0lwZHufBkQhhJNJ3UE8nQAF4VANI25oSNPKotKI
	BZeOe2fmbPOYL28mnMP4yTWPHsYWEFW+8dMTICkgVkipkmOV2mZm5et2dbJqjecpebp
	4+x4auK+k8wQqkFSvo7qn209sU62K1QE1dKqGs5Y=
Received: by mx.zohomail.com with SMTPS id 1773312338962431.72554716052593;
	Thu, 12 Mar 2026 03:45:38 -0700 (PDT)
Message-ID: <a1b3f694-523a-4817-b9d2-d8b8ec0f2927@zohomail.com>
Date: Thu, 12 Mar 2026 18:45:33 +0800
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
 <530f0541-851a-4201-98f3-93439825c6c7@zohomail.com>
 <abI7g5xdfQTERoKX@aschofie-mobl2.lan>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <abI7g5xdfQTERoKX@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: rr080112282aedaa9d9a996371b0a9e20600002e56a6eb943c701379f7d0ecc0eb3d564041a69f47bd5c4e6303:zu0801122711c9217af5f8056d275faae5000099752f3f65d2a010ad7a48c30036a04b14b8ff6509c57aef4e:rf0801122d48aada44e05273a830d796540000756f3feaa4c9fb1e5d06b880bd48431837016ae84fa927dfcd607bfc6c7cd5:ZohoMail
X-ZohoMailClient: External


在 2026/3/12 12:05, Alison Schofield 写道:
> On Wed, Mar 11, 2026 at 06:53:26PM +0800, Li Ming wrote:
>> 在 2026/3/11 05:34, Alison Schofield 写道:
>>> On Tue, Mar 10, 2026 at 11:57:54PM +0800, Li Ming wrote:
>>>> CXL memdev poison injection/clearing debugfs interfaces are visible
>>>> before the CXL memdev endpoint initialization, If user accesses the
>>>> interfaces before cxlmd->endpoint updated, it is possible to access an
>>>> invalid endpoint in cxl_dpa_to_region().
>>>>
>>>> Hold CXL memdev lock at the beginning of the interfaces, this blocks the
>>>> interfaces until CXL memdev probing completed.
>>>>
>>>> The following patch will check the given endpoint validity in
>>>> cxl_dpa_to_region().
>>>>
>>>> Suggested-by: Dan Williams <dan.j.williams@intel.com>
>>>> Signed-off-by: Li Ming <ming.li@zohomail.com>
>>>> ---
>>>>    drivers/cxl/core/memdev.c | 10 ++++++++++
>>>>    1 file changed, 10 insertions(+)
>>>>
>>>> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>>>> index 273c22118d3d..8ebaf9e96035 100644
>>>> --- a/drivers/cxl/core/memdev.c
>>>> +++ b/drivers/cxl/core/memdev.c
>>>> @@ -295,6 +295,7 @@ int cxl_inject_poison_locked(struct cxl_memdev *cxlmd, u64 dpa)
>>>>    	if (!IS_ENABLED(CONFIG_DEBUG_FS))
>>>>    		return 0;
>>>> +	device_lock_assert(&cxlmd->dev);
>>>>    	lockdep_assert_held(&cxl_rwsem.dpa);
>>>>    	lockdep_assert_held(&cxl_rwsem.region);
>>> I'm having second thoughts about this since this call site is not
>>> the 'beginning of the interfaces' as the commit msg suggests.
>>>
>>> What about taking the device lock in the debugfs func, ie -
>>> mem.c : cxl_inject_poison. If the goal is to avoid using the debugfs
>>> interface before probe completes, that does it.
>>>
>>> At this callsite, we make sure nothing changes out from under us,
>>> no endpoints attach or detach during the work.
>>>
>> Thanks for taking time to dive into this issue.
>>
>> But I don't quite understand your comment, do you mean that we don't need
>> above device_lock_assert() in cxl_inject/clear_poison_locked()?
>>
>> You mentioned that taking the device lock in cxl_inject_poison() to ensure
>> endpoint won't be changed during the debugfs interfaces calling,
>>
>> That is right and that is what this patch does. So I am a little bit
>> confused.
> I was only thinking of moving the ACQUIRE one level up, to here:
> drivers/cxl/mem.c: cxl_debugfs_poison_inject|clear ()
>
> That would mean dropping the assert in clear_poison_locked().

Oh, got it, will do that in v2, thanks for your explaination.


Ming

[snip]

