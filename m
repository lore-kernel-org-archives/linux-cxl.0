Received: from dormouse.ash.relay.mailchannels.net (dormouse.ash.relay.mailchannels.net [23.83.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BB91F4289
	for <linux-cxl@vger.kernel.org>; Mon,  3 Nov 2025 19:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.222.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762199601; cv=pass; b=UA3yZGeR0AhQ4Qt5cQWVIJMzji+TIh6U2MIJw/bwdltQ0GU7RuJv3H06NAl+H6XH6Jk8MV+VxDiaqQFDRtWJEWlz5Fenuzvo1xj2jGyFnhdorFXRdUygI0evFhexm7zeG5zkiGlFLHGpVZFQpM7zhvI15EdWfIoBy+5LkO5wzWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762199601; c=relaxed/simple;
	bh=kEW/qK81mupCHr0O1X481uiEqTRIL8TzV1lPwNLagYU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OYnxv5nEuEl6AMN1zKfbgwbvJz2gmz7P++4wHTyd1z8nzGyhYwCi/n4Trl9qTA18NNpcNJd8WN/LoV2Gw7CQsjOijV0smbw3uc5PebNiesFf734pG61z2rXksxzx1cvvfSYcgkZWwPMHxNcZ5paoeTQ0Jjl0jpEgCijX2U9HaIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=LO9CJrH3; arc=pass smtp.client-ip=23.83.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="LO9CJrH3"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 6DC20120C92;
	Mon, 03 Nov 2025 19:53:12 +0000 (UTC)
Received: from pdx1-sub0-mail-a475.dreamhost.com (100-121-54-118.trex-nlb.outbound.svc.cluster.local [100.121.54.118])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id DA6E2121B24;
	Mon, 03 Nov 2025 19:53:11 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1762199592; a=rsa-sha256;
	cv=none;
	b=Ws9uQEojG/MjLnhYdFeWX5nHFiSVoJbrvY88p8apTGSPU96fnGXeCvH3PISaRwyirNwfbD
	nfca5qS60ui7Ep+e6gB0DGr7Tfu50nOMegc7QsDSBjBtZ1gGlu3kRTZym7Y31M7ZURiAQJ
	j+dqMv3+yOjybo1Ija8rLCGGN8Kw5YgFgmvIkGT8nRWjoRB8K9CuTDIivciWezIpgJgi4k
	CJQsUEckb96F9W0wv/VFMxGoIIfYXEgJ7T2qwMjIbP743JRbynaSi8o1hlGuVpWpAeSoo3
	0ZKCmCB5H8PJEuiCqxaLRMFdcZVwnsLdx+Q7IxYKG8oHWu4ClJ/VDfQCzMn4vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1762199591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=AmFoDFrxSC+IPGq7rdCR2qUi0cncf4yoFgbBTnBlvy8=;
	b=o9+HGTQoaZmadgEbYYOCWwqXdWRp7klbSYSmUfz5UVv032LlZa9xUJg/RAswj7V5Sr4lYc
	wi8lVMdNj0wYFAzYDowM77uvTvh/gBWJMP031eBHeASuQHM3ifDwAxnXqeXFzDW8pjqMyt
	1CQghanDq14LyOm+RTky05gfRX2wpel7UlPu2oMRc1JCAsLcHxIp6IpdIGSLl7ZJHfzS8o
	2eOJQtIEXzLvEfPL2aTFJnSwOFmE1MumChx7Csb/dh603Tppovn6qiQ36FkM0qO3etUFfw
	mfwan+Emdyjc+sq0H7m/kkx5py4C2+6FKAabHqtgve8/nejOZmc30iSZe1ZJfg==
ARC-Authentication-Results: i=1;
	rspamd-768b565cdb-k86dj;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Tasty-Bored: 04d8a3331abfc5d1_1762199592187_3518719076
X-MC-Loop-Signature: 1762199592187:897472234
X-MC-Ingress-Time: 1762199592187
Received: from pdx1-sub0-mail-a475.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.121.54.118 (trex/7.1.3);
	Mon, 03 Nov 2025 19:53:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1762199591;
	bh=AmFoDFrxSC+IPGq7rdCR2qUi0cncf4yoFgbBTnBlvy8=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=LO9CJrH3Ut1TrBMfRuCiVBERhuXMQUEFwF7zYQZ0GxJy3VdJFSfehgTpOU3GNqnm1
	 yy/Px/FCT+TqUfbgHH6G/DwvIW2j8tjjRKIJI/xgaVAwnBQb5hvy2RXf4743K2DR6i
	 AyrBCtHlIQUJfgwYlODWXfrEzbN2KU21IfqSzLczNhoaGUkxW36vDIixqbLjB6olET
	 a6qrWUQse6DKt485orERn76ySWmgnB6ohWZuMg3GtdvI/3RDnjnwkZt60b3v5qT7Dp
	 I4Mtl4tnirs4r15hXTcE6uISZpIbBZfQvTYxPlQzAStv0b4SWBOpmqylHYFCQdL3K1
	 8A7mzfRI3NuJQ==
Received: from offworld.lan (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a475.dreamhost.com (Postfix) with ESMTPSA id 4d0j1f5rq7z1wdh;
	Mon,  3 Nov 2025 11:53:10 -0800 (PST)
From: Davidlohr Bueso <dave@stgolabs.net>
To: jonathan.cameron@huawei.com
Cc: ira.weiny@intel.com,
	alucerop@amd.com,
	a.manzanares@samsung.com,
	dongjoo.seo1@samsung.com,
	mst@redhat.com,
	marcel.apfelbaum@gmail.com,
	armbru@redhat.com,
	linux-cxl@vger.kernel.org,
	qemu-devel@nongnu.org,
	dave@stgolabs.net
Subject: [PATCH v4 -qemu 0/5] hw/cxl: Support Back-Invalidate
Date: Mon,  3 Nov 2025 11:52:04 -0800
Message-Id: <20251103195209.1319917-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following allows support for component basic back invalidation discovery
and config, by exposing the BI routing table and decoder registers. Instead
of going the type2[0] route, this series proposes adding support for type3
hdm-db, which allows a more direct way of supporting BI in qemu.

Changes from v3 (https://lore.kernel.org/all/20250930032153.1127773-1-dave@stgolabs.net/):
  o Fix Flexbus caps bits in patch 1. (Jonathan)
  o Flipped the bi arg to true for hard-configured components in patch 4 (Jonathan).
  o Expose the BI routing table only if the sw upstream port is in Flit mode.
  o Removed the mem-path= arg in the documentation as it deals with volatile (Donjoo). 

Changes from v2 (https://lore.kernel.org/linux-cxl/20250811033405.332295-1-dave@stgolabs.net/):
  o Renamed 256b-flit to x-256b-flit (mst)
  o Added a brief description of flit mode in patch 1 changelog (Markus)
  o Added missing hdm-db parameter which went missing in v2.
  o Replaced the new CXL3_TYPE3_DEVICE with passing 'bi' params. (Jonathan)
  o Fixed writemask bits in patch 4. (Jonathan)
  o Misc cleanups in patch 4. (Jonathan)
  o New patch 5 to remove register special_ops read() cb. (Jonathan)

Changes from v1 (https://lore.kernel.org/qemu-devel/20250806055708.196851-1-dave@stgolabs.net/):
  o Further lnk training in patch 1. (Jonathan)
  o Flit parameter changed to bool in patch 1. (Jonathan)
  o Do not set 68B in component Flexbus Port when in flitmode in patch 1.
  o Doc build fixlet in patch 3.
  o Pass the exact type3 type in cxl_component_create_dvsec() - unused, but better
    for keeping track, in patch 4.
  o Change doc example to volatile device in patch 4.

Changes from rfc (https://lore.kernel.org/qemu-devel/20250729165441.1898150-1-dave@stgolabs.net/):
  o Added 256b-flit parameter, per Jonathan.
  o Added window restrictions changes.
  o Dropped rfc tag.

Patch 1 introduces the flit mode parameter.
Patch 2 is lifted from Ira's series with some small (but non-trivial) changes.
Patch 3 updates the cfmw restrictions option.
Patch 4 adds BI decoder/rt register support to enable type3 HDM-DB.
Patch 5 is a small cleanup.

Testing wise, this has passed relevant kernel side BI register IO flows for
BI-ID setup and deallocation.

The next step for this would be to add UIO support to qemu.

Applies against branch 'origin/cxl-2025-10-03-draft' from Jonathan's repository.

Thanks!

Davidlohr Bueso (4):
  hw/pcie: Support enabling flit mode
  hw/cxl: Allow BI by default in Window restrictions
  hw/cxl: Support type3 HDM-DB
  hw/cxl: Remove register special_ops->read()

Ira Weiny (1):
  hw/cxl: Refactor component register initialization

 docs/system/devices/cxl.rst               |  23 +++
 hw/cxl/cxl-component-utils.c              | 211 ++++++++++++++++------
 hw/cxl/cxl-host.c                         |   2 +-
 hw/mem/cxl_type3.c                        |  15 +-
 hw/pci-bridge/cxl_downstream.c            |  10 +-
 hw/pci-bridge/cxl_root_port.c             |  11 +-
 hw/pci-bridge/cxl_upstream.c              |  18 +-
 hw/pci-bridge/gen_pcie_root_port.c        |   1 +
 hw/pci-bridge/pci_expander_bridge.c       |   2 +-
 hw/pci/pcie.c                             |  23 ++-
 include/hw/cxl/cxl_component.h            |  87 +++++++--
 include/hw/cxl/cxl_device.h               |   4 +
 include/hw/pci-bridge/cxl_upstream_port.h |   1 +
 include/hw/pci/pcie.h                     |   2 +-
 include/hw/pci/pcie_port.h                |   1 +
 qapi/machine.json                         |   3 +-
 qemu-options.hx                           |   4 +-
 17 files changed, 319 insertions(+), 99 deletions(-)

--
2.39.5

