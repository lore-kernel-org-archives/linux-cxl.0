Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80ED23D2A8;
	Wed,  9 Jul 2025 07:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752045212; cv=pass; b=BZHiSitteqgs6w8QuBuAGWkqEbDZ7lUWOusYzhTFtGVtCwttZABPExPEEtd0z10A5KBk97Rp0TeYhnuyOyvBleHl5BH3evvSH72lvxyS4S/1L6gOQOvDtW6EgNzVUYHN13x0IbcdaVkmdUPDuBAodgr2BJYfiwwBk7UgESB/0aA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752045212; c=relaxed/simple;
	bh=q+8kEUFKOe/AKuTRv4NGUZZO/epcQtr/DUmBVoSmhpk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DGmTJ1SR3Crkbx9g/UHY9dK58cCX0snNYzyVkiCne7xtiTGlgqmpcGNcCpbpRyQBlurULTk95Py54XoXDsszzzmeO7JDHwnF1Lt+cCQ+RHAOAIOsXeq9uNyFkuZLnRQBozejIBU89ye2tvNCfwIs3TiR0HJ9fLuP1qQQVABjNv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=Qg8gTY2z; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="Qg8gTY2z"
ARC-Seal: i=1; a=rsa-sha256; t=1752045197; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=VrGL00rSnZWsEe4N7esptw4fm+gl31/S0FzTLFCOR7MyIMpnwcp8mQZ2vlIb6mGT3RY9kp/1HdycGRGoveSGm40MsbZCPSVp9Sq8dWeumEB5t/l4JCk4g/I6Nkkckr0AhjNgzE4bpDAcX3jxJYfyRQVK1qNAPkojiMZkls1l1J4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752045197; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=wHiqZyuTgPxzdXyYfuv3UPD8orqV8Nu2TK8I32/j/G8=; 
	b=K1r2LKszC0dAZi/YRoSK5vjSb8+Gm8wQqUtkunGJpD1IChSZ6Q6TwZBDyvSURCOEZX2NmwGnxSSLowUDq7H+Mm/piIETu6RkGXClEWwj7UcCemiEQLNNUtjFNbPlujG0GDnkayHmqmpKdzSDBx9zPF3oQkqU6vnkyTPy//M4ZII=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752045197;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=wHiqZyuTgPxzdXyYfuv3UPD8orqV8Nu2TK8I32/j/G8=;
	b=Qg8gTY2z/Vt6feMcSXrbJ7RW+BSLDsvL5o3dVtthTAHkEo5xOQUTMyQ+5qomvqLp
	GCHDTCEmbbxyCjfetqJCpHmmR6K2MeJT7wF8ZeSgm85v+BkMk5/lB1+nI9tKYSN9nd4
	W8FYoQZjTJ5JHP1O2/n0YgAsDVfYgN654uxUpDjE=
Received: by mx.zohomail.com with SMTPS id 1752045195118841.5038900262972;
	Wed, 9 Jul 2025 00:13:15 -0700 (PDT)
Message-ID: <86bcfb22-f9e7-4b2a-a51b-d8d63d423fcc@zohomail.com>
Date: Wed, 9 Jul 2025 15:13:09 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] cxl/edac: Fix wrong dpa checking for PPR operation
To: Alison Schofield <alison.schofield@intel.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 shiju.jose@huawei.com, andriy.shevchenko@linux.intel.com,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250708051536.92119-1-ming.li@zohomail.com>
 <20250708051536.92119-3-ming.li@zohomail.com>
 <aG3I9ooPm0eJnMPn@aschofie-mobl2.lan>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <aG3I9ooPm0eJnMPn@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr080112276557fa28b7021264f2e8d91000004c12bdf5733af7bb711d0b54f5dd71f5d2f6b8c8fd28096c90:zu08011227b142ed5d17c63be61cf5659600003121704cbb81ca4af9ae61ba2ee5d273286914cd85c86b2e8f:rf0801122d3604bdcbcb47a2d032448b100000e7f69e1d853b41f2ab6ac607679ef88887ab7517ea8b7b95651c0467b58c63:ZohoMail
X-ZohoMailClient: External

On 7/9/2025 9:42 AM, Alison Schofield wrote:
> On Tue, Jul 08, 2025 at 01:15:35PM +0800, Li Ming wrote:
>> DPA 0 is considered invalid in cxl_do_ppr(), but per Table 8-143. "Get
>> Partition Info Output Payload" in CXL r3.2 section 8.2.10.9.2.1 "Get
>> Partition Info(Opcode 4100h)", it mentions that DPA 0 is a valid address
>> of a CXL device. So the correct implementation should be checking if the
>> DPA is in the DPA range of the CXL device rather than checking if the
>> DPA is equal to 0.
>>
> If it needs a fixes tag, doesn't it also need a user visible impact
> statement? I get that the PPR won't happen. What does that look like
> to the user? Is there a user level error message we can add to the
> commit log?
>
> With that, you can add:
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
>
Will do. Thanks.


Ming

>
>> Fixes: be9b359e056a ("cxl/edac: Add CXL memory device soft PPR control feature")
>> Signed-off-by: Li Ming <ming.li@zohomail.com>
>> Tested-by: Shiju Jose <shiju.jose@huawei.com>
>> Reviewed-by: Shiju Jose <shiju.jose@huawei.com>
>> ---
>>  drivers/cxl/core/edac.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
>> index 623aaa4439c4..1cf65b1538b9 100644
>> --- a/drivers/cxl/core/edac.c
>> +++ b/drivers/cxl/core/edac.c
>> @@ -1923,8 +1923,11 @@ static int cxl_ppr_set_nibble_mask(struct device *dev, void *drv_data,
>>  static int cxl_do_ppr(struct device *dev, void *drv_data, u32 val)
>>  {
>>  	struct cxl_ppr_context *cxl_ppr_ctx = drv_data;
>> +	struct cxl_memdev *cxlmd = cxl_ppr_ctx->cxlmd;
>> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>>  
>> -	if (!cxl_ppr_ctx->dpa || val != EDAC_DO_MEM_REPAIR)
>> +	if (!resource_contains_addr(&cxlds->dpa_res, cxl_ppr_ctx->dpa) ||
>> +	    val != EDAC_DO_MEM_REPAIR)
>>  		return -EINVAL;
>>  
>>  	return cxl_mem_perform_ppr(cxl_ppr_ctx);
>> -- 
>> 2.34.1
>>

