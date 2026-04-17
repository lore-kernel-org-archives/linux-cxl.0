Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756AD3C1995
	for <linux-cxl@vger.kernel.org>; Fri, 17 Apr 2026 15:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776438479; cv=none; b=SoyJEkqQFb10HpAGVxF5Za9q+RJXbTo8a7DjzJ7f9E/XudI3O2y9qBp7MLyvxYzb7fhYSnj/UlodAsTqpuIOIyOY4v0OVZkvElADp7f8Gn+XbDmiSeVsqx5za5g1JhwekuOC+Y6Po23EzKP1VaEpTD7gy6592hUCQLMoI9ZyE0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776438479; c=relaxed/simple;
	bh=4pOvxWvA/yj5xSsYSUbpCo6Kkeq+uF64q1hqZjlP4T0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u9lIOu9e/zTGFvkKY95ixFv/68d6qiW4Ju0XvZBgmQQrQD1je7JXkH/cMqm1dYTeRbK8LTMOoC/9kHGqdsyVGksml1EacYh8LZAc0PS8GIutelbS4o3/Y5cWxjEBaNehah/fQtc6QBFkWKTac1od2YKAWMk2qEl1ed+7vDTywjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=MuXvucRS; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="MuXvucRS"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-953b0a7ee18so192039241.3
        for <linux-cxl@vger.kernel.org>; Fri, 17 Apr 2026 08:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1776438477; x=1777043277; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l8hmn8cP8J8LvjQAqTAHhf9pkwu4llVl8k7YZT9Lr2w=;
        b=MuXvucRSPryIvwYoaQCiGTb9aT275yNFutcZ8S6ZOCNgBzvAKq7D9d+rhXkd2xbJqZ
         FWEK6FwCH8erIvtPT0O7vKzSm3Rr4npcFBMD/omrKxxHttXdAoMZ1CU2NbexWyfowXXY
         BK1I/UOka5u3OVfPDrWoxsEjUED2U+CStdw/czC6gqtUMv+huF8cu3wC42LVGI9zBeP9
         t++KjE5+/VVnbuTtP8Vhgc/c8oIjrO8Pml5joMhi1D1gMIA3QspaijVqGmC9oDPKeroO
         ubS/lBY7qL8QVEDbun0mNhpoSOZDZyCEIYgM5XoHlYIf+kkcyhnXT7HPY6yvprnf7qQ1
         E2wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776438477; x=1777043277;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l8hmn8cP8J8LvjQAqTAHhf9pkwu4llVl8k7YZT9Lr2w=;
        b=qMHRFXLTEoTkBPVDOOwNh2+D5LicEv+nyMGDsbuCCog1xr/R217OFJYU02JlsmTS+y
         280m4IyWGT33oa+BFV5aed9S1kMep8yS1mXHqtg0FnjaniagcdneHmoPh+mZ8ubkypte
         z24n4Y+sjRvf/EkLeMQxFqKeHzbBt5QfgeTh794A/gyQ2vMMTv+RnArXQu+iRb6BNEm8
         SRwHuHuEA3wY5SDmMP2PX+nSzIU5Cx6s9366et1/PFwMLwZcpCm0i0SJhVbzBNz4gxeD
         dP/19mLu8E3UXIW94iIBcAI4Y9U/Usq7oNRkqCgWXCNB5HbLQLigt50r47fh7K4pFoLc
         PktA==
X-Forwarded-Encrypted: i=1; AFNElJ9APJp9BhryEiwtpoNZ/+Etcm5yzHZ4i7i/5ngIVZqP77dfJ7rznlH4c4TgDzW2cdC0aZrdBwEdquM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbHYFYmvH3DPg0Qq542t8ImY8K6fE5AuvoUZLlsS816ANjlBDo
	JcDwsX3qv/xjSX9th7S5bGfBnTXFqYJgK/Hbwg1MYZNTETJYf26IcJvKQCPy31yIHk8=
X-Gm-Gg: AeBDieu1CEKmCADnJsA+65az6e0argohx6xUDmloYAoYBKoXtK8P5Vgl4SsEPwbqC/n
	M/n1ABqnCXvZI7pmjyiYEtTkTD8gSx5+ODPZYu6lfuuJRYlk6et7q4Oy9ReeIRDfY6O203Svjr7
	Qelnt+4QlKIcbGN9wdxGvEi0mDcX+vLh/NG7Q2j6PE52sczesCV0flm8ApR6WL/4n3yYUWLjwe7
	sVl6eDMDum1GNM8cK2H/RbNFN/69I/p96r41KO5QrwcSqut9saZCzeMaPjLaLBGZHvRX64rJz8y
	wS36/EyVQkM1Dz3swexThDuBbfspdteSDbaYeHO85pHI3iKsbdp5wSlpq79m08gBrQ9zEeLy3k1
	ke0lxPHKJnW5jdKLb4TsYUX49WOvKGJSRaNrp/HYKZo9vt4av7ItPi2Be89lNHd6ll9cDPwiTEr
	HM5QKWYwgawJ2kucxHeznkM4Lo041+kjxKzVg8P0KcGOqO21dQptD6PPdgb7zqu9nLB91ZINAZp
	xl/PFaheVQak7T1Sy05
