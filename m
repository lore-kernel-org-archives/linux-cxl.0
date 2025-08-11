Received: from iguana.tulip.relay.mailchannels.net (iguana.tulip.relay.mailchannels.net [23.83.218.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05292B9A5
	for <linux-cxl@vger.kernel.org>; Mon, 11 Aug 2025 03:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.253
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754883275; cv=pass; b=pP59TNsZzCiIZQFR5XW1aXmwNoYEYZxgkc8haR9G6Wd4+Il2IrnnNfYb5UoFwjoUddn5dm1PIfakITsKtbyCq1qU9B2l745yyNequCn0LUUGCeVxlU1taxnkMp9bfg3IOrK//wMfAyZYnUP98v3PeXPo+tp+HYXnsojjpsODq/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754883275; c=relaxed/simple;
	bh=/w+DbjAdRVizn9iVAqZ5LKZYNkXGjBINUMFOzCxYImU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TFMkbXlwCz3s9yyiRTzgYM9q/Pvke7e56407CBuLrxj+qXN9K8MAL5BNySmP3UQr/83Mky0zQreBM1bKGyh2eSaF3hR3BumAjoy3MW37XIEbevbKCrN3yJsBLMFRSd4BsKoAzf03tmzpJi16ABQ0sddMPrf7RC7d/wj2ai7cR6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=Nz53jo4c; arc=pass smtp.client-ip=23.83.218.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="Nz53jo4c"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 0EBBC2C58B5;
	Mon, 11 Aug 2025 03:34:27 +0000 (UTC)
Received: from pdx1-sub0-mail-a236.dreamhost.com (100-96-42-182.trex-nlb.outbound.svc.cluster.local [100.96.42.182])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 9E8042C5C57;
	Mon, 11 Aug 2025 03:34:26 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1754883266; a=rsa-sha256;
	cv=none;
	b=0lL7Vboa99amW95g81C6FP2Ai04Sl4CDd4bF7mGtVY92Gy4vK/j/t0hvL0rRlyYUp57UCI
	9boYTiE/STN/a69HYFWd2h77QMUbiIOReqloaqsaw3XYz5Rr/M/kbnhRGJ5wXx2/Tcvu4V
	JvZFHeK0JSMDUPod8IdnM277a58/FRe2aTcGaLcp4Sy2I6iCjNCnZBChzUIchdrZwikTNN
	Z0X0T7mUuQNg+6Em3GWfce02Gp6BGpEglcmWjmPeF13amL6grd/lPkoO/W6QbwU0K3nc1H
	vUQYkycOESQklyvtFSoAqwuC1fpd0deSDPDDCaqEqotNqmadDo+kev81DEhmpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1754883266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=0XWSHvmyXiq4ud4xYsKRJPgbRJy5sP9HaxHzqSo7Tso=;
	b=1ofwbbyu1Q2p/nZ3XHub3WN95edmUmo+jTjNGxw3Gl78kt21+ir++BFKsxwRviCNocKKPI
	eVF6pL9hFQx53Z1e/2VpzDWcta6zNXG/k6uZPGmmM80+Ly/HbtWBVw+skmwop7qMPrd0yP
	vgoQqDY8AN6Y/nO1/EAGOgpBnbj141wW2OA+buTplh/6p6auIF1h1RkWERT2yvA6C82X5j
	fx5FqcW9pDdlsqWq9K6mJ8/+8o9gUHTpqfgmcaGSzzSPArrJRCJZrBLWhjCzHDFvqm7IyQ
	awfoyV6MVSuV2qyUwQuPO/gQVF9R1hAbqxVUWaNkZzmmbEIndknW4D89pZA6PA==
ARC-Authentication-Results: i=1;
	rspamd-64567b6586-knbzh;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Army-Society: 309e33e878c7f21b_1754883266901_1252089449
X-MC-Loop-Signature: 1754883266901:355089586
X-MC-Ingress-Time: 1754883266901
Received: from pdx1-sub0-mail-a236.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.42.182 (trex/7.1.3);
	Mon, 11 Aug 2025 03:34:26 +0000
Received: from offworld.lan (syn-076-167-199-067.res.spectrum.com [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a236.dreamhost.com (Postfix) with ESMTPSA id 4c0gH60fn8z6f;
	Sun, 10 Aug 2025 20:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1754883266;
	bh=0XWSHvmyXiq4ud4xYsKRJPgbRJy5sP9HaxHzqSo7Tso=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=Nz53jo4cqCsnVpYGkqflP7yiONm5gD1U0weIW/NAgqfLdTX/6DTRb+5uzlPwXEpxp
	 PdHGj9CDWnLBXwmFEsJQ7BcrDU7QN2HM93g6Rlak5yyoIo11eGVzMWzVtE/Z0v+kUf
	 Xt6Ofvr+/sO27wphzdg82EWG5MKxE5z7AhRcUadnujnd2LC4PnVwU5C+bLcpa+J+4j
	 cmxlJViEDMz5Di/iNCBgjnG/GDLs4pDSSHfkIXAFTtNVDdj4p/VhTgvMtib1ouWHOW
	 r1pqutERAvZJxTyY4bnUezgv3ZQ9iZ3Mcv6gUwxI0U9dYx0AzU7j4nQKnwJFEdeOlW
	 1PHphUud8vBlg==
From: Davidlohr Bueso <dave@stgolabs.net>
To: jonathan.cameron@huawei.com
Cc: ira.weiny@intel.com,
	alucerop@amd.com,
	a.manzanares@samsung.com,
	linux-cxl@vger.kernel.org,
	qemu-devel@nongnu.org,
	Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH v2 -qemu 0/4] hw/cxl: Support Back-Invalidate
Date: Sun, 10 Aug 2025 20:34:01 -0700
Message-Id: <20250811033405.332295-1-dave@stgolabs.net>
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

Testing wise, this has passed relevant kernel side BI register IO flows for
BI-ID setup and deallocation.

The next step for this would be to add UIO support to qemu.

Applies against branch 'origin/cxl-2025-07-03' from Jonathan's repository.

Thanks!

Davidlohr Bueso (3):
  hw/pcie: Support enabling flit mode
  hw/cxl: Allow BI by default in Window restrictions
  hw/cxl: Support type3 HDM-DB

Ira Weiny (1):
  hw/cxl: Refactor component register initialization

 docs/system/devices/cxl.rst               |  23 +++
 hw/cxl/cxl-component-utils.c              | 206 ++++++++++++++++------
 hw/cxl/cxl-host.c                         |   2 +-
 hw/mem/cxl_type3.c                        |  23 ++-
 hw/pci-bridge/cxl_downstream.c            |  11 +-
 hw/pci-bridge/cxl_root_port.c             |  11 +-
 hw/pci-bridge/cxl_upstream.c              |  19 +-
 hw/pci-bridge/gen_pcie_root_port.c        |   1 +
 hw/pci/pcie.c                             |  23 ++-
 include/hw/cxl/cxl_component.h            |  87 +++++++--
 include/hw/cxl/cxl_device.h               |   4 +
 include/hw/pci-bridge/cxl_upstream_port.h |   1 +
 include/hw/pci/pcie.h                     |   2 +-
 include/hw/pci/pcie_port.h                |   1 +
 qapi/machine.json                         |   3 +-
 qemu-options.hx                           |   4 +-
 16 files changed, 322 insertions(+), 99 deletions(-)

-- 
2.39.5

