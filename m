Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAF41EA7FC
	for <linux-cxl@vger.kernel.org>; Tue,  1 Apr 2025 09:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743500046; cv=none; b=rAA0YYfpJ9l79Slb8QAsWxKa14QDfbVjKiOq7GWLd4TzDjcSLjQQMq15VmaFAFi1rwdg1MMD5e6suUjoMLuPH/JeBSmdGmNfC29y8lnlBzxwpS51hHSpyUIc4pNXnpijSVmbeg6Snxwg8SfA5CLhzgOxV8LMtPSUj4EjRYw6HFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743500046; c=relaxed/simple;
	bh=iMKn0ausjfwYR6lIOx0cH6PZ301JCLh8GZ6gFWn89o8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W6/2ywLSzfTRlYQoLoCg5UdTiqNYBBxRKUmlWfWsSTEKrJluoSHR9Hn+Txg3DE/YQFu6sZ03sFgVDhCd52UI4BQhvMWiGHwHtqFpSU5lQpG3PZXQ9rpS9IgpsJmy4SvDRZwZv+gmXJWhnVjj56z+uQ/cHKTLh2tia57/MxLJnes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gyUDAZkL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gyUDAZkL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743500043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yLW4M7GQepknRN85JoLE8ZSwVeAqp3fUrjLO1RbXEVY=;
	b=gyUDAZkL3a/Zs2+yT2DuYvE/FBgXKJaV8APJ3qxsy1vQgaj4MdsTrjiF21IBRo5MR19DCK
	NQZWh5SV/SjLSKCsB3JcbaV2sKllF6Iixh87Z7PHTyobogyoWe1gfvfaVOPZN18MtVePH0
	V7sXPccklj9pIodiAhMvSjfJ8vGtHa8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-3zS0Jkd4PNWxSdwxhQPfMQ-1; Tue, 01 Apr 2025 05:34:02 -0400
X-MC-Unique: 3zS0Jkd4PNWxSdwxhQPfMQ-1
X-Mimecast-MFC-AGG-ID: 3zS0Jkd4PNWxSdwxhQPfMQ_1743500041
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-391492acb59so3469563f8f.3
        for <linux-cxl@vger.kernel.org>; Tue, 01 Apr 2025 02:34:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743500041; x=1744104841;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yLW4M7GQepknRN85JoLE8ZSwVeAqp3fUrjLO1RbXEVY=;
        b=NZzs48gGJ+PxDRYucYbzgKHofkpJHzfYBudMDOvvQFc+mfUIvLkhMKsXV8jgR03jN3
         V7aEOFNjAOffazFsVTpAJaNdeHiwxYUYe2Jb2aEZy4txrIir5rN1qB984SLE4YX26RjL
         CPYCY7Bixoh3pNC8D3GOcOjXY0CsD+C4nyZoPw633eDBJsDsIaFmHg2uflhXgmAZVfsq
         u7D2fhnoCX/QcYoyXZHPDJ3TQP6ECo97SAkCHy6Hb3OK84Va50zWB4bBlnl5SmBVB35B
         WGfEx0Eyniwxw0skFJB5BvCutGRB3uTM8I60S3HD1FlRxWWcKbh+3mQTDzwzk0Z68eq1
         ieDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUnz0cUG9KlJ8zbAujq/qzxhWPQ1/cfEPiymL9r2uUC5HqZGVap+GP1mFGhb8dfGAQ3cLeD5X9LFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+JjmF9pEUrjjfinRgpe0xDbqfcWgcaFM2EsNJpIQW86hxXnt8
	lFNAn2XP8cSnwiDJanNKssFw9mUzEMdUbqGScuUirEOT48rS4Tjp6RvLNok67a3mNxxcTGQJ6gD
	q2Sf74eN6l1l7bDQ9TjqlcL7pPcbyIEwIQZcnuucWtVSw5m7TyXjMv1LI5g==
X-Gm-Gg: ASbGncs6ZOPEmsXaZj8ZB45qQCVPmhcCUJ7x4vox//AMJuPy8dH9nskf54Zat6TFpMC
	nKBIgg7BP2t8C/269t5YLPsS/0UHRzeFJ3phz+FLHO0xBTjiU+TeHpgTLzm+1bPBGckluCuJ00f
	8HralXVyro7Mbvt9NOW0Z6owe3cnugeBHs8l7amKbDQsvtNO4JY2nYmtiGNlhfNzqXUJyO7y5wZ
	WZUWbP78fwz6qlxAA5R87Cm9CcLk+8BJt39Uo2noJyG1K58ioTdAF677innQaQYZTrm5q3gKcpu
	aYIMJEGqQv/NDLa3URBzqzRvTkmA8l/GUOEGUhH4CCD/K974gFjud2YX37eJMKFb6bC6TXHzfac
	BA+0L6E7hFMOou8SlWJb3AsKBBnVjvl7f+nLy2bA9
