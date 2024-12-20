Received: from slateblue.cherry.relay.mailchannels.net (slateblue.cherry.relay.mailchannels.net [23.83.223.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB27157A48
	for <linux-cxl@vger.kernel.org>; Fri, 20 Dec 2024 21:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734730627; cv=pass; b=Ihwb6T6zBBNum+mf3K6wIhJCYjLcNhjImVq1haR2mNUxCvSKuVvPGNb6p4Yf1CoNpzB2BJfVJiFwEPAM5BoUyMEXe0JRJPAwl21IMJ+REXq7HRLEdIBnQ8U4umLata0e/yCGwAqy5RbSdl7/J0c/Id6OcEVFmzKdRYxr/OSCQBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734730627; c=relaxed/simple;
	bh=Reh/3J4Mhm3CuTtc0vMlL4tB9pW/q/4btfVIsKZnsX4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=am343njpDaBt94Ay7wwx/FrpcJQLLH5zRwYPwFgq3oke2Y1R59WDOvnRyOfyG7DjE3avAV+WL3yYNNi1dDvQdL1qOLYoZjfIN2P+ZAzdhnl5lyQttkewv8wm++zorGKIvXfbJE+1EKP4yZBw9HcTxdnMHPM0qoZ5dlRdmkS4YvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=Bdte+9CS; arc=pass smtp.client-ip=23.83.223.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="Bdte+9CS"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id CEF2C901EA3;
	Fri, 20 Dec 2024 16:00:31 +0000 (UTC)
Received: from pdx1-sub0-mail-a227.dreamhost.com (trex-5.trex.outbound.svc.cluster.local [100.102.76.164])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 72CB490286B;
	Fri, 20 Dec 2024 16:00:31 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1734710431; a=rsa-sha256;
	cv=none;
	b=6lMn7mNoB2uX50P+nnzUHjxYFGxmmY4/cJBGU0DSbjD2KzquXSySS2EI4SwXzYfPxz0Pzb
	uHZt/V0TZn4Mk1BLVj8QMzyvVg0o/h54Gq0q9CfLdJJ9TV/YoGdiHxtIpUBTBQIgs2scw1
	u5uYcj1YaAAwrXe4/sIf74hRQAe0GayFayU9RtK07fgFBtLuBh9S0YVKiTA2COESWgf7jA
	ouAi9bgNVaXQdINGMp1nqcPIIRuQTPReXLqehjMGEF184I1UXt7Ib9mE8xg26Qjul0+TpB
	fbF8q1tsVvhNAKj2/grxzJI0b4uFOm2gzNRXla+wiEaGrTlMdVo8b5rqTni9vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1734710431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=pDaoc/zqxEoN9dMJ2z3PMeaAdqOICRm75InQ42aL2QE=;
	b=YChC3pGvNA8HSxwI+SykbICUf0vkDWv1uBfGfApkr+UWqn7fUF9NfvpAjAtHCTa6K0fikb
	AJrV8gv27BaVqT299ZkfggNZzOqHnIcCebEyiZZWTr5gcWHTOgjRmQxWKI17+FxlIoyMJj
	LqcH+lhQJQsk6GTZ5t/3sHCyu5hE9E6NHVtjOlBzIKvBS7dW+OOlsxQJMCn2KuVgVIz6op
	TJaxHSEvqWeiuq7MWW0s0jF3lwFn9dycfYJChtjSlafy/Nw4+Iq8r9pMIlhQu/BuX3xsjA
	4/xnAdfgxAOXr5rnAS3TBDW7CRxBgDg+k5K+0a+4oT0WiJ460iV/mituonWlfA==
ARC-Authentication-Results: i=1;
	rspamd-7d788bbf85-ds7ph;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Quick-Tasty: 0252ed9149b39efb_1734710431707_1047297148
X-MC-Loop-Signature: 1734710431707:1191748444
X-MC-Ingress-Time: 1734710431707
Received: from pdx1-sub0-mail-a227.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.102.76.164 (trex/7.0.2);
	Fri, 20 Dec 2024 16:00:31 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a227.dreamhost.com (Postfix) with ESMTPSA id 4YFBvy6KnrzP4;
	Fri, 20 Dec 2024 08:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1734710431;
	bh=pDaoc/zqxEoN9dMJ2z3PMeaAdqOICRm75InQ42aL2QE=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=Bdte+9CSfdyxZ/sOS4JrQgU6ojqvnYrpKRdj40XaQ1Qa9sixFO4qcivQBd1f7ucbt
	 ZvmLvUA4yQ/Iugw/VYpBnK5iWXXsw3JxzyZQE6LxyGPMCkNRD9Mf5+7W/DbcSRRvLJ
	 r5OPrtlyueSWTu2nf7FViG6dvdHh8bspbdmS25z65EU0YVeUAbMQLmXIm051ZwuoJg
	 ZeJ3st9sqOQQg92rBfrmdqmvYn1tx7wxNF3I2kRo6wGZnl8DSnqFa0HeONPCUn2HtT
	 oe0V/v1ECsuNtHkgkYf9st03JUWA/QZyCr+q74kDHaKvcGe7TIaXeD18361kp2Xgk9
	 r9R86JN9QAu9g==
From: Davidlohr Bueso <dave@stgolabs.net>
To: jonathan.cameron@huawei.com
Cc: fan.ni@samsung.com,
	dan.j.williams@intel.com,
	a.manzanares@samsung.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org
Subject: [PATCH -qemu 0/3] hw/cxl: Support dirty shutdown
Date: Fri, 20 Dec 2024 08:00:23 -0800
Message-Id: <20241220160026.204055-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

The following adds support for emulating dirty shutdown semantics.

Patch 1 is a trivial cleanup, patch 2 adds get/set shutdown state
commands, and patch 3 introduces a new 'dirty-shutdown=N' parameter
for type3 memdevs which explicitly sets the dirty shutdown counter
to whatever passed value.

This series aids testing Global Persistent Flush support in the kernel.

Applies against the 'cxl-2024-11-27' branch in Jonathan's tree.

Thanks!

Davidlohr Bueso (3):
  cxl: Fix mbox cmd enum order
  cxl: Support Get/Set Shutdown State commands
  cxl/type3: Add 'dirty-shutdown' parameter

 hw/cxl/cxl-mailbox-utils.c  | 91 +++++++++++++++++++++++++++++++++++--
 hw/mem/cxl_type3.c          |  1 +
 include/hw/cxl/cxl_device.h |  5 ++
 3 files changed, 92 insertions(+), 5 deletions(-)

-- 
2.39.5

