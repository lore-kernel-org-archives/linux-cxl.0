Received: from glass.ash.relay.mailchannels.net (glass.ash.relay.mailchannels.net [23.83.222.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814B617A2E0
	for <linux-cxl@vger.kernel.org>; Wed, 19 Feb 2025 02:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.222.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739932491; cv=pass; b=UF9pnKk1qrVpreDdbnKUZmUDIUpkasTZcWlSU2Tarlwu7ISaHVOFAgsoydWsXHWKBsuvVe/aEzBP3yX4puSvV0Ada7xbzKh6cVZdhKHnliWZjIEaHtgJStxwXsjhU0z8PZRQIb04kAhxZoFREe3Ig/wL1flZJHE3XUVLMsJc4+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739932491; c=relaxed/simple;
	bh=Qr8i0cpQFWn1+QVGeqfvN9lQK2ybIvzvHZdFJGdpWJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JqeFaiT8YtlwXb44x5vbZ13CNtbRefVrsYe6kmZZNQFmUEUDgE+ACTMMRuqL5AnMY27bCAtm/V15YPAz79xrIvLS2KWe5z/Ei5yXToAc2O2XQ1Q16wE9oa4TV4xvEgnrrKC0pNamRg363UdQuqmOpFhSlg3v0aBQpSTvTTg2KzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=ZDSp5rOm; arc=pass smtp.client-ip=23.83.222.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="ZDSp5rOm"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 0FF7A2C34D7;
	Wed, 19 Feb 2025 02:34:47 +0000 (UTC)
Received: from pdx1-sub0-mail-a289.dreamhost.com (trex-9.trex.outbound.svc.cluster.local [100.101.208.252])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 835932C33DF;
	Wed, 19 Feb 2025 02:34:46 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1739932486; a=rsa-sha256;
	cv=none;
	b=O8nlAh9qaWBr3iN/XPsVWfxzmIL9jiHTBVbgQBuhxRT4DdtoEvDvYcV1lfj7MLuPr5V97J
	OXjRfggeeVWulMMQj1j3C5cXO4vhxkMHzlAupRZNcU3w9s7MvLBjYU+/68W/7fuaQ9NQps
	yIvvTRVNPgqoI2Ik451f1Dnntjpy0cmR6OxpucYVfy74Uab+cBNTHCyft2BEeExfMBqtgp
	rnMkonYcre6Nhwcug1/N91oCpWQoNSSPpek/+DjQcIkImnOdzoMaVUB1+3Y2+QjpXPb5+N
	+lYQ+OLlTDYEQEmoPtVvTieRE3BswloNmFmjyKs60NJ/70Pj8YrRLZ1a74P+eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1739932486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Qr8i0cpQFWn1+QVGeqfvN9lQK2ybIvzvHZdFJGdpWJs=;
	b=kxne3hiWjfdkx60VsJO4v0owSbh6TtJKsbc/FeZtc/RWUycF3juiwqoTYGBksaWdyXrJR4
	NM+JLzrB6dfdd7lVhKZU7oqQR7XvwboFqCnpfgAthXpCYET+a+twzV8MhhKHSc2ZJYdln7
	4GKcuNoO2ylraAoSsmk/RUOWYmE15oK1QR0XchoepsdV4lhPD5a2P/pixf7QeU6ZwoaMcd
	aw5am/8mRmI8/ZPVNuXItvEHWJzaQfecUwnL6Q7GLr4i0txizlshL+OaeXSpoOHsSlbzst
	S/2ciHgHP+30WhtBBu7WY76hYWj1RWvgX0QBLjjPVHCKIIwtJEORDD/NF5m5rg==
ARC-Authentication-Results: i=1;
	rspamd-6d7cc6b78d-k4sxl;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Hysterical-Gusty: 6fbd496c2af631b6_1739932486824_945282738
X-MC-Loop-Signature: 1739932486824:2960456743
X-MC-Ingress-Time: 1739932486824
Received: from pdx1-sub0-mail-a289.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.101.208.252 (trex/7.0.2);
	Wed, 19 Feb 2025 02:34:46 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a289.dreamhost.com (Postfix) with ESMTPSA id 4YyL855TDqzBP;
	Tue, 18 Feb 2025 18:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1739932486;
	bh=Qr8i0cpQFWn1+QVGeqfvN9lQK2ybIvzvHZdFJGdpWJs=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=ZDSp5rOmA5gIglOLwd75suvU4FNr8apDha/LBwzu87RPrS6UR/RvSvMDl+L28H9Ml
	 O5yDeK3pm7r49JRMAC939rC65od8dE8MDXEFUlqKRVTJgpsnXrPyfzqn/8SYZZlxhK
	 sW82NEy72PFaLuXCjq8/9xzkPDihgy1PcI1LgM/H6+1c/jVul/1gqtXO5a50JXuOil
	 N8iN4PCigGdeJLUC2cMJRovduwEwPMD40uXtbqG8hwhzgwQpJ5cQyDYxr1g++zqUdO
	 3ZUPgbnEc2EeWyVc9ISmdH1AdDhftMd/QVmRloL+E4FivXldKBcIVoMJy/x25X9Pq9
	 2vtTPk1Pne1+A==
Date: Tue, 18 Feb 2025 18:34:28 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com, dan.j.williams@intel.com
Cc: jonathan.cameron@huawei.com, alison.schofield@intel.com,
	ira.weiny@intel.com, vishal.l.verma@intel.com,
	seven.yi.lee@gmail.com, a.manzanares@samsung.com,
	fan.ni@samsung.com, anisa.su@samsung.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 3/4] cxl/pmem: Export dirty shutdown count via sysfs
Message-ID: <20250219023428.6mglt2srettb47nu@offworld>
References: <20250219021420.214991-1-dave@stgolabs.net>
 <20250219021420.214991-4-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250219021420.214991-4-dave@stgolabs.net>
User-Agent: NeoMutt/20220429

On Tue, 18 Feb 2025, Davidlohr Bueso wrote:

>diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
>index 6d60030139df..03ad3c8ba88d 100644
>--- a/drivers/cxl/cxlmem.h
>+++ b/drivers/cxl/cxlmem.h
>@@ -866,4 +879,6 @@ struct cxl_hdm {
> struct seq_file;
> struct dentry *cxl_debugfs_create_dir(const char *dir);
> void cxl_dpa_debug(struct seq_file *file, struct cxl_dev_state *cxlds);
>+
>+int cxl_gpf_device(struct cxl_dev_state *cxlds);

Bleh this is a leftover of v1, it slipped through. I will send a v3.

Thanks,
Davidlohr
