Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898D731580
	for <linux-cxl@vger.kernel.org>; Tue, 10 Oct 2023 20:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="FEDil0de"
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DFCF94
	for <linux-cxl@vger.kernel.org>; Tue, 10 Oct 2023 13:21:26 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 9B91380A80;
	Tue, 10 Oct 2023 20:21:25 +0000 (UTC)
Received: from pdx1-sub0-mail-a235.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 23AA180560;
	Tue, 10 Oct 2023 20:21:25 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1696969285; a=rsa-sha256;
	cv=none;
	b=9v2JKXwsmlWUiMULBb1dyMKUIJMo3Lx8XexG18JsXNHvi2RLlOm4r5pLZp2Rb1hjdBVyvJ
	W7b/JdVyx0Y2eqE7wCGkA8v7OqtGJ618Bhdp9YJCRm84xakebWpoDvo+zj0lNFC0JMFN9V
	K72YQjrWLPrb7Aok2HQzHFc33fXYMgH0mW+D21ImbKguHY+6xOstVOQD+bFXHsFfxa6Bzj
	B9Xg+XtkVb0tkp2k7namJfirAOOAg/hPZ+OcmZrFi2etK+phETqOvt0FMK557/AhGduKHf
	xYvqOuU3KwDE22QxL41Z4B1GpeC8/09pnaFaJTtvTPFKWDX5sGm0wEPxNFEDNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1696969285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=u/txUThemye87LbJR5wEYOvvCBJJu0Ru8ulpGDD7LEs=;
	b=rxgojdp2H8A8y0+KFo8515GMXe3/MbN8q41UtrCmZzRwlgVc1/oDghDQMolpH/DF1LlJIq
	9Z29BwRd9u9xzeQGWX9ndcCHsTDH9Cf22IQpmTFMzLBnfwhRoPBa7XNgaHz7DD0QkWbeT9
	Lc/jpQjBu8IbVLiAbFz4EdVqn6E5YwWyrB2CzTXG5Uf0YKpu/Ovc6yR2lQDnA15cvf3PES
	DZwKBtACVDS6t5aINfNsCCOqGfBksLvvEDlWtTdCZ+2cUpoTT6cds0ht9qcBr/8bQTe7h7
	kf40Cf/RIVIuvAIA1XOaOOAIoLo4jPrLEFry+zF4BG+GYIbrV0XMzRDGv42Y7Q==
ARC-Authentication-Results: i=1;
	rspamd-7d5dc8fd68-g8k7p;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Average-Whispering: 0269bb6a7cb68c9b_1696969285427_3912752043
X-MC-Loop-Signature: 1696969285426:2508996630
X-MC-Ingress-Time: 1696969285426
Received: from pdx1-sub0-mail-a235.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.68.32 (trex/6.9.1);
	Tue, 10 Oct 2023 20:21:25 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a235.dreamhost.com (Postfix) with ESMTPSA id 4S4nNh5hjvz3M;
	Tue, 10 Oct 2023 13:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1696969284;
	bh=u/txUThemye87LbJR5wEYOvvCBJJu0Ru8ulpGDD7LEs=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=FEDil0decuSlc34PYcM74q0/USgNoWn9eNkTKnzPSjvt8rDNg7H787VgSLSW/NJ0y
	 mUi2nX+F+9Ue2Tkp8Is12Po9dArvrhd0nKQDDevDKG7rztID7139a7lvY1TjmgUfDH
	 9bX60mn98jH+f3WJOWjVWAXM0VBfhb2Lp1epbGw+oHn4SOHt7dUeRFMgvY/aVyKJFF
	 WmAIpu/7yEkJzLRXH9eNJind92GPbm0MGozgGUXU/gtrkz7iHh+JKeB9DeX295F8uS
	 KyRD4Izb+DyFExOng8nhfbIhIoDeKLxfPY2bUBKpHvzRfrpYsVyLP8Del6CVB5hKaP
	 pTNBDsF59gKqw==
Date: Tue, 10 Oct 2023 13:21:14 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: Re: [PATCH v3 07/10] cxl/memdev: Fix sanitize vs decoder setup
 locking
Message-ID: <gbboe2vmzywzfo3chh5qzs4s2gyslqkclmpejmdfgtdwribx5k@xchumyhhg3qr>
References: <169657715790.1491153.3612164287133860191.stgit@dwillia2-xfh.jf.intel.com>
 <169657719974.1491153.15276451196916291864.stgit@dwillia2-xfh.jf.intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <169657719974.1491153.15276451196916291864.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: NeoMutt/20230517
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 06 Oct 2023, Dan Williams wrote:

>The sanitize operation is destructive and the expectation is that the
>device is unmapped while in progress. The current implementation does a
>lockless check for decoders being active, but then does nothing to
>prevent decoders from racing to be committed. Introduce state tracking
>to resolve this race.
>
>This incidentally cleans up unpriveleged userspace from triggering mmio
>read cycles by spinning on reading the 'securiry/state' attribute. Which
>at a minimum is a waste since the kernel state machine can cache the
>completion result.
>
>Lastly cxl_mem_sanitize() was mistakenly marked EXPORT_SYMBOL() in the
>original implementation, but an export was never required.
>
>Fixes: 0c36b6ad436a ("cxl/mbox: Add sanitization handling machinery")
>Cc: Davidlohr Bueso <dave@stgolabs.net>
>Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
