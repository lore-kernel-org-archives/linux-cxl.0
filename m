Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91AF21B9F6
	for <linux-cxl@vger.kernel.org>; Tue, 18 Feb 2025 19:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739906767; cv=none; b=IjjO1TPYqWjk4yvDMDkuKeW+TIFNXRzPIGZ7mvXVgKTzZvRsZh4unhIVLugmJ30gijwdapKHkSAJUsQcR4w9fgwDkE4SsPR4liR4pjnbYQUNRM4CP1p+RmESm2MI+sUke03Qiz7bmMWjx4FFH9w5FtFA2r1uDMlOou0A/3fzONA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739906767; c=relaxed/simple;
	bh=nwJk52yHaYxvd/snVr31b0tcpHkXR77LuokApJ7Vcpg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CTGxKy8EydgLU7Cx/ibwn0ZyExZLVFyQ/7As2fCcXbJxzYII5TgSlNGINIDxN99SnCwT9FHPfMygXGnlm0kf2DyhjUbHf+NdI8ijWL6WiIGHA7XftufE6wceQgzvR4Ea+VPKOeG6HF3REo1+CYR/pkwIpdpPzb32kI8Fv78FNJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LavVP5OP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LavVP5OP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739906764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ZheJrrl/+szmf1Pt3zwPzLYDDz3uD8c7iU2qgn0Duac=;
	b=LavVP5OPfytaORura71gFylcvBgwm3Kdyub3wBmSQIUOf0FSBVN3uPkMSi+BAOtJ3RhPmm
	OYs4sLef5XNt2jVIJH/YtMuzNBT0k69torwe55ucrlX1q1mBJoAIS4vU/2czcGzNeYJjFO
	XxuURvcE4MblAn0jtxezNEPtLNr7lDk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-_XQriAHqOeqPEbIvbhvozw-1; Tue, 18 Feb 2025 14:26:03 -0500
X-MC-Unique: _XQriAHqOeqPEbIvbhvozw-1
X-Mimecast-MFC-AGG-ID: _XQriAHqOeqPEbIvbhvozw_1739906762
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-38f2ef5f0dbso2168708f8f.2
        for <linux-cxl@vger.kernel.org>; Tue, 18 Feb 2025 11:26:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739906762; x=1740511562;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZheJrrl/+szmf1Pt3zwPzLYDDz3uD8c7iU2qgn0Duac=;
        b=s/7NYy11sjuw6HODadiR8U/NGR+KXgNBT5D/DTjkxdz6JStvkefyI+3OgoL/SMnOZw
         ubuUGxauReuxQjbFA3EbyGMqbcT48tw9jSnrNsBQ+BL/4Jy3kxF8Nd5EXyT+mAu9fg/K
         3dJinGNeS9iIMfxuFahrFssWKrfOSDchfL1X7HhFKzXYLLoHVqNYnQ4ac6rwlJjlhMrE
         im4BEFXizeDvVUw76XjMLMFgxtIL5rY0gv2TBBW+1OPSW+zRRzFXOoxJ2onlTJYgF7Xg
         V6e94UARVtyz2FelSoWNSJHmz5K6oQh24/Uuu9n65FNN3Q/8XCTgm+sJaOM1nhu/pBpD
         56TA==
X-Forwarded-Encrypted: i=1; AJvYcCXnFICbY7GcfId5LuuGQF+PVTRJyHBZ29xkhrHHdylrSJqYcJgRH/zzZnudRKuxtAHilzbLievJFkk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ4xjxtwaSltO3Ko2gPQO19u1OqRs0RNK636TCdN/GrnNM3ue5
	aZyZoT2Ca3gAYdv1nH5gv3MERKv5fqhqXCSoyJ83cBMO6oPL5bveeLmcWQdvyGZZr0YCV8QVGlC
	3+PnoL3BzzoLIHTL/jtJ5h+4agX7/oi6kuF9q0f2ZOqEguSX/6a3OKoYa8Q==
