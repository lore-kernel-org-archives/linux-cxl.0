Received: from aye.elm.relay.mailchannels.net (aye.elm.relay.mailchannels.net [23.83.212.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0EE17BA5
	for <linux-cxl@vger.kernel.org>; Wed, 19 Feb 2025 03:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.212.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739935492; cv=pass; b=hGXL6aOMMdzcFydSzLyLnxssHf9xbQTEsESIsqdFpTk9kh0IaFjmJybmOg7PDF+e7BpACqZqqpf3E8EgxRIxwEulebbI++bf7yCRpmzrtTDM1PALl1bIAzufbP7MFDvJZPEk/TN6aqyH27PtffE3ZcMcP1S5U3XVPYGZ+iA2S2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739935492; c=relaxed/simple;
	bh=Mg+lgducy9HevF+scvmfSJVA+nWQu4LAxR3ij7OF4F8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WIP0DjV3brtHHEttZPTc41H3Yk0Z93gqeN0fehiCtJ44wNk3eWliUefx0ttN6M7TD8wTXnwGtHqL2ENt7xOJJ0KkOAkG4L1dtkVpbeKhQklMty1ua4YNeWDY2Ous9lQCSrF1ssFyV7XzGc1SBi45f975RCkHjQ773boLz6yOVf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=GW3mcI33; arc=pass smtp.client-ip=23.83.212.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="GW3mcI33"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 68F4182242;
	Wed, 19 Feb 2025 03:06:00 +0000 (UTC)
Received: from pdx1-sub0-mail-a289.dreamhost.com (trex-1.trex.outbound.svc.cluster.local [100.97.27.146])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id EDA27821D6;
	Wed, 19 Feb 2025 03:05:59 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1739934360; a=rsa-sha256;
	cv=none;
	b=8ISteEXUm2wrAdjRKk83TQJ8fnHGwHsaK/ySpLMjFbtnX/4d134ooGY1fXDLxH9MoIYZWF
	QiVyn80DfLiMcmdH1gx48IjQfNxW+h17/O0zdmwmtWjp93FOGOy7N2NjbAsDbb7IWOYOjZ
	4ECmDwR1VvCBnigLYkF7jid0yU86z7ytsgoAMUGs4Kh0RLSk093X14K9QOf2ZQCE2bzQyN
	5ym8DoPRPVdmjK9ej0P9y23LbB1H6gknJeyUAhOf2crwHQlMpCM8ZlDGpkeW/+FoZKF/0l
	Inahd78wpzRHRyqwwjpcKEz6uGW9P2U3HJrN17aapDwwUO/Yph31T4rEgNAi6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1739934360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=UNXY3sMqlqXzMn6Ii4Y/Smh4IqubbPCxIrHD3kM6knA=;
	b=Gg7gy8rRknzpCvSk4QD7do/P1aa9e66gmEHLW5T5kCnKltkCTr3MmPtj6mi1fnaZ6eRy22
	yZea0kuGwegjUpLenctkgwi5hjsp97nP8c17p9d+ACo8WVokVxoC/ABwOjQR6TkLsc08vV
	q/MyIUu58SlHUWJeADrtJA9ILCG+6WbLNhf/OsNGjVxirRC6xzOQFKzpFRhoxAB06NlJcQ
	6NI8f2Rx/5qx0KbHLa0godIrgFZfcKomjej/lhI0OOMP74IO7eIFNSqGHhRcyDxpk3wSqh
	J/nwqzYwnDF+yoiMpbnw1ruA0tDTjhkCw1525EcsC6BTvrSJxyq50DIReK/CVg==
ARC-Authentication-Results: i=1;
	rspamd-6d7cc6b78d-mdkjb;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Trouble-Callous: 7a004d1c519db672_1739934360275_826057906
X-MC-Loop-Signature: 1739934360275:2096790245
X-MC-Ingress-Time: 1739934360275
Received: from pdx1-sub0-mail-a289.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.97.27.146 (trex/7.0.2);
	Wed, 19 Feb 2025 03:06:00 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a289.dreamhost.com (Postfix) with ESMTPSA id 4YyLr705ppzDk;
	Tue, 18 Feb 2025 19:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1739934359;
	bh=UNXY3sMqlqXzMn6Ii4Y/Smh4IqubbPCxIrHD3kM6knA=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=GW3mcI33H4F9HLAH0koJExU618N0yZMnGVWQkAqN4RROFptzu9cpGEI4PKhOUmGrN
	 R6GFgtn6fD7JnR6ggdDaeEBd44pxxTt+nctVhdr798OKScsQ+55p4eX2S59chQnC3D
	 1hqf49x4i1k0fz7DM0Oea335cmGJj7SovbdJyqOLt1QyzOBb1XRdRAiM2H+8Wobsuk
	 +ENtNgIs2hgXKfshmkGvANEiF+3Ovt6q0DBQgXekl+nPtn9hf4TUX8+AlhsSp65qoT
	 EQ2utsMtnfW57RuWxJB0ptSzDp8Yx2jgQAiyjTUYVhWLu/cf+UFF0qqz478CWm5gYJ
	 yF+eZp91C+F5A==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com,
	dan.j.williams@intel.com
Cc: jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	ira.weiny@intel.com,
	vishal.l.verma@intel.com,
	seven.yi.lee@gmail.com,
	a.manzanares@samsung.com,
	fan.ni@samsung.com,
	anisa.su@samsung.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org
Subject: [PATCH v3 0/4] cxl: Dirty shutdown followups
Date: Tue, 18 Feb 2025 19:05:16 -0800
Message-Id: <20250219030520.237207-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes from v2:
  - remove leftover cxl_gpf_device() declaration
  
Changes from v1 (https://lore.kernel.org/linux-cxl/20250205040842.1253616-1-dave@stgolabs.net/):
  - crated a new cxl_gpf_get_dvsec() helper to share for port and dev gpf (DaveJ)
  - renamed cxl_dirty_shutdown_state() to cxl_arm_dirty_shutdown() (DaveJ)
  - exported the cxl_gpf_get_dvsec() symbol used outside of core (Yi, DaveJ)
  - introduced CXL_INVALID_DIRTY_SHUTDOWN_COUNT (DaveJ)
  - use u64 for cxl_nvd->dirty_shutdowns,
  - rename to cxl_nvdimm_setup_dirty_tracking() and use return statements (DaveJ)
  - picked up review tag in patch 4 (DaveJ)

Hi,

Some followup patches to the GPF work. First two patches are from feedback
provided by DaveJ. The third patch adds a $platform/dirty_shutdown sysfs
attribute to expose the count to userspace. Fourth patch adds support
emulating the set shutdown state command for the mock device.

Applies against the -next branch of cxl.git.

Thanks!

Davidlohr Bueso (4):
  cxl/pci: Introduce cxl_gpf_get_dvsec()
  cxl/pmem: Rename cxl_dirty_shutdown_state()
  cxl/pmem: Export dirty shutdown count via sysfs
  tools/testing/cxl: Set Shutdown State support

 Documentation/ABI/testing/sysfs-bus-cxl       | 12 +++
 Documentation/driver-api/cxl/maturity-map.rst |  2 +-
 drivers/cxl/core/mbox.c                       | 25 +++++-
 drivers/cxl/core/pci.c                        | 38 ++++++---
 drivers/cxl/cxl.h                             |  3 +
 drivers/cxl/cxlmem.h                          | 15 +++-
 drivers/cxl/pmem.c                            | 77 +++++++++++++++++--
 tools/testing/cxl/test/mem.c                  | 23 ++++++
 8 files changed, 173 insertions(+), 22 deletions(-)

--
2.39.5

