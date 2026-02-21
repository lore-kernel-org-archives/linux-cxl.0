Received: from dog.birch.relay.mailchannels.net (dog.birch.relay.mailchannels.net [23.83.209.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D892571B0
	for <linux-cxl@vger.kernel.org>; Sat, 21 Feb 2026 18:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.209.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771700142; cv=pass; b=RFlEiyqxZAk6f+x8lj1Glv+XLLZARjzcbuap/YVWMaYpMmVc9UuMdX1OKAxLIwaMtaM4IZnETNC52pgHAwtGMuCXiaXBdqTQ6Pxwwx9FHDx2kieLmJH9sfGwB4LLk5y6M64vZ1r9EwTcktJwjKDPapqpIF9ypHQ8ARYapP5B0LY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771700142; c=relaxed/simple;
	bh=5Mo3BgfH40Xv+Yz35FuV3rG1qR/e3Ub88eYiKT5f+98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vz0StgZ58RdA6sp9NEWWK6wiK5bJT9DDrChSGgdwz+bT8Efa+7/beKdV4nizUKB92kiMMoMDJhhz5qnf4cv2MF5ybzeUrEkA2pZTlNnbhHoHnfgkwEr7nFrGuUef/0B0ivYv+qs+ekkEbZoL1RMQaGfAo/KHv27YyDG4f7lxJ4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=p1JkojDS; arc=pass smtp.client-ip=23.83.209.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="p1JkojDS"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 371827824C0;
	Sat, 21 Feb 2026 18:55:35 +0000 (UTC)
Received: from pdx1-sub0-mail-a237.dreamhost.com (trex-green-7.trex.outbound.svc.cluster.local [100.99.24.30])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id C30C67825E4;
	Sat, 21 Feb 2026 18:55:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1771700134;
	b=USvrhjlxBng4vUQEFEp1qQoxSEVeDS0Bt+rKYDqVcL/w/45iQ/mdc5ETzuVGZut1PigYX5
	VBFer3pHsL2JKgUbu8ju/huZp7hRCg9aSCWfBi+WaORnwlpYgQPw2ryL+JKXpLgov6fgk+
	84VAzk1+HcEVb1RuoAAbviEy/P0ipdedn47j4H1BrZF4l/0xLElDR4hx+EBar7UCZFn75x
	5qipqD8Jk1KVXGl9KnxWGmSLJM8Zi2x5YkuwE3/hqvhcyiGnVpVYRfYo70dlPQRBBhytDv
	mhJxIagp5YUHqWy0SLhkqehpXcOnGLpcSfVwmDhiEQ/8YQXCxan4KC7y7pnq7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1771700134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=5Mo3BgfH40Xv+Yz35FuV3rG1qR/e3Ub88eYiKT5f+98=;
	b=LYA25SiHFudCYqEzRv/VdEvoSu5je0deSEXc6sWUAFeWTux1pn9XAZVp4STVaBA2J7Mpoa
	c4zTlMrzO/+kA1UWB9rZ4PZlx+DqjAerJY+xHkt+R6HuM/wrP3xdr1++yWGogtjro7Mg2O
	ziSLhQEZmSFvHw7PUJrOtJ+jicAIAxEpP4TcqdH+RLFIG/urY2r91Azk6pz3acYzVnod7I
	zdLoUShdEiiBx0bAAfbPK85/IZGjt0amYkRgr4jaq4JNJReDBhfPsC1ICYy+kdrkWLfQ37
	8sWl/rBw5j20Way3i69Xz3tbCDIwYe6sVmyDvxA1h/c0HomhweBXcTc3eiPj7Q==
ARC-Authentication-Results: i=1;
	rspamd-7f65b64645-wksht;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Arch-Whispering: 0f83f4c336ba6c45_1771700135041_1729749272
X-MC-Loop-Signature: 1771700135041:272781825
X-MC-Ingress-Time: 1771700135041
Received: from pdx1-sub0-mail-a237.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.24.30 (trex/7.1.3);
	Sat, 21 Feb 2026 18:55:35 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a237.dreamhost.com (Postfix) with ESMTPSA id 4fJGXQ0GP8z107J;
	Sat, 21 Feb 2026 10:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1771700134;
	bh=5Mo3BgfH40Xv+Yz35FuV3rG1qR/e3Ub88eYiKT5f+98=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=p1JkojDSCrnCtQOFebgfJIbHJL5r2m/vzHAnwC5pllH4PWpaWJq+qhkU/8WDkkm7/
	 WAVuRWiapwHRynfLXPTKA81mfloEb8Reeu4BIddZq59jCb4SoVRzpmnmEZ8E4eo5y0
	 1dVpvJnqSn/dSZdAlOh7S4apUifHgt7lFcscAWNmI3jy30vx7P/ORfeY7FDTovF47D
	 BKkBhwWgwGkw+VnE5TQ1HzOWfDVXOQcvKpEQadAb/3d+TLyqN4RZ2SjxGkc7CofyPW
	 hYuFWmCqSPxDuEhKYKGlZQXDt+DUvenuQO8u7TEjfosUpxV9YHsOGcXR1iBbaarVSM
	 R8/D1NwuZVEPQ==
Date: Sat, 21 Feb 2026 10:55:31 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: Alison Schofield <alison.schofield@intel.com>
Cc: dave.jiang@intel.com, jonathan.cameron@huawei.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 2/2] cxl/mbox: return appropriate error in
 cxl_payload_from_user_allowed()
Message-ID: <20260221185531.mj6up2v7wmd3r2eb@offworld>
References: <20260220001618.963490-1-dave@stgolabs.net>
 <20260220001618.963490-3-dave@stgolabs.net>
 <aZjc1w1GMnwoJOzN@aschofie-mobl2.lan>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aZjc1w1GMnwoJOzN@aschofie-mobl2.lan>
User-Agent: NeoMutt/20220429

On Fri, 20 Feb 2026, Alison Schofield wrote:

>My concern is preserving ABI simplicity and avoid implying that the
>kernel validates RAW mailbox payloads in general, when it doesn't.
>cxl_payload_from_user_allowed() is a limited safety gate. Before this
>patchset, any payload rejection returned -EBUSY. Returning -EINVAL for
>undersized payloads could be read as broader RAW validation than we
>actually perform. If we want to keep the ABI surface simple, we could
>treat undersized payloads as another ???payload not allowed??? case and
>continue returning -EBUSY.

So while the bug is only triggered for RAW commands, these paths are ultimately
for all user cmds, so it's pretty implicit, and ultimately does not respect
cxl_validate_cmd_from_user() return semantics. So I don't really see it
as a case of adding complexity to the ABI surface or sending the wrong message
about RAW command verification.

That said, I don't have a strong preference if only patch 1 is picked up, I
do understand your concerns; and it's kind of the reason why I split it the
way I did.

>Conversely, if we are going to split errno values and distinguish -EINVAL
>for undersized payloads, then for consistency we should also reconsider
>whether -EBUSY is appropriate for the IMMEDIATE flag case. That is a
>deliberate policy restriction (not a busy condition), so tightening errno
>semantics in one place raises the question of whether we should do so
>consistently. I???m not suggesting we expand scope here, just pointing out
>the implication.

That's fair.

Thanks,
Davidlohr
