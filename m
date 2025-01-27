Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135892D7BF
	for <linux-cxl@vger.kernel.org>; Mon, 27 Jan 2025 14:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737988826; cv=none; b=hu6qEHDD6xzJTlO6gOsdAsdNS0dBKal694XR2x9LUz8AzIrFk+UIejVdybkdNAQxu6509TyNWz4PtbdUtjKmrsq5f2sQDwy4fGPGPRVE2pwuK7XA/F/+9k1kvYkmUxGB4j5awX3rMlzcT7A7GQZymYpfSUTdZRM0+w7TOqLLCO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737988826; c=relaxed/simple;
	bh=eCKNQKTlNju8+3NgJuO48DRX9mxkFe1KMgip9ppG9X4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X4LmsanAzsSo1+44sAP259sJTUQxj6bqlha7PK/5dFgX2ZtjE5xeXumZ6R7GO9aVOZy8eP9zSQ5Yko2xb68+b4MLBRmjXZ92EzGSi3bCdM/YXo84mJmQIVJY5nUpaB6UiHJnNaEpqJiezL17fUx7apo6Y/QORXxLdQue3TYNwfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JXm80M9i; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JXm80M9i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737988822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=j+LY8zaaRW7ManqkA8bImcGJ7nd8rdtPjeIf4KgIMV8=;
	b=JXm80M9iRLxvr4oYJuQAmRJg2RGoU+t2p3r2ssG5wHnWrmYYZiBvMERb6KlbhZicSJqLyy
	dmYLNXu4trgz9s3aCrZuj7JAZYTG1xpjjuVHqCX/D028Tm9wvVEeF+QYOR10Q1mP2lG7y1
	EJOnB8SoE4Sf6+lWEbeqU14bDKa0VVQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-KFx6B9eiMK-P27dM8VlfzQ-1; Mon, 27 Jan 2025 09:40:21 -0500
X-MC-Unique: KFx6B9eiMK-P27dM8VlfzQ-1
X-Mimecast-MFC-AGG-ID: KFx6B9eiMK-P27dM8VlfzQ
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43619b135bcso22045725e9.1
        for <linux-cxl@vger.kernel.org>; Mon, 27 Jan 2025 06:40:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737988820; x=1738593620;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=j+LY8zaaRW7ManqkA8bImcGJ7nd8rdtPjeIf4KgIMV8=;
        b=k+JoXBB8daVn2pOnCTWy5NUG7zbZKYeu7CVbuc+BaQqa01J0eNsmZoQXL5CWBpB9mT
         wasc1sAwtJAg1Yc8wBnAB5dRh7X5jSuLmsSJ1tpS7ad8+/JfYOEk8LrG/5fJLwNYCBbA
         Y3iS56Tjeb8KKqCZmjIsHne2IU6oganZIinC+NjWbm6WEAEd5ilJrg5oo2dC0wMCKb41
         o5xFBf8ivfSxCIgfSmvePePpjZ/aTRSlud5aofA6gerUJ7nyKOgaDiuAxDIjzJIvhjIV
         2buoeWPQ72xAU/INRFsbVabjUTA4TCZFQYH5vQZGIOS0/HagHZezUbWsRPMNAIGZecfl
         2MGQ==
X-Gm-Message-State: AOJu0YyUaacRI8UF8KmplnhsQLSdwpJHaIGAkw6qN9QLYfCO4qFmfzqy
	lFP5T80VRm/0h9Rv9aeuOJG6buT6tTXffNXYauiRUs1wYdxGRHla51Q8xPcna3+e0OdB00Qei4D
	R6DZi3lzXszhw01rnC/sFUiMs65xSh2g8VQaICIA8zIjgvcY3LuoxSxSsX96ueDPCSeem
X-Gm-Gg: ASbGncuhPvHu1QA/TD6l6hjUhOHzDHLXmZqFeNVa8bsOkpXqYzgZCxi5xs0xnoXzorm
	jD9EG7Lg/pe1z+/0sXK3ik3j2qE2z+PrBJ9PY90T+pxaMmrxbZMAgi9+5atEwERTde9w07cwesc
	WC6xRKPJm9QkTPgiPvra1lKrAqMA40t0JYufrhnQi7a4vb7Dy2fw9LNJPZ0i7p6xKwyDrVhhy/H
	5hWyGp8+OkAMOlmhZVPx68duuXR/xBKympT7aTV7C1ZRp3XOVeB3InALPyfW+XKPyILmNvLorvh
	e7EUTcSiRqRcwlpkhmr0A9vp5Pnut+uEemx04R7O7W7CcAP8f3xNFePbCtccBrgpu/NOHey4qU1
	3McudwcClGwDUWz1hvK+oPDplIJejSnu7