X-Gm-Gg: ASbGncsoM9LZ1N3rODMyxjk8eq2rzbtkIsoJ7wFcvk48fy71OZPUvdFZeHU5wtdxGDL
	K8OKyPG7rUXM96YcfPpSks6YPTn8TjriWeRkQmJqaJ32csOJWrYhQMYmViIcGnubwHYu+UqZdyA
	SlEQxxa2SaOPeYnnYS0GdQI66RXmgZfRAtZmGFHTRpuEMBBQ6bBaBR0m7m5rIIMGvIRsW6Kfdey
	Gf3Ib6AHEgp93zjBkn54x6k3wZ57WRAOldSvNRQhaJ0yoAlf0py7KXAnM/PBSLl2Ut63u801juE
	m2G/AJ9kMyCMMoon76NRNMvFwle5vnHxDCltxEWQJhYa6mOVcPJ9alajkmnAqA7zVYSPSN9T+jw
	UtPOigHXgW9kEhu6I9owL/amFQaunbsTI
X-Received: by 2002:a5d:6c63:0:b0:38f:4b2c:2475 with SMTP id ffacd0b85a97d-38f4b2c255amr6889150f8f.20.1739906762342;
        Tue, 18 Feb 2025 11:26:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE2+TxYTALjdCrXK7nzVIJ9gqCfpVhvtmHfRY7+jlAoZQBF7tynDq9Tork1X9JveH8HiTXnNQ==
X-Received: by 2002:a5d:6c63:0:b0:38f:4b2c:2475 with SMTP id ffacd0b85a97d-38f4b2c255amr6889130f8f.20.1739906762005;
        Tue, 18 Feb 2025 11:26:02 -0800 (PST)
Received: from ?IPV6:2003:cb:c70d:fb00:d3ed:5f44:1b2d:12af? (p200300cbc70dfb00d3ed5f441b2d12af.dip0.t-ipconnect.de. [2003:cb:c70d:fb00:d3ed:5f44:1b2d:12af])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258fc7ecsm15598329f8f.49.2025.02.18.11.25.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 11:26:00 -0800 (PST)
Message-ID: <1b4c6442-a2b0-4290-8b89-c7b82a66d358@redhat.com>
Date: Tue, 18 Feb 2025 20:25:59 +0100
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
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Z7TLwtQY3vGUw2bO@gourry-fedora-PF4VCD3F>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Fg9mefaKJ4BO6-Z_g_kj4S0oOyjCYn_gh3jlZPOG7n4_1739906762
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 18.02.25 19:04, Gregory Price wrote:
> On Tue, Feb 18, 2025 at 09:49:28AM -0800, Yang Shi wrote:
>> On Mon, Feb 17, 2025 at 12:05 PM Gregory Price <gourry@gourry.net> wrote:
>>> The node ID passed in as an argument is a "preferred node", which means
>>> is insufficient space on that node exists to service the GFP_KERNEL
>>> allocation, it will fall back to another node.
>>>
>>> If all hot-plugged memory is added to ZONE_MOVABLE, two things occur:
>>>
>>>    1) A portion of the memory block is carved out for to allocate memmap
>>>       data (reducing usable size by 64b*nr_pages)
>>>
>>>    2) The memory is allocated on ZONE_NORMAL on another node..
>>
>> Nice write-up, thanks for putting everything together. A follow up
>> question on this. Do you mean the memmap memory will show up as a new
>> node with ZONE_NORMAL only besides other hot-plugged memory blocks? So
>> we will actually see two nodes are hot-plugged?
>>
> 
> No, it creates 1 ZONE_MOVABLE memory block of size
> 
>                     (BLOCK_SIZE - memmap_size)
> 
> and as far as i can tell the actual memory map allocations still
> occur on ZONE_NORMAL (i.e. not CXL).
> 
> So you just lose the capacity, it's just stranded and unused.

Hm?

If you enable memmap_on_memory, we will place the memmap on that 
carved-out region, independent of ZONE_NORMAL/ZONE_MOVABLE etc. It's the 
"altmap".

Reason that we can place the memmap on a ZONE_MOVABLE is because, 
although it is "unmovable", we told memory offlining code that it 
doesn't have to care about offlining that memmap carveout, there is no 
migration to be done. Just offline the block (memmap gets stale) and 
remove that block (memmap gets removed).

If there is a reason where we carve out the memmap and *not* use it, 
that case must be fixed.

-- 
Cheers,

David / dhildenb

