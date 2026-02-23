Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA511308F0A
	for <linux-cxl@vger.kernel.org>; Mon, 23 Feb 2026 16:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771862924; cv=none; b=q9yMG1vBON4uI+x/GYe1XF16Q9j2NnwU43VG2blAx25QVejtIrHc0Zb+j4cV1lw2lIZx4Rj79n0fQIiKCSxR/9Si6Mq+MdQA1nxxYFSuQltj+GyAe5LPZtcbqZZvdEGfS1vK+bS3KxWUt5DN4PdZJvskcf6gzW4FX9w2MLMzCUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771862924; c=relaxed/simple;
	bh=EnsbfZuxC9RIxnGqfBuxuj/9JrH+GEm1z2N32vhH5LU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Du6L/06LbHnTCuFUml56k36w1dr5gsd6FbhR9U01JV8md93uW/euYv6zwZpD9qwV/ZuGq3/IByQvHx4qX/kI1Hnh9pOM06AsTSt16pr8EEW+uesZuaG2zxKAk7NZ3sOuFWepHwBqCCsrg4YY1HP+DfZsK4TOyZQaKmAuYwU75TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=BsPhcHiQ; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="BsPhcHiQ"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-50698970941so49357161cf.0
        for <linux-cxl@vger.kernel.org>; Mon, 23 Feb 2026 08:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1771862922; x=1772467722; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hp6xyKYDxr6lXYQA9JHTZDh6ckgrNYb0tSD8kTJSDxQ=;
        b=BsPhcHiQGsO4aoJboaOZn97P6uBmWUfSjz3Od8jXn/z1O+Gnwj6js3XjU09uVlsnSB
         9zRAzlb9E5oo++sFMpDsKG0UH7a0/+s8tFHwHbczUDpVVL9KM3CI3mfmBljlKYBt+xX3
         l/nCtNXkxQJLPWl+OlSUT5LRiz6tuDrFGyiBDeq8dQ7GRvow1YoSDnDsDs0Fs/MisV0S
         pef6NHm9kuIXh+HpG6hX+aDkR5WJqhM3HXtKt6Z9YnWCfjtHaRaVi2jxBnF5h7M0Wjmi
         CG9Ii/EHnmggQMJVwfnFdJ9p+BX2e0arNJHAjIt8QmHCCXxWin+Jseb8pDRwEVgXjGvF
         MeHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771862922; x=1772467722;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hp6xyKYDxr6lXYQA9JHTZDh6ckgrNYb0tSD8kTJSDxQ=;
        b=r6A+euy12WoqEnhN4oHFLiECQqB3JzuZdUYrFOxB815DaRZJ3JCIErs6NVrx0mtlON
         GxGyzX/8i1AXNcwQNZ2ZdMO9PSPRIjlplc2dV7rzQns63tuwdq/lSbOH1pK5+3KCrhTp
         EGwp9cY+i4EG3bUJWjeU4qFVINpLw6OVp06NBBqwpw3bueyvSPjKwMtnqo34yh5v8IQW
         et8DlunCC0jJXE4IL8WlUAnkgRf14RE9qThBbB2Nx1KIRlcwkFqHifzzr675UQy54Wl1
         qYi0dWOOCSQAZ1wu/WBw3kXRh5KdgPuZCVnZgB3JF0UersLYC7JRWmKnGOqDV1pqsZau
         4gsw==
X-Forwarded-Encrypted: i=1; AJvYcCVpf9l+eOqOAV8uANcB1iYmg1FHe96oBDDKSeChHuso5joSbKz0WrqA+SliuPloEkCuar2dw5yTxOo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJNEQEBqMCKanJ6BtEZ7hdD0KrBxlzTv82XJm9JKvWlkz9NiX2
	LqL0q8+hpnHAGSCq+iOhvBFw5LEzT0IQ8Hr4VR9rlfyTpVLbV5QOIwdEluH/A7020zs=
X-Gm-Gg: AZuq6aJ8jLhi+W3y68ii4Z25rtzt8+iUixFi4jCx/mJwbKtS59CndrSfbldNPFOc3I/
	lU/OQSB6b28HMgIzCnDF9jo8YpxMr5Ccx0WIKsO5h0qqYoapY4VAEOo1Z1AnMr0Fyiw5VuTSYWh
	I3pnc0XSmYZgCDZKrqqCzQgY84mMYhQLB8jWIKW20BskGu/UekTi/CtSQHYfLzX1HpVy6Tj2ULy
	dNO8/kL4taimOYEythFzSYI/SM98gBoREYDUF6PcKs9gPQy3SrGYn5wgEy+dEJhtzAwRdGAgLgq
	DTpi7JtGqcPmyAurog2i0fe3wnIxTjUr9dJzuNQZKY7NJFhWbIGQV9cop4P2l0EpSUsNrc3IoLm
	pTi1pu4z39DQRvK48dNQ9lhBSMSe7WrOHl7t0+mWEOITFtaib+d0ZpNi5UVvaOjodSPNNaZb8i1
	WjEHvYceP3XYz394e+3KO3+HkSlF8n1OGFcuuHAXz0sInciP3ZMCayi4/F/DvUjvbq/GwYfnj/S
	VUJIgP4OzUWgFbQLKha
X-Received: by 2002:a05:622a:1922:b0:4f3:5835:e946 with SMTP id d75a77b69052e-5070bca9868mr136790871cf.55.1771862921369;
        Mon, 23 Feb 2026 08:08:41 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d54000fsm71259831cf.10.2026.02.23.08.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 08:08:40 -0800 (PST)
Date: Mon, 23 Feb 2026 11:08:38 -0500
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org, damon@lists.linux.dev,
	kernel-team@meta.com, gregkh@linuxfoundation.org, rafael@kernel.org,
	dakr@kernel.org, dave@stgolabs.net, jonathan.cameron@huawei.com,
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
Message-ID: <aZx7hsVNU0XOCCiG@gourry-fedora-PF4VCD3F>
References: <20260222084842.1824063-1-gourry@gourry.net>
 <c10400db-2259-4465-a07e-19d0691101a4@kernel.org>
 <aZxqP7J1kOClQUPQ@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZxqP7J1kOClQUPQ@gourry-fedora-PF4VCD3F>

On Mon, Feb 23, 2026 at 09:54:55AM -0500, Gregory Price wrote:
> On Mon, Feb 23, 2026 at 02:07:15PM +0100, David Hildenbrand (Arm) wrote:
> > 
> > I'm concerned about adding more special-casing (similar to what we already
> > added for ZONE_DEVICE) all over the place.
> > 
> > Like the whole folio_managed_() stuff in mprotect.c
> > 
> > Having that said, sounds like a reasonable topic to discuss.
> > 
> 
> Another option would be to add the hook to vma_wants_writenotify()
> instead of the page table code - and mask MM_CP_TRY_CHANGE_WRITABLE.
> 

scratch all this - existing hooks exist for exactly this purpose:

	can_change_[pte|pmd]_writable()

Surprised I missed this.

I can clean this up to remove it from the page table walks.

Still valid to question whether we want this, but at least the hook
lives with other write-protect hooks now.

~Gregory
