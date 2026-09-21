Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF164D4895
	for <linux-cxl@vger.kernel.org>; Mon, 21 Sep 2026 16:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790009308; cv=none; b=RuXLNGXVMVm9EeXH/rXoWRJdpvu+VN5GvOLuUozzMS9/bxrHUEdLh8HiU81txPnGY+HAK79Z8/67VKGx7mOYc+njjR/HPznnH059F2RLsT0myoXjvZCw0rWpq2jBWvLPhL84MLr0X/duR7WsT12Aogv7W9Ufz7S0Wf+A0rvnW6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790009308; c=relaxed/simple;
	bh=Y281zkM/Qmo9OSGui1K8yVeXfs0hDkEf9zNmUTSMONA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iw0jA61gMlC9bznTi8sUtnorMy27Dn+SJRuaSWzhDQFJsePrxmEwKvKwBHpTb5Abhs9IN1xj+vJPIT4fW3A9twxpSZdDZC0WPZj7ubQK7qKycq3BGDa2iISezqt7YLOQw1aIeiMytZTbb7NSaPlrHk+iyzRBVIxpaGEFz9iqXl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr; spf=pass smtp.mailfrom=snu.ac.kr; dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b=i7IxOuaB; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b="i7IxOuaB"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccd66bb4so2793638a91.1
        for <linux-cxl@vger.kernel.org>; Mon, 21 Sep 2026 09:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snu.ac.kr; s=google; t=1790009304; x=1790614104; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PmR+gFnwjwx9HRJSW244xTdy4CpVHKmXxMQ0vpvGnEg=;
        b=i7IxOuaBbbKOMBUBrXKkslJQuAbP8WoIgXp7kMS1idjIphj+mUBRVVFGp55KcPSs06
         8KZb0jI8fJvJbQccXljwLmmS8lbGJtjup9Eg4RW0K+mhUFIh1dDmCCJIP8gsqLWI0pD/
         gurC4tPRF97yOOpUvwqxHbH05BYm9U9QmZ3Gc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790009304; x=1790614104;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PmR+gFnwjwx9HRJSW244xTdy4CpVHKmXxMQ0vpvGnEg=;
        b=gwAPUqgJ9oQtGCF5yvSOqmQxkv2CCcKHKELsPiXFxAE3lEwkPK4xNQMejj65lR+5cD
         pc1ldvHmPhnRht9ozKnHdRQiBzJiIJZZ1SCu//rILMFU8pX9VQVivskgjzBaUHou0Xg4
         eQXIAnLcDRUUj82iFnMXE9M/Ow7vN/68s6/crG751touMj2MXs7nN7ewaB5A5vp6h1QM
         p0Sl+pBv9BhlqY547imwr7s5I2RjatCXZRX7gDSo+ts1aOv8iy/lO97zERcA1cbUWj18
         xB/f9TTar7ik8G82PS2Hvgouy6oCWr5l9VlAnstjSJX+Szmc/lhFItlgtZrDf+TeVIQT
         W9/Q==
X-Forwarded-Encrypted: i=1; AKwUvByETu4ALTYFWFSzZa0dosyS0VYtmSngM9ptGXo6yRz1RdLQB2OMGeH0mCqGRnbR0d/PyD98QWgsEJg=@vger.kernel.org
X-Gm-Message-State: AFuF++kDe9F6F5WAa+iFS6+cQsa+GBVOg8LJqtd+L/1WPjDNlecpQ/G0
	Iap3gwHMvZKxiDvRa9vROg2KOSYyfW0P3NfQVFO/HY7QAXWFHiQfgm3m3KxRI71u0LY=
X-Gm-Gg: AYBFou1f+sc8GxXl07bKGHjMvz458UOi2VbT6Q3oedpcpuVddPdSGcuOqNvFE6nZos2
	kwqrFqn0GO3DcR/Qhmu4bTjRffDpd34TTNprQ9sGeT47tXDQt6jn7AjE1OAtsqSN0ClscB4b4nc
	qQudi3XCDtA02AdHQysQQo2sSxWYXCEwP7eQnP8fNH1i9n/EPEwBA8pVbasP52TsuR24+0TsZ0u
	EOdwaq4H+Ma0GLCO9jy6mnVmnG7MnTUv4NeEpgQecOZtSbDWfWlhFl4rJni1He4y8cgEyIAkiL6
	9OAUg5o2WSIbK3nDUbtXUo1OAofn4a806Z4LnZSTXtzE8PbmKgSZsYcdw3/kXiSEY1ZWtYzKQvP
	W9ZdLPhuIt2xKHztk9hp4WTyqDxhQh8ULOIKod2SerYvL3/yh9nBwqVjn3gWoYkA35O++i9nkDm
	CQfWlAeTobOBKOoIGEEsKYGAODnDFa8DVjs4Jj5VWecels0LKiXC4iOnqDR8nDfuRbgQ==
