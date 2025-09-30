Received: from iguana.tulip.relay.mailchannels.net (iguana.tulip.relay.mailchannels.net [23.83.218.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A04928DB3;
	Tue, 30 Sep 2025 01:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.253
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759196779; cv=pass; b=pZoYm/r3PvycgsOjg0TfUFL+hG0fTjr5m0DjSWhpa4v9gDLB6ZgELGcxoah46zKaeYLxhrxuiN5EjwlyZtSdB6IZNazUaPtZLxJuCAmi0FLl15okSW39Bo3jxxQ5yjN7z6meXQtKQ9f2PE1x3IwSuVuvStZszWgix+MKf2Cu49s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759196779; c=relaxed/simple;
	bh=K1SaJ03Zb+0zIH6YPGJompoGTfD5QRCxCAXXUnMfn44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cp+KaFc8WfsSXxUL69o+Gx/BPCx/gFW57L7XxdQUx1+HzkCioJWJXdbOqqZGYcxjcdQfnii9xoLlhGrnPgbD0Hgf/jurQKSlDag805gVdro3wgM5GbFsgv38wacCduCs1JsRawDLLE6Gv2BSEy2MIgGg+KibV/KrZek3nkoHK3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=YvqBTMWL; arc=pass smtp.client-ip=23.83.218.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="YvqBTMWL"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id CE049861EE6;
	Tue, 30 Sep 2025 00:50:57 +0000 (UTC)
Received: from pdx1-sub0-mail-a277.dreamhost.com (100-111-81-141.trex-nlb.outbound.svc.cluster.local [100.111.81.141])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 63782861DA9;
	Tue, 30 Sep 2025 00:50:57 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1759193457; a=rsa-sha256;
	cv=none;
	b=UEJETx/+P22Z6XuwSXgjKjxfF4LDcSUYnf+yLqTPxrvRhyaWlcLXUGKLRtMA0ZRRRv1L43
	jIliJjDaowG/WqrU9OBJk/QTItegbItdOaBNRBRXnzMH78xEfRVCPvsBdyHGBFIMw6KawW
	A2P1oGMijOxOr5WRjLLT2HRuXXIdA+NkWbhtz8+z4ODvlh2ZndDA7AIbz0nHKDd+NvdxBr
	XJMOXk962WDsQ6dp/4dRttAbgTtaTeDxvcbgTNgld42zrO4d99H+iwXPHKP/PjCF7Rmr/d
	0ecLRE7D9KkXhx/Iiic9OBKU96XBe2ur5LSiKWKRPOC6bG2F84TWe23BnJHF1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1759193457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=GD6dCCvB0quMOwLUDjOSNb+cbivTPxA7Oze4KxmHZ1c=;
	b=9iG5HNH6JRvDX4WBa3RvDlCw6crX3Tlh12dHsJWLqcxIafLn/av1xtC2aNoe24KpnZJPhF
	s8T4IfaxkPVfOUG3bXs/GuGPj7JjtlvEKSR2OoEq3aiUNzHDIdXmFjPCnYZ8Lq68v6x6XI
	EnLzvl63MXj81i90xorHhJt5wssrYe+bEOC3vB4H63by8Cdi/dKGHhuk3ZGMCQSnWZ4kuZ
	vgtsjOSFf9E6/LIBqnieE9vTA7GsTv14jD88AWosqfgOMPF5MFYChFz04zV1qAsYLZXFep
	1av5UnzkytIEZv4hEjRpfDwSIk6hjsc4KAElB7iyVi//uZPoyZ4E6YU9t4wrYw==
ARC-Authentication-Results: i=1;
	rspamd-867694b6c6-kkwjg;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Glossy-Plucky: 3394838c4c0e2391_1759193457678_3012880551
X-MC-Loop-Signature: 1759193457678:1454249302
X-MC-Ingress-Time: 1759193457677
Received: from pdx1-sub0-mail-a277.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.111.81.141 (trex/7.1.3);
	Tue, 30 Sep 2025 00:50:57 +0000
Received: from offworld (syn-076-167-199-067.res.spectrum.com [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a277.dreamhost.com (Postfix) with ESMTPSA id 4cbKHN4ZbDzC9;
	Mon, 29 Sep 2025 17:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1759193457;
	bh=GD6dCCvB0quMOwLUDjOSNb+cbivTPxA7Oze4KxmHZ1c=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=YvqBTMWL2Cqd7UY85PDtZzSKWJZnhLFw2gFmxstsEjvnN/hNsXbQVJ7NfkEyIASbf
	 FmnEWZ3HBIcDBq5Qxq0QwTpHAzA/oW5p8uZEC94o8FvYDhNJJkWuPVAf1OZS+Pknoo
	 dobg3ho/LjhSgVWMyYk4uXXzP9NlfctRV/QMnkdlPXkqaLpr597jl3hgIJ6C9N/OXF
	 F+TKRDf8obyTGkn7EPiqY61hxgsA22L7oRiYoQaRN7XYUWVsSCt2Q3qaS/TKg5T/mF
	 43rdlL2WURCRoJSEjLpECYgIkmjLyUrr+uSBkmkkU7H+7++L3yMxx9/8CWmkWNIvf8
	 yT+uXb5XXOArA==
Date: Mon, 29 Sep 2025 17:50:53 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Li Ming <ming.li@zohomail.com>
Cc: jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com,
	shiju.jose@huawei.com, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] cxl/port: Avoid missing port component registers
 setup
Message-ID: <20250930005053.2jme7stunhrmp3om@offworld>
References: <20250928101433.424778-1-ming.li@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250928101433.424778-1-ming.li@zohomail.com>
User-Agent: NeoMutt/20220429

On Sun, 28 Sep 2025, Li Ming wrote:

>port->nr_dports is used to represent how many dports added to the cxl
>port, it will increase in add_dport() when a new dport is being added to
>the cxl port, but it will not be reduced when a dport is removed from
>the cxl port.
>
>Currently, when the first dport is added to a cxl port, it will trigger
>component registers setup on the cxl port, the implementation is using
>port->nr_dports to confirm if the dport is the first dport.
>
>A corner case here is that adding dport could fail after port->nr_dports
>updating and before checking port->nr_dports for component registers
>setup. If the failure happens during the first dport attaching, it will
>cause that CXL subsystem has not chance to execute component registers
>setup for the cxl port. the failure flow like below:
>
>port->nr_dports = 0
>dport 1 adding to the port:
>	add_dport()	# port->nr_dports: 1
>	failed on devm_add_action_or_reset() or sysfs_create_link()
>	return error	# port->nr_dports: 1
>dport 2 adding to the port:
>	add_dport()	# port->nr_dports: 2
>	no failure
>	skip component registers setup because of port->nr_dports is 2
>
>The solution here is that moving component registers setup closer to
>add_dport(), so if add_dport() is executed correctly for the first
>dport, component registers setup on the port will be executed
>immediately after that.

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
