Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EC5415F19
	for <linux-cxl@vger.kernel.org>; Tue, 21 Jul 2026 18:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784657791; cv=none; b=m/uy/nY8bk73AzaFpxAIhoLHNLE3TtdF/usU1dUuvMUTG7krqkHY1rqjMhX1BujSqAqiIMr3+5MRGZO9KML0rpE4Awp/+bbP1ZbLJnlW/HorvLwkhiMCfRWXwJRxYG3jLwmXTi9+0vP4nWn37GS/eXUYy8zftYzbdn/lge0Sgl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784657791; c=relaxed/simple;
	bh=oFlvw3giOtGQsSkXQn6VVdx6osu4tro2T3RPW7SBhU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F16IhWsvx1N/ihEaIikPw4Ikx0KlsGC1p8ZpRL1WoqrxhRNBE92Kswyz5P3q5ngZjfzWVWcUyTgSrkoSb1AJRIqlxQ0cjbd74PZUl3QJDAG5OhwqhhsX9ggLYwkeB5548Igl6OC9cxiv1mP8QgDKD6a++dAobQm1+H0+B3HAcb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=lWiMqNe1; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="lWiMqNe1"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51c2a818fc4so99165531cf.2
        for <linux-cxl@vger.kernel.org>; Tue, 21 Jul 2026 11:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1784657788; x=1785262588; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tK6CpaworNApxpcs4ZRJbHY7w08bgOkmP8ipHWd1tq8=;
        b=lWiMqNe1aGdlndmF0DEIX11ekT+kppi6ZCsdKP+nARwmUcbPRB2RiqFp9CcVZlrCMe
         a7iQJIUlHGgwrTlgeBPrEB9RYw65vbDnpQS/W6FXlBeixFMzdS/zMQMhcf9prwyKh9Tg
         zZM1P1+WyYLol3M86HhbDS8lLf0qvp8NnbVepemntzhrmA+vdbVuvJTjusRGwuudCrDN
         IJnhW0U1qCJ9qu+q+c/HoRATkAolbkeQ7YmmUklTRfiHMdfAYBd7KPK3bsHOQiTqkD7y
         nQk7+E507U93KpaB3JodhTTR0dnlAPaEgPrkM70sUwYbhPsJOnuOLMGTZLlANx5BWdjy
         4gWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784657788; x=1785262588;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tK6CpaworNApxpcs4ZRJbHY7w08bgOkmP8ipHWd1tq8=;
        b=TA8jW7owR9mNBhU16hK/ZcsoxRFtbqESpabik9BtrIpRcCCQkXtQxnU+wo61sspE1H
         eMTpsB6W0hMeZCgUT8jRAzd48SMGukicfwWz0VC4d/uXJcmb+8PD0/9N0zwLPoIC8tzy
         7gVe5xDB3OkR9v87GW/3W/GB2suihEKSRs2yootONMTwi0f1oC5ZYFMt5qpc99x6suX8
         xdf352zjCVEuYXP9nqCnBVoz0JWbyQJUcH5lTQt9KQuj3+VOTiNq9XDiB7/wUixz9yJZ
         KTG5lT97O4bOMNE38eUTaohfl2aPmv0gd1U1b8SlnTPPLnG3puuiWEnTwfnTuPxCv/xP
         QgZA==
X-Forwarded-Encrypted: i=1; AHgh+Rq/uiDCDyedXdnmRwltoxwPHxIKzMaEg6ie6jjdBti9hAuHVD7fPPuU7M7jAa3Rm4wsCCnvrugYoMA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/fH9AyovbAgcazCuDQzib0cFuxUcbGTEz3YP2Nh5bMZUbDvoE
	nnYEcvj72li6ei+tiY29yUeMYCMSh89wxw16v/Ih2HxOqayx42ohuY9LaWN+Nn/BTPw=
X-Gm-Gg: AfdE7cme4LtUo89XcgnaKeN0RzV9MREKyf5HIi6m81lHJwXVTYmPVWb/NyjtfX9atEv
	5gybo0+eoGA8mroY00O5hrlH2HWTu64ydJZSiHRWVBHBJnj3YfzYVcQ34KI6vUTxFJJy+NBENfy
	N+nIALe8aAA++Z9fARhID8ODRDzn1wE1IIDjnAR6CzYkZZeURKK17YxXd8zP3t1qvMsOGKeEbKJ
	ncDzOYjLifvZZYOGteVXDm22J3GVjPrxTLBlCOE1Yb8ITNRVbPxVZIf3YwF+kKOxMGmyarlr4+e
	mxT8NNVcRj+aGW/WjM0FscZBni+IssyEJGPF2kBIaM7xqREeWPPDqRoC6FKxKHOF4S3kh8iF3ER
	V2nsLSQ/06n6WjJGDHBeyU99iAYD6TfEirE9mo8d9roLbvIMffDREJGMa/ZxpxaCPE6mzXqFRgy
	vQOZcSB0Mfox/zQkBNMPKB39+MJfn3psWUcQZhdhPfQPAubx7/b/q9EVx7lfxs+pFBAOw7
