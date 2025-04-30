Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE183220689
	for <linux-cxl@vger.kernel.org>; Wed, 30 Apr 2025 09:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746003750; cv=none; b=I+baurPPTCLOUgX329K1Zk6rzWJk9kkTCdd66lhbZq2m0sDjh743AkqwS8fp7vqwIemn3ahGPa6kKKwgUFNuDAJL+Yv6JbxhVZ6zE/tqNFV8gFMp7JrmnvAZGVh9oxvYdKb6L/J0A0cDzOD6uyIUEkot+Xj4Lnt5OG+OfVeGUxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746003750; c=relaxed/simple;
	bh=cJU8biS1+gGlWgERPE1gyaFbtxMhkq1Rk8/2TGCcIwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jf3ixw3Z4b7UcgWXpcOOFzxTnzJyCOxL+jwPfUbMxEXRofyDH4QWZuPoNveYHQ3Tb2uq0MgL3j5jU/aX9dYbDg/xP1HiJui1nh8Sfmcl7Mxu8A+1phzkWUcFWUcL9ydbFO+982xo1Cx4GOIyvcJ/tHBkMYVWLrgzsmArK1cIQ5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XUbaduGj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XUbaduGj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746003747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=HlOQwhXNNGDrS3OJ/8pVFC8SE8/TT0zkRIcc+T6vAtI=;
	b=XUbaduGjzAkxRXbtspHRM6b6D+mjrUbAB13dfnhQDi+rIT9u4ARupT1k6sZWRzN/zq59zT
	SUvpgv8ZcuKO6zZALyKuT0rVQ0BCf+rZl4b3e8PNUx0DzXI6ydoRn/RTForlzB+suKGqf8
	ZkzyT4nONJUo8adeReCLZhy9lofjz7g=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-LI7vqAMAM22sz2D8UBeYOw-1; Wed, 30 Apr 2025 05:02:25 -0400
X-MC-Unique: LI7vqAMAM22sz2D8UBeYOw-1
X-Mimecast-MFC-AGG-ID: LI7vqAMAM22sz2D8UBeYOw_1746003745
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43cfda30a3cso34639385e9.3
        for <linux-cxl@vger.kernel.org>; Wed, 30 Apr 2025 02:02:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746003744; x=1746608544;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HlOQwhXNNGDrS3OJ/8pVFC8SE8/TT0zkRIcc+T6vAtI=;
        b=LZnZ1bO16Z10cK+GeXjVycIR+E6l/fb08puuEPHOAnbJnj/z8ohJ5zYz5Jw+hBGO/a
         2DK5bIhwPPznYWs+/JR++JzZ7jlCk9knGYDP9pVNqumf2bQ90IXnvn+Hml9M7RGow8dI
         JWuuPYKUSB4JaIjY8UOm547kDD91M6RPFC/5H+dmIxBq3qnoeZ8sYOC29JWAykJQi6/o
         0kfI/B3XrFGt50Sm0fTeJn/1rF7TOp9THwESLVLazn9QpbP7QVakU1NqdoQeGMZHtssx
         i4ndOmg13oTQUgyi3G08oD1arT3RhepXxBzAHiSuxgBIxoSYmaPddd2FO4GFN4K7rkhE
         ViLw==
X-Forwarded-Encrypted: i=1; AJvYcCVrDZbAL7ioJZ1cziJTZsyRVfXL6eLC1YWwYSzD2D1CqLNWJ4HAxbUkHpPp0PQnElwP8xdtPgwvLb0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqkE2ipWSAJugNTasv+HHNNPLyoVEp5l6HXU8ITz0bAatXFRP0
	K414PTAcdyCqtXyQC0RNmhsGVS2R5hTG+FL/sXp/9vYu//s8F4NH2nvid7wwzNuFetSf/leU8C0
	P8jjEYredAu2uoElKFc7Ip1TqRHeh1X+RsV7jmWLsZwam4BvEaBesLKGENw==
