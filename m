Received: from toucan.tulip.relay.mailchannels.net (toucan.tulip.relay.mailchannels.net [23.83.218.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F782EF9A8
	for <linux-cxl@vger.kernel.org>; Tue, 17 Jun 2025 19:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=23.83.218.254
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750189088; cv=fail; b=MT+ac/sDnPBEiekLlxggV/9X1c5LplD41349sRwFtSTQfnj4FErwY9xl5/SLwnwXfoll+gm/HJhVA8ywJKW5F7Ln1V3EOqtQcyGmYuDdN5b5OjHrrUYVNb/LlgBXS7Pri0oLc94qna1W7Izq/qAgp37wof3Eg9svrsbb4o+xI2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750189088; c=relaxed/simple;
	bh=GbPelLX1IDr2c5wxlnX2q2Kd791Y2REC/dHp+/1ksKs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZtSpVahv3NuBD+jhAatsjt+sNiP3wxd95VytD8pq0WW9mX8jHlnTyUpDwr+0LySgfE3rnpVR0ItLGvgmfly3pYbBjMQ9fOtadKKO8JvcfWVMXVkhRWpG4+CS15xxK9qkNpqXOXb1WVThR+LI2AsSNMeI/VDJlU5IuL9uJcPegXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=orpm4RrT; arc=fail smtp.client-ip=23.83.218.254
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="orpm4RrT"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id A1B9644EA9;
	Tue, 17 Jun 2025 19:38:00 +0000 (UTC)
Received: from pdx1-sub0-mail-a289.dreamhost.com (trex-green-7.trex.outbound.svc.cluster.local [100.103.38.140])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 2148445DDA;
	Tue, 17 Jun 2025 19:38:00 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1750189080; a=rsa-sha256;
	cv=none;
	b=Byi7dbZ5kPhTgGNjGAZU695/mPeFMs+TuUEWPrMLTuG9d2rUu3Kclmb0M8JQxDXC9uiBLa
	iwOsHne3OWstqPgMleWMD8oURE6St3YFAAPf2VlPhiNevVxcrakZJm7/pVE/SeJJnqQasa
	dNjPsjV+mnYD8tmcAJkiCo9GgG/YNjHlHIMM6EkpUBS9y56n+JJRbgPihVks2IBOvgZo2C
	U+UewpP4tdkkZhY7Vxr7rRkeKIGKOUkV4YbxSX5bj8JbS2ER0KvoNGXSYwkfn3tB4sMAtV
	0fslGdfuZFJGGlodieuhEjb6ANFvfOeWrr57METXFZkalq08nZExEEElKQS+pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1750189080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=GT3fYvBXQXue6Ea6o3hUaKRSxBej8/qBcczVv4C6mk0=;
	b=xOe1MfTpcOfxW+SJ2ulj4CgTmwzrUNHyIBdSn1Z0dUk7Fm16xdRBGDvAPInfl6pIr0TclU
	LLSNPZp/O4pYjEeaBeEE4zSc5+iUjmftI9cG1069hIDmNlYLp97hDQ7z3cVXhoZXVl+WIT
	iDteU1UOfem0PxLEBmVCkwng1GGqmUlLLNWG+braXHzDS9YIUzR+wua6SIGwGCBB2CwshJ
	7670YDB2QVnI3agauEKC5Ib3RZh3qk3N0ObqdP6ASfZt+gUarXv7ytF8xIxIBW6/XEhhy/
	NwhflQW+bb1Umrg6hDr0+UWkYxFL2jn9awsWYR8F9lUpHO5ygrFqKtHFkrNPDQ==
ARC-Authentication-Results: i=1;
	rspamd-5859dfb5d9-x6kxz;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Thread-Harmony: 6e80cb900e4ae54e_1750189080441_3641567884
X-MC-Loop-Signature: 1750189080441:781265425
X-MC-Ingress-Time: 1750189080440
Received: from pdx1-sub0-mail-a289.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.103.38.140 (trex/7.0.3);
	Tue, 17 Jun 2025 19:38:00 +0000
Received: from offworld.lan (syn-076-167-199-067.res.spectrum.com [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a289.dreamhost.com (Postfix) with ESMTPSA id 4bMHGH0hT5zGw;
	Tue, 17 Jun 2025 12:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1750189079;
	bh=pG1GZwOuV03WyFEjPs4a9imR6+LClMRh2lU2xH0STC4=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=orpm4RrTKzZNulPLcOP9Y+uduhdxrm3xEhCfaZbsmSZH6xajWq5AdAug0q0WceNPC
	 y4uPLPq8czXSOw4PlRiaKZaPgSb6FHEn3y4C5b7MJF5GHKucDKIGxUzVQ1A9htDolV
	 +3oaAFfEPAZAdlG4ds6j0xtglp5JFoex1Z9QqmY1HWSLZ0thEegR5ibqQcJUqzF1v5
	 ff4h1TQDTx1L2pSQKPD/yVT7fqTaxISJXBhGjpH06uiX4Tfxi+/heWLB6OS3mI5rER
	 45kS+WmKVJCZ/SVOgehrO7dLvtFYJ+4dxYTzcsK42QO9YbwfynlzqdTAjVjLoiDU4H
	 G81SFWbNw0b+A==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com
Cc: dan.j.williams@intel.com,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	jgroves@micron.com,
	ravis.opensrc@micron.com,
	fan.ni@samsung.com,
	anisa.su@samsung.com,
	a.manzanares@samsung.com,
	linux-cxl@vger.kernel.org,
	dave@stgolabs.net
Subject: [PATCH 0/7] cxl: Activate FW and userspace bgcmds
Date: Tue, 17 Jun 2025 12:36:04 -0700
Message-Id: <20250617193611.564668-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

The following addresses two of the requests by Micron, both for
general userspace bgcmd support as well as the more recent sync
meeting discussion around activate FW taking too long and timing
out.

This builds on the previous proposal:
https://lore.kernel.org/linux-cxl/20241022031809.242591-1-dave@stgolabs.net/

... with 2 main differences in this series (i) added the Activate
FW work; and (ii) prevents kernel canceling another kernel bgcmd -
this may later be extended for kernel policies, if required.

Overall this expands on the monopolizing side of things (async to
the driver):
 - user bgcmds are only enabled if they can be canceled
 - activate fw is not timeslicable, but the expectation was that it
 will not run for long (online activation is currently unsupported).
 This is not the case apparently.

Patch 1 is generic to all further functionality.
Patch 2 moves activate FW to the monopolizing (aka sanitize)
category.
Patch 3+4 are prep patches for canceling bg commands.
Patch 5 adds the cancelable machinery, no actual commands yet.
Patch 6 adds a sensible warning instead of silently failing.
Patch 7 adds the Populate Log command to the uapi.

Testing has been done via qemu, similar to the previous proposal
(hacking the code further to disable the userspace only policy).

Micron folks: this does require further adhoc testing, of course,
so feedback welcome.

Jonathan: does this satisfy the Maintanence requirements?

Applies against the next branch in the cxl.git tree.

Thanks!

Davidlohr Bueso (6):
  cxl/mbox: Track background commands from CEL
  cxl/mbox: Handle Activate FW as async bg
  cxl/pci: Lockless background synchronous polling
  cxl/mbox: Stronger cxl_mbox_background_complete() semantics
  cxl/mbox: Allow userspace background commands
  cxl/mbox: Shout upon async bgcmd race

Ravi Shankar (1):
  cxl/mbox: Add Populate Log support

 drivers/cxl/core/hdm.c       |   2 +-
 drivers/cxl/core/mbox.c      |  41 +++++-
 drivers/cxl/core/memdev.c    |   4 +-
 drivers/cxl/cxlmem.h         |  44 +++++-
 drivers/cxl/pci.c            | 269 +++++++++++++++++++++++++----------
 include/cxl/mailbox.h        |   4 +
 include/uapi/linux/cxl_mem.h |   1 +
 7 files changed, 276 insertions(+), 89 deletions(-)

--
2.39.5

