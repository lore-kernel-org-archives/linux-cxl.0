Received: from dog.elm.relay.mailchannels.net (dog.elm.relay.mailchannels.net [23.83.212.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D035439ACB
	for <linux-cxl@vger.kernel.org>; Sun, 10 Mar 2024 23:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.212.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710111721; cv=pass; b=JAq2XwmLTi7Y2fVt/Y9hTWmK1ewDsY/DLZfKEOy26v7bMmw8+nqz9pWjdc+gluWp3wQUtACdfpQ/tqklDuVfJons9fUFn54efW03tEZPR25F9Am1HGhlnlO1Vr5/6LvudlqJVImK6gOqM6VfPYmzM5vzJoOTyBtvl1mmh4o7vY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710111721; c=relaxed/simple;
	bh=3yNmOR89W6rsCYo7fCGRP96083wrqWdORtlcE0AuVAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eqFcR+ALvziwoZaQysAhzJozVWkt80/YFLVZheZO6HHz+XJIUxh/IG05O5hxlgjJ9mDQ1vEWUtgXZtEnPZG018i11z+TyG7OYSbzziP4pgnN/FPSRc02aTH7kQ9MCe+M1dedi3jL6pi8bZFbG17/CtzkTXaWLbBLZjTn2nKTVwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=BKOE7IiM; arc=pass smtp.client-ip=23.83.212.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="BKOE7IiM"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id A343C102CEE;
	Sun, 10 Mar 2024 23:01:53 +0000 (UTC)
Received: from pdx1-sub0-mail-a202.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 45C1D102D31;
	Sun, 10 Mar 2024 23:01:53 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1710111713; a=rsa-sha256;
	cv=none;
	b=8vl+8xC5DqzWpWLC3L/Q4d1oAOOauI+EjxUtjhmP2IsMyrY2arhJxH/t6MMvQq2npZPsOa
	fMH+F/mYRaCfVz1cm2WTtV51yDx9QvL70GKal3rZo7VLG7GMfFvOLvBg5aUhVXmFdjIjDx
	dtTYQE6ujBtLMmhdfiX1bbOHxjqRfsLU+dgLXmDYr+My8SaF1ysEyPBGYGhSkVuMRf+NkN
	r8N0oHPGR9cstjt83Bn/LIqzl7PR3AClFOp/MkoR4BXQhrGb6hCWCiGEFBjLfkVWLfLMmx
	JTOMmAeFtFVMZ4XQiHHhxdKGWkjcHk4qAfV5YHvGHmkgGdurcZYdWQKuvFiN0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1710111713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=l2HWUjqjmDG3dE4nGQIbWOiAD/6EgkwTYq4raWEcqCQ=;
	b=TvBV1DAgugN6Nm+CRb9ua0jmNi6IlL4zEdv/zV19jLx1GCWxZ9kZ+BR4Mc9XvBluTGLq+j
	L6ZCpmzn2M+lEKvcogE33RscopFd9Lw0pL1DB6EL73kHmOtPcqZmpO8Vnj4CrGAwpEEyPM
	N1DZboNnR8AM6QM64IbvyjahZShQZ81MeRWQIDpiUBs0lXtBoyio2fNrH2N8u9U08Hbu0S
	BqpPLTecqF+0zrPTdo/nxiFZdYdimpmxiUiYpZdhrWVcyUkQFp8vbmKoTJRAFzvWBhS6Mx
	/S4cYG4v6nClxCjbeB5k3AUIFpkdKkSUpxn8o5GlofH9spNeGWL/kSAfpbOiaw==
ARC-Authentication-Results: i=1;
	rspamd-5db57bc4b6-7g4vs;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Madly-Turn: 2e219ad5039c1b4e_1710111713565_993148189
X-MC-Loop-Signature: 1710111713565:4189441498
X-MC-Ingress-Time: 1710111713565
Received: from pdx1-sub0-mail-a202.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.122.162.88 (trex/6.9.2);
	Sun, 10 Mar 2024 23:01:53 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a202.dreamhost.com (Postfix) with ESMTPSA id 4TtFlh57D8z2N;
	Sun, 10 Mar 2024 16:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1710111713;
	bh=l2HWUjqjmDG3dE4nGQIbWOiAD/6EgkwTYq4raWEcqCQ=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=BKOE7IiM/OQBdQqBQj9fvY7rZxqn6deX8Y7ABKzHL8DEwnsfUqFUtO8Jsf/P8Yac2
	 pR8JRqZjKGST6aA4EoUm1jYNyUL/5e9Ly3hEqRUn1QQMK47T1jjwFVrp5rW2r+gUjI
	 G+4D5YQIMS8Pbvb2bpNafyBui4D7OCQOUSND3tngYb+COGHt/01WjadzD8C7jHaj1H
	 5Qzh0zxk4EH9zZ4iYf804KIxtkBr5uiCTlcNBzWcjS6eBMnD5NazXftS+v9B+eC+F+
	 MJZKjwCUUl0AvHcsu6PiydajO1N5aLQBVCLi9de/ipzcbgg+WUle3veDQcYs0FT8oY
	 jyOX22iNB7Q9A==
Date: Sun, 10 Mar 2024 16:01:49 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
	ira.weiny@intel.com, vishal.l.verma@intel.com,
	alison.schofield@intel.com, Jonathan.Cameron@huawei.com
Subject: Re: [PATCH v4 1/3] cxl: Remove checking of iter in
 cxl_endpoint_get_perf_coordinates()
Message-ID: <20240310230149.2ybcqrrh6rvp4ohj@offworld>
References: <20240307230432.2006490-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240307230432.2006490-1-dave.jiang@intel.com>
User-Agent: NeoMutt/20220429

On Thu, 07 Mar 2024, Dave Jiang wrote:

>The while() loop in cxl_endpoint_get_perf_coordinates() checks to see if
>'iter' is valid as part of the condition breaking out of the loop. However,
>iter is being used before the check at the end of the while loop before
>the next iteration starts. Given that the loop doesn't expect the iter to
>be NULL because it stops before the root port, remove the iter check.
>
>The presence of the iter or removing the iter does not impact the behavior
>of the code. This is a code clean up and not a bug fix.
>

For the whole series:

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

>Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>---
> drivers/cxl/core/port.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>index e59d9d37aa65..e1d30a885700 100644
>--- a/drivers/cxl/core/port.c
>+++ b/drivers/cxl/core/port.c
>@@ -2142,7 +2142,7 @@ int cxl_endpoint_get_perf_coordinates(struct cxl_port *port,
>	 * port each iteration. If the parent is cxl root then there is
>	 * nothing to gather.
>	 */
>-	while (iter && !is_cxl_root(to_cxl_port(iter->dev.parent))) {
>+	while (!is_cxl_root(to_cxl_port(iter->dev.parent))) {
>		combine_coordinates(&c, &dport->sw_coord);
>		c.write_latency += dport->link_latency;
>		c.read_latency += dport->link_latency;
>--
>2.44.0
>
