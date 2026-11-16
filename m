Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.94
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794813004;
	b=QUXBpFUJjgPRHZltAAI5On+cikbMMsVQIpnw1o2+fw0Oe78YJCy7WujqZvC0PK/YfA04
	 PaJC/hHUOiN9OyWBRP+SsR0y2HIYJVg1LilWii54s4H29RPzd7o6ztf216xSakl5Y+DFU
	 ugMnP9zzpHlSCFPmOG/FDScdSEPAj52ZvnEj3BTlSEI0HopdxI5grTgSCXpLxlBoFiGix
	 VWhm2vWzNdQuO1UCHeLje6pRg1RViEwXeRRmLhUt9qBWT5HxISZWhJFmULSnY++RN5bDe
	 bHyIbOG8GI0UWwxIbi8XBaQkfwQMlI3PaZK8Vbx8Q4Xw6vecBbCgqnC94TB35y8bGjQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794813004;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 Feedback-ID:X-Zoho-CM-AccountID:X-ZohoMailClient;
	bh=FvDsm4yRBtWFPT6+W/4xl8vGM4uKtGLGN8dDdVuuu1o=;
	b=gUlImqZ5p2YobmzdFhCYqRUH25xdLX4WC4aoyDTNnpZr2SesRuVV3TH6eBFbxr3wnNoP
	 M9OlJWdVKkoLB88+k3gbdq2Z7LoaSmupA04ZpKQ8diSycJk/5dX1/nOrmYMbmnL6MLrZC
	 vAxzb0iVErFJLY4f0PJmabgN6QpUO3sqdWuAp0hEByC3FK2Gbnz/Ep6Q79tRxEFCNSHPQ
	 9d43bc7MfbSABrWN6RO1OMXRIz/GIAt1altTSCyWovwITqfmOjyEBkE35Ddeiyk1HGVgM
	 NdeFmKqmmWsv0yYeuoORzFZzOR6py6xjTrIXFjdc9YF+fhBY/JxjWdr/r3CsRrkKudw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zohomail.com;
	spf=pass smtp.mailfrom=zohomail.com;
	dkim=pass header.d=zohomail.com header.i=@zohomail.com header.a=rsa-sha256 header.s=zm2022 header.b=IYtyeZZO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.94
Received: from sender5-pp-o94.zoho.com (sender5-pp-o94.zoho.com [165.173.182.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831B0606A335;
	Mon, 16 Nov 2026 07:10:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 831B0606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=zohomail.com header.i=@zohomail.com header.a=rsa-sha256 header.s=zm2022 header.b=IYtyeZZO
ARC-Seal: i=1; a=rsa-sha256; t=1794812995; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=dxjxAUI8874AGVoHw1N8eIdlC8IRhUCQLg0RzCmQ8nzPNA80YBSa3RjxLR26RbKutwhLNlwqfbVqskcAcisLlbvh5f/sBpsqzvFfIJvg68qvKZsaE4xp1jbd2kI5EPxW+vhABi1kuh/Y0RuOLZCBYENGC0/hvJMocEO+vWxEG+8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794812995; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=FvDsm4yRBtWFPT6+W/4xl8vGM4uKtGLGN8dDdVuuu1o=; 
	b=QlzPwJkZvhTsk9lFSenWPgSwZmqDvSVYvOi4DnzkYERkiyEBSMMFLJKyftEy4k+jgz7QVqA65HXvlOrlyxV3as9U0WfJcyUPT+Zdxs+K2+509Ip8LssndCls2+htM8APVVDp63SiwprUOf3C+mu1dMA3bEdW9On9x1nkloYPM74=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: a=rsa-sha256; b=IYtyeZZOAwBTJYOHTusVQhuoI9FFY/Z6bVR4j/l2RZ3/Kyz+wADgEwpRyzw6dYWp1Qn6x+O17l4vm5YV3HTJk7T7cTHlrHhXtb2YmxO7+OybaRBA6NoWKhH4dk6OZsHAqZ1YEqCqStb5qxv66ePH5d3lVx+YeP5lA8EPzSpjYs4=; c=relaxed/relaxed; s=zm2022; d=zohomail.com; v=1; bh=FvDsm4yRBtWFPT6+W/4xl8vGM4uKtGLGN8dDdVuuu1o=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794812993163843.6042632786574;
	Sun, 15 Nov 2026 23:09:53 -0800 (PST)
From: Li Ming <ming.li@zohomail.com>
To: dave@stgolabs.net,
	jic23@kernel.org,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	djbw@kernel.org,
	iweiny@kernel.org,
	icheng@nvidia.com
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] cxl/mbox: Return success for CXL_MBOX_CMD_RC_BACKGROUND
Date: Mon, 16 Nov 2026 15:09:37 +0800
Message-ID: <20261116070938.3675205-1-ming.li@zohomail.com>
X-Mailer: git-send-email 2.43.0
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
Feedback-ID: zu08011227652a2b7829dfa1043a32320000008a75c226003d5fb2256b46a821edf56cde78d90c2405bb3dd1:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External

In CXL subsystem, each mbox command hw return code is mapped to a
corresponding errno value. Currently, CXL_MBOX_CMD_RC_BACKGROUND is
mapped to -ENXIO.

However, per Table-8-208 in CXL r4.0 section 8.2.9.4.5.1, a BACKGROUND
HW return code indicates that the command has been accepted by the
device and continues execution asynchronously. It does not indicate a
command failure.

Return 0 instead of -ENXIO for CXL_MBOX_CMD_RC_BACKGROUND so that
callers do not treat a successfully started background operation as an
error.

Signed-off-by: Li Ming <ming.li@zohomail.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
---
v3:
- Drop fixes tag.
- Collect review tag.
v2:
- Add a reference to the relevant spec section in the commit log.
---
 drivers/cxl/cxlmem.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index c401e3a1af06..cc71d7a84cdc 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -160,7 +160,7 @@ static inline struct cxl_ep *cxl_ep_load(struct cxl_port *port,
  */
 #define CMD_CMD_RC_TABLE							\
 	C(SUCCESS, 0, NULL),							\
-	C(BACKGROUND, -ENXIO, "background cmd started successfully"),           \
+	C(BACKGROUND, 0, "background cmd started successfully"),		\
 	C(INPUT, -ENXIO, "cmd input was invalid"),				\
 	C(UNSUPPORTED, -ENXIO, "cmd is not supported"),				\
 	C(INTERNAL, -ENXIO, "internal device error"),				\
-- 
2.43.0

