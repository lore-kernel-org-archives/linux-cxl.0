Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA8212FF69;
	Thu, 20 Feb 2025 01:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740014786; cv=pass; b=aYMD6OF0/wKy/c9Ys3p6cCsimfQRs6NlOAk1FMuWEQ3sPO0+NIVzDgoRdAOyTV79DNB50jDTlDabGqRKSNIdRMTPxF0P642GCd8sroBenCpo49ChBJVa93iun+0aW/GsyYJ/jhYgKuBq+bcSVoj6agbo2kgw8OH8Ur2nu5MqWlQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740014786; c=relaxed/simple;
	bh=9uRLRTvNQAfO7e/XzvTvEkPAnHESpfWdkaBYvdDCGx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rna6VKb8fIehl3i3uuK7xN+tx5dV+hsaGLrC00Z8zN3F7kLCLn1YouIUWp8/WRC+YTRoiUH9Wf14toQhoIgqlYUXGSZlOTbVxZ2vE9+ekc4TFddgIUG3oT1sZqHNY+ZuTYdvYV/5+wliTGvErOvOmwMTTsuaKmvXoQaApPo5a5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=WLpxDii7; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="WLpxDii7"
ARC-Seal: i=1; a=rsa-sha256; t=1740014772; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=X9YmXD5VU4Cq5iV3XCcVKEQzTzdqCjb/iQg9+/CgSsfguSanlCF6lSX2ER/w7iMQFJ3vp2FmguyNwkyw+p8SNmBh/EUJenp5+BbmVHAzJ5Za7hOL8UsxX+lnflIVsVNLMLnQZF2nAsE/6RsNbqLHlVI2ANC1sKuO92Mmb3+Fyvc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740014772; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=v9ZcB0DU1C9TnPXVQqwgiiKUCT4jhoFiq6zlHbZLgPo=; 
	b=eysCiRkfyvRpYxYY7fAhfuaU3keOcJIpUyikbohxpUjh+MLdOS/r44sk/+pexciho53lacJW3w5sdZKt92hyLRTgSwA8zSMRKlay4LDDWzNcae9hzc8Einre5orjhErYjs/ADiL5YPBQeUzu98WPkgCiKeSip6UusOuQDSOK4IU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740014772;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=v9ZcB0DU1C9TnPXVQqwgiiKUCT4jhoFiq6zlHbZLgPo=;
	b=WLpxDii7CMhVWdG9LREXykfxgtAq4LU6LNxMKnHNd2eoN3nNQIPWA9XYftF9fXd8
	L6A1gSfFuVjTKvDAugdV47+IbEENllcOR29WjPiqTR/KI+drhs8g451j3oOW3Fn4xyy
	trxIRKEzBkNN8fSZUCdvo2pDMtfWEpE8vK0R4qdM=
Received: by mx.zohomail.com with SMTPS id 174001477005914.717016759812168;
	Wed, 19 Feb 2025 17:26:10 -0800 (PST)
Message-ID: <55f67727-ed24-4ac4-97c1-95b65d110daf@zohomail.com>
Date: Thu, 20 Feb 2025 09:26:08 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] cxl/core: Use guard() to drop goto pattern of
 cxl_dpa_alloc()
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com
References: <20250217144828.30651-1-ming.li@zohomail.com>
 <20250217144828.30651-6-ming.li@zohomail.com>
 <67b67f05f0a58_2d1e294c6@dwillia2-xfh.jf.intel.com.notmuch>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <67b67f05f0a58_2d1e294c6@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr080112274efb791aa1f6577bac6a4606000006ca0f243d08b0c7a583df7ce4591796e04fb222e503f2fba2:zu08011227c32ea96bed4d230e86654b990000ba68c7a88cd3144e351cc11bafc0142708823fa43e6962da8e:rf0801122d416bb6e4157a848dfbd4345c0000acbefb76e3754d4db3220833132d687f0f973645196a8e0ce909ee0a3b1c40:ZohoMail
X-ZohoMailClient: External

On 2/20/2025 9:01 AM, Dan Williams wrote:
> Li Ming wrote:
>> In cxl_dpa_alloc(), some checking and operations need to be protected by
>> a rwsem called cxl_dpa_rwsem, so there is a goto pattern in
>> cxl_dpa_alloc() to release the rwsem. The goto pattern can be optimized
>> by using guard() to hold the rwsem.
>>
>> Creating a new function called __cxl_dpa_alloc() to include all checking
>> and operations needed to be procted by cxl_dpa_rwsem. Using
>> guard(rwsem_write()) to hold cxl_dpa_rwsem at the beginning of the new
>> function.
>>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Signed-off-by: Li Ming <ming.li@zohomail.com>
>> ---
>>  drivers/cxl/core/hdm.c | 29 ++++++++++++++---------------
>>  1 file changed, 14 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
>> index 874a791f8292..1edbf7873471 100644
>> --- a/drivers/cxl/core/hdm.c
>> +++ b/drivers/cxl/core/hdm.c
> [..]
>> @@ -504,21 +500,24 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
>>  		skip = skip_end - skip_start + 1;
>>  	} else {
>>  		dev_dbg(dev, "mode not set\n");
>> -		rc = -EINVAL;
>> -		goto out;
>> +		return -EINVAL;
>>  	}
>>  
>>  	if (size > avail) {
>>  		dev_dbg(dev, "%pa exceeds available %s capacity: %pa\n", &size,
>>  			cxl_decoder_mode_name(cxled->mode), &avail);
>> -		rc = -ENOSPC;
>> -		goto out;
>> +		return -ENOSPC;
>>  	}
>>  
>> -	rc = __cxl_dpa_reserve(cxled, start, size, skip);
>> -out:
>> -	up_write(&cxl_dpa_rwsem);
>> +	return __cxl_dpa_reserve(cxled, start, size, skip);
>> +}
>> +
>> +int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
>> +{
>> +	struct cxl_port *port = cxled_to_port(cxled);
> Am I missing something? This @port variable is unused?
@port will be used after below __cxl_dpa_alloc().
>
>> +	int rc;
>>  
>> +	rc = __cxl_dpa_alloc(cxled, size);
>>  	if (rc)
>>  		return rc;
>>  
> So I think you can drop this new cxl_dpa_alloc + __cxl_dpa_alloc scheme?

After __cxl_dpa_alloc(), a 'devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled)' will be invoked, cxl_dpa_rwsem is possible to be held in cxl_dpa_release() in devm_add_action_or_reset() failure case.

So I create __cxl_dpa_alloc() to hold cxl_dpa_rwsem for the operations needed cxl_dpa_resem protection, make sure that the cxl_dpa_rwsem is released before devm_add_action_or_reset() invoking.

>
> After that you can add:
>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>


