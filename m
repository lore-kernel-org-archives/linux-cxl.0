Received: from cornsilk.maple.relay.mailchannels.net (cornsilk.maple.relay.mailchannels.net [23.83.214.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A21C3E47B;
	Wed, 23 Oct 2024 02:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.214.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729650799; cv=pass; b=ScETELDd2H/jRNddrXybFVSHdULlMW4pn+BIHwpZNF3R65qafKxUZ0RF4FYNlPfJDHGjvsEJhcoRXqO4HAa+Vr9Hq6KhtlALVK8VcW+gium2wU7rOFNWHaApyxPrlWktJAmPf2Hjr179HUAM2nYHDgCPelbAclT8F9c4BXXBpyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729650799; c=relaxed/simple;
	bh=5fYAjH5FlAHwtaSvvs3W+zv+PNPWwGY2qt5JII6jlUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JMlbzRy9fxCO8j1Q7kHAs/Sb15u4Ah/QPGkjlT6uQfg4LERfcUsnovQkaPs3YLxPToVpiiJ8edJzvcnMbblorXDIo90DHK2fJJJ42uyso18xIemUZ/qzmQdjQwYeY13qMyunfiCFbM6oKYlKADvAaW4o0EkOjq2C0tMv91qvHuc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=gESraCBN; arc=pass smtp.client-ip=23.83.214.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="gESraCBN"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 282C7A6430;
	Wed, 23 Oct 2024 02:27:40 +0000 (UTC)
Received: from pdx1-sub0-mail-a233.dreamhost.com (trex-8.trex.outbound.svc.cluster.local [100.103.220.31])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id A3FB6A6482;
	Wed, 23 Oct 2024 02:27:39 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1729650459; a=rsa-sha256;
	cv=none;
	b=kOIQuPZxTZIEvOH6Rm1FGhDXdP2CS3cAdtgGlUmw/riuVaQFlpLxPhyVRWwSBrP0blA+b7
	VkK8ROr3IAJv5ZvnHwzIs9/8wXwD6YUnsLi2v27v1dZy+DGYp4f1ugvVaNrfdJlkIUK5yR
	TRWbwiBT0IA4yqBpQ01oxFt9B3rgCe7WSm4jreDFFaZ3oTJLNMVzWdBuHFtd0IY0sEesSu
	BPV/0qAPdCWK+5vMzngkJTGUEts9byzU8F+e5pZMiTt5QCSGxWhUUvAd0h9tthZc5w4laU
	hZ3w3A9EhB8qTOlTKQnG8EZNYlxg0+X/JsKRts7FhJXM8N2oRlEc61ZDc4rkoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1729650459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=5fYAjH5FlAHwtaSvvs3W+zv+PNPWwGY2qt5JII6jlUQ=;
	b=8ul1yl4+Ry8IwIINdayHUSvlRP5q+KboDSS8SQ1OWU6/8crGxiXeW7BHsCn59ixBEwg67D
	hQ3ilEdaLaz6L38nANAcHPVbumn55C6ZUqfKHeELEMsJLMJKWWaqPWv5MgkLLBkty8+qvc
	ym8jFn5JdEivmMeMv+XqRHzjnICwfTgJU7qS92yJmIF6CWJI7w6VmxO7F+XwFM3FD+hDpx
	HPiXNqMQeVilqTmYeEXMKFqet3EwKq8/4FIvKgUbv37nmeXZ29j1fljn2u8L3lsGeOiWlx
	yceMku5MBQH5ATBaCABE+vh4uod69e84msRDH5RQ/gR9YbTrDtcYEnCQaw7VtQ==
ARC-Authentication-Results: i=1;
	rspamd-5bbb596db8-j9c44;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Fumbling-Ski: 4606d8de4e8c482b_1729650459965_3770196926
X-MC-Loop-Signature: 1729650459965:1152177914
X-MC-Ingress-Time: 1729650459965
Received: from pdx1-sub0-mail-a233.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.103.220.31 (trex/7.0.2);
	Wed, 23 Oct 2024 02:27:39 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a233.dreamhost.com (Postfix) with ESMTPSA id 4XYCcp5bVDz2K;
	Tue, 22 Oct 2024 19:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1729650459;
	bh=5fYAjH5FlAHwtaSvvs3W+zv+PNPWwGY2qt5JII6jlUQ=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=gESraCBNlRRONSC7xQQ+LeQNhY1PHVR4RgR0ynVU1gYq7EZHXwkZG060u7HxWNhgI
	 71PtPu8PP8oEHMP7m9Oz7tRJpXMD/6B8xRZXqMPQyJyRKSWoiTrUhCkin0s22Hgj1b
	 tdrN2qS/Tebw9aKPvPUK0U95e2TvkZ8psgBANFJd6XqGgdMwb6qXXgyepPzaq4jyMk
	 OJSH4NccdRNyrVYxzeDvtmBCeOa7s92Ok1uWuRMoLHhCxh1KxXOYD52RvPvH20VbvJ
	 Ixm+avGHNOlikfFrLIPYzz1tIjEKJ0RuWmTfwLJ/3LbJT19kJq5GUv3qu7uUJfqHEu
	 GIQ4Zued201Ew==
Date: Tue, 22 Oct 2024 19:24:54 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: shiju.jose@huawei.com
Cc: dave.jiang@intel.com, dan.j.williams@intel.com, 
	jonathan.cameron@huawei.com, alison.schofield@intel.com, vishal.l.verma@intel.com, 
	ira.weiny@intel.com, linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linuxarm@huawei.com, tanxiaofei@huawei.com, prime.zeng@hisilicon.com
Subject: Re: [PATCH v2 4/6] cxl/events: Update DRAM Event Record to CXL spec
 rev 3.1
Message-ID: <7btps7egaaxz5wguakki3qs6aorv2ujhjgirrkgmdx42rpjqgc@qzzjb7ijb6bh>
References: <20241022105849.1272-1-shiju.jose@huawei.com>
 <20241022105849.1272-5-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241022105849.1272-5-shiju.jose@huawei.com>
User-Agent: NeoMutt/20240425

On Tue, 22 Oct 2024, shiju.jose@huawei.com wrote:\n
>From: Shiju Jose <shiju.jose@huawei.com>
>
>CXL spec 3.1 section 8.2.9.2.1.2 Table 8-46, DRAM Event Record has updated
>with following new fields and new types for Memory Event Type, Transaction
>Type and Validity Flags fields.
>1. Component Identifier
>2. Sub-channel
>3. Advanced Programmable Corrected Memory Error Threshold Event Flags
>4. Corrected Memory Error Count at Event
>5. Memory Event Sub-Type
>
>Update DRAM events record and DRAM trace event for the above spec
>changes. The new fields are inserted in logical places.
>Includes trivial consistency of white space improvements.

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
