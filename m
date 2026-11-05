Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.83.223.168
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793895168;
	b=VRrrRD4wvrEuheLRfTJppSasgpAZv/5T0zIJK8qU+EAMCr933AXv6ogetJz68nydMahd
	 ls2z7JPtZaqDjsxWgxpzAFJCQhu18If6zPA9hkNp5G/xSscKI46C4nTAthHoVRgDhVVYL
	 WrB35r0RpngiZl4+KmBWAU5+6mD4YGaHJ2jlfDfqZ1esAH+xwnP8nADstmFql+mRQajqZ
	 Fx5bHt0tsU+1GmFmCgQrft+8q21mSGBJF2Yq92woQJnd/ApQjqqd9Hn2ApfG45j/4wpFT
	 ezjNPjeSKG820HvzutJ1bRY8IKga49R+q9eGeKsiGYjDYZ0nyBT5g84YKYBclIZ2KrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793895168;
	h=DMARC-Filter:X-Sender-Id:Received:Received:X-Sender-Id:X-MC-Relay:
	 X-MailChannels-SenderId:X-MailChannels-Auth-Id:X-Keen-Troubled:
	 X-MC-Loop-Signature:X-MC-Ingress-Time:Received:Received:
	 DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=PT8JmtgQaKxIiSRjpFS7WyOErWx7tIUinsH0pzURzzk=;
	b=OBEa8tVQpEoYWZI8kA3ZE4E6kPdQYvL2S58BZY3rqhltRac0Gtrn+hWUyNBLrXf9GwBz
	 h2Obe4sT6hWMPAS0epSrk+bHkeg4+ajIkOSr/Al2r3a4lj76Pj4JJYe8h7MYgqgCrTwzh
	 utJ2OLOFU4sqDIfqk8FSCdnEBxqp5KIp6wWwcpBcV/Jxli8zIKArdqenjjm6MdEYYEz4T
	 vv9xoMtPMgaI1qPSl6Mzb8VoEYxosPVCGr62UX5cLcI4Ilrp3gVY0gR4j8M6cHj793u4D
	 ROiHk2xPgEoD1wwUGtx2KBqknA9GSu0pHad1FRdJ10nLnesGQdr/vHON8fizSWPnHlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=stgolabs.net;
	spf=fail smtp.mailfrom=stgolabs.net;
	dkim=pass header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b=nge6Jc4q;
	arc=none smtp.remote-ip=23.83.223.168
Received: from slateblue.cherry.relay.mailchannels.net (slateblue.cherry.relay.mailchannels.net [23.83.223.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993FF606A326;
	Thu,  5 Nov 2026 16:12:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 993FF606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b=nge6Jc4q
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 3BCCE4E3ED0;
	Thu, 05 Nov 2026 16:12:41 +0000 (UTC)
Received: from pdx1-sub0-mail-a213.dreamhost.com (trex-green-9.trex.outbound.svc.cluster.local [100.99.173.10])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id DDF594E3ED8;
	Thu, 05 Nov 2026 16:12:36 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Keen-Troubled: 503ee652723f8280_1793895161089_3656331162
X-MC-Loop-Signature: 1793895161089:3356026341
X-MC-Ingress-Time: 1793895161089
Received: from pdx1-sub0-mail-a213.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.173.10 (trex/8.0.2);
	Thu, 05 Nov 2026 16:12:41 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a213.dreamhost.com (Postfix) with ESMTPSA id 4jL6lm2qkGz2x;
	Thu,  5 Nov 2026 08:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1793895156;
	bh=PT8JmtgQaKxIiSRjpFS7WyOErWx7tIUinsH0pzURzzk=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=nge6Jc4q08MYRODpRPnqjsfmc9OW0+cgozTB39bqn+t8tGN6aM4ksfNAAHTwFjrVa
	 YFwOTuTJk1dSMDptcfHfJEz59Ry4erj3/lCm8UuYL7AgLFfHn6pxxwFx60zQN2PWjT
	 KLZcCQvS7FyhM1QK9TjvfZeVTnHLuywDUJGdfkYF2YHhhixBFmVuFV+xCQ+iBW0t5w
	 mXorbY+m3TNs7O5zVQ/oNKAVxlD+QKnw/JLCGmnZJ4mzVC5xaYI9VzADVEHO0G4O2m
	 DPBSMsOvHxg12RT5ZaLpBWV9qng4pwJRBR7EWqSPVlJ0frq/0yNPdmMr9N82ewl4Oi
	 /u2/p/xkuopQg==
Date: Thu, 5 Nov 2026 08:12:32 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ben Cheatham <benjamin.cheatham@amd.com>
Subject: Re: [PATCH] MAINTAINERS: Add CXL reviewer Ben Cheatham
Message-ID: <20261105161232.6dyfjszlsk6h2sbh@offworld>
References: <20261104175003.297974-1-dave.jiang@intel.com>
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
In-Reply-To: <20261104175003.297974-1-dave.jiang@intel.com>
User-Agent: NeoMutt/20220429

On Wed, 04 Nov 2026, Dave Jiang wrote:

>Adding Ben as a reviewer for the CXL subsystem.
>
>Cc: Davidlohr Bueso <dave@stgolabs.net>
>Cc: Jonathan Cameron <jic23@kernel.org>
>Cc: Alison Schofield <alison.schofield@intel.com>
>Cc: Vishal Verma <vishal.l.verma@intel.com>
>Cc: Ben Cheatham <benjamin.cheatham@amd.com>
>Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Acked-by: Davidlohr Bueso <dave@stgolabs.net>

>---
> MAINTAINERS | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/MAINTAINERS b/MAINTAINERS
>index 2a955a626784..edaf70961cba 100644
>--- a/MAINTAINERS
>+++ b/MAINTAINERS
>@@ -6729,6 +6729,7 @@ M:	Vishal Verma <vishal.l.verma@intel.com>
> R:	Ira Weiny <iweiny@kernel.org>
> R:	Li Ming <ming.li@zohomail.com>
> R:	Richard Cheng <icheng@nvidia.com>
>+R:	Ben Cheatham <benjamin.cheatham@amd.com>
> L:	linux-cxl@vger.kernel.org
> S:	Maintained
> F:	Documentation/driver-api/cxl
>
>base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
>prerequisite-patch-id: 57bdcea37c2a480531ec5d1022422748e462077a
>-- 
>2.54.0
>
