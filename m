Received: from butterfly.birch.relay.mailchannels.net (butterfly.birch.relay.mailchannels.net [23.83.209.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29F6334374
	for <linux-cxl@vger.kernel.org>; Tue, 21 Jul 2026 00:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.209.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784594965; cv=none; b=LcEIToKPLRLokx187l83zLiXaW2wTxdVaBi6YOdKMFaK/jHJO8K1pWyUZ99TqNanpxzoFs4xVHJg9AWteIz56KT6bpsnxHGVggXJ0m4FLjpHuq6+IvcE43yGsz2HPz7rV+quXmxd+Z/2vm8zWvSKSBNhRe/sPQAsoTQjCkDjjYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784594965; c=relaxed/simple;
	bh=qBRiDtdcf978BPdPNEyxdWP5nOegZqnc9WMHVaX+bRg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FgbnIdacyXvgVaxJ8TqEW61Ig58Lxxg/gh+lCKi0UoQePSOw186YVEyIz0h27viVbacTRRS6k4bh1RWOr1NjT/LdEuaaE6HYUZrecv14QUOhDUBKA+ulJuI1LCHgfuM5vZQ3zB/VYfV7dTtRXQJOwON8YpWOxy4RrUhwBp3j+14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=I0zyqnbA; arc=none smtp.client-ip=23.83.209.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="I0zyqnbA"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id D27FA942807;
	Mon, 20 Jul 2026 23:33:08 +0000 (UTC)
Received: from pdx1-sub0-mail-a216.dreamhost.com (trex-green-6.trex.outbound.svc.cluster.local [100.104.248.19])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 80B439427F3;
	Mon, 20 Jul 2026 23:33:08 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Juvenile-Bored: 580ed5b52595c1cc_1784590388774_387277786
X-MC-Loop-Signature: 1784590388774:2841013375
X-MC-Ingress-Time: 1784590388773
Received: from pdx1-sub0-mail-a216.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.104.248.19 (trex/8.0.2);
	Mon, 20 Jul 2026 23:33:08 +0000
Received: from offworld.lan (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a216.dreamhost.com (Postfix) with ESMTPSA id 4h3xdw0ChPz1RB;
	Mon, 20 Jul 2026 16:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1784590388;
	bh=Ttj+PI4T1KYb/sma3Tc4KkN36biy0tYu1idHgYObEdc=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=I0zyqnbAERcAeOxyp5NjcUWrwgQCGcvynq4plPoRGx47Vhax2vt4qDtu7Eyg3X2DV
	 5WS7fOGEQGraGF9rG1Sv6gl9EAuoL1zlTsuH8bgKWnjfYY8QfrE++eZBP0zlWcoBsM
	 nJUmRQt/FV3AY7K+ge/cSyssZObRXZT5sTcvloa9aseWhFFzf9ynFD3Z6wxDnIfCiF
	 m2C/l3k57dkBDFUR5NHmlCTsAhJNe9Io4bsncm3I2wCFv0GHjd3PldgTYmAmpcfm+c
	 0CNoZle/rcHt5Ar0EC3EejeopGmqov0LkR1vhvfFsgB+yZQ2x+qRHrfOatsiKYdP4c
	 90gdz04fk3fZg==
From: Davidlohr Bueso <dave@stgolabs.net>
To: jic23@kernel.org,
	mst@redhat.com
Cc: linux-cxl@vger.kernel.org,
	qemu-devel@nongnu.org,
	dave@stgolabs.net
Subject: [PATCH v2 3/5] tests/acpi/cxl: Update CEDT.cxl for the default CFMW restrictions
Date: Mon, 20 Jul 2026 16:32:40 -0700
Message-Id: <20260720233242.901544-4-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260720233242.901544-1-dave@stgolabs.net>
References: <20260720233242.901544-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the default CXL Fixed Memory Window restrictions changed to drop
Back-Invalidate (keeping device-coherent and host-only), update the
expected CEDT to advertise 0x0f instead of 0x2f.

[064h 0100 001h]               Subtable Type : 01 [CXL Fixed Memory Window Structure]
[065h 0101 001h]                    Reserved : 00
[066h 0102 002h]                      Length : 0028
[068h 0104 004h]                    Reserved : 00000000
[06Ch 0108 008h]         Window base address : 0000000110000000
[074h 0116 008h]                 Window size : 0000000100000000
[07Ch 0124 001h]          Interleave Members : 00
[07Dh 0125 001h]       Interleave Arithmetic : 00
[07Eh 0126 002h]                    Reserved : 0000
[080h 0128 004h]                 Granularity : 00000005
[084h 0132 002h]                Restrictions : 000F
[086h 0134 002h]                       QtgId : 0000
[088h 0136 004h]                First Target : 0000000C

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 tests/data/acpi/x86/q35/CEDT.cxl            | Bin 184 -> 184 bytes
 tests/qtest/bios-tables-test-allowed-diff.h |   1 -
 2 files changed, 1 deletion(-)

diff --git a/tests/data/acpi/x86/q35/CEDT.cxl b/tests/data/acpi/x86/q35/CEDT.cxl
index c35f3882eee67aa5613af427234d1ccd196aa249..ff8203af070241bd23dd0eb8a51460692bb7d229 100644
GIT binary patch
delta 36
ncmdnNxPy_)+0`Xv2Ll5G<Hw0yRgC--Th)2^fm|LSz6ZnrtThL&

delta 36
ncmdnNxPy_)+0`Xv2Ll5G<Hm_xRgC%*Th)2=fm|LSz6Znrs#OQB

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index b4646b5b3147..dfb8523c8bf4 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,2 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/x86/q35/CEDT.cxl",
-- 
2.39.5

