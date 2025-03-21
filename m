Received: from buffalo.birch.relay.mailchannels.net (buffalo.birch.relay.mailchannels.net [23.83.209.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B063F1388;
	Fri, 21 Mar 2025 07:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.209.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742543886; cv=pass; b=bBa13RX73Do6KKF4FXjg1uqXqCpIaiExB0FCKla5t0hfoPq9W/ZbOBGATkun1kQt/TYlYFANJ3gH9wgLwUjh5Rsw/XC4mNKm6LuaslBt1sDJ9Cnq7V4kbQFKWclHm22P39RWc3TLjU/ACEFSGw4pcBqozfySOMBJ5qznJBNHcZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742543886; c=relaxed/simple;
	bh=UnHOO/0o9icAYmNqnO8vLCcu+VibrNBPds8KJJ7Npxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YvwsGGsH5CPR0MZDAKAZrlmokIGKyKYddtR81IPcv5cP6Y7gvijKbexG7JFNqlmR/Aou8a5l02vOLMwB4aI8v3yOUsyOHDrlVlIwFbXs/kMFBDFFq4n74XNWlAJdoFNRG2SLU8NsBuCE4HVYgdbzAJsXXOP2qi/m024t/w2GYRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=kuKl/0mo; arc=pass smtp.client-ip=23.83.209.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="kuKl/0mo"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id DB568783891;
	Fri, 21 Mar 2025 07:41:58 +0000 (UTC)
Received: from pdx1-sub0-mail-a313.dreamhost.com (100-115-57-189.trex-nlb.outbound.svc.cluster.local [100.115.57.189])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 49CFB783AD4;
	Fri, 21 Mar 2025 07:41:58 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1742542918; a=rsa-sha256;
	cv=none;
	b=Hbx8zXOcZyoxUGVupNsX0ffRV7DcEB/I82G3hcrfPWh9ma9Rnng+IYpN5BENlRYapTwiRK
	dOAdeacR2drQyTG2wfPaS6Q7/4IgWPQaoxEw7XIl/DiRZ4YWaGisygwnGqehT0lZpfGH+J
	HW5sYk/6iHovETTwtinyuLDcThMhE8WXug7ZjQsu0Dp4UHmew9KphJswdY/2hWt5NgSmpl
	DVgd98X4bdshBb8hwYzVEdkrLAriTyNEyW2l9JJVM++VDGJ2XcE/Jnp/D85zuZzijCrQ/S
	chihqY6mtYyhjKb6bqpO4L9V3BMEI+nCwTeA3+hGDMl40m1ub6UDlNBCHnMJNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1742542918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=UnHOO/0o9icAYmNqnO8vLCcu+VibrNBPds8KJJ7Npxk=;
	b=gR8gf6Nl8w7ddJCpRMf/Uobr5PuG0wjI4s6hdy1J0T303a5l/KfEPVV63S8b4vE8/0OQb0
	ozidmvxEDXJLpHh5E9QhufSrMkbU78K8zlSgIPsrYpQ4EsVvKOuvxAz3GPFuNkjvnY2FY/
	lbJbfKBmdyFmmhFimlIKpfDEKFrmp/0IL4ObF5AB2soFGHvTm5P96H4ZKTDotRCJ7Uv+Hs
	YgsWf5Z9yXDQLgA9lS1gN9OkIn+VDUrjnZza+ncPuoQGpRFbRdkSC/10ImVrqo5mx06N9r
	m5koxqog39iBCPwnQPRfA163lT2w4uVhBUYzzl/0hFjN1QVHQN40RsH84UzSiw==
ARC-Authentication-Results: i=1;
	rspamd-74d566c845-79ct4;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Company-Shrill: 57d17fdc02ed3bcc_1742542918638_1087039239
X-MC-Loop-Signature: 1742542918638:2043952214
X-MC-Ingress-Time: 1742542918638
Received: from pdx1-sub0-mail-a313.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.115.57.189 (trex/7.0.2);
	Fri, 21 Mar 2025 07:41:58 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a313.dreamhost.com (Postfix) with ESMTPSA id 4ZJvXj4RyhzK7;
	Fri, 21 Mar 2025 00:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1742542918;
	bh=UnHOO/0o9icAYmNqnO8vLCcu+VibrNBPds8KJJ7Npxk=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=kuKl/0moaPMMiu00g+Dwi8N0RpHD7dAoJ557Qdoicv7j6qWqYEc7ozSjUwCX6Rewu
	 Z7vYm1snSfU0XC38Nu90Cgz5nf4DmLFCnRDkikX6WiM0MvFxTLey9Ipe/93x4EeSMV
	 gOGwc5Qr8W9ZxBZdtXG7rZahkqOgWqurKxS3NWu9T9/ezCNa6y/FCAeVcYbW9HRFV/
	 mrZrrWCeNblzPRW4G9H5LLSkWHJbDxYtfpYq6M+GJ/GcmDxlT7ce5VRa2/881wBaM3
	 1FFYwcCmJw+eQxfI6qF4rtgH0EjtXAjvoATwT6vgOwKpR/AfsEGyK0hQ1ahlXhzR7K
	 MKEzZzn68OdKg==
Date: Fri, 21 Mar 2025 00:41:54 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Li Ming <ming.li@zohomail.com>
Cc: jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC Patch v1 1/3] cxl/core: Fix caching dport GPF DVSEC issue
Message-ID: <20250321074154.ltenxqprgxizh5kx@offworld>
References: <20250319035516.222054-1-ming.li@zohomail.com>
 <20250319035516.222054-2-ming.li@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250319035516.222054-2-ming.li@zohomail.com>
User-Agent: NeoMutt/20220429

On Wed, 19 Mar 2025, Li Ming wrote:

>Per Table 8-2 in CXL r3.2 section 8.1.1 and CXL r3.2 section 8.1.6, only
>CXL Downstream switch ports and CXL root ports have GPF DVSEC for CXL
>Port(DVSEC ID 04h).
>
>CXL subsystem has a gpf_dvsec in struct cxl_port which is used to cache
>the offset of a GPF DVSEC in PCIe configuration space. It will be
>updated during the first EP attaching to the cxl_port, so the gpf_dvsec
>can only cache the GPF DVSEC offset of the dport which the first EP is
>under. Will not have chance to update it during other EPs attaching.
>That means CXL subsystem will use the same GPF DVSEC offset for all
>dports under the port, it will be a problem if the GPF DVSEC offset
>cached in cxl_port is not the right offset for a dport.
>
>Moving gpf_dvsec from struct cxl_port to struct cxl_dport, make every
>cxl dport has their own GPF DVSEC offset caching, and each cxl dport
>uses its own GPF DVSEC offset for GPF DVSEC accessing.

This conversion looks good if necessary.

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
