Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.83.209.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793739147;
	b=je0UZOpbHdzlBPPTw26Q0eD94RQmGsyhjqZbx7S7geNkvizRHy7uLr+Izd1VA4CD/l+a
	 MtFD5UZfST9QNVKCJ+dLZ36LO4hb5NrQm/m/fU7Xp/D/CM5gUMJuMREw9jfkffa/hNrAf
	 p6Hpj+OaPLjbDU+Ji7Ije7WX4NzFeJiipe21iaiwD9nGXg4l9wqTpeBrCffVL2RsD/FvU
	 S3YgP/90zXZWY2nJv2fu+bm5thGDehUs7qVUQg2ngyTDipPZmp/I8Iwi80aYSjnrFxh8B
	 JicZwIuWySrZkRKm3EtEXaoEvyd23UeipfBA2hm5lzGHm+8H7GqgdCD7x1n9SzZvr4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793739147;
	h=DMARC-Filter:X-Sender-Id:Received:Received:X-Sender-Id:X-MC-Relay:
	 X-MailChannels-SenderId:X-MailChannels-Auth-Id:X-Stop-Whispering:
	 X-MC-Loop-Signature:X-MC-Ingress-Time:Received:Received:
	 DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=6M/kUMvA0UzgjNwvS0eMpTxMfz/tcXoWNV729ws5vZ0=;
	b=UUr89SPRBdvS2wBCVW9dlDrmAHe6Ug8B4xdBDBmldvEEcV+/NmDbHoInCalJ5OP0NMDV
	 5s+B+TGfVkis/jzWWH5ucoprgprviW8OjTC08NqmsRj7JfBw71aXnQisq1wMMOLzAffsF
	 Xo7TR9qpXLBooNrdk4pVSqcsu0wfZV6SxIL+KakznEceMQH8Xtawhl3Egjw7Ur3l0mO16
	 kMfROyFHfYA9bga74g8FCPwh9RCC6RPF92pY6f3HwCcPYXoZmQkzToABZLLnuP1NrMVnr
	 q7vIxS+CUnIo3NmGOmOtGHCskQR38JlvjYbsVUOIzguqKUF9HXBH7Ubo6HEAzHGPkRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=stgolabs.net;
	spf=fail smtp.mailfrom=stgolabs.net;
	dkim=pass header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b=A2qF8jnG;
	arc=none smtp.remote-ip=23.83.209.135
Received: from olivedrab.birch.relay.mailchannels.net (olivedrab.birch.relay.mailchannels.net [23.83.209.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA453606A324
	for <linux-cxl@vger.kernel.org>; Tue,  3 Nov 2026 20:52:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA453606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b=A2qF8jnG
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 0A947941A7C;
	Tue, 03 Nov 2026 20:52:20 +0000 (UTC)
Received: from pdx1-sub0-mail-a249.dreamhost.com (100-99-189-159.trex-nlb.outbound.svc.cluster.local [100.99.189.159])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id AC468941609;
	Tue, 03 Nov 2026 20:52:15 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Stop-Whispering: 2a78b63d2dcf4f6b_1793739139889_1141921077
X-MC-Loop-Signature: 1793739139889:1747846557
X-MC-Ingress-Time: 1793739139889
Received: from pdx1-sub0-mail-a249.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.189.159 (trex/8.0.2);
	Tue, 03 Nov 2026 20:52:19 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a249.dreamhost.com (Postfix) with ESMTPSA id 4jK13M0KSlzymg;
	Tue,  3 Nov 2026 12:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1793739135;
	bh=6M/kUMvA0UzgjNwvS0eMpTxMfz/tcXoWNV729ws5vZ0=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=A2qF8jnGKe7qjEAZhm/L9ZZ0dAEv8Ogmmz8sAhmTjkw9jBOxcBBguogGN65rdb/YF
	 kcTTwaAQliZBO3D4I2hRNbB7XfTWV5Q8PucWLDVwwN3rz6oRWMXyJiMvHbi0Ry9mBF
	 qzNm/yoRTPbU17BLcqg9IHlIqsAsyowTwgFW3jejAKOy34qDAhyRGgGgU7hgxG5FvD
	 W4b2YaKUboh5+vH3KPDaZKQnV84TZ/lqsVhj7GuRdGZAI/qgawUoHknoTpKBbBf0CV
	 qGSUOz2bLAlpa9kD/csso9MSYGd9ITPxjlg448iU03Lqka83Sfd3YbUGWW/h2gCz0w
	 rzbSAst5m0h5A==
Date: Tue, 3 Nov 2026 12:52:12 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: Alison Schofield <alison.schofield@intel.com>
Cc: dave.jiang@intel.com, jic23@kernel.org, icheng@nvidia.com,
	ming.li@zohomail.com, benjamin.cheatham@amd.com,
	linux-cxl@vger.kernel.org,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: Re: [PATCH v10 04/10] cxl: Add HDM-DB region creation
Message-ID: <20261103205212.7vtja6zizuetpsui@offworld>
References: <cover.1793567979.git.dave@stgolabs.net>
 <187374442f21d6cc52ec6b9e390550db198f05c2.1793567979.git.dave@stgolabs.net>
 <aulMglfChjfQGGOz@aschofie-mobl2.lan>
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
In-Reply-To: <aulMglfChjfQGGOz@aschofie-mobl2.lan>
User-Agent: NeoMutt/20220429

On Mon, 02 Nov 2026, Alison Schofield wrote:

>v10 changes LGTM, Thanks!
>
>Looking at Sashiko's comments:
>1. the qemu 11+ regression I believe we agreed not to worry about
>2. the stale BI state after reset, needs looking into
>3. the unreachable CFMWS validation is a minor cleanup
>
>With 2 & 3 above addressed, you can add:
>
>Reviewed-by: Alison Schofield <alison.schofield@intel.com>

Thanks! fyi I replied to sashiko with these (particularly point 2):
https://lore.kernel.org/all/20261103204607.xybp5dfybdu5tlip@offworld/

