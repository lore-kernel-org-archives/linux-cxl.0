Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E203002B3
	for <linux-cxl@vger.kernel.org>; Thu, 16 Apr 2026 20:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776370994; cv=none; b=JlhXy3XtHhvgZF4uzXCb9hlRPec10LHGHWDRb85ipI4VlsNjZnDh8gCvfg9SbWjIUXNlPQo8nc6os/2a7txni/aLpP3le7rHgFX6/k1KRj05pCGjUd7cX+yojoXw2rPsBzLqGqHVUA30BB0MTAehsvlcWR/tXmg/6s/vzawr5iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776370994; c=relaxed/simple;
	bh=/jHN3AKrXKDhewo5A4ppG7b+41Xeu+rziVT/eh08bi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VjaD02FS9tYvt4TnSgaAiO6TUl6Fna/Z9O43ewzPo8chGRbEUiEVa/++Azd8ng3p1CWbBDNL4wqu3cIP+WsZSaKaHKWByJbsIbE+mh+z3gm3GdJakukmUETUdCwnM55sqDBxRk5h8x56LnV5botp6kUHvlSBHzRZetnfWyzQlXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=uxnbTcmG; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="uxnbTcmG"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-50d87610513so82040731cf.3
        for <linux-cxl@vger.kernel.org>; Thu, 16 Apr 2026 13:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1776370992; x=1776975792; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lQIC/zWz5OJ08TBOSJwx1m1q+xpY5Pl9ONSV8Ev4djw=;
        b=uxnbTcmGcyjxqVHuWZqJ9OckKCFgnYarPQ965GpLUwI5pVDxfogLlDNeuBCPedAcrO
         nlvqIRLQYrtJe72ihtLgGHgrC1myR3O+EWrzJybE37/OIMxHiEsSrt5zdG6KyShnAz1F
         3NlEanODL+1+YjHfNjfjJZTv+ZFj4n3j2/sWps68IVzeifI7zHk8pS79AnFZz2gBbTT9
         4gmIQU8KbB+rm9nSOd9smTOUulfubLU85Hw2XLHRM08J668JeRdFdX/AnaHKmYuCWlai
         zEK1r73u9jw3gTKVYu2yNUF5VH5ncJN9+Tv+y5FcujDa1KL5RcrX6MX8J73ctBWDUN0F
         OUIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776370992; x=1776975792;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lQIC/zWz5OJ08TBOSJwx1m1q+xpY5Pl9ONSV8Ev4djw=;
        b=ewRxIkylAGLp9bnty72REYdfw7yZ6AcZXTZ7K73wBRmiMdHd+03mi06yG0MfROYEeG
         WnqqhqFST53MIg2uE3HufG+drhmGj6vWoQ24zqq8Nr6YNQLtLYSS7KBUfZDueDgj+K73
         PMjFRN4o8gf3FdYNMEDsEEcyOwlAqAKqz4LGOoRxkLoN9j9QrtLp3Eo3bEbbePOYru2S
         J3b8iVWWjEtxuvg1VY7WqW+bqIdVACUoa5mOolgnzuIgJf0EajF0HAKNp8IElRN/YvyB
         r721RRiNOGmfqEvLpStJ1u1nfNHWWfEDUhaos6cq/JEWCzzA3ssz5xci+otmm4B51VAY
         xrtQ==
X-Forwarded-Encrypted: i=1; AFNElJ/1bB0bwbDomAQN2QuaDrBaDM5zIWxHW1wAImpCRWBeuy7upYWAz/2J+V0TxAXtff52dk5JpNhwE9A=@vger.kernel.org
X-Gm-Message-State: AOJu0YypZY/9NkLS3QjXcyX79z03tp7PG7YvTI4K2qrvN/WxGqo1DTTp
	XUnpxBNqfl1ipB2/Jf3DMMIM1bm1mh5DPLU5QIFxJXpYXmhJVcuQFABaj9l0/oKskpk=
X-Gm-Gg: AeBDiet/MD7MgbWoQVnJwzdHGxeeY68qKllqv7C618kw90DhP25h+sM4MXpMGZr9ZjB
	lAhMn5OsesISDPCdPGeO14OFdjB4njcYoJ1cgjnhJ5WrP5bFM7Le2JYHlj/6Do9JSnB+3FuswDG
	BymKQeP4H3YLINeow6Ps03AlLNb5u0XFoggjF6Pxjd1i4wMrtQx8Rq9mIVTPzYa3lNkVBygQbXF
	fK+rHkKShx1cfxSDjrHNn17fcjstoGkHuc5u+3nxkEpC3S7N8yK8aYJ/LEMFaVw8bDBPdq4zveB
	/w+Yn/iU8ojI3Gv/k/bHhWoh1MeACoR6W6zDqI4KgCD9EgvrBpUa7mXkzCpnAGf9SkAeTlutsN2
	KuJeCFY+1KDkFDj916ciYB4JUWR4mRpzqqUUgHn0Jcm/k/rwn6DdViMB30ZM8REBqZgytb/s3ct
	tkS7JQ5ZvK4hnSVbCLvnaHndKrhBKNUJdb834ATVk/6Sy1yI6c
X-Received: by 2002:a05:622a:7917:b0:50d:a7d9:d9af with SMTP id d75a77b69052e-50e34a76ca8mr7683091cf.53.1776370992242;
        Thu, 16 Apr 2026 13:23:12 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([2607:fb90:ea1b:4643:9f36:3ffb:fc60:9518])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e1b0063easm49480691cf.29.2026.04.16.13.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 13:23:11 -0700 (PDT)
Date: Thu, 16 Apr 2026 16:23:06 -0400
From: Gregory Price <gourry@gourry.net>
To: Frank van der Linden <fvdl@google.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
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
Message-ID: <aeFFKlSgOctW2W84@gourry-fedora-PF4VCD3F>
References: <20260222084842.1824063-1-gourry@gourry.net>
 <3342acb5-8d34-4270-98a2-866b1ff80faf@kernel.org>
 <abwRu1FNqI3dVyqL@gourry-fedora-PF4VCD3F>
 <2608a03b-72bb-4033-8e6f-a439502b5573@kernel.org>
 <ad0iT4UWka3gMUpu@gourry-fedora-PF4VCD3F>
 <38cf52d1-32a8-462f-ac6a-8fad9d14c4f0@kernel.org>
 <ad-r7hwIdnvKsrh9@gourry-fedora-PF4VCD3F>
 <CAPTztWajm_JLpp9BjRcX=h72r25ELrXeGkOXVachybBxLJGS=g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPTztWajm_JLpp9BjRcX=h72r25ELrXeGkOXVachybBxLJGS=g@mail.gmail.com>

On Wed, Apr 15, 2026 at 12:47:50PM -0700, Frank van der Linden wrote:
> >
> > > I also have some questions about longterm pinnings, but that's better
> > > discussed in person :)
> > >
> >
> > The longterm pin extention came from auditing existing zone_device
> > filters.
> >
> > tl;dr: informative mechanism - but it probably should be dropped,
> > it makes no sense (it's device memory, pinnings mean nothing?).
> >
> >
... snip ... stitching together some context here
> 
> So, looking at having some properties set at the node level makes
> sense to me even in the non-device case. But perhaps that is out of
> scope for the initial discussion.

I think there's an argument burried in this observation (useful for
non-device case) that suggests there could be a world where longterm
pinning on this memory makes sense.

But it doesn't need to be introduced from the start, and it's a 5-10
line change to add it in later, so I think it will get trimmed unless
there's a user out there actively experimenting with it.

~Gregory
