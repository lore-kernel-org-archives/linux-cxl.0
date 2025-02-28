Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8170742A87;
	Fri, 28 Feb 2025 02:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740710854; cv=pass; b=YzjS0f/JPHFVkckpDZAz3iUN9LhOnEo/AhsxIGQ3An9KwPMVybtXqrPoHGE2UXdcsc05RXtdiK0ENhB17+5JJJ4HjLS2Mgqmr13ZcNwUkFXBYTs1+z3OSrKFxOuewid5KuXgme/Ww977ySgs8ObMXLmJHYsFGFyS5Gcj7rxWCw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740710854; c=relaxed/simple;
	bh=jRnyotKrIz3xE9KAt8CfF5YQ2e5ZHfWxfwXfBWEtk44=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OI+6cPjxl1pPfhpxv8bE5YfTaklfpyL4JfoMw3YHYt8x89QxV9SVyTw1FDbzFcvFozBBdN4+itrWbgHsdSnjM0qQGSmwhWwpL7z+YED9Ar/CEdGA9mRm66e5v7I7bDHND1LSzHDmamCqfbhCKPENDkxZR36gSdYjMZBdzO/eTPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=S4fBoN9I; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="S4fBoN9I"
ARC-Seal: i=1; a=rsa-sha256; t=1740710839; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=frC96BHeX3wXQzjLQOr0igZe6s4G2mHnP6CNSYWRTEEvGN9ERdumrEfU+X4JFfca9HtnC+fBWTZLInJzZRyT3AHfv3tajCzaCRIl78eCPgLafnvqyAfkNC2nULOYy4tbVLtJwE5xR8PRpxDMG7FxlskstYGvXMMMs3wwpXJJkrs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740710839; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=tmh5ew+H6kLNXBeX0vCkVQk8CqBaGCCXYfCYinqFqiM=; 
	b=JzyfN+bMu++l28o+dOFiG2Iqt6agBUxHoMEUp0G5AJP8aFa5rVDnywK3YzuzEb1A6pRlYfTxDMkfAk/12fTw6SSOTuVRa2oFmftwTnSRR1q4PMsdowIqFdUEh5yELCtC+qaxQn2SCPFRgc1FMgAfX5Tjry/t79jnnPZFMFF0yyY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740710839;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=tmh5ew+H6kLNXBeX0vCkVQk8CqBaGCCXYfCYinqFqiM=;
	b=S4fBoN9IKgU3ZOB38Nag1WdV2ARMqNOrigZnPZLzw1DJvkOSqEEcjCk4utfif8Im
	9296kJ3u6t3Emx3DciYNf49EAzXZAaXr/a3i/H+upktcCkRPIlM+JR+mgWLyL+AXle1
	Z42MADCNaKz+yympN3iry/AZLELDbMr7tt/x3BMU=
Received: by mx.zohomail.com with SMTPS id 1740710836113177.21630475431164;
	Thu, 27 Feb 2025 18:47:16 -0800 (PST)
Message-ID: <4c97ec3a-3435-4e79-8265-6a82ae930c3e@zohomail.com>
Date: Fri, 28 Feb 2025 10:47:12 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] cxl/hdm: Verify HDM decoder capabilities after
 parsing
To: Alison Schofield <alison.schofield@intel.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250227103251.390147-1-ming.li@zohomail.com>
 <Z8DdafbX6_tbM4DW@aschofie-mobl2.lan>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <Z8DdafbX6_tbM4DW@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr08011227bda5bc386ac7805229bd7b7f0000ebd037d407201db7b3a960f81788134882b82c30e525ef0d46:zu08011227648d5c086ae41ed457b75b3c00000de38bb4fe29b1586f95748c1a14fdd72171a11a158fd6c6aa:rf0801122dafa3877bbf6afd3e80a3bef10000939289b6fe9ee8a39cb3997948a5bad320c2d57bc932ae6f5692edd6086f45:ZohoMail
X-ZohoMailClient: External

