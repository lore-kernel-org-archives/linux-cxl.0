Received: from sender4-pp-o90.zoho.com (sender4-pp-o90.zoho.com [136.143.188.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796993161A8;
	Sun,  8 Feb 2026 12:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770552426; cv=pass; b=hMzeVRpNsUyq73jeVL0cGia9PkG9O8ME11k384Aj1VJacZiEoY3w874nWaohqzaRcNQbiZ9dNkXsrzAKpEyBG1++YEN/Swz9zrEjnROPd2+dYQuvcApm/04R0uJNuE9K3btr//03/zpxxPrR4V31X9h2nOZh7fSIj6mOYoKM6J8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770552426; c=relaxed/simple;
	bh=oAndgAbQlMEGIFsqd6mz+pqzEySKWdglpbygOIj1JQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lh9AjnzSe/YxGlgDaMyIyFeWLJaYOlgV89HoCCowMAGAjfkppKer3rJk/klUeaopocVtbermYvl8PjS+SawYeYovq2OLf9NBD0ijMW1Onl2BE2CTcWDcUkaPvqPnSXo+BNGQeQJnXbNwcpk15+/V/dTZwtFQTSBVv9Nmt+D7CFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=EhsU7D2w; arc=pass smtp.client-ip=136.143.188.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="EhsU7D2w"
ARC-Seal: i=1; a=rsa-sha256; t=1770552411; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=hgZrDZSu+bSFPXzkEblrhblnP3K6zia71UaJXOKuSprQDYJtot5pcOddB/fXqxJoJTLJq6FSDW4oZpToKqor2B3gNeQZwxnuPMZ8gsWuAdatU8XKm6UgkXZvoAkXmxHtFy4UwVnSPqE+klMwcFXNCQk6E/zLdt2TGZ7ebws1gNY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1770552411; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Kl+S+AOOVZrjfGAitK//x+Hf39M/SB5LdTO49ElMZQs=; 
	b=VO36a6WAK8siWfDkYRlpMxcHmzjS5bwG+qg7K9a1LGZNWBW2xJheNXP5GGteoVuieGi2iTZT9rau90UxMf93KIAO0xeRexQ1p3sDfSMBWrqTfI1lbMbHU/BTXlm1N9QSBtY9jqm5fW+hK5eRV/q8JqmmdAiFz0fsYFmJ/6AS4kM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770552411;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=Kl+S+AOOVZrjfGAitK//x+Hf39M/SB5LdTO49ElMZQs=;
	b=EhsU7D2wYfD5pfIg+EJVukBKDejMoD1EW81KZ22u/QnoiOPYsTLGrbFrHwEDZu1a
	38eDhvFnvQnQD9hMH5IXVXRJcTP+treQgUGEGj/hmoCy+DpphCtnRL6hNm0xKUFVVpg
	gHYy9UO0MaWT/KxzdCxVKFJhYgFt8hcvlECbjy3Q=
Received: by mx.zohomail.com with SMTPS id 1770552409089915.8820504421028;
	Sun, 8 Feb 2026 04:06:49 -0800 (PST)
Message-ID: <4adcfebd-3489-4b41-b5b2-09ed89d6e0d7@zohomail.com>
Date: Sun, 8 Feb 2026 20:05:29 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] cxl/port: Hold port host lock while dport adding.
To: dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com
References: <20260207133512.306128-1-ming.li@zohomail.com>
 <20260207133512.306128-2-ming.li@zohomail.com>
 <6987763fea2ab_125f100f5@dwillia2-mobl4.notmuch>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <6987763fea2ab_125f100f5@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: rr0801122822a4b01a898e49d062257b300000ca2dbc7cba69d8f98eeb46b02d67cf43e10f799320d5a94adce0:zu080112279b0795e60c2240316d926bb00000869c7d8c627d4a0ad066158c9d90a08fa2109d62e087c8e293:rf08011232d4f6ecf791ba4a0a1f4c35f400003c4fbfabd4e543d6bc565e2546a1c8fde2ef1f3a5c3c9697259f93b637eb27e8bc2b2e2a:ZohoMail
X-ZohoMailClient: External


在 2026/2/8 01:28, dan.j.williams@intel.com 写道:
> Li Ming wrote:
[...]
>>
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index 5c82e6f32572..6f0d9fe439db 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
>> @@ -612,6 +612,23 @@ struct cxl_port *parent_port_of(struct cxl_port *port)
>>   	return port->parent_dport->port;
>>   }
>>   
>> +static struct device *to_port_host(struct cxl_port *port)
>> +{
>> +	struct cxl_port *parent = parent_port_of(port);
>> +
>> +	/*
>> +	 * The host of CXL root port and the first level of ports is
>> +	 * the platform firmware device, the host of all other ports
>> +	 * is their parent port.
>> +	 */
>> +	if (!parent)
>> +		return port->uport_dev;
> This helper looks good and this case is theoretically correct, but I
> assume that find_or_add_dport() never hits this case, right?

Right.  This case is only for finding cxl root's host, 
find_or_add_dport() is

only used for cxl host bridge ports and cxl switch ports.

> How about move the introduction of this helper to its own lead-in patch
> and use it to replace the open coded version of this pattern in
> unregister_port(), __devm_cxl_add_dport(), and endpoint_host().

Sure, will do it in next version, thanks for that.


Ming

> I do notice you caught the one in unregister_port(), but there are more.
>
> With that change you can add:
>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>
