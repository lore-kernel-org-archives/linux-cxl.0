Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.94
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793858574;
	b=Awx8QufYUYtBQNJkaPDXo7pM/ZloZwvMarXIxFS9wfIkRBa8N49iR7gglhtdx7bso5U7
	 Q3XBUJys9viOv8Gea+Nn2cIEAbJJACy0hD6wLuW+HAoouUx0BxDZs7CxBUo87vukqNJJF
	 GJMv5JQlTqcj6bkG88iJ00thkCyKaCTOgJJrzhevR6Mvt+dfvZTBdOssP5oOuc0TAZh8j
	 AptZQ1hJUZroujb9Oxsp+wvbcV2QZOvHWNCKZuLPXgFshd0TrcFqFR3lf97o+SFINlAuo
	 FMMiLtCjXjRTgKBclnt/lmQgMxJ/hsIfHDJXajamJPHlnWyNl+RzFMvuOQt5UOErgBw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793858574;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:Feedback-ID:X-Zoho-CM-AccountID:
	 X-ZohoMailClient;
	bh=Je+pxxclclWOzMYv/ZDExoy2DE7Cbpmv5nO2YtyInVE=;
	b=1RUDc2YoweenHyZiMPCFI3y1zdPGix58OxgDDccujxx7mDwZcDb1MJ/XFfu8EVYW3Meu
	 /vl9rOfRf7kNktZynP3F+emYnD41yaJjrYpudiLeb4QKW527Ogierq3OA6ZDUxIdqIIPa
	 skEWVOkzoBdMqeo/pM9om0XosHM6gE10MqSdn0FlW6OcfLl8GAfNt0hf3DJk6bOUOO3nN
	 s7EprNo874nbZCEf7QQFP4ijzOMkHyDlw6Fj13hCTTJMNN+t2MbCNHhkpfOlHEaTgbo5D
	 Mfcr8F2EN0TzUcczW/LGJvwLBb7CUYCjB4WwYs9U2LDjHQaibsziAPrFquc9sHkKH0w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zohomail.com;
	spf=pass smtp.mailfrom=zohomail.com;
	dkim=pass header.d=zohomail.com header.i=@zohomail.com header.a=rsa-sha256 header.s=zm2022 header.b=HE6Qx8Sl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.94
