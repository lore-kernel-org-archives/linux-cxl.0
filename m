Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F02823CB;
	Fri, 28 Feb 2025 02:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740710929; cv=pass; b=eXkKv7yx0rLlLbFowrEJPgs0vbgNDeiURo5i5o1E588PWC5AwWtiFww3TBsGRBJpB+x3kNPaju77YM7GP27FiQnqzUiVFHeWhzIb2lVrNNuGpuiunuy04noLXGdxo+YpJOlDO5KmRQL+JY1DWuw349vp6qVyPE+sHPIDdwPAfVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740710929; c=relaxed/simple;
	bh=90J/r+zezVNLO+dnk2SSsm3jg7ubTc8Hq04I3hqxlhk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MtC8DJDmSEYyxmnIAahUvloaYZRhqpM6s3TZ5d27w6/FrFRlpD+6dyHjuHmEDlt7WZUg5MwOw3r1Sf49XweB7HmZ8efg3iat1Yvkq6K/oa/PJBVtAGLWUgqYkOOjZ+y20NgDkdm8FzOb6vUElFPI0nQuPOkC7RMzwTYFUYbDzg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=B/8etYy3; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="B/8etYy3"
ARC-Seal: i=1; a=rsa-sha256; t=1740710916; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Ya3YwJblnhHlK6QpBzOfU/NmuVeEh3vR5XuXKw8pZ/iEpenckDZ0KHRORlzMZcH7SmZFYbb1gYLdJJqNMfuq0VEn5NAtOPGQyf+Qqo2r9lp5SsOJyS3r+i+XWdRx/XtksT/2yI+yzclRvEH1qcypIcwZ8f85iVxf7Xeg2gQ8nJ0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740710916; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=TjgmGrj2pKiN2+9kEx/SXBHo3APqNpx6FIWgYaHFhCY=; 
	b=jBpfHahwp/Vs72SC1qydszIU82KsXa6/Vaqjl/nYDJhedQQdU0aWIqh3wB8M/pEE+9QFaAJLUndIhBl+eAPH0A5wwty0Dxldu1uVE+DBxxawmdWOGY7oZ71Ncu/WCMQVj9q6fwg46Rb0j8vh+On37t7oKcAbDJSuDLvwuauWNSI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740710916;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=TjgmGrj2pKiN2+9kEx/SXBHo3APqNpx6FIWgYaHFhCY=;
	b=B/8etYy3q42PtXNnPpUKx093UxwlvBO+PITkilOcmQazMTC10G6withBNUABz5M2
	cLFKFt9Djze38Y3GH/FppeETKV8z1ou3N9ITh1b8to6G4K7pXmAkVkJe3JceukHcL/o
	awz30OY+NFHJI3xmWgK626YE6dBoMlIxinwyyNRw=
Received: by mx.zohomail.com with SMTPS id 1740710913081161.54984296268083;
	Thu, 27 Feb 2025 18:48:33 -0800 (PST)
Message-ID: <8ecd1237-4719-4f08-8826-2735eb6f472f@zohomail.com>
Date: Fri, 28 Feb 2025 10:48:29 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] cxl/hdm: Verify HDM decoder capabilities after
 parsing
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 dave@stgolabs.net, jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com
References: <20250227103251.390147-1-ming.li@zohomail.com>
 <34a30d8d-f4e2-4c3b-8386-d07f7b8cfaa1@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <34a30d8d-f4e2-4c3b-8386-d07f7b8cfaa1@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr08011227200a881e4ee661824213df4b0000c647cfbf695ddc0077799efb6bfa5810c0051e5363be40452d:zu08011227435949eb9bcec677da86e55f0000b5d3cfc267491b85ae1e0808df420a2ba1322a67ac1c19d5b4:rf0801122d9fad29f79a13b52a866d6fcf0000d8bcd6111b1d3637b503a353c09b201926738c2b3d6a187b72b39eb84e8629:ZohoMail
X-ZohoMailClient: External

On 2/27/2025 11:21 PM, Dave Jiang wrote:
>
> On 2/27/25 3:32 AM, Li Ming wrote:
>> devm_cxl_setup_hdm() only checks if decoder_count is 0 after parsing HDM
>> decoder capability, But according to the implementation of
>> cxl_hdm_decoder_count(), cxlhdm->decoder_count will never be 0.
>>
>> Per CXL specification, the values ranges of decoder_count and
>> target_count are limited. Adding a checking for the values of them
>> in case hardware initialized them with wrong values.
>>
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
> #define the limit please

Will do, thanks.

>
>> +		return -EINVAL;
>> +	else if (cxlhdm->decoder_count > 32)
> same here
>
> DJ

Will do, thanks for review.


Ming

[snip]


