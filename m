Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEA821D5BD;
	Thu, 27 Feb 2025 10:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740653186; cv=pass; b=PmHU8/oxoolCg8Zl16Zfxm0aCa5RsjKZR8FwUsoaJAl+Dz7X1Zbl7I8xB6dwhpctPcD6mH3Nc8KaSxpizT0TmkEQu6cq6gj59VcLS3YkAnsTVFN44Zb0s14T3aS71Utd9qW853hkb7RupliNHDKBtjYlsd1B/ZOWA3MMGd+AJSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740653186; c=relaxed/simple;
	bh=jErgEQ+TUOucGrZZAhpmYkoPvjxC4e7WR4Mn6W94J2k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f3MNoecjo3JU9BYqVDpv43fS8uJ7kpkPoACMFofo9HBE8+HO3QoAJDISE1P+6CPlEFkRuZ4MF38ih/+7UZo9PGoflaZ4MZxSQHbznB6MXWKsNqsm35JjX0WyLFilQwjaPruWVYbqN180LxE4yEAJcn4JG3dNIcwaRKjwB87Joi0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=F1LekHHU; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="F1LekHHU"
ARC-Seal: i=1; a=rsa-sha256; t=1740653169; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=dg8P0nJK5JPcFugLoKt0xIYPkUVtQmKGkV5bvVaHL7tlGB4Hr65TunHF6Sdi1ndX3A44gl8lyvSF3J7wOonIBUeCbfsrkSDI+/A91WtVWWSE2jd31VUEUnUdnbdhiSAGKNb9vb0gni31QF+F5ZfMu/KNYMFY2SJB8qEF9Yk8WFI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740653169; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=P07Y9+em6TQ0YpcdOuQLsw4N5WzWQShNoV6rX/vAwp0=; 
	b=jpDQ2nVh/ReuUm/frgAKuagA7MbowZmgAdWZLGy+/vvPRkX2KiS485MU9OyUBsNfaHl73jBDd4DJH8Jup84r2PeBXMPXU3eKLxaGYvoS7hG3yledjb/MOPHsPsmaTWXKWsg4/Zoa2cw/CoLWSZqJZDrXvGH3PYjLiJcvmwboHB8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740653169;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=P07Y9+em6TQ0YpcdOuQLsw4N5WzWQShNoV6rX/vAwp0=;
	b=F1LekHHU+XYWrxz2ToxORCrdnh/pnLbGUsDiRy8eDuaNOBS6WX8UD2wUva8AsdXz
	GrCWdOwTWQNSAs/tQ1b3zRBGQQmkBx6lTMHIlj0snGQlsaqw5KEpueQJ9LlUtlDqSjJ
	rS+Yt3OjF1iQUVdKCQiPcfz1DTG5fYg4Wlf/iW4Y=
Received: by mx.zohomail.com with SMTPS id 1740652387816361.8871097135559;
	Thu, 27 Feb 2025 02:33:07 -0800 (PST)
From: Li Ming <ming.li@zohomail.com>
To: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li Ming <ming.li@zohomail.com>
Subject: [PATCH v1 1/1] cxl/hdm: Verify HDM decoder capabilities after parsing
Date: Thu, 27 Feb 2025 18:32:51 +0800
Message-Id: <20250227103251.390147-1-ming.li@zohomail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr08011227c0943d90364cb82e43977bd3000036146dae4918cde90a0f48e2b54b1f01c60f3825064a82e4ee:zu08011227d3f19496acc2fe87961957450000a1e5773b687733c8bf686330abbf024704b5232d2550ba6eff:rf0801122dd0313017268c95b673f66f9f00006272b51ab9fc857ccf2ea6766b3c7c171d5b8fab80748d0d6dfa19fa842c50:ZohoMail
X-ZohoMailClient: External

devm_cxl_setup_hdm() only checks if decoder_count is 0 after parsing HDM
decoder capability, But according to the implementation of
cxl_hdm_decoder_count(), cxlhdm->decoder_count will never be 0.

Per CXL specification, the values ranges of decoder_count and
target_count are limited. Adding a checking for the values of them
in case hardware initialized them with wrong values.

Signed-off-by: Li Ming <ming.li@zohomail.com>
---
base-commit: 22eea823f69ae39dc060c4027e8d1470803d2e49 cxl/next
---
 drivers/cxl/core/hdm.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 70cae4ebf8a4..a98191867c22 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -138,6 +138,34 @@ static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
 	return true;
 }
 
+static int cxlhdm_decoder_caps_verify(struct cxl_hdm *cxlhdm)
+{
+	/*
+	 * CXL r3.2 section 8.2.4.20.1
+	 * CXL devices shall not advertise more than 10 decoders,
+	 * CXL switches and HBs may advertise up to 32 decoders.
+	 */
+	if (is_cxl_endpoint(cxlhdm->port) && cxlhdm->decoder_count > 10)
+		return -EINVAL;
+	else if (cxlhdm->decoder_count > 32)
+		return -EINVAL;
+
+	/*
+	 * CXL r3.2 section 8.2.4.20.1
+	 * target count is applicable only to CXL upstream port and HB.
+	 * The number of target ports each decoder supports should be
+	 * one of the numbers 1, 2, 4 or 8.
+	 */
+	if (!is_cxl_endpoint(cxlhdm->port) &&
+	    cxlhdm->target_count != 1 &&
+	    cxlhdm->target_count != 2 &&
+	    cxlhdm->target_count != 4 &&
+	    cxlhdm->target_count != 8)
+		return -EINVAL;
+
+	return 0;
+}
+
 /**
  * devm_cxl_setup_hdm - map HDM decoder component registers
  * @port: cxl_port to map
@@ -182,7 +210,8 @@ struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
 	}
 
 	parse_hdm_decoder_caps(cxlhdm);
-	if (cxlhdm->decoder_count == 0) {
+	rc = cxlhdm_decoder_caps_verify(cxlhdm);
+	if (rc) {
 		dev_err(dev, "Spec violation. Caps invalid\n");
 		return ERR_PTR(-ENXIO);
 	}
-- 
2.34.1

