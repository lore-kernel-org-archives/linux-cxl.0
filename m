Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A0240B6E5
	for <linux-cxl@vger.kernel.org>; Wed, 27 May 2026 13:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779887322; cv=pass; b=gmFkI6KPYsxS/lRGQbgTGOFJn+HGOE4+jgkXKumZkLiFPIN3JpeaNRwq/LV8RFnXpeav6rWaybOakiCSpXF9M17k1NPzeJrnqhr1Q5nbeY4/84t+xiDusKMA1s97NziOKSLSDB8heRpgP4rjrQN2vuGCB/1O8F5MWb3RlFZ/CbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779887322; c=relaxed/simple;
	bh=GtG1CxC5YIcWz73QGJTyczJSNPtYLG9fgVPfVnNcFrA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pngL8fQsfRE3/xG2EOztoPxRvh6tpFXU/0skrBiLjB0AJIeGnDIVvPH3KYTibr1iwGqhDJiVuHrv1F6gF2hE3MoHjYu33EGsPtetQ+uLuCJXP8HVCIVdk/LF+rVo6+PS5rk2RFWNAkCmM8NiaO+WAvDYa9SpmTbQQRGPwNgTbTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=IM+H/jyo; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="IM+H/jyo"
ARC-Seal: i=1; a=rsa-sha256; t=1779887306; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=j4oCHXpjTXLmvzkVWm/IG8YcRFkxsKQWq/J6Fu7g0FVhWgNHxJ3ihXDlp5OXQl0XBUMWSePbzLVTydNDaqaP5NBqyJYINAcw27E3n30+dIb26bXIukxbt6PJfqK+Qq+iszbGMfv+7uz8FPsu4fd6qhmwubWJA9rjrn3HVmyxCBg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1779887306; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=WwMgR8nAFbzrHaIOcoXXLD1rdyHGXUJOJBPbdUBq0Rw=; 
	b=D5jZDcp+TiUceFC+CuPUUORSUwdlAmOKfm8M5hmxZ+MZ0qXkWpwD0waRfBG573mjb2CsYTV9dNF8YjbWdB4A+o46wi3rg5uL14s4gZXTZ8BYwRd2DPxZS+t6n82Hqfvka0MObfcYbnCTQYbj6r5shhtzAIJ3yNficcj5RC1+tO4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779887306;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=WwMgR8nAFbzrHaIOcoXXLD1rdyHGXUJOJBPbdUBq0Rw=;
	b=IM+H/jyo7Jg9Ds/hvSXwYDzshN/4LutTFRuawJJoO9xDlirSBAenliTTMM8hi+29
	3qqScFj4lm6TNWKHarIGuVFJDBQB8XcMdi0hUazeLcPkcndcIbNwKLBIz6GZJ6m7j3p
	mJ4lQW3A01/jbTgjlE7NpIrFRAQtEElPJQe1bXa4=
Received: by mx.zohomail.com with SMTPS id 1779887302473811.8314878154824;
	Wed, 27 May 2026 06:08:22 -0700 (PDT)
Message-ID: <7da588a2-cbdc-4f63-aadb-9faf0125e90a@zohomail.com>
Date: Wed, 27 May 2026 21:08:14 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add CXL reviewer
To: Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>,
 Davidlohr Bueso <dave@stgolabs.net>
Cc: linux-cxl@vger.kernel.org
References: <20260527001305.533170-1-alison.schofield@intel.com>
 <27e15fda-2994-4fd4-9822-d0006b01a26e@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <27e15fda-2994-4fd4-9822-d0006b01a26e@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: zu08011227ca8df406df07c6c4c7474f370000cc916d08e08fad81b43c9118da18989fddf7f3f944a1b9e590:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External


在 2026/5/27 08:33, Dave Jiang 写道:
>
> On 5/26/26 5:13 PM, Alison Schofield wrote:
>> Add Li Ming as CXL subsystem reviewer.
>>
>> Thanks to Li Ming for all the CXL bugs they've found and fixed,
>> and looking forward to many more prevented!
>>
>>
>> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Acked-by: Dave Jiang <dave.jiang@intel.com>

Thank you all for trusting me as a reviewer for the CXL subsystem. I 
truly appreciate this opportunity. I will keep learning, do my best to 
help you to improve the CXL subsystem.

Reviewed-by: Li Ming <ming.li@zohomail.com>

>> ---
>>   MAINTAINERS | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 2fb1c75afd16..992e1fa57b72 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -6428,6 +6428,7 @@ M:	Alison Schofield <alison.schofield@intel.com>
>>   M:	Vishal Verma <vishal.l.verma@intel.com>
>>   M:	Ira Weiny <ira.weiny@intel.com>
>>   M:	Dan Williams <djbw@kernel.org>
>> +R:	Li Ming <ming.li@zohomail.com>
>>   L:	linux-cxl@vger.kernel.org
>>   S:	Maintained
>>   F:	Documentation/driver-api/cxl
