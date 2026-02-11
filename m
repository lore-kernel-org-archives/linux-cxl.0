Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68512951B3
	for <linux-cxl@vger.kernel.org>; Wed, 11 Feb 2026 15:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770822969; cv=none; b=eaISePCQP6D6IpLXHtaSLe3Mtzmnjf4FpblUd3eQEwqvfS/331Q8Mu3TlK81htk2eN1Tj+QekPfUkeOJoGWJpe7q7kXzpPhKfGUSg0tJoEMRDwxxuOGzDZix1EJWdiMNH0lcMhCHV/PKg9Q9mV6YEjNCjhKabx97ByZS/qRaKqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770822969; c=relaxed/simple;
	bh=Y5dQk5BCO0oicRdymA3ybVZWSVfSTw8FG/SUsw6RP/I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=khNPaxDUDi/O6b1Qz4W1RlNAi/IDC3QRok9I3feVxlHF1kAaB90jCbcBCF0CTAwTZq/2hXOMw4RjMfDV8JKS+6qvmDbG7wEUHZFkErrqZZi8GX48dfrj/W3GjLSE2HylRHsdJP1q/UoTFGdDtGaC0vrlIDp0gWlrVose2hA+q9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=uEGfPTf3; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="uEGfPTf3"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8c5384ee23fso584411385a.1
        for <linux-cxl@vger.kernel.org>; Wed, 11 Feb 2026 07:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1770822966; x=1771427766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TUOtkVcbwA3CulfDewyA7u2Auwst15RXQbVOCJbTEV4=;
        b=uEGfPTf3UYkgA6f9XgBGVm27bILVWDTRjx+NzAed55r47MQDhkSRH12lrGOLfi3nZt
         fBhXhE5gOwSQk62P5lMM6T2lJZ84SRKABWSp/SnHxo7NGEHVlT/VSHCd5aO2IOq3JLAf
         ohDr3yrvO8MMPRPYKoLvPo1aJ4SnlRKpqjlF71zv1nQYPl/1mGprtaP6Vbgdm1wXfTSM
         kCsJV042gZBqDNDM+7auNlIFpG83Wv3C1H4IT1ALV+qsWBP3/KfMhyRq5EonQIHHSXjC
         NMJszsBbVGJY8R11jRQubKrE4i15EWrKHWSAS19SvrO03T/NVFCmETMsfx2m2jwppRC7
         QGZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770822966; x=1771427766;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TUOtkVcbwA3CulfDewyA7u2Auwst15RXQbVOCJbTEV4=;
        b=Gbe8a8vsOR3S+ChJHr0yv1BePLqtIEhXC3FyHNPxLmwLF6R2H/B06PKkmp4d3jUwk2
         sWzHMmxJcJ3+60NUWDxk/vvG3EhbQdAjBqXkUZcyzVJCt+zByWARzTMXSF28lqruitm9
         CIpuLDCcXVxTeoexp3b8JKq2cLqlIBi60n5xF20zYyfvEIPThIe2bHHuzQp3AfVnFviC
         usZBLGwNa8TpOU2rbD2OP6QwhqFL0e/RsT1FulAJPVy4aFtCqUxeKwEftpg8cnljP3VK
         wbLOO7YJ0nQsY/Dm6KRAHWmgAVSKR7oQMS5AC4ud0pzV25eXcevX8oWM5SwZ2RbqSMUk
         V4HA==
X-Gm-Message-State: AOJu0Yz/1n5h55iKPim+4yzKnhYG9zGUTCGcNJJlhZd2lmYgLdc6OlcO
	mEEX0IR2UGo9y5tmy0ngDgreDbx94LRlAmiSPsFACZ1hjWoDZmFp/iU/XaJQp8No1dVxsFxTf3f
	McpC0