X-Received: by 2002:a17:90a:d888:b0:39e:4c7f:8b16 with SMTP id 98e67ed59e1d1-39e54cf8bdbmr17750548a91.27.1790009297592;
        Mon, 21 Sep 2026 09:48:17 -0700 (PDT)
Received: from 1c1aead48890 ([49.142.45.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0673209b7sm148455a91.16.2026.09.21.09.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 09:48:16 -0700 (PDT)
Date: Mon, 21 Sep 2026 16:48:10 +0000
From: Seongjun Hong <hsj0512@snu.ac.kr>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Kairui Song <kasong@tencent.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, Baoquan He <baoquan.he@linux.dev>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Brendan Jackman <brendan.jackman@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, Oscar Salvador <osalvador@suse.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>, 
	Kieran Bingham <kbingham@kernel.org>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-cxl@vger.kernel.org, driver-core@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 09/12] mm/sparse: remove SECTION_MARKED_PRESENT
Message-ID: <vpz5zqg5nwbpolxbkip45vxxdt3lni7j2haal7q42skc3b57tu@uh4cec4x32dq>
References: <20260909-b4-sparsemem_cleanups-v1-0-008fc8d579fe@kernel.org>
 <20260909-b4-sparsemem_cleanups-v1-9-008fc8d579fe@kernel.org>
 <aqK9S1hBpPnujgz9@gremlin>
 <eb5b465b-c256-4454-84de-517aefcd6d59@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb5b465b-c256-4454-84de-517aefcd6d59@kernel.org>

Hi David,

I'm sorry for the delayed response.

On Thu, Sep 10, 2026 at 05:11:36PM +0200, David Hildenbrand (Arm) wrote:
> >> +++ b/scripts/gdb/linux/mm.py
> >> @@ -76,7 +76,7 @@ class x86_page_ops():
> >>              self.SECTION_IS_EARLY = 1 << int(gdb.parse_and_eval('SECTION_IS_EARLY_BIT'))
> >>          except:
> >>              self.SECTION_HAS_MEM_MAP = 1 << 0
> >> -            self.SECTION_IS_EARLY = 1 << 3
> >> +            self.SECTION_IS_EARLY = 1 << 2
> > 
> > Seems a bit strage given the code is:
> > 
> >         try:
> >             self.SECTION_HAS_MEM_MAP = 1 << int(gdb.parse_and_eval('SECTION_HAS_MEM_MAP_BIT'))
> >             self.SECTION_IS_EARLY = 1 << int(gdb.parse_and_eval('SECTION_IS_EARLY_BIT'))
> >         except:
> >             self.SECTION_HAS_MEM_MAP = 1 << 0
> >             self.SECTION_IS_EARLY = 1 << 2
> > 
> > Whereas other variables must be available with no try, e.g.:
> > 
> >         self.PAGE_OFFSET = int(gdb.parse_and_eval("page_offset_base"))
> >         self.VMEMMAP_START = int(gdb.parse_and_eval("vmemmap_base"))
> >         self.PHYS_BASE = int(gdb.parse_and_eval("(unsigned long) phys_base"))
> > 
> > etc.
> > 
> > Is there some weirdness with gdb? Or is it maybe because there are some configs
> > without these symbols maybe?
> 
> TBH, I have absolutely no idea and I was asking myself the same thing (but
> decided that I couldn't care less about a python gdb script).
> 
> This code was added in February:
> 
> commit 55f8b4518d14b7436f70defe27faba4eca0cd4e1
> Author: Seongjun Hong <hsj0512@snu.ac.kr>
> Date:   Mon Feb 2 12:42:41 2026 +0900
> 
>     scripts/gdb: implement x86_page_ops in mm.py
> 
>     Implement all member functions of x86_page_ops strictly following the
>     logic of aarch64_page_ops.
> 
>     This includes full support for SPARSEMEM and standard page translation
>     functions.
> 
>     This fixes compatibility with 'lx-' commands on x86_64, preventing
>     AttributeErrors when using lx-pfn_to_page and others.
> 
> @Seongjun, why are these conditional and the others not? Trying to support older
> kernels?

No. TBH I didn't look at the gdb script carefully at that time and just 
wanted to avoid a symbol lookup failure. 

It would be better if we remove the try statement.

Thanks! :)

--
Best regards,
Seongjun Hong
