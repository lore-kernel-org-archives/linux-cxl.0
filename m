Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640353803F8
	for <linux-cxl@vger.kernel.org>; Tue, 13 Jan 2026 13:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768311661; cv=none; b=MStXiSjirNdYIuBrmMpwE327TQcguE4shcYlrVtArNaWba2HqIEIZguAs2hCuc5xPBSTMMzcAcnpvBd7D549CxFzJlFgCCreCjPk4RXWd7wTcZFn/hn68ttjx65/6biIxSeLRx741Ihcm2uGFTxE2DjX3rlzwyxT6Gs+7HcGFGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768311661; c=relaxed/simple;
	bh=jGzGrD/PbeywSnmSsKK8romCiGJbqWqEAzsE4Ch9YtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=taTYIH0ggMrZZPdN/bWRystsdGmC1u5CfFWzUo0/xwHr4WRpdB6I+wYMcVyRMBi6pFlWPaO4qxP+watvRb2IY8FhZ5j0Txf12AjIA0FbBZkeLMCrGqd4h1jRdPiYRFZ/87yzPs3uey5f25pLaFn2RT7dCoQ2m7866BQFYxgg1Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dQUGLxkk; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dQUGLxkk"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47ed987d51aso6911715e9.2
        for <linux-cxl@vger.kernel.org>; Tue, 13 Jan 2026 05:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768311657; x=1768916457; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hOqKXa6v4TuBaNjoDA47lyBnXhGd9ZScrVY1o+qPEe8=;
        b=dQUGLxkk8IduLU5P1LrHk1dvyAtPJwIhwnOQmC37tgcle7KSCi68M2al6w6mmlnsdI
         VhMRUXAOxgIpHLAfQFZx4bv/5f/JHifCJhCPHUnwoSuzivmJRbfORkPdU4oEvljuCnNg
         x++2hzESgmE7dnc3xGJdnncPIeqNMM3c5/He0mE9wXyW6nxLUCUwiPUlvHjnP54xOR8d
         S5t/sR5jEroHFgpnuQh0ZqPEkX63dswyNlLv+1g9iw+woPpduvu7jWc5o3pvcFmGIf3n
         jOqYRUqHCWC0PAddYuxuSHLYOWyZvq8e9H+F3iNgBSbX8BbacMYa6r/gEYoH8TA+fSbN
         EHUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768311657; x=1768916457;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hOqKXa6v4TuBaNjoDA47lyBnXhGd9ZScrVY1o+qPEe8=;
        b=mu0il794dpINV9fJkcfsdd/sRW3EKoZtZM9NpfkZ3idCdi+U7PoxaE4EKfDn9OrcNz
         PmroTjg+XgfkrU/+mxC5ZUriZYIFohM4VxQpF4hNUHnq27XuBpR1yGfaMZrAxec/67pS
         7uCyTP/hteL38Wn7JCLcluYZvodB/ujcw+J5jLnt41+YE0QNLvCVwbg4IaLV6lF35Pzz
         05S93uBJl9b8vKpVbk6RT6NTs1EOwd05qFSUf1JLDbnpnqTAjo2iwcKn0ooZD8QAGXag
         BlC3hrPYxggRf8iSwL44kG/Acf3Eznk8JDhK84H6lCVUFCIulAKwih2a1yC4V6dAfHwO
         QpZA==
X-Gm-Message-State: AOJu0YxKSiqQEKvdQNfN/537vebabkvV88FFBv36DxY7b+ja3AB7gMa3
	fGX/SZpFsr+XH5iBeKvlx/dR8EGoOUagng7/u2OO1jcpjrp9BIDNqSmU4SUKjvbcjyI=
X-Gm-Gg: AY/fxX7D4HVCbHt0cKFZ8pCK9GliAYE2KTN1kaNB7SOG4eppqChCzibh1oB7jXvm/dw
	Hr5GlQmnfb4vwvO3x0kN/+5v3iMcIw6bUKSNZ3VQBV+t5uYFgorRMSj4kqCOdwE1QQyU+vHX+w0
	KSoJ6h2nsiTmZSfTdcBM6Xk/jdnlbjHfe2sDb1NKeocLlzsAFflKU4Tf1XANDjOw70cz0W+hEIv
	5MxIMO8pL1EsmjfV+mPQP5jA3ZWmsfNHFl2Bux+uTDHdfcxSHxYhqb9KBzfung/3zXldP9LM1bn
	gN8hUmM/1vU6dEZiMMvryDETlQnrS5g6E0t57GzqK/SIzXt7yhwvrEZ/H9mcBDcBZlfQQz3v1mp
	FtCk0L6dm1+ADwhGHAH+cWZngBB2gno2hj+RBmV83o1yuAEeeGw+35cMdiIXGLeRByS4ikyC5HH
	t8CEvKEHLMXHn3xHvsZSp66gOM
