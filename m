Received: from dwarf.ash.relay.mailchannels.net (dwarf.ash.relay.mailchannels.net [23.83.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE583168F6
	for <linux-cxl@vger.kernel.org>; Tue, 17 Feb 2026 22:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.222.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771367117; cv=pass; b=u3cGKjLdP4SlfLx1H2YTjVH/diyukhRODDqBvsPYF8emoxe9Kz+UvI2ftbwYsGsuSqpj7Fk1oD61SzJZBKB6sBKFN8ay+iElNTkfhGZbxFQwpMtWXZ4O6sSOTeF/AxrCct3/mgDXZ+TgIHaJgiReXx8oS6+ILFvviIeHtvxeCeg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771367117; c=relaxed/simple;
	bh=hwzXTERe/Gz1NXM88vOPhJzyPyJWCimzaD/H2X3aTKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T/ikoo4F5ihQP6JJVJdYWQ8j/6U51SfdC81GAt6QvRilHrHqniuP+kzFUIkLHrS6YEDSo5BWePQMZJDqTsVIRkY7fBgDqqIK7x6C4cO9SaPo8KyJtGzeQuLidfU+DizkdmgEbRy1cVpzyrMw9O2wz9Lx39k+k+JSmnXT59ykEOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=SmzHFiX9; arc=pass smtp.client-ip=23.83.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="SmzHFiX9"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 11D3D7E0A34;
	Tue, 17 Feb 2026 22:25:09 +0000 (UTC)
Received: from pdx1-sub0-mail-a249.dreamhost.com (100-97-23-78.trex-nlb.outbound.svc.cluster.local [100.97.23.78])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id AAAF87E150B;
	Tue, 17 Feb 2026 22:25:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1771367108;
	b=lGbEuGmzb0Wh+/r23hFeHvKkzsGnH21O37pM5UR5teXIM4UY5VuMEotr/ETa/dafrLgvfX
	5UGEVPsi6JEjbEFYeRIL6JofFzyTWAuVe+1sBeG6d75pQRdcD+nJu04LWUD4im0om0R/jH
	cIP/lxATqJrkxYC0FfyZBb/qhGoNoSxsupCaqp9bLH5JORg38SUvhgSvyWtozZNTEsOYTJ
	ikCXjWti+Kiy1N8xnGu7MSr1ocjPceZwvhZVDGueEdhi62vFmolihMYSCfCYjygXFaW/p5
	QYlOHlvqFWnl81VONFVB5w1Exr/Kpc6DQ+RvHSqQP17YArHAEwqBge2eQJiF2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1771367108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=hwzXTERe/Gz1NXM88vOPhJzyPyJWCimzaD/H2X3aTKQ=;
	b=ACzSV3VEIf609YwmjJt6DzE64Stu0HUQzqay5fgpjuRA8Blxd9UobeU8/TlBKUDyxdeMxS
	ZWDIC7QFHC6XBRV9V35RQeImvDgtjla9VtzPCVZEg3tUK0fch1mdngk5yc1riNiEOt/ACv
	+cyzAQbNhYdfJ4I3JGvrQd45PF1hmd+PfCWl8/WxGYV7KzCbdqGktv3y/MIz/TcOyWdMIl
	6/MwmlgHHFPcgc64t1x9SqeTqOaN8psnz0iJ6MdbRigN1eDB+3XeyKOuNhXWmZvOi22O7U
	X2DMZVNlIYDwt/QKbjHe+r/LDXlgrcI5Q69JewQf4M3sEtnwlqxvqvTswvBLQA==
ARC-Authentication-Results: i=1;
	rspamd-659f7bc6cc-q7dr7;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Society-Stretch: 715bfa6e42421df6_1771367108950_2003071276
X-MC-Loop-Signature: 1771367108950:1848218416
X-MC-Ingress-Time: 1771367108950
Received: from pdx1-sub0-mail-a249.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.97.23.78 (trex/7.1.3);
	Tue, 17 Feb 2026 22:25:08 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a249.dreamhost.com (Postfix) with ESMTPSA id 4fFvN415Knz103y;
	Tue, 17 Feb 2026 14:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1771367108;
	bh=hwzXTERe/Gz1NXM88vOPhJzyPyJWCimzaD/H2X3aTKQ=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=SmzHFiX9D09Pef1d6eCvlmL4wZwfBIZuWpE6RJDhkbyfdcEfwvHkhUBPK5HWYGlgs
	 XfVChBiCf8A8cjyrPoMwMPTOz0u0XV4kEywMVoQmdKf3LE7Yq6GzxuwRoFBHQismJd
	 UqmqI/hTbykWmy9PSKlbkcenSf3w8zWdRGhWQO/a2kslk6tKyutzAy7KOyzJ2ibFEL
	 3fdoFekZ2nknxHCIrDuTSFSFYB+32S+wtWQf7BCaKEyB2jfelp9MmcW9wzH1EB4Y9s
	 dqXd3ePAjMEBIENZeyNy/jkdfzGHVrgzK3cxnrswtCcIkGPB9j9UCPIN+paB5xa7hI
	 +G3J72Oymvf9w==
Date: Tue, 17 Feb 2026 14:25:05 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH] cxl: Test decoder flags as bitmasks
Message-ID: <20260217222505.p4wguawtfmdlrokg@offworld>
References: <20260206181404.1025991-1-alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260206181404.1025991-1-alison.schofield@intel.com>
User-Agent: NeoMutt/20220429

On Fri, 06 Feb 2026, Alison Schofield wrote:

>The CXL decoder flags are defined as bitmasks, not bit indices.
>Using test_bit() to check them interprets the mask value as a bit
>index, which is the wrong test.
>
>For CXL_DECODER_F_NORMALIZED_ADDRESSING the test reads beyond the
>flags word, making the flag sometimes appear set and blocking creation
>of CXL region debugfs attributes that support poison operations.
>
>For CXL_DECODER_F_LOCK the test reads beyond the defined bits, causing
>the test to always return false and allowing resets that should have
>been blocked.
>
>Replace test_bit() with a bitmask check.
>
>Found with cxl-test.
>

Nice find. Other than splitting the fixes as suggested by Dave:

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
