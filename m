Received: from iguana.tulip.relay.mailchannels.net (iguana.tulip.relay.mailchannels.net [23.83.218.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5314A99DF
	for <linux-cxl@vger.kernel.org>; Tue,  8 Sep 2026 17:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.218.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788887751; cv=none; b=Br4c3cm/AVkpTSiOYWUxisWQCf5QOYV2DAeZ+cxMYlx/P8qSHkwxJPCx7bPM9m5rWX933C79MX3JdvW/rOcI5brOma3Y9eHCdeMi2CYc8Ncv9tyjpLkXMzD+FZOvNAFNtEa1HLF7+adl8Oy39UZ4yHNOpH17PnGXbPymy06iQCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788887751; c=relaxed/simple;
	bh=EmZEIf6cXtY3yIifVFSHi4CNr23peMeRz/WEBHbME6c=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=XmFKFpjI8GZ7Zt9gng9WOXxqoTpzRNtG+xMQFOwMR4BeeIfuq7O7GCX5Eu2KsHzjC6uXQC9/txOYuAgBn1CNzmQ6ism/VGyadlYwuYS/Y0DyMg3Vw3PQudNid23zH5/hNQyTsecWgPeSRS5r5JFbv1oZbOj4tsowEmy2iqiA0og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=iVe0QaA5; arc=none smtp.client-ip=23.83.218.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="iVe0QaA5"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 00F43162EDC;
	Tue, 08 Sep 2026 16:37:03 +0000 (UTC)
Received: from pdx1-sub0-mail-a249.dreamhost.com (trex-green-1.trex.outbound.svc.cluster.local [100.97.105.60])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 947341620BA;
	Tue, 08 Sep 2026 16:37:02 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Attack-Fumbling: 08752fbe791a0173_1788885422819_2422440594
X-MC-Loop-Signature: 1788885422819:2683067083
X-MC-Ingress-Time: 1788885422819
Received: from pdx1-sub0-mail-a249.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.97.105.60 (trex/8.0.2);
	Tue, 08 Sep 2026 16:37:02 +0000
Received: from pdx1-roundcube52 (ip-66-33-200-4.dreamhost.com [66.33.200.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a249.dreamhost.com (Postfix) with ESMTPSA id 4hfV2k2WnZzyrH;
	Tue,  8 Sep 2026 09:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1788885422;
	bh=6xRGPwNYNHBPaIqEB7NsqNA2w4prHRE6fWtr5z4oaio=;
	h=Date:From:To:Cc:Subject:Content-Type:Content-Transfer-Encoding;
	b=iVe0QaA5t1uMwVmar3uHuHrvMMOb4XvhEJPRZ9WtRQzOEzPc565yqrK7IZLnUzxi4
	 0f9BD6cCy4x8Q8+bLWISuAQf4xQIr7MEQlcrHPqejZ0YlTQ4ym3u0f515faDyPe4sT
	 sw9GfGiWiC07oh0nbIAmOK7koV17uunlV96lh8bAhN/C0mFl7TLHWanCgnyr0xAALF
	 jUgbk0/LFcjHxNpaVGtfxarub5nhWNl2wdZB+ThWH3d/SQJ4qrVF81r9f8G7LQVZkQ
	 wCm8zfnCGjs3HEqz8+vKmQ4JA0zu8NOCsqS0VkOrBJkwYq3+YCslyEUj7GlvOkBdLs
	 O8rU7JioTglBw==
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 08 Sep 2026 09:37:02 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Anisa Su <anisa.su887@gmail.com>
Cc: linux-cxl@vger.kernel.org, alison.schofield@intel.com, jic23@kernel.org,
 dave.jiang@intel.com, gourry@gourry.net, icheng@nvidia.com,
 ming.li@zohomail.com, vishal.l.verma@intel.com, benjamin.cheatham@amd.com,
 Ira Weiny <iweiny@kernel.org>, Anisa Su <anisa.su@samsung.com>, Wonjae Lee
 <wj28.lee@samsung.com>, Junhee Park <jh9934.park@samsung.com>, Heesoo Kim
 <habil.kim@samsung.com>, Fan Ni <nifan.cxl@gmail.com>
Subject: Re: [RESEND PATCH v13 4/8] cxl/events: Split event msgnum
 configuration from irq setup
In-Reply-To: <20260908102124.2231730-6-anisa.su@samsung.com>
References: <20260908102124.2231730-2-anisa.su@samsung.com>
 <20260908102124.2231730-6-anisa.su@samsung.com>
Message-ID: <c938fe79f72b15dfd1e7ed04c18ea1fc@stgolabs.net>
X-Sender: dave@stgolabs.net
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

On 2026-09-08 03:15, Anisa Su wrote:
> From: Ira Weiny <iweiny@kernel.org>
> 
> Dynamic Capacity Devices (DCD) require event interrupts to process
> memory addition or removal.  BIOS may have control over non-DCD event
> processing.  DCD interrupt configuration needs to be separate from
> memory event interrupt configuration.
> 
> Split cxl_event_config_msgnums() from irq setup in preparation for
> separate DCD interrupts configuration.
> 
> Signed-off-by: Ira Weiny <iweiny@kernel.org>
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
> Tested-by: Wonjae Lee <wj28.lee@samsung.com>
> Tested-by: Junhee Park <jh9934.park@samsung.com>
> Tested-by: Heesoo Kim <habil.kim@samsung.com>
> Reviewed-by: Jonathan Cameron <jic23@kernel.org>
> Reviewed-by: Fan Ni <nifan.cxl@gmail.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Li Ming <ming.li@zohomail.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
