Received: from antelope.elm.relay.mailchannels.net (antelope.elm.relay.mailchannels.net [23.83.212.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E3EFC08;
	Tue,  1 Oct 2024 03:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.212.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727751722; cv=pass; b=B/9CdRZIfo77+p2dYvPJLdKFNts9aUA8hE7/PIcSGRXrUzCiV5jtC+SPwS+taa7OexUxQoLLRQ8459dB/QamQOzos14Z247knvKdnUXvQI+K4j/xBwyLLEbEpAWqxZVsLJmCvhJxS3nUzWiY1w6hn17G15jnvWjJ0jWVZDZnlZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727751722; c=relaxed/simple;
	bh=OlWlubkBamZ7PsOW1yG15T48PRXZDL5gJptZl6ol6y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y+VfNAJAK5s3Q76EqrVQ+xc90OdUVjttWIk8hlc6W1pS166hO4BSl3swke+S+kULBpDyPXVsldGHthSAlVcRa8+yPa46IbuQtF126CSUVEvveuQ2x73g5JhxJkOCVGPvE0/7h6TfXg9sZRMYUQ0yVpszUgu+a1kDxV88mlBrpXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=QQEcbd8Y; arc=pass smtp.client-ip=23.83.212.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="QQEcbd8Y"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 441B91C2CD5;
	Tue,  1 Oct 2024 03:02:00 +0000 (UTC)
Received: from pdx1-sub0-mail-a311.dreamhost.com (100-96-88-243.trex-nlb.outbound.svc.cluster.local [100.96.88.243])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id BF5F21C2D0D;
	Tue,  1 Oct 2024 03:01:59 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1727751719; a=rsa-sha256;
	cv=none;
	b=ck5HMXeJ0T8rdxwT1fW6aUDaUMBcsvhPK6HzIKiCYd1kLOXpibu3JtjCa9lum3zRPE4kcr
	S0G3lvNlvE/Gu0V9pow4ZwDUzQvYQ2IanYOCTfWf2ZiJ5JBwU8EWWNtB8Cq30qyXUv1fWZ
	OpigV5pGJKk3RbCjjSndkllgrlzqki+gUIUTALQ21GSvBmdOLvZ9VAd9A7zhTcQJ1R6uN/
	LC3Ugn8MFGYN25YWqerxolW/DLVVahHuyRhqrvQSFgrYd7KDkYIU3YqwQwe5C9QJSdd1/K
	2Qc4dmpI9r7FuPV1t0GAT6roHYAPwWXafXGEw8TVsdWjdqPJWHSXH1bOBkP9+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1727751719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=9Yzk8zoPL5ckI+vdpIQ0q5JxBXeFmDJGjArET0wyiWg=;
	b=eHb1KG5sqOt+hyYM/xcQtufphuG7JgM0gV/4HqWcOpPqL4A8x/mbSOURdsLk7/jO1eJkiJ
	KAYWBCdxJGlXJyQzu6AjANXf7qdPxz528zrkMA2fDc6zch8sqPtzwa6Zl/VFNPqJkA/tJI
	+XaE0aOh+pf0vqmvM63dIO8vCrwPFXKADmM2tHxbBpND4V6wpBvJooKgNc502th4YqqnLr
	A+5uA8Av04SAixq4XjV8CG51X7cCPf4kmH0S7+l7eijxfT5feeSm6B+ZJCjeo5S+7NtQOM
	tWS+rZit1yQ7nHKMeOtOEpL7Q8TZH3PvOIfkxf22TudDduGorzZ3GTbupikr7A==
ARC-Authentication-Results: i=1;
	rspamd-9d66c6866-pdnpv;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Descriptive-Cure: 4589b1a7419e0fc1_1727751720066_1675553827
X-MC-Loop-Signature: 1727751720066:1626573576
X-MC-Ingress-Time: 1727751720066
Received: from pdx1-sub0-mail-a311.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.88.243 (trex/7.0.2);
	Tue, 01 Oct 2024 03:02:00 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a311.dreamhost.com (Postfix) with ESMTPSA id 4XHjQb05y7zGP;
	Mon, 30 Sep 2024 20:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1727751719;
	bh=9Yzk8zoPL5ckI+vdpIQ0q5JxBXeFmDJGjArET0wyiWg=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=QQEcbd8YQji5X2lZBUerc+TJ9m6TrtvTWQgWH75d50ZylCQetetbCJDEArOtNtyCu
	 cshHN111CUOwIWvzUgFoZiLrIA84G1aED2RZ8ltjEQ56FTNFwxcpL7XARsmRQADnpp
	 zTZI23KVOg2h/gB1IwVCqRE92utWyja1N96tJmw23uiLwTx2RcZqnno6GedcrSR/9x
	 KhTUrzsIptKgENntfKslgXY+4fOzPYivRzgnRPIbQMqvuwKbhIIJKiziJ/XeZ4dmzi
	 iWh0in5Yp1akQgOhnNUQBo4NeXdbTa9Tcj/uPEGXQgz4PHDGtE7dD3dwPrYq3ijOTx
	 NlfU3DhUPklqg==
Date: Mon, 30 Sep 2024 20:01:56 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Huang Ying <ying.huang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Alejandro Lucero <alucerop@amd.com>
Subject: Re: [RFC 2/5] cxl: Rename CXL_DECODER_HOSTONLYMEM/DEVMEM
Message-ID: <20241001030156.yflpw3a2cwdgdyqt@offworld>
References: <20240925024647.46735-1-ying.huang@intel.com>
 <20240925024647.46735-3-ying.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240925024647.46735-3-ying.huang@intel.com>
User-Agent: NeoMutt/20220429

On Wed, 25 Sep 2024, Huang Ying wrote:

>Previously, CXL type3 devices (memory expanders) use hostonly
>coherence (HDM-H), while CXL type2 devices (accelerators) use dev
>coherence (HDM-D).  So the target device type of a cxl decoder is
>named as CXL_DECODER_HOSTONLYMEM for type3 devices and
>CXL_DECODER_DEVMEM for type2 devices.  However, this isn't true
>anymore.  CXL type3 devices can use dev coherence + back
>invalidation (HDM-DB) too.
>
>To avoid confusing between the device type and coherence, in this
>patch, CXL_DECODER_HOSTONLYMEM/DEVMEM is renamed to
>CXL_DECODER_EXPANDER/ACCEL.
>
>No functionality change is expected in this patch.

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

>Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>Cc: Dan Williams <dan.j.williams@intel.com>
>Cc: Davidlohr Bueso <dave@stgolabs.net>
>Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
>Cc: Dave Jiang <dave.jiang@intel.com>
>Cc: Alison Schofield <alison.schofield@intel.com>
>Cc: Vishal Verma <vishal.l.verma@intel.com>
>Cc: Ira Weiny <ira.weiny@intel.com>
>Cc: Alejandro Lucero <alucerop@amd.com>
