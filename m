Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D81269CF5
	for <linux-cxl@vger.kernel.org>; Fri,  9 May 2025 05:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746769805; cv=none; b=gGzBGDG0gd9jhQ+AKpD+BtNVKUbqVTc3yPQicRl5a+E5h+1ZDXShNOme6BRWqVCXh0iCKcpAEgleYaLP4XUM2VlKieXlZPBmwDnAE/F455dxOYcgUMPVEqJtJ+SKR+9qVB3kPBlYv+Nbq4upjg417H+x1leLeIApLXnD4e+hcwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746769805; c=relaxed/simple;
	bh=ZA0MrnVqPmGqRqvds91nIAY/X0tkAPwaQfeJInh43CA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YXx4U7mvogCPM9ePRhXYNC1mbL8dhQZKcQrEZBeVKeLqrko6FLFAOeHC6mLcI3OWUY8kXxP251YvzDnkpk+QJRAAxKlYiDemzdfRuarfQHrhvKB/JwFdTQFqcsmB8RLqymxLu9Cyeti9dd+dxTKgRBfzCDzLwL0H8rQgJlqKHh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=P8HoKr3T; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="P8HoKr3T"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c96759d9dfso285575185a.3
        for <linux-cxl@vger.kernel.org>; Thu, 08 May 2025 22:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1746769802; x=1747374602; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cz9N1KWOckoEyD/I2Q+cFcf/PqZ2i2IlArKDvKjy79k=;
        b=P8HoKr3TDkxDKvKFyXTUpyUgQPCyhENcwzxSGt25Oco4ltNmU1cmIJhJDaDhHYkNZI
         VkM8ggnvadlB9dO0lls49cF/t8tAe8mduFziFSx3jrriXSRMJeJYQfC8xdkCebMKq3AE
         cLH9v2GkVRIibhoU5Yc/VsYNOICWQajnbGYCeWm+R1XL2oV2Ud8BSYpL25ILGsZTOvqn
         l2bjMFLLbdMhq23HmpE5sCnjmvn67drs9IsazKa7qry9nNAHjcIJ+5ZD6oE1C/plGgmG
         2lEi75NXeLcVV6NAHphVxgGDjLYrvLFils1N5AsOP4+pY1uo9q0KMygo8YqHt4vTIuhy
         6Bpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746769802; x=1747374602;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cz9N1KWOckoEyD/I2Q+cFcf/PqZ2i2IlArKDvKjy79k=;
        b=giogcDDuqAuFxy1dkR87c3IfMC6u5lwL9e+DdvCbwYj0DyBeIa3WhBRCxSX30D6jaO
         zg8wgdnPEZflWkbz+sQTH2tXnaoEqjYhwgUmQB0ocPmzOnkeqn06VB33kNZhRkrxgpg4
         Mh3CcqQIWX8fqJauBLHvFsHIm89LvPuW80AV4+7WDBLNFrI39AuZnCuxWKHFeO0h9UvR
         EBRdbqG7KQ6ndX3zhY/cm147Hpp/KSsECTs9A8+KD+lgaD4HLP1Od2KmvQwfqmAk9VgI
         tSVJIcWgJHMo0Qf4Ve1v/7M0foez1qNnEenzXTRKBumj7W0M4JhCQwncBlyC4NIsZ2wo
         jRfg==
X-Forwarded-Encrypted: i=1; AJvYcCXfEF0aOoG7BQjtjN8erfX1FqKk7ErBIEnkczDBwwqIY/de/etFWrI3RtmteYhlJZBwhDQJRCSY++c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEgKmILiLYZrznV7N06460NzuBkSTHAMjmcJpHOnv+/87qsyCn
	MGoBcpfHElppjedP6ybgnj1vjrVpgaxYRneyplcazMaWMvglxmvDXif4zEv8Wro=
X-Gm-Gg: ASbGncu7kG8FI8FfT0Yi2+Wr9b6UUeOdBZm9NmbPFqBWxY7aOeo11ATCCZ4YyKXES2x
	o0VPiERJu5i+xTQRIoMkVle3ifcio7mltwVZu1Gtq6yKckfLORmThbu5wCfhPoUuwHV7fU1Xxoo
	rfoKg5sjyzjqnnyj2211KoKeVtKVmzX3qjChbKYt41KnE+jXrV7nvZfCaDxLSrZpaGGEl6Ttq/J
	/YgKKoHrTKcZVEPvX6jikffdT5RUNJ7JF/5ojtyFzbkBXC5atc3xZmZilImzvpTxDtxIjywy1FY
	0yMZJSYGTYNv81W6kSn9sDmTEiFKAsykT4GmIl47LWhS6TvBliZqclMfWsXH2kotzyiw52L7lce
	lQorNoMTjoYaLNAP541g8
