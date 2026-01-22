Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891543112C0
	for <linux-cxl@vger.kernel.org>; Thu, 22 Jan 2026 16:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769099966; cv=none; b=D8DbGc99N4ysMSG58ELAeyUU4gVV4qdxiee8+sSCJ5KusZmfuvDxUx7eVKUvRbG6KBFUirx3uLjM8izi8PTEDVMvbMOC1YYRLjS+Hrhg/mAgjX7D3fH8q7AlnBx/85f74ZZtPKSxurxIr+z2p8ivxODOat8fa2Zfq03akFZZAFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769099966; c=relaxed/simple;
	bh=XorEDbyyvoKRZ9z/e0bILVETPN9UaeqR5myzu2mQX4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WvgefNSnbdu63hiIO2+s/7zD4yTGvKwlcdb8AMBilKYhU9Kz6HOxukuY0/NFkiuVa3D9dC5iwXaRh3sfie6WqXxJ8BldmwgIdhgI763gULkAd2drVDXaHLANv+MlwNPEVTansOn6L2S4TMdO3tc97oX4a+XmE6S5uX+rg58pSBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=FbAkhhDG; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="FbAkhhDG"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-502a2370e4fso9063891cf.3
        for <linux-cxl@vger.kernel.org>; Thu, 22 Jan 2026 08:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1769099959; x=1769704759; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=26F4T6+OWgQyYilpWpKxSqIZyd62LthQzewXe3OU7ww=;
        b=FbAkhhDGaL/LJRvLBdoqZpZTg3R6nNzghJFBq+PLl3XLyONiy/zlF9kFuRJ5XxHTTd
         QPydGb1Y6JildzqZqgFlj7GudxflYtozVBlMkK24WT+FKAGyeUbsVgHKEZeCklpjdevR
         C01g8+hYB2E8v7zeaDMJaqYuoIukpUP64o9dQiaodV51dfBjx0YkUWGtvI9V/qKTU/2p
         g0RIQXVFppV3+hKU5f8D//Yh/8NVctdczdSD6xrQ3EdtSjF/sOq1+6pnhdeOWC44cJWC
         6UMotKbjZXHHnnCXroV1Eupwcnca2WUgBt0WHiMMdQvzNyfkblc4RriH4g++zr1DZdp8
         b2yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769099959; x=1769704759;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=26F4T6+OWgQyYilpWpKxSqIZyd62LthQzewXe3OU7ww=;
        b=Sc+jYN5QAhIl7DOpQmg5U+VHwSbPA2kemKtzTFECnqpW8pqaYOThzSGAQ844By8DIS
         WVNmMMrMMtOUzojq02yFHzWM1xu9zTLs5Egrw9C/iUNpcCQj8MRCWbT+YhryAI0Q31K9
         IhNZoZIHOAJfTVaGm8ee1LY/Y9bvO0dxwRIexccmtKLJNrs8hqkVq7CUXV8jr7vK1i0v
         ADqUJJ+eY18pl6HmbCTPH8tPpnQRG/O6VgwsV1Zw3PrEXHqracnCAhk7PfLoN/DBFr7T
         /1lvP6uIEJ9dD+qttU0fS3fUEv3DC8hwYnIT2w5QLYdk4tOntN76i3wCwZgfLQ6KtD2N
         6UtA==
X-Forwarded-Encrypted: i=1; AJvYcCULS98dckzwrD8XNQ3sIr3KCdILEEuQDek2/9GX2DeCHR5MPf8UxKCLcBzCx0TyPmmF1Y18QywVKfM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz91UDOqXaDAxy5LoKimeQ7IukYrmBuAVue/WOMU4BjCEAm8cx
	izRcvElEoB2fC3+Hg5cDdS+guiZC2mnXpMsR3mlAEJOYvdSrB7f2SxmLC5kv5mgyyY8=
X-Gm-Gg: AZuq6aJHu10BHmtoAXsrS9eHAP+Wb58eVDHsdDGdyWZ2yzBmL39jg4mgCNlkvLtXtZG
	Fx3y4zyoXCc6TYZSOhlHlCfN6pYoiCStHZRHAxAaRMp+UQmnWfCAg2TUpgLdCyCTLy+CY30KtTN
	7MFnWt/TpXxx0QAwahluFi4thU0WC9PXZ0d+Bbd4X/96HvX407FxPIUbdkkhTZoAmCJjOj9TU1e
	WpssUYIJmh4izX++6goasj/JnYxZH05FElVr3Qu3t6g7E2qAOV3KlMErbqDFQQWkTJnSDkZvzs3
	6JXVQRe5lycxhsawERm/RyJy+wl3snqL4Nj1XsG4IRJKIar+ekjlVARNu5ZKXBYpeRDZblhWA/x
	fvdkUTVFGo1BVrapglAVuFwD37riVPL4xavWW4bjmRFfRXSZZWS0D1bADs3IjstugW5C/KMKXc2
	9xcL8exNN/cQU5Q4mGmyjHNtc0kO+LUoQntEYtIoZTv3TlXLs7hGP/wrrhztcRSg8RYH7IGA==
