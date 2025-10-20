Received: from dog.birch.relay.mailchannels.net (dog.birch.relay.mailchannels.net [23.83.209.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E429129E11D
	for <linux-cxl@vger.kernel.org>; Mon, 20 Oct 2025 03:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.209.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760930235; cv=pass; b=pNrMjykKiU61XjjiD8drDpI/bIX380865j9CQs4EgZHceWSOBMnJD8SRbMaz9c1PewtukImCbeoqyYawetoObB5jCZv16Os6k4tDP6hSSzXkJD/hF6gaubCy5vLOC3/DMmAsqyGTZeVAhktLPV63Dd327ZRUc17yh01Ra2oj2II=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760930235; c=relaxed/simple;
	bh=cwHV3AOfkPQRwNSJ4Ycmqk7h+w9UvQ9L+DMLFSSiI3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LetR4KYdV3hZieV4n4O9H+SDmtn9T6b2d9mkhN8wHAZvpmRojVTPM9jzL26E/6StqmV1Ci9wb5ru4BtVGTC7D4A7wgZfakcelNo2G8OCdacmTloiUtFCNelteMmgUc0Q9WcbnRr/xzqeeT7MsDSLKQ4viC5YzYfm+Eha8l9CZ6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=E8IdOl/K; arc=pass smtp.client-ip=23.83.209.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="E8IdOl/K"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id D7E101E1274;
	Mon, 20 Oct 2025 02:38:47 +0000 (UTC)
Received: from pdx1-sub0-mail-a212.dreamhost.com (trex-green-4.trex.outbound.svc.cluster.local [100.117.123.159])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 8091A1E0E3B;
	Mon, 20 Oct 2025 02:38:43 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1760927923; a=rsa-sha256;
	cv=none;
	b=VIB3PZJNknuMkVO/fKb5vOA1JyVKo7kBhcwjfsEgqvr1+AWTKvNQfb/Mn3EV2eRaI9GrpI
	x8jEPtMLcaEfJOTvZY/ZABtHEEI39SrfOOJu3BYtWJ5uh82/lNyOCqYQoE6jUkcHBL7z/O
	SSD3FGs4Nsx3LyE+cu5Fn4qxVr8hIr72zxxpf6vQoRCsZ4DHIvoX7V4BzJtEAPItYkQT0/
	JG2PoY5IukNWQyskJS7ZGPAJhBQYJ0WEp1UzRKRZ+eleHpeghdbBYniAdL12kaCutjC6Of
	32f7m6x212NUBsI46TQMCZZrs/QQXV3ag/QPTbePVNbnnLTkH99ZayXoPnwYvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1760927923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=cwHV3AOfkPQRwNSJ4Ycmqk7h+w9UvQ9L+DMLFSSiI3A=;
	b=erLu+dCxD1JMZLYHEa6zGoSh/0TyrVitA8m9d5092gLpnIlaDv5Yrio711+nlhSiyFRpFC
	GVoPJm0i/LrBYhk6UfibF3SQAcbztpppc2yHxreE440viMtdf4YcOIYxESXM85Yayxw6Q6
	1xnkeli6Z2aTtlFEdT1qgQXx9a4HFOlAcBQySJTb1T5Tt5c+ge/5Czo9P9S1Z8xTAVcxI6
	JQkNKmLxWDsfeKOZNWcg1dEED30WLvrUfHP6/TMMJSTWx09rFy2XHVp7mNHcHXM7pxtQs+
	RgKGjcGtIsTYivG/lG5Lo6k5N1+8ARscQ/3P2UEx7+EzI2HREFn64FjW1XDtxA==
ARC-Authentication-Results: i=1;
	rspamd-869c579f6-76r7p;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Cooperative-Invention: 6220aae05a17e2a7_1760927927767_366099641
X-MC-Loop-Signature: 1760927927767:3743317792
X-MC-Ingress-Time: 1760927927767
Received: from pdx1-sub0-mail-a212.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.117.123.159 (trex/7.1.3);
	Mon, 20 Oct 2025 02:38:47 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a212.dreamhost.com (Postfix) with ESMTPSA id 4cqfkV4XCWzJ7;
	Sun, 19 Oct 2025 19:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1760927923;
	bh=cwHV3AOfkPQRwNSJ4Ycmqk7h+w9UvQ9L+DMLFSSiI3A=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=E8IdOl/KF0CgTvV9TPLpJwvOUZ3MGnwHHgptS/41bMfkayzoWGbEsgkata229UG1e
	 +ndpXCVt+ohk2UT77F0QzTT/8h8+ytVGCPqFJ4vasyQYVlbWLlXqghO4RfDQ03Ida8
	 u1Ay2rKNTKKg+VXWtPC8TI7F99q2Hpt8vz6u4+Q+KxH7dgRy0zR6if4LoAJt58yJ7Y
	 TmP+ZpGYe1GxJ0GpHFlh9PF1jjiEMyAutouMOdApPVyWPYvFkZ9JrakAzt5p50HEHF
	 KkpmtY7Etj53h8D6UYkX6FyASm/toBe7qkDDz63PgntAbA42OA71QkXr1amV7g4F2Z
	 1CKnSPdJ47Icw==
Date: Sun, 19 Oct 2025 19:38:39 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: dan.j.williams@intel.com
Cc: "Huang, Ying" <ying.huang@linux.alibaba.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	dave.jiang@intel.com, alison.schofield@intel.com,
	ira.weiny@intel.com, vishal.l.verma@intel.com,
	seven.yi.lee@gmail.com, hch@infradead.org, a.manzanares@samsung.com,
	fan.ni@samsung.com, linux-cxl@vger.kernel.org
Subject: Re: Deep flush support for CXL pmem?
Message-ID: <20251020023839.p5f7wiymp62zdx2h@offworld>
References: <87zf9qf46z.fsf@DESKTOP-5N7EMDA>
 <68f294af24168_2a201001c@dwillia2-mobl4.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <68f294af24168_2a201001c@dwillia2-mobl4.notmuch>
User-Agent: NeoMutt/20220429

On Fri, 17 Oct 2025, dan.j.williams@intel.com wrote:

>CXL does have a Global Persistence Flush mechanism that fires as the
>system is dying, but it is not something that can be triggered at run
>time.
>
>So, either the system has the reserve energy to make sure that all
>globally visible writes make it to persistent storage or it does not. If
>it does not then it had better arrange for those failures to be flagged
>via a dirty shutdown mechanism.

In addition, GPF is purposefully vague about the details of how this is
correctly handled (ie phase 2), which imo implies eADR-like semantics,
as there is no extra programming burden. So the scope is CPU caches + pmem
write-caches, and hw vendors need to budget power accordingly.

Thanks,
Davidlohr
