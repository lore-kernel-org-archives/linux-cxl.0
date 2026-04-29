Received: from toucan.tulip.relay.mailchannels.net (toucan.tulip.relay.mailchannels.net [23.83.218.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D99B37C11E
	for <linux-cxl@vger.kernel.org>; Wed, 29 Apr 2026 17:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.254
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777482213; cv=pass; b=LpVbGXhvckAglNhCPVCdLtSdJh/mheGKpd5k1obdGbKevvtgewSmcIpuVhhlTr4qjCoN6hd8ImwbXDHIsvkwZB1Tn9/G2yQUCt/6SODrEbBNoUArV8ahB7hNzWoKxOgr9bp3TA28MWdXY3m1k5aZLl50zgY3ZBzUMPrGvcsC/wc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777482213; c=relaxed/simple;
	bh=a9tpsDSiXvltMd1gv+1lHh5LSs7UrZ6WpRMRRxp1qUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EDyuTotX3dg3wR+0xuv/RJiw+HIGoDUIPoBjPi8VzCOwub+8QeQO9lBDFPzrsX5hAE7RUbHf1RgwD0L+fCFo/ciDakchyubXIrSCZ59YqnbubqZewJXFs57mF7m3iePLYuWhtBJFW23Lco9D+TYSKdFjnhXF+ezkxJ29Vk2BP/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=VgV4rbW6; arc=pass smtp.client-ip=23.83.218.254
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="VgV4rbW6"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 0DA1A7A1591;
	Wed, 29 Apr 2026 16:43:45 +0000 (UTC)
Received: from pdx1-sub0-mail-a209.dreamhost.com (trex-green-0.trex.outbound.svc.cluster.local [100.100.197.62])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id B595E7A17FB;
	Wed, 29 Apr 2026 16:43:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1777481024;
	b=9SyqymGEJVypiK4v89pgSHNREv7N9uxagnyp7bEgxdDZdSCpCoR/dxcrA6nANjJiunkyUv
	Pb+J37QlGIWmjQmDNW3eVSkWYcLJIn/Sf125BFPzWCmduxUZUwvJbFxPhiBMy0Hc1l3gXH
	Swr0Oybq1v65Lk3YEK3KQCG2V56NFTnDDN5ZCl4r8gpy5eB+kJ0xkYWCpWC6+lxS4iHGx6
	agQDNNgP+3pS58AoLJPn33cjYcLNHVeRUPNq+2r5ArL94VOZ7mFYdGrfsyrh4haFDf8Fg/
	S8mwR3rh5cd3f3guNJn8ie7EC3LsVWEcvEtE5naITEVyI+JN6/O3LXEEMZoOvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1777481024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=a9tpsDSiXvltMd1gv+1lHh5LSs7UrZ6WpRMRRxp1qUs=;
	b=6xKvyVCOgprZmikNP6qQm0wVebYsF36zVjRoRkf9jTgWKjLFdTDcIffX73KSy/kjl8tbTZ
	Zr+VFHfGH7rluoUuAUeocb6rg39JiXf1tg2a87CwVavElbXkx6D1U8tCRtGqAJN47Q+q3M
	vSHQfXwMHePB/aRptSv7GUPRxaRhrTrEKQgcCF1M4DZIhTiwfb/tOo8VYTjNdzLvVREagH
	uc4oskNgsA1Nzv4wyiC8pxNYm8Gk0TWrfVQyiA/emyuCAdADYhqxAnsBZioH3r7dYrybuY
	TX9yebw56iVuHDGe4JK5CBNqL6McSqEjzjDNUFvNeqtMWomcoU4XPiT0SfVJmA==
ARC-Authentication-Results: i=1;
	rspamd-798d95666b-s48tm;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Ruddy-Attack: 1f304a7025ec7239_1777481024903_729114954
X-MC-Loop-Signature: 1777481024903:3120847516
X-MC-Ingress-Time: 1777481024903
Received: from pdx1-sub0-mail-a209.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.100.197.62 (trex/7.1.5);
	Wed, 29 Apr 2026 16:43:44 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a209.dreamhost.com (Postfix) with ESMTPSA id 4g5NRN1CZ9z1h;
	Wed, 29 Apr 2026 09:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1777481024;
	bh=a9tpsDSiXvltMd1gv+1lHh5LSs7UrZ6WpRMRRxp1qUs=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=VgV4rbW6FMV39W7pxFwMB4Npdxf/KwS5Z3KmoIRtsTlJFRGYrIcE50O+UoJ54/WnV
	 PbTfMZ+L+vSnG59elOMuHz3gw3470/6p5l2eXDa7pb3yUctmLDN/QHxuhrw25anwzV
	 1fb0AsOwgfzabb4Dv22X8m/Zf81TYYonoMLfoB1yNyN+ZTyRF7MXKAUwolD/OLGnIy
	 99E2T4SNUke/FemQ+tIYmhSTOmmxE8R1qyDqT10NIkwyXPe0RQAAUmPUq0LybaIr8C
	 KOqhRxbKjlwh8w5spbBtQkgYXEmLh/RffOH9hE4CAAPZw5SpgtXHxLEBGv5PxMITaR
	 Nwf6KMX7HHItg==
Date: Wed, 29 Apr 2026 09:43:41 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Dave Jiang <dave.jiang@intel.com>
Cc: jic23@kernel.org, alison.schofield@intel.com, ira.weiny@intel.com,
	djbw@kernel.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH] cxl/mbox: Use guard() for mbox_mutex locking
Message-ID: <20260429164341.wilgbnjyzedhzyv2@offworld>
References: <20260428212220.711160-1-dave@stgolabs.net>
 <b96ab07b-a134-4417-86a5-386c17829977@intel.com>
 <20260428224700.koa6ls7thc5ggw27@offworld>
 <0c6fe274-c5ef-4b95-9676-bf32f810a45c@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <0c6fe274-c5ef-4b95-9676-bf32f810a45c@intel.com>
User-Agent: NeoMutt/20220429

On Wed, 29 Apr 2026, Dave Jiang wrote:

>May not be worth the churn if it's not part of ongoing work.

I don't disagree, also considering Jonathan not being fond of
the change, lets just ignore the patch altogether.

Thanks,
Davidlohr
