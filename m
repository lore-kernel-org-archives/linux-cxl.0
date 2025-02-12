Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191211FCF43;
	Wed, 12 Feb 2025 06:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739342197; cv=pass; b=rf+yhzNTFQiEYVlPQI3CKME5KJGefbtqdvJKGW6ovmQ8Z4XKxMgmY5R2GueV2lRMFRHUg/FmgNRMDQCVyC5ocDySRSzLKzRjV5t/nDKYDAho2ZCX8xH8ppifrJ7BtgeawzroEMntI29tly6d5JlQvk1JoJS0ZuPc6BHZEDz4PsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739342197; c=relaxed/simple;
	bh=3irGPHQC/K6RK/yeXyHTs57gMvgnoNPgII8mTMc0qHU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bLOpAMV7SaVoCPDYBqvfevyGxPJsYZdY3EZEGMSna2tMg0Mai4K/8HVaDBI+Dmplue50wcJW5Wfj+xUx63M0rRh3A1846IVc51KtyIbnV58tPubxuPcirzbvPFu+6oxHe/HizYNN3C6Mkl84yoOLM4lMtNnKKMgqz9oSG8rwvYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=T443ZCFR; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="T443ZCFR"
ARC-Seal: i=1; a=rsa-sha256; t=1739342181; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=XJTbcEuACuufCGEAJTS44aoa6028AfFN+jzs8OMVTr0lAfAAzEKedm5V9lH/sngFav78+vprF9YTHMgIUXQL+ISuQGt3rjbyDmGSoy+F80n4nupTzS8gHbEaox7SCJhtkgn4J0JFd2M1pgW4iLqGGICsl1PokdXNL8IOD9j+5Ig=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1739342181; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=GJKDRumPJxZwrkTljZygJTFvkDrV1Gqw+2PEapWNG68=; 
	b=J449S835554iPyf7ImX6Y9Q/42UZKgCVxFkreyKvprCMqCGxzUshf3ysLwW37wIHwFwdzjWdlRAEvCLxp28Gm1HQYL+UvcUU3O8q2mqDFYKwBU2IacJqNH5/A0gXQKo9+v4ol0YlXTeVVK2lS4CsUdjOFUL+pWWviTDy+V04LIE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739342181;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=GJKDRumPJxZwrkTljZygJTFvkDrV1Gqw+2PEapWNG68=;
	b=T443ZCFRdMPVrCDuHf3RMaml6gEAUc8PXVmUo5qWLVXCz4nGZKdJB85F2gDl/L1m
	n4QRXsjxT5IhSRe52eyhVqBPvS90m/qF8PVXy/h34V8gStyAjiNW+Ykt6ckt4eS+y9c
	lMi7rznhrOm9yp2tiL2dtVlT8QrDZ9+wa6/6z1Io=
Received: by mx.zohomail.com with SMTPS id 173934217918933.73227970390144;
	Tue, 11 Feb 2025 22:36:19 -0800 (PST)
Message-ID: <5ba7516c-2856-4bd1-9d5b-0e33ea91addc@zohomail.com>
Date: Wed, 12 Feb 2025 14:36:16 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/7] cxl/core: Use guard() to replace open-coded
 down_read/write()
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: dave@stgolabs.net, dave.jiang@intel.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250211075727.351895-1-ming.li@zohomail.com>
 <20250211075727.351895-2-ming.li@zohomail.com>
 <20250211172631.00001a34@huawei.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20250211172631.00001a34@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr08011227fedd44d0a3b6b9b0306373560000bf97cb02c303c91e27c2fd76e5b1e9c33bb144ecf172f9f0a8:zu08011227ed9f2dc1a604e89a12933dc40000cab3b3a5864163b94aee35fd67553efb60a5e43ec1f4ace1cc:rf0801122dbdb2762d8c8f0a58afd5e28f000084f9e2bb3b8f8c52eb63ffa7f82e44279b010bec0557d046755dc00855222e:ZohoMail
X-ZohoMailClient: External

On 2/12/2025 1:26 AM, Jonathan Cameron wrote:
> On Tue, 11 Feb 2025 15:57:21 +0800
> Li Ming <ming.li@zohomail.com> wrote:
>
>> Some down/up_read() and down/up_write() cases can be replaced by a
>> guard() simply to drop explicit unlock invoked. It helps to align coding
>> style with current CXL subsystem's.
>>
>> Signed-off-by: Li Ming <ming.li@zohomail.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> I wondered if it was worth doing some early returns and dropping
> local variables, but on balance think it isn't worth doing.
>
>
>> @@ -364,10 +362,9 @@ resource_size_t cxl_dpa_size(struct cxl_endpoint_decoder *cxled)
>>  {
>>  	resource_size_t size = 0;
>>  
>> -	down_read(&cxl_dpa_rwsem);
>> +	guard(rwsem_read)(&cxl_dpa_rwsem);
>>  	if (cxled->dpa_res)
>>  		size = resource_size(cxled->dpa_res);
> Could return resource_size() here and return 0 below.
> I'm not sure it gains us much though. 

Right, I will do it in V2.


>> -	up_read(&cxl_dpa_rwsem);
>>  
>>  	return size;
>>  }
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index e8d11a988fd9..e3bb33109ced 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -3216,10 +3216,9 @@ static int match_region_by_range(struct device *dev, const void *data)
>>  	cxlr = to_cxl_region(dev);
>>  	p = &cxlr->params;
>>  
>> -	down_read(&cxl_region_rwsem);
>> +	guard(rwsem_read)(&cxl_region_rwsem);
>>  	if (p->res && p->res->start == r->start && p->res->end == r->end)
>>  		rc = 1;
> could do return 1 here and return 0 but it doesn't gain us much.

Will do it in V2. thanks for review.


Ming

>
>> -	up_read(&cxl_region_rwsem);
>>  
>>  	return rc;
>>  }
>

