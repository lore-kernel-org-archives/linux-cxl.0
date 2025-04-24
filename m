Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8220A27C879;
	Thu, 24 Apr 2025 15:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745509713; cv=none; b=KF5yLwblwx7EDNjEmIjxi7ByRabxM9F1t3zk/vPG3rg/anr7GJgvD4W7O2fkSUi4QQ9hV+xKia8TTuHkL+VQEm9PaEr7A/zMvadYqLjdxAt1I8RtuS59bNMDmdXJqmrUmq0JZAvsPu3DGpMDshWv8T2RknRLjV8gKMOl13hgnS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745509713; c=relaxed/simple;
	bh=IknhUfZWPF7mGq/HC8anKs8hdz1XIB5tgIBQY23Iy3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q/iOVLA2NIJ3v0/4Xl4Mv+ftR5wQ/5zpnqBUbX4AcaloBlDOw4WI/bcpT9lhXDOPbKdKMGn1F+2Z8RL3yjxOqYNUHV/T+VJMXuKQshTNh5F8QZk9kgT70BTZDGBRJt8Oo0zWQDCzh6oLTmj7P9MgPttyFuN/+u818a8NVcR+y88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LDoU3Ptq; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LDoU3Ptq"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-736aaeed234so1089419b3a.0;
        Thu, 24 Apr 2025 08:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745509710; x=1746114510; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hXSNAZqWqHOdN8glT1K15OYszjzdg5sYyN+x4FDGNp0=;
        b=LDoU3PtqfTPrI6WG/HzV4c/aQWImSJMJFnRtwJ9yrsI+TeDuWyzub6kpubcoL0Fc7A
         j8OWcPvkqgJkKuH94xJGfgSRf80EQNokyRFf7+MTMtLkyHkqRfcDbBqWfrXYjkgLj1xZ
         IYHN+KEZuwBoZT3lZGmdADezmcZpMnZVhscbrqidOC+JB3a4BCR5LrWhWAUzYyUIjCLH
         cbEVfIuE1kB5WopasjU4mczkeSy31y8CyB7RYfmAolTlQd0DBFKHQ6W7rSf3iSyvqL49
         pCDiQMuyPlH6Qs+MBc7dnSf0HuK11L090Enj0+G1e8YMc6KNG3wLpJrULBWigcR0c53k
         yHBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745509710; x=1746114510;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hXSNAZqWqHOdN8glT1K15OYszjzdg5sYyN+x4FDGNp0=;
        b=gPDBqBLYKj2l6X0ZX9Pu5OWGnnJblEK918SZKbH6vBF7fyasjefaXVc5pMPtDgue3i
         9ce/g3EXyi3j0oXXExcK6BMBZq/Z/FMlcqEAIcXCjrbFs3Vz45MDhf6spiUEi/WG07S1
         mNlwoZcYfuEbWmkN3jLeybKKl3533WnYoGl2JnqvH1UBllJmwABBbZjS+7ZpSH+xqWEr
         9CpysLP7bPuhejQw9/k+meu23ds9QEZafMW9E6dKDTYDaMH/D/yei6OQ3dDSn67/WxQL
         wAzLt+85yizy+ZiFALO6MCy7td2ygfSGLtzmTkPYLpCX6/2V31eC0FolijQcZJUpFoas
         mlXw==
X-Forwarded-Encrypted: i=1; AJvYcCV/NVOWDv+6TdrDw58n9nZlk8qXO3UOIVrFgZNuE1GqLy6uUw49hbpD39lf4EQ1fmP9QlETwfC9qraA3eRs@vger.kernel.org, AJvYcCW/iL2lyJU063JupcL1Vl0/31AwfqgMMTPw7ojlJKO2+9CY1N+egiZdVAP8pLAn7+qn9qN7p8tmfpM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjkfa0MJ5UrYQe9pCK5OhCNVQKB8I0hfjc4HR8ZdlhlJfXdXDi
	P8+jtAHH60sRKVf3d1Bv939AU6m11YHYS6dzyUv51BBEUnVdWPZY
X-Gm-Gg: ASbGncsvP83SZfsaDCQ7WxMdeGQPvbcaEwoCI+J6XqwrtTt4QKVvSX6RjJdjKvwMfTd
	cvZXkcmCPCBFqBY/ONaYw4RaS2yCSk+YqMtSGzYWXw0hEEL455Y7GzsPozPuoJP8KwaxLvJ8KGv
	8xfkfdgODOfIohbwNgsH7durUaEwGRNfM1hFDE4CQYU4SVYMAc8A4fejbIduykyj8HI7jlmkNkK
	51AJ8dU4WobLU9oAnkVZS2rb2XEX5WMcdaHsizRdwB0R9Awow6mxwGvy0mKu2jJH4zAsZigF5W5
	sCkcoI2SX09pg16ZLKZB4sWrjtXdX96xavZwPVP7+zIULzh0Geptpq1bjPw=
