Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F83218845
	for <linux-cxl@vger.kernel.org>; Tue, 29 Apr 2025 15:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.212.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745942380; cv=pass; b=piyyiS+eNiH+t+G2R8ncP+rZMcPkmb4OG6Nv3fr7RvUtpxp7rDWlI3PX0hAhmtgsGoZ6ri2snsfVXNTs5lDp1KDFBsKhAfvCKYE03xKt63TYm5jSot3ZaIwNGz63Sm3muJsruVKzaLlhq5cumalIGsyAWLl2qZXsx2+slBs65Xw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745942380; c=relaxed/simple;
	bh=kW0OYPbiNctwNt73GWVVY+Hh6jd9+dC2pliWlTMjkKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IttmwezSRjq5EWzVdc3WoBS8yzsJe0ik6wL5xTZ47PbP4tJUWjSmaH1/aqWSmf0/VJJyXVx+k3Y7DbfnK0y4ekNBIV/5IVRQKllbVQs4sKRz0QKJ56DxGVs+vMwDlcpeBSCX/6lqOnEVkw/dianbX6/BptILMRb2f97kMBQ0h4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=iFL0hUdV; arc=pass smtp.client-ip=23.83.212.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="iFL0hUdV"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 5078583B24;
	Tue, 29 Apr 2025 15:59:31 +0000 (UTC)
Received: from pdx1-sub0-mail-a259.dreamhost.com (trex-3.trex.outbound.svc.cluster.local [100.108.243.240])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id B955E84565;
	Tue, 29 Apr 2025 15:59:30 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1745942370; a=rsa-sha256;
	cv=none;
	b=3YL7hYgXkSZD/HXsg4Nu00P8ero882GLen7OvJ7dt1QjWbM4Dm4RGJxtogur0YIDMx0wWb
	SjJhXBB8PqPyiWEoC1pfquf1D/LaM+5Q+Go7yo6wFDc6TxzgKASPn7dA3KFzKI43VIXMir
	nbFiotIoH14a+ZSrlijo5JGu88rWRjQWCutSVzKp2wCrFm1oWYl61zfvPTaqmwHZ8Edkkk
	nw/M7YOtDGK9tIyG8Tyh+NdGKKTUtBUrZj3FbnzgVp3fwI3k1kAGLfuz2h73052juUJGX5
	bTiRm7pbKEvoKN/KpAIYJ0igWQiBErdmNKa3ju5Q+MHsYcGm2N5LL9lOu61uCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1745942370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=kW0OYPbiNctwNt73GWVVY+Hh6jd9+dC2pliWlTMjkKM=;
	b=SZqJIz5MSstm52b40KW53aXI7sFiQQWNm/TOR5SEImn0xn3ikzFFLUn9XwMWUYWJsYuY8+
	liMwya4j8wdzPcyvY73di1J3moxtT+AANGYvrFKmdNFpuZ86bjYjEV6V5EC5irtpP4K1ue
	0aVxNCEYebERWUVhrXI3VhRvFMYNwP3GVJwQyTMM6rcx8U1T5xpxM3sx0hG57ZKZ6CCgKJ
	cN0EPxAvXaZhrL5UnkmYqBQKllKKhenDh2DS/xSn/qBcWTLjw9SoQbmG4O5deoZUjXTcfv
	tHHmFGdbdo4qUvGb9iKYcChfmOE7sJa5OpQiakC8JkSx1LZO0tHutTJAxjCyiw==
ARC-Authentication-Results: i=1;
	rspamd-6d6c74965d-sx8ct;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Interest-Army: 5ec216f32cde97e3_1745942371065_1380139958
X-MC-Loop-Signature: 1745942371065:4212428162
X-MC-Ingress-Time: 1745942371065
Received: from pdx1-sub0-mail-a259.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.108.243.240 (trex/7.0.3);
	Tue, 29 Apr 2025 15:59:31 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a259.dreamhost.com (Postfix) with ESMTPSA id 4Zn4kp13jwzQq;
	Tue, 29 Apr 2025 08:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1745942370;
	bh=kW0OYPbiNctwNt73GWVVY+Hh6jd9+dC2pliWlTMjkKM=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=iFL0hUdVF+Zl0cjdouPo3wZ4GcdtvUAvq77QtpR70J+clHRat/SklRI3cLOyCrjXO
	 /Sb1aYTL5o7Tv/v/1Lm6b74Cc5T9HL2+eGL8wSiWVeoZvYVBcJoTVrJMtXQcgwg1SN
	 bQMwrZ/gHSJ10ZhxAjl7sxXdYYOx9zoC5zeE/eU/Qim5vJOXaaUQuqJDM/n9hqfVwN
	 wPGZPSTLhr8pub2TYkbFMVPTPvC+w6bkizfs86wOV7eFTTo+abPFfrcfOpPsB7QEze
	 QCUWGJwS8shD/eWWfUaXuzPd6pY+iAu9R/84VFF5W3/a929AinSm63gqg0kX3q3lqT
	 Z7vJFuiIySbgg==
Date: Tue, 29 Apr 2025 08:59:27 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Gregory Price <gourry@gourry.net>
Cc: linux-cxl@vger.kernel.org, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, kernel-team@meta.com
Subject: Re: [RFC DOC] cxl driver draft doc
Message-ID: <20250429155927.2t4rdawgpf4veaq7@offworld>
References: <20250427170042.545675-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250427170042.545675-1-gourry@gourry.net>
User-Agent: NeoMutt/20220429

On Sun, 27 Apr 2025, Gregory Price wrote:

>This is one piece of cxl boot-to-bash series being documented here:
>https://github.com/gourryinverse/cxl-boot-to-bash
>
>This page specifically:
>https://gourryinverse.github.io/cxl-boot-to-bash/linux/cxl-driver/

May I suggest using cxl.docs.kernel.org? I set that up years ago
exactly for something like your writings, but never got around
to it.

Thanks,
Davidlohr