X-Received: by 2002:a05:600c:3593:b0:431:55c1:f440 with SMTP id 5b1f17b1804b1-4389144eea8mr457174865e9.30.1737988820521;
        Mon, 27 Jan 2025 06:40:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEBYeysFdBvN+m4FKahXOG5MkiJQMvnChppGgOxmLEvVQ8l5svEMPycMAUdr1Hp2gAePl93zQ==
X-Received: by 2002:a05:600c:3593:b0:431:55c1:f440 with SMTP id 5b1f17b1804b1-4389144eea8mr457174535e9.30.1737988820144;
        Mon, 27 Jan 2025 06:40:20 -0800 (PST)
Received: from ?IPV6:2003:cb:c736:ca00:b4c3:24bd:c2f5:863c? (p200300cbc736ca00b4c324bdc2f5863c.dip0.t-ipconnect.de. [2003:cb:c736:ca00:b4c3:24bd:c2f5:863c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd4d34e3sm134224415e9.39.2025.01.27.06.40.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2025 06:40:18 -0800 (PST)
Message-ID: <9b0fa1f7-4133-4111-9142-143c36c42f8d@redhat.com>
Date: Mon, 27 Jan 2025 15:40:17 +0100
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] kernel/resource: Introduce managed SOFT RESERVED
 resources
To: "Fontenot, Nathan" <nafonten@amd.com>, Fan Ni <nifan.cxl@gmail.com>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
 alison.schofield@intel.com, linux-mm@kvack.org, gourry@gourry.net
References: <cover.1737046620.git.nathan.fontenot@amd.com>
 <1800b17449d1c231292c85f59b226aff39a81552.1737046620.git.nathan.fontenot@amd.com>
 <4e556200-c790-4e0a-b103-2a1529c81927@redhat.com>
 <3c7c5b87-f241-482b-9b00-98e2e53d8e9c@amd.com> <Z5CKN57paDmGJH9A@gpd>
 <5067fda1-c2de-4a20-9025-ebdf90ebba8e@amd.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <5067fda1-c2de-4a20-9025-ebdf90ebba8e@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BHobtJX8zBTlbbm2AxS2zsxxHQYDsSDeb1tTQfUNx1A_1737988820
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 23.01.25 16:49, Fontenot, Nathan wrote:
> On 1/22/2025 12:03 AM, Fan Ni wrote:
>> On Tue, Jan 21, 2025 at 12:57:19PM -0600, Fontenot, Nathan wrote:
>>>
>>>
>>> On 1/21/2025 2:19 AM, David Hildenbrand wrote:
>>>> On 16.01.25 18:42, Nathan Fontenot wrote:
>>>>
>>>> Hi,
>>>>
>>>>> Introduce the ability to manage SOFT RESERVED kernel resources prior to
>>>>> these resources being  placed in the iomem resource tree. This provides
>>>>> the ability for drivers to update SOFT RESERVED resources that intersect
>>>>> with their memory resources.
>>>>>
>>>>> During boot, any resources marked as IORES_DESC_SOFT_RESERVED are placed
>>>>> on the soft reserve resource tree. Once boot completes all resources
>>>>> are placed on the iomem resource tree. This behavior is gated by a new
>>>>> kernel option CONFIG_SOFT_RESERVED_MANAGED.
>>>>>
>>>>
>>>> I'm missing a bit of context here.
>>>>
>>>> Why can't we flag these regions in the existing iomem tree, where they can be fixed up (even after boot?)?
>>>>
>>>> Especially, what about deferred driver loading after boot? Why is that not a concern or why can we reliably handle everything "during boot" ?
>>>
>>> That's a good question and one I should have addressed.
>>>

Sorry for the late reply.

>>> The goal is to prevent the dax driver from creating dax devices for soft reserve
>>> resources prior to the soft reserve resources being updated for any intersecting
>>> cxl regions.
>>
>> Not an export. Can you explain a little more here?
>> What is the problem if we only flag the resources as "soft
>> reserved" in the iomem tree without creating a separate tree, and
>> process the "soft reserved" resources only when needed?
> 
> The issue we currently encounter is that the dax driver consumes these soft reserve
> resources and creates dax devices for the soft reserve resources before the cxl driver
> comnpletes device probe and can update the soft reserve resources to remove any
> intersections with cxl regions. We do not want these soft reserves consumed prior
> to them being updated.
> 
> If we were to put the soft reserves on the iomem tree we would need to have the
> cxl driver provide a notification that it has completed updates and others (i.e. dax)
> can them go process the soft reserve resources.

Would there be any blocker to that approach?

Adding them all to the resource tree and flagging them as soft-reserved, 
to then have a signal that allows DAX to work on these, sounds cleaner 
to me.

-- 
Cheers,

David / dhildenb

