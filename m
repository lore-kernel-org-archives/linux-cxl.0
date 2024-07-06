Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E64847A
	for <linux-cxl@vger.kernel.org>; Sat,  6 Jul 2024 06:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.212.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720247712; cv=pass; b=Vf4VOFKvzvwrvjsXe3NCrEa9A2FvedcoHiIpMNz3SU/Vdp0eRhpCBw20ZlZGS9a2N3/Y7JdZ3SZ66vQGUY5DF5ryaGwBULttqn4+VCNT9QpY/0hWMq33kSn2toslrWNyYTuHvqNEu8XGgaDk9Q5RH4sTOSUXRpYO+pF5YhmdLzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720247712; c=relaxed/simple;
	bh=RR4ndy8DJi6i+2N1b64CsTRKrkHvee4BttaJYHl02gE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DY7nGuAmvx38NjwmstayV1BQEZJG3ejQ3mJB7S7H7faChgfVqdiyTqq3IHaNTXr56pcDsmZCLh88inrMlh7vqHhJZn9WV6I4UPTnqqkGs+0g2VErtd5RpO2Wzny3yua9Lw7Ly7COeEiM+eYai2rHTi7s2vTIrajKawGN3YeWK3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=mwKBGykP; arc=pass smtp.client-ip=23.83.212.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="mwKBGykP"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id C10997A42AC;
	Sat,  6 Jul 2024 02:05:48 +0000 (UTC)
Received: from pdx1-sub0-mail-a312.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 9F1547A42C0;
	Sat,  6 Jul 2024 02:05:47 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1720231547; a=rsa-sha256;
	cv=none;
	b=8TQZKS8tekLFH6yf2u1iJIdMLeaIdzzvoiZgZsHWqu/7eXklaF1dE5OqJhYboN3F8zPl6F
	WF8NbdnMOztZ6WE8GPgBFkY86zSmvknLpCsD2hf3kTr1nBEIm1XwjdU53lhJ0xwlA9F9dZ
	dQdYdsFxSwdVvd04uSKKd52MfDkh3tfnM0jf6mY7R7ZDtJrgLQdIweBSHXm6ys0h8gvqo3
	Os7Zs+8Bjke2KNHqyHQTJmzjwZCJmCKwFpWuMoTEvhDAkClINNZ9PjOK5C3FhlGhcP0uK6
	S1dx3BKI62xnBDTAaFmLum8ipJC/djw/PVBpPRNeTPAfzL7fghXOKYHmgD593Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1720231547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Um5DqBU+AHxpxjlfwVqJNYnk60L7QGnj8bkJgYOgzhQ=;
	b=Ko99RHtx/spMBwtyzo86ek2OX8h4rCgkRIEmaYvzi20qPrlRkwYt6Tv98BJ0ZwFCybV47n
	Yp0qfx1u4O5SKJWtELMfWPImK1regSeoTG/CbaulueKXGiy0AzXuejnLedDFFCaUoxp/yD
	jaFNLVzg5OFIKKhZm/UExlhBZ+308qeQTD1WdIKzi2xbmDzG8qj6uwKvRZLHDvFdsS4Q1F
	JEqebr2Kq6CRxNVNmGKR8Keu3+0fCASubeJzRYiz+JeICJFMguJED0Yg1asMU9YcUtVFnu
	R1USDpKWNNSd+K0PKlVrR/zwWNo4RkJ+ZHfQXdU1AsHFcQ2LUMGSXdaOvpGKog==
ARC-Authentication-Results: i=1;
	rspamd-6db77b4858-5lnp5;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Absorbed-Invention: 6ab12fce7cd33f8e_1720231548598_3798865081
X-MC-Loop-Signature: 1720231548598:2967552490
X-MC-Ingress-Time: 1720231548597
Received: from pdx1-sub0-mail-a312.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.117.230.9 (trex/6.9.2);
	Sat, 06 Jul 2024 02:05:48 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a312.dreamhost.com (Postfix) with ESMTPSA id 4WGDHv0T34zPv;
	Fri,  5 Jul 2024 19:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1720231547;
	bh=Um5DqBU+AHxpxjlfwVqJNYnk60L7QGnj8bkJgYOgzhQ=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=mwKBGykPqZbB06hIvYfr7dUSPT0/U0sP+b8VOgA/zUMPf6qtyNPQrAAf689CxARqP
	 7ofriNFIDbAWUfDTBST4ry2v6vSiKpqwhqWzVjuGvIipMYnFGExuXE6owGOQFJG0Dx
	 2VDVQN/PdtnkmG6vInsSHBv8AJZ8dwwQq+y1PoCOCYyAIsBtS+uvt4Yvfa2liOIT3n
	 tzzstSUAK4WqQ+yMso0bi0Vp3QyhJANhdj+1l2f6hVjthCDxyrGbHIGOGlBpCjRi67
	 tZdz7HtLH6QGcgv7ewHHjFKjxYOzS5UJdhLbUKm2lcwlUttHnpTPNFpLqLWPIhFaKj
	 ItyI+t76cNE2Q==
Date: Fri, 5 Jul 2024 19:05:44 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: alison.schofield@intel.com
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 0/2] Return EBUSY on inject poison limit reached
Message-ID: <20240706020544.nufgym7wwqs3dewq@offworld>
References: <cover.1720052137.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <cover.1720052137.git.alison.schofield@intel.com>
User-Agent: NeoMutt/20220429

On Wed, 03 Jul 2024, alison.schofield@intel.com wrote:

>From: Alison Schofield <alison.schofield@intel.com>
>
>Validation users are asking for the ability to recognize when
>their injection testing has hit the limit of the device.
>
>Change the drivers error code for this failure to EBUSY and do
>the same in the cxl-test mock of inject poison.
>
>
>Alison Schofield (2):
>  cxl/memdev: Replace ENXIO with EBUSY for inject poison limit reached
>  cxl/test: Replace ENXIO with EBUSY for inject poison limit reached
>
> Documentation/ABI/testing/debugfs-cxl |  7 ++++---
> drivers/cxl/cxlmem.h                  |  2 +-
> tools/testing/cxl/test/mem.c          | 13 ++++++-------
> 3 files changed, 11 insertions(+), 11 deletions(-)

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
