Received: from hamster.birch.relay.mailchannels.net (hamster.birch.relay.mailchannels.net [23.83.209.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C394C1917FB
	for <linux-cxl@vger.kernel.org>; Tue, 21 Jul 2026 00:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.209.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784592518; cv=none; b=ofv8B3zLNxYaf+lMWFiADI+a9MIMeoj3chbDjMpVCyjd2F8Q619sRh1jLMxHoheEqjzSKOcoFUa/xxY203J9VV0sQFZn8j/f+NPJdgpbUFZXPnlMzqe02RABvHd9IJqTrec+njKFgSa16zAedQY+Gxq1EcfUU4lmSzQ2yCcpDH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784592518; c=relaxed/simple;
	bh=tJWdKcOqy5swccV7+Z6YZBm4eSh1Hyl+7odGYBjuAJo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rOVMR5TcBs0HakDTZYFF0d9xghjYq9NgyD6QVSAT0Ab9IP2uMQ7KoNGS8sCXXbGM0yD+0xm/cc1LHFsOzfkGkJgLBJlbBraVUVo9FH1rhfpbgalu7/ICP96QxGYSHJYV0fk3E5WrTvHU6oO5cN+Uhfm9AF+L3VX8O3BuKbCvA1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=ojRTW46V; arc=none smtp.client-ip=23.83.209.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="ojRTW46V"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 82A0180270D;
	Mon, 20 Jul 2026 23:33:08 +0000 (UTC)
Received: from pdx1-sub0-mail-a216.dreamhost.com (100-104-243-177.trex-nlb.outbound.svc.cluster.local [100.104.243.177])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 7EF55802BCA;
	Mon, 20 Jul 2026 23:33:07 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Whispering-Bitter: 7d61d5b35271f909_1784590387770_910987872
X-MC-Loop-Signature: 1784590387770:750604934
X-MC-Ingress-Time: 1784590387769
Received: from pdx1-sub0-mail-a216.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.104.243.177 (trex/8.0.2);
	Mon, 20 Jul 2026 23:33:07 +0000
Received: from offworld.lan (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a216.dreamhost.com (Postfix) with ESMTPSA id 4h3xdv02rpz1P9;
	Mon, 20 Jul 2026 16:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1784590387;
	bh=OMIOmwFct7Bvsigsxau0j7OtTsPfP7cD/QiB88tlONg=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=ojRTW46VnMvqW441pkcsACYeRrh7pfXSWzf6w2FufXdcVa+8Ko0uCYfyhRkU2E7aa
	 rn1Y4v5DPqjW27qStJWhWW5DNvN9TzT+7NVYM2lugTrHr98tmbfsph8P6meOtv5F/s
	 S59p1fwlflkDU9ythsFVu6gQTErPB2Gd4DMy3qvKszETr/EbZzO+2pwCcNmzHTGNtR
	 v0DQFjfVVYCWcmT2Bbj2Ik3s2TIx5CoSWD2JSvxAISQkj07iPA91xY8Syb8x9HQ+Lz
	 LRIK/QWdFX4Qnv/9KXuoptyt4/Ga5ctZrsWCvU2ZjyiYlzjIViRm+rUMYjA7j4RJkt
	 UNj0zVrq0oPDA==
From: Davidlohr Bueso <dave@stgolabs.net>
To: jic23@kernel.org,
	mst@redhat.com
Cc: linux-cxl@vger.kernel.org,
	qemu-devel@nongnu.org,
	dave@stgolabs.net
Subject: [PATCH v2 1/5] tests/bios-tables-test: Exclude CEDT.cxl for the CFMW restriction change
Date: Mon, 20 Jul 2026 16:32:38 -0700
Message-Id: <20260720233242.901544-2-dave@stgolabs.net>
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

The next patch changes the default CXL Fixed Memory Window restrictions,
dropping Back-Invalidate.  Add CEDT.cxl to the allowed-diff list so the
comparison passes until the expected blob is regenerated.

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