Received: from sender5-pp-o94.zoho.com (sender5-pp-o94.zoho.com [165.173.182.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D3F606A31B;
	Thu,  5 Nov 2026 06:02:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19D3F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=zohomail.com header.i=@zohomail.com header.a=rsa-sha256 header.s=zm2022 header.b=HE6Qx8Sl
ARC-Seal: i=1; a=rsa-sha256; t=1793858564; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=UUbtslUHyo7v+DmWQ0tAhKbZqTP2FV8d9FUucA/ZxPU6IJw0njakJItVKNA7zgNQ2iSwpjzw8n0IWUHFi483MFXlOjau1Md6xppRvZSfnnO0WS7Yv3spWU50DLdeawr/5W67qNMjEvHKGP5qUmTfH8UgOo7Umf5Rgh62jyeXWro=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1793858564; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Je+pxxclclWOzMYv/ZDExoy2DE7Cbpmv5nO2YtyInVE=; 
	b=A4T10RbgY25DZ1giPQssorpjxJaHiNEIVMlNVphMG6OV8MY4Esk9uQ1FWJcVp0XYj+cDaOEjh43y0HaVjlWayCQ22r+njl/0XCcHngBzVMesGYij2G2EdpSPboazWlJ30NUgyOH8eknast57iFWMr+UqtdvGnR5Yv6DgAnaxs64=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: a=rsa-sha256; b=HE6Qx8SlPEgjMHx4iVCgzSkyTI8+snmdIp7AqMjBprtohlRzGxr9gtZssPhXcRR/NV27qIaLWHHnrM4i8CHfRzKcIT3kD8B1rFIFvSD1lAfz6ED3DjLp1vg/7f/Iln+WdF6yteAxFZ784ai3GrI9abySImlX3AbakwTzWfzR0QY=; c=relaxed/relaxed; s=zm2022; d=zohomail.com; v=1; bh=Je+pxxclclWOzMYv/ZDExoy2DE7Cbpmv5nO2YtyInVE=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793858563308258.37950983087626;
	Wed, 4 Nov 2026 22:02:43 -0800 (PST)
Message-ID: <8a49b7c8-3be3-4c46-a5ee-6cdaefecea14@zohomail.com>
Date: Thu, 5 Nov 2026 14:02:37 +0800
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] cxl/mbox: Use mapped errno to determine command
 status
To: Alison Schofield <alison.schofield@intel.com>, dave@stgolabs.net
Cc: jic23@kernel.org, dave.jiang@intel.com, vishal.l.verma@intel.com,
 djbw@kernel.org, iweiny@kernel.org, icheng@nvidia.com,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261103024305.2333508-1-ming.li@zohomail.com>
 <20261103024305.2333508-2-ming.li@zohomail.com>
 <auwI9iLC0NCRvp9R@aschofie-mobl2.lan>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <auwI9iLC0NCRvp9R@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: zu080112271c1c7e0f77a06ee78d49f1320000b090f3fa3a2fc1b7162068d450fccb2ea7dd09f2f0c46cb9f0:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External


在 2026/11/5 12:41, Alison Schofield 写道:
> On Tue, Nov 03, 2026 at 10:43:05AM +0800, Li Ming wrote:
>> cxl_mbox_cmd_rctable already maps all mailbox command return codes to
>> errno values. Use the returned errno directly instead of checking
>> mailbox return codes separately to determine whether a command succeeded
>> or failed.
>>
>> Signed-off-by: Li Ming <ming.li@zohomail.com>
>> ---
>> v2:
>> - New patch.
>> ---
>>   drivers/cxl/core/mbox.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
>> index 55828a836c01..bd91b03c4d21 100644
>> --- a/drivers/cxl/core/mbox.c
>> +++ b/drivers/cxl/core/mbox.c
>> @@ -270,9 +270,9 @@ int cxl_internal_send_cmd(struct cxl_mailbox *cxl_mbox,
>>   	if (rc)
>>   		return rc;
>>   
>> -	if (mbox_cmd->return_code != CXL_MBOX_CMD_RC_SUCCESS &&
>> -	    mbox_cmd->return_code != CXL_MBOX_CMD_RC_BACKGROUND)
>> -		return cxl_mbox_cmd_rc2errno(mbox_cmd);
>> +	rc = cxl_mbox_cmd_rc2errno(mbox_cmd);
>> +	if (rc)
>> +		return rc;
> Hi Ming,
>
> The existing code really seemed to want BACKGROUND as a special case, so
> I searched the history on this one,  Davidlohr and you discussed this in
> 2023 around sanitize[1] .
>
> I do think it is confusing and if we can just follow the table codes,
> that would be easier.

Hi Alison,

Thanks for your review.

I checked the link you shared, it is about the return code of a 
BACKGROUND cmd handling inside __cxl_pci_mbox_send_cmd(), because 
__cxl_pci_mbox_send_cmd() needs to handle both non-BACKGROUND and 
BACKGROUND cmds and returns the result. but in cxl_internal_send_cmd(), 
I think we can consider the cmd done whether it is a BACKGROUND command 
or not.

>
> I'll let Davidlohr dig in on this one.
Thanks.
>
> I read both these patches as cleanups but no bug to be fixed.

Sure, will drop the fixes tag.


Ming

>
>
> [1] https://lore.kernel.org/linux-cxl/mw5bsc5u72fdrgo7qovj6u2npg2asftzp3jeprwtmnvbvg7vet@fayzcxpurjl6/
>
> -- Alison
>
>
>
>
>
>>   
>>   	if (!out_size)
>>   		return 0;
>> -- 
>> 2.43.0
>>