X-Received: by 2002:a05:622a:18a7:b0:500:d108:275b with SMTP id d75a77b69052e-502f775b653mr2055011cf.5.1769099958557;
        Thu, 22 Jan 2026 08:39:18 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8946e7fa675sm43565766d6.35.2026.01.22.08.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 08:39:18 -0800 (PST)
Date: Thu, 22 Jan 2026 11:38:46 -0500
From: Gregory Price <gourry@gourry.net>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Michal Hocko <mhocko@suse.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	akpm@linux-foundation.org, axelrasmussen@google.com,
	yuanchu@google.com, weixugc@google.com, hannes@cmpxchg.org,
	david@kernel.org, zhengqi.arch@bytedance.com,
	shakeel.butt@linux.dev, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, ziy@nvidia.com, matthew.brost@intel.com,
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
	ying.huang@linux.alibaba.com, apopple@nvidia.com,
	bingjiao@google.com, jonathan.cameron@huawei.com,
	pratyush.brahma@oss.qualcomm.com
Subject: Re: [PATCH v4 3/3] mm/vmscan: don't demote if there is not enough
 free memory in the lower memory tier
Message-ID: <aXJSlv1_K1uQCN16@gourry-fedora-PF4VCD3F>
References: <20260113081453.8293-1-akinobu.mita@gmail.com>
 <20260113081453.8293-4-akinobu.mita@gmail.com>
 <aWZLZzo5Hb1aFZ0j@tiehlicka>
 <CAC5umyib=XmPkTvRT6eAsMx+WDx0NkSP9djh4xkhLJgwk_v8Mw@mail.gmail.com>
 <aWfXHKDzoQBsHxAp@gourry-fedora-PF4VCD3F>
 <CAC5umyg+wubKoQSfpDQvNh3K5Y7+iOEYn6_BuKFd53kHDVE7aw@mail.gmail.com>
 <CAC5umyjOgZE0Qpa3W3qZ=sSkwkuf_md47jctXgi5UKWuG49o1Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAC5umyjOgZE0Qpa3W3qZ=sSkwkuf_md47jctXgi5UKWuG49o1Q@mail.gmail.com>

On Thu, Jan 22, 2026 at 09:32:51AM +0900, Akinobu Mita wrote:
> Almost all of the execution time is consumed by folio_alloc_swap(),
> and analysis using Flame Graph reveals that spinlock contention is
> occurring in the call path __mem_cgroup_try_charge_swap ->
> __memcg_memory_event -> cgroup_file_notify.
> 
> In this reproduction procedure, no swap is configured, and calls to
> folio_alloc_swap() always fail. To avoid spinlock contention, I tried
> modifying the source code to return -ENOMEM without calling
> folio_alloc_swap(), but this caused other lock contention
> (lruvec->lru_lock in evict_folios()) in several other places, so it
> did not work around the problem.

Doesn't this suggest what I mentioned earlier?  If you don't demote when
the target node is full, then you're removing a memory pressure signal
from the lower node and reclaim won't ever clean up the lower node to
make room for future demotions.

I might be missing something here, though, is your system completely out
of memory at this point?

Presumably you're hitting direct reclaim and not just waking up kswapd
because things are locking up.

If there's no swap and no where to demote, then this all sounds like
normal OOM behavior.

Does this whole thing go away if you configure some swap space?

> 
> When demotion_enabled is true, if there is no free memory on the target
> node during memory allocation, even if there is no swap device, demotion
> may be able to move anonymous pages to a lower node and free up memory,
> so more anonymous pages become candidates for eviction.
> However, if free memory on the target node for demotion runs out,
> various processes will perform similar operations in search of free
> memory, wasting time on lock contention.
> 
> Reducing lock contention or changing the eviction process is also an
> interesting solution, but at present I have not come up with any workaround
> other than disabling demotion when free memory on lower-level nodes is
> exhausted.

The lock contention seems like a symptom, not the cause.  The cause
appears to be that you're out of memory with no swap configured.

~Gregory
