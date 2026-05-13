Received: from poodle.tulip.relay.mailchannels.net (poodle.tulip.relay.mailchannels.net [23.83.218.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCB31519B4
	for <linux-cxl@vger.kernel.org>; Wed, 13 May 2026 00:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.249
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778632455; cv=pass; b=ETRalsc/fQ0WK687QqSeWWF+mrTHcMv8JVTIp0cR1k0cfv7tLT+w9dpc9+fYfScPgWs2e6tf0R9CUQgLc1rk5IZgOT4X/rDh7crMWifaVAXm2q5g6LvmGdlEYNqh0Gm3qzyl54byel3BkNAXjNRVOF+MnuivFMrCzQ3C5oV+K0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778632455; c=relaxed/simple;
	bh=nAplhqEB03M8z5WeYXfcV9H8bvRvHi4I1WCm7ROyOrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YG9F6H0XG56gPSJxOUTH1qjNhsTWKeeMnH5lT7ZFx5Sh/LgMwUX3hCUbURC/T0HT4/L0uF2abullDotLSoIUUGsDP/e3Ma0SxQZ3p7E6MaE1mBa6vcqsVeBFDIbetOInSHThO6S4gzq7/IQhcxrrZYm7znu2bAUkblG6c6EZ6hY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=apXsbHrY; arc=pass smtp.client-ip=23.83.218.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="apXsbHrY"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id F3FF24C09B8;
	Wed, 13 May 2026 00:34:07 +0000 (UTC)
Received: from pdx1-sub0-mail-a207.dreamhost.com (trex-green-5.trex.outbound.svc.cluster.local [100.104.5.234])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 9B9264C08EF;
	Wed, 13 May 2026 00:34:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1778632447;
	b=m3pP2qzFco+SnO4SgO0cXaVqx5NlQE1Pg/2KnNVBDCQDv5ljWxiAk6EC99ICdqqLcZ3dr3
	uiySdjjN3BJlj/FKtpcjduXeE+EP7K6H9YWh47UvrNij6qaX5GwYE0HuQdC8FKTLU1i/SY
	g3v+QIY6t1/xspXJuMxiZzPE9sB9e7ZdPYd91YczZaw++Ikhv8w1Qy53rW8SwyL7dnXBCB
	nepCfquk40tWT9EOakdKurbfUCt6WeTKJDHk6A2rnk7reLMn0/4vhLvw2wiO7Az5CIqlig
	hqQBo6W8a3nSgXueJKkggheeL11u1zqatREHbPM4ysKgW9/zvFkyCvZC91YcDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1778632447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=nAplhqEB03M8z5WeYXfcV9H8bvRvHi4I1WCm7ROyOrw=;
	b=NgdGjP4Zdvm3wBbkMj39L65xCgZaftSgC7DjYz8WFG9WU5VS6N02Oi0SvJ9JStHx+DT3zY
	flbe8JTemi0K2lWveCYPb3eRo0Pqg24DvKoe3PxZXhCLxTBKpdYTWmJqpge/7FXGeI05wi
	SOc3MYqrMdsvxg4kBn8hTiRgm2Yb+WhytJSi0e3T6VsYyOj1IFeaBSMepwMJXTGzrIjLKx
	HWtMyWJ4wEyIWoBtp73BGdORM4vycxC8PERYlWst/8yBpZV9TdT1PytjwIljVKjlam7v/5
	GR8YqMp6jGBjWa+AYcRJfLPfa1QURSViktm5WxYsZKVFE43xQwTBwQNWdiTrxA==
ARC-Authentication-Results: i=1;
	rspamd-79cfc4d687-xnhbx;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Abiding-Quick: 3d384c7770715bd8_1778632447907_512055836
X-MC-Loop-Signature: 1778632447907:2744399259
X-MC-Ingress-Time: 1778632447907
Received: from pdx1-sub0-mail-a207.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.104.5.234 (trex/7.1.5);
	Wed, 13 May 2026 00:34:07 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a207.dreamhost.com (Postfix) with ESMTPSA id 4gFZG70Jlzz2Y;
	Tue, 12 May 2026 17:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1778632447;
	bh=nAplhqEB03M8z5WeYXfcV9H8bvRvHi4I1WCm7ROyOrw=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=apXsbHrY3qwiR+V4u+49g+qbd8rWV+wynkcej2VbP6QaRxxM0ZOwLSP9cxdK97Jkh
	 NguT60xSwILh7kHsON8s2UJK51OfgbrS6u9+MpLTNtDXa0qTScyTr8H3lVZOeP30Li
	 Yj58w6NDDddjOAPYSdJX762qCr6Y61pd37aFodqU1+VqllvUH7UiR26dZ0yIYGeylN
	 ikjCLQfrEe+cXW2RjU7ZLk781N0M76YBnKzCS7fEb9UTHRVJGtHGKf6ZwkPSUqpZpx
	 9i22mikw3fTKijuh6ZaNp+GdM2IA/jLXK4cGpB3FbX9buyDnzmVwiFnPJhsc1QeCcV
	 3YGnWYQOiuhvg==
Date: Tue, 12 May 2026 17:34:04 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: dave.jiang@intel.com, dan.j.williams@intel.com,
	alison.schofield@intel.com, ira.weiny@intel.com, gourry@gourry.net,
	dongjoo.seo1@samsung.com, anisa.su@samsung.com,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH 2/6] cxl: Add BI register probing and port initialization
Message-ID: <20260513003404.fjzxfuxosa7j37d5@offworld>
References: <20260315202741.3264295-1-dave@stgolabs.net>
 <20260315202741.3264295-3-dave@stgolabs.net>
 <20260320154646.00002d4a@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260320154646.00002d4a@huawei.com>
User-Agent: NeoMutt/20220429

On Fri, 20 Mar 2026, Jonathan Cameron wrote:

>On Sun, 15 Mar 2026 13:27:37 -0700
>Davidlohr Bueso <dave@stgolabs.net> wrote:
>
>> Add register probing for BI Route Table and BI Decoder capability
>> structures in cxl_probe_component_regs(), and initialize BI registers
>> during port probe for both switch ports and endpoint ports.
>>
>> For switch ports, map BI Decoder registers on downstream ports and
>> BI Route Table registers on upstream ports. For endpoint ports, map
>> the BI Decoder registers directly into the port's register block.
>>
>> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
>
>Various minor things in here. Biggest one is whether we can use port->regs
>for the switch upstream port registers.

Yes I have reworked a v2 just using port->regs and simplified a lot of
the init code.

Thanks,
Davidlohr
