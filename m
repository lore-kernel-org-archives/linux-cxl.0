Received: from cross.elm.relay.mailchannels.net (cross.elm.relay.mailchannels.net [23.83.212.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F3B287259
	for <linux-cxl@vger.kernel.org>; Wed, 18 Mar 2026 18:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.212.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773859839; cv=pass; b=l0oTunXktxhLOgAeOwrm+r6eex184aITT+sPFan3bwpb+D/NIULs0oOxrzXjHP0UXDYs8rpLpc3k2GFid7LZvrWC/Gsc5WMd1KiWIByrOGNQQhs80VW76tw1hbwH3elMGUhCjDftCqEiB0QDxuZL2xLc3F6/+nt+UBKLhr59yLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773859839; c=relaxed/simple;
	bh=Z/CRvThUIj01wxUkZVOswhw5IKMyxiphou2284IMlQ4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kZW/4hN0Xs/GEPCeu5YD0GHAlx6Coin+fXFZcwbzAYFDMeWorF14nKW5BSc0bOixVHEqHCRmdF+J0M0PLq2EOB06yg3i7qjuKqaWabtVo3hIXcKdvKj1NJ40AYQ/y9eWk/3BlkNAvYAuiVXk3qTsIb4WWUsDXIb3K8j+aG7UReU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=qn5y0uA/; arc=pass smtp.client-ip=23.83.212.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="qn5y0uA/"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 114CB6C1088;
	Wed, 18 Mar 2026 18:43:04 +0000 (UTC)
Received: from pdx1-sub0-mail-a234.dreamhost.com (100-119-11-147.trex-nlb.outbound.svc.cluster.local [100.119.11.147])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 804206C296C;
	Wed, 18 Mar 2026 18:43:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1773859383;
	b=BFPb69LxxmUxIO7JXfRX8pnf3qUB3OAUoNu/+1WgK27O12TF5Ul+agwuXcxmYtOfIC+iFm
	i6LoRmneZl3SShVGyzirPSZlwUpb00YisY0OoF2P/Y3d9PE08TQKrtMlXeIhEwz1JFj1lI
	siRwpQAiQLzDNDWerm1uHY8sFWJT/ZDDPFmF6javLYToQamf9MR90dS+76PeHkXEqEOM29
	3WEugL0D0fR/3e++x9wywe5t0LCziKfhQnIAl96h2Gz0RQld5QskiHdEFGk187JeRmvxCr
	0TPcG8GCMgkLxOWYxYLZHp9JlbRIooKP9p33LDrdjWSoIiBpDRodHM7OnAyJMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1773859383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=l3hY2N7dSCkpPwJJBTMXp/fhaMGcTJQMcRH8IzI2ikI=;
	b=u6qlwUOj79Kb1G+akK2t2auIrOMrQSqRYzUDWFQivbRR0sdkIN/Ld+DhSjidKYaiNo40lg
	5F4kLm4OrMFoI4xKIDF0b681773XDI87pX+CDvs+xr7toNBVJCLptTTfNh2oiML7R5BoB+
	VFaufbFRm4YVaOdiw14lE6hS6z+K1i3CxujigSYligf5+2j3lToQ4dQIzMmH/lR0P25QuY
	cF8H0M3LhokNwhTdqPqKv6sr366svLm/BEddEc0Qb7d5ZAjKC+2GCP5s5Kza8PYnS/0ydl
	y3xLiI+kPW3yTdLugxiH7wO7HbMrEivnTAsSHyGBo5cBrAX9TlkFyo+fZV2ufA==
ARC-Authentication-Results: i=1;
	rspamd-6d4cb6745-pf456;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Arithmetic-Plucky: 048eeb8f018453ba_1773859383816_2816671567
X-MC-Loop-Signature: 1773859383816:37079076
X-MC-Ingress-Time: 1773859383816
Received: from pdx1-sub0-mail-a234.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.119.11.147 (trex/7.1.5);
	Wed, 18 Mar 2026 18:43:03 +0000
Received: from offworld.lan (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a234.dreamhost.com (Postfix) with ESMTPSA id 4fbd4R0ZFnz1079;
	Wed, 18 Mar 2026 11:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1773859383;
	bh=l3hY2N7dSCkpPwJJBTMXp/fhaMGcTJQMcRH8IzI2ikI=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=qn5y0uA/PwPOEFMcQif5gM1zi/7O3PrE1TwQIHfPACGOc6bPQ/gFhfoxiiXMJYXsL
	 LIGzovLuBsTLhzU6iufaMQ4ULUuVrzTlYRTDa27TkD9F0mgLn9KRS1csdCXR8wwYLv
	 D2lZ4WlonOio1TA+fMP5rYi9BkzDHBfL72+NqFz5/PgZWPjCja1gQdYGGpuSScBDNr
	 KlVdARINAFS47A1WpojIL1vJNPF9j14qF6BkGWVKuAEWXeHqNjZpLLx6e+0G6N0Ll7
	 gpByyou5MpfkDtp6FNqsEssg5H9VV580fNl/zqCC55smIF2pEid/0gPeuC4LcO+6BX
	 f8PjESJkfpceg==
From: Davidlohr Bueso <dave@stgolabs.net>
To: jonathan.cameron@huawei.com
Cc: qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org,
	dave@stgolabs.net
Subject: [PATCH -qemu 0/2] hw/cxl: Media Operation Discovery fixles
Date: Wed, 18 Mar 2026 11:42:54 -0700
Message-Id: <20260318184256.3680349-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

While working on the driver side of this, I tripped on two qemu issues
around discovery semantics. I think this is the first time these code
paths are exercised.

Applies against 'cxl-2026-01-09-draft'.

Thanks!

Davidlohr Bueso (2):
  hw/cxl: Respect Media Operation max ops discovery semantics
  hw/cxl: Exclude Discovery from Media Operation Discovery output

 hw/cxl/cxl-mailbox-utils.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

-- 
2.39.5

