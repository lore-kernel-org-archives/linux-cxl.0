Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879DF42B742
	for <linux-cxl@vger.kernel.org>; Thu,  4 Jun 2026 12:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780575531; cv=none; b=bpw+wHEDyZi1mGq6D3ma87XhtYgtsNu489cpme9Pmg96RHrn6mCd5wsvvMKPois42Wg3xhUiqZSXP61RgjrJruY1bytCm6W3v36Aqi5mocvwKgHPHQDM1qY/i4KF9DrxfQXBwvb/fqsHtHi6gqE3Yf1YVKJhj9FiZwtoOnxVAk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780575531; c=relaxed/simple;
	bh=VAnfCTlLBiEiB+TD0eyA0lvhdUfV9bmWB+Umsp+9RUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kBngDlzDH2wzrGwtxPih3tvQ4eXTKYgZ8ugrFmXrZsrSf02cM/bWQ62S35woKo84nndyxuC34iaLxChIFixu8ERtwR9bAxGGLmVBKgaSGjeOEeDj1QVRulCE9b44UTh+prLAVG0l/xzs5xnpNXi/3C70egdcd1D+iP+80vPTQcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=bHkB8C/Q; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="bHkB8C/Q"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4903d730b1fso7092495e9.2
        for <linux-cxl@vger.kernel.org>; Thu, 04 Jun 2026 05:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1780575528; x=1781180328; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pv1Oyz2SuibchEQ+somLIZ/UIk84PCQQ/cJhhIFylGE=;
        b=bHkB8C/QgMJN0x492cuzjiWQbmo/qNdHkk0X5/9T2HXegtU8YQon1Qm7OWWgEoNPP4
         agda4Ep/0fSBgpSjoH3j8MzyIEASf2eDI6tFgMLs0kyHGAEwgPqM5pHzI62v76y3xwNF
         36lmi7duXQFTyWuSIOpKpFcYWJ+qluWCqt6OgZcUQmLZl0yyosp2ZHyYBZDa+HhGHCgO
         Rntj1TrqwBpm8zp2NoclZT7hu7iGBas0RiuG7drvIY6fmRBM5deljhG8COMzMwZHy5cc
         EaY65iWFtpmgO3SGvi9nvz0R6bnMmIALmPpN4KRrHlyYSEaSuAeS9L4pDhLZrb9oV2uX
         chMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780575528; x=1781180328;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pv1Oyz2SuibchEQ+somLIZ/UIk84PCQQ/cJhhIFylGE=;
        b=ZygJwjjqSLLipNI3n4ZNQrq4GcHdUhx+oyu7uia708UpcdoBBW6poCfOEBI2nzHgG7
         iRKxL3aPYTq9TDX8jALaEqiVVzx1WpwzOeruUwN386lN8exr7Bc+R9D/N0uoNN5RnGNq
         0j6+XdepkmWs92KHbVROIoNkrqIvjOyEhm4lRCLmw0nxtbMw83q3AkEqZqm1yxnnWuQr
         sVnWKtZ7+7L+DEXe4YfzKEMbArbB0EpOmd3+FEE+pV9RW8anupcG28XJsh6ptfofe7YO
         JjHrru4zp1PbJdTj7AbHdHJcDIDy/XaLJU7or9JcIOO3mfnFGAcvd2Qa2anlzqY38Rff
         ECFw==
X-Forwarded-Encrypted: i=1; AFNElJ+e/x2E6YzGvTwxbZQfaJdj+fFd2rPQkT9S7d6vvIyt7d0lMIKJaSW+nbg/vqNCOY1QYhwnveZK554=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcxIn5y8evuRMAw/LXFTzNPDHGJjyikt4ARJfyMUp/KaMC7AVW
	8rwiaKuLCclQt29Pr2XwKc+8Lxclaa9S1PpY0BqYILeNBEdl0fd6JH79IkJdr7cg2Yg=