X-Google-Smtp-Source: AGHT+IFaP2iCQyPkPtDuq0FAoPlsVPxjyBZV/+/xzyktamAZBKv0F67VIzG+jccmSHe8TZYGoYXK7Q==
X-Received: by 2002:a05:6a00:328f:b0:736:a7e3:d4ab with SMTP id d2e1a72fcca58-73e32f5df9cmr256898b3a.5.1745509709618;
        Thu, 24 Apr 2025 08:48:29 -0700 (PDT)
Received: from [10.16.12.253] ([61.83.230.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25941cccsm1548743b3a.71.2025.04.24.08.48.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 08:48:29 -0700 (PDT)
Message-ID: <896732b1-b761-4a07-a1c0-1e4456d36e84@gmail.com>
Date: Thu, 24 Apr 2025 21:18:24 +0530
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [PATCH] cxl: trace: Fix macro safety in
 CXL_EVT_TP_fast_assign
To: Ira Weiny <ira.weiny@intel.com>, dan.j.williams@intel.com
Cc: Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Shiju Jose <shiju.jose@huawei.com>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 "Steven Rostedt (Google)" <rostedt@goodmis.org>,
 Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250421184520.154714-1-shaikhkamal2012@gmail.com>
 <68096119523f6_1bed7d294ad@iweiny-mobl.notmuch>
Content-Language: en-US
From: shaikh kamaluddin <shaikhkamal2012@gmail.com>
In-Reply-To: <68096119523f6_1bed7d294ad@iweiny-mobl.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 4/24/25 03:22, Ira Weiny wrote:
> shaikh.kamal wrote:
>> Fix checkpatch.pl detected error
>> The CXL_EVT_TP_fast_assign macro assigns multiple fields, but does not
>> wrap the body in a `do { ... } while (0)` block. This can lead to
>> unexpected behavior when used in conditional branches.
>>
>> Add checks to ensure cxlmd is valid before accessing its fields.
>>
>> Signed-off-by: shaikh.kamal <shaikhkamal2012@gmail.com>
> Nak
>
> This is not a normal macro.  checkpatch.pl does not apply in this case.
> Also checking cxlmd here is not necessary.  The callers of the tracepoint
> know very well that it needs to be valid.
>
> Ira
> Thanks for your comments.
>> ---
>>   drivers/cxl/core/trace.h | 30 ++++++++++++++++++------------
>>   1 file changed, 18 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
>> index 25ebfbc1616c..a1a1014ee1fe 100644
>> --- a/drivers/cxl/core/trace.h
>> +++ b/drivers/cxl/core/trace.h
>> @@ -249,18 +249,24 @@ TRACE_EVENT(cxl_overflow,
>>   	__field(u8, hdr_maint_op_class)				\
>>   	__field(u8, hdr_maint_op_sub_class)
>>   
>> -#define CXL_EVT_TP_fast_assign(cxlmd, l, hdr)					\
>> -	__assign_str(memdev);				\
>> -	__assign_str(host);			\
>> -	__entry->log = (l);							\
>> -	__entry->serial = (cxlmd)->cxlds->serial;				\
>> -	__entry->hdr_length = (hdr).length;					\
>> -	__entry->hdr_flags = get_unaligned_le24((hdr).flags);			\
>> -	__entry->hdr_handle = le16_to_cpu((hdr).handle);			\
>> -	__entry->hdr_related_handle = le16_to_cpu((hdr).related_handle);	\
>> -	__entry->hdr_timestamp = le64_to_cpu((hdr).timestamp);			\
>> -	__entry->hdr_maint_op_class = (hdr).maint_op_class;			\
>> -	__entry->hdr_maint_op_sub_class = (hdr).maint_op_sub_class
>> +#define CXL_EVT_TP_fast_assign(cxlmd, l, hdr) \
>> +	do { \
>> +		if (!(cxlmd)) { \
>> +			pr_err("Invalid arguments to CXL_EVT_TP_fast_assign\n"); \
>> +			break; \
>> +		} \
>> +		__assign_str(memdev); \
>> +		__assign_str(host); \
>> +		__entry->log = (l); \
>> +		__entry->serial = (cxlmd)->cxlds->serial; \
>> +		__entry->hdr_length = (hdr).length; \
>> +		__entry->hdr_flags = get_unaligned_le24((hdr).flags); \
>> +		__entry->hdr_handle = le16_to_cpu((hdr).handle); \
>> +		__entry->hdr_related_handle = le16_to_cpu((hdr).related_handle); \
>> +		__entry->hdr_timestamp = le64_to_cpu((hdr).timestamp); \
>> +		__entry->hdr_maint_op_class = (hdr).maint_op_class; \
>> +		__entry->hdr_maint_op_sub_class = (hdr).maint_op_sub_class; \
>> +	} while (0)
>>   
>>   #define CXL_EVT_TP_printk(fmt, ...) \
>>   	TP_printk("memdev=%s host=%s serial=%lld log=%s : time=%llu uuid=%pUb "	\
>> -- 
>> 2.43.0
>>
>
