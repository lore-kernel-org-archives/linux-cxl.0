Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.83.223.166
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793304866;
	b=XpK7LAwhP76xfGpBCgJHJ39hebdaYceE1rRbTmeMKj9gGtiKzOEVhGqwzvK10xo23tBr
	 EpExLPx/DCCpcdNPzXt/PzKQlLJiFcnXl4mr0HLKp19L7ucSdLyZpKU2Rn1fz/yOtJvfL
	 yWEF9NHiyVGftB94rP85OukJiMsIRYbIpJUUD/c2j3nARSUkGvIqPvAXxzr6AP7qVwJqn
	 q0fHVBdXkAxy4mFEvNMCjegxw0yj0RjvLC6+lX6pQwSBOtcp8shl6kBtEzxrc5ayT4Fmw
	 TeuAPi0dMTB9A7PQEqpLwjEDNLJ+g12haEagO6fdu24YmyEWlJ6QYDf3gqK82n66vzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793304866;
	h=DMARC-Filter:X-Sender-Id:Received:Received:X-Sender-Id:X-MC-Relay:
	 X-MailChannels-SenderId:X-MailChannels-Auth-Id:X-Cold-Battle:
	 X-MC-Loop-Signature:X-MC-Ingress-Time:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=i6RKODoDUkc7uRDqYTyKQ3eGPdaCQ8LzwdUOfqmZNQw=;
	b=CXJDWyEwIVZMoGYG5JOKqMfsrBaXRqAiQiDAW/ghwVTjtOf87hLVKGwk8tN+qWckcDMm
	 N6lvdg9NztfU3rO4Q2Wnb/U5ki2q4vhvErq9pVYAkPfnE/Ubw8hz3CVIURZMxj0yd0NwK
	 KuyP5bncXlGMZGzC+2TIbRRuxsrATVL/8QbBgLLOWXX3DMx7FtbeSXMvC8JBPIR/01DnI
	 IqofnmrjKSBALlQgHYsEPNoF4iZnx3clhZij2Hw3NMvPJ593Eq4QmGUicIS6U4T0q1aiU
	 iVLVxU+JnVW5Eo3VijLDKDSCOqSsXlmL/vcsXaEYUtYW0qYuM3CGFo8IXvZEphd4DrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=stgolabs.net;
	spf=fail smtp.mailfrom=stgolabs.net;
	dkim=pass header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b=gLB+TDgY;
	arc=none smtp.remote-ip=23.83.223.166
Received: from silver.cherry.relay.mailchannels.net (silver.cherry.relay.mailchannels.net [23.83.223.166])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F41606A31C
	for <linux-cxl@vger.kernel.org>; Thu, 29 Oct 2026 20:14:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65F41606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b=gLB+TDgY
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id A2707641E57;
	Thu, 29 Oct 2026 20:14:20 +0000 (UTC)
Received: from pdx1-sub0-mail-a221.dreamhost.com (100-99-186-176.trex-nlb.outbound.svc.cluster.local [100.99.186.176])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 3CA15641EEA;
	Thu, 29 Oct 2026 20:14:16 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Cold-Battle: 08705f602857e204_1793304860457_4048901475
X-MC-Loop-Signature: 1793304860457:3589132790
X-MC-Ingress-Time: 1793304860457
Received: from pdx1-sub0-mail-a221.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.186.176 (trex/8.0.2);
	Thu, 29 Oct 2026 20:14:20 +0000
Received: from offworld.tailf5af7a.ts.net (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a221.dreamhost.com (Postfix) with ESMTPSA id 4jFwRq4176z1Z;
	Thu, 29 Oct 2026 13:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1793304856;
	bh=i6RKODoDUkc7uRDqYTyKQ3eGPdaCQ8LzwdUOfqmZNQw=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=gLB+TDgYW9KqmSL7mtEi7xFT4taDKhaj6Ah8Sq24CF215SN1QkANWMDvEh/yKLn5L
	 zGLhc7NOxkmn7gHSjloOv/57Gb3DFUfPmltN+kWfDAa5biOqXf9QqVzZQbMZ5JCCxB
	 rJFji7+zOf96axlae9HPIOcGvjNrzpUBIk7UXXl/vQRIBWYUrokZ/LWDw42YizxQPs
	 eKXCEmMuOTToX4nFN8bZ2fr+bCi7T6fBqVMF7IBoDrSIaW0n/SXYaTLmpOqVdIC1HO
	 pIekoqzTtWftC91DvBYaRIg9+3KeexFI1XXLuRK/ylYu4Jc7xu2iR+13yTZCD4myFD
	 SYYGWcKzvOR0Q==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com
Cc: jic23@kernel.org,
	alison.schofield@intel.com,
	ming.li@zohomail.com,
	icheng@nvidia.com,
	linux-cxl@vger.kernel.org,
	dave@stgolabs.net
Subject: [PATCH] cxl/hdm: Account for locked decoders regardless of commit state
Date: Thu, 29 Oct 2026 13:13:27 -0700
Message-Id: <20261029201327.1119231-1-dave@stgolabs.net>
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

Firmware may arm a locked decoder it leaves uncommitted, a corner
case albeit a valid one. Enumeration only records the bit for committed
decoders, yet setup_hw_decoder() carries it through and the driver's
own commit triggers it read-only.

A later region teardown then writes a reset the hardware ignores and
clears CXL_DECODER_F_ENABLE anyway, so the decoder looks free while it
still decodes and releases its DPA.

Record the bit regardless of the commit state, such that the decoder
then reads locked from probe, and a region built on it is locked at
attach.

Tested on qemu modified to enforce locked, arming the bit on an
uncommitted endpoint decoder before the endpoint probes, then
committing and deleting a 256M region on it and creating a 512M one.
Before, the decoder and region read unlocked, the DPA is freed and the
second region reports committed while the hardware still decodes the
first; after, both read locked from attach, decommit fails with
-EPERM, the DPA release with -EBUSY, and the second region cannot
allocate DPA.

Fixes: 2230c4bdc412 ("cxl: Add handling of locked CXL decoder")
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/core/hdm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index fdcef20e01ba..a34f3509ab1f 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -1064,11 +1064,12 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 		.end = base + size - 1,
 	};
 
+	if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
+		cxld->flags |= CXL_DECODER_F_LOCK;
+
 	/* decoders are enabled if committed */
 	if (committed) {
 		cxld->flags |= CXL_DECODER_F_ENABLE;
-		if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
-			cxld->flags |= CXL_DECODER_F_LOCK;
 		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_HOSTONLY, ctrl))
 			cxld->target_type = CXL_DECODER_HOSTONLYMEM;
 		else
-- 
2.39.5

