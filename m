Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8822F4317;
	Thu, 12 Jun 2025 01:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749690372; cv=pass; b=n+66bCCD72whq/9Jrr8XpSYVVmxNoAPW8ulOuFKe6KEP+byyk1Lw59kxo08z8vxSCH023cQrZ1SO0Qbin6uU33qHvVa4DvBp4LAdLGRk7WWgr+A9LcDMMjgdejr7vpyLs6a+hpZJTQyLWSPCqSD13Iw0urO3swo0xQ65BCiR9f0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749690372; c=relaxed/simple;
	bh=qcBIqiqgEqNH/gAPwyki31podD2iALIdvmiSORhj25M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RI0GTu0u2oaHqnxpiiaiKJCIO2NsqqfBYWsrTHhC3yxUXXf62q8Dg90lIrfwuu9cguzLR9S4Y7tFpLu7+X/lHLGM/cYZNXvZdgl9VOOQ74miUIdQo+9Fy/BWTIUWgnfZuh41E1KhP7kTwkAXznf5T0tryRvjPZkvqfgp4EsETyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=QQ4ix1aF; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="QQ4ix1aF"
ARC-Seal: i=1; a=rsa-sha256; t=1749690354; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=QGrkd0TbS0wHtqyyAzdMtBrwvMRO++hZkCzbXATFl1Yep3BmyJsCzQLHcZjiK0EF4UWep43fTd/U9PizBj3PH8zCVhLZohCm5GhA3Pzs7V5jcYUSLzHvRi2zldULZH5w2sXyD9dmytfNJjWE13p9KHD/S1+3dJIR3Jv1o6cnDjo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1749690354; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=yXPXKnGzInWurD7QEHdOaP9i4/7gqwiuKjJcRldQdpM=; 
	b=O2lHMC7G9a6NTLDAnDMmWNE+Qoz/MOBCvJvvfn5BVN9umaQ+AOYa6ObvewuPWC6+gqlLeZ/1Lds/hJGd9GPes5VyhJCtESz01xyltqhTXuLxTMUfUGUL2jZaYd4mo+al0qRN2/Qcb8pVhT9B1QfEs5FvV0+v00Oyhb4ZoeeJXwI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1749690354;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=yXPXKnGzInWurD7QEHdOaP9i4/7gqwiuKjJcRldQdpM=;
	b=QQ4ix1aFCQlZ3amEGOmIIKY9y52SgSqd8xY6gmdEbvD1bMkCndLKBy9LW/nLa4BJ
	pNkxf5IKcsMN8I5iM25COuL1G+mRbC6NrfF13048aL4LNsB/GEdFfcIeMQp1yYHIfkn
	mmCqf5RsJVeL6ELezRaKqNAkSPTS/vZZm6gYz2Io=
Received: by mx.zohomail.com with SMTPS id 1749690352799475.5882412202018;
	Wed, 11 Jun 2025 18:05:52 -0700 (PDT)
Message-ID: <cd89c81f-2a9d-4b3f-94e9-c30471410686@zohomail.com>
Date: Thu, 12 Jun 2025 09:05:50 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] cxl/edac: Fix potential memory leak issues
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: dave@stgolabs.net, dave.jiang@intel.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 shiju.jose@huawei.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250611033542.96184-1-ming.li@zohomail.com>
 <20250611141637.0000546b@huawei.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20250611141637.0000546b@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr08011227b61ce302fb3409d8faf691710000c7ad5a556caf45c5a187b173ebc0277256b2016849b8b01c55:zu08011227fb3cb49cab3d2a682c7d6eb7000092b3cdcb4d67516b8f2f6933e54fecd6a922c0598868ba5653:rf0801122db16c54944d6be6cd8f4e9ab60000f3303566aec7bbbc566e8b68cdcac3d92c456301bdfbef689d490751763828:ZohoMail
X-ZohoMailClient: External

