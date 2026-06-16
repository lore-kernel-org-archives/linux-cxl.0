Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E134630B50F
	for <linux-cxl@vger.kernel.org>; Tue, 16 Jun 2026 13:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781617634; cv=none; b=n1tlTb2FU3L8EVl535lRqG5lb2VLGDEXW1Ge4NnBiyQWhHv/RQPElJ+SNBXq+9fJrANTYuWNBWnWjXDKIbi/LtVfGT/IwAj9PulEEAuGonfbxUO6ZmRjGa2fA5rgiod9qvkDJIoIZtfi84n7vtU72FssK6IxOlZ8c0LvTP0RIpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781617634; c=relaxed/simple;
	bh=ON5XRz8lHOpOJ8xktgKhULmQK7Hl4dNNx6xl4pP0U7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h4kUzNGniSJY5etw2pBfp3zxmOSdYnPUuLCMrrnzcmij9c1l+w0T5XD28z5DteZPNZ9SBdTgKM84n8GkGPzfku4nXei9bGMpWiFD/R1seGpQU3rGPLAEGrVuefC4QWieipGmzHPrNPTdqgFuzISErmltHp62hbE5EZieFJGD/uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=LCkTe2IB; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="LCkTe2IB"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-517863a2edfso36125381cf.1
        for <linux-cxl@vger.kernel.org>; Tue, 16 Jun 2026 06:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1781617632; x=1782222432; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EvNzegJ7+heyexsBUGAQ0jwoVUjk7efTCiVuRf1VOy0=;
        b=LCkTe2IBkv5qsv/rAmGrOexkI/ZfXf5q6AV8BqKMOOZ+sHg78vk69hSs+G8iRTCY5v
         cBhcigAqcSSFuNUN6XPPFKundVuwRQFhop+/+/fUKrv3GG/rLB7va1VT2qASgn0EHkQH
         fIHaDBVjEL5IiGHZs1jE6KCzQxaM+SSybNLhFBQj9Uwl3v/L2i+i6lch40EIrpPmaVFQ
         c55fGSwNOIdqM4IPGd8JBp7QTkM8ULCKMIFgubmM5K7RtnuAWHk0qvXXik2UHAk/NcMx
         SuBqjt0rDc3YlRFJu1MXZNOhDqTDk5tk3S0IND+cMCL74Nhq+x5UQ3pvsyhBUR8CUkD8
         WwBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781617632; x=1782222432;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EvNzegJ7+heyexsBUGAQ0jwoVUjk7efTCiVuRf1VOy0=;
        b=h11/dGVIesk/KAFw8fYReZA9t+iWBARe/AqN2ufldFDUdkA7NW3uF9ddIfHqZ0Fk6x
         Z05DxVTKYB7a/Dd4BqOWHqpQM36TIQ9XGfQfFOcZOrUnkDegdzgq2Qh2PY4NDsdmpRcj
         v8W8i/A5J06kQX+Au5ikI6Ou9JpsArth1pmPyJCNqrQ/N9N045N3effGg0r9yaJq8j6W
         ezWSHV5kazF8PxT9zup8zud77LiQnNmgQSUMGNYNYgrz/q0HhAEqt3Ih9ic9aErWnNEX
         5EyBzQmUMVZuueFEpZUvnA1MWYRFt+q20xUhWBJ1yFXi5cKPlysCNEpvol3tUXCsFV6q
         UQ9A==
X-Forwarded-Encrypted: i=1; AFNElJ+rYZoUXECJ1Wjq+G+IFuDEp6gy57cltlpzSNdCjp1LrHf7xxp4ZTmHwiaYAc/Fv3W0Yh1gJ6mCl+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD+T0S4YuHeFb2Ir90BPt2B3MXdIlnYScwOPUkhBtsQye3i0Vx
	JW8khPIaWnvKBRIHQ9xxk8sK/rdLbZundrB4vNTsIB2XySaQxJTKPZ0rwKAuRnk1GEc=
X-Gm-Gg: Acq92OFYr89uW+/gsdjqqPzXQtUAUVbD9/Sn11Y8VO6GebyTWwO0xyp3+eqnLsi6S3z
	hUUlcIaTSgArPcQmQQbx1gojtvEWpnkXRkAVnCe+ctl63qUrrvYcEiODAp044OAIxNOP+p99hpJ
	u7ctYnEV1CIhZu2LrpW8gQd+iYtkEPweyTw/PUDCp7wAUoJlZON8w6beKeaCd7yh7GkexGcIGf2
	O9PC/JD+u+a8hNlQ3idfu5gaGOBoLaW1urUIlIKmGxnsodLDFioD0ZoM3Zwlr52vyRugHTJBKBS
	ZBUtclkEYeHXOBt1GM7elBOctQrNGxanaMc4RZC3iiJZk2MMA3BBJ99nD1xrRgNQJLNkGY9a702
	kSP/mM4XCsFjcoohuWHor20UM5WvbylGmTKeqCtZJ0KyR6YtPphJJb71Hh098C+800HIYPtevr+
	HJn2Ty3t0JzfAwoXkpbZ1J
