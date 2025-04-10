Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E776E1F930;
	Thu, 10 Apr 2025 01:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744246956; cv=pass; b=eWc1hgx06DsHU3xJFHSJyALsrCflF0UacJ/jdOC89/1IJWDIr5qSVd0jfJ3ONXM3FaaxqOEPilbRTOrGgM3Ul89+sfV0PVVqdcm+uDWOTDI3OHHIfFZ2l3RnOGKkVBP/Aj3Q9hDqBCNFx+OIvs3Q74l467nbE0uadNfh8yNv5VI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744246956; c=relaxed/simple;
	bh=MrxcKYFtfSYZKLYuEYQVdxRMiWDquY/naspmGHw0tVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eH+In2ZGp0Xa3jlpG5XHgrqqsgvEYof2ZmYPEMvjQJkEntKzNmLN9o2wgAhTjOdZQBovJ+nAZMQ17piK1C9YWbl+pM5bW76hcdgu2iKh4FYIlr4gokz5Shn03oCyw8Nfd1kOzom/BqzYjwOwu+QqBFvZLGcksB3JEK5rbnnEja4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=RYoVyMEZ; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="RYoVyMEZ"
ARC-Seal: i=1; a=rsa-sha256; t=1744246941; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=f2oqtgtEIj7w+ItXf9V4BDfwS+ugN8MiAC3IMibGEZ+k+QJsFSXwn/BX5C/2fumA+/eOT4RhYyniWAyCk7txALtAahKuYLKzsgVZjX/CX0XrUC1MQBZrqVjG3mIvxNz0g4iqoNg+NV2jAQuVdELs5yVqA7NyxqRgjFSRs9xkAxQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1744246941; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=OLgUik1lavsa4dvzL1XWz9uETF9zNws6mzgEbiJosDU=; 
	b=B2Af/dczb5l7H2eFyLbkmcRPdllPRjChGPZpgGr4ixUm0KFzL5O54FFotFnkwMm2uWIBluSus6PTfuosqpmfoqRkahojTw3YSHOL/J/oXhfHm1o0SAkEO+47fwRROHUhpNHMRivSuu8vtjmTv320AAiZgFIV1WWF5RAT4jJEDT4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1744246941;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=OLgUik1lavsa4dvzL1XWz9uETF9zNws6mzgEbiJosDU=;
	b=RYoVyMEZqPAhpXq9QoGMnIrCpfu5erE7DQodbwx64GL7dUo8yW0rJpUcK228HHXq
	hpFZPeb1OssCHtFheKFmriN47K8NlBg3ZH4lShg27CcH4WhBeFrl0YpFVQLdvK+mLAO
	Vk0pD1WqFV6XzOV8Z1bW3962w6oxmJgp92TowcSg=
Received: by mx.zohomail.com with SMTPS id 1744246927063883.6331792523235;
	Wed, 9 Apr 2025 18:02:07 -0700 (PDT)
Message-ID: <6bfb9815-0270-41e5-95c3-7ecefe8d46f4@zohomail.com>
Date: Thu, 10 Apr 2025 09:02:04 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] cxl/feature: Update out_len in set feature failure
 case
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 dave@stgolabs.net, jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com
References: <20250409022521.510146-1-ming.li@zohomail.com>
 <1be19059-e879-4404-a68a-10093fef7522@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <1be19059-e879-4404-a68a-10093fef7522@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Feedback-ID: rr08011227992645d5d2c7868c64dd78f10000e9006b009f7b49c9a435aebfb3330aba26f303c7659b66c985:zu080112270e4f283cd5b666dda86c7fb100006255011d5eb43def78a455df14279ec3107627889034eb23ea:rf0801122d72bc644ccb62eab6600b0df0000020babff4686c6ca42bb0e13137bf51fedcf0e20be1ae287ac0b3484e52019f:ZohoMail
X-ZohoMailClient: External

On 4/9/2025 11:37 PM, Dave Jiang wrote:
>
> On 4/8/25 7:25 PM, Li Ming wrote:
>> CXL subsystem supports userspace to configure features via fwctl
>> interface, it will configure features by using Set Feature command.
>> Whatever Set Feature succeeds or fails, CXL driver always needs to
>> return a structure fwctl_rpc_cxl_out to caller, and returned size is
>> updated in a out_len parameter. The out_len should be updated not only
>> when the set feature succeeds, but also when the set feature fails.
> Good catch! Can you add a Fixes tag please? Otherwise 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>、

Yes, forgot to add a Fixes tag. Thanks for that.


Ming

>
>> Signed-off-by: Li Ming <ming.li@zohomail.com>
>> ---
>> base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8 v6.15-rc1
>>
>> v2:
>> - Adjust changelog
>> ---
>>  drivers/cxl/core/features.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
>> index f4daefe3180e..066dfc29a3dd 100644
>> --- a/drivers/cxl/core/features.c
>> +++ b/drivers/cxl/core/features.c
>> @@ -528,13 +528,13 @@ static void *cxlctl_set_feature(struct cxl_features_state *cxlfs,
>>  	rc = cxl_set_feature(cxl_mbox, &feat_in->uuid,
>>  			     feat_in->version, feat_in->feat_data,
>>  			     data_size, flags, offset, &return_code);
>> +	*out_len = sizeof(*rpc_out);
>>  	if (rc) {
>>  		rpc_out->retval = return_code;
>>  		return no_free_ptr(rpc_out);
>>  	}
>>  
>>  	rpc_out->retval = CXL_MBOX_CMD_RC_SUCCESS;
>> -	*out_len = sizeof(*rpc_out);
>>  
>>  	return no_free_ptr(rpc_out);
>>  }


