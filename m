Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873C2213E61
	for <linux-cxl@vger.kernel.org>; Thu, 20 Feb 2025 19:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740079591; cv=none; b=szelo6OOiZvOq4kYWceVeMERJfYdhbFHfkgqMvvuQfBeEi2v/Kwtc/FeTPi/WSO6NtkiUHn7nv5wiAmOxs1R8WvJeO3UFA79rYqWjmwBE40aHEolDT+3Qttc5jhczXJe0uyMshKFfu1dG4Kt1G9k7xl5TFsOP7+NsFtgb3sS2Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740079591; c=relaxed/simple;
	bh=8bCxreR7sk/IeNRpWmX/cXsQs0NvKoFazceujYFolhE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rFP24LToD0hmeYUruHXCzwuHKBwwgfxf+IWLW/rAZQjx0xgJxTBTVUQe4+bE13kNCHKUuFuaQMiL/vrWqrQx+4JAZFrsBzS3WE5HhcY2uOM43USxRZ65iW+lp7+yCOAZq0DgCU9wAgM3888q0kloZj+4lt93gF2QFu/8uaiTFKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YkYESgYW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YkYESgYW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740079588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=irSBqz7swEwN7V0gLT8/jmltTtJjErnbhzJ+tCBY6ps=;
	b=YkYESgYWXSMGGWLdGYWwxKec3vO6D+3pdpDHpxg7dWdUqqOnEM+IBFKzwfPC12OKes8X7a
	5jbTXuqzy25c5IPm9CW0nK1ERTCe09Br9wKxPrEoKYPTAG/i/hP5vcaQg9cv9bk62XFGcz
	kUgqA+8E+DyHSlkqto32eONXbFi+S7Y=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-97lHqIhJMfaE6wYP4USBxw-1; Thu, 20 Feb 2025 14:26:27 -0500
X-MC-Unique: 97lHqIhJMfaE6wYP4USBxw-1
X-Mimecast-MFC-AGG-ID: 97lHqIhJMfaE6wYP4USBxw_1740079584
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4399a5afcb3so13523655e9.3
        for <linux-cxl@vger.kernel.org>; Thu, 20 Feb 2025 11:26:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740079584; x=1740684384;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=irSBqz7swEwN7V0gLT8/jmltTtJjErnbhzJ+tCBY6ps=;
        b=rqRzKlb5bOsIM+i2YaIw0H93TWz5EG/rsE4SEkJ4LEZUpsZ8cf7bl5nofQbl0bJM47
         igqYsJjZtWJRS5gsF2n/IP/xPK/FQYnHLy/AXlc+figPYuGab6gsnuTtgCRtX7OzWSgh
         Wr+gIV19zxShuh08X4Z0G+ttr3todcnT+4MoBAG6El+aosJ1SZUpdgHmqLMGVfvWKwGq
         AOky36F95J/c47tkFx5pSYkS2W1eMnWSCn6apBpigqrGGIlm2NAfSdWv4ZAQkhPJPBKf
         YxLjwYPrLk+LmG6klU41ZZ/dtzPZ/zSDvrem7xqyK0bYsL80FzILW/LLJ+xK8nXYLAIR
         5lRA==
X-Forwarded-Encrypted: i=1; AJvYcCWghnavzSTaRB096DcOdRxUMogotbE8tTF5//z7+4BSfcsro5TkxeP3wLshVK2XKQDXs5/Xx68l6D4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYIIlh6mNWUylfBl+ISYTCD8ilEmWPTUsb/W/h8EykQ2KpbZ44
	UXfiCA/lZqahqZ9PCiMQCpNTF9s9N7+bkiiPVo8zi6gyGApQeSBnwG6FgTgUvr8UPoIdpfal9JB
	j08a8l0xeLtwJrF0R1HGXgdm4HE3sLuhBw2LKPlUq3AkrkVY1OdymDw2U+w==