X-Gm-Gg: AZuq6aKHWPJPB8VtDtZvoq+oP5+noVK3IRg4B/OCY3ZrScU+W7W3OnmHV0jYCCH7cY6
	0g+WdXS9GZhJVjkBIVQikhtuDRAqY2OW2fTCzFx30m1g1NNg3eht3jA+4kDfurtuxUs97SJ5ORo
	KBg8GbGurKWQWbg2XctoAa8Wbmov/9j6jxy/yKegH6jbst4FqyH5Q3UUGNXCkrF4XNQtTOCtZG6
	163zaP8oEnR5C6RfahAZ1j9iD/jqOriIc2qiw8euF88zb7ubC75CZ+K92c+Xa4EL2+ttmt4RFsE
	lW/d0GI8gHfm4SNtRb1d8rpO19jBWxh76jcNytISdC8Qe2PVavmZ534TGEADcgy5IGL/3XsBo5Z
	RIU4Ny8CAQ3Ukv9FJ4nNq1eLxdyM8DXNQSMqcHhRPAvyVPioElnVjmvnFCph7wHNRBnlXf3C/gX
	eKlHiOiQdhmhfEeM4IQL5fYYKcVrlPYIlD+ZsP6xsNCUz6YVeMXRR3od3Cm9WSmsqEkw9j1zSXd
	/uuNWLkbmNAugo=
X-Received: by 2002:a05:620a:7084:b0:8ca:2e39:4b62 with SMTP id af79cd13be357-8cb2807ac64mr419055285a.73.1770822966347;
        Wed, 11 Feb 2026 07:16:06 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb2b0ce72fsm149707185a.13.2026.02.11.07.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 07:16:05 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: linux-cxl@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: [PATCH v2] cxl/memdev: fix deadlock in cxl_memdev_autoremove() on attach failure
Date: Wed, 11 Feb 2026 10:16:01 -0500
Message-ID: <20260211151601.2082584-1-gourry@gourry.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cxl_memdev_autoremove() takes device_lock(&cxlmd->dev) via guard(device)
and then calls cxl_memdev_unregister() when the attach callback was
provided but cxl_mem_probe() failed to bind.

cxl_memdev_unregister() calls
  cdev_device_del()
    device_del()
      bus_remove_device()
        device_release_driver()

This path is reached when a driver uses the @attach parameter to
devm_cxl_add_memdev() and the CXL topology fails to enumerate (e.g.
DVSEC range registers decode outside platform-defined CXL ranges,
causing the endpoint port probe to fail).

Fixes: 29317f8dc6ed ("cxl/mem: Introduce cxl_memdev_attach for CXL-dependent operation")
Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/memdev.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index af3d0cc65138..281acb3b9abe 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -1089,10 +1089,8 @@ static int cxlmd_add(struct cxl_memdev *cxlmd, struct cxl_dev_state *cxlds)
 DEFINE_FREE(put_cxlmd, struct cxl_memdev *,
 	    if (!IS_ERR_OR_NULL(_T)) put_device(&_T->dev))
 
-static struct cxl_memdev *cxl_memdev_autoremove(struct cxl_memdev *cxlmd)
+static bool cxl_memdev_did_attach(struct cxl_memdev *cxlmd)
 {
-	int rc;
-
 	/*
 	 * If @attach is provided fail if the driver is not attached upon
 	 * return. Note that failure here could be the result of a race to
@@ -1100,7 +1098,14 @@ static struct cxl_memdev *cxl_memdev_autoremove(struct cxl_memdev *cxlmd)
 	 * succeeded and then cxl_mem unbound before the lock is acquired.
 	 */
 	guard(device)(&cxlmd->dev);
-	if (cxlmd->attach && !cxlmd->dev.driver) {
+	return (cxlmd->attach && !cxlmd->dev.driver);
+}
+
+static struct cxl_memdev *cxl_memdev_autoremove(struct cxl_memdev *cxlmd)
+{
+	int rc;
+
+	if (cxl_memdev_did_attach(cxlmd)) {
 		cxl_memdev_unregister(cxlmd);
 		return ERR_PTR(-ENXIO);
 	}
-- 
2.47.3

