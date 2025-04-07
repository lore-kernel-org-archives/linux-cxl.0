Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B21519C56C;
	Mon,  7 Apr 2025 03:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743997288; cv=none; b=rfbh46VuwO4FVzzKZeofrpDmotOmw0bJqUisblPoH/b4Gpjsnv2Io2Vqb4jtiKAaB1i+cyiyV+JZ6Dc4mFjffAuxW7SSd1Nu5iMYZkWQuYlCc44we9DfN77GzdTkXJrJOTmttC4Elmg2fCU2dJytTZhM7qx5ypQwif+JHXUp/sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743997288; c=relaxed/simple;
	bh=NTcXbwL38vSSci5+YhVl3tBxzGp8Y0H+0Y7TGDB18uI=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=hF2h4yRhuT/v8+JJ/RivTlCOx1eiXBuz+12pWZ9Vdy5jvNN3/aKpT1aIeqzxSFqFEHqoiutEJqLmviaiWz3sWuax2w+KGEVCvKmxe9+VgTONLQwHJyJwZglKH108agz1BqDDNqQcKpvzo2I61sbB/vvewhyDQGV+wiyGdlTFo5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=B/4JOgPX; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="B/4JOgPX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1743997275;
	bh=IMyxFJaKvKwRxiYIQy+ytQiD9LwsVii5JDrZLSDOAwE=;
	h=From:To:Cc:Subject:Date;
	b=B/4JOgPXIdZXq29t868/HE+5KKRpyI2VRuuSFippMBKyqeMhXFRxOyPKMjYB4Lft9
	 f3gqbK1TBjc7tn6KfAPIA3xsYlyDz8GlOPD+kh6hj0Ne00DB9oFw3wPv/72zs6jOyu
	 XnQioUZjTAElVlc8tAPTEHWw6rZYGjsUuP7OrKQw=
Received: from localhost.localdomain ([116.128.244.169])
	by newxmesmtplogicsvrszgpua8-1.qq.com (NewEsmtp) with SMTP
	id A4CB78D9; Mon, 07 Apr 2025 11:41:12 +0800
X-QQ-mid: xmsmtpt1743997272tz6le7j9g
Message-ID: <tencent_30DA5E4827F37333AE881122DCE054DC9008@qq.com>
X-QQ-XMAILINFO: NC4p7XQIBeahjaYmoLWuFHbLOJ3LvuiNhOfLjN3PcP2V1vecPSyDU69tYRm4Cp
	 jD8Yw/gj1i2kDhjVxQ2mwzYlZkdI8z1PNcEPYa0vyeHSwGdfBPgygvhLd9MRxif+WZVZp9WEWPMF
	 4jYb0VSNqvDNCDy1OfN/aNdg1wqiQOzYZeDU2XTJy+z3P2sRPVb7QZMlSAc8Q/urzmDYXdAJTteH
	 UXZp5uCfit/qJ+jThoytz8EosQO68X2d5mF21GbQqJSibKXkWEg6L/S72IVRPBHYDJYPVjlc2LrA
	 lYnHY4Xi4D09AwjrlfqMsz6Dga8ZBoVFvgOQU/bFbd12l/TZDnLDdcyJ8b+gKYXrmVELQYxEb3cu
	 /qPgJrI4kAcicwdk4zH70A692LI2AXxjIZFwzc70MyYjBOlUqhWveyVEsWqKL5vckd5OL5zw1upG
	 sfFDQfrkARBVtaDF/Ibgtiv7OuOSTVYyJBTVv6NdsvtnQz9o0dOmqTJgVtwSp4av//3yN3d7qmD4
	 zdGKU4fj1W8r0BlFMgCbakDWAv8pcucx9oJn/qppJ2+U+gR2LXhZt4jh4v5M2o+sYAtyllb+xSTc
	 6IjDihGDMBN1ZcHJBX8q+4pZtA1V2w+riwUrPAFu5pr88B4AdL6h5/OCchImGIVjk0NwoZO+mEBj
	 Dri1o0h6gOW5z8v8JBkGF6l3VDk2M0dOJLGDCSMSs6wbf2WXBGSSKJckWg02JFmhw8wQv+rJ5JEu
	 /iJCTItnB9Qea5Gva4sLgDwnzbuiZRmjzSrPdlXdIakClcTZKKNowCFTXwZYOC3DkReZS1W0Y3iZ
	 C704Ygw5t0PYcSZUY75sVbFTWPiKtKaqTOHgf8htfYVuwjIvli/GeeBK3AvGmhgVDV0gx0rqXqLR
	 ZEcaSpiGehKiXcuJ6DA1w89cmNNF9QLRbegkjclSMAMMy1pYXu2RduKb/gDYs6UNDUaQNtTTSQMY
	 yWdLHyZHoMN9JojaGMqLM4tuKBtt0/gCBivK+czp0VwWx+mZ+1GQ==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: xiaopeitux@foxmail.com
To: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Pei Xiao <xiaopei01@kylinos.cn>
Subject: [PATCH] cxl : fix cxlctl_validate_hw_command() warn: always true condition
Date: Mon,  7 Apr 2025 11:41:09 +0800
X-OQ-MSGID: <a9ba95dc9e845c538438d0a062707a819d1f3232.1743997152.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pei Xiao <xiaopei01@kylinos.cn>

smatch warnings:
    drivers/cxl/core/features.c:441 cxlctl_validate_hw_command()
    warn: always true condition '(scope >= 0) => (0-u32max >= 0)'

remove always true condition.

Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
---
 drivers/cxl/core/features.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
index f4daefe3180e..fdca93c984ce 100644
--- a/drivers/cxl/core/features.c
+++ b/drivers/cxl/core/features.c
@@ -616,9 +616,8 @@ static bool cxlctl_validate_hw_command(struct cxl_features_state *cxlfs,
 	case CXL_MBOX_OP_GET_FEATURE:
 		if (cxl_mbox->feat_cap < CXL_FEATURES_RO)
 			return false;
-		if (scope >= FWCTL_RPC_CONFIGURATION)
+		else
 			return true;
-		return false;
 	case CXL_MBOX_OP_SET_FEATURE:
 		if (cxl_mbox->feat_cap < CXL_FEATURES_RW)
 			return false;
-- 
2.25.1