X-Gm-Gg: ASbGnctVE+/A6lCibg3vfa0Zr48dbe5y1sC/uvI7W72W/KUlJSRqEOQRqUiEnFsKBqd
	uve7idAtLqHGqeeJOoAvx6IabZC+1BeCAHPndo6ZaJ1spys6D4ilSlBhmS/0Qeek6EYNBJvP6iu
	WtKnbKwszht7HtXDzB4xD1t4cuLfWqoqFM6P9wvN67La0XGNaz/R+Y9ly7DjAXk1TI3DSSr3iMk
	5ROsYM+5bbhdNrVUF/Oh+Wuv6FNGf8IDnodflLkIW5FHNvgnP7+6IgNA+VhyonwfyFn42V+go7M
	ubC1ihowZcK37TxjSZ6AlxR43TiWWMsXOA==
X-Received: by 2002:a05:600c:5487:b0:439:9d75:9e92 with SMTP id 5b1f17b1804b1-439ae21e3cbmr4188315e9.28.1740079584581;
        Thu, 20 Feb 2025 11:26:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF+Wi0kRb7c6ax7rMeY2G1XU3iiMUudXyvxM+EL6SvfggdqQd/SA+4o5SHVVPJRJVKIfhYdrQ==
X-Received: by 2002:a05:600c:5487:b0:439:9d75:9e92 with SMTP id 5b1f17b1804b1-439ae21e3cbmr4188125e9.28.1740079584237;
        Thu, 20 Feb 2025 11:26:24 -0800 (PST)
Received: from [192.168.3.141] (p5b0c6195.dip0.t-ipconnect.de. [91.12.97.149])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d5c36sm21652394f8f.67.2025.02.20.11.26.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 11:26:23 -0800 (PST)
Message-ID: <4ae838ee-b079-408e-8799-e9530ca50417@redhat.com>
Date: Thu, 20 Feb 2025 20:26:21 +0100
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: CXL Boot to Bash - Section 3: Memory (block) Hotplug
To: Gregory Price <gourry@gourry.net>, Yang Shi <shy828301@gmail.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>
 <Z7OWmDXEYhT0BB0X@gourry-fedora-PF4VCD3F>
 <CAHbLzkq6Me6nRaL6b09YxJ_nFkxb+n+M3-q_aJwOs2ZO4q8VCg@mail.gmail.com>
 <Z7TLwtQY3vGUw2bO@gourry-fedora-PF4VCD3F>
 <1b4c6442-a2b0-4290-8b89-c7b82a66d358@redhat.com>
 <Z7TswQbpPV590ADr@gourry-fedora-PF4VCD3F>
 <bda4cf52-d81a-4935-b45a-09e9439e33b6@redhat.com>
 <CAHbLzkqDQcrHLPzk8n0SMgkidH2ByCqdwfYXX=uBPQfOArWf8A@mail.gmail.com>
 <Z7d3vVdJ8UWU5oex@gourry-fedora-PF4VCD3F>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Z7d3vVdJ8UWU5oex@gourry-fedora-PF4VCD3F>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2lW2QQ63wcW_yn_kUTPUZQp3qSA3H6M_UQrN7Snywy4_1740079584
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.02.25 19:43, Gregory Price wrote:
> On Thu, Feb 20, 2025 at 09:50:07AM -0800, Yang Shi wrote:
>>>> I will double check that this isn't working as expected, and i'll double
>>>> check for a build option as well.
>>>>
>>>> stupid question - it sorta seems like you'd want this as the default
>>>> setting for driver-managed hotplug memory blocks, but I suppose for
>>>> very small blocks there's problems (as described in the docs).
>>>
>>> The issue is that it is per-memblock. So you'll never have 1 GiB ranges
>>> of consecutive usable memory (e.g., 1 GiB hugetlb page).
>>
>> Regardless of ZONE_MOVABLE or ZONE_NORMAL, right?
>>
>> Thanks,
>> Yang
> 
>  From my testing, yes.

Yes, the only way to get some 1 GiB pages is by using larger memory 
blocks (e.g., 2 GiB on x86-64), which comes with a different set of 
issues (esp. hotplug granularity).

Of course, only 1x usable 1 GiB page for each 2 GiB block.

There were ideas in how to optimize that (e.g., requiring  a new sysfs 
interface to expose variable-sized blocks), if anybody is interested, 
please reach out.

-- 
Cheers,

David / dhildenb