On 2/28/2025 5:47 AM, Alison Schofield wrote:
> On Thu, Feb 27, 2025 at 06:32:51PM +0800, Li Ming wrote:
>> devm_cxl_setup_hdm() only checks if decoder_count is 0 after parsing HDM
>> decoder capability, But according to the implementation of
>> cxl_hdm_decoder_count(), cxlhdm->decoder_count will never be 0.
> How does a check against the spec maximums benefit this driver? Is there
> a bad path we avoid by checking and quitting at this point.


My understanding is that no a bad path on driver side if the decoder_count is greater than the maximum number spec defines.

Driver just allocates cxl decoders on the port based on the value of decoder_count. But I am not sure if hardware will have other potential problems when it didn't follow the spec.


>
> Might this catch silly decoder counts that the driver previously
> ignored?
>
>> Per CXL specification, the values ranges of decoder_count and
>> target_count are limited. Adding a checking for the values of them
>> in case hardware initialized them with wrong values.
> Similar question - is this catching something sooner, rather than
> later?


Yes, the check is at the beginning of HDM setup during port probing, if value is wrong, will break HDM setup.

I'm not sure if I fully understand your question, please correct me if I misunderstand it. thanks.


>
>> Signed-off-by: Li Ming <ming.li@zohomail.com>
>> ---
>> base-commit: 22eea823f69ae39dc060c4027e8d1470803d2e49 cxl/next
>> ---
>>  drivers/cxl/core/hdm.c | 31 ++++++++++++++++++++++++++++++-
>>  1 file changed, 30 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
>> index 70cae4ebf8a4..a98191867c22 100644
>> --- a/drivers/cxl/core/hdm.c
>> +++ b/drivers/cxl/core/hdm.c
>> @@ -138,6 +138,34 @@ static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
>>  	return true;
>>  }
>>  
>> +static int cxlhdm_decoder_caps_verify(struct cxl_hdm *cxlhdm)
>> +{
>> +	/*
>> +	 * CXL r3.2 section 8.2.4.20.1
>> +	 * CXL devices shall not advertise more than 10 decoders,
>> +	 * CXL switches and HBs may advertise up to 32 decoders.
>> +	 */
>> +	if (is_cxl_endpoint(cxlhdm->port) && cxlhdm->decoder_count > 10)
>> +		return -EINVAL;
>> +	else if (cxlhdm->decoder_count > 32)
>> +		return -EINVAL;
>> +
>> +	/*
>> +	 * CXL r3.2 section 8.2.4.20.1
>> +	 * target count is applicable only to CXL upstream port and HB.
>> +	 * The number of target ports each decoder supports should be
>> +	 * one of the numbers 1, 2, 4 or 8.
>> +	 */
>> +	if (!is_cxl_endpoint(cxlhdm->port) &&
>> +	    cxlhdm->target_count != 1 &&
>> +	    cxlhdm->target_count != 2 &&
>> +	    cxlhdm->target_count != 4 &&
>> +	    cxlhdm->target_count != 8)
>> +		return -EINVAL;
> Maybe instead of manual bitwise checks try
> 	(!is_power_of_2(cxlhdm->target_count) || cxlhdm->target_count > 8))


Yes, It is clearer, thanks for that.


>
>> +
>> +	return 0;
>> +}
>> +
>>  /**
>>   * devm_cxl_setup_hdm - map HDM decoder component registers
>>   * @port: cxl_port to map
>> @@ -182,7 +210,8 @@ struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
>>  	}
>>  
>>  	parse_hdm_decoder_caps(cxlhdm);
>> -	if (cxlhdm->decoder_count == 0) {
>> +	rc = cxlhdm_decoder_caps_verify(cxlhdm);
>> +	if (rc) {
>>  		dev_err(dev, "Spec violation. Caps invalid\n");
> Can you move the dev_err to the verify function and include the
> specific invalid capability.
>
>
> --Alison

Sure, will do that, thanks.


Ming