X-Google-Smtp-Source: AGHT+IF8cxzSR2U/aI/gpis3jn6E94G2h+DlhGUvJnL7EqPj7dinresMd7rQXy64ZZLM/dvYDYNI2g==
X-Received: by 2002:a05:600c:19cc:b0:47d:264e:b35a with SMTP id 5b1f17b1804b1-47d84b19f69mr245181875e9.13.1768311657513;
        Tue, 13 Jan 2026 05:40:57 -0800 (PST)
Received: from localhost (109-81-19-111.rct.o2.cz. [109.81.19.111])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0daa78sm45085370f8f.6.2026.01.13.05.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 05:40:57 -0800 (PST)
Date: Tue, 13 Jan 2026 14:40:55 +0100
From: Michal Hocko <mhocko@suse.com>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, akpm@linux-foundation.org,
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
	hannes@cmpxchg.org, david@kernel.org, zhengqi.arch@bytedance.com,
	shakeel.butt@linux.dev, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, ziy@nvidia.com, matthew.brost@intel.com,
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
	gourry@gourry.net, ying.huang@linux.alibaba.com, apopple@nvidia.com,
	bingjiao@google.com, jonathan.cameron@huawei.com,
	pratyush.brahma@oss.qualcomm.com
Subject: Re: [PATCH v4 3/3] mm/vmscan: don't demote if there is not enough
 free memory in the lower memory tier
Message-ID: <aWZLZzo5Hb1aFZ0j@tiehlicka>
References: <20260113081453.8293-1-akinobu.mita@gmail.com>
 <20260113081453.8293-4-akinobu.mita@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113081453.8293-4-akinobu.mita@gmail.com>

On Tue 13-01-26 17:14:53, Akinobu Mita wrote:
> On systems with multiple memory-tiers consisting of DRAM and CXL memory,
> the OOM killer is not invoked properly.
> 
> Here's the command to reproduce:
> 
> $ sudo swapoff -a
> $ stress-ng --oomable -v --memrate 20 --memrate-bytes 10G \
>     --memrate-rd-mbs 1 --memrate-wr-mbs 1
> 
> The memory usage is the number of workers specified with the --memrate
> option multiplied by the buffer size specified with the --memrate-bytes
> option, so please adjust it so that it exceeds the total size of the
> installed DRAM and CXL memory.
> 
> If swap is disabled, you can usually expect the OOM killer to terminate
> the stress-ng process when memory usage approaches the installed memory
> size.
> 
> However, if multiple memory-tiers exist (multiple
> /sys/devices/virtual/memory_tiering/memory_tier<N> directories exist) and
> /sys/kernel/mm/numa/demotion_enabled is true, the OOM killer will not be
> invoked and the system will become inoperable, regardless of whether MGLRU
> is enabled or not.
> 
> This issue can be reproduced using NUMA emulation even on systems with
> only DRAM.  You can create two-fake memory-tiers by booting a single-node
> system with "numa=fake=2 numa_emulation.adistance=576,704" kernel
> parameters.
> 
> The reason for this issue is that memory allocations do not directly
> trigger the oom-killer, assuming that if the target node has an underlying
> memory tier, it can always be reclaimed by demotion.

Why don't we fall back to no demotion mode in this case? I mean we have 
shrink_folio_list:
        if (!list_empty(&demote_folios)) {
                /* Folios which weren't demoted go back on @folio_list */
                list_splice_init(&demote_folios, folio_list);

                /*
                 * goto retry to reclaim the undemoted folios in folio_list if
                 * desired.
                 *
                 * Reclaiming directly from top tier nodes is not often desired
                 * due to it breaking the LRU ordering: in general memory
                 * should be reclaimed from lower tier nodes and demoted from
                 * top tier nodes.
                 *
                 * However, disabling reclaim from top tier nodes entirely
                 * would cause ooms in edge scenarios where lower tier memory
                 * is unreclaimable for whatever reason, eg memory being
                 * mlocked or too hot to reclaim. We can disable reclaim
                 * from top tier nodes in proactive reclaim though as that is
                 * not real memory pressure.
                 */
                if (!sc->proactive) {
                        do_demote_pass = false;
                        goto retry;
                }
        }

to handle this situation no?

-- 
Michal Hocko
SUSE Labs
