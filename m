Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12626F31E
	for <linux-cxl@vger.kernel.org>; Fri, 11 Oct 2024 10:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728643876; cv=none; b=lyyyh18CxiLgU/U4POC0WZJ9XGv06u4eZ9S4/Exc3ttvzLepFNOO64JgslrEhPShusuuAkeamQVGkqvDiAa4ACfAVA0F8BP1BeTa1vbGzZigD4YiFEFGhAYpNrlCPcm3TmEIEaAwtS9W09q0g+Qbe44FelHMtMUZ8YMdKT/3Oho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728643876; c=relaxed/simple;
	bh=wU8yeRkfwEOvs3NnyYcG7qZ5LY9LccW92vEJg86MmI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=shmJloPPBsvrYzx3BUnvwM16XQBS9whSQKm2aWBYC3qYWwbunfmtiM6tpC3ZdB39mNUoxU7Ptsy3VDws+zwk1GfGoe5rZX8pJtWsb5TkaXfIQo3RqI3C4IVYgCNAqA6t9VqU+gmrELWvgFqDCY8r8WiDXC37qs07nKueBj/nWxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K10nWMwh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K10nWMwh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728643873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QRWZ/dnW/X5JVzbg+/NMl8548MA+vPq6+17sLtHovgw=;
	b=K10nWMwhqB4VHgRE814IwNwfKLD+WN7e+HFqf6/T3tEAFuZPL16PC2EwU4TB7lc04fH+SB
	m18lOdg02YHWXaH1faCZsFrkXawogGwD3ARrdch/o1E20cevaZcU2rjbUgn4SkWOcNH4Rh
	7FdIVtX54npBGEQi622raRebi4l7aNA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-t3TjNkyHM1SVn2CaVWlDuA-1; Fri, 11 Oct 2024 06:51:12 -0400
X-MC-Unique: t3TjNkyHM1SVn2CaVWlDuA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-430581bd920so11736935e9.3
        for <linux-cxl@vger.kernel.org>; Fri, 11 Oct 2024 03:51:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728643872; x=1729248672;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QRWZ/dnW/X5JVzbg+/NMl8548MA+vPq6+17sLtHovgw=;
        b=w0CfciNfLbSacGlOqZPKcfisYhwOa9qoKB3VGDUlPiJRb8YbJtfKGSTyexfx07w85k
         fS82kdYML4+6mR29fOWHZ8Ahps5sLqPhyDas0R8T4qzNnTwEUzOwSHBWnDMWBpUxkbXr
         dn4reeIZnDu0gmOxNvQm2BUZCoZoP2q1ZmIz4kr06mkOsDBud9JNxCp99LNpcQ59HtvY
         HFxXeEA5gNTAQQRiW410MMZ1r7gpLU7wivFDJH2QEMTL8lnSA3/oyf+jrBF69bkRdEpL
         rw3eJLPPeF4gHxTCir+hRQM+fDswsYI+LeoEbJhcgHcxUt4XwcwCxn6B0SUqYFs6Tn/z
         y1Rw==
X-Forwarded-Encrypted: i=1; AJvYcCVJgWbqQe+YwVJy2su3Vz4QDRSYDiXq5Pe4r9XJwNuuYFZbMPF/dThfGD07MYlcRCw5o4T1sstni5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyuQoH5OnAgiNwGTb613z/FfuMA22qZBhAtYyTv9Hy6ng5Cxb6
	gVLeXsUxFX7hLD/+/oyq4m6E/fRF8CsMLSGIVf6p2FeAjAaCC6moZV3o5x8CmMqaXj4OqAYgxP1
	iDWu0dARSLUm9d3tIqaJ3LXOXVoT3xJqVn/ZQ4HxE4fZX+zbimDKIsgsI1Q==
X-Received: by 2002:a5d:63d1:0:b0:37d:4ebe:163e with SMTP id ffacd0b85a97d-37d552cccb6mr1702876f8f.53.1728643871648;
        Fri, 11 Oct 2024 03:51:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFL6Tn8HmyoiXRJkxDHKJCyxSs3ivj+s+7gbQ+jDcwdoHa40SFacUizcZIoHh9Sc1ZMAF7bCw==
X-Received: by 2002:a5d:63d1:0:b0:37d:4ebe:163e with SMTP id ffacd0b85a97d-37d552cccb6mr1702848f8f.53.1728643871216;
        Fri, 11 Oct 2024 03:51:11 -0700 (PDT)
Received: from ?IPV6:2003:cb:c749:9100:c078:eec6:f2f4:dd3b? (p200300cbc7499100c078eec6f2f4dd3b.dip0.t-ipconnect.de. [2003:cb:c749:9100:c078:eec6:f2f4:dd3b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b79f9c1sm3623267f8f.68.2024.10.11.03.51.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 03:51:10 -0700 (PDT)
Message-ID: <b8262026-533b-497b-9713-fa3e32f76d9f@redhat.com>
Date: Fri, 11 Oct 2024 12:51:09 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] resource: Avoid unnecessary resource tree walking in
 __region_intersects()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 "Huang, Ying" <ying.huang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
 Dan Williams <dan.j.williams@intel.com>, Davidlohr Bueso
 <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alistair Popple <apopple@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Baoquan He <bhe@redhat.com>, Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>
References: <20241010065558.1347018-1-ying.huang@intel.com>
 <d129bbe4-8ae8-4915-bd9c-b38b684e8103@redhat.com>
 <87set3a1nm.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZwkCt_ip5VOGWp4u@smile.fi.intel.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZwkCt_ip5VOGWp4u@smile.fi.intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.10.24 12:49, Andy Shevchenko wrote:
> On Fri, Oct 11, 2024 at 09:06:37AM +0800, Huang, Ying wrote:
>> David Hildenbrand <david@redhat.com> writes:
>>> On 10.10.24 08:55, Huang Ying wrote:
> 
> ...
> 
>>> 	for ((_p) = (_root)->child; (_p); (_p) = next_resource_XXX(_root, _p))
>>
>> Yes.  This can improve code readability.
>>
>> A possible issue is that "_root" will be evaluated twice in above macro
>> definition.  IMO, this should be avoided.
> 
> Ideally, yes. But how many for_each type of macros you see that really try hard
> to achieve that? I believe we shouldn't worry right now about this and rely on
> the fact that root is the given variable. Or do you have an example of what you
> suggested in the other reply, i.e. where it's an evaluation of the heavy call?
> 
>> Do you have some idea about
>> how to do that?  Something like below?
>>
>> #define for_each_resource_XXX(_root, _p)                                \
>> 	for (typeof(_root) __root = (_root), __p = (_p) = (__root)->child; \
>> 	     __p && (_p); (_p) = next_resource_XXX(__root, _p))
> 
> This is a bit ugly :-( I would avoid ugliness as long as we have no problem to
> solve (see above).

Fully agreed, I didn't quite understand the concern about "evaluation" 
at first. If it's just reading a variable twice, it doesn't matter at 
all right now.

-- 
Cheers,

David / dhildenb

