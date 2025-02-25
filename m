Received: from skyblue.cherry.relay.mailchannels.net (skyblue.cherry.relay.mailchannels.net [23.83.223.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67A11ACED7
	for <linux-cxl@vger.kernel.org>; Tue, 25 Feb 2025 21:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740517760; cv=pass; b=nTOL9Xyv0OnzeGOgTs241FOKLJdpXM5nDlh5qBNXYFcFtgCHxHHzgH7tCNTxeefB483gLalc+W6WGrH4IbngrobC4xz25SPSFZdd9zhNuXVme/fJtdiYfLPIE+Shn4vTJ7GnaEYI9RfqZMUq11mvaQpSP9y2oiDVx5P8rdMi06A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740517760; c=relaxed/simple;
	bh=WC4wZMjvccSprhFHnDMHW1RQddXS3vti/2BUWCP/vm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GIQOZDyCNfTygUL0FlW1Hl5kUksM6TRC5IWlbOGBxOcxeR8it5lJ1v3xonshqAICtoTkAZBD8/zIza62xjbwqQimC7GA16yBUBKwvpZAymfNWxUDooGgzeiFhZAq7PxU+uviUHVd7wcRKVxZ15/leLunyBxiRwcfjzCx1uRUEgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=bhgO745J; arc=pass smtp.client-ip=23.83.223.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="bhgO745J"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id A19852C1795;
	Tue, 25 Feb 2025 21:09:12 +0000 (UTC)
Received: from pdx1-sub0-mail-a218.dreamhost.com (100-102-124-192.trex-nlb.outbound.svc.cluster.local [100.102.124.192])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 3AA772C1339;
	Tue, 25 Feb 2025 21:09:12 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1740517752; a=rsa-sha256;
	cv=none;
	b=DUZKRw01ddZFkpwj8bWcfISZLnrXjczkC/X8JqJaZ0yFvwFb1j+3U/7MlcizOKPweFIHzU
	s4uovuTVOA0fsJaIecdBM8XKk4OSD1mOw2H226+cHp+sNcUJGuCUOFU00Au5pYnopMrL1C
	5uxPndQvdMbMfWvYJ21Keqmpguv99AfWYlrd0WGl91eGKbsopvTCNUQgz73Zluep6S+0sE
	2+8WBlNzHRVDlbx7Jmd1eG/JEjqQYjorpNl5o6c6IcUkRBtGV/eEKfoH2KO3ZKNYqFopdt
	CgiRlRwH2z/lhH+vxu7k8C3iC91Y30e9D87Wdl6iwU/I3BteFgyfZnNeOEpf3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1740517752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=WC4wZMjvccSprhFHnDMHW1RQddXS3vti/2BUWCP/vm8=;
	b=Edajc+fyJZJMlIp1lnw4gPWIMF85vGyTFnKMa+oT3aQW0JjCDmTYlR/AKcK07eekGhtsiU
	SEUyNcWZ7JnyKuldx8OVqZ0OutH6GcauUfTh3hLXdJl4mSk8mFba7dEhfGebIeQRBdbSbV
	/78zIJ6YYXOxBGqCigjWRKvxjett6p0qxwhDatGE0ZDEmN9K5mwL0/weRHLjZ/CcYgIgTW
	AM46g2aOm3UrT/jD0Iu+ZkSKj6skmgs3S4beAmGU93wXcNihP61pudHMKNg+5zAK6jzXMV
	Rqi+r5shgK0dZaesLSpA8EPkhCEOWP0AMibZ7wdwDP3X5E2VXqvjXOBw/lOtlg==
ARC-Authentication-Results: i=1;
	rspamd-6d7cc6b78d-zrpw6;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Power-Inform: 4b42a68a331c34a0_1740517752512_3073116100
X-MC-Loop-Signature: 1740517752512:1963909159
X-MC-Ingress-Time: 1740517752512
Received: from pdx1-sub0-mail-a218.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.102.124.192 (trex/7.0.2);
	Tue, 25 Feb 2025 21:09:12 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a218.dreamhost.com (Postfix) with ESMTPSA id 4Z2VbC3xlCz4g;
	Tue, 25 Feb 2025 13:09:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1740517752;
	bh=WC4wZMjvccSprhFHnDMHW1RQddXS3vti/2BUWCP/vm8=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=bhgO745JZMznxM8aeS7/tHthTbKnC4+dk/AouWFIlpoqlPSrLub5bdkgJm6XuU5Cc
	 OT1XYpotSJ1gxZ3jFiAjFow+DXYkLLVl6DPF6egq5+kURoIecPgx6xgkNE0rSUdQJO
	 mMt4cbttJ/KLofYf05JsPQiLmhtlWK5/uU/CpdpmK0Nl9uHSpsEDpa+mZ2K5ZDaGQ/
	 FNe12L2pwopt+Ea4wQUTom/WajPTJfQ8S6D+d5Ls5ZN66mvAFXVB8DxKCv9k6b3V27
	 cPaR4vlj4htX7jsXspHP+XJD3Vf96kji/XNLy5wXyEgITPNTGq6E4xxGR9xu1WpmnX
	 yFMYwlgD/lW7g==
Date: Tue, 25 Feb 2025 13:09:08 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
	ira.weiny@intel.com, vishal.l.verma@intel.com,
	alison.schofield@intel.com, Jonathan.Cameron@huawei.com,
	jgg@nvidia.com, shiju.jose@huawei.com,
	Li Ming <ming.li@zohomail.com>
Subject: Re: [PATCH v7 01/14] cxl: Enumerate feature commands
Message-ID: <20250225210908.d3leh62kcikm3yi5@offworld>
References: <20250220194438.2281088-1-dave.jiang@intel.com>
 <20250220194438.2281088-2-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250220194438.2281088-2-dave.jiang@intel.com>
User-Agent: NeoMutt/20220429

On Thu, 20 Feb 2025, Dave Jiang wrote:

>Add feature commands enumeration code in order to detect and enumerate
>the 3 feature related commands "get supported features", "get feature",
>and "set feature". The enumeration will help determine whether the driver
>can issue any of the 3 commands to the device.
>
>Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>Reviewed-by: Li Ming <ming.li@zohomail.com>
>Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>Tested-by: Shiju Jose <shiju.jose@huawei.com>
>Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
