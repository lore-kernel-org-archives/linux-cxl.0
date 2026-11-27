Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.83.223.161
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795809105;
	b=rE0w/DYLvqC0iVmVtsN9yt0HbrEB3N3V5uNsIpE8YACGdQc0yvgpOEBZ1xe+sHgYFk2z
	 dQSgJki0AnaMj8WlUOWJpW3SBQrZ7RyA720dGQyRgbC24Zm1IAxgsCUMRJrThiMZsthyL
	 G6vn/0XPNstj3tW3wmi7TENxEcTTPiV0Fk7x85hYvc8t5SwpAPvh8I9pSVYIQdcV4IZVO
	 hEL5iDAWN7rTkcxFjgn9B0w/KoRRxjc0gPUiOoym+N+PHpGxgE/V8mS/XtC1xwaZ4VKOb
	 onheJ/NzauyVF0BiMOQ7UGhsD2D69UThPmrRbkrOdfK7OWA6soiRgv/J2RhqXiOvx5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795809105;
	h=DMARC-Filter:X-Sender-Id:Received:Received:X-Sender-Id:X-MC-Relay:
	 X-MailChannels-SenderId:X-MailChannels-Auth-Id:X-Shelf-Thread:
	 X-MC-Loop-Signature:X-MC-Ingress-Time:Received:Received:
	 DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=HcvIrPb2cxSgvcGV74mI37tQYpZJDLpnaqRSLO6J+P0=;
	b=Vi+rHAmncgESxSFnhuEfN4E8NkVaeJLMCL7cuqZgElyWgx4UlnGKv6ifV7v8OHPItwCk
	 hUEvS/8k+5V+u7bXoxQ5d8V4j/jPrnkjFJqJq9HgQp2zFU55hLgHjLV5xNLEplQvmB6dH
	 cdyVaRr83T6nLlM/LilxP5DBXaXpC+2+p7wQSJuWSXfC3813znplo+TYp8esVSSgnWOZO
	 kHw+aeoqexG/u+18i1KB5Mp8N5UdHFet82FdDZOjv3xSN0vw6E6wcnz01iy0CSgTEXvim
	 A9X57e7u/eemino2bCkBMSWMJUuLvcfHF8FpTa1BUXp2rmTbkujxCWAmIVG5XtDtUxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=stgolabs.net;
	spf=fail smtp.mailfrom=stgolabs.net;
	dkim=pass header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b=btLb2nnT;
	arc=none smtp.remote-ip=23.83.223.161
