Received: from panther.cherry.relay.mailchannels.net (panther.cherry.relay.mailchannels.net [23.83.223.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CB13C7691
	for <linux-cxl@vger.kernel.org>; Tue,  2 Jun 2026 23:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.223.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780442332; cv=none; b=RZRWNT72dS+5g8i6is1vFLQb2t2XfGKUCXUzgVHjanRArh1N2qjwg4o3qc80iPPnRmiNWxSeU3AFIjyzIWJ/tU4hwfAqUT+IogS28DN1/Dy0ffYA1gI9hHy2sp7ze12x3rG9qoKveXBKVRQNqpHTe9GixM+hg4oCCkRPZwrLu5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780442332; c=relaxed/simple;
	bh=eVqHwoC+Xkbxt2QVP1JgGX86HnOzJxEYVvdQkuM3xjg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u9O2LH6cuEabLva7V/oBVD8uO90zHKNX7JcLuGMm/HEMA9hVpNSiP+WSff/FfaeCX7kia50HPyjDvjPYOirl8TROk4surPQlSo27mGxEqc5cNUWF/bnDt4xoVNfovNkHhiLFqmaIWJ6F7QfD7U2jHGf4LVkEvAKvdPqql2J66aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=LP1V0C+n; arc=none smtp.client-ip=23.83.223.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="LP1V0C+n"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id BD56A402C75;
	Tue, 02 Jun 2026 23:18:47 +0000 (UTC)
Received: from pdx1-sub0-mail-a251.dreamhost.com (100-103-80-215.trex-nlb.outbound.svc.cluster.local [100.103.80.215])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 60884402C7E;
	Tue, 02 Jun 2026 23:18:47 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Wipe-Absorbed: 1af98fc53376dabc_1780442327626_2445509738
X-MC-Loop-Signature: 1780442327626:3667555747
X-MC-Ingress-Time: 1780442327626
Received: from pdx1-sub0-mail-a251.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.103.80.215 (trex/7.1.5);
	Tue, 02 Jun 2026 23:18:47 +0000
Received: from localhost.localdomain (unknown [181.212.92.203])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a251.dreamhost.com (Postfix) with ESMTPSA id 4gVRbT732Vz1041;
	Tue,  2 Jun 2026 16:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1780442327;
	bh=Y60gMEITJfCqStaTYSFD8uzsncBlRLgD4z5UccFv+RI=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=LP1V0C+nvIbxNEFifrTaPCggxU0rWlDpZrnVmZ/XRqr2y7EZLhEekoxx9FeyV4INf
	 sew8BRzpkOSu4atWRRBw3yl69MCaFhTja3UDToYu5TgK7tHjXC9SohsLVif1gEwyBk
	 dEJTTNX6wKtuTSxAJlVFysxyA8xTpB55RcQVRSEp2QHmTr6gzR0gPoqymUq/yvU9c1
	 eKnz9PuckKHoCJ2UpyUUYUUG0xWzFv9SKp7Ko0HDpcpp7w+Z4YliPZlg/rsDEr3YDg
	 KF0mlz5x/Ha54v/i0+rSXrBkBedPG69synmMc1Z3buMNkKOTRIzO+yHwGzkSiDrCXa
	 4mK7eJpiKb9dQ==
From: Davidlohr Bueso <dave@stgolabs.net>
To: jic23@kernel.org
Cc: linux-cxl@vger.kernel.org,
	qemu-devel@nongnu.org,
	dave@stgolabs.net
Subject: [PATCH 1/4] tests/bios-tables-test: Exclude CEDT.cxl for host-only restriction default
Date: Tue,  2 Jun 2026 16:18:03 -0700
Message-Id: <20260602231806.2469011-2-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260602231806.2469011-1-dave@stgolabs.net>
References: <20260602231806.2469011-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The next patch changes the default CXL Fixed Memory Window restrictions
to host-only coherency, dropping Device Coherent and Back-Invalidate.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8bf4..b4646b5b3147 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,2 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/x86/q35/CEDT.cxl",
-- 
2.39.5

