Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454BD3A16B6
	for <linux-cxl@vger.kernel.org>; Wed, 16 Sep 2026 11:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789558967; cv=none; b=fz0nrvM7dO6pUR9P02NHQUWVqyzTcfOJ6Uax3Tj7/4FQRjvSxPEL4WaYk4/a8Q5ZN2g7feMUX4pWy3GRG+6RrKaW8QLS+ZXjZDrAzNtKcbB/gjbuJCAsZDdx8eqSOT7wgrN6PtHuUG2+bO9Xmmt8eJAu0txOjv+3+A/Lsp4rv+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789558967; c=relaxed/simple;
	bh=kKK8/KMJdfBK7SLrZpXKnV7nwXCW3bU61lHFDcGd1+Q=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=u9wInApgSHsHFal5GOBcMaCrtRkZMTGvA9tUE993Tix+BQRxt+HVUSZ47DWIfJlXl/wCpiocDyvWEgPHPygP2ACNtbiG07xsC6OSRAol39mCR/wJOpGywt578lDyfaIB4YI1o3kUXPyU1ce0/3XS4KAR/siNVSjx6a6qIfb3RcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=kwqszziL; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="kwqszziL"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1789558955; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=73ejTBGDdkwS6a0ZoLbSGpNu30B7TXUCNwnLMZtPMaQ=;
	b=kwqszziLMWW/y0/00ADwH2rXe+Umr1Cj4RIKtFHP6nYn7ermejbxBTHq6bHDQfinTsEUdn8t7QhyjmIlpLvUv6DBc5zZjdFWGhmnxWUQQjwUiouW+RMzNaYuvuYs6cY3h//O1lkjdSbqUbJOuYIEINO17BksbIpO4c1IpaAcrZ8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0XB4wRKE_1789558954;
Received: from 30.178.84.130(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XB4wRKE_1789558954 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 16 Sep 2026 19:42:35 +0800
Message-ID: <48ac212c-080c-46b9-a9c8-c0ea046fb133@linux.alibaba.com>
Date: Wed, 16 Sep 2026 19:42:34 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet: copy the hostid into the ctrl before creating PR
 pc_refs
From: Guixin Liu <kanie@linux.alibaba.com>
To: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>,
 Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org
References: <20260916113435.324095-1-kanie@linux.alibaba.com>
In-Reply-To: <20260916113435.324095-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

I'm sorry, send to wrong person, please ignore this.

Best Regards,
Guixin Liu

在 2026/9/16 19:34, Guixin Liu 写道:
> Commit 6202783184bf ("nvmet: Improve nvmet_alloc_ctrl() interface and
> implementation") added a second uuid_copy() of args->hostid near the end
> of nvmet_alloc_ctrl(), and commit 7b658153f1b8 ("nvmet: Remove duplicate
> uuid_copy") removed the original copy that sat before
> nvmet_ctrl_init_pr() instead of the new one.
>
> Since then nvmet_ctrl_init_pr() snapshots ctrl->hostid into the
> per-controller per-namespace reservation refs while the uuid_copy()
> from the connect data runs later, after the controller is published.
> The ctrl is allocated with kzalloc(), so every pc_ref created on this
> path stores the nil UUID.
>
> pc_ref->hostid has a single consumer: nvmet_pr_set_ctrl_to_abort()
> matches it against the preempted registrant's hostid to kill and drain
> the victim's in-flight I/O for Preempt and Abort.  The match can never
> hit with the nil UUID, so whenever a namespace with reservations
> enabled exists before a host connects, which includes every reconnect,
> Preempt and Abort silently degrades into a plain Preempt: the
> preempting host sees success while the victim's in-flight I/O is still
> in the air.
>
> Copy the hostid where the rest of the connect data is consumed, before
> the controller is published and before nvmet_ctrl_init_pr() takes its
> snapshot.
>
> Fixes: 7b658153f1b8 ("nvmet: Remove duplicate uuid_copy")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
>   drivers/nvme/target/core.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index 43871a8f56ca..8c8c8627871f 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -1648,6 +1648,8 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
>   	INIT_DELAYED_WORK(&ctrl->ka_work, nvmet_keep_alive_timer);
>   
>   	memcpy(ctrl->hostnqn, args->hostnqn, NVMF_NQN_SIZE);
> +	if (args->hostid)
> +		uuid_copy(&ctrl->hostid, args->hostid);
>   
>   	kref_init(&ctrl->ref);
>   	ctrl->subsys = subsys;
> @@ -1706,9 +1708,6 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
>   
>   	nvmet_start_keep_alive_timer(ctrl);
>   
> -	if (args->hostid)
> -		uuid_copy(&ctrl->hostid, args->hostid);
> -
>   	dhchap_status = nvmet_setup_auth(ctrl, args->sq, false);
>   	if (dhchap_status) {
>   		pr_err("Failed to setup authentication, dhchap status %u\n",

