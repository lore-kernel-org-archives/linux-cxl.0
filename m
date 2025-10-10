Received: from skyblue.cherry.relay.mailchannels.net (skyblue.cherry.relay.mailchannels.net [23.83.223.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F952FC024
	for <linux-cxl@vger.kernel.org>; Fri, 10 Oct 2025 16:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760115530; cv=pass; b=JGRLRW5ly2Ka/TwYaxqmYLtV8o23uYhDSl4Xw/cP4/QgTGcda0HGhZHeNk/JOa8sO++j7+ay+HrBAnubPX4zB1jb2BnlSJHXQ3P+NzjOMTduYxWLRe0/21ifemPq1oYDfKDqblbEa7sMmPclBz6QTADZaPQcP+S0WR1DcOb3ypo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760115530; c=relaxed/simple;
	bh=Xsx1yqHTfdFr6eXyfBbIZIPa1S+nEI8m/z5WCCmbsCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JMCpTZxSRv5kwTA79tM1d73nY04lGB6mAkL0JtUMdzaOrMwIqriZJnE3qvxP/Sqyz5RQNIaqXhRCv8EMduDNCjY55lbZKOmbhrxw+PPPPJialuFRbTLW8dmKezdhiChOJirpn5fNqWr3pNbyomU0KmgrPywampxU0n1EyWRNJHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=lgv2zV+E; arc=pass smtp.client-ip=23.83.223.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="lgv2zV+E"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 5104B1016BF;
	Fri, 10 Oct 2025 16:58:42 +0000 (UTC)
Received: from pdx1-sub0-mail-a202.dreamhost.com (trex-green-1.trex.outbound.svc.cluster.local [100.117.100.119])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id A7D74101852;
	Fri, 10 Oct 2025 16:58:40 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1760115520; a=rsa-sha256;
	cv=none;
	b=mpuYMXrgBJtc14MIwkaCIw9Gul3R60uiuQaPcKqbPlDgRtBqRuqXNId7IiceBUSc/tWmY8
	nA7di4c1j34M+EGwtbb0QaFjXZQiy9SEF4vN+9S4VzTMKAjQqf2gYX5kl+9uZNyDySEpvG
	8WEwh+xI2GvXmY/WJbhu1f/uO/1cJaI06cbZP4CKPE1y0ThLv/zuiHufI/Ah0DSzF45jqK
	Y9rS43b7SrZUtftHsjMO0WV7TAUzgth7V6heW/f1y3zOzLmaK2OM++i7L65YHG999Sk8dx
	XCfbLzwhP8r92zVOJJSjnITu2IZMZjTbkOP8ntfoSJvslqmMQYc2OnS0R91GDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1760115520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=fPRMZuU2G8Db8QcSSnmyGqxV5im3fHe0romBuyi4+j0=;
	b=xxCwMKbRpzKNiX6gJtm9NxcQEYNlpsRlhXcZjFqYQvsiV/12Z8fhmibT0IaJ+s2T0J5S1U
	Mg+EWlShd6X0tKUNX856gqq3waCBI8/jpxHmR/V/nuWEuamimWIQ0aUuAx0TdWwrwEi/q2
	baeNNy82ONseKrTaiS83HIhWakYKJhdZaRfYsRL1qDRFuuglOd9Jy1oD+e2tf5nbOpOA9D
	qSIgyoEmTtSvz3xPsIDBp0imHNMY5DpgpFtpch0hR0wRBqaW8fV6Nhfqkphu00qWH7VrXH
	EvOosKpUaafcWbA0LgitL6GPSlp/GAlfifm+OC8k/qBxJKMpEcWIm8EiQ2Ru7g==
ARC-Authentication-Results: i=1;
	rspamd-668c7f7ff9-zzxcl;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Irritate-Bottle: 4c9576c647452fe2_1760115520913_2547032128
X-MC-Loop-Signature: 1760115520913:3517153055
X-MC-Ingress-Time: 1760115520913
Received: from pdx1-sub0-mail-a202.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.117.100.119 (trex/7.1.3);
	Fri, 10 Oct 2025 16:58:40 +0000
Received: from offworld (syn-076-167-199-067.res.spectrum.com [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a202.dreamhost.com (Postfix) with ESMTPSA id 4cjtHN0rdvz3n;
	Fri, 10 Oct 2025 09:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1760115520;
	bh=fPRMZuU2G8Db8QcSSnmyGqxV5im3fHe0romBuyi4+j0=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=lgv2zV+Emz9RtvRx8ZPLvcGcnUHc3iZWG7WR5lc1tSMKi6VQ0oBwoB3DoFYaDMm3q
	 1Ph67waMTv+J3Tw25o96Os6poE3lh42/IIORdg/tKaqIzYZNXW/WGYV6viyx8OBkYr
	 8GNbrzdPuWL2PGelUoI496bBcRAWbj4kDuvzIgHdT4Z/DJY8pWMgTLc0yopOXnHk+z
	 GCtYOnyRlIH+o7UyOBBQU+snzGQ8Ovy47YDRpR6/kQoXaemDt90DUzd2DmCu1lliVf
	 zspPFEa/I2tQY+PBZf8d0kqru5x5EU6NAgl0hgmYTgAhcvH1jJXihX4TgkdsdfndSz
	 t1I1P63usHdrA==
Date: Fri, 10 Oct 2025 09:58:37 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, jonathan.cameron@huawei.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com
Subject: Re: [PATCH] cxl/features: Add check for no entries in
 cxl_feature_info
Message-ID: <20251010165837.g7i7bxwqfzfogjne@offworld>
References: <20251009154001.2660917-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251009154001.2660917-1-dave.jiang@intel.com>
User-Agent: NeoMutt/20220429

On Thu, 09 Oct 2025, Dave Jiang wrote:

>cxl EDAC calls cxl_feature_info() to get the feature information and
>if the hardware has no Features support, cxlfs may be passed in as
>NULL.
>
>[   51.957498] BUG: kernel NULL pointer dereference, address: 0000000000000008
>[   51.965571] #PF: supervisor read access in kernel mode
>[   51.971559] #PF: error_code(0x0000) - not-present page
>[   51.977542] PGD 17e4f6067 P4D 0
>[   51.981384] Oops: Oops: 0000 [#1] SMP NOPTI
>[   51.986300] CPU: 49 UID: 0 PID: 3782 Comm: systemd-udevd Not tainted 6.17.0dj
>test+ #64 PREEMPT(voluntary)
>[   51.997355] Hardware name: <removed>
>[   52.009790] RIP: 0010:cxl_feature_info+0xa/0x80 [cxl_core]
>
>Add a check for cxlfs before dereferencing it and return -EOPNOTSUPP if
>there is no cxlfs created due to no hardware support.
>
>Fixes: eb5dfcb9e36d ("cxl: Add support to handle user feature commands for set feature")
>Signed-off-by: Dave Jiang <dave.jiang@intel.com>

lgtm

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
