Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4584B346E4C
	for <linux-cxl@vger.kernel.org>; Thu, 22 Jan 2026 18:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769106903; cv=none; b=N1KB2zgDFyeoj/r2qj0cWFJG3UXXwFlWgn2mtbxQ3xhfBMQ7c4xYSK/hFOok+FX0mdnnjfme+Xg5kJTnpQVq8ryq3p93kpayMnk45nM7AV2YBoVkSiFBqextlQG9jxy14+vlN0WpH8l5gV3+57yegLAtcvLpDZzJZt0xOqCxWUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769106903; c=relaxed/simple;
	bh=wbtFg+skcBqgF5MTcXPSDxO9rOPC52NVjval1/lvzxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N7j61IzTQyA1vTCOcYeUitj4lzyyYO9DaC9QNBzvej+UnlyidBPKBG8BnZeHFJl3kpwhwEXSuZICHokH9Yhc2Wh6M2JWW9pOFhJONU8CuVb+fvF1JoqnPALsbx6iee8hiulhfTwpC0Ovzs44bDApZGTkcz0WjxjKkX7zoAdLBus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XxpvlVIq; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XxpvlVIq"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-790992528f6so12894717b3.1
        for <linux-cxl@vger.kernel.org>; Thu, 22 Jan 2026 10:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769106896; x=1769711696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mq5VJmqRAo0xyjSAtScAIcpCkrPE7TyUs2+qpNnChkY=;
        b=XxpvlVIqZ0IfofRHGQWWylRC8GxN6bMSvOumG22vLgb70sXqTdtQQ4nIfPF9Cxx3e5
         pPnCEElIZbmJYql7WVfHzGuLe/0FadSSkAe2lqglPK3BSr7RiKPZhssCxe/mAqlKeAF6
         J7PIJqKol1SaiKgCko7LUQ9mtmgOYljv7PzFrqVULKhcgfLp0QfhGGIWSozjTY/DBFyB
         0pMjjt/iXpsBdEkODfxCeQHXdBZu5JhO7J1Un8gsbheNMJhD7Tips95nl9qAMJNGDUPj
         Kh1o40OaK5q6RjSh9sFqvPdXeKs6Xp2fiNENJqMbCi/aisBXDReBstKpLeZELuHYCw1R
         p61g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769106896; x=1769711696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Mq5VJmqRAo0xyjSAtScAIcpCkrPE7TyUs2+qpNnChkY=;
        b=uTrBed4VPAtcomq3esD2GENtxyH7q0MQqGZOnnaWI2UfJMBmUPYumRIfkBrKm/t+v1
         S7ewG9bV+fiyyfcyhUXuXhu1XVIx1MWrxUy50BNAvwnBTkHTTlZI/6+lxwpvjFfQ44WS
         dEcQUtLwjbOLF3aogroqMnCykfFtSMK4l5vsz0hxds6FrTxieUuf1BfcnKqNva89WQdr
         KGo5U4LJApKPZ94pgBsoG8lfgn05i1MShXB3wiJGKURPZO4+eaOnJxanyKja+o5NVU3/
         80WWzxeyvmqN0ZS3znvLWM80kQVu4lZ/MGUvTcNTedvbpVdKcOq6P9FEbdnA4t7qSfz5
         q0Ww==
X-Forwarded-Encrypted: i=1; AJvYcCUlzNXyMf3GBhAkdkaDwwEPJKgijmbuAPJLGLFtPttkB+jNAzFqqNwXNC1oMPTMeRTk0SOC8SjTPDI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAHd3wjx9fXUBvvhvOX3kUd5YX0xEtayqHUbSWYSKh6yydGBOb
	Oux//b8WuU0LSwGKv2JkHE4vAMJeI611WsgRi62zTEySnKjMY4vaMZlwCVvvgw==
X-Gm-Gg: AZuq6aLKrrX6DQRzbQ9DxDXU6yZ2yiFEhwjIsg1vmGlEEoRsFCVn11BQIkVC1gEqFx2
	8C/LsFNZd9+D4Vwpo4790/RWp0wX350XK/JzqTuqDUt4/UJpaDUFFg6uBBB6MDPGAx4zX/8PuRb
	FaxwbLgnBT3db4yyH3C8By+q/C8T4fMJlnLK59RFaufyKnfkHMNLM2qxVt23b5UY20Vh8zbTPyk
	+Vya4f5939yvmgRQWFBgOipoqi4b8ojeaaamN2Dk+ycRCeOrbHN3rVwim/ntzMUxCjBuygEbRt+
	KgiB3+Ys9YIiuZMGHTOzYaJPESoG5BnoqFPVPnX5JVH4Ssv2k7S4ujqlE9FlFG5XmiZtRis+w0A
	uy8Hx8OEy1lOIIOfb0SPfBcL6YcZLJ4/LDo0M+lVMOUhCLzS7m36FXO5D0S/k5L1cpAy8udRS15
	PEGGpmUjR76A==
