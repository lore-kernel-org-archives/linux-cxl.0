Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85772171CD
	for <linux-cxl@vger.kernel.org>; Thu,  2 Apr 2026 10:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775125791; cv=pass; b=Q5HZWTIJS/UzlmByEZzOXivFAyZzOq9xqx3Vfw4G9WNVqs9Ur3y0FW71QJpRP/1dpPbhgvlGeQmPvRD3ewkIqbEvV/XbjnH2A7qhiiZUm1cI6Qxa1g7cLoYBo2mLd7uHtnUR0hMZ47RQqZgDSDqV2tTldIX2J1SyJj6NIuk1uCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775125791; c=relaxed/simple;
	bh=Q+a/xKe5eNA1ne+cV1nH4L2VnAJTk07nXN82LuaTim8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jWR3CMltsn8Vzds7+2++OBHGZ1717NYdI15ixeWUaK38vImGCIorJz1ggjPxiJ3cdyhJiI+jzpFxM99SxWXmFADTnuXgNqsPnTKInj3mms2iWnK+C/AlWQpPRCcexNS5APnzc9w9WeGee1cOFulurEHJxm/nEwQc8CRGQYnXOeU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=T8Y3SQaW; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="T8Y3SQaW"
ARC-Seal: i=1; a=rsa-sha256; t=1775125781; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=a3ogbccfDYKT2KvZ/UeTh8vTCeBmDeAhZ2fOahBKXbuBqGAJAHvmBQNOunVVL4gUX0XpJgm1P1MK30E4MlDQ5DqoQP1JLXunn5mWrNZBAx7Q2DQSEAxpbuaj0JE+6E2Suj+7I4aInMkYxhaFNJ/UArDk4sJx0aYYbu1XeAvy2yU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1775125781; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=nf8C0bI1OP6yqtVtrRRPQSrLjTgwog5FtA1ezw0IHlw=; 
	b=BcBPbcZdZRn+GewknhnbUndMOrfdR8LCfOt0AR7/ljn2Fg52MewZZ2GrgB9OWLsSyiVHsg2Onhbg5LeHqPZqZ1y0W6ZwmE8IMJqHCamjlUjsGk3it1ad0+SBFt8ANfKShVa4jlirAyr67etwbUBpN0TyVKB2VKvzwfwPm180jGQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775125781;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=nf8C0bI1OP6yqtVtrRRPQSrLjTgwog5FtA1ezw0IHlw=;
	b=T8Y3SQaWYZm+4Ysp9SqE0ezIeoWgWoQlb7OvuQFqJRujeXd2SASHds/uDLF7slBi
	tenMFKykoEAep/1cF6pD994iYuSUJR6v0bIL/FxonlcY8V/XDG+I6SP4BtG3czQktDX
	/2RCAxoRQndIFGgs9pvCMDeObRkpIWsNSSOGnT60=
Received: by mx.zohomail.com with SMTPS id 1775125779074418.60612082314617;
	Thu, 2 Apr 2026 03:29:39 -0700 (PDT)
Message-ID: <e29eab5f-2a28-4bd8-838e-041d148cd441@zohomail.com>
Date: Thu, 2 Apr 2026 18:29:26 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ndctl PATCH v2 1/1] ndctl/cxl: Show region locked status to user
To: Alison Schofield <alison.schofield@intel.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 linux-cxl@vger.kernel.org
References: <20260401124205.1288996-1-ming.li@zohomail.com>
 <ac1snnLIKRO7EzkM@aschofie-mobl2.lan>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <ac1snnLIKRO7EzkM@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: rr080112289a2a415b1fbb75fe11974c47000014aa3b42cb5cc6e846b0bda68f2daa597fa71e9db3109ff7f16c:zu080112272c84c5deb980deadcba981d000008bc60935b86ecf717c721512a7b64871e837fe294a76d79eaa:rf0801122d2661da1f90f392aadeb2ee5b0000e2f8b6c80142ddb0a8078e527a97cf37773cd2ab9bf47db7388574b0049dd1:ZohoMail
