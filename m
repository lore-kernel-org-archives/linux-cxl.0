Received: from buffalo.birch.relay.mailchannels.net (buffalo.birch.relay.mailchannels.net [23.83.209.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01EB347529
	for <linux-cxl@vger.kernel.org>; Tue,  2 Jun 2026 23:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.209.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780442335; cv=none; b=tBaWBAjysMRhL/mQBy8twFxXOQB1Hvr3HekCsf8vW3mINi9WUzzxzuluke3zrp0oT+RN8+e8ZAFXchJujoV2QUEYoY++EixrQsmdbfYRTEE46rC6yNKOSciHXJiRcmfwaIspQXxy0dE5Vfx2uCpNpIiUYwMiIdRD2RdD9ZiDmnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780442335; c=relaxed/simple;
	bh=EQU+LJzsoVx5HXFhkJgvHC+bQvhLcrovSXWhMq1jr24=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AZ+xq7/8Q9Hxf8cc9R93YudaVAaIz+bL1p97FPUHoSPmRTq51kSBsyyNFf1e/nb8XbwaHiYH9mQzsrrmniEaZhSQtUtoUTkxq4Fy9x/BIJ00hPOY8pcsR54wG0hgq9ptGMAt+sJhkL+25/ffKp0RraBBZlc93nt17m+EKNCmYpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=IdQToCVo; arc=none smtp.client-ip=23.83.209.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="IdQToCVo"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id D0A42801CEA;
	Tue, 02 Jun 2026 23:18:47 +0000 (UTC)
Received: from pdx1-sub0-mail-a251.dreamhost.com (100-109-202-128.trex-nlb.outbound.svc.cluster.local [100.109.202.128])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 26BF5801E1F;
	Tue, 02 Jun 2026 23:18:47 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Bored-Blushing: 14292ab73114efe5_1780442327636_591365789
X-MC-Loop-Signature: 1780442327636:130476261
X-MC-Ingress-Time: 1780442327636
Received: from pdx1-sub0-mail-a251.dreamhost.com ([TEMPUNAVAIL].
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.109.202.128 (trex/7.1.5);
	Tue, 02 Jun 2026 23:18:47 +0000
Received: from localhost.localdomain (unknown [181.212.92.203])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a251.dreamhost.com (Postfix) with ESMTPSA id 4gVRbS1zR9z107p;
	Tue,  2 Jun 2026 16:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1780442325;
	bh=PNR2zmPZNrltlaAyMs5BB8X7/xQzarCvrNRYiQEXme4=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=IdQToCVo6fcTXvzsB9QZah1Lb5gIipy3BwkKYGYLw3jbLT3EdDSO8e8MxDGZvWtBx
	 lgiRMD3OTvPPPQWfv2fVqMGby/cXOqwXVzM7DY1zv89YCcrcBV2hh7j4DP5rh+Evxq
	 RuP1jq2X6ucy3ASrC2q0BvJ0QCzLSyRCG7aGzH8LhNlfFxzpvy/M11MP1p49gqMneG
	 WtARK6deQ8FUGfsGRj4sexQMDdKKUbPRkoO7qiw6hFkUAvNiN53V9q7xqmh/LLKpzv
	 YucQEQ8wZTHhFAJWaCjUUJjhYd+JR7lIE0ZVx7Fh/oqyCYfdoLFXXcTTyFY9yhJHnL
	 K9rRpWXmh4NnA==
From: Davidlohr Bueso <dave@stgolabs.net>
To: jic23@kernel.org
Cc: linux-cxl@vger.kernel.org,
	qemu-devel@nongnu.org,
	dave@stgolabs.net
Subject: [PATCH -qemu 0/4] hw/cxl: Host-only default CFMW restrictions and per-window options
Date: Tue,  2 Jun 2026 16:18:02 -0700
Message-Id: <20260602231806.2469011-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CEDT CFMWS "Window Restrictions" field (CXL r4.0 9.18.1.3) advertises
which coherency models and memory types a CXL Fixed Memory Window (CFMW)
permits. Qemu hardcodes this to 0x2f, which advertises Device Coherent,
host-only coherent and Back-Invalidate (BI) simultaneously, which is a
spec violation/UB.

 - Patches 1-3 fix the default Window Restrictions from 0x2f to
   0xe (host-only coherent, volatile, persistent), so an unconfigured
   window is spec-compliant out of the box. I have split it in 3 patches
   as indicated by the bios-tables-test, please shout if I did something
   stupid updating the binary (this was a bit confusing).

 - Patch 4 makes the restrictions configurable per window via named machine
   properties -- device-coherent, host-only, volatile, persistent, fixed-config,
   back-invalidate.

Without patch 4 the HDM-DB support is effectively untestable upstream.

Davidlohr Bueso (4):
  tests/bios-tables-test: Exclude CEDT.cxl for host-only restriction default
  hw/cxl: Use host-only coherency for default CFMW restrictions
  tests/acpi/cxl: Update CEDT.cxl for host-only default restrictions
  hw/cxl: Add per-capability CXL Fixed Memory Window restriction flags

 docs/system/devices/cxl.rst      |  13 +++-----
 hw/acpi/cxl.c                    |   2 +-
 hw/cxl/cxl-host.c                |  55 +++++++++++++++++++++++++++++++
 include/hw/cxl/cxl.h             |  12 +++++++
 qapi/machine.json                |  29 ++++++++++++++++
 tests/data/acpi/x86/q35/CEDT.cxl | Bin 184 -> 184 bytes
 6 files changed, 101 insertions(+), 10 deletions(-)

-- 
2.39.5

