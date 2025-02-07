Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B5F1B4239
	for <linux-cxl@vger.kernel.org>; Fri,  7 Feb 2025 08:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738918672; cv=none; b=fF+Nf5eVuPp9JtL4NjdOOKU5JZ4GsWRCPxrlXrbP7b3hxvLw3rx2m+FylNB9YYqOdFEy2ReTC2cW7mjsJnwqiNx5h/YpaWI6xBDqA4RdkqQUBBCTVtnJPmNI0zvVTkxt6KjP3VBPDAKzTlwthoDeD7hDSZ8zfkIyE1PIPcLriqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738918672; c=relaxed/simple;
	bh=GcOzZLBP1nqWpmU4ehierO046jTkvvo6hp9hYlhVjFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fvhr9TvY+bl5RRXjEiE++2eVNWmHr9bh7g2KIX5tL2PiW+B+tHQXmktc+3NBScp+WJgF/9FDrb+1z/yl2I0WwfYZS7KJmlzPCPLzxsDW/st7KasQgKVDw/8+Ei2nSvp48iPFeF0SzYPxF88AlhitEhcxb6gOerxBJJ7SS7gtGx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=OR7LqJcu; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="OR7LqJcu"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7bcf33f698dso170608185a.2
        for <linux-cxl@vger.kernel.org>; Fri, 07 Feb 2025 00:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1738918669; x=1739523469; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NgvrfAQwLFovDWtM64VfstFqvcyM7cPGtOE5g74BpOE=;
        b=OR7LqJcu+8dXiJjr6VTkJsKP4MQc34nCvEsXfE82Pe8Lt9DwXCctCzoPnRaph+JP/A
         k99f2oi189MYnVbBHaGRhShr4UDyM6EwV1XnoMocPQtdokWojoqzNX/leXnQSk5gfstG
         USB1hIcHNubXfC+ylELhCuxgFMCD8KoTk1PPfCNaQjutrdk+JxjOXE17LVhkIFyZDmAj
         gZwXfemTJZT61f7raOBeUGcdOoadk7dtzbUNjWPOcviYjFGJP6MiW/ZWTNYikExTD143
         UOBUCjXzxlAoVWQqdqlYAC2ac1cpT0IfRU/qvHCaQu37lDwAYCU3XHW9YYmw+8k0cmT9
         Z64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738918669; x=1739523469;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NgvrfAQwLFovDWtM64VfstFqvcyM7cPGtOE5g74BpOE=;
        b=oGWa9SGIug2QJo4FD0vw7SrpE2yU0MPYchOv+icZmp9FxgaguJB3JYldXUQ+741T1I
         Bgse71CQ7H1vUl2aG7SXtOMhGGufjXKAj05ji3sYx/0MzHZa0l4z8xggBu4FA56JCdiL
         jR5lBbufb1ADb3Ls5HBBR122Z6VcdXE21bC2vEfiIx5KBJLbbEQ2XJpJZAWd9aPscmfF
         vtWTEIT1JpAHe1LgDUGg8ZmyUSihCpXzutCh+s98t1L+YTuogxx3eM10/o78maOhuUJs
         FkQUG+iBQF+mTF3I6g/DIdvEJ35MzVBMlhWX2YSjM+SKiJw6ZlL9iE+OMDd8vXtB0wQX
         cfzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmJtRk3LpwSmDfH9o6dCK44OXcYPisCH27hSyK2slehFCY3nG+kFOAszuDXmdgchY3WVfGW2ZLc4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoCP+5WnOBDPoJvszTk84vJoG1pGX400+pl9E0HDOIAk0+/jYm
	QKw3fDVMrcBbbcpL/TXI2BPQXIhsNP/fmpycB320yv/BeKDBgst63NmrzYwLbII=
X-Gm-Gg: ASbGncsqGvt2jVF5uAHXjevMuQeLBdKeYpXttcj7ufxfsetQ6VtRfSkusi52wncXmvr
	iyfzb+XGqLYgMOnouAYj2trvVVspxSv05qVGdr1xDXDkCjXa09KWufw0C8HaBd6ceLvxeLpp1kA
	PvFtENlPNYlcavRwYz75nhXWVQ+MX3do8aAkvZX3dK52Yj9qH0DMpUvbpPGhs9FYr7XGtS30lW9
	sdqY5152X19p301OCPRLM2/pQ9AXOv2VXvdei11m+/sIwd5v3nxmlNN7CJkHmj2cMAODhm7dRdx
	tt0Hoz4JaNNFhHeZd/Gpt+YIeu6iDo6gE+NYaeAFMt1Ti42svLAtpX5DUXGcoo9KajqcrlRPnw=
	=
X-Google-Smtp-Source: AGHT+IHmp+FH1AuZTlJKN929evp5N+MuXixQzE8522ihJ4whOBdQptmbBxXYSkVLlqkBflCAEdVa/w==
X-Received: by 2002:a05:620a:270c:b0:7b7:2de:6fd3 with SMTP id af79cd13be357-7c047b5214fmr359033585a.0.1738918669134;
        Fri, 07 Feb 2025 00:57:49 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c041dec312sm163884585a.11.2025.02.07.00.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 00:57:48 -0800 (PST)
Date: Fri, 7 Feb 2025 03:57:45 -0500
From: Gregory Price <gourry@gourry.net>
To: Byungchul Park <byungchul@sk.com>
Cc: Matthew Wilcox <willy@infradead.org>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org, Honggyu Kim <honggyu.kim@sk.com>,
	kernel_team@skhynix.com
Subject: Re: [LSF/MM/BPF TOPIC] Restricting or migrating unmovable kernel
 allocations from slow tier
Message-ID: <Z6XLCeU0vjIOYGKe@gourry-fedora-PF4VCD3F>
References: <Z54hUTXRsw0LYQ8b@localhost.localdomain>
 <Z54p4QOnAlTYm6DG@casper.infradead.org>
 <20250207072024.GA48419@system.software.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207072024.GA48419@system.software.com>

On Fri, Feb 07, 2025 at 04:20:24PM +0900, Byungchul Park wrote:
> On Sat, Feb 01, 2025 at 02:04:17PM +0000, Matthew Wilcox wrote:
> 
> We can work with from the easiest object

>e.g. page table

It's more efficient and easier to change page sizes than it is to make
page tables migratable.

It's also easier to reclaim cold pages eating up significantly more
memory than the page table (which describes pages at ~8 bytes per page).

Also, there's quite a bit of literature that shows page tables landing
on remote nodes (cross-socket) has negative performance impacts.

Putting them on CXL makes the problem worse.


> struct page,

`struct page` is a structure that describes a physically addressed page.

It is common to access it by simply doing `pfn_to_page()`, which is a
fairly simply conversion (bit more complex in sparsemem w/ sections)

This is used in a lockless manner to acquire page references all over
the kernel.

Making that migratable is... ambitious, to say the least.


> and kernel stack,

The default kernel stack size is like 16kb.  You'd need like 100,000
threads to eat up 1.5GB, and 2048 threads only eats like 32MB.

It's not an interesting amount of memory if you have a 20TB system.


> When it comes to this topic, the most important thing is the collected
> *direction* from the community so that we can start the work under the
> *direction*.
> 

My thoughts here are that memory tiering is the wrong tool for the
problem you are trying to solve.

Maybe there's a world in which we propose a ZONE_MEMDESC which is
exclusively used for `struct page` for a node. 

At least then you could design CXL capacities *around* that.

~Gregory