X-Received: by 2002:a05:6102:162a:b0:613:6b44:3fa9 with SMTP id ada2fe7eead31-616f71ff8c8mr1462957137.20.1776438477197;
        Fri, 17 Apr 2026 08:07:57 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-108-18-109-80.washdc.ftas.verizon.net. [108.18.109.80])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ac6c3e7sm13032726d6.13.2026.04.17.08.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 08:07:56 -0700 (PDT)
Date: Fri, 17 Apr 2026 11:07:53 -0400
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Frank van der Linden <fvdl@google.com>,
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
	bhe@redhat.com, zhengqi.arch@bytedance.com, terry.bowman@amd.com
Subject: Re: [LSF/MM/BPF TOPIC][RFC PATCH v4 00/27] Private Memory Nodes (w/
 Compressed RAM)
Message-ID: <aeJMyYMQWLyiGTRb@gourry-fedora-PF4VCD3F>
References: <20260222084842.1824063-1-gourry@gourry.net>
 <3342acb5-8d34-4270-98a2-866b1ff80faf@kernel.org>
 <abwRu1FNqI3dVyqL@gourry-fedora-PF4VCD3F>
 <2608a03b-72bb-4033-8e6f-a439502b5573@kernel.org>
 <ad0iT4UWka3gMUpu@gourry-fedora-PF4VCD3F>
 <38cf52d1-32a8-462f-ac6a-8fad9d14c4f0@kernel.org>
 <ad-r7hwIdnvKsrh9@gourry-fedora-PF4VCD3F>
 <CAPTztWajm_JLpp9BjRcX=h72r25ELrXeGkOXVachybBxLJGS=g@mail.gmail.com>
 <aeA6aNDpQ-U5UJCs@gourry-fedora-PF4VCD3F>
 <6d4f702c-5ad6-4f84-a73e-c9e34965be98@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d4f702c-5ad6-4f84-a73e-c9e34965be98@kernel.org>

On Fri, Apr 17, 2026 at 11:50:58AM +0200, David Hildenbrand (Arm) wrote:
> On 4/16/26 03:24, Gregory Price wrote:
> > On Wed, Apr 15, 2026 at 12:47:50PM -0700, Frank van der Linden wrote:
> >>
> > 1GB ZONE_MOVABLE HugeTLBFS Pages is an example weird carve-out, because
> > the memory is in ZONE_MOVABLE to help make 1GB allocations more
> > reliable, but 1GB movable pages were removed from the kernel because
> > they're not easily migrated (and therefore may block hot-unplug).
> > 
> > (Thankfully they're back now, so VMs can live on this memory :P)
> 
> Heh, but longterm-pinning would fail on them (making vfio with VMs
> angry). Similar to CMA hugetlb.
> 

Yeah, depends how you configure things.  As long as you expose those
pages on a separate memfd and online it in ZONE_MOVABLE in the guest
to avoid vfio from touching it - you can have your cake and eat it too.

It's a bit of bodge but it works.

However...

> In the latter case, we should have a way to identify "this allocation is
> actually from the CMA owner, so longterm pinning is perfectly fine".
> Checking the CMA alloc state would be one approach, but that's rather
> nasty. I guess there would be ways to make that work.
> 
> I'd assume that people barely rely on 1GB ZONE_MOVABLE HugeTLBFS Pages
> (iow, mixing kernel-cmdline ZONE_MOVABLE creation with kernel-cmdline
> hugetlb reservation).
> 
> I'll note that there was long long ago a proposal of converting
> ZONE_MOVABLE to "sticky-movable" page blocks. It wouldn't really solve
> this problem, though, where the early boot code just does something
> that's rather stupid.
> 

I have been toying with hotpluggable CMA regions.

Interesting opportunity:

  Hotplug on a private node w/ (RECLAIM | DEMOTION | CMA | HUGETLBFS)

Now you have exactly two enabled consumers:
   1) HugeTLBFS
   2) vmscan.c demotion logic

In this regard, HugeTLBFS is the only one that can reach these pages in
a way that could result in the pages being pinned.

All other pages on the node are - by definition - movable, because they
can only reach the node via migration (demotion).

The system can't do fallback allocations to the node, so it operates a
bit slower as a general purpose memory pool - but if you decide you want
to optimize for that you can unplug/hotplug the memory back to a normal
node in ZONE_MOVABLE - without rebooting.

~Gregory