Received: from seahorse.cherry.relay.mailchannels.net (seahorse.cherry.relay.mailchannels.net [23.83.223.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1007606A31C
	for <linux-cxl@vger.kernel.org>; Fri, 27 Nov 2026 19:51:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1007606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b=btLb2nnT
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 945E73E0C54;
	Fri, 27 Nov 2026 19:51:38 +0000 (UTC)
Received: from pdx1-sub0-mail-a223.dreamhost.com (trex-green-6.trex.outbound.svc.cluster.local [100.96.15.253])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id EC9153E0F8D;
	Fri, 27 Nov 2026 19:51:37 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Shelf-Thread: 7f21c2f25a4e6cd5_1795809098245_2862993013
X-MC-Loop-Signature: 1795809098245:3966688462
X-MC-Ingress-Time: 1795809098245
Received: from pdx1-sub0-mail-a223.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.15.253 (trex/8.0.2);
	Fri, 27 Nov 2026 19:51:38 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a223.dreamhost.com (Postfix) with ESMTPSA id 4jbkZK14Hcz1q;
	Fri, 27 Nov 2026 11:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1795809097;
	bh=HcvIrPb2cxSgvcGV74mI37tQYpZJDLpnaqRSLO6J+P0=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=btLb2nnT/aN2onc8mR4uChl7Qy0rHtrMD93QrEWAST1qAk0M6Zw2FVrxVA8NR/MwR
	 SzH0Uq7aV4u1CjYPLszPpbICymNvJqugCZbb8nedkb/QtQF7yqdVti0U//KHiLCCze
	 1FZ6Rs9nsw0+rYMUsABuV3OCnl/PR0E1VsSb6ZfVNlbgBOhYQbT/QQ2ilZD7xmNfPa
	 30qhxuYx0bqnz3qxa2+s8CFtgWW69BROkyYSc96XrRcIygb8p2N5bSxrMOckeQHb2a
	 FhUJGzFVDUZ9B1JFyrMbrVV0EZG6WUAkd6YWpkN/7o/YGuNNvqRWU0Ch12Lg6XFVz9
	 VoVt3jFz+1woA==
Date: Fri, 27 Nov 2026 11:51:33 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: Unsung Lee <unsung0317@gmail.com>
Cc: linux-cxl@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>, Dan Williams <djbw@kernel.org>,
	John Groves <jgroves@micron.com>
Subject: Re: [RFC PATCH 0/4] cxl/memdev: Activate firmware without a reset
Message-ID: <20261127195133.dwixro55ocba7qes@offworld>
References: <20261125124358.3583223-1-unsung0317@gmail.com>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261125124358.3583223-1-unsung0317@gmail.com>
User-Agent: NeoMutt/20220429

On Wed, 25 Nov 2026, Unsung Lee wrote:

>This series lets userspace activate an uploaded slot online once the
>device no longer decodes any memory, the same condition sanitize uses.
>Uploads keep their current behaviour; activation is a separate,
>explicit step:
>
>  1. upload as today (slot N becomes pending for the next cold reset)
>  2. move the data away, offline the memory, destroy the region
>  3. echo N > /sys/bus/cxl/devices/memX/firmware_activate

Is this a real use case for online activation?

This now seems like an interface clash, memX/firmware/activate would
be better. The upload device is registered to the fw class.

>  4. recreate the region and online the memory

So this work requires a CXL equivalent of
	   Documentation/driver-api/nvdimm/firmware-activate.rst

.. describing the flow, states and the results. Patch 3 only extends the
ABI file. The capability would be quiescence-like.

>
>Patch 1 lets Activate FW complete as a background command; without a
>poll budget the mailbox reports a timeout at once.
>Patch 2 keeps the pending slot and the activation capability from Get
>FW Info.
>Patch 3 adds the attribute.
>Patch 4 lets cxl_test advertise online activation.
>
>Questions:
>- Patch 3 requires that the device decode no memory, as sanitize does.
>  The driver cannot tell how long a device holds CXL.mem requests while
>  it switches firmware, and the comment on the RAW command block list
>  says activation "requires adjustment / coordination of transaction
>  timeout values at the root bridge level". With no memory decoded
>  nothing can time out. Is that the right condition, or too strict? It
>  means moving the data away first.

This makes sense but really is the show stopper for your patch 1, where
bg polling timeouts (albeit 30 secs) leave things in a very bad state if
the device is to ever be onlined again.

>- The Online FW Activation Capabilities ECN to CXL 3.1 allows Activate
>  FW to complete as a background command (8.2.9.3.3), so patch 1 waits
>  for it like Transfer FW. Should it carry a Fixes: tag? John Groves
>  raised activations longer than the 2 s mailbox timeout at the June
>  2025 CXL collab sync; patch 1 may overlap with a patch from that.

Semantically, transfer fw makes sense to have with the timeouts because
users can partition the work, which is the whole point. Activate fw
lacks those semantics, so while 30 secs seems like a value unlikely
to timeout, there are no guarantees (I have no idea about activation
time expectations really).

This plus the above answer means that we should just move activate fw
to the sanitize category as a potential mailbox hogger and just wait
asynchronously... which is what I did with the followup series to this
collab sync meeting:

https://lore.kernel.org/all/20250617193611.564668-3-dave@stgolabs.net/

(i am rebasing this series and will send out)

>- Patch 3 holds cxl_rwsem.region only to check the decoders and set a
>  FW state bit that makes decoder commit refuse the device with EBUSY,
>  as sanitize does. An earlier version held the rwsem across the
>  command (up to 30 s); with an activation emulated in the kernel,
>  create-region and region sysfs reads on other devices then waited
>  for the whole activation. The cost is that a create-region on this
>  device that races the write fails instead of waiting. Is that the
>  preferred trade-off?
>- After a timeout the device may still be activating, so patch 3 keeps
>  refusing regions, uploads and sanitize until the slot shows as
>  running or a later activation succeeds. A later error does not count,
>  since it may come while the device is still busy. A device that ends
>  up on its old firmware stays refused until cxl_pci is bound again.
>  Reading the Background Command Status register would end this
>  sooner, but needs a new mailbox callback. Would that be acceptable?

See above.

>- Should the pending slot stay set after an online activation? QEMU
>  keeps it, cxl_test clears it.
>
>Not addressed in this series:
>- State cached at probe (CEL, timestamp, event interrupt policy,
>  features, Identify, CDAT) is not re-read after activation.
>- Unbinding the port above the endpoint during the command tears the
>  endpoint down, which clears HDM decoder enable and Mem_Enable on the
>  activating device (exercised in QEMU without kernel warnings).
>
>Testing (QEMU 11.1.3, one type3 device, guest v7.3.1 unless noted; no
>real hardware, so an activation that really takes long, polling while
>it runs, other hosts and other CCIs are not covered):
>- Functional and race tests (concurrent writes, upload, create-region,
>  cxl_mem and cxl_pci unbind, mailbox readers, kill -9, sanitize,
>  upload cancel) on release and lockdep/KASAN kernels, 20-50x: no
>  warnings; kprobes showed no activation while a decoder was committed
>  and no commit while activating.
>- A test-only build emulating slow and timed-out activations, release
>  and debug, 20x each: refusal during and after a timeout; a failed
>  activation after a timeout stays refused, with uploads and sanitize,
>  until cxl_pci is bound again; a cxl_mem unbind waits for the command;
>  a port unbind during the command. Create-region failing after the
>  port is bound again also happens on plain v7.3.1, so that test does
>  not check regions afterwards.
>- The whole flow (move the data away, offline, activate, online, move
>  it back): 100x without data; 20x with a process rewriting 2 GB on
>  the device's node (longest write stall 78 ms, in QEMU only); through
>  a maintenance script, deferring when there is no room (10x), rolling
>  back when room runs out (20x), and SIGINT/SIGTERM/SIGKILL at each step
>  (60x); and these mixed for 4 hours (1,462 iterations). No failures,
>  and the data was intact after every iteration.
>- cxl/next 32af781935: applies cleanly, no W=1 warnings; QEMU gets no
>  root decoder there (CFMWS with both HDM-H and HDM-DB, rejected since
>  e4c3f0d966), so only the tests without a region ran (all passing).

Dave wants new features without dependencies to be based against Linus'
latest, instead of cxl/next. That said, testing cxl/next is quite welcome
always, so while the qemu breakage is inconvenient, it's worth just using
a newer qemu from source.

Thanks,
Davidlohr
