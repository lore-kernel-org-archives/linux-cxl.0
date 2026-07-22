Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF7D34EF1F
	for <linux-cxl@vger.kernel.org>; Wed, 22 Jul 2026 13:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784728139; cv=none; b=W2bPusH9gtGS+qfcVL00MQjaOXhKpidguiuAUYbWDpu5syFan2EQS9miCmrg9oxrx69br3onsw3qmX5Vq0f69ExRrY7ZBZRrj3d+cWtJ81tOIdub8gQNIsYvHNTVN3/1Getem+iljphD1+mlDvqtkHgTmOzQNvApPffoZPcFmX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784728139; c=relaxed/simple;
	bh=JAIqzpQM3gUx7M+gDSziic1KcB43W58VAXiVvJF0/Hk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gqVhgSwIExyLCiTjCF32KcYb52Abm6+pjuur7KvXjnSH/LdLPbh0SJTKQpqCGsXll0zKy2JHaWglK5NGBpVIIz4ohY+0iujwvi0P7JIRAOj/Ky/HjzLvayg9uPVZqwNDP0+TRta3i4rtYI0Ltrb+tcchltwVlVmP/KPb9O8Mx3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=GfLa6fHj; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="GfLa6fHj"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51c4436d02cso50814361cf.1
        for <linux-cxl@vger.kernel.org>; Wed, 22 Jul 2026 06:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1784728136; x=1785332936; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LI4otu0+1hHJyrtu/tBxz3iTtloCysub9k9iNgYv1gk=;
        b=GfLa6fHjBw5k5Cgmz1whJ5nETVeelFxMT26tNktv/o76lhNb8g352TR5NSgzxj0xK/
         l99ZU3otNIqIWf5NPRZOUByX/rsuPiQ11f/76fJZU6VdndYf/hECk1QXXGmtm6zxg/D+
         Jp3L7vWik0zmayA89l50HzOSWyCZrphTG1lt1EZnBbJQbWY5rLr8WS00j1qAY7moV6C6
         lTJ7XSZYNDD8dlO/MPxVy2EEZD8SCjSLPMCaZCsQD7e37hasV8TP4a+NhorAAbZ0Ohhs
         6nlqtYbIICyZZQkN6OqTZwVx6r17L7v2FbkjPkZ0Eqhsumnot7b9+N7Dj0SpPbVDkztD
         g8YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784728136; x=1785332936;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LI4otu0+1hHJyrtu/tBxz3iTtloCysub9k9iNgYv1gk=;
        b=IhlJqxr7wKbDJtKFET4tn8F8A+Mf8djEhv1jNha5bhqEUIN4sadhYVNDakT9SVBLXG
         WU6bwn7vsT+shZOHgdNkI3viOI+nllgrEMbO5r4FaRNms1upbAsHyKmr4ywigOYl1M6l
         BsvW1PzNeTNxsB+rO1lo9rni1VLvi2gFpniU+b1nOyGnEMRpKtgBtsbWvmMsPQZ62pOe
         fRnqGPL1tnBUTcfRtnopKmDjkfpgSXnIlDS0wY5Tqr4h6CxsX5Kzykux2gUM76qmZT3u
         R4Ur1q8JrjAGkvTyKy2if+pz5bZjFTm6LJTHR0efXC2U1TMZOTle78+XiAbL3f/NX4Jf
         CXwA==
X-Forwarded-Encrypted: i=1; AHgh+Rr/aI5MPPXxVnGjk+RwSAiCb80ulaY9ImT4qlOPSjeWQZL2rs9m8akVupNeJK8FeEAw28fIy8UoyGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNZkn2u3Q3rRh4FC4Jdjcjzfdp8DG9jQMscEmGyC0ZNtkePG48
	DTYX7YNHoYdBcyS/8MwCrP7eywS45qOuft1cUlE6dQEbaBkRVpmLPGnENv2n9NGdkr8=
