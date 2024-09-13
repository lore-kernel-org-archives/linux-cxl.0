Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E1213AD20
	for <linux-cxl@vger.kernel.org>; Fri, 13 Sep 2024 18:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726252411; cv=none; b=i6tJ8Zohshw464houCHfy+XvIvjI0XGwG5s/RG+DJOM7cDBEA4jDDff2FrvzVSIvETLgXOijc/1dD1o2UcaVuvji6Q57ZGSga4fW+G3IOO7DTb3HjpJy6yePAeFn50mOTtxuk7C2LDSyW2r2YNTIH/6iWGuHsqwd2Wjq2dzdFIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726252411; c=relaxed/simple;
	bh=KWGgAMhSiiyP8L31h701ZTjtJNsOy0WoTQfM158fupU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RFXzB2aIa7Sc8sIT6Jj+4KTbdeQOq/zDSS+UHTuJbCAxrRzlwEaupOnYt8KIsUV2uTkzyLhlnIL3f6w8fOXcda5QoE7LaHJl8tIgUpwptCCuJgIm9mSFaODOUoaTQwmjEIhplqDg1gKq4MqjjwZBsdO37yo5wpHn2lQeZxIY3FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Ilt/Ipsv; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Ilt/Ipsv"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4582c4aa2c2so15130581cf.0
        for <linux-cxl@vger.kernel.org>; Fri, 13 Sep 2024 11:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1726252407; x=1726857207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2v0+dGtW112yh7kuPl9jbngDqDOI2CHxz8mSzSdgOgk=;
        b=Ilt/IpsvgH7nywcfAmar9EChYlPG/WaDk8pNHxHYrG8cDXcicnSGPF86dAejeTfMW5
         uXt5pDCoWTs2HhQOe2Ddaqx4+ZSPknOrDawcpyHCTK/ZU+3tZpcMi/uOckGPTu+Th2oV
         RQ2eSBCtIw8BQNBqzEfvzETJYzoVboYgeDzuqL+hCGva1tnN0r7XLJ5f1p5H5geEXjVe
         4wDSvkPnP+SWd8SzEIiQVtHmuBIk2qRq3Lpt1MYZ60lydbdIxAVaqDRqQrQ/NvWxbbSa
         qUPR4SqHvQPKWfBqQOsdzQvNyisQ09sREL72jJWRv6y3s5cQQzOtL7ZH4HDeX6+GXNGZ
         THRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726252407; x=1726857207;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2v0+dGtW112yh7kuPl9jbngDqDOI2CHxz8mSzSdgOgk=;
        b=qGfsjsSrO8oC1b1UPU38lNuugeRWSmVbS3+FU22ee/5coDh7MG4Tv8RAj9QmpQe26U
         JLmjeflRSJj3HPlXUWtKQk3W0/IXX7VOplBcnFpfmVUiEgN/vHaYbf1g4MFPCjTModRq
         iBnNDkfWF3DjCuXysollY3ss4i+VeSGo00wXEGiq4wMuSl1VvTsewGC5bNhdaNf++9UC
         /Y/C6vITbhGbu6VvJ4k88tge+qqPdUi13DKv0iXgYPVqIish40BArXxREUVgEIUulTXL
         98uAqplvzBOod8aOhdR/yrGILms6hT0j0Y5G9no4V4H8irb74YZPq39CVVjBswP0r3Bq
         olHg==
X-Gm-Message-State: AOJu0Yw2GK1lm424GPnTnE1PaAjS9GMpwSXDtNRd8fGS8+16/jeWxesS
	zMLMDKr1VKu33cSZ7j9uhwx407IZ6GlNDCxtX3mOO0MKHhkzSB2qnkKVQADv5Sw=
X-Google-Smtp-Source: AGHT+IGvC/54/kqTEqx6TS/kP3pJhDLE6A7PbErUo3HvjAsjov75/IPAU3sCI8+hL1thXWjQYgmYEQ==
X-Received: by 2002:ac8:584d:0:b0:458:35fe:51d with SMTP id d75a77b69052e-4586045e50cmr79001221cf.60.1726252407607;
        Fri, 13 Sep 2024 11:33:27 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45822f61ac7sm68596801cf.71.2024.09.13.11.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 11:33:27 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-pci@vger.kernel.org
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bhelgaas@google.com,
	dan.j.williams@intel.com,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	vishal.l.verma@intel.com
Subject: [PATCH] pci/doe: add a 1 second retry window to pci_doe
Date: Fri, 13 Sep 2024 14:32:41 -0400
Message-ID: <20240913183241.17320-1-gourry@gourry.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Depending on the device, sometimes firmware clears the busy flag
later than expected.  This can cause the device to appear busy when
calling multiple commands in quick sucession. Add a 1 second retry
window to all doe commands that end with -EBUSY.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/pci/doe.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
index 652d63df9d22..5573fa1a0008 100644
--- a/drivers/pci/doe.c
+++ b/drivers/pci/doe.c
@@ -647,12 +647,16 @@ int pci_doe(struct pci_doe_mb *doe_mb, u16 vendor, u8 type,
 		.private = &c,
 	};
 	int rc;
+	unsigned long timeout_jiffies = jiffies + (PCI_DOE_TIMEOUT * 1);
 
-	rc = pci_doe_submit_task(doe_mb, &task);
-	if (rc)
-		return rc;
+	do {
+		rc = pci_doe_submit_task(doe_mb, &task);
+
+		if (rc)
+			return rc;
 
-	wait_for_completion(&c);
+		wait_for_completion(&c);
+	} while (task.rv == -EBUSY && !time_after(jiffies, timeout_jiffies));
 
 	return task.rv;
 }
-- 
2.43.0