X-Google-Smtp-Source: AGHT+IElqWip8aE/2idz6dfBS7ZlxOEMPHoBzrDhBd78If8/KiDXUWfsyQmB3CNHzKfet4ro2QMMdA==
X-Received: by 2002:a05:620a:319e:b0:7ca:e971:8335 with SMTP id af79cd13be357-7cd010d51ecmr362007285a.8.1746769802047;
        Thu, 08 May 2025 22:50:02 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-42.washdc.ftas.verizon.net. [96.255.20.42])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cd00f4e1a5sm94081385a.13.2025.05.08.22.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 22:50:01 -0700 (PDT)
Date: Fri, 9 May 2025 01:49:59 -0400
From: Gregory Price <gourry@gourry.net>
To: Rakie Kim <rakie.kim@sk.com>
Cc: joshua.hahnjy@gmail.com, akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	dan.j.williams@intel.com, ying.huang@linux.alibaba.com,
	kernel_team@skhynix.com, honggyu.kim@sk.com, yunjeong.mun@sk.com
Subject: Re: [RFC] Add per-socket weight support for multi-socket systems in
 weighted interleave
Message-ID: <aB2Xh4jEqpSTuvsi@gourry-fedora-PF4VCD3F>
References: <aBzJ42b8zIThYo1X@gourry-fedora-PF4VCD3F>
 <20250509023032.235-1-rakie.kim@sk.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509023032.235-1-rakie.kim@sk.com>

On Fri, May 09, 2025 at 11:30:26AM +0900, Rakie Kim wrote:
> 
> Scenario 1: Adapt weighting based on the task's execution node
> A task prefers only the DRAM and locally attached CXL memory of the
> socket on which it is running, in order to avoid cross-socket access and
> optimize bandwidth.
> - A task running on CPU0 (node0) would prefer DRAM0 (w=3) and CXL0 (w=1)
> - A task running on CPU1 (node1) would prefer DRAM1 (w=3) and CXL1 (w=1)
... snip ...
> 
> However, Scenario 1 does not depend on such information. Rather, it is
> a locality-preserving optimization where we isolate memory access to
> each socket's DRAM and CXL nodes. I believe this use case is implementable
> today and worth considering independently from interconnect performance
> awareness.
> 

There's nothing to implement - all the controls exist:

1) --cpunodebind=0
2) --weighted-interleave=0,2
3) cpuset.mems
4) cpuset.cpus

You might consider maybe something like "--local-tier" (akin to
--localalloc) that sets an explicitly fallback set based on the local
node.  You'd end up doing something like

current_nid = memtier_next_local_node(socket_nid, current_nid)

Where this interface returns the preferred fallback ordering but doesn't
allow cross-socket fallback.

That might be useful, i suppose, in letting a user do:

--cpunodebind=0 --weighted-interleave --local-tier

without having to know anything about the local memory tier structure.

> > At the same time we were discussing this, we were also discussing how to
> > do external task-mempolicy modifications - which seemed significantly
> > more useful, but ultimately more complex and without sufficient
> > interested parties / users.
> 
> I'd like to learn more about that thread. If you happen to have a pointer
> to that discussion, it would be really helpful.
> 

https://lore.kernel.org/all/20231122211200.31620-1-gregory.price@memverge.com/
https://lore.kernel.org/all/ZV5zGROLefrsEcHJ@r13-u19.micron.com/
https://lore.kernel.org/linux-mm/ZWYsth2CtC4Ilvoz@memverge.com/
https://lore.kernel.org/linux-mm/20221010094842.4123037-1-hezhongkun.hzk@bytedance.com/
There are locking issues with these that aren't easy to fix.

I think the bytedance method uses a task_work queueing to defer a
mempolicy update to the task itself the next time it makes a kernel/user
transition.  That's probably the best overall approach i've seen.

https://lore.kernel.org/linux-mm/ZWezcQk+BYEq%2FWiI@memverge.com/
More notes gathered prior to implementing weighted interleave.

~Gregory