X-Received: by 2002:ac8:5845:0:b0:51c:7b12:600a with SMTP id d75a77b69052e-5213e881e44mr171868611cf.86.1784657787636;
        Tue, 21 Jul 2026 11:16:27 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-527d066fa6asm463921cf.6.2026.07.21.11.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 11:16:27 -0700 (PDT)
Date: Tue, 21 Jul 2026 14:16:21 -0400
From: Gregory Price <gourry@gourry.net>
To: Balbir Singh <balbirs@nvidia.com>
Cc: linux-mm@kvack.org, Zhigang.Luo@amd.com, arun.george@samsung.com, 
	brendan.jackman@linux.dev, yuzenghui@huawei.com, apopple@nvidia.com, alucerop@amd.com, 
	matthew.brost@intel.com, akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org, 
	liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, surenb@google.com, 
	mhocko@suse.com, corbet@lwn.net, skhan@linuxfoundation.org, 
	gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org, djbw@kernel.org, 
	vishal.l.verma@intel.com, dave.jiang@intel.com, alison.schofield@intel.com, 
	osandov@osandov.com, jannh@google.com, pfalcato@suse.de, jackmanb@google.com, 
	hannes@cmpxchg.org, ziy@nvidia.com, pbonzini@redhat.com, osalvador@suse.de, 
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com, ying.huang@linux.alibaba.com, 
	kasong@tencent.com, qi.zheng@linux.dev, shakeel.butt@linux.dev, baohua@kernel.org, 
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, yury.norov@gmail.com, 
	linux@rasmusvillemoes.dk, longman@redhat.com, ridong.chen@linux.dev, tj@kernel.org, 
	mkoutny@suse.com, sj@kernel.org, jgg@ziepe.ca, jhubbard@nvidia.com, 
	peterx@redhat.com, baolin.wang@linux.alibaba.com, npache@redhat.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, lance.yang@linux.dev, usama.arif@linux.dev, 
	xu.xin16@zte.com.cn, chengming.zhou@linux.dev, roman.gushchin@linux.dev, 
	muchun.song@linux.dev, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	driver-core@lists.linux.dev, nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, 
	linux-debuggers@vger.kernel.org, linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org, 
	cgroups@vger.kernel.org, damon@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH v5 00/36] Private Memory NUMA Nodes
Message-ID: <al-2D_7NcwMxqmsM@gourry-fedora-PF4VCD3F>
References: <20260720193431.3841992-1-gourry@gourry.net>
 <6a7aaac3-e70d-4063-9c84-e643db1488e0@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a7aaac3-e70d-4063-9c84-e643db1488e0@nvidia.com>

On Tue, Jul 21, 2026 at 01:46:01PM +1000, Balbir Singh wrote:
> On 7/21/26 5:33 AM, Gregory Price wrote:
> > 
> > Patch Layout
> > ============
> > The series is broken into two sections:
> > 
> > 1) N_MEMORY_PRIVATE Introduction.
> >    Introduce the node state.
> >    Opt those nodes out of mm/ services.
> > 
> > 2) NODE_PRIVATE_CAP_* features
> >    A set of mm/ service opt-in flags that augment private
> >    nodes to make them more useful (i.e. reclaim = overcommit).
> > 
> >    NODE_PRIVATE_CAP_LTPIN for private node folio pinning
> >    NODE_PRIVATE_CAP_NUMA_BALANCING for private-node NUMA balancing
> >    NODE_PRIVATE_CAP_DEMOTION for private-node tiering demotion
> >    NODE_PRIVATE_CAP_HOTUNPLUG for opted-in private nodes
> >    NODE_PRIVATE_CAP_USER_NUMA for userland numa controls
> >    NODE_PRIVATE_CAP_RECLAIM for opted-in private node reclaim
> > 
> 
> Looks reasonable, I wonder why USER_NUMA/HOTUNPUG is an opt-in?
> 

Ideologically: Private nodes default to fully isolated, why should any
given feature be special?

Concretely: 

User-numa

   Some devices don't want the user to have control over placement.
   I have been working on compressed memory, for example, which only
   ever wants to be used as a reclaim-demotion target.
   
   (The reasoning for this is another thread, i plan on publishing
    my research on this this year)

Hot-unplug:

   Some devices can't necessarily handle unexpected migration, and
   hot-unplug is fundamentally a migration.  So the HOTUNPLUG cap
   actually means "hot-unplug can execute migrations".

   If the entire device has pre-drained the memory (all memory is free)
   then unplug works - it's just not very hot (no migrations) :]

   Maybe a naming issue?

~Gregory