X-Received: by 2002:a05:690e:13c3:b0:644:71e8:cd02 with SMTP id 956f58d0204a3-6495be6c0aamr352932d50.4.1769106895892;
        Thu, 22 Jan 2026 10:34:55 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:47::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-649170bebaesm9858332d50.21.2026.01.22.10.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 10:34:55 -0800 (PST)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Michal Hocko <mhocko@suse.com>,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	hannes@cmpxchg.org,
	david@kernel.org,
	zhengqi.arch@bytedance.com,
	shakeel.butt@linux.dev,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	bingjiao@google.com,
	jonathan.cameron@huawei.com,
	pratyush.brahma@oss.qualcomm.com
Subject: Re: [PATCH v4 3/3] mm/vmscan: don't demote if there is not enough free memory in the lower memory tier
Date: Thu, 22 Jan 2026 13:34:53 -0500
Message-ID: <20260122183453.2619156-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAC5umyib=XmPkTvRT6eAsMx+WDx0NkSP9djh4xkhLJgwk_v8Mw@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Akinobu,

I hope you are doing well! First of all, sorry for the late review on the
series. I have a few questions about the problem itself, and how it is being
triggered.

> > > On systems with multiple memory-tiers consisting of DRAM and CXL memory,
> > > the OOM killer is not invoked properly.
> > >
> > > Here's the command to reproduce:
> > >
> > > $ sudo swapoff -a
> > > $ stress-ng --oomable -v --memrate 20 --memrate-bytes 10G \
> > >     --memrate-rd-mbs 1 --memrate-wr-mbs 1
> > >
> > > The memory usage is the number of workers specified with the --memrate
> > > option multiplied by the buffer size specified with the --memrate-bytes
> > > option, so please adjust it so that it exceeds the total size of the
> > > installed DRAM and CXL memory.
> > >
> > > If swap is disabled, you can usually expect the OOM killer to terminate
> > > the stress-ng process when memory usage approaches the installed memory
> > > size.
> > >
> > > However, if multiple memory-tiers exist (multiple
> > > /sys/devices/virtual/memory_tiering/memory_tier<N> directories exist) and
> > > /sys/kernel/mm/numa/demotion_enabled is true, the OOM killer will not be
> > > invoked and the system will become inoperable, regardless of whether MGLRU
> > > is enabled or not.
> > >
> > > This issue can be reproduced using NUMA emulation even on systems with
> > > only DRAM.  You can create two-fake memory-tiers by booting a single-node
> > > system with "numa=fake=2 numa_emulation.adistance=576,704" kernel
> > > parameters.

[...snip...]
 
> can_demote() is called from four places.
> I tried modifying the patch to change the behavior only when can_demote()
> is called from shrink_folio_list(), but the problem was not fixed
> (oom did not occur).
> 
> Similarly, changing the behavior of can_demote() when called from
> can_reclaim_anon_pages(), shrink_folio_list(), and can_age_anon_pages(),
> but not when called from get_swappiness(), did not fix the problem either
> (oom did not occur).
> 
> Conversely, changing the behavior only when called from get_swappiness(),
> but not changing the behavior of can_reclaim_anon_pages(),
> shrink_folio_list(), and can_age_anon_pages(), fixed the problem
> (oom did occur).
> 
> Therefore, it appears that the behavior of get_swappiness() is important
> in this issue.

This is quite mysterious.

Especially because get_swappiness() is an MGLRU exclusive function, I find
it quite strange that the issue you mention above occurs regardless of whether
MGLRU is enabled or disabled. With MGLRU disabled, did you see the same hangs
as before? Were these hangs similarly fixed by modifying the callsite in
get_swappiness?

On a separate note, I feel a bit uncomfortable for making this the default
setting, regardless of whether there is swap space or not. Just as it is
easy to create a degenerate scenario where all memory is unreclaimable
and the system starts going into (wasteful) reclaim on the lower tiers,
it is equally easy to create a scenario where all memory is very easily
reclaimable (say, clean pagecache) and we OOM without making any attempt to
free up memory on the lower tiers.

Reality is likely somewhere in between. And from my perspective, as long as
we have some amount of easily reclaimable memory, I don't think immediately
OOMing will be helpful for the system (and even if none of the memory is
easily reclaimable, we should still try doing something before killing).

> > > The reason for this issue is that memory allocations do not directly
> > > trigger the oom-killer, assuming that if the target node has an underlying
> > > memory tier, it can always be reclaimed by demotion.

This patch enforces that the opposite of this assumption is true; that even
if a target node has an underlying memory tier, it can never be reclaimed by
demotion.

Certainly for systems with swap and some compression methods (z{ram, swap}),
this new enforcement could be harmful to the system. What do you think?

Again, sorry for the late review. I hope you have a great day!
Joshua
