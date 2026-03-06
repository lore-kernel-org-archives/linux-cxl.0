Received: from bumble.birch.relay.mailchannels.net (bumble.birch.relay.mailchannels.net [23.83.209.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3033306B1B
	for <linux-cxl@vger.kernel.org>; Fri,  6 Mar 2026 19:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.209.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772823852; cv=pass; b=jZo/o2Mx49/JH9RFy8WFX80BRIoFaUuCyNskAy+3NonAWU49I0J3nYDqVQKvCioa9beXCFmyuaYZK+1J3JyXYtNGFOZksempbrXSmF9PaNSw6XCs4jYfUZ5HPxxtaNyarv5VA7yc5yxT8qGphNf9BmTlFbGZHaj6KXYncjvRLkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772823852; c=relaxed/simple;
	bh=ptHXSuU9hSnfo/yrnP4TxZOE4RlnF8hU52zv6fAgVQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X6Bxkxs8gq715sCY8XvbbbsC30/47km+d9oWTryEf22I0A6v2hPPE989fQQ9zZttklNODbIaoFIPOHKt5MvtmMi0GQ45Xr60OviX2qn1DBoEv1WMEXZ3nQxJXJigkdhTIwnU7RpYamiYmbeDR64g5X+cl7XcfEAZfA51TrqttDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=fpIQ1srv; arc=pass smtp.client-ip=23.83.209.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="fpIQ1srv"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 90C85562240;
	Fri, 06 Mar 2026 18:45:04 +0000 (UTC)
Received: from pdx1-sub0-mail-a222.dreamhost.com (100-107-38-197.trex-nlb.outbound.svc.cluster.local [100.107.38.197])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id E759D562221;
	Fri, 06 Mar 2026 18:45:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1772822704;
	b=WxX37yWs8PwQE4AKbwp/TgKlNWoU3V0j6/5RoLnZ1g04ixCMuFlMT780PxebVBcJcz7gYG
	MRYFJWBuN3WYQg0h92GAwFpMd7rhggvKxY2QE0+lmBjA4/ImOGpnX+anAPh97VX10GOTNV
	cHjqTITpXIu2BmaxEKrjdpHGtVoNyniXOnCz1h4GMIPEuxESGrPa2xW2lwpu1JjyIr6qiS
	aA6EoxT+Z+cYuCPdBy0nyb6nD5+JMgE/4gzIsH9fwWd51d1Y9NE2oJ8OtTV4yzcliUFdas
	VTGyVFLhlsukhQZavWU0VeEWVyL7H1NMXIrkjZZPv9jx70Mmr5X+huUHsVi7TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1772822704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=ptHXSuU9hSnfo/yrnP4TxZOE4RlnF8hU52zv6fAgVQE=;
	b=DzTCnkkXaafdB6TsAURVQ+OEYh9SCKFqeF6tg8I9uH5GRvzCvdMESnz1RdU2zpXxRL8xJL
	pG5jnl1oYKr07Ts008bstnPnYlasKe3bA24FPUtvYZU/PLLkhlw08JrVavknDuNkLC7xnH
	PHTmVL1naxGQYuhAhFj6kUSEFmsml6C5UyacYIC/TbBaHBag8TdEE6k/jRx8ztN0Q90S1E
	6Icoj7EKDccZwn+yGxnfwgmLO2ZgXZ3d/7JYWXTca9EC3ZVOmF3JqN/66uZEQB5J0WHbLh
	4aM924G/el+++9cfiV4xyrnKEp4gDMqRFGJ1qRVsahinhkhqcXLJbY+2bhdfOQ==
ARC-Authentication-Results: i=1;
	rspamd-8f47468b4-v56zt;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Whispering-Little: 233333e70ce30f89_1772822704203_3995252013
X-MC-Loop-Signature: 1772822704203:2881025118
X-MC-Ingress-Time: 1772822704203
Received: from pdx1-sub0-mail-a222.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.107.38.197 (trex/7.1.3);
	Fri, 06 Mar 2026 18:45:04 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a222.dreamhost.com (Postfix) with ESMTPSA id 4fSFhH2ZCqzS1;
	Fri,  6 Mar 2026 10:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1772822703;
	bh=ptHXSuU9hSnfo/yrnP4TxZOE4RlnF8hU52zv6fAgVQE=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=fpIQ1srvxh/Kbfj62g7O/WqB0bNLD+VvM8OgVa2iOfF2mWFq+3mBdRHWKHncuKe1H
	 yxWmVlP5tUAdUnZeQl3JOgb0F3irNP7JT1c/KypYeGr84xVHrikKsso/pjdslZBFHA
	 Q50m87LMZJQKWhlIIdYPsT5/UCd2fm55zrRDL38xxZGe+Zgw8dB1or1D4wbzkk0KL/
	 EYEN+uSjFqacQyVt8Rj4sjaVZxF9e6+Ka+3MFV7UfZHD+oCGLMtKulT0765/bp9wvC
	 BUfstwCoi7vYEhdhEkNhrdahpq4zTcRvDZ8DYcntVeiJ4z9QK5jVttOFJOh9a1bHDT
	 LRKq++npdO2Wg==
Date: Fri, 6 Mar 2026 10:45:00 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
	dave.jiang@intel.com, gourry@gourry.net,
	Alejandro Lucero <alucerop@amd.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: Re: [PATCH v4 4/4] cxl/pci: Remove redundant cxl_pci_find_port() call
Message-ID: <20260306184500.dpwzb2vxrfv2j7zf@offworld>
References: <20260306164741.3796372-1-alejandro.lucero-palau@amd.com>
 <20260306164741.3796372-5-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260306164741.3796372-5-alejandro.lucero-palau@amd.com>
User-Agent: NeoMutt/20220429

On Fri, 06 Mar 2026, alejandro.lucero-palau@amd.com wrote:

>From: Gregory Price <gourry@gourry.net>
>
>Remove the redundant port lookup from cxl_rcrb_get_comp_regs() and use the
>dport parameter directly. The caller has already validated the port is
>non-NULL before invoking this function, and dport is given as a param.
>This is simpler than getting dport in the callee and return the pointer
>to the caller what would require more changes.

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
