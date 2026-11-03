Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.94
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793673803;
	b=c/o4dIc0yeKY9jzkHJRI5hNjgcpDeew2KiENTuAtVC91R9k2umwhBRAUxcKRZacQ6vgv
	 TOXHfms8xnp1euqHpkGmtjTKvfX7Q7aFWV60pAQs5UbyaJ8gFKTP2y8F1SjBChOIly43F
	 uy/xoqL1ZaAneLlu/UY7rPfKv0k/5efWZinmng+p6RY816cfEw5vstnhJRd5PbvOv//mN
	 LnieB4AGJy200e3uIZdIo5+XmF9+E73ltrGXMnkBEZedlfzN8Etou1Uwgkj8p72IzWPAo
	 foDiaCESQosfEKA3qJ66GHSl8l7Zj1AdYtxZrdWLWe3DJmyf/6w4dTkevorl5Zehevg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793673803;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Feedback-ID:X-Zoho-CM-AccountID:
	 X-ZohoMailClient;
	bh=6W6e0wI4QI5/OKg3yZWgk4/j8ia/yQjNrbB3cwr9/QY=;
	b=hd/pkLfLmmAIVHGxucTKbYPS+C2Z6peKJv34UWbyvhpehqk7SC+WMB6mzagRTW2XOJLc
	 68KiZBcYy3jCYqqJnvdEb2lyTp71BVkSayMU0H2gNgl9cPi34LkBiLd07/hhwgFoK2FD5
	 XOepPeRrbvOoPcHa8S7B1vAqbjQj7ZY/KuAA4+5rOuU16kE5ybFt0k0c9Fo6JUcdO4uTw
	 wPAHhGJrSyoqzSbqZjeHKzGEG1hn/zN7RDWlXBImTCBwQS8FOtkHKHvQPYNTlKPoVeUAH
	 I7Q7TSynv9lb6lLAwNHqlBQJBdFAiB2EHlE7gKYU3n13NBNBg8GVF2BfhYxQlow3csw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zohomail.com;
	spf=pass smtp.mailfrom=zohomail.com;
	dkim=pass header.d=zohomail.com header.i=@zohomail.com header.a=rsa-sha256 header.s=zm2022 header.b=PI38M4E6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.94
Received: from sender6-pp-o94.zoho.com (sender6-pp-o94.zoho.com [165.173.180.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30078606A329;
	Tue,  3 Nov 2026 02:43:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30078606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=zohomail.com header.i=@zohomail.com header.a=rsa-sha256 header.s=zm2022 header.b=PI38M4E6
ARC-Seal: i=1; a=rsa-sha256; t=1793673793; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=jmsxHTHf7QkvSJMk1y5EbH32T5RtkIz+udIUGuRtkn1+848/O5BNBp89XpqlIR3lJCxRYMJ2sgi+XcCuRsT44j02nzt+nsP7Ju4QUHSKtInDkU9lRdSjzA2g9gwU+jFh8dr8cpAMa53s0xHU9D7t1PCnR3YWbWRsANlsQVhxjFM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1793673793; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=6W6e0wI4QI5/OKg3yZWgk4/j8ia/yQjNrbB3cwr9/QY=; 
	b=AI34x0acldeNEZ0SxSEQMmk6x1AWwkl+FSN5wvOfLMm20Ccx+khqZk1xB/SldbopKb/fzFY54w5x+WakV/3S9NAehOmdPo9sPLbCz/PD4m1HYZ0c+sUJh0dI9QM2rrGHUc1Ck/7eqX7IRIinQfPWyT5Byy03IxSDp/KEZuviU5I=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: a=rsa-sha256; b=PI38M4E6hTQ9HEoFQbRh1kMTKrNYB/38GOB/KEEEviaqOC9p3oG88sktNyMm6oyG9BoYNDKMBncYKoKIcxRwC3xkt4ITBjwh4veL/F8TEGz6qnHRB/AmSC8suERS10d00Tm+qWbInvTD3Nl/HF6tjmfHvSCoWPUt5ewQ3BMEjys=; c=relaxed/relaxed; s=zm2022; d=zohomail.com; v=1; bh=6W6e0wI4QI5/OKg3yZWgk4/j8ia/yQjNrbB3cwr9/QY=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793673792882862.4540011356563;
	Mon, 2 Nov 2026 18:43:12 -0800 (PST)
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
Subject: [PATCH v2 2/2] cxl/mbox: Use mapped errno to determine command status
Date: Tue,  3 Nov 2026 10:43:05 +0800
Message-ID: <20261103024305.2333508-2-ming.li@zohomail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261103024305.2333508-1-ming.li@zohomail.com>
References: <20261103024305.2333508-1-ming.li@zohomail.com>
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
Feedback-ID: zu0801122777b729a567c8a3f2c91adbd00000694a88e67a62e4306fb09accbed7fd9285027663648eb7ca7d:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External

cxl_mbox_cmd_rctable already maps all mailbox command return codes to
errno values. Use the returned errno directly instead of checking
mailbox return codes separately to determine whether a command succeeded
or failed.

Signed-off-by: Li Ming <ming.li@zohomail.com>
---
v2:
- New patch.
---
 drivers/cxl/core/mbox.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 55828a836c01..bd91b03c4d21 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -270,9 +270,9 @@ int cxl_internal_send_cmd(struct cxl_mailbox *cxl_mbox,
 	if (rc)
 		return rc;
 
-	if (mbox_cmd->return_code != CXL_MBOX_CMD_RC_SUCCESS &&
-	    mbox_cmd->return_code != CXL_MBOX_CMD_RC_BACKGROUND)
-		return cxl_mbox_cmd_rc2errno(mbox_cmd);
+	rc = cxl_mbox_cmd_rc2errno(mbox_cmd);
+	if (rc)
+		return rc;
 
 	if (!out_size)
 		return 0;
-- 
2.43.0

