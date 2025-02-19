Received: from flamingo.ash.relay.mailchannels.net (flamingo.ash.relay.mailchannels.net [23.83.222.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE65E13665A
	for <linux-cxl@vger.kernel.org>; Wed, 19 Feb 2025 02:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.222.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739931899; cv=pass; b=NpEo1oqT0PGOCaptKLOxOynKie9SxyYQhQW0AP54HGBo4D6tvFVF3lr5I7sYCWgChIpk7SrK9RzZDWWF2jCv08caLR8d1Y+pnWhsYHXIU0iXcrjfMB09vLCT78+jgq7JDu4WqDEani2XmEb7EpTguvh3KZVGbQRt4YRcRTw/pIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739931899; c=relaxed/simple;
	bh=VcxqRmJhd9Rxw505oSnfU4fcH+IiUoo/ype6qQ7Uwoo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QiaKwp29+qIeGnruAgJNx54KsXn17Qiuiv/N7UXFZha1+DFaQaYb4+E/0l4GvAo2DkIBOqkRb3Y1JFWgTaUvx3UYk0fXlQZNxBNgFb93x2Q5e5IAQmTwqniPW+nUvqQyeO4Xr2okp2UKSzDUqaMTHbh1bPwuhZJQEyhKU16OKf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=k4FLyA0q; arc=pass smtp.client-ip=23.83.222.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="k4FLyA0q"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id AB923812E5;
	Wed, 19 Feb 2025 02:15:24 +0000 (UTC)
Received: from pdx1-sub0-mail-a289.dreamhost.com (100-97-46-201.trex-nlb.outbound.svc.cluster.local [100.97.46.201])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 295388118C;
	Wed, 19 Feb 2025 02:15:24 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1739931324; a=rsa-sha256;
	cv=none;
	b=JINqnHQXKEL6GnFFstsGmGFj8f9WBSVhDT1G1Sdkw+KOTm5GGF9I41IrdKQSr3Khhamf2B
	1OmH+6INj6kVEC3AsPIjeDv+raxkTRloHM0cdL89gpE8S3LUBF8JvnN/UpDjp7wV+jvvfD
	6PeAMZ3AA5pVi/xjaP+m6yYyIJ5PuNtp9IYLjFdNR34dYpte9xBbRX0fLFglJJFbQ0nbhY
	FOgMvM7mXmEdAOmDT147sNO6Kd9PTid3vquoI8U8BuxzLf1DCKuqU7M9VuXQLq7oS8qxe5
	Itrjt++ufHgroVoObVoTqKwmt+gEGG+EIj3jkIk2Mwb9Dn9MBOl9tP/WI1t9yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1739931324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=/8oB4lUeCLo+Abfkt2xE3ryR06wT2pUcg/09SNT7TYI=;
	b=Ij5qTA7izcWdkjf+L2ZXNHUmyzBpX+PR8iiGM45KRoipXvukwSYSbKl5n+SyGUBPbFviwL
	FYZg18ITXRK+kmeqlHzrXZUDs9qXwjGIWSlRgrS67affKP2gWgSPI9f9pTNFf3D1nMxBjb
	rityBFKUQKIuJvUsbc51T0BLWJVDyCDysHkbczxy2t6/bh7x1kpaaGt/RqxKDnTJa58I8v
	m/Mf+UmN512OpWEnExKUhHIfwfFbMW1RCjcGTmlXw/Cqf0Ic+9hArUz5OO3Y7UIHJAgxXb
	e73fOb/ipymo6iK4gRZuzuF7p6ooYvQQ1sFSyINFk3FuKr9wV9bCrR/MEMCyTQ==
ARC-Authentication-Results: i=1;
	rspamd-6d7cc6b78d-k4sxl;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Fumbling-Decisive: 7a029d45418d523b_1739931324469_1167939522
X-MC-Loop-Signature: 1739931324469:572388698
X-MC-Ingress-Time: 1739931324469
Received: from pdx1-sub0-mail-a289.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.97.46.201 (trex/7.0.2);
	Wed, 19 Feb 2025 02:15:24 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a289.dreamhost.com (Postfix) with ESMTPSA id 4YyKjl2qt4z8j;
	Tue, 18 Feb 2025 18:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1739931324;
	bh=/8oB4lUeCLo+Abfkt2xE3ryR06wT2pUcg/09SNT7TYI=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=k4FLyA0q/PfvSabGTOwhOZMInMjAbQGd2jhqtGpcxplF1Mg4BxCFn1vKPIQ8CMRR+
	 n3bKOY0eV87vZl6oT1MCozNChWdlPkI1LH6gcWO3UkM9c3rEZWXlTwoxbzOo/SN4vY
	 AMIY2aiNrTImlK1XmthmpFEO99hyZLMFss9puXhmKm9KgzSOzBxE4pdgZ2OIRXO5TW
	 WPbRY6a/kgUNuE7k1gkt+zRmwQ/fQEjeRE+z6Km+mSpzw87gA+DZwLkn/enEo5OpVn
	 FNDqAC7W1bMUnwkM5acVWe3es573tU+WV9cEo2926FlBQvErlFS4KicMpdhVHVqTW/
	 XfS2IxI1XhTfQ==
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
Subject: [PATCH v2 0/4] cxl: Dirty shutdown followups
Date: Tue, 18 Feb 2025 18:14:16 -0800
Message-Id: <20250219021420.214991-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes from v1 (https://lore.kernel.org/linux-cxl/20250205040842.1253616-1-dave@stgolabs.net/):
  - crated a new cxl_gpf_get_dvsec() helper to share for port and dev gpf (DaveJ)
  - renamed cxl_dirty_shutdown_state() to cxl_arm_dirty_shutdown() (DaveJ)
  - exported the cxl_gpf_get_dvsec() symbol used outside of core (Yi, DaveJ)
  - introduced CXL_INVALID_DIRTY_SHUTDOWN_COUNT (DaveJ)
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
 drivers/cxl/cxlmem.h                          | 17 +++-
 drivers/cxl/pmem.c                            | 77 +++++++++++++++++--
 tools/testing/cxl/test/mem.c                  | 23 ++++++
 8 files changed, 175 insertions(+), 22 deletions(-)

--
2.39.5

