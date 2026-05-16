Received: from serval.cherry.relay.mailchannels.net (serval.cherry.relay.mailchannels.net [23.83.223.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B470F283FCF
	for <linux-cxl@vger.kernel.org>; Sat, 16 May 2026 02:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.163
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778898078; cv=pass; b=rdkj7TtZ3tMA/sC2rV/Ov8QnNDJZOyCY6k7aQi6vpIY01ySunhL8xTpcVmeJoq0lvk/CHs0ftuCk/suelsX935HYRkt/k4Y2gECV0u43WI/h1hYwjlPqx2XEk82ehocCVfxb2GG8VKotDpXqItloJ54krozRhSr/6EOPgfNuCAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778898078; c=relaxed/simple;
	bh=TgMm98slRRwTb7aHGTjHcX8pW+l9l87ICN2+Jpu4cGU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UvpXRd6DvlM7v4uiVnHSGMY89XFNhvhk4iAWJvldshB7iqIlJc4L2bLqdWu3w7qezmeo1YYLgQqCkrK646f6kV7dV3Tcks01MLheUKrxmFUU6tWkOGuPXEbkx4O6zPFnQaQegbV+R2GKYnbQFn9bUIJDWvmxXeXAiXR1o8zwMOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=O/Fj+Jag; arc=pass smtp.client-ip=23.83.223.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="O/Fj+Jag"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id B05C7941B14;
	Sat, 16 May 2026 02:21:11 +0000 (UTC)
Received: from pdx1-sub0-mail-a238.dreamhost.com (trex-green-5.trex.outbound.svc.cluster.local [100.104.5.234])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 55CC094171B;
	Sat, 16 May 2026 02:21:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1778898071;
	b=fNQxQtm251naMzdH3T/fVEhQoyk4mgfQywJdxEMZsyw9VQPDHwtazAW11XrpxUZv94I/7E
	fo5iHBdODa+yCepvY0MlPTfpE4vjE1ROTIPYIzyb47jCk7BXCnycNUUPEf/nvcbab9Q493
	hm8DJD1RscMbb4PlKPfqcgV5jZil3ueusaDZzKqYEVlbdixgY71Q+cCPeTA8CRZ/wMFeJs
	eT6jjygKYb0qzfRq8Q6Lt95duoqzDYDZ2NiUHraXaw2lwYBRSec+cgORfMDkul2hJrV+Xx
	C9TNTqY+wnLSQaZtH6qEEcLWJFTGBkzQX2LmGzx/cpGdQUKDHadbmizVb2QE5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1778898071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=wEJoRvcnnfad7nY25yU9qnR7t5UDc94CqCZwN8O7gH0=;
	b=cwS9BDRgvtwQVAyh095OVYq4mFs03Q9NkW+KtujspKrACoY+MDAnbqqrbAa8E+a5lNbbUz
	KiIvU3trjORrDfpgtkBN5l8CafsBuAebkg3AJxOlHMCyQdZHu+AJRZKvL76WSERDyLSVwF
	406OiiRDJmwxo5tzLmkpgG3yIw1RIA5DT83oTknbJReepnSAVgvyZns4CvmcinH/dRLH+M
	IBHvabxt8W53X88aAGBXcimL2CjZoWVpPXuwFGhfSobi1LJKVcrLuDRTX/sDTYvZQrWrva
	A1swe4+g6X/ujDzWCq7Xh4Y98A2VJoalZgGkz0bBhyw83tNpBzLGyTAcMz/rWg==
ARC-Authentication-Results: i=1;
	rspamd-79cfc4d687-89c2h;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Cure-Society: 268317a36e62be8c_1778898071641_921759477
X-MC-Loop-Signature: 1778898071641:2259644677
X-MC-Ingress-Time: 1778898071640
Received: from pdx1-sub0-mail-a238.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.104.5.234 (trex/7.1.5);
	Sat, 16 May 2026 02:21:11 +0000
Received: from offworld.lan (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a238.dreamhost.com (Postfix) with ESMTPSA id 4gHSVG4F7CzyqP;
	Fri, 15 May 2026 19:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1778898071;
	bh=wEJoRvcnnfad7nY25yU9qnR7t5UDc94CqCZwN8O7gH0=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=O/Fj+JagVDt9/rFki96cvykOtcGyqIFi5FTESEwea9x5aC50QfESPzUAuPNKyFCJn
	 84NqLSYe0cl7ZECGbKyiWIo7LTLQ3OwdFZrdcpqCehf2OhWoU5Ag/B4NOSGMnzOGRU
	 PbgzpmD/B5+AzJ8n2QEYUq5ZS0RKZot94WsSG4g85OdKt/wXfkepvVGys2L+S6RRkO
	 wKuALsa107/uhaOqjKCtig5pjBsKzYtjD4xjmTnJ0dEnP++d0eXMURKSPMCbDqwxJK
	 wHW8I7dSq980PKluBojRJO4RWFeZ2JKqZAUldz2N04aN9q1hvtxJmarR3RSV93z5It
	 f51xuua67+i2g==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com,
	djbw@kernel.org
Cc: jic23@kernel.org,
	benjamin.cheatham@amd.com,
	alucerop@amd.com,
	alison.schofield@intel.com,
	ira.weiny@intel.com,
	gourry@gourry.net,
	dongjoo.seo1@samsung.com,
	anisa.su@samsung.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org
Subject: [PATCH v3 5/5] cxl/mem: Wire up BI for Type 3 device
Date: Fri, 15 May 2026 19:20:36 -0700
Message-Id: <20260516022037.1761453-6-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260516022037.1761453-1-dave@stgolabs.net>
References: <20260516022037.1761453-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Setup BI flows during cxl_mem_probe() after endpoint enumeration and
EDAC registration.

BI setup failure is non-fatal - the device continues to operate
in HDM-H mode without back-invalidate support.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/mem.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index fcffe24dcb42..f2d01a218895 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -150,6 +150,10 @@ static int cxl_mem_probe(struct device *dev)
 	if (rc)
 		dev_dbg(dev, "CXL memdev EDAC registration failed rc=%d\n", rc);
 
+	rc = cxl_bi_setup(cxlds);
+	if (rc)
+		dev_dbg(dev, "BI setup failed rc=%d\n", rc);
+
 	/*
 	 * The kernel may be operating out of CXL memory on this device,
 	 * there is no spec defined way to determine whether this device
-- 
2.39.5

