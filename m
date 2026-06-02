Received: from rusty.tulip.relay.mailchannels.net (rusty.tulip.relay.mailchannels.net [23.83.218.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C2839936D
	for <linux-cxl@vger.kernel.org>; Tue,  2 Jun 2026 23:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.218.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780444525; cv=none; b=L+PSq+b3PHmPxj+2GSgeSO93Mh6SFcIK6xXjMjc/8sRvxZI5uEuHCeLP6zx4JwQGA5U2sgxPbKk2qaTnoTe5AmtUCOVOFmqLeQ2dhM7kbXmxxrVcEaWy8wa8gXmFkWqxN79ilUcubXajdbZHWlx1DRVz7RM6ZoFNVXEtGOBib+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780444525; c=relaxed/simple;
	bh=Y4o7g9NUlYDk/O9wXNJdONrPN54OwvVt0aJs+oF/sq4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dIGum4KOFSUv3fJSI1DSigUIvRLSVks7nPfZNdFTrng7TVoalS/E+nZN7WWqIiwLkLgSZkO6c93EkEL68Yr1Mi7YmNvoQqcZEhkgXYZJFLayYqVtLUt1jaElDXSi89hhAx5ROR03+4OGEzSuL0SVJ9ell5fhc+kkpI5auSel1GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=FcJjX5X0; arc=none smtp.client-ip=23.83.218.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="FcJjX5X0"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 54A0462F2F;
	Tue, 02 Jun 2026 23:18:51 +0000 (UTC)
Received: from pdx1-sub0-mail-a251.dreamhost.com (100-101-141-32.trex-nlb.outbound.svc.cluster.local [100.101.141.32])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 0982B62B1F;
	Tue, 02 Jun 2026 23:18:51 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Plucky-Spot: 2b67ec0f0938dd5a_1780442331265_451508995
X-MC-Loop-Signature: 1780442331265:3454953683
X-MC-Ingress-Time: 1780442331265
Received: from pdx1-sub0-mail-a251.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.101.141.32 (trex/7.1.5);
	Tue, 02 Jun 2026 23:18:51 +0000
Received: from localhost.localdomain (unknown [181.212.92.203])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a251.dreamhost.com (Postfix) with ESMTPSA id 4gVRbY3GnCz107p;
	Tue,  2 Jun 2026 16:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1780442330;
	bh=2mGLD0wl25r1asFKim0hraTc613N8Kw+BsTweRKBvoo=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=FcJjX5X0SEZ34VRIKdic6J42a6aneyxDPcWIZuLrLcfLOu9x2HqxZp735KAVX1GaB
	 zZ9jKZFtCLKYNWTuocCA4ckI/26B+JMuBi2JTfbMEWuGrNlhAIjNOBNuWa40tR6/oV
	 Lf+kGtwQVi7LS6zrnaF0BQzUiVccy4kBILbyXGwxbiZzSJn3arl+J/eFU2RDE4NbqT
	 yyIZPZsmf+CCjhzTWuCbIg1h4CAGcFHauOpz+PKB4iVTjM0XMNwYxUVRst2qClwb1g
	 WDs5feDAUep6J84V18zL8spNw1pWqbCrr47BfKrd1hxU/Jlc6VY/pdRWe/Cj0JIlzf
	 6WeHI0Lgnw54w==
From: Davidlohr Bueso <dave@stgolabs.net>
To: jic23@kernel.org
Cc: linux-cxl@vger.kernel.org,
	qemu-devel@nongnu.org,
	dave@stgolabs.net
Subject: [PATCH 3/4] tests/acpi/cxl: Update CEDT.cxl for host-only default restrictions
Date: Tue,  2 Jun 2026 16:18:05 -0700
Message-Id: <20260602231806.2469011-4-dave@stgolabs.net>
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

With the default CXL Fixed Memory Window restrictions changed to
host-only coherency, update the expected CEDT to drop Device Coherent
and Back Invalidate from the advertised CFMWS restrictions.

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
[084h 0132 002h]                Restrictions : 000E # Changed from 002F
[086h 0134 002h]                       QtgId : 0000
[088h 0136 004h]                First Target : 0000000C

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 tests/data/acpi/x86/q35/CEDT.cxl            | Bin 184 -> 184 bytes
 tests/qtest/bios-tables-test-allowed-diff.h |   1 -
 2 files changed, 1 deletion(-)

diff --git a/tests/data/acpi/x86/q35/CEDT.cxl b/tests/data/acpi/x86/q35/CEDT.cxl
index c35f3882eee67aa5613af427234d1ccd196aa249..15e30750b4d963eeced503204a5213f755892b77 100644
GIT binary patch
delta 36
ncmdnNxPy_)+0`Xv2Ll5G<L8N7Rg8QSTh)2^fLtCRz6ZnrtV9Q{

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

