Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9E684A3F
	for <linux-cxl@vger.kernel.org>; Fri, 13 Sep 2024 18:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726252404; cv=none; b=OoiF3BrL24YEt6hab47HufB/aC+dOcz/it9a7Aljkzt9CQ4x1dpVHlysOLGGzsW1h43c5TUUUQJHu6QuJgotKGqRg0hq1epH/oha7GW+BZtDMTg2qezst6feEE7KPvMoBgZ12BdgE4QNSqPOlkCwpNULYnFK/mClWZJRlvWssPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726252404; c=relaxed/simple;
	bh=NND0V9zwpZ9XBN49kNHvsHEKD6qn2VhcX6V5P1HaAeg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=brp9gN6grPttNAKn4D6pV3z6lJ/mJ2sRr1n5KjXKDlv8zaXPz+xzFmmCOVQzXVi3E1BlfgIC1Yw6C74qoqbnyR3bBY18GjWKS63zcjQ+Br6i12c1kxk9wp5Hjr2Ok64kyg3Jsb2xS/ru74Ico2UpGqIOoK1eafWa+WEr4GyhT6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=tLPnMM/r; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="tLPnMM/r"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7a9ac0092d9so133526685a.1
        for <linux-cxl@vger.kernel.org>; Fri, 13 Sep 2024 11:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1726252401; x=1726857201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j+MSLPUwLhZTQZUn622ey25pLdlzBaTeBrT+c96fv7g=;
        b=tLPnMM/rA9nHR6Z9i95MoJbHTdpql/Wqe1m2eCHha4vugm0u0njgSYoVZwxCcktfwC
         6IMkHsdi1sg7lVlyuB8bkT0S/fKBh6FYKwdJSO9TMvosrx2Ldh2e3zSpC5MgNALuXcD/
         bErHgBrr8yNUUk6w42BeGchdAx5LZO9JJn8dz6X1ECK1UI2T3vwtklO7H1xKSW/Avt5g
         CqVU/cfSn9iJlrjh7RmVu+q5EDBLyxlaq5kOIJDrxgltSe9WLiVUIrNDiqapPQmIHo9s
         AiHhDax49D4OOWrjAvNZlkuRhXkvpXT1vWyf03lXui10LVbOaMdEExStTq87NIRBXoyc
         GdSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726252401; x=1726857201;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j+MSLPUwLhZTQZUn622ey25pLdlzBaTeBrT+c96fv7g=;
        b=qk0qEvev6GW2nij8G08O8gezxvaBdvOFdQcfeVu5HRvJWMrWdMfGXLZb8nSrJ08/yH
         eB5gxmD4Ko2UTGWYDzO+3wKJP9HHEvffnaZ7OT6V3koiXLGxL9ZIbNEs2YRnYJK1ZMRF
         eD9NJVCoW+SY6S5JGpDneU+E4pexbEO5lwxkWAxigIp85/gKWPJRYkLFS2RVNS3iPTI7
         QYTXRx+SXU7WKUIQlQ+mSlk7mZrVPU72p94M5lOH85r9XQVvHeg67FhNG84UfsD8Ganq
         1TsGl9XRcXF2BQiE1tATsNYOx89jWDdszH6MeZ6hjlrpF/+qnlAKR1syjLffhG6srUB3
         z5gA==
X-Gm-Message-State: AOJu0YzOrlP/tY4vTZDyEYnrcN4U6NXZXmDAWXqaQCQMBMNF3yhVnu1z
	ZZI/WvHC2j+moTCNmmIGc2ebw9nU5g/eSOoXB1UJ7BaqX69hqVa6pqPa7Nf19onJP3g45al9ID4
	2
X-Google-Smtp-Source: AGHT+IEtf29vOcJbTdnkyw9MhU6TEzWslLOhmIOOSID2g8h0qEnBTldMRg/iO9ZQASlfDku7n/b1jQ==
X-Received: by 2002:a0c:f411:0:b0:6c3:5c75:d2bc with SMTP id 6a1803df08f44-6c57e0d6734mr56796156d6.47.1726252401543;
        Fri, 13 Sep 2024 11:33:21 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c534339987sm70416046d6.33.2024.09.13.11.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 11:33:21 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-cxl@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	rrichter@amd.com,
	terry.bowman@amd.com
Subject: [PATCH] cxl/core/port: defer probe when memdev fails to find correct port
Date: Fri, 13 Sep 2024 14:32:34 -0400
Message-ID: <20240913183234.17302-1-gourry@gourry.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Depending on device/hierarchy readiness, it can be possible for the
async probe process to attempt to register an endpoint before the
entire port hierarchy is ready.  This currently fails with -ENXIO.

Return -EPROBE_DEFER to try again later automatically (which is
what the local comments already say we should do anyway).

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/port.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 1d5007e3795a..d6bebf70d142 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1553,7 +1553,7 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
 		 */
 		dev_dbg(&cxlmd->dev, "%s is a root dport\n",
 			dev_name(dport_dev));
-		return -ENXIO;
+		return -EPROBE_DEFER;
 	}
 
 	parent_port = find_cxl_port(dparent, &parent_dport);
-- 
2.43.0

