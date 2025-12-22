Received: from smtp.smtpout.orange.fr (smtp-79.smtpout.orange.fr [80.12.242.79])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE57B3161A1;
	Mon, 22 Dec 2025 11:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766402958; cv=none; b=Oxo0QSEWkPxcp7rWrCgspXpeiO06AAn8BN13cFuWcKd0U3WdE33ugMybvqlCCwcw0u8r04lk+vambY/cF+38s/WcX7wzkkFK4kNT7ZkQqAqmXaQ3C+eakd2UOnUfgP9BhfRdzw/ElChMXv5OFeWztI28BIyIL15Z3E8/cvvOfAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766402958; c=relaxed/simple;
	bh=JpIavZ2AUtsWkzJJuBvg8jaS3rMqo5akFEf1gFRC+Os=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cp4gJxC5xvDttw9YXzq4tJhJ7dzskE7NZxTLGGBS6B9WzVegv+lmhNecPAkELXSbIuVYgcHCetK+8Y7Ie35J4mKdDivQRFIqdhYFbJ2DrQE6rra6bY3jshIt2YSiZe0BWm8He2gy7NQ8EqH2c40RX3o2pv91Es1Cp5mio+cspos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=lIKaoAnm; arc=none smtp.client-ip=80.12.242.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="lIKaoAnm"
Received: from [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
 ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id Xe54v6Lg6Mx35Xe55vBBs3; Mon, 22 Dec 2025 12:28:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1766402886;
	bh=XRzZpavEbBXNqBowMoqVM+56I2klO3UFZwg2QvNDSDc=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=lIKaoAnm0vgunNfCitt5ywrm9FVuIAjz6Omedb41mdSkcUuOkI6rgZcILcKcDeiQ+
	 /1YwAxLFJMsCxGEPvvmWWspuQQZdIrwwuRUpq9+dEuooyZZhg7HrAVE9WvtD9o/A9Z
	 cKAbuszv++ggmXz+7BH6zsmSX6zCZQMVkQEvCi/XfpaDahciRiNcpNO+X6VMQlgOom
	 R8o8zmBNPkfmjUpjZmRU16aRlZdmJfYEeAug2lYLMhWpXVNhU6iT+OI6QPVkbcesHX
	 MHTKoet5oqf3lwMEK3k5bJChCsfn/O3ZBqr7IpAek4PUzfg++EyhK2OMoLT8NdHOXB
	 M1y3gFGthUoLA==
X-ME-Helo: [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 22 Dec 2025 12:28:06 +0100
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
Message-ID: <265df0fd-7427-45d8-85fd-a487baf1521d@wanadoo.fr>
Date: Mon, 22 Dec 2025 12:28:01 +0100
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl: Slightly simplify emit_target_list()
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-cxl@vger.kernel.org
References: <589ee57cfc275c5249885e1eace22e9bf3a9561d.1766326481.git.christophe.jaillet@wanadoo.fr>
 <aUjAcQZ5JCxnk7Qp@aschofie-mobl2.lan>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <aUjAcQZ5JCxnk7Qp@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 22/12/2025 à 04:52, Alison Schofield a écrit :
> On Sun, Dec 21, 2025 at 03:15:04PM +0100, Christophe JAILLET wrote:
>> sysfs_emit_at() never returns a negative error code. It returns 0 or the
>> number of characters written in the buffer.
>>
>> Remove the useless test. This simplifies the logic and saves a few lines of
>> code.
>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>>   drivers/cxl/core/port.c | 10 ++++------
>>   1 file changed, 4 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index fef3aa0c6680..b77c1600beaa 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
>> @@ -151,7 +151,7 @@ static ssize_t emit_target_list(struct cxl_switch_decoder *cxlsd, char *buf)
>>   {
>>   	struct cxl_decoder *cxld = &cxlsd->cxld;
>>   	ssize_t offset = 0;
>> -	int i, rc = 0;
>> +	int i;
>>   
>>   	for (i = 0; i < cxld->interleave_ways; i++) {
>>   		struct cxl_dport *dport = cxlsd->target[i];
>> @@ -162,11 +162,9 @@ static ssize_t emit_target_list(struct cxl_switch_decoder *cxlsd, char *buf)
>>   
>>   		if (i + 1 < cxld->interleave_ways)
>>   			next = cxlsd->target[i + 1];
>> -		rc = sysfs_emit_at(buf, offset, "%d%s", dport->port_id,
>> -				   next ? "," : "");
>> -		if (rc < 0)
>> -			return rc;
>> -		offset += rc;
>> +		offset += sysfs_emit_at(buf, offset, "%d%s",
>> +					dport->port_id,
>> +					next ? "," : "");
>>   	}
>>   
>>   	return offset;
> 
> Can this can be cleaned up further at the target_list_show() call
> site which also checks for an impossible rc < 0 (twice).

I missed that, sorry.

target_list_show() only add a guard() and a trailing \n.
Maybe, both function could be merged.

Is it ok for you  this way ?

CJ

> 
> 
> 
>> -- 
>> 2.52.0
>>
> 
> 