X-Gm-Gg: Acq92OFQdt8sv+J5ekSdtK5AButKcVPn46FeJIfprqcHIP5xF0w9/CSjCKn8xTlc2sF
	qkF1SGvg4uES3Bvca8+46VvLKditz+pAAi7Akyq4RAPB5snhAMImLj2ZW9WoqF+Y45of4O/Ar1g
	Pam6Q7R4QuEbbqAaAHwmiYYH2fh/w7lzmeX/qq6m/zlw3wzoYNjYBuGYD93TVffI5gBPEY+RZWB
	LePA4m7zSYoONvxH3jg0ahlxAh7EKo3s9lCk98iOCwczpvq4QfJS7EQDrOTElczIaeKipexmGl8
	ZT929dAv12g9zWE9mPMns3D6BM4P+lRFt9DUaF6JScyra4hnqwCv0cY/UXtBcpQR2wz38urL0VE
	LfKllzPgJoYPLosy/IlRuWjHnf8vvmcPQYpAfYqB+K4zsz3XDsLp+a9ymi7RGSpAmbAzjuIR+K/
	YvYCXsA2s9oUr/YWyRSyhfUqkLN7vEXY0=
X-Received: by 2002:a05:600c:4043:b0:490:b2a6:8c2a with SMTP id 5b1f17b1804b1-490b5e748e3mr78263665e9.5.1780575527855;
        Thu, 04 Jun 2026 05:18:47 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([2620:10d:c092:500::7:a76c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3cc140sm81382665e9.9.2026.06.04.05.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 05:18:47 -0700 (PDT)
Date: Thu, 4 Jun 2026 13:18:44 +0100
From: Gregory Price <gourry@gourry.net>
To: Balbir Singh <balbirs@nvidia.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
	damon@lists.linux.dev, kernel-team@meta.com,
	gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, longman@redhat.com,
	akpm@linux-foundation.org, david@kernel.org,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	osalvador@suse.de, ziy@nvidia.com, matthew.brost@intel.com,
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
	ying.huang@linux.alibaba.com, apopple@nvidia.com,
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
	yury.norov@gmail.com, linux@rasmusvillemoes.dk, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, tj@kernel.org, hannes@cmpxchg.org,
	mkoutny@suse.com, jackmanb@google.com, sj@kernel.org,
	baolin.wang@linux.alibaba.com, npache@redhat.com,
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
	lance.yang@linux.dev, muchun.song@linux.dev, xu.xin16@zte.com.cn,
	chengming.zhou@linux.dev, jannh@google.com, linmiaohe@huawei.com,
	nao.horiguchi@gmail.com, pfalcato@suse.de, rientjes@google.com,
	shakeel.butt@linux.dev, riel@surriel.com, harry.yoo@oracle.com,
	cl@gentwo.org, roman.gushchin@linux.dev, chrisl@kernel.org,
	kasong@tencent.com, shikemeng@huaweicloud.com, nphamcs@gmail.com,
	bhe@redhat.com, zhengqi.arch@bytedance.com, terry.bowman@amd.com
Subject: Re: [LSF/MM/BPF TOPIC][RFC PATCH v4 00/27] Private Memory Nodes (w/
 Compressed RAM)
Message-ID: <aiFtJFqkpbZ9qFvM@gourry-fedora-PF4VCD3F>
References: <20260222084842.1824063-1-gourry@gourry.net>
 <ag6XyvxR-NU5rGn-@parvat>
 <ahOqzpzAua96HVkn@gourry-fedora-PF4VCD3F>
 <ah47NNhuiClgGCdn@parvat>
 <ah6bDNxlB1zBUnzN@gourry-fedora-PF4VCD3F>
 <ah-0CyZurn5D1ezY@parvat>
 <ah_RcTU8SpQG7hab@gourry-fedora-PF4VCD3F>
 <aiDVMgu0viTIml8H@parvat>
 <aiE5DZC8Io4SNI3H@gourry-fedora-PF4VCD3F>
 <aiFSZfRlFPd7qlIw@parvat>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiFSZfRlFPd7qlIw@parvat>

On Thu, Jun 04, 2026 at 08:35:19PM +1000, Balbir Singh wrote:
> 
> My concern is that __GFP_PRIVATE is too wide, I wonder if we'll have a
> need to support N_MEMORY_PRIVATE may not be all homogeneous memory nodes.
> Very similar to how not all ZONE_DEVICE memory is homogenous.
>

Can you more precise about your definition of homogeneous here?

Are you saying not all memory on a private node will be homogeneous?
   While possible, I would argue that you should not do this and
   should instead prefer to use multiple nodes - 1 per memory class.

Are you saying not all private nodes will be homogenous?
   I don't see the issue with this.

> > 
> > Agreed, but also one which can be deferred and played with since it's
> > all kernel-internal.  None of this should have UAPI implications, and we
> > need need to accept that we're going to get it wrong on the first try.
> > 
> 
> Agreed that we might get the design wrong, until we fix it up. I feel
> that __GFP_PRIVATE should be an evolution of the design to that point.
>

Possibly.  If we can't guarantee isolation without __GFP_PRIVATE, then
we probably can't merge the baseline without it.

> > Because pagecache pages are associated with potentially many VMAs.
> > 
> > The fault can be a soft fault or a hard fault.  On soft fault - the page
> > was already present, and will simply fault into VMA without being
> > migrated.
> > 
> 
> Let's split this into two:
> 
> 1. unmapped page cache is never impacted by mempolicy and should not
>    end up on private memory nodes
> 2. For shared pages, mempolicy would be hard, but it would need to
>    be on a set of nodes backed by private memory, depending on mbind()
>    policy
>
... snip ...
> 
> I'd need to think more about this. For now, my basic requirement would
> be that unmapped page cache should not come from/to private nodes.
> 

This does not fully describe the problem.

A file can be opened and cached as unmapped page cache, and then mapped
at a later time - at which point the mapped copy would share the filemap
page cache page.

Worse, because it's file-backed, you can have the memory faulted onto
your remote node - reclaimed - and the faulted back in via the process
accessing the file via unmapped operations (read/write), at which point
you've had a silent migration occur.

Basically consider

Process A:
   fd = open("myfile", ..., RO);
   read(fd, ...);  /* mm/filemap.c fills page cache */

Process B:
   fd = open("myfile", ...);
   mem = mmap(fd, ...);
   mbind(mem, ..., private_node);
   for page in mem:
       int tmp = mem[page]; /* fault into vma */

The result of Process A running first is Process B thinks it has faulted
the memory onto private_node, but in reality it's taking soft faults and
just getting the filemap folio mapped in.

If you wanted mbind() support from the start, we would have to limit
applicability to anon memory only.

Shared anon memory is different, as there is a radix tree that deals
with a shared mempolicy state.

> 
> I am open to this, I was coming from the blueprint approach of:
> - Let's mimic N_MEMORY with N_MEMORY_PRIVATE and then pick and choose
>   what features to change or make specific to the implementation
>

N_MEMORY essentially states:
	"This is normal memory touch it however you like"

N_MEMORY_PRIVATE (_MANAGED, w/e) says
	"This is NOT normal memory, there are special rules here"

So, no, lets not mimic N_MEMORY.  This is a "closed by default" design,
while N_MEMORY is an "open by default" design.  This design choice is
explicit to make reasoning about these nodes feasible.

> > This is informed by a single use case / device.
> > 
> > There are users / devices that don't want any UAPI for their memory,
> > but simply wish to re-utilize some subsection of mm/ (page_alloc,
> > reclaim, etc).
> > 
> 
> But then, why do they need NUMA nodes? Do we have a list of use cases?
>

So far i have collected:

- Network accelerators carrying their own memory for message buffers
- GPUs with semi-general-purpose working memory across coherent links
- Acceptionally slow distributed memory that you do not want fallback
  allocations to (so you want to deliberately tier what lands there)
- Compressed memory (just another form of accelerator really) which
  has *special access rules* (i.e. writes need to be controlled)

In most if not all of these cases, the right abstraction to reason about
where memory *should come from* IS a NUMA node.

- the network stack can be taught to check if the target device has a
  node with memory and prefer that node over local memory

- accelerators can be given private nodes to manage memory using
  core mm/ components, without worrying that general kernel operation
  will put unrelated memory on those nodes or do things like migrate
  your pages out from under you (unless your driver/service requested
  that).

the tiering application should be somewhat obvious / trivial.

> > 
> > I am trying to test whether, lacking __GFP_PRIVATE, any normal runtime
> > operations access private nodes removed from fallback lists are reached
> > via something like the possible / online nodemask.
> > 
> > I remember, maybe a year ago, there were per-node allocations happening
> > during hotplug and that's why I originally proposed __GFP_PRIVATE, but
> > I'm trying to re-collect that data now.
> > 
> 
> Thanks, I look forward to the next set of patches. Let me know if I
> can help test what's on the list or if you want me to wait for the next
> round
>

Really I want to get the minimized set out the door so we can start
breaking this up by feature (reclaim, mempolicy, etc), because trying to
reason about it as a whole is infeasible - and I cannot be the single
arbiter of every use case (I simply do not have sufficient context).

I'm reworking it all as we speak.

~Gregory