X-Received: by 2002:a05:6000:1447:b0:391:466f:314e with SMTP id ffacd0b85a97d-39c120dba55mr9972729f8f.16.1743500041379;
        Tue, 01 Apr 2025 02:34:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuhOY4h3uniqh8t2ORHDry92nujdtgLRHvSyISYtelPiE+fYAhj7bnHs3IyJZqGbkWb7WXIA==
X-Received: by 2002:a05:6000:1447:b0:391:466f:314e with SMTP id ffacd0b85a97d-39c120dba55mr9972710f8f.16.1743500041060;
        Tue, 01 Apr 2025 02:34:01 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:4d00:6ac5:30d:1611:918f? (p200300cbc7074d006ac5030d1611918f.dip0.t-ipconnect.de. [2003:cb:c707:4d00:6ac5:30d:1611:918f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b79e136sm13665091f8f.67.2025.04.01.02.34.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Apr 2025 02:34:00 -0700 (PDT)
Message-ID: <3e3115c0-c3a2-4ec2-8aea-ee1b40057dd6@redhat.com>
Date: Tue, 1 Apr 2025 11:33:59 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] DAX: warn when kmem regions are truncated for memory
 block alignment.
To: Gregory Price <gourry@gourry.net>, dan.j.williams@intel.com
Cc: nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org,
 kernel-team@meta.com, vishal.l.verma@intel.com, dave.jiang@intel.com,
 linux-cxl@vger.kernel.org
References: <20250321180731.568460-1-gourry@gourry.net>
 <Z-remBNWEej6KX3-@gourry-fedora-PF4VCD3F>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Z-remBNWEej6KX3-@gourry-fedora-PF4VCD3F>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VJPrydvbq1PN3LTsi_4FMBYyjrW974wiUwdFzzvd2QU_1743500041
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31.03.25 20:27, Gregory Price wrote:
> On Fri, Mar 21, 2025 at 02:07:31PM -0400, Gregory Price wrote:
>> Device capacity intended for use as system ram should be aligned to the
>> architecture-defined memory block size or that capacity will be silently
>> truncated and capacity stranded.
>>
>> As hotplug dax memory becomes more prevelant, the memory block size
>> alignment becomes more important for platform and device vendors to
>> pay attention to - so this truncation should not be silent.
>>
>> This issue is particularly relevant for CXL Dynamic Capacity devices,
>> whose capacity may arrive in spec-aligned but block-misaligned chunks.
>>
>> Example:
>>   [...] kmem dax0.0: dax region truncated 2684354560 bytes - alignment
>>   [...] kmem dax1.0: dax region truncated 1610612736 bytes - alignment
>>
>> Signed-off-by: Gregory Price <gourry@gourry.net>
> 
> Gentle pokes.  There were a couple questions last week whether we should
> warn here or actually fix something in memory-hotplug.
> 
> Notes from CXL Boot to Bash session discussions:
> 
> 
> We discussed [1] how this auto-sizing can cause 1GB huge page
> allocation failures (assuming you online as ZONE_NORMAL). That means
> ACPI-informed sizing by default would potentially be harmful to existing
> systems and adding yet-another-boot-option just seems nasty.
> 
> I've since dropped acpi-informed block size patch[2].  If there are opinions
> otherwise, I can continue pushing it.

Oh, I thought we would be going forward with that. What's the reason we 
would not want to do that?

> 
> 
> We also discussed[3] variable-sized blocks having some nasty corner cases.
> Not unsolvable, but doesn't help users in the short term.
> 
> 
> There was some brief discussion about whether a hotplug memblock with a
> portion as offline pages would be possible.  This seems hacky?  There
> was another patch set discussing this, but I can't seem to find it.

Yeah, I proposed something like that as well when I started working on 
virtio-mem and did not really understand the whole hot(un)plug model in 
Linux properly. Someone else proposed it again a couple of years ago, 
but it's just wrong and should not be done that way.

One could implement something like virtio-mem, whereby parts of a Linux 
memory block can be added/removed independently ("fake offlined"). But 
the whole idea of virtio-mem is that all memory in the Linux memory 
block range belongs to it. So it doesn't quite apply to DAX where parts 
of a Linux memory block might be from something completely different 
(e.g., boot memory etc).

-- 
Cheers,

David / dhildenb