X-Gm-Gg: AR+sD12c+PDk9TwlGay6IGGQ5YoGDP33fx/KkHiB1LLqvFQZLx8UClps5jona20H175
	zh+1GuvqlGVcGpTtlQsZJB9cOx17z9sz387ymDeix9Vimw1u9j4ELc/3Ei/o430Uo9yfR8DZ4R1
	fisn9dQn+OPFZACrXUTo4Dxv7PnX4M3gFrSdgN5Z3TAZgwsorPedjQFWVpGUdHhIyMSlmcjCIgm
	hz3JKm2UNUBnrQXsPts5hu27KrMgd3qt9OJnj75spn4ivK7NxbWqPemnpmYypS1B9VifYZ+S5Ru
	tts7yGL1XuJ4QIYGTA5Vig5dLRT9x9Ji75R+fUEed6nHgSiPlo/MpJ+ujozo+ib9yOzsaZaUU6Z
	64omPzUBkDpO3Lx/w+OeuPuEAfhCJ6eJ5Hx0yEhB3sGDnYUzasQ1JQsbGYsSF0uwOFBoeRnR9AX
	mcmeWt0jTgWywkZtBSXrNfLnAGaIu0G8t2IcOIZuUQev+OOCy6BQmbLNM2ew==
X-Received: by 2002:a05:622a:350:b0:51c:555:7dea with SMTP id d75a77b69052e-5213cbd667cmr215415981cf.30.1784728136109;
        Wed, 22 Jul 2026 06:48:56 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907ba8e2581sm21393266d6.19.2026.07.22.06.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 06:48:55 -0700 (PDT)
Date: Wed, 22 Jul 2026 09:48:50 -0400
From: Gregory Price <gourry@gourry.net>
To: Richard Cheng <icheng@nvidia.com>
Cc: linux-mm@kvack.org, Zhigang.Luo@amd.com, arun.george@samsung.com, 
	balbirs@nvidia.com, brendan.jackman@linux.dev, yuzenghui@huawei.com, 
	apopple@nvidia.com, alucerop@amd.com, matthew.brost@intel.com, 
	akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org, liam@infradead.org, 
	vbabka@kernel.org, rppt@kernel.org, surenb@google.com, mhocko@suse.com, 
	corbet@lwn.net, skhan@linuxfoundation.org, gregkh@linuxfoundation.org, 
	rafael@kernel.org, dakr@kernel.org, djbw@kernel.org, vishal.l.verma@intel.com, 
	dave.jiang@intel.com, alison.schofield@intel.com, osandov@osandov.com, 
	jannh@google.com, pfalcato@suse.de, jackmanb@google.com, hannes@cmpxchg.org, 
	ziy@nvidia.com, pbonzini@redhat.com, osalvador@suse.de, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, ying.huang@linux.alibaba.com, 
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
Subject: Re: [PATCH v5 26/36] mm: add NODE_PRIVATE_CAP_RECLAIM for opted-in
 private node reclaim
Message-ID: <amDJEbu3aQO8J8f4@gourry-fedora-PF4VCD3F>
References: <20260720193431.3841992-1-gourry@gourry.net>
 <20260720193431.3841992-27-gourry@gourry.net>
 <amDGXU94trqlXUgR@MWDK4CY14F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amDGXU94trqlXUgR@MWDK4CY14F>

On Wed, Jul 22, 2026 at 09:36:14PM +0800, Richard Cheng wrote:
> On Mon, Jul 20, 2026 at 03:34:20PM +0800, Gregory Price wrote:
> > +static struct zonelist *memcg_reclaim_zonelist(int nid, gfp_t gfp_mask)
> > +{
> > +	unsigned int aflags = ALLOC_DEFAULT;
> > +
> > +	if (unlikely(!nodes_empty(node_states[N_MEMORY_PRIVATE])))
> > +		aflags = ALLOC_ZONELIST_PRIVATE;
> > +
> > +	return select_zonelist(nid, gfp_mask, aflags);
> > +}
> 
> 
> I applied this code change and notice in mem_cgroup_shrink_node(), it calls
> shrink_lruvec() directly and never passes through shrink_node().
> 
> This patch makes private nodes reachable through memcg reclaim zonelist, but
> what prevents the direct per-node memcg path from reclaiming a private node
> that has not set NODE_PRIVATE_CAP_RECLAIM ?
> 

I legitimately missed this.

Sashiko also picked it up on the filter patch:
https://sashiko.dev/#/message/20260721183528.B4B9C1F00A3A%40smtp.kernel.org

If nothing else - implementing this feature has taught me some
sub-components of mm/ have very well centralized logic, and others (like
vmscan.c) have 3 or 4 different paths in with a lot of strange quirks
carved out.

I think some of the vmscan paths can be improved to simplify this
interaction, but i will fix this particular miss in v6 and come back
around to see whether we can clean up these different paths as a general
improvement.

~Gregory
