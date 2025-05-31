Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAD41531E3;
	Sat, 31 May 2025 11:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748692396; cv=pass; b=eji5qDUbXJ9X67fki5RFlSJQyLZCkhcSFvJ37PEt7wza0HhhffuZGjqrGysG6gIM68GrXVbXh3sEy+kjCjB573ITLLesyoHXJtoRO1fR8I0RY7/eO50u6DSSINWCgiObOPg1iuFPzpyoOVnaIPcThLxRTjLSORBfBwqGlid+/RY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748692396; c=relaxed/simple;
	bh=sE+vy1zp0mDHtV2/qptAqzDjLE/OT24fQZody1FK3Aw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rcohhhO1CEgxKQPnZVSsnCbKqAJay2v9LAWyBykW2zP4UfF556xfQ8We0sVTahCv4gaeDRkbgK/+r0e7vlWqiWhb9+SE+oX2iSu/hm8q9sceqer5PihzxDEDl/2DBuljgNNBGLsLHEV4FTRx2SE9TJ7EIUfcdWtFJOXllx+Vk24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=Y7krZN4J; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="Y7krZN4J"
ARC-Seal: i=1; a=rsa-sha256; t=1748692380; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=mPmFtIIj3slRDXbZqMmWnU4CoUCqmmDSaP/fIvJhcuUG2waenOXG+YBqF0XQEMgOECJ/zXdL++2TSQsdrlzV3j1HgqAV2QCmf1tJ9mc1GSTBV24/eeqdBTQPk/PPwFWIk4zS+DG0et9gqWWEJmYv5oVoSDUcKwEMRjh0L+ZWS/w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1748692380; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=r0zae7oBE4TZBjI7YyNtdXcZ/puNeLxBgQH4NeeIAg8=; 
	b=NHxD/Bu5t3lml53YH72wlSEolzSA5FGY9m91+MG/UfjV5UEmf7Uy2camEhBm6S18wAZW6Y3mmMjuEmAwEDRltVhPyTQ74bCQtTlqiaiM2J2lxPcojjYS2VZV9qpD4AdXI1NbN3c/xezFb42lQ2FbByDgY0OsSETyc43DoKOaZHk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1748692380;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=r0zae7oBE4TZBjI7YyNtdXcZ/puNeLxBgQH4NeeIAg8=;
	b=Y7krZN4JqOiEa3AcmQBq4aCtUougTYblwweQ0tJ0Ek38QZ4JrfuxCfNOx/6tsY3K
	wG0vtOsIv2/5hPfYHPNFeXYa6z6Z5bh3/d7CwhVeXa2xdy+tAPBvWg7CQqeIxQi27pl
	BxQJhXVhPtwmDWuogTsZjh+3ighIaiw6m3xOmWa0=
Received: by mx.zohomail.com with SMTPS id 1748692378368831.198778188815;
	Sat, 31 May 2025 04:52:58 -0700 (PDT)
Message-ID: <71f1cf7c-eea9-44d8-8d56-28a507eef4ad@zohomail.com>
Date: Sat, 31 May 2025 19:52:54 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/1] cxl/edac: Fix the min_scrub_cycle of a region
 miscalculation
To: Alison Schofield <alison.schofield@intel.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 shiju.jose@huawei.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250530122852.10139-1-ming.li@zohomail.com>
 <aDn4o8Fw91vQ9D-D@aschofie-mobl2.lan>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <aDn4o8Fw91vQ9D-D@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr0801122751877404a3cf759f0557e87400001ad870fb3c8e3864193bf1168c444489a368d0f38bcafd791e:zu08011227ddc8d17ee9f4510022aa310d0000778f76ae4248828c73c47962e8088bb5576fa53c31f42ad0b6:rf0801122d05e50d11034d767c07780ed300007b10b88825f6e836f55fc0f6645f84769db0583111c49d41bb36acdc3470ba:ZohoMail
X-ZohoMailClient: External

