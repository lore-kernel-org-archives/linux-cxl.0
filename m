Received: from sender6-pp-o94.zoho.com (sender6-pp-o94.zoho.com [165.173.180.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34C113D53C;
	Wed,  9 Sep 2026 02:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.180.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788919709; cv=pass; b=AaNnjqptK/zBBxTeFaBqgl962XmNd5ShAVomDEST0+5IX/f9yDSjdsyw5v9siwhyr74nxtvqtEKIh9R7oaC70qiCJrcG7KV5OMyWBeXuFqF/4wGZul0YDfR36ztpmdyrIQCp3zlJx4Jmx1XqqqyKQpAojH5x5c1IbMsBeRLp/W0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788919709; c=relaxed/simple;
	bh=fzZsDrYGy+IbNu7Tci5r7HZUQrMRfylbcqJ7UQXJ0qs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TafWUytjxl9sLU1XUO/JGaklvLjBhq/8iZFGTkDqMmLKiotp7Z2M834aDYJGX/XGd5kJrohdW/V1Bdm/tc6okWXfs4ZrLVcdcD7JqYknpE1SObynMbsn5LI9YkHoaCQFWhtu4gDVWkl8S4av7MFeAy69BWwLyAP1RnNNMGVsm/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=Atmq24h0; arc=pass smtp.client-ip=165.173.180.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="Atmq24h0"
ARC-Seal: i=1; a=rsa-sha256; t=1788919700; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=UDluB+eFyFv/9WBjZnbnn7+nZSt0PNNC4AbDv6+fnSvYOf/Ppw+4QhT8ZtiiJinP4PgYkm/1zJ6NGMxOIta9k3R9piGHZpe5WOsy6hofJObobCQefirbyk7+qwLNPz6N/sQpNjTqfDaPLuZWTSHzqk6QG7XJhWlqlTvFtrjDVDw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1788919700; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=xRyGtyZmjhzl8CYleaEojSFYXlW6kLaxI53pyn/v0Sc=; 
	b=MGJJH80a3kY3tNTgdHpW9/Tv+6qAiBydUrje69HVJ5k3avkJh7YW394+/pw8fjtJi76m+Y3HWngMKTHEivyBMGjgmrv9gxHvs3FQsyCwBZXz3Vom8y46ntzSJMJUKxyeI6YN5jHyoy468+1q0cRr0G8P3x/sHIg8tdIBCHog5Vs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788919700;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=xRyGtyZmjhzl8CYleaEojSFYXlW6kLaxI53pyn/v0Sc=;
	b=Atmq24h0yV5W2T9EqFTkgXSF9IxGPUuG2wdGKXCe7LjYkVmDitSI33izB7geFHyC
	x/Gb0pGbcK6Tnpq4ExlyIbXczK7KJF9uuYaX0TAHBCfv83TvO5eYnx1pP79EMA2t28S
	r5yp778ef3JvmaoU9EtgxwxUeK4LrDZ7ZgOpXKok=
Received: by smtp.zohomail.com with SMTPS id 1788919699020409.6821399782324;
	Tue, 8 Sep 2026 19:08:19 -0700 (PDT)
Message-ID: <fc844c0b-e429-4c0d-9113-35a1635c03a3@zohomail.com>
Date: Wed, 9 Sep 2026 10:08:14 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/events: Return IRQ_NONE when no event is pending
To: Jonathan Cameron <jic23@kernel.org>,
 Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>,
 Ira Weiny <iweiny@kernel.org>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260906155705.13252-1-shaikhkamal2012@gmail.com>
 <20260907194824.615e47ff@jic23-huawei>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20260907194824.615e47ff@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: zu08011227da0bf2ef153f92606495703a0000d3d03e4108f7dc55e74078963443d5780ca88952a1e5deaa3e:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External


在 2026/9/8 02:48, Jonathan Cameron 写道:
> On Sun,  6 Sep 2026 21:27:05 +0530
> Shaikh Kamaluddin <shaikhkamal2012@gmail.com> wrote:
>
>> CXL event interrupts may share an MSI/MSI-X vector with other event
>> logs or device features. Consequently, cxl_event_thread() is registered
>> with IRQF_SHARED and must determine whether an interrupt belongs to the
>> event-log facility.
>>
>> The handler masks the Device Event Status register to the event logs
>> supported by the driver. However, when no supported status bit is set,
>> it exits the processing loop and still returns IRQ_HANDLED.
>>
>> Track whether at least one supported event status bit was observed.
>> Return IRQ_NONE when there was no event to service, while continuing to
>> return IRQ_HANDLED after processing one or more event logs.
> What is the practical result of this change?
> I think it will only affect the spurious interrupt detection so
> to me it looks like a cleanup rather than a fix.  Is there
> any path by which we actually lose interrupts as a result of this?
>
>> Fixes: a49aa8141b65 ("cxl/mem: Wire up event interrupts")
>>
> No blank lines in tag blocks.  There are a number of tools that rely
> on there not being any and as such there are also scripts that run
> on various upstream trees that will send us annoying emails if this
> blank line is still here!  I'm not sure why this mistake in patch
> formatting is so common as there are plenty of docs without the
> blank lines!
>
>> Signed-off-by: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
> A suggestion for an alternative implementation below.
>
>> ---
>>   drivers/cxl/pci.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>> index c7c91e8dc51d..8b560cae91f2 100644
>> --- a/drivers/cxl/pci.c
>> +++ b/drivers/cxl/pci.c
>> @@ -515,6 +515,7 @@ static irqreturn_t cxl_event_thread(int irq, void *id)
>>   	struct cxl_dev_id *dev_id = id;
>>   	struct cxl_dev_state *cxlds = dev_id->cxlds;
>>   	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
>> +	bool handled = false;
>>   	u32 status;
>>   
>>   	do {
>> @@ -527,11 +528,13 @@ static irqreturn_t cxl_event_thread(int irq, void *id)
>>   		status &= CXLDEV_EVENT_STATUS_ALL;
>>   		if (!status)
> 			return IRQ_NONE;
>
> And don't need the other changes.

Hi Jonathan,


I think we should not return IRQ_NONE here, because the loop could run 
multiple times untill no event record, so we always get a status with 
0x0 value in the last loop. In that case, we still need to return 
IRQ_HANDLED.


Ming

>
>>   			break;
>> +
>> +		handled = true;
>>   		cxl_mem_get_event_records(mds, status);
>>   		cond_resched();
>>   	} while (status);
>>   
>> -	return IRQ_HANDLED;
>> +	return handled ? IRQ_HANDLED : IRQ_NONE;
>>   }
>>   
>>   static int cxl_event_req_irq(struct cxl_dev_state *cxlds, u8 setting)
>>
>> base-commit: 7098e9cd98a05c0c5de2fae0c2465f9d966fdd07
>> prerequisite-patch-id: 92e40cd60a697020faac475dcc77ba63b33434ea
>> prerequisite-patch-id: 10027ad5d9aed85806047f807b3a76273b6c4a77
