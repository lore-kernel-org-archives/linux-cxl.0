Received: from shrimp.cherry.relay.mailchannels.net (shrimp.cherry.relay.mailchannels.net [23.83.223.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072B81482F6
	for <linux-cxl@vger.kernel.org>; Wed,  4 Sep 2024 20:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725481097; cv=pass; b=SCce4qAMTXEG7SW1YSwkvtBCA4zEEWvkddj62aA+KyXSlMvx/rx+5wAPeFX0M+N1+tTN2Zrf7TbfKiFIFO8OPe1F/YY2QKrf1GfrFtdlKUsTieDsSXvn+LrUSCqRaRcLEfTepp6WzAHYaDIodAVNktu0gDnyBIMQ92gf8Ica6ag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725481097; c=relaxed/simple;
	bh=GgIe4kQVXa8dNIpdUlDNas9cfJctUmVAoTjzpLXm0qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jp8YRXt0aWtxXwqj2o6QMEfPyikTBw52ldz8lY+EMSu0RuTaUxRgFNBQXDtrxZ4o85uwI77D2hDIfM2H4TPgIcv1ptfSPomeFr6Gm7TqBUAKGEqTQp+hchZsWfDq7ex0QzBOPuDX2VEA7SP3EAIPeH/B48KHnIXIlWe/xU5i2ko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=lfZI349U; arc=pass smtp.client-ip=23.83.223.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="lfZI349U"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 7AA23907329;
	Wed,  4 Sep 2024 20:02:06 +0000 (UTC)
Received: from pdx1-sub0-mail-a315.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id C331F9066B4;
	Wed,  4 Sep 2024 20:02:05 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1725480125; a=rsa-sha256;
	cv=none;
	b=jvoCStF+jA7muerIFlNBR9U/UCQII/pOeOCTVQFMb0KiKEQEhSiOzUIjILEgC0Woj3zBmB
	cpW4C53O7K2R9AbAFbQEnIGtR+rLhnnENhPFcJ5sGstBmbFCmXVbrXezCneVZIqoMQHCFp
	b+klvdC/qI6Uv7gY5wfIyrxY7lon2NKvuAf4VAjZ5LALjzZlVpfcfYxAZH0Iryj3EzqWec
	gLFjVF973f207Q2ks0hb2A0Lp5zdxo7vCi948W3/AgXcLSxeGsXDw/hjsVKvtBEOteUjvX
	W15CaOm/ugLwcsx8IhRkhZANkAJELg4K5NQ4cil9wJbGMtPbawQQYWdpKTlAEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1725480125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=vqsmt64i93hUT3uHDYPQydPpb4QSmkI811mVgIxWbTc=;
	b=wKkGj5JtpzR+OKAKlIE1uE8nDw6OavBSXx7r3yf3gywE3lXZw+rACkYsnq6BsFveLDVpHx
	g6dIhSmpYyWkLhL9BpruyJWoCvQQ5vQ7Kpw3hgeSt3VS7I4fAX2yQXnlW7xgN6bnAw4Icp
	AswmoAMuFJxpFiFzX65n+yaJx/POfQeRdxsh5ifdsVDRo0S+wvWpraIXy8EIHt58g28K4D
	cZLqy500Vvp3SPfp5V+bc/2u4eEt7N/syAbEKGwOSZBxFxZzu6ODXO0Mm4LJYSaRPMniZR
	MPQP3nR4dlelSm+fsHZ8sBzq3T3lnYdEEdwgn9EmQIifcWOhHR96EUZe42AtVw==
ARC-Authentication-Results: i=1;
	rspamd-6bf87dd45-7bhbn;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Chief-Imminent: 25c52b7c67bb955a_1725480126323_658189804
X-MC-Loop-Signature: 1725480126322:807150917
X-MC-Ingress-Time: 1725480126322
Received: from pdx1-sub0-mail-a315.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.242.198 (trex/7.0.2);
	Wed, 04 Sep 2024 20:02:06 +0000
Received: from offworld (unknown [172.56.176.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a315.dreamhost.com (Postfix) with ESMTPSA id 4WzYL46rfCz2j;
	Wed,  4 Sep 2024 13:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1725480125;
	bh=vqsmt64i93hUT3uHDYPQydPpb4QSmkI811mVgIxWbTc=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=lfZI349UBhnXzYQ88um9KjL84exNb9VmCKLJptxoEGyKQjpWRGr3JACuhMFWovnZF
	 DwCANNRGWN1jK+Bi7sdgkK7OH9AlmZ67AAC4o7ZfrlomDORq7220qlM2E6hCJthBLu
	 s14FFaW2gqT+XoJYMuVBi0Q6cVsoU+IbyZlBLI8Z0xH26cHFmHsrITsV2RBpvGx8h8
	 vdgXfPV6V0wf1JBh0XEuKmqHSHhqDk8R6LmxiSiX12rP07mSYrlJ5onpckGoA625U/
	 DOA8r0A43P8BeiMABqqmYDNXUmTND/BA9lXdmJ/zHZ7GfVt71tFtWAYIpKPIk3Oky9
	 z14P4J88pY/VQ==
Date: Wed, 4 Sep 2024 13:01:55 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: peng guo <engguopeng@buaa.edu.cn>, fan.ni@samsung.com, 
	linux-cxl@vger.kernel.org, a.manzanares@samsung.com
Subject: Re: [RESEND] hw/cxl: fix the determination of illegal physical
 addresses
Message-ID: <4ylhz5gnwatapw2nwu6ktgr6i6l4iwyxirg7yamimsvilh2jla@d7vkuddno4z2>
References: <20240819120317.12505-1-engguopeng@buaa.edu.cn>
 <20240823161434.00004b30@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240823161434.00004b30@Huawei.com>
User-Agent: NeoMutt/20240425

On Fri, 23 Aug 2024, Jonathan Cameron wrote:\n
>On Mon, 19 Aug 2024 20:03:17 +0800
>peng guo <engguopeng@buaa.edu.cn> wrote:
>
>> When physical address range in the input payload of scan media command
>> exceeds static_mem_size but does not exceed the sum of static and dynamic
>> memory, the scan media mailbox command unexpectedly returns an error code
>> which is CXL_MBOX_INVALID_PA.
>>
>> This patch determines whether the physical address is valid in two cases.
>> If dynamic memory exists, check whether the address range of the request
>> exceeds the range of static memory and dynamic memory.If dynamic memory
							 ^ space for a new sentence
>> does not exist, then check whether the address range of the request
>> exceeds the static memory size.
>>
>> Fixes: d61cc5b6a8d3 ("hw/cxl: Add get scan media capabilities cmd support")
>Is that the right one, this code is affecting cmd_media_scan_media()
>not the capabilities one which always limits to static_mem_size and
>hence also looks wrong.

Yeah it is the right one - both commands were merged together (and
yes, they both need to be updated for dcd).

Maybe have a helper to consolidate all cases where such ranges are used?

uint64_t ct3d_get_total_size(CXLDeviceState *cxl_dstate, CXLType3Dev *ct3d)
{

	return cxl_dstate->static_mem_size + ct3d->dc.total_capacity;
}

>
>> Signed-off-by: peng guo <engguopeng@buaa.edu.cn>
>
>As with the other patch, this needs to go to qemu-devel list
>+ both should have gone to Davidlohr as author the patch you
>are fixing (sort of it, it's mostly down to what order patches
>landed in I think).
>
>Fan, Davidlohr, do we want to just cover the DCD regions as
>well with all the scan_media commands?

Yeah, I think so - particularly since poison management already
considers dcd for CXL_MBOX_INVALID_PA.

Thanks,
Davidlohr

>
>
>> ---
>>  hw/cxl/cxl-mailbox-utils.c | 9 +++++----
>>  1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
>> index 3ebbd32e10..b23c6b9b0b 100644
>> --- a/hw/cxl/cxl-mailbox-utils.c
>> +++ b/hw/cxl/cxl-mailbox-utils.c
>> @@ -1943,11 +1943,12 @@ static CXLRetCode cmd_media_scan_media(const struct cxl_cmd *cmd,
>>      }
>>      query_length = ldq_le_p(&in->length) * CXL_CACHE_LINE_SIZE;
>>
>> -    if (query_start + query_length > cxl_dstate->static_mem_size) {
>> -        return CXL_MBOX_INVALID_PA;
>> -    }
>> -    if (ct3d->dc.num_regions && query_start + query_length >=
>> +    if (ct3d->dc.num_regions) {
>> +        if (query_start + query_length >=
>>              cxl_dstate->static_mem_size + ct3d->dc.total_capacity) {
>> +                return CXL_MBOX_INVALID_PA;
>> +            }
>> +    } else if (query_start + query_length > cxl_dstate->static_mem_size) {
>>          return CXL_MBOX_INVALID_PA;
>>      }
>Can we not rely on dc.total_capacity == 0 if num_regions == 0/
>
>>
>