On 5/31/2025 2:27 AM, Alison Schofield wrote:
> On Fri, May 30, 2025 at 08:28:52PM +0800, Li Ming wrote:
>> When trying to update the scrub_cycle value of a cxl region, which means
>> updating the scrub_cycle value of each memdev under a cxl region. cxl
>> driver needs to guarantee the new scrub_cycle value is greater than the
>> min_scrub_cycle value of a memdev, otherwise the updating operation will
>> fail(Per Table 8-223 in CXL r3.2 section 8.2.10.9.11.1).
>>
>> Current implementation logic of getting the min_scrub_cycle value of a
>> cxl region is that getting the min_scrub_cycle value of each memdevs
>> under the cxl region, then using the minimum min_scrub_cycle value as
>> the region's min_scrub_cycle. Checking if the new scrub_cycle value is
>> greater than this value. If yes, updating the new scrub_cycle value to
>> each memdevs. The issue is that the new scrub_cycle value is possibly
>> greater than the minimum min_scrub_cycle value of all memdevs but less
>> than the maximum min_scrub_cycle value of all memdevs if memdevs have
>> a different min_scrub_cycle value. The updating operation will always
>> fail on these memdevs which have a greater min_scrub_cycle than the new
>> scrub_cycle.
>>
>> The correct implementation logic is to get the maximum value of these
>> memdevs' min_scrub_cycle, check if the new scrub_cycle value is greater
>> than the value. If yes, the new scrub_cycle value is fit for the region.
>>
>> The change also impacts the result of
>> cxl_patrol_scrub_get_min_scrub_cycle(), the interface returned the
>> minimum min_scrub_cycle value among all memdevs under the region before
>> the change. The interface will return the maximum min_scrub_cycle value
>> among all memdevs under the region with the change.
>>
>> Signed-off-by: Li Ming <ming.li@zohomail.com>
>> ---
>> I made this change based on my understanding on the SPEC and current CXL
>> EDAC code, but I am not sure if it is a bug or it is designed this way.
> The attribute is defined to show (per Documentation/ABI/testing/sysfs-edac-scrub)
>    "Supported minimum scrub cycle duration in seconds by the memory scrubber."
>
> Your fix, making the min the max of the mins, looks needed.
>
> I took a look at the max attribute. If the min is the max on the mins, then
> the max should be the max of the maxes. But, not true. We do this:
>
> instead: *max = U8_MAX * 3600; /* Max set by register size */
>
> The comment isn't helping me, esp since the sysfs description doesn't
> explain that we are using a constant max.
>
CXL spec implies the max value is FFh. You can take a look at the Table 8-222 and Table 8-223 in CXL r3.2 section 8.2.10.9.11.1.


Ming

>> base-commit: 9f153b7fb5ae45c7d426851f896487927f40e501 cxl/next
>> ---
>>  drivers/cxl/core/edac.c | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
>> index 2cbc664e5d62..ad243cfe00e7 100644
>> --- a/drivers/cxl/core/edac.c
>> +++ b/drivers/cxl/core/edac.c
>> @@ -103,10 +103,10 @@ static int cxl_scrub_get_attrbs(struct cxl_patrol_scrub_context *cxl_ps_ctx,
>>  				u8 *cap, u16 *cycle, u8 *flags, u8 *min_cycle)
>>  {
>>  	struct cxl_mailbox *cxl_mbox;
>> -	u8 min_scrub_cycle = U8_MAX;
>>  	struct cxl_region_params *p;
>>  	struct cxl_memdev *cxlmd;
>>  	struct cxl_region *cxlr;
>> +	u8 min_scrub_cycle = 0;
>>  	int i, ret;
>>  
>>  	if (!cxl_ps_ctx->cxlr) {
>> @@ -133,8 +133,12 @@ static int cxl_scrub_get_attrbs(struct cxl_patrol_scrub_context *cxl_ps_ctx,
>>  		if (ret)
>>  			return ret;
>>  
>> +		/*
>> +		 * The min_scrub_cycle of a region is the maximum value among
>> +		 * the min_scrub_cycle of all the memdevs under the region.
>> +		 */
>>  		if (min_cycle)
>> -			min_scrub_cycle = min(*min_cycle, min_scrub_cycle);
>> +			min_scrub_cycle = max(*min_cycle, min_scrub_cycle);
>>  	}
>>  
>>  	if (min_cycle)
>> -- 
>> 2.34.1
>>

