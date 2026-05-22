Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DAB3E9C06;
	Fri, 22 May 2026 11:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779450675; cv=pass; b=rd+vDlWrFD1Fj9PfWX5jlyKwK22kzLajeItaXV0bQak5TMnHml6asVEkPdmDssjgmI0aPKHDREDp5q2NcPKnH9rSzH9EZFi6H1juQ7NLhvqtZqIoRgeiBqAzEEbuY4AZc4V8hpoNAjnsGjiH/EAealCduL3OBshXafmn6WpbSTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779450675; c=relaxed/simple;
	bh=woMCRgXR4kwKYKDurUZHiOt9IdkSlv8oVaxuJ0mvV8Y=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=DxFwqJ8clN/It3jOR7cCUGn4UNBdSSj3WzOQjn7r4C0Wmxbx82AId1ypZNfTNjRPXFUmF0b+9JTyFpffhwLK67vlLJV7YOt423VXsvXuttDq1cgkx84T618ZBiJ6pZDC2EZRRjaOA9QvEPPYnjqv1SRYAZuvWl00SAIy5k/8Jjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=Tp4XC/xK; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="Tp4XC/xK"
ARC-Seal: i=1; a=rsa-sha256; t=1779450669; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=k8DCtI437PvVqxVj6QILJKP9D3vLzO6nU8cY+SiVZJsDNMbr9Rc9J4BbtX/Lk+SvTSQB48pyKNWsi1uxzLfmEmRTyvekpBV8xCaUrlRS5b2XPAQHWs8sDF4ayCGvlOYA+72B2LZNiMkfef7t5BKjpqElnkRoi5f60qUNHYwiEQ4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1779450669; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=oVGmRJL62RfXiWV9ueGhVYKFsvCpcKEbNOsFTv2UJvY=; 
	b=bluoeaGEc22E17OYcVah5tj8LMQrY+Ax42wccDWzZrNNW1nAYcPBJ86IEpwfZ+1OCLbBNhquFedYIPNzOv88O59hlBhjHtWxMECObANOIUGU83d6i1X5rUu0s0mS/3jyew6QsXwAhbu4Uqc8hy+jSSZHzHhwmvUsDBnj1pU23Z4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779450669;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:From:From:To:To:Cc:Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=oVGmRJL62RfXiWV9ueGhVYKFsvCpcKEbNOsFTv2UJvY=;
	b=Tp4XC/xKGn5Gc3mYMJ3aZWZe74dh7lDNAlNJE8xOyCIIFtuc8wI121JHGUr8vfsT
	e9NgI68IDqcRAE3x40RYP94NB6yYpwMrzPBCT+ChCfKGZvqH2IOi/NUCZsYnkU/T6wd
	GHT/wJgriayJFOznOamdsJ4ZJt4FyCb9CZBsaDq4=
Received: by mx.zohomail.com with SMTPS id 1779450667436436.7647965313753;
	Fri, 22 May 2026 04:51:07 -0700 (PDT)
Message-ID: <83dc5f69-115b-4d2a-bc0e-46ed0c3cee10@zohomail.com>
Date: Fri, 22 May 2026 19:50:59 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] cxl/test: Update mock dev array before calling
 platform_device_add()
From: Li Ming <ming.li@zohomail.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: dave@stgolabs.net, jic23@kernel.org, dave.jiang@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, djbw@kernel.org,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260520121457.234404-1-ming.li@zohomail.com>
 <ag6zbJFdvxkf6Q9I@aschofie-mobl2.lan>
 <082c7b2d-e9dc-443a-b385-79585cf8e48d@zohomail.com>
In-Reply-To: <082c7b2d-e9dc-443a-b385-79585cf8e48d@zohomail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: zu08011227f3443ed76d37f5874f4fee290000d43ee5d4ef712aa17a59f71a0631417d8d43cccc1e406fd146:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External


在 2026/5/21 20:25, Li Ming 写道:
>
> 在 2026/5/21 15:25, Alison Schofield 写道:
>> On Wed, May 20, 2026 at 08:14:57PM +0800, Li Ming wrote:
>>> CXL test environment hits the following error sometimes.
>>>
>>>   cxl_mem mem9: endpoint7 failed probe
>>>
>>> All mock memdevs are platform firmware devices added by cxl_test 
>>> module,
>>> and cxl_test module also provides a platform device driver for them to
>>> create a memdev device to CXL subsystem. cxl_test module uses
>>> cxl_rcd/mem_single/mem arrays to store different types of mock memdevs.
>>> CXL drivers calls registered mock functions for a mock memdev by
>>> checking if a given memdev is in these arrays.
>>>
>>> When cxl_test module adds these mock memdevs, it always calls
>>> platform_device_add() before adding them to a suitable mock memdev
>>> array. However, there is a small window where CXL drivers calls mock
>>> function for a added memdev before it added to a mock memdev array. In
>>> above case, cxl endpoint driver considers a added memdev was not a mock
>>> memdev, then calling devm_cxl_endpoint_decoders_setup() for it rather
>>> than mock_endpoint_decoders_setup().
>>>
>>> An appropriate solution is that adding a new mock device to a mock
>>> device array before calling platform_device_add() for it. It can
>>> guarantee the new mock device is visible to CXL subsystem.
>>>
>>> This patch introduces a new helped called 
>>> cxl_mock_platform_device_add()
>>> to handle the issue, and uses the function for all mock devices 
>>> addition.
>>>
>> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
>
> Hi Alison,
>
>
> I missed that you mentioned putting platform_device_alloc() into the 
> helper. I will send out v3 for that.
>
>
After taking a look into the implementation, maybe keep current 
implementation would be better.

This helper is responsible for performing the platform_device_add() 
operation for all mock devices. However, each type of mock device has 
its own specific logic between platform_device_alloc() and 
platform_device_add().

If I move platform_device_alloc() into this helper,I will also have to 
incorporate all these device-specific implementations.

Ming

> Ming
>
>>
>>
>>> Fixes: 3a2b97b3210b ("cxl/test: Improve init-order fidelity relative 
>>> to real-world systems")
>>> Signed-off-by: Li Ming <ming.li@zohomail.com>
>>> ---
>>> Changes from v1:
>>> - Rebase to v7.1-rc4.
>>> - Introduce a new helper to handle the issue. (Alison)
>>> - Use new helper for all mock device addition.
>>> ---
>>>   tools/testing/cxl/test/cxl.c | 105 
>>> ++++++++++++++---------------------
>>>   1 file changed, 43 insertions(+), 62 deletions(-)
>>>