X-Received: by 2002:a05:622a:a6d4:b0:517:7e3a:5ee1 with SMTP id d75a77b69052e-519916d65f2mr43449041cf.1.1781617631680;
        Tue, 16 Jun 2026 06:47:11 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([2620:10d:c091:500::3:437e])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb84188asm150577021cf.29.2026.06.16.06.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 06:47:10 -0700 (PDT)
Date: Tue, 16 Jun 2026 09:47:07 -0400
From: Gregory Price <gourry@gourry.net>
To: Brendan Jackman <brendan.jackman@linux.dev>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Balbir Singh <balbirs@nvidia.com>,
	lsf-pc@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
	damon@lists.linux.dev, kernel-team@meta.com,
	gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, longman@redhat.com,
	akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, osalvador@suse.de,
	ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com,
	rakie.kim@sk.com, byungchul@sk.com, ying.huang@linux.alibaba.com,
	apopple@nvidia.com, axelrasmussen@google.com, yuanchu@google.com,
	weixugc@google.com, yury.norov@gmail.com, linux@rasmusvillemoes.dk,
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, tj@kernel.org,
	hannes@cmpxchg.org, mkoutny@suse.com, jackmanb@google.com,
	sj@kernel.org, baolin.wang@linux.alibaba.com, npache@redhat.com,
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
	lance.yang@linux.dev, muchun.song@linux.dev, xu.xin16@zte.com.cn,
	chengming.zhou@linux.dev, jannh@google.com, linmiaohe@huawei.com,
	nao.horiguchi@gmail.com, pfalcato@suse.de, rientjes@google.com,
	shakeel.butt@linux.dev, riel@surriel.com, harry.yoo@oracle.com,
	cl@gentwo.org, roman.gushchin@linux.dev, chrisl@kernel.org,
	kasong@tencent.com, shikemeng@huaweicloud.com, nphamcs@gmail.com,
	bhe@redhat.com, zhengqi.arch@bytedance.com, terry.bowman@amd.com,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC][RFC PATCH v4 00/27] Private Memory
 Nodes (w/ Compressed RAM)
Message-ID: <ajFT235iYsSJ7nbR@gourry-fedora-PF4VCD3F>
References: <ah6bDNxlB1zBUnzN@gourry-fedora-PF4VCD3F>
 <ah-0CyZurn5D1ezY@parvat>
 <aik_ddHymus2DJ6D@gourry-fedora-PF4VCD3F>
 <c1b66e7a-bb95-4295-8193-55ceadaaa578@kernel.org>
 <aimSzvoJDrpeQsmM@gourry-fedora-PF4VCD3F>
 <d01fb1ed-2418-42ee-aea2-37f9a5c5729c@kernel.org>
 <ainFROZ3WrGioyuY@gourry-fedora-PF4VCD3F>
 <aiwl4kCG814dpX7L@gourry-fedora-PF4VCD3F>
 <9f1815b0-896b-44ab-9e6d-9316d8f11033@kernel.org>
 <DJAGEUY8S09F.3V3HF570G85OF@linux.dev>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DJAGEUY8S09F.3V3HF570G85OF@linux.dev>

On Tue, Jun 16, 2026 at 11:57:42AM +0000, Brendan Jackman wrote:
> On Mon Jun 15, 2026 at 2:38 PM UTC, Vlastimil Babka (SUSE) wrote:
> > On 6/12/26 17:29, Gregory Price wrote:
> >> On Wed, Jun 10, 2026 at 04:12:52PM -0400, Gregory Price wrote:
> >>> On Wed, Jun 10, 2026 at 08:59:59PM +0200, David Hildenbrand (Arm) wrote:
> >>> > > 
> >
> > I think the memalloc approach is dangerous due to unexpected nesting. There
> > might be nested page allocations in page allocation itself (due to some
> > debugging option). But also interrupts do not change what "current" points
> > to. Suddenly those could start requesting folios and/or private nodes and be
> > surprised, I'm afraid.
> 
> Minor side-note: couldn't we just define it such that the allocator
> ignores the context when not in_task() (and warn if you try to enter the
> context while not currently in_task())?
> 
> (Don't think this would change the conclusion very much, e.g. doesn't
> help with the nesting issues. Mostly curious in case I'm missing a
> detail here).
>

I looked at this - only solves one issue and oh boy is that an obtuse
confusing condition to understand.  We still suffer from recursion in
reclaim.

~Gregory
