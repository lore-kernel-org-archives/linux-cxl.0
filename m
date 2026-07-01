Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA6C3ED3CA
	for <linux-cxl@vger.kernel.org>; Wed,  1 Jul 2026 08:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782894819; cv=none; b=ikdeguKH4jm8DfTSRIISuJDljJP1fzivDZiIL9oWicSvqf6LvVe9FT2xgWUV6jH/WM6kxHh+zk5ucHcy9ghsg2eWKKyK38bfVLGWQGBdCwKZ85/ZH0gYOsDCTtqqJ5l8m31DKy9TiXZ7MfbeQjqFKP5w2NKEfCyuxmORpLMTURk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782894819; c=relaxed/simple;
	bh=KdGxBvvqUEKh01AHomJVyPjMsIlcQgvzY/8dHzWOD0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=IpiKkRBua9yk/+TBhAjYRjoBygyAcFTylViNm6CkzyZ0aPkUHCvYExTDXJGFivVxY0fJrp6lHI2skEBIm1kUUcfeyVsDuOVqE3/MDV4XRPVQN+y2Qwmb/uOIjnQA7F17LTAVw9cW7RlKShqXe2QhvExtANBVPK+beXnw8Ov7sLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E9gnV4A6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E9gnV4A6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782894817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UGIqf/RERDJYkTy1UTY+sb5OW/7mHN3HiL9KZ7p6W40=;
	b=E9gnV4A6xts5n2FCQquOTySmgSNXCqvbRqAX2V+b72+MYafrt4XV2srlEtzljVXAHgcIzY
	Y6WZ1nT/NUkXIfOv+F2yUztqiGEZF7p9Ek2leqSFNo+yvB5kozbB1yGYfGyjKv/SiUT4nD
	TfSZRRE+yPa2SmWOLrD10hyBvHe/wgQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-5d-hl8CtPeOBCwOfynUH0w-1; Wed, 01 Jul 2026 04:33:33 -0400
X-MC-Unique: 5d-hl8CtPeOBCwOfynUH0w-1
X-Mimecast-MFC-AGG-ID: 5d-hl8CtPeOBCwOfynUH0w_1782894813
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-493bd52dae6so3012855e9.0
        for <linux-cxl@vger.kernel.org>; Wed, 01 Jul 2026 01:33:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782894813; x=1783499613;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UGIqf/RERDJYkTy1UTY+sb5OW/7mHN3HiL9KZ7p6W40=;
        b=ldLDIh4tA+nB1q2UXgZkn20dhLNfaARr1aiiT8gXaODDSSyUqNF6B8VykJvXFJNIPz
         KdFJgNaT3aizyaEtJ1NMh7svuWp5F9NgQ4Fte9zNFdQPoGW8vN1dVhfaOa0JPLYDcrkK
         z4UcbViKQMQHXXABcDq/sZRtDtdxYB4guNrxDh8wGpcXSRs5kfQhVq8N15aAvWoJPk5C
         TqzLy+e4/RVFNewBdFWAPHIcmKcNa5DwrqBjzkgGa3nASyaz/nL8oXrdYO8kgIsoYAsJ
         4VteVwdgQL7smzzQxPQ/wfPTqrX33itzYeQKgZuqfTeO3dXRxnGJqj61JBlFboLGH/Bx
         hwTA==
X-Forwarded-Encrypted: i=1; AFNElJ/vuh0w31dZ/ambqIrIo1rT+JcZhE75TTOebjpU2pQfi4O9iNm/fBCBwYI5GOqG/S62rcO0n+tfbTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhGw+taYEisOYhnRI5N7Mtw6DXY/rpWbLq3Sn8FE4dnnPgPV0c
	ToFDjClM7Fs/nQrFB/XTzG4Tbedm8riE4+kkLowVKpkf6WPx4IYhJ9mbWzSv0T2ArD8ViTpNCqX
	T1OwtCMSbORuCggKKr9wjEEdSnJnSTYg+rbWhTHurO3m971GUslWYGSchc+ynGQ==
X-Gm-Gg: AfdE7cktWwvdJcBxqG2cPDFYZawV+L6iBA13N+RKDchKxiNcgM1MEQCW1rxw4A6zhVA
	Zoa6xnruTUTBok0cFxWikXB2+9InyhQtMOQ+DbewXOfHyDCSmp6KWRC7yqv3qGn5L/c7QX/Y2hK
	RoO9NzA1LEuqKCcQMw99qFdtsAnUkvIsNur8/Ftq1CLhNQpL22g26IL3CE77utt6Yj95x8lrqgT
	FgKIjRh58gT3kwK0z+morGsb86+b15Iw80zjnAld16QPUufVc4UPeGpUBGe0+m4iRvy+RlVtJPO
	d74e2z/0B3XF7NGfJwMrQmWtGYClpR/JyofVykMAFWt3Vj/XnaAoiXVnLB0euFjALL3lQ4j5t6e
	GVt8eokujvHncQVBF/OlC8fqAUmt2cdaC