X-Gm-Gg: ASbGnctxhtUT1Hd34NDnS8m5dIkXNgQukzp9IcCjsm/thRYu+zkmvIWNlIi7gmN2xR/
	3eLWgKiEIRcvkE9Dv6uC0Iu96DBltYBaGk6MbOk/TlhMB03clEinoLjHbWKpJTJj0E2klAI1y0N
	dgoVQJtvaBsi9aaYual3TUbARzWPSftY7iE16BcaaI51Ec2+xBq8LodF9jJsNcVbuVBjx1jhPFq
	nG0uaAcHLqDkYg9EAdSf4RuQJBzgdPSWkcrkp73LpAVj7IKnyQnb+9QCfcvek5eW0kCvzqg5H5G
	VLZdg+P4PXEelcn42NASz1cyFHq2QyweXZXSGoktR9VZULEqbtdhGPBgdYNroZ421Eyf2yVClsT
	dJGn9ouzhnTn13caPn/Xz+2ITfI+jtOorTb10lW8=
X-Received: by 2002:a05:600c:19cc:b0:43c:e7a7:1e76 with SMTP id 5b1f17b1804b1-441b2634d59mr14747675e9.1.1746003744684;
        Wed, 30 Apr 2025 02:02:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPkqg071oBTCMv5yXkndW9/oYqy/4WUrpgNaM6fWdgfaRVDQrbkV4ZKrIu5wdVxfGbOISQzg==
X-Received: by 2002:a05:600c:19cc:b0:43c:e7a7:1e76 with SMTP id 5b1f17b1804b1-441b2634d59mr14747405e9.1.1746003744372;
        Wed, 30 Apr 2025 02:02:24 -0700 (PDT)
Received: from ?IPV6:2003:cb:c745:a500:7f54:d66b:cf40:8ee9? (p200300cbc745a5007f54d66bcf408ee9.dip0.t-ipconnect.de. [2003:cb:c745:a500:7f54:d66b:cf40:8ee9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b2ba48b0sm17027745e9.10.2025.04.30.02.02.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Apr 2025 02:02:23 -0700 (PDT)
Message-ID: <0dbcbb75-9d5d-48ee-9bbb-02eacd856aaa@redhat.com>
Date: Wed, 30 Apr 2025 11:02:22 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] mm,slub: Do not special case N_NORMAL nodes for
 slab_nodes
To: Vlastimil Babka <vbabka@suse.cz>, Oscar Salvador <osalvador@suse.de>
Cc: Harry Yoo <harry.yoo@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, linux-cxl@vger.kernel.org
References: <20250408084153.255762-1-osalvador@suse.de>
 <20250408084153.255762-2-osalvador@suse.de>
 <92ff4f7f-90d2-48ab-8f7d-7fc3485276b5@redhat.com> <Z_UwPmyxyu8YNLG_@harry>
 <b26b32c9-6b3a-4ab4-9ef4-c20b415d5483@redhat.com>
 <d581417f-7756-4ce7-8a5a-49149db33b8c@suse.cz>
 <60ae4d6b-3ace-482b-9945-1261003f3785@redhat.com>
 <aBHjt9D7m03FOPCJ@localhost.localdomain>
 <f06d735c-894a-4c93-bd1b-817e9e978be6@suse.cz>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <f06d735c-894a-4c93-bd1b-817e9e978be6@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lwKrDY965AvnkwyIga_W7adBSRK3RzDetUURO5ddL2s_1746003745
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30.04.25 10:57, Vlastimil Babka wrote:
> On 4/30/25 10:47, Oscar Salvador wrote:
>> On Tue, Apr 08, 2025 at 08:18:32PM +0200, David Hildenbrand wrote:
>>> We could by grabbing the mutex in MEM_GOING_ONLINE and putting it in
>>> MEM_CANCEL_ONLINE / MEM_ONLINE when a node is going online.
>>
>> Hi guys,
>>
>> After a few busy days I have been revisiting this.
>>
>> I checked the proposal of slab_mutex spanning GOING_ONLINE <-> ONLINE,
>> and I did not see any issue.
>>
>> The only concern I had is that we might be calling some slab function from
>> {online,offline}_pages() that also takes the mutex.
>> I am not aware of any though, and quickly checking did not reveal
>> anything either.
>>
>> If there is any will be quickly revealed though :-).
>>
>> So, unless there is an opposition, I can move forward and see how it
>> looks.
>>
>> Thoughts?
> 
> I feel a bit uneasy about it, while maintaining slab_nodes doesn't seem like
> a huge issue to me, so dunno. Maybe David has a better idea now :)

Yeah, let's avoid the slab_mutex change for now.

-- 
Cheers,

David / dhildenb