X-ZohoMailClient: External


在 2026/4/2 03:06, Alison Schofield 写道:
> On Wed, Apr 01, 2026 at 08:42:05PM +0800, Li Ming wrote:
>> A region is not allowed to be destroyed if it is in locked status.
>> cxl destroy-region command will fail and ask user to try it again as
>> root, but it is not the real reason and it will confuse user if user is
>> already a root user. This patch will show the region locked status in
>> region information and output an explicit log to user that operation is
>> not permitted like below.
>>
>> Before the patch:
>> cxl list -ir region0
>> [
>>    {
>>      "region":"region0",
>>      "resource":53955526656,
>>      "size":536870912,
>>      "type":"ram",
>>      "interleave_ways":2,
>>      "interleave_granularity":256,
>>      "decode_state":"commit",
>>      "state":"disabled",
>>      "qos_class_mismatch":true
>>    }
>> ]
>>
>> cxl destroy-region region0
>> libcxl: write_attr: failed to write 0
>>   to /sys/bus/cxl/devices/root0/decoder0.0/region0/commit: Operation not permitted hint: try running as root or using sudo
>> cxl region: destroy_region: region0: failed to reset decode: Operation not permitted
>> cxl region: decoder_region_action: region0: failed: Operation not permitted
>> cxl region: region_action: one or more failures, last failure: Operation not permitted
>> cxl region: cmd_destroy_region: destroyed 0 regions
>>
>> After the patch:
>> cxl list -ir region0
>> [
>>    {
>>      "region":"region0",
>>      "resource":53955526656,
>>      "size":536870912,
>>      "type":"ram",
>>      "interleave_ways":2,
>>      "interleave_granularity":256,
>>      "decode_state":"commit",
>>      "state":"disabled",
>>      "locked":true,
>>      "qos_class_mismatch":true
>>    }
>> ]
>>
>> cxl destroy-region region0
>> cxl region: destroy_region: region0: Cannot destroy a locked region.
>> cxl region: decoder_region_action: region0: failed: Operation not permitted
>> cxl region: region_action: one or more failures, last failure: Operation not permitted
>> cxl region: cmd_destroy_region: destroyed 0 regions
> Sorry Ming, I missed previously-
>
> This always emits "locked":false on kernels without the new sysfs
> attribute. Please make it skip the emit in that case.

Hi Alison, the case you mentioned requires an extra interface 
implementation for checking the new sysfs attribute exists. Or a new 
variable to represent if the new attribute exists.

How about just skpping the emit when locked == false? It works for both 
no the new sysfs attribute and the region is not locked cases.


Ming