On 6/11/2025 9:16 PM, Jonathan Cameron wrote:
> On Wed, 11 Jun 2025 11:35:42 +0800
> Li Ming <ming.li@zohomail.com> wrote:
>
>> In cxl_store_rec_gen_media() and cxl_store_rec_dram(), use kmemdup() to
>> duplicate a cxl gen_media/dram event to store the event in a xarray by
>> xa_store(). The cxl gen_media/dram event allocated by kmemdup() should
>> be freed in the case that the xa_store() fails.
>>
>> Fixes: 0b5ccb0de1e2 ("cxl/edac: Support for finding memory operation attributes from the current boot")
>> Signed-off-by: Li Ming <ming.li@zohomail.com>
> Good fine but I'm not sure this is the best fix.
>
>> ---
>> base-commit: 87b42c114cdda76c8ad3002f2096699ad5146cb3 cxl/fixes
>> ---
>>  drivers/cxl/core/edac.c | 10 ++++++----
>>  1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
>> index 2cbc664e5d62..b4c5c23a45d4 100644
>> --- a/drivers/cxl/core/edac.c
>> +++ b/drivers/cxl/core/edac.c
>> @@ -1086,13 +1086,13 @@ static void cxl_del_overflow_old_recs(struct xarray *rec_xarray)
>>  int cxl_store_rec_gen_media(struct cxl_memdev *cxlmd, union cxl_event *evt)
>>  {
>>  	struct cxl_mem_err_rec *array_rec = cxlmd->err_rec_array;
>> -	struct cxl_event_gen_media *rec;
>>  	void *old_rec;
>>  
>>  	if (!IS_ENABLED(CONFIG_CXL_EDAC_MEM_REPAIR) || !array_rec)
>>  		return 0;
>>  
>> -	rec = kmemdup(&evt->gen_media, sizeof(*rec), GFP_KERNEL);
>> +	struct cxl_event_gen_media *rec __free(kfree) =
>> +		kmemdup(&evt->gen_media, sizeof(*rec), GFP_KERNEL);
>>  	if (!rec)
>>  		return -ENOMEM;
>>  
>> @@ -1106,6 +1106,7 @@ int cxl_store_rec_gen_media(struct cxl_memdev *cxlmd, union cxl_event *evt)
>>  
>>  	cxl_del_expired_gmedia_recs(&array_rec->rec_gen_media, rec);
>>  	cxl_del_overflow_old_recs(&array_rec->rec_gen_media);
>> +	retain_and_null_ptr(rec);
>>  
>>  	return 0;
>>  }
>> @@ -1114,13 +1115,13 @@ EXPORT_SYMBOL_NS_GPL(cxl_store_rec_gen_media, "CXL");
>>  int cxl_store_rec_dram(struct cxl_memdev *cxlmd, union cxl_event *evt)
>>  {
>>  	struct cxl_mem_err_rec *array_rec = cxlmd->err_rec_array;
>> -	struct cxl_event_dram *rec;
>>  	void *old_rec;
>>  
>>  	if (!IS_ENABLED(CONFIG_CXL_EDAC_MEM_REPAIR) || !array_rec)
>>  		return 0;
>>  
>> -	rec = kmemdup(&evt->dram, sizeof(*rec), GFP_KERNEL);
>> +	struct cxl_event_dram *rec __free(kfree) =
>> +		kmemdup(&evt->dram, sizeof(*rec), GFP_KERNEL);
>>  	if (!rec)
>>  		return -ENOMEM;
>>  
>> @@ -1134,6 +1135,7 @@ int cxl_store_rec_dram(struct cxl_memdev *cxlmd, union cxl_event *evt)
>>  
>>  	cxl_del_expired_dram_recs(&array_rec->rec_dram, rec);
>>  	cxl_del_overflow_old_recs(&array_rec->rec_dram);
>> +	retain_and_null_ptr(rec);
> I'd move this up to immediately after we hand it over to the xa successfully.
>
> Actually I'm not sure this is a good use of __free given we have a single
> error path to handle it in and have to manually release it in a different
> call to where it is passed to the xa_store() function.  Maybe better
> to just kfree in the error path.

Sure, I can do that, using kfree directly instead of the __free(kfree). Thanks for reviewing.


Ming

>
>
>>  
>>  	return 0;
>>  }


