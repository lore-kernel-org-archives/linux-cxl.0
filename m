Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.83.222.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795809955;
	b=oe6XT5h+A+XY7+LL7Xu1fm/07CgZyKq/2VVHHuDsSMJCb5917tneYr9Tgdd0ey89/Lvc
	 0/rc5dedyO/n/x5YB1enbdZr4ylopZwcpOzRHdzHvJ/pA5/HoK+kmiN7L9AxP6zIULbuP
	 6Kyr24T1LaDCk0165OWSAng11UjBg3WdbrL+EbN7+fEB3mVjrdU7fI6SoIXZSdU5Wdarf
	 YRR1KN+xpqqZVSZHLwK1R9UHUix6MLBQ+NoxJLn2C3mWkdR+Iwq4VhIsZ/rlftLiX9Lhf
	 d4cNKS9790vJhYz2bK1bSIhOnOB4vuoFq3JjDVEpjDmY2iXMYoq+G+UQ1diAG++rJqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795809955;
	h=DMARC-Filter:X-Sender-Id:Received:Received:X-Sender-Id:X-MC-Relay:
	 X-MailChannels-SenderId:X-MailChannels-Auth-Id:X-Cooperative-Shoe:
	 X-MC-Loop-Signature:X-MC-Ingress-Time:Received:Received:
	 DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=NZgqBdHSpB1ye7VkOrl9fo6d12s/C9J98ct8CiwoAPA=;
	b=Tkb525r9vUb/sHCW4V0g4LzP0QGmHVSyRVfuDPa+hSlNWFok1LQ7c96fb2mzAgccEp5G
	 7xkjN3pqVymUvJOH8oiDAn4zNGFuJgqXmsbwzkoRWa9rGoq4cI2AANG+skjz0+U1XMVLT
	 QvycFwE/Ra1YDbMmW0fgHDG4Z3LpEMo6B9FRHQSa55mNFqAj0WdvX4DhF/7LNCLWbWEe8
	 DqSn0n4ZYn0Hn9c+nFhejgaeiOoiEusXtJVl4otIWlFXoRy1N/DWorsMoWudIY6DwR3A+
	 dP2I6EXb2mDj+mo7RjXMh6U07xeEBVG4FQQivuhq/tVG0CgaERMCZOEIwEsy7ZALiQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=stgolabs.net;
	spf=fail smtp.mailfrom=stgolabs.net;
	dkim=pass header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b=N0bUbHTA;
	arc=none smtp.remote-ip=23.83.222.55
Received: from eastern.ash.relay.mailchannels.net (eastern.ash.relay.mailchannels.net [23.83.222.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DF0606A31C
	for <linux-cxl@vger.kernel.org>; Fri, 27 Nov 2026 20:05:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47DF0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b=N0bUbHTA
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 866284029CC;
	Fri, 27 Nov 2026 20:05:48 +0000 (UTC)
Received: from pdx1-sub0-mail-a223.dreamhost.com (100-96-3-135.trex-nlb.outbound.svc.cluster.local [100.96.3.135])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 1F1A2402493;
	Fri, 27 Nov 2026 20:05:48 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Cooperative-Shoe: 4a80ae0363edd5bc_1795809948325_44521051
X-MC-Loop-Signature: 1795809948325:2497550653
X-MC-Ingress-Time: 1795809948324
Received: from pdx1-sub0-mail-a223.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.3.135 (trex/8.0.2);
	Fri, 27 Nov 2026 20:05:48 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a223.dreamhost.com (Postfix) with ESMTPSA id 4jbktg1cBqz1q;
	Fri, 27 Nov 2026 12:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1795809947;
	bh=NZgqBdHSpB1ye7VkOrl9fo6d12s/C9J98ct8CiwoAPA=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=N0bUbHTA7njMYZO9puw8cV2UJH8ACCnIrc5GacO1D4eR+HcYxcW8b8+4WRLeI+ng3
	 24lG6nWCstEEUEOIm35NKYlccLIa9qk07QlfEgdoFiscANIX0HwMVeXgPIq0WQ6vN+
	 Lc7nfpCl/105erDdu/9UtaQRAiiJ9AvXShMtFHrSAgpoVVlYCBdUo0uBQ9IbxIr+vn
	 JhZ5RbMwgquW/j1DXaLi5+/nhjNG92ZJjSDKGITt4fufDRZJucjhM4EulGIXm8TEt6
	 vB/wiygf8lmE8KZSSI00EZ6L388SbTj1bAF6WYMGfQIR5IIWd9P71JnpzdI33PTf2/
	 GEJkSbTdTCdYQ==
Date: Fri, 27 Nov 2026 12:05:44 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: Unsung Lee <unsung0317@gmail.com>
Cc: linux-cxl@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>, Dan Williams <djbw@kernel.org>,
	John Groves <jgroves@micron.com>
Subject: Re: [RFC PATCH 3/4] cxl/memdev: Add firmware_activate to activate
 firmware without a reset
Message-ID: <20261127200544.nzz2kbxcwuns5zv6@offworld>
References: <20261125124358.3583223-1-unsung0317@gmail.com>
 <20261125124358.3583223-4-unsung0317@gmail.com>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261125124358.3583223-4-unsung0317@gmail.com>
User-Agent: NeoMutt/20220429

On Wed, 25 Nov 2026, Unsung Lee wrote:

>+What:		/sys/bus/cxl/devices/memX/firmware_activate
>+Date:		November, 2026
>+KernelVersion:	v7.6
>+Contact:	linux-cxl@vger.kernel.org
>+Description:
>+		(WO) Write a firmware slot number to activate the firmware in
>+		that slot now, without a reset ("online" activation in the
>+		Activate FW command). Firmware uploaded through
>+		/sys/class/firmware/memX/ is set up for activation on the next
>+		cold reset; this attribute lets userspace switch to it earlier.
>+		Like sanitize, this requires the device to be disabled, that
>+		is, not actively decoding any HPA ranges, so the caller has to
>+		take its memory offline and destroy its regions first. The
>+		write fails with EOPNOTSUPP if the device does not support
>+		online activation, EINVAL for an invalid or already active
>+		slot, and EBUSY if the device is decoding memory, a firmware
>+		upload or a sanitize is in progress, or a different slot is set
>+		up for activation on the next cold reset. Only the decoders of
>+		this host are checked. If the device fails the command, the
>+		write fails with the error of the mailbox command: ENXIO for
>+		most device errors, including a device still busy with an
>+		earlier activation, or ETIMEDOUT if the command does not
>+		complete in time. While the device activates, committing a
>+		region on it fails with EBUSY. If the command times out, the
>+		device may still be activating. Until a later write finds the
>+		slot running or an activation succeeds, committing a region
>+		still fails with EBUSY, a firmware upload fails with the error
>+		device-busy, and sanitize and secure erase fail with EBUSY. If
>+		the device ends up keeping its old firmware, this lasts until
>+		cxl_pci is bound again; firmware can be uploaded again after
>+		that. If the device still reports another slot set up for
>+		activation on the next cold reset after the online activation,
>+		a warning is logged. The firmware_version attribute is read
>+		once at probe and is not updated by an online activation; the
>+		version of each slot is available from the Get FW Info command.
>+		If this file is not present, the device does not support
>+		firmware update.

EWAYTOOLONG ... please less specific details about return codes and comparisons
with with other ABI files.

Thanks,
Davidlohr
