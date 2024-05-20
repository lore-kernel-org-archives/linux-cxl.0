Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B8B11CBD;
	Mon, 20 May 2024 19:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716233555; cv=none; b=TxxlOTTaNCLDeQQAXTf2jdhuWD5TLnhXRrNIpnXCBLt5sLlvZ5/oYzQTA1/4mJUoGuF2iIdapemW0JXNqmjSmkIqOxJMEnanxInX9blcSeP7hRryrXBEKuyj+m9TkTF+ZlOnsz3coNGTAQ7CicsUuIK8mcyp9AZbTjXtlSMSMXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716233555; c=relaxed/simple;
	bh=C4tPPsuu3rOgFOx3Did9ynbqKsO2S+lSJuO54Jr9d60=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JDmzR8Barhqr/oUx0r2rAXVF19v8tRxai6Bk0p/smJr948HTyYeLamSsYxyeoMgcVtnR/vcGC+Skw0HkvowkshUseF7+CavFSCuvIcGqStbsZxHvZlbLIHFvzTRWsR7lvIjrL+zA5Gxsmn54lefw6+BvRotMTaHu15drn6dbu64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hr0kVeAU; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hr0kVeAU"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-61b4cbb8834so25426717b3.0;
        Mon, 20 May 2024 12:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716233553; x=1716838353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GBt7iaIFZwGfNOhqAQPefN/MrdE83Vt3S3U+O/46MvE=;
        b=Hr0kVeAUpHUP2MQWnKq8zyFb8YaAbrFGD96N7yV6C9/utd0BTl5DUd7+La9vaqJSE2
         sFowZzHIDhOQY1wm+KkFnNMcTnnV7dzALPv6M8PYEBdb5q3C1Zb4zXim5ReA0LoJ1y1Z
         TnOiyMKPad07igIQgWRd1OHlNWRAr07MCHxYxPrAiBNExTE4wIbvyhFg2Htya4GFTwiU
         UD4I/FItP1L4fEMcVxxKtasBLKeYs7iQvz3Naew/91FO2xZhDL2oBqV5NNf08DyVtNK6
         NhU6/htEyi52SuMEB8f+wB7Fa0zp/Z3e2o1y75/41U9+vFjjzAcC5lzgjhD9L2IOhn0X
         7Now==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716233553; x=1716838353;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GBt7iaIFZwGfNOhqAQPefN/MrdE83Vt3S3U+O/46MvE=;
        b=mr4K2LseYgx9r/aDjeURZ0gMAVxVdc3g00lnHJW/dplsfC/t7DkqGW270ik1F/uI1m
         2oSkNMu/SMRLkhSyXVf8huv1iv3eSoX1T4KOXIGHkyZAfijwhFGwDy2NWCBlK6uqIE8r
         IhmiZQzsqlIWLay5ypLoVpgFEDfo2RqgDX5/wOZjPbD5molrzmiiYHsOL1N+CJkLxJXI
         VkPcf3uBnDnkou4zALZS8Df0Qv8tZSDbIdlcMJWUgmHMx2u4PgKHGyf9BRsohnZRMrA4
         shXOdvtIG2YuWH6OTiZGgL2Xgixgd5uWGm4dZfXHGyOc3Odl2HFfTHan5TA+NO6PVccN
         izXA==
X-Forwarded-Encrypted: i=1; AJvYcCUpFDQWZq4KQ+LeJoM4kzUI1bkh2Amn7QavOwkGWEHllaxWapTkuGxI2mP86wnTw7AUbR1LpprEGS0ElGh2xN3H6io8LRZsVtlRwKFK
X-Gm-Message-State: AOJu0Yz93zY+wQdFUrq86PGA6AiToo2SD4l3AnnSQFxWCcoOEfveVOk2
	pvIHSQvWtbsYS3xx/mydKEPPIzd8uvPHx95ilSkwORlq+aPRXRzO
X-Google-Smtp-Source: AGHT+IEXfb+CBEIb+7OyPVewwLYo2RFKVm/8etip53ijoqbQKVVi9P28yDVnMdr2mIunjWA86cEMPw==
X-Received: by 2002:a05:690c:97:b0:610:e9b2:f84a with SMTP id 00721157ae682-622affc341bmr339978817b3.26.1716233552961;
        Mon, 20 May 2024 12:32:32 -0700 (PDT)
Received: from localhost.localdomain ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6209e379376sm49613887b3.117.2024.05.20.12.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 12:32:32 -0700 (PDT)
From: nifan.cxl@gmail.com
To: dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	Jonathan.Cameron@huawei.com
Cc: linux-cxl@vger.kernel.org,
	a.manzanares@samsung.com,
	dave@stgolabs.net,
	linux-kernel@vger.kernel.org,
	nifan.cxl@gmail.com,
	Fan Ni <fan.ni@samsung.com>
Subject: [PATCH] cxl/region: Add module license declaration to cxl region module source code
Date: Mon, 20 May 2024 12:29:55 -0700
Message-ID: <20240520193106.994172-1-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fan Ni <fan.ni@samsung.com>

This change explicitly specifies the licensing terms for the CXL region
module as GPL v2. This commit does not introduce any functional changes
to the behavior or functionality of the CXL region module.
It solely adds the MODULE_LICENSE declaration to the module source file.

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 drivers/cxl/core/region.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 5c186e0a39b9..e299ddcbd1a2 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3204,3 +3204,4 @@ void cxl_region_exit(void)
 MODULE_IMPORT_NS(CXL);
 MODULE_IMPORT_NS(DEVMEM);
 MODULE_ALIAS_CXL(CXL_DEVICE_REGION);
+MODULE_LICENSE("GPL v2");
-- 
2.43.0

