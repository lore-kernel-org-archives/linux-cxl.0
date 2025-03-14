Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E672036FF;
	Fri, 14 Mar 2025 16:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741970824; cv=none; b=VuEAT+LFUrrHN+6j55+y9bG7LlwkWdoQ6ITQ7i5F1SdNI7KY7U0uOLLl0YHht1U7ky7uMCPE9rQXOAzQwjM0RrRu9QxlbsTXr6DuVb3/yonAGxGJJUea+fbN0Dekd6cpGMzW1PqvFVdeesijVGq4ULF75ICYUKiM3vnUci2ZdIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741970824; c=relaxed/simple;
	bh=5ow0IO1Lxno0ruL0X/rFbPZdHMBzwVXIJvTvpzKa9Go=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=keQ+ANEtls+mStLGrGmEOgxy2++1y4mDOWJASnWpNSAkoROjXlTWvsbiZPRz9ELt5qncSeV5MYQoibsbnYCaVK/6pc9dmZTI0TzoSj31DqGMrBY+JC1S8dtEw2D6kYRdafzgRrbXqN7r887nQHmL7XoYdcFnGvPlXHgW1M18dUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L9GCcLde; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L9GCcLde"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-225df540edcso17497465ad.0;
        Fri, 14 Mar 2025 09:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741970822; x=1742575622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gXQOhE3zWBqm8qiTh3H8EE+99XmrXnz6Df0P1iclh/U=;
        b=L9GCcLdevMBFSfGKFB72/VOcGz2JXADWdrpt7d/w1V65kM/J2uSLnk5GHsIEqsSETx
         kMXcQ3ce9Rc3iHM1tGUK4Ub+KxKrQSgjh7KTEv+39oh2YvTYT3JgpnZoRl1iQyhIZTLi
         iaMtHhBsBGZvc8iv21DXske3/Q2LdKbrabVpTiMJDFhqmrHkSj/qgt/NPxZETIcbffEu
         KMTxVc0Z1q1fDLzAkUwDIuXtWNMcQySxkOcgjTmuhfInZy1gK2g4JR8Y4DQuhXK1g2Oz
         1tBDuXcDcHXS5Q32fHHNASp4T+GKT41Ujylc8xJ8yFTpoNf9Cd/h9OR103Omg7UO6Mnj
         grsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741970822; x=1742575622;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gXQOhE3zWBqm8qiTh3H8EE+99XmrXnz6Df0P1iclh/U=;
        b=Mjf+SFf7g1vUvcS7ntp1KXH9J89d3w6RbiC8JGzo1coSQdf8SVimCiiGnX7J3BjcSu
         0LOHD9opRQ54rNE880tuy7GK42wTrGv7/8P+3wDHIwOi1BGnV86d1WZRrerf+xfh54eC
         fW4wx05tnERzU71y6/A8cKcwJTXa07LQhqbdvpHHYk9ZZmlSWbktaesAycsOFKnoLzON
         nAY7GVLym0Ked5mMmHaL5mXsrQwo3ky42y4x6MRZ3Hv/iYI+JpfGs+pknUQCN2kY7/wf
         pPe1SgkdDPtdE7PUhbMaR5EwTbOEOobW2nvZ35nSfdELPFI8HEoSuQ/Tfqyoi6ThUZhA
         ehiA==
X-Forwarded-Encrypted: i=1; AJvYcCXzBDr8SIC+c2NxhWT7nUYmrtHTQuavLGKat1BH3tnwD+YwUkM75uj1dAbBqhUbk7YyWkOixm4u2LsN4bg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIywiIfOBR0Uq4d7Va8YMGwJia1WxHq1iFjPTEz2+jVkTY7WhD
	sYsymoZAIHF0/DN0s10PFVbQLU71iHi67KdLNUd/qqnQBuzIGOXO