X-Received: by 2002:a05:600c:190a:b0:493:c068:db11 with SMTP id 5b1f17b1804b1-493c2b94615mr9321155e9.26.1782894812480;
        Wed, 01 Jul 2026 01:33:32 -0700 (PDT)
X-Received: by 2002:a05:600c:190a:b0:493:c068:db11 with SMTP id 5b1f17b1804b1-493c2b94615mr9320455e9.26.1782894811919;
        Wed, 01 Jul 2026 01:33:31 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493be4f76a7sm56484595e9.13.2026.07.01.01.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 01:33:31 -0700 (PDT)
Date: Wed, 1 Jul 2026 04:33:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Oscar Salvador <osalvador@suse.de>,
	Andi Kleen <andi@firstfloor.org>,
	Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>,
	Rik van Riel <riel@redhat.com>, Vlastimil Babka <vbabka@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry@kernel.org>, Hao Li <hao.li@linux.dev>,
	Kiryl Shutsemau <kas@kernel.org>, Byungchul Park <byungchul@sk.com>,
	linux-mm@kvack.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 0/2] mm: memory-failure: fix HWPoison flag race with
 non-atomic page flag ops
Message-ID: <20260701043024-mutt-send-email-mst@kernel.org>
References: <4f5ba5d6-246c-4430-9737-e8dd8e4c5142@kernel.org>
 <20260629092856-mutt-send-email-mst@kernel.org>
 <54c8cbee-9b26-458c-93ba-5aa594f5d1e8@kernel.org>
 <20260629174225-mutt-send-email-mst@kernel.org>
 <cbab829a-3e65-4b4f-a2e2-704e88a611a0@kernel.org>
 <f6d8354c-2f79-4a48-934c-cbeb335765e2@kernel.org>
 <20260630174852-mutt-send-email-mst@kernel.org>
 <2f884bfa-3cd5-4fba-8aa4-c2e68890ab64@kernel.org>
 <20260701041112-mutt-send-email-mst@kernel.org>
 <d2ce93d9-c3d8-4915-a511-d08eb2c1b374@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <d2ce93d9-c3d8-4915-a511-d08eb2c1b374@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: B7lFV4rsrDH6Mz6kwPJ6cGiUKe8lESss128mv3Llx04_1782894813
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 01, 2026 at 10:26:26AM +0200, David Hildenbrand (Arm) wrote:
> On 7/1/26 10:18, Michael S. Tsirkin wrote:
> > On Wed, Jul 01, 2026 at 10:08:45AM +0200, David Hildenbrand (Arm) wrote:
> >>>
> >>> Yay. I did that + dropped the extra lock/unlock and now it's in the noise in
> >>> my testing. needs much more testing of course.
> >>
> >> Cool. I'd expect that latency-sensitive workloads (PREEMPT_RT) would not want to
> >> have hwpoison handling either way, so using the no_resched variants at these
> >> places might be doable.
> >>
> >>>
> >>> If you want me to post (including addressing your other feedback) let me
> >>> know.
> >>>
> >>
> >> Let's first discuss the options. We essentially have the following one so far:
> >>
> >> 1) Ignore the problem
> >>
> >> It's been there forever ... but I am not quite happy about that.
> >>
> >> 2) Use atomics everywhere
> >>
> >> The easiest+cleanest, but as measured, the performance hit is real.
> >>
> >> 3) Keep retrying for a couple of times
> >>
> >> The big problem is "how long". A CPU in a hypervisor might be stalled for quite
> >> a while (20s? can be longer).
> > 
> > So on this idea. It might not matter. What I had in mind is:
> > 1. run the current logic
> > 2. add page to a list of pages to check, then invoke e.g. call_rcu_tasks
> >    (or call_rcu_tasks_rude) maybe
> > 3. in the callback, recheck and if poison cleared, go back to 1
> > 4. otherwise everyone will see the bit set, remove from list we are done
> > 
> > it seems to not regress anything, and for the rare race, we set
> > the bit eventually.
> > 
> 
> So test-and-set (and friends) would also have to check the data structure that
> remembers bit to set/clear (and possibly update the data structure).
>
> That does seem doable. Do you have a prototype?

what do you think ;) post it?

> -- 
> Cheers,
> 
> David

