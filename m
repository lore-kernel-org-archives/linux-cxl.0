Received: from bumble.birch.relay.mailchannels.net (bumble.birch.relay.mailchannels.net [23.83.209.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7118628D83E;
	Fri, 31 Oct 2025 16:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.209.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761927434; cv=pass; b=Jm7ue6tAJ7WuV5xcozouk3vwNAD/8fI4rc30cMQBKCcTdUBbrnzS6BlNfMJDaSvdmylttnqoYD5KBInUAJYPtjNcNco8f3FQtUvPKDOwj9LSmhCo1Sk0uv5mOn3ggpMpEKBkWyCnbyoQ2r1mHTXTqtrV3QEW+GjVmTrCEN7KHrM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761927434; c=relaxed/simple;
	bh=aOOIgokpQl1lsGaXJ+1ZZ7zoYugBTfuX7IxTAgJklds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WTNM0+EFFo2FrUBrVXNkD2b49uCebmvgCZDR2J+llGtFDOeJYVlCgMFx+Z4CFMcH2WkJqvYCIC95iODSLFRq/7lMiT+j12k745OfesdF/Mb53nmqebYdgxgDN+psGXqdtN9RyU9h1d71tjmKkTps7iA4wOyuCO2FuXMgJ43GskA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=BXsu/tGN; arc=pass smtp.client-ip=23.83.209.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="BXsu/tGN"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id D2C3E16129B;
	Fri, 31 Oct 2025 16:17:04 +0000 (UTC)
Received: from pdx1-sub0-mail-a447 (trex-green-2.trex.outbound.svc.cluster.local [100.124.159.62])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 6C1F7163035;
	Fri, 31 Oct 2025 16:17:00 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1761927420; a=rsa-sha256;
	cv=none;
	b=kmDktWeXk3HyLgMoL1BX+OmcYTQ582r24LoBQXMxabwOarc70lJeX1GMqTcxz4N4d/Euwd
	jl5I1DnE782CnZupjBg1JNskJqvaHkTzU75I/4kgH85ura1Rly22reGjgk43zk6JW//xMN
	amzrLDGO5t/YZh3hOP3ugiMHuA2/7ZI1/pfwFSMTPMr2VHYmcwrVc9yK/ny6SoM91gayYr
	ZNn4O4+OtDL1lFWwoLF1NWnGxodhP/QQGmYrXfPM5qq2MwaP1MpO+4AIrr4B1xwZyBuPBP
	Y1OY6JEYoIBzkC++Ag535ynbFDZq1jXBECIZ7IOsICIAnUdYjwFo8n8dRC6IwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1761927420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=aOOIgokpQl1lsGaXJ+1ZZ7zoYugBTfuX7IxTAgJklds=;
	b=323mOcu5zEOcBEi+2T0P097+6+GK3Wj4S+wdIzdb8hhkKl5TgN29qIicL0d4xDRijhsqm2
	WJVUm2GZmG0/MIsUJm2xk+VsD62cJMyHmokWxCEtzMRI0qGW1kFav7i4j8VLD1ci2K73s8
	k/V3iKf7gQpDVk1f5c8oSnbOt4m24tzdChiNUV6WkDG78wKQm9cnhNR1mYAWJpWAU1y5l9
	5tzRIogyDfh4zFCHrSIVwbdhLfXuTWeUetH0TrBD79w6okXK4GQYrwKCsQnsjjBe82oQhj
	hg2ouGqqb81VaPhepCuzfJM8HGx+tq8yj8m2qRj6a+ieKoZVXw2WzqGPAMCygw==
ARC-Authentication-Results: i=1;
	rspamd-77bb85d8d5-d2rt8;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Thoughtful-Cellar: 4ca3403c074a88a5_1761927420744_975491570
X-MC-Loop-Signature: 1761927420744:3857003168
X-MC-Ingress-Time: 1761927420744
Received: from pdx1-sub0-mail-a447 (pop.dreamhost.com [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.124.159.62 (trex/7.1.3);
	Fri, 31 Oct 2025 16:17:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1761927419;
	bh=aOOIgokpQl1lsGaXJ+1ZZ7zoYugBTfuX7IxTAgJklds=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=BXsu/tGNbTLf2YW3cIn8BRT6+KVn/GLsvfKI4jIIofvS5rRycZ/lkjPQbhB7yEYv4
	 s9pPtFqBKxlN6TAYa2/OkKaUPwiOMRdI1sEVAZkolqPivZTL2Rzvm2KmilXCHSqjwy
	 AWYQxBEpwl9Wl6KHbvXzj0HENe5Lp2r6jeifGZ09ejAj88Geblz2vQk+7ofbqkhrmt
	 xdxR1wn7nSBFhygKfYD9jAC2Knh/6T/1pK8Xlt3bkdctuD8csU1gu6USWldzRtQVKV
	 3DmnAX/wuK6ZeJRbhq0lnuYQWnHddEjajOEI/jWnwEVUke/fieW6wZ6KmBpGkXoB/j
	 MdHU6j5R4kOtQ==
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a447 (Postfix) with ESMTPSA id 4cymMZ6MY2z1wdQ;
	Fri, 31 Oct 2025 09:16:58 -0700 (PDT)
Date: Fri, 31 Oct 2025 09:16:56 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Michal Hocko <mhocko@suse.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] cxl/pci: replace use of system_wq with system_percpu_wq
Message-ID: <20251031161656.porcqeplmln3qzl5@offworld>
References: <20251030163839.307752-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251030163839.307752-1-marco.crivellari@suse.com>
User-Agent: NeoMutt/20220429

On Thu, 30 Oct 2025, Marco Crivellari wrote:

>Currently if a user enqueue a work item using schedule_delayed_work() the
>used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
>WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
>schedule_work() that is using system_wq and queue_work(), that makes use
>again of WORK_CPU_UNBOUND.
>
>This lack of consistency cannot be addressed without refactoring the API.
>
>system_wq should be the per-cpu workqueue, yet in this name nothing makes
>that clear, so replace system_wq with system_percpu_wq.
>
>The old wq (system_wq) will be kept for a few release cycles.
>
>Suggested-by: Tejun Heo <tj@kernel.org>
>Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>

Acked-by: Davidlohr Bueso <dave@stgolabs.net>