X-Gm-Gg: ASbGncuALh29hRSzDfd8ERkEDAjGbfM6k6NaysDPxZw6DxPxKc2qUPxoeC18KTOnsMJ
	9R79vqdXbU915uj4Ot9oVuvDNEq2kFaeZ6HZvZQbWTdaK3EKOcUpkjiRyFl7kfpKUICD8NV9FLf
	i0zlBtzSyx9+nohmN57pIpv3GE3+ShKOz9+mr711qLQ2U0xZlwTC067pUfgDc4BWzPFcVfrlwKF
	kW2yaHVp4OCOT10xfnZltIguZJ50VYa49AteeUtKeHprlLKRx/9UzpsRRy+xqa9Us5iFSheYGnI
	We/Zunfweo/MFCI+YQQ5m69mrq6dJmi6sExU9Xfr1XLc03v70VDJA/Jg+gPu
X-Google-Smtp-Source: AGHT+IETW085KBPhOBloqrxL4/C+oH11RFHan0UJ9ycgygib4EUNqH/YQXg7hN/Xw6Rij2HvsdIMVQ==
X-Received: by 2002:a05:6a00:893:b0:725:4a1b:38ec with SMTP id d2e1a72fcca58-737106d1c9dmr11397192b3a.3.1741970822195;
        Fri, 14 Mar 2025 09:47:02 -0700 (PDT)
Received: from localhost.localdomain ([2601:646:8f03:9fee:8f4e:a163:c61a:7fed])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7371167e07fsm3069624b3a.119.2025.03.14.09.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 09:47:01 -0700 (PDT)
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
	anisa.su887@gmail.com,
	Fan Ni <fan.ni@samsung.com>
Subject: [RFC] cxl/region: set numa node for target memdevs when a region is committed
Date: Fri, 14 Mar 2025 09:40:19 -0700
Message-ID: <20250314164629.6937-1-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fan Ni <fan.ni@samsung.com>

There is a sysfs attribute named "numa_node" for cxl memory device.
however, it is never set so -1 is returned whenever it is read.

With this change, the numa_node of each target memdev is set based on the
start address of the hpa_range of the endpoint decoder it associated when a
cxl region is created; and it is reset when the region decoders are
reset.

Open qeustion: do we need to set the numa_node when the memdev is
probed instead of waiting until a region is created?

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 drivers/cxl/core/region.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index e8d11a988fd9..935ee0b1dd26 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -242,6 +242,13 @@ static int cxl_region_invalidate_memregion(struct cxl_region *cxlr)
 	return 0;
 }
 
+static void cxl_mem_reset_numa_node(struct cxl_endpoint_decoder *cxled)
+{
+	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+
+	cxlmd->dev.numa_node = NUMA_NO_NODE;
+}
+
 static void cxl_region_decode_reset(struct cxl_region *cxlr, int count)
 {
 	struct cxl_region_params *p = &cxlr->params;
@@ -264,6 +271,7 @@ static void cxl_region_decode_reset(struct cxl_region *cxlr, int count)
 		if (cxlds->rcd)
 			goto endpoint_reset;
 
+		cxl_mem_reset_numa_node(cxled);
 		while (!is_cxl_root(to_cxl_port(iter->dev.parent)))
 			iter = to_cxl_port(iter->dev.parent);
 
@@ -304,6 +312,15 @@ static int commit_decoder(struct cxl_decoder *cxld)
 	return 0;
 }
 
+static void cxl_mem_set_numa_node(struct cxl_endpoint_decoder *cxled)
+{
+	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+	u64 addr = cxled->cxld.hpa_range.start;
+
+	cxlmd->dev.numa_node = phys_to_target_node(addr);
+	dev_dbg(&cxlmd->dev, "set numa node: %d\n", phys_to_target_node(addr));
+}
+
 static int cxl_region_decode_commit(struct cxl_region *cxlr)
 {
 	struct cxl_region_params *p = &cxlr->params;
@@ -340,6 +357,7 @@ static int cxl_region_decode_commit(struct cxl_region *cxlr)
 			cxled->cxld.reset(&cxled->cxld);
 			goto err;
 		}
+		cxl_mem_set_numa_node(cxled);
 	}
 
 	return 0;
-- 
2.47.2

