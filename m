Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231C43A3E78
	for <linux-cxl@vger.kernel.org>; Wed,  1 Apr 2026 12:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775047404; cv=pass; b=cgWKN95iL3ES2Odk9KFcFyBhIeZlFRuWEdT5yUeGl4ro1Gfv76f46vQVuP6SMcOLtJEvYskLDI9I2ryXDcGhczF/cjkjhMrWHr0iFBM0ccMXwoyJ71Xs+lzH9oA1Ew2mZ7MySJwsuHCRBx+tcGQmgqYA7hfeRW6omoKZ3JKYnJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775047404; c=relaxed/simple;
	bh=fhi6d2YKo7wJKPwzjvcQkCl0E7tutCjvvFtKrpYSwCI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A/viJa60p0cihbODC7RE9EoZdTR+wvp5QA0zcDuFq1OCnuLeIvom9eYK9bnm1mLp59ow+S2s10OytJmxI/4yR+jI67U/YE+Tqj4/zpMDnHxwUgRU7yyBZ5dMNqsdIk5rSblzYocCGWWj1D+sCXr5jk1cg9SiFp5NupGfNcbDJOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=PC+Pq15t; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="PC+Pq15t"
ARC-Seal: i=1; a=rsa-sha256; t=1775047394; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=VDaM6yf0HR9VkjVqsUyCgcMz8H9En+AsBw8YkcHYyrpd4lqhN1xxLGmttXOd/eO/hm9+lvcc6k/zHFj+TkrheHJERSISxoXJIlCD+Vrt5uVINV3PtN2hfmZ66uuq1BQ4Dlj6Z/+x5Oe0uvGEmehkHJV4LGuHRKTKCVjmMB8ejA8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1775047394; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=wtvh9inwdwiJw0UH4MNObvbZ5mzuBOGQXZmBqWGPMz0=; 
	b=nriE6k1mieDRrcI+P8Xq8RZrtSnDbe+fin3PqYLOUrruLG1275QAWnQGoryj6VgjykTIOKuZnDEdjiI85X3gl0HEB/xSI840E56pYq3bHnmnxy9AnPHwC048iXoPJVO8k90MXXL9/mX9+fsUCkrJD+FxeCWESN5+VKGi2s5FwA0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775047394;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=wtvh9inwdwiJw0UH4MNObvbZ5mzuBOGQXZmBqWGPMz0=;
	b=PC+Pq15t/nQ3LxvlCZ8+BBZKq8xdaIQFC4y+CaDoe1CpQmCBHdAUduQogIS9F7cG
	WwIYUkMCGlAlO8NxXEnOxce0jFj6P5N1Yo+O86T4IF87BYXPwVuX3dEoAf6tneqFLFP
	ILRz+bvUZ7SeJNwMfhp7dz/wei8JXxRPidZj3WpY=
Received: by mx.zohomail.com with SMTPS id 1775047390410211.3802146889152;
	Wed, 1 Apr 2026 05:43:10 -0700 (PDT)
Message-ID: <c21f31bf-28ea-44ca-83fd-92fa16b8ed39@zohomail.com>
Date: Wed, 1 Apr 2026 20:43:02 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] ndctl: Show region locked status to user
To: Alison Schofield <alison.schofield@intel.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 linux-cxl@vger.kernel.org
References: <20260329144714.888155-1-ming.li@zohomail.com>
 <acxmON1VSw4EEp4q@aschofie-mobl2.lan>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <acxmON1VSw4EEp4q@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: rr08011228b9931cb50f57a0300536de4200003efcf5c1d1de49980ba5136e9796d4cffa0251ddea0da6a4ed07:zu08011227e669b58709739e8eb07626870000740b6e2fdc6be1acfd4f736786275742838956801abd1825e5:rf0801122de42df92bec5bf03bd1e237300000e4f2dd1477d42f0e123f88b038c0f52c16238c1ea20510a6dc3bccbda20853:ZohoMail
X-ZohoMailClient: External


在 2026/4/1 08:26, Alison Schofield 写道:
> On Sun, Mar 29, 2026 at 10:47:14PM +0800, Li Ming wrote:
[...]
>> @@ -853,6 +853,12 @@ static int destroy_region(struct cxl_region *region)
>>   		}
>>   	}
>>   
>> +	if (cxl_region_is_locked(region)) {
>> +		log_err(&rl, "%s: Cannot destroy a locked region.\n",
>> +			devname);
>> +		return -EPERM;
>> +	}
>> +
> How about moving the check earlier, before the unbind/disable?
>
> With this here, users selecting --force will get back a disabled
> region. Seems better to do nothing at all if destroy is not an
> option.

Yes, you are right, that is better. thanks.


Ming

>>   	/* Reset the region decode in preparation for removal */
>>   	rc = cxl_region_decode_reset(region);
>>   	if (rc) {
>> -- 
>> 2.43.0
>>
