Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.94
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793673798;
	b=HjPau8uZLtt49WxgKFbNSrdCf2j4A4YIfKD2pIza9scd/9aKh58mvldADsOzXIu4Cn1a
	 RXcdnOtZL2omSG/WbrI9omkJ4mgnqV4Qi+bJAaA88YfKkfDgW4lAhGGWYTk2oe6Os6K3N
	 6RCbLeNlCEcc2R2Tv7xkZFwusXIdT/xWbz+WrYKyA1pSdtlfYKnQ/8tF9+/PLrey4lwTs
	 kygcAKI7Qp8rjUhLHaCZj7dpqbyAfeN47mCfn0bgQJlJpRBn93wHERnV9vw30taqkLpHf
	 utN3kEi+PO9vQZ9ZLPbVZ5G99efhXZYf/+gEfKdNWEXQkC5jqQMbC65juJX6pzPMbvg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793673798;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 Feedback-ID:X-Zoho-CM-AccountID:X-ZohoMailClient;
	bh=Ac9wcqw0N1NdkwYzXlPFIvlGhWFuWiTfi/PMncvpwfQ=;
	b=EjbjG+vEtn6cNyu1ddi/szFFLzHCRQu7z/+BWPYNF21Zpm61WLA3+5X5E0yg022qejfl
	 Sp3UPsWp7uQ0spYbWg1Thg89EAuojx16RpjYuL+junMLWTNmwJm6rwByS3N2R2k+XP3Dv
	 I++mc4iFa2YiS1IRvVlTdub3JX67L3vBjaJ/HWetedoOrzdVZDFwTxvv3or0a8ZBqHBoJ
	 1s3OvNn9ayyo/3OM9jdtqC8nsk7QAi3cefY9wbdy9QN/vJI3J4aRxvK70lQW94ivHiyBo
	 cnZM33fcRj0NTIPKBMwdBGA1li7wI0P4fFN9iWYOisEdB1hVQ+uNu/6ZW0aK29qXSqg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zohomail.com;
	spf=pass smtp.mailfrom=zohomail.com;
	dkim=pass header.d=zohomail.com header.i=@zohomail.com header.a=rsa-sha256 header.s=zm2022 header.b=XbHmqVRR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.94
Received: from sender5-pp-o94.zoho.com (sender5-pp-o94.zoho.com [165.173.182.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383CA606A324;
	Tue,  3 Nov 2026 02:43:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 383CA606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=zohomail.com header.i=@zohomail.com header.a=rsa-sha256 header.s=zm2022 header.b=XbHmqVRR
ARC-Seal: i=1; a=rsa-sha256; t=1793673791; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=aI2Pj82xbTWNLdZazmGlyNQz6bu2C6H1VDam1L+lDPkWFBAXzKSH2BpG+uum9lmib6ouj5MZlY6YdxEUhfYVDA5OgNPmYCkdECQimI0EFFX+UbSnW87FSdI5sulHt1ELyYRepS1IuulnyI+M0z5avz6nfXRbDIIx2/hOu5KPzJY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1793673791; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Ac9wcqw0N1NdkwYzXlPFIvlGhWFuWiTfi/PMncvpwfQ=; 
	b=eTea5ku4ABZgzc9jHHJprLZMjYsO+QO9G70IkKa9wdFn83Q731HRJNXVswGN5tH5QwLSt9pCmHko4AHs5jkoTo8kuzLWpNVMlB4JGWx0pizBYQWqM5A99wT7EwTSLXjIpV9STQxjWNl12dud9sR/OAun/g91orWBEq9JPT+QsCI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: a=rsa-sha256; b=XbHmqVRRA42sG71WGnkE4Ki2vJYqX2FO33vMxxvlQWVKpUhETgYdzaLRqODvjnZ+dGUREdjoA3FWq+LV26SOV7yIpwSdmB+jjzxFNdQSp7hRy/rkg+ooCxh7Y/FfZwmDahyiQoFCsBzvczya/iMlETsCPNW+TvXK0Otmcszw1Ec=; c=relaxed/relaxed; s=zm2022; d=zohomail.com; v=1; bh=Ac9wcqw0N1NdkwYzXlPFIvlGhWFuWiTfi/PMncvpwfQ=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793673790038266.48729951782275;
	Mon, 2 Nov 2026 18:43:10 -0800 (PST)
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
Subject: [PATCH v2 1/2] cxl/mbox: Return success for CXL_MBOX_CMD_RC_BACKGROUND
Date: Tue,  3 Nov 2026 10:43:04 +0800
Message-ID: <20261103024305.2333508-1-ming.li@zohomail.com>
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
Feedback-ID: zu08011227da2b39c69005b22d0fb279a700002f8a14b11e10e28b14e236c5ad7a12f2e71dd325d86d575c42:ZohoMail
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

Fixes: 92fcc1abab09 ("cxl/mbox: Improve handling of mbox_cmd hw return codes")
Signed-off-by: Li Ming <ming.li@zohomail.com>
---
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

