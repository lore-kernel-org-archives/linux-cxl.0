Received: from butterfly.aspen.relay.mailchannels.net (butterfly.aspen.relay.mailchannels.net [23.83.221.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413994071F5
	for <linux-cxl@vger.kernel.org>; Sun,  7 Jun 2026 21:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.221.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780868963; cv=none; b=DuPEuX59IEZbxU2sbXzukAEhq4VI5YwNN8XtGhH2nLz6g+30UosTBWclF6Yf30PCRQa9eh1ZZ10T9uJlGSW5cTzCXEFw3v46PytRKDIX3wgzkDgMYqlgWU1fGZlb1UXfg6O4cl6G4CS+6fQaF+r+I2+DNcXToT2ha/rAsrDjC24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780868963; c=relaxed/simple;
	bh=eZ2xLjyqidwT+dAzJnaQRROoZ67YTAzkQbJeIp6PVVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U6VbEPjd3grblo7av1EbnyO60Rt5sDctom+FvZxzGvw7Ax+JAVj3KBrcoYKU/4w5Hin5Y4ZLkiyrgU7GY4aumhpLgjud3PAOmy/TKPjdlJYZ4mfKZWBP734DER7xh43tQh/xlM8/RosgryDhxVNl5xqARA2V8XJv9U4CL6pSJRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=DMqxg3K4; arc=none smtp.client-ip=23.83.221.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="DMqxg3K4"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 8CB5241139;
	Sun, 07 Jun 2026 21:13:18 +0000 (UTC)
Received: from pdx1-sub0-mail-a251.dreamhost.com (trex-green-3.trex.outbound.svc.cluster.local [100.114.214.242])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 4239941A85;
	Sun, 07 Jun 2026 21:13:16 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Junk
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Tart-Average: 63738728761c6fde_1780866798465_2497135080
X-MC-Loop-Signature: 1780866798464:2098169700
X-MC-Ingress-Time: 1780866798464
Received: from pdx1-sub0-mail-a251.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.114.214.242 (trex/7.1.5);
	Sun, 07 Jun 2026 21:13:18 +0000
Received: from offworld (unknown [172.56.180.160])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a251.dreamhost.com (Postfix) with ESMTPSA id 4gYSZL43wfz105C;
	Sun,  7 Jun 2026 14:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1780866796;
	bh=VgS4HHHUlydDvT5zaoC60e2DvAPSe/JTite81U6ZiSs=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=DMqxg3K4cwg32X25e/rWKykxr91lZKiOXjGix7eQASQllJDx8aJm4hJ42aG2eW09f
	 HKIQP5RjGOSeoWFfUec0oX0QLC1nR5yqD8EyVFfMyQgfsO8YTuxW+dLvOFmSGkh8Mw
	 ifcZFL6Wlb8l0YusK7p/yPPXKeLJyOD/ugCdTldT+QDVSBVGl33ocUEGWNs51FnArV
	 ttt3qABQQ45eJhNQ9NI3oLwUvwNxrP7Gw7D2rzaNqheUxr2i61WyTtMtG/LuKB5DQ9
	 uEUoxWYABWiWbXrvjnnfBHAfq5FKEcPBm8Pt5UifvV5tXqc4cEXga6Dh7t5y/u4aOA
	 OXXOmwapSsUcg==
Date: Sun, 7 Jun 2026 14:13:08 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Richard Cheng <icheng@nvidia.com>
Cc: sashiko-reviews@lists.linux.dev, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 2/5] cxl/pci: Add BI topology enable/disable
Message-ID: <20260607211308.boymh6ahlbjlfb7p@offworld>
References: <20260605003329.2584012-3-dave@stgolabs.net>
 <20260605012940.1A1EC1F00898@smtp.kernel.org>
 <aiIwmkvqVGb-Tdvw@MWDK4CY14F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aiIwmkvqVGb-Tdvw@MWDK4CY14F>
User-Agent: NeoMutt/20220429

On Fri, 05 Jun 2026, Richard Cheng wrote:

>On Fri, Jun 05, 2026 at 01:29:39AM +0800, sashiko-bot@kernel.org wrote:
>> > +static unsigned long __cxl_bi_get_timeout_us(struct device *dev,
>> > +					     unsigned int scale,
>> > +					     unsigned int base)
>> > +{
>> > +	static const unsigned long scale_tbl[] = {
>> > +		1, 10, 100, 1000, 10000, 100000, 1000000, 10000000,
>> > +	};
>> > +
>> > +	if (scale >= ARRAY_SIZE(scale_tbl)) {
>> > +		dev_dbg(dev, "Invalid BI commit timeout scale: %u\n", scale);
>> > +		return CXL_BI_COMMIT_MAXTMO_US;
>> > +	}
>> > +
>> > +	return scale_tbl[scale] * base;
>> > +}
>>
>> [Severity: High]
>> If the hardware provides a base of 0, could this return a 0 timeout?
>>
>
>Yes, if base is 0, "readx_poll_timeout()" will never timeout
>and thus hang there forever.
>"tmo_us = min(5s, 0)" will result in 0, making tmo_us == 0

Hmm yeah, I guess we could just return the max tmo (5secs) here,
and still attempt the commit even upon bogus hw/fw, similar to
the scale check (albeit this is the opposite hw issue).

Thanks,
Davidlohr
