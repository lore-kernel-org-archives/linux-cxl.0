Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8123B2FFC;
	Wed, 18 Mar 2026 13:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773838917; cv=pass; b=BGsbssThTsFjq6X756ffRZdY8EVHoO++F37AHzFqxvjlbi7TzFuthreP1/xS8x1qlLD5DnI3Lb83W65/5JUd2R60cJowvboNwUj67IFr1M29rgAFWW4jWgCEfAAFVmSdPdfOwb2kZwX0lEJ1ADsSU2VVx9kD+pZaX6LJBIr8UYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773838917; c=relaxed/simple;
	bh=S2u7BSVpqBze9Gms0Al3dxuqY4AFCIDfjT14/dfgO1k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=A3iQ6QEVn2+fyr2eC+pUqKI6jFYNW4p0ne8JZljSJT0NFNqBaBaTa1Ej0AirdLCio1oIDubZNAvKjLchwm3Zyr67M3B9/lTcfLF5myQ/XcG4x/GE5UDVI8Vbrvsz02q2lHYqTZDcMqSVmpU43tt8dCWK3c9I7LwGxRGl//Iq8hg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=KJk4jtSh; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="KJk4jtSh"
ARC-Seal: i=1; a=rsa-sha256; t=1773838900; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=JEUnmSjM3CAb5RvWeOTlMYn1FPDlF9vxfm8BaAzdB+Ggx06ySg+WqQr2oCS/RJEn7KspU899rRKRg8ZVCgoUtX9TU8Ej1b3/Go63Xp6V20tsj7fx6WcHIm5MGstTv0VvB7q3vrW5TQdyBCjKDVBWRsUXZGNyKvDhhnLIZpCGMHc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773838900; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=UzJhqXB7qjjEzePbxNJja1KmjuRik85abye14WER2ws=; 
	b=SgyOmJEXJpjf6sDaLB5cJhy2pWJ5eadym/7AcXsHCTfUAya/uGo5zay7gXKIsTWzPAshXV7O3m2QlHB5vFXdu49wSKv+eOuYrqypQacY2LBSjxfPRn4hJEJX4OQUA/Ap6P/k6vux0NpW7p/jY9oO38/f4eEJSkLoXpNkoa6QGs4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773838900;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Cc:Cc:Feedback-ID:Reply-To;
	bh=UzJhqXB7qjjEzePbxNJja1KmjuRik85abye14WER2ws=;
	b=KJk4jtShaTGe7PnJLpfpKP68hhvmB2eHrTBGZnLV2f4tMH3JT53Le6XQpyML+vVr
	kmf7/jzHIkrp+r6oNZufU8Y15oWD8YCFitR2Fje+d964oD0jbdbnEODQI6TCP4tn9DG
	yPb4uWLKtaBFqsllTAMXY8VUrgxYXCu58BMvo8pg=
Received: by mx.zohomail.com with SMTPS id 1773838897404473.9337669467926;
	Wed, 18 Mar 2026 06:01:37 -0700 (PDT)
From: Li Ming <ming.li@zohomail.com>
Date: Wed, 18 Mar 2026 21:00:21 +0800
Subject: [PATCH] cxl/hdm: Add support for 32 switch decoders
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260318-add_support_for_32_decoders-v1-1-bb7b41efde2a@zohomail.com>
X-B4-Tracking: v=1; b=H4sIAOShumkC/x3MwQqDMAwA0F+RnFewtazTXxlSShO3XGxJVATx3
 1d2fJd3gZIwKUzdBUIHK5e1wT46yN+0fsgwNoPr3bMf7MskxKh7rUW2uBSJg4tIuSCJGp9CDmH
 0Y/IW2lCFFj7/+3u+7x9mxXHIbQAAAA==
X-Change-ID: 20260318-add_support_for_32_decoders-4a7c77949a41
To: Davidlohr Bueso <dave@stgolabs.net>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Li Ming <ming.li@zohomail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773838892; l=1229;
 i=ming.li@zohomail.com; s=20260210; h=from:subject:message-id;
 bh=S2u7BSVpqBze9Gms0Al3dxuqY4AFCIDfjT14/dfgO1k=;
 b=+tnLHTyyyQov+kFLZtJE58herebz0cAsXMYuIsOofZ00tCAZFBpUTggjqimeLyFqRM4mhiNCo
 ywIpOJHbnSFCqqk2mfGbqESXNrap8BMJlgqAVNwkpVSe6swLRBhKNro
X-Developer-Key: i=ming.li@zohomail.com; a=ed25519;
 pk=JfhrdHjyYJMXt47Hy8d/fsqZuhGPD4Z3whV5lTfVvhE=
Feedback-ID: rr08011228230f56f4e4e71b618117549d000049f7a357aa1eea5558616dc9e6e08af4b0a54ce20a5db6f5b266:zu08011227fc1b4f77b7da7a6a18ac4dd9000094859a651deb50de223ca78794364f54083fdc423d2a0c22c6:rf0801122d4505782e8b44f7c5b80dad130000ff3cc383edbfb782156ff40b1eae327bb212796bfc7e23f72c28501d5c5d1c:ZohoMail
X-ZohoMailClient: External

Per CXL r4.0 section 8.2.4.20.1. CXL host bridge and switch ports can
support 32 HDM decoders. Current implementation misses some decoders on
CXL host bridge and switch in the case that the value of Decoder Count
field in CXL HDM decoder Capability Register is greater than or equal to
9.

Update calculation implementation to ensure the decoder count calculation
is correct for CXL host bridge/switch ports.

Signed-off-by: Li Ming <ming.li@zohomail.com>
---
 drivers/cxl/cxl.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 9b947286eb9b..466b8eeefed7 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -77,7 +77,12 @@ static inline int cxl_hdm_decoder_count(u32 cap_hdr)
 {
 	int val = FIELD_GET(CXL_HDM_DECODER_COUNT_MASK, cap_hdr);
 
-	return val ? val * 2 : 1;
+	if (!val)
+		return 1;
+	else if (val <= 8)
+		return val * 2;
+	else
+		return 4 * (val - 4);
 }
 
 /* Encode defined in CXL 2.0 8.2.5.12.7 HDM Decoder Control Register */

---
base-commit: f338e77383789c0cae23ca3d48adcc5e9e137e3c
change-id: 20260318-add_support_for_32_decoders-4a7c77949a41

Best regards,
-- 
Li Ming <ming.li@zohomail.com>

