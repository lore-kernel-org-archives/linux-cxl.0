Received: from hamster.birch.relay.mailchannels.net (hamster.birch.relay.mailchannels.net [23.83.209.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72D83EB7FF
	for <linux-cxl@vger.kernel.org>; Mon, 20 Jul 2026 23:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.209.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784590976; cv=none; b=D/PSPThlci3XJJh+jfG3r0y83drtvedQ0kxv/hDFTVossVAJwhhEBprbtNQhrA9lGLutShBbth/YPOOJwaXg21pthKeOLHlA67g4/H5XT1Ve6aP2Es2UJyn1yltiPEwx4r/jCsnKQD0UGR03GbbWiLGaiKROsqG/dEtoV+wCI7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784590976; c=relaxed/simple;
	bh=U1Cc6kv62FQhunL7+C7ak47klHIyATWZSkxvKOsU8J0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fdeTgeLSZGv4t6kAcFLa2hnEV8xMHEL+i0158MiBTiNQoKykYrKjv60nDPBkDGPKR3fxXICQFhsLcv19vTVW0wxAcg3FhQnYganRu+RVLIS50KvEbVu0Ai5K79ISawv2/OB2jzpx0tEkrKAZ6OYfqCI7OqhFJxaSPuxx1uImtRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=VpAB7emU; arc=none smtp.client-ip=23.83.209.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="VpAB7emU"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 827684016FB;
	Mon, 20 Jul 2026 23:33:08 +0000 (UTC)
Received: from pdx1-sub0-mail-a216.dreamhost.com (100-103-99-190.trex-nlb.outbound.svc.cluster.local [100.103.99.190])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id EFA77401DAA;
	Mon, 20 Jul 2026 23:33:06 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Robust-Bitter: 7ee8ba5a48fd37f7_1784590387231_2039064562
X-MC-Loop-Signature: 1784590387231:1777061217
X-MC-Ingress-Time: 1784590387231
Received: from pdx1-sub0-mail-a216.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.103.99.190 (trex/8.0.2);
	Mon, 20 Jul 2026 23:33:07 +0000
Received: from offworld.lan (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a216.dreamhost.com (Postfix) with ESMTPSA id 4h3xdt3g1kz2x;
	Mon, 20 Jul 2026 16:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1784590386;
	bh=qVPr/UgYAhoiY9M1ZZZNrrvDLAPjpjaAzUUl1S432Is=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=VpAB7emUzBxYsLCoPOVutG+Yo5M1t+UGy7EuNVu4YGEg+ECkW6G0iSMxqT9P6VHHC
	 12tSXa3NX5v9hNPMPaWZz90I1CPk1PAmk7O4/JSG5D/n0hz1i17gIU/ejXztFGbM5o
	 MttImMFDte81gOihdiU1Q78WbnmkvFbJbsEE1iJVlhtX4LTuGcA/YpVZqd1kHNhodj
	 BPozdff0RUscQRpKBxCJSDfdPjwo4bIJ0LVTV5g4NxXUQj4VR2SACUD/DZI37IGko+
	 7ycQtyry64CZiOjYO4PopzGnF8ZTRjvhF7W8sPTAUv+/lhxD5C263xrP8I7oeIAXj9
	 yMEs7fTfzhe+Q==
From: Davidlohr Bueso <dave@stgolabs.net>
To: jic23@kernel.org,
	mst@redhat.com
Cc: linux-cxl@vger.kernel.org,
	qemu-devel@nongnu.org,
	dave@stgolabs.net
Subject: [PATCH v2 0/5] hw/cxl: hw/cxl: Host-only default CFMW restrictions and per-window options
Date: Mon, 20 Jul 2026 16:32:37 -0700
Message-Id: <20260720233242.901544-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v1 [0]:
 - Keep device-coherent (HDM-D) in the default alongside host-only -- 0x0f
   rather than v1's 0xe, dropping only Back-Invalidate. (Jonathan)
 - Give the mixed HDM-DB / host-only docs example a window per host bridge
   so the mapping is explicit and both windows are exercised (Jonathan).
 - Add qtests (new patch 5).

[0] https://lore.kernel.org/all/20260602231806.2469011-1-dave@stgolabs.net/

As of commit e6742e71c24 CXL emulation is incurring in an (per spec)
undefined behaviour scenario, by allowing the CXL Window to publish
all three coherency models. This series addresses this issue.

The CEDT CFMWS "Window Restrictions" field (CXL r4.0 9.18.1.3) advertises
which coherency models and memory types a CXL Fixed Memory Window (CFMW)
permits.

 - Patches 1-3 drop Back-Invalidate from the default Window Restrictions
   (0x2f -> 0x0f), keeping both the device-coherent and host-only coherency
   models plus volatile and persistent, so an unconfigured window is
   spec-compliant out of the box. It is split into three patches as the
   bios-tables-test workflow requires (exclude CEDT.cxl, change the value,
   regenerate the blob, please shout if I'm doing something silly).

 - Patch 4 makes the restrictions configurable per window via named machine
   properties -- device-coherent, host-only, volatile, persistent,
   fixed-config, back-invalidate. 

 - Patch 5 adds qtests.

Thanks!

Davidlohr Bueso (5):
  tests/bios-tables-test: Exclude CEDT.cxl for the CFMW restriction
    change
  hw/cxl: Drop Back-Invalidate from default CFMW window restrictions
  tests/acpi/cxl: Update CEDT.cxl for the default CFMW restrictions
  hw/cxl: Add configurable CXL Fixed Memory Window restriction flags
  tests/qtest/cxl: Add CXL Fixed Memory Window restriction flag tests

 docs/system/devices/cxl.rst      |  25 ++++----
 hw/acpi/cxl.c                    |   2 +-
 hw/cxl/cxl-host.c                |  46 +++++++++++++++
 include/hw/cxl/cxl.h             |  12 ++++
 qapi/machine.json                |  28 +++++++++
 tests/data/acpi/x86/q35/CEDT.cxl | Bin 184 -> 184 bytes
 tests/qtest/cxl-test.c           |  95 +++++++++++++++++++++++++++++++
 7 files changed, 197 insertions(+), 11 deletions(-)


base-commit: b9e9a55f9950b78ef4c940d0599409c614f36766
-- 
2.39.5

