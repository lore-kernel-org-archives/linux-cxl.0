Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.94
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794813012;
	b=n8/IQP+8rybjxPbzCUTRBNbhmRCtGEj4/QG5ieQLLNPHUqguYQWj0ei5pCWlBCRFRHPl
	 yTLsreB00DGHVR0dlDYO8dHzTatcqn+oRIJqlilVPVPBZRM8UjmNUERLBVRkZAz7F5SPZ
	 yFFwN6FXdWIaoYdY+zKupXNpnIOoVRcJ8yNq/qDOt0ze8MQ9FHKe8+XtdPbUFEUQvaKEV
	 8qcy0Wr6tMa6hkuxM2YEDI7rTmyU9ox39Zm+2dF/XkeinGresgb8llWRCagQJBebMN79a
	 B/cf7X0LxgyTKTnOb3sM+ib0aEhbIyH0btnQktwuzXvBr3EVI3I4WYxNU5U0pY4+mgg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794813012;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Feedback-ID:X-Zoho-CM-AccountID:
	 X-ZohoMailClient;
	bh=752magGq7IrvWYg97KnOkqOFQl9cdvBx3a1hDh/JWs4=;
	b=CMS6th/PtfRvIEfKmmVGR0h9Pf1lMpCZPFn+JnBhthOcxNEBneohrSePkKjsJjYPMwU9
	 3D/i50KKCgCJctIYTBwtfFNo6p9hpRYjCs7/co5LOHmRjuyeMF941n82mob6m3pfHdl5U
	 SjgAe81AVi/Dn8yPzS6vp56xpKOeK/WUe0rtW6ULO+ZFVUoUjyY7tplXHjm+vfRaaWOL5
	 nOImRSC5UP1mFlKnbB63v5hDxSfHVq1mjZXYl51StIdu0iwMvoAQzEKT0mgQra/iPdNAL
	 NWsiLrf+N2VKJbGy0W2BQ1+sw25M8bb11KWa1+yljvPxNOc+qBO36p22L9fYH635qyA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zohomail.com;
	spf=pass smtp.mailfrom=zohomail.com;
	dkim=pass header.d=zohomail.com header.i=@zohomail.com header.a=rsa-sha256 header.s=zm2022 header.b=Aw0XO6BZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.94
Received: from sender6-pp-o94.zoho.com (sender6-pp-o94.zoho.com [165.173.180.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1830606A33B;
	Mon, 16 Nov 2026 07:10:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1830606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=@zohomail.com header.a=rsa-sha256 header.s=zm2022 header.b=Aw0XO6BZ
ARC-Seal: i=1; a=rsa-sha256; t=1794812999; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=bLH5PxI7iQrUmkGZDwVBh8xI8PiRCu15KqSCC+QcehIrI5EXgRuG9ERyMnt44AuQT+Kns1qr1oKeVwnkWPmRjnv4ZvS/0NK5WhS5ELnr9aSm1g+ZtPkdS/VuiYje3DD9s88wdQz/YdDxcQsrGsrIVmkflFtfoyrLt/pYnnAGRLw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794812999; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=752magGq7IrvWYg97KnOkqOFQl9cdvBx3a1hDh/JWs4=; 
	b=lexAXisJE6O+7mQDYYzRnDl1xAfN03NUIwRrkLv33yh71K1h1thz+R9y7Kj0lT7khImK/C2tzEu/JENbL5xx/yax2T4hh3FyhcRXlx4Eq1NafrhHuVEoDhlytCv9GYP83z3/U87ZI1nH7L9+a8Ai6kbnh2xIeIGzg/duXxw86rY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: a=rsa-sha256; b=Aw0XO6BZMBF08IA7G4mUAjYJhEq3wL38uOTZLv/Y8QHiyR84grnVBBNf5WZN7P8P0N+I0AmtISTFy9LPfRg2/1POLtU+EXJxjNhpbsstt4N7ImLuVDU6BjngNFU8XQVmoRbpP8jLh8vVqP070pPtMIF+vP3OXu9Kyyc+UwvdHF8=; c=relaxed/relaxed; s=zm2022; d=zohomail.com; v=1; bh=752magGq7IrvWYg97KnOkqOFQl9cdvBx3a1hDh/JWs4=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794812997831173.02271146337864;
	Sun, 15 Nov 2026 23:09:57 -0800 (PST)
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
Subject: [PATCH v3 2/2] cxl/mbox: Use mapped errno to determine command status
Date: Mon, 16 Nov 2026 15:09:38 +0800
Message-ID: <20261116070938.3675205-2-ming.li@zohomail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116070938.3675205-1-ming.li@zohomail.com>
References: <20261116070938.3675205-1-ming.li@zohomail.com>
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
Feedback-ID: zu080112275b9909e28fd7d53acbea95190000861468830200391b36135c1ceff1f6d0a5c68d7febc9ba39c4:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External

cxl_mbox_cmd_rctable already maps all mailbox command return codes to
errno values. Use the returned errno directly instead of checking
mailbox return codes separately to determine whether a command succeeded
or failed.

Signed-off-by: Li Ming <ming.li@zohomail.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
---
v3:
- No change.
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

