Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A51F2DCF68;
	Thu,  3 Jul 2025 09:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751536696; cv=pass; b=tJWTNzItCdo3IKd5CgWhofkDU8kBHFW9KGYfHzUuxEdC4TQt4bWdwIiKyg4LobIJvXqg/ONMg2SN1RKKozMzSDDfLLZVWfCxaXNDpgoyfEebe/awf3sZZjvYFdtrhlpGUOpJS/LS33Ne5vfIT4qIsNUbulD1T0sqWsfd8af/JgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751536696; c=relaxed/simple;
	bh=QszsUgJLo/UJjAndQFyfJ5j/AC0XpvklEA8TpJmTGjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sZsEN1W7YNMshgKknzcSUcttp9TuzfQ4KQWhrQtNs4gc8we2cHtnnrZgvsz0P9MlTgCXznnHFDA7dcKfVyiN1GL01dLJ53a+bwxbkwyOD8YXyxOdvHYPViDmCFVEkNWPtFegBV3u++L9u0SUZIaUlf0bBoIIQy3rHDvU9YqFaMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=QWPPiOek; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="QWPPiOek"
ARC-Seal: i=1; a=rsa-sha256; t=1751536677; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=YrLvbcgSsnKveQfU/T7HKFQ1Ne5kco8X25ntrr1jkuGMZe6BXiy9kzgpG1UjBogCLdJgMdcnJzmM2ogQ+zsfMsxqcbm8KPs8uPmmy0m9omxjG7n+vw9eXOsPkVEEc0pyT2iJkXQGR49lHJlPXXe7yH37H9I4Zqt8f3oCIkXPno4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1751536677; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=vXsCgkX+jIyjyDWv3KCUQOrDI+B7GkZ6YSr93YGOphA=; 
	b=PczccBgUEkknhZ2B2B3eCWiMNGav6oHm4WFOciMA8SMLqDu1Gl2La7eOToYweN4VPI1e8reSyjn5fsFkVFg8ye3hN6si8tTMiKVALin9sepUAeaTFL4EJ1ZJNTGR4Gdj89Wn4IY9B93iY48/4RNUGUVslBf9aySZeYwa2i0hoV0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1751536677;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=vXsCgkX+jIyjyDWv3KCUQOrDI+B7GkZ6YSr93YGOphA=;
	b=QWPPiOekWWd1Jx9fh6jPe0O+QFfITG7dY8vM6x2SQf/SVS1ByKXkYySYtyBxXQXs
	RjljTpH2PMQ85HEfNUEwia/pqBvyJKNYBhKwLEZY7MI3zJkFt59YdYcGNNmxnBCZfua
	HXMDgATzthFSvmxxtPVVcuHtRZMc86RlHGuh/vq0=
Received: by mx.zohomail.com with SMTPS id 1751536675965912.8846049878568;
	Thu, 3 Jul 2025 02:57:55 -0700 (PDT)
Message-ID: <02ce91ae-9ebb-4f79-b5d5-4f7463596eef@zohomail.com>
Date: Thu, 3 Jul 2025 17:57:51 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] cxl/edac: Fix wrong dpa checking for PPR operation
To: Alison Schofield <alison.schofield@intel.com>
Cc: akpm@linux-foundation.org, andriy.shevchenko@linux.intel.com,
 bhelgaas@google.com, ilpo.jarvinen@linux.intel.com, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com, vishal.l.verma@intel.com,
 ira.weiny@intel.com, dan.j.williams@intel.com, shiju.jose@huawei.com,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250702072008.468371-1-ming.li@zohomail.com>
 <20250702072008.468371-2-ming.li@zohomail.com>
 <aGWKsBYX2kux7w9W@aschofie-mobl2.lan>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <aGWKsBYX2kux7w9W@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Feedback-ID: rr080112274fcd7691f01259b96b87ae370000691350233a52406932514c4990707acdb09b1d91521a407dbc:zu080112273fe35d8a2bb41c2b1c520bd700008120b5b9fa42cab822e4c0dd0cb0aeeb87d8701fe84cebab91:rf0801122de828932ffda4b63597df500e000034cdc63354886784e6c87db9b40ad20cd389cef7d3d73ed27d81915362fd04:ZohoMail
X-ZohoMailClient: External

On 7/3/2025 3:38 AM, Alison Schofield wrote:
> On Wed, Jul 02, 2025 at 03:20:07PM +0800, Li Ming wrote:
>> DPA 0 is considered invalid in cxl_do_ppr(), but per Table 8-143. "Get
>> Partition Info Output Payload" in CXL r3.2 section 8.2.10.9.2.1 "Get
>> Partition Info(Opcode 4100h)", it mentions that DPA 0 is a valid address
>> of a CXL device. So the correct implementation should be checking if the
>> DPA is in the DPA range of the CXL device rather than checking if the
>> DPA is equal to 0.
>>
>> Fixes: be9b359e056a ("cxl/edac: Add CXL memory device soft PPR control feature")
>> Signed-off-by: Li Ming <ming.li@zohomail.com>
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
> Hi Ming,
>
> I think this one needs a user visible impact statement.
>
> I'm hoping the broader helper gets accepted. That may be the ioport.h
> addition, or maybe we end up with a CXL special helper.
>
> However, if this patch is aiming to go upstream as a FIX in a 6.16 rc,
> then we are probably better off fixing the check inline right here, and
> then you follow on with the other 2 patches to be considered for the
> next merge window.
>
> Please share that impact and suggest whether it can wait for next merge
> window.
>
> -- Alison
>
Hi Alison,


I think the impact of this issue is limited, because the issue is inside CXL edac part, just causes that user cannot issue PPR maintenance operation for the DPA 0 of a CXL device. (A PPR maintenance operation requests the CXL device to perform a repair operation on its media.)

I am not sure if cxl subsystem will have another fixes PR for 6.16 rc, my understanding is that it is not worth to submit an additional PR only for this issue. So  I think merging it in next merge window is also good.


Ming

>>  
>>  	return cxl_mem_perform_ppr(cxl_ppr_ctx);
>> -- 
>> 2.34.1
>>

