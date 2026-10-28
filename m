Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.83.209.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793222351;
	b=H6rnlp8lrXCZkdPCxGI4yjPUquRzC6Cf+qED2vvhdfcVW/+Qa51GikqjNsLL+RD5bRx3
	 iI2nzrf+0VJt+QThT3kkB19YPyW/b1v0xPLBrRaH4BYXsT3GlRAPr7033NDWeFvefyv71
	 JIq7mkMZzmRnPYL7GbbfqEjwlm/qprENI5gpXcO1VEIYRK6kGTlKxJhRt+sKg3af/R7Bl
	 54wG0ai1UaBV2Zjxxq/1A5DOlTfpOjimB0+jU1JnhPCwsz2zw70nymPjL7nsla05+a1eu
	 8kj0W0pb3NLpaKuU+xj1X3e2K+X8gbpZxYHjp5JQY9ZB7mXwsgACtFYmhNPnnQjuFtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793222351;
	h=DMARC-Filter:X-Sender-Id:Received:Received:X-Sender-Id:X-MC-Relay:
	 X-MailChannels-SenderId:X-MailChannels-Auth-Id:X-Bored-Troubled:
	 X-MC-Loop-Signature:X-MC-Ingress-Time:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=MLVHR1TaToacfGgBynTFfVp/dF8TU4TCKrrj8uNbtR0=;
	b=XlWg4ZRCXoRfLjIRDgufOuIivP1THZaKio+G098bty+qz0/l+bkP1izDzBiCbbmXFzbh
	 Be2nndm7/q4Ne5H1EK8q3QFtqR/zzusjbAWy1ShjecvSIjFUzLYZerEEamJZ1G7TlgA83
	 WH0c1kur48vsCoFfpD/izLz2A4nF92zDj4M+cOKiXumglR/ON9wExe7f69gyjdfvcVuiG
	 N7SdMwFmxXVgDyoiTj4+fS7/tC2IBnpoec/4bIo7UfmJUnuhiXCylRcCOn//kKgOogg0K
	 mei5BQPdGN9uhSWKWTLo4pIKc6o3K/bcYUTo7lbfjiTsthyIkRhXJtm3LGpeS9NjY5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=stgolabs.net;
	spf=fail smtp.mailfrom=stgolabs.net;
	dkim=pass header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b=iZ5JSLez;
	arc=none smtp.remote-ip=23.83.209.48
Received: from dog.birch.relay.mailchannels.net (dog.birch.relay.mailchannels.net [23.83.209.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AC5606A31D
	for <linux-cxl@vger.kernel.org>; Wed, 28 Oct 2026 21:19:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1AC5606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b=iZ5JSLez
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 2930E382AD2;
	Wed, 28 Oct 2026 21:19:04 +0000 (UTC)
Received: from pdx1-sub0-mail-a254.dreamhost.com (trex-green-4.trex.outbound.svc.cluster.local [100.96.18.161])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id CA41638270F;
	Wed, 28 Oct 2026 21:18:59 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Bored-Troubled: 6d5783cf23248330_1793222344013_1074215436
X-MC-Loop-Signature: 1793222344013:4218349828
X-MC-Ingress-Time: 1793222344013
Received: from pdx1-sub0-mail-a254.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.18.161 (trex/8.0.2);
	Wed, 28 Oct 2026 21:19:04 +0000
Received: from offworld.tailf5af7a.ts.net (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a254.dreamhost.com (Postfix) with ESMTPSA id 4jFKwz1pS7zyrD;
	Wed, 28 Oct 2026 14:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1793222339;
	bh=MLVHR1TaToacfGgBynTFfVp/dF8TU4TCKrrj8uNbtR0=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=iZ5JSLezSSRbA6FdEZ9Kjy2esD+fPsWqyHVWzeC0Ck+bsgMb+JXlnNiGWI/bBEma2
	 /rSI38aVaw6T+gpVkukhKzAYXM8urK8GggUck7yRFwXv+q02RpGEguiyM6wGGypo18
	 VNfpKB9HrsC/cGF4xePMSe78g0digXQL+JIbg/81MTEUHKm5gS/EgC/7Gp/d0ekYSh
	 Eke2kqIa85qrswjciQlZ0q8F6J3sBMTvq7UvDaBFGC2dHFFY5TfvbZQgWqKWbKmEa2
	 UFnvPl0dCUSPXnL3nf7Z54hsq29+iQunP8JH2crujSO2sOXOka5dNJrMEjfrZEGj4I
	 2lJK08M9Vy9+w==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com
Cc: jic23@kernel.org,
	alison.schofield@intel.com,
	ming.li@zohomail.com,
	icheng@nvidia.com,
	linux-cxl@vger.kernel.org,
	dave@stgolabs.net
Subject: [PATCH] cxl/hdm: Account for a firmware-armed Lock On Commit
Date: Wed, 28 Oct 2026 14:18:36 -0700
Message-Id: <20261028211836.939648-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A corner case (yet valid) where firmware sets the the locked bit
without committing the decoder. setup_hw_decoder() carries the bit
through.

A later region teardown then writes a reset the hardware ignores and
clears CXL_DECODER_F_ENABLE anyway, so the flags claim a decoder is
free that still decodes: cxl_dpa_free() releases its DPA, and a new
region committed on it appears to succeed, cxld_await_commit()
returning as soon as Committed reads 1, while the old mapping stays
in effect.

Read the control register back after the commit so the decoder is
treated like one found locked at probe.

Tested on qemu modified to enforce locked semantics, setting the bit
behind the driver on an uncommitted endpoint decoder, committing and
deleting a 256M region on it, then creating a 512M one. Before, the
decoder sysfs reads locked=0, its DPA is freed and the second region
reports committed while the hardware still decodes the first; after,
locked=1, the DPA release fails with -EBUSY and the second region
cannot allocate DPA.

Fixes: 176baefb2eb5 ("cxl/hdm: Commit decoder state to hardware")
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
Found while battle-testing BI locked decoders.

 drivers/cxl/core/hdm.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index fdcef20e01ba..d23076aabb89 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -856,6 +856,7 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
 	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
 	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
 	int id = cxld->id, rc;
+	u32 ctrl;
 
 	if (cxld->flags & CXL_DECODER_F_ENABLE)
 		return 0;
@@ -899,6 +900,14 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
 	port->commit_end++;
 	cxld->flags |= CXL_DECODER_F_ENABLE;
 
+	/*
+	 * Lock On Commit armed by firmware engages on this commit and
+	 * makes the decoder read-only, like one found locked at probe.
+	 */
+	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+	if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
+		cxld->flags |= CXL_DECODER_F_LOCK;
+
 	return 0;
 }
 
-- 
2.39.5