>
>> Signed-off-by: Li Ming <ming.li@zohomail.com>
>> ---
>> v2:
>> * Move lock status checking to the beginning of destroy_region().
>>    (Alison)
>> ---
>>   cxl/json.c         |  4 ++++
>>   cxl/lib/libcxl.c   | 11 +++++++++++
>>   cxl/lib/libcxl.sym |  5 +++++
>>   cxl/lib/private.h  |  1 +
>>   cxl/libcxl.h       |  1 +
>>   cxl/region.c       |  6 ++++++
>>   6 files changed, 28 insertions(+)
>>
>> diff --git a/cxl/json.c b/cxl/json.c
>> index a0dc343..3bbe07a 100644
>> --- a/cxl/json.c
>> +++ b/cxl/json.c
>> @@ -1077,6 +1077,10 @@ struct json_object *util_cxl_region_to_json(struct cxl_region *region,
>>   			json_object_object_add(jregion, "state", jobj);
>>   	}
>>   
>> +	jobj = json_object_new_boolean(cxl_region_is_locked(region));
>> +	if (jobj)
>> +		json_object_object_add(jregion, "locked", jobj);
>> +
>>   	if (flags & UTIL_JSON_MEDIA_ERRORS) {
>>   		jobj = util_cxl_poison_list_to_json(region, NULL, flags);
>>   		if (jobj)
>> diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
>> index 5e8deb6..ce2b364 100644
>> --- a/cxl/lib/libcxl.c
>> +++ b/cxl/lib/libcxl.c
>> @@ -472,6 +472,11 @@ CXL_EXPORT int cxl_region_is_enabled(struct cxl_region *region)
>>   	return is_enabled(path);
>>   }
>>   
>> +CXL_EXPORT bool cxl_region_is_locked(struct cxl_region *region)
>> +{
>> +	return region->locked;
>> +}
>> +
>>   CXL_EXPORT bool cxl_region_qos_class_mismatch(struct cxl_region *region)
>>   {
>>   	struct cxl_decoder *root_decoder = cxl_region_get_decoder(region);
>> @@ -689,6 +694,12 @@ static void *add_cxl_region(void *parent, int id, const char *cxlregion_base)
>>   	if (sysfs_read_attr(ctx, path, buf) == 0)
>>   		region->module = util_modalias_to_module(ctx, buf);
>>   
>> +	sprintf(path, "%s/locked", cxlregion_base);
>> +	if (sysfs_read_attr(ctx, path, buf) < 0)
>> +		region->locked = false;
>> +	else
>> +		region->locked = strtoul(buf, NULL, 0);
>> +
>>   	cxl_region_foreach_safe(decoder, region_dup, _r)
>>   		if (region_dup->id == region->id) {
>>   			list_del_from(&decoder->regions, &region_dup->list);
>> diff --git a/cxl/lib/libcxl.sym b/cxl/lib/libcxl.sym
>> index 797e398..7c586f4 100644
>> --- a/cxl/lib/libcxl.sym
>> +++ b/cxl/lib/libcxl.sym
>> @@ -315,3 +315,8 @@ global:
>>   	cxl_memdev_clear_poison;
>>   	cxl_debugfs_exists;
>>   } LIBCXL_10;
>> +
>> +LIBCXL_12 {
>> +global:
>> +	cxl_region_is_locked;
>> +} LIBCXL_11;
>> diff --git a/cxl/lib/private.h b/cxl/lib/private.h
>> index 582eebf..d074122 100644
>> --- a/cxl/lib/private.h
>> +++ b/cxl/lib/private.h
>> @@ -189,6 +189,7 @@ struct cxl_region {
>>   	u64 start;
>>   	u64 size;
>>   	u64 cache_size;
>> +	bool locked;
>>   	unsigned int interleave_ways;
>>   	unsigned int interleave_granularity;
>>   	enum cxl_decode_state decode_state;
>> diff --git a/cxl/libcxl.h b/cxl/libcxl.h
>> index a853ab6..6ff58de 100644
>> --- a/cxl/libcxl.h
>> +++ b/cxl/libcxl.h
>> @@ -353,6 +353,7 @@ int cxl_region_clear_all_targets(struct cxl_region *region);
>>   int cxl_region_decode_commit(struct cxl_region *region);
>>   int cxl_region_decode_reset(struct cxl_region *region);
>>   bool cxl_region_qos_class_mismatch(struct cxl_region *region);
>> +bool cxl_region_is_locked(struct cxl_region *region);
>>   
>>   #define cxl_region_foreach(decoder, region)                                    \
>>   	for (region = cxl_region_get_first(decoder); region != NULL;           \
>> diff --git a/cxl/region.c b/cxl/region.c
>> index 207cf2d..8a85522 100644
>> --- a/cxl/region.c
>> +++ b/cxl/region.c
>> @@ -837,6 +837,12 @@ static int destroy_region(struct cxl_region *region)
>>   	unsigned int ways, i;
>>   	int rc;
>>   
>> +	if (cxl_region_is_locked(region)) {
>> +		log_err(&rl, "%s: Cannot destroy a locked region.\n",
>> +			devname);
>> +		return -EPERM;
>> +	}
>> +
>>   	/* First, unbind/disable the region if needed */
>>   	if (cxl_region_is_enabled(region)) {
>>   		if (param.force) {
>> -- 
>> 2.43.0
>>
