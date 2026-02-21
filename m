Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36052BDC04
	for <linux-cxl@vger.kernel.org>; Sat, 21 Feb 2026 04:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771648221; cv=none; b=c8MXHBROnJ7UH4XkwA3lnEL5SipOyM9gI4y+cM5CzVmYr0XSHIbD0rAO3NkIz/XSLP+5tkXvyMMlFvQEdPX3Aftl3MpbVjqAn5TCmF30+VNlD6p6vAQRs4CeXww50RhzoSg1B/Q1L7b7FpH/O7NNlvbWM9/e5KfccBG52dk1nHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771648221; c=relaxed/simple;
	bh=ZRs6+NhUviNhlgRBhjTLA0ALalBLgTYbVtHs0sTqhVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ewZoApF8BAZu1OPI8KbebLE1FVh+aetOfPJr743gAPGB3/qMRCSKWEKegJfao2aCZWv0d2cYQ9f9LL1nr1Y1evoz7CRMAw37kdGbs4WcNIl7dWvAclK9gINvq04X0+arnQInehNThMHDqrYtyGwqTuc9+MGZhlICXWBzcDjSkE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=FQuqMyvL; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="FQuqMyvL"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-50335b926c2so24429941cf.2
        for <linux-cxl@vger.kernel.org>; Fri, 20 Feb 2026 20:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1771648220; x=1772253020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tuOgoOTZLXH+3C7CUph7NNzBgAOFkmZpYhbkSOA0eug=;
        b=FQuqMyvLHSUXRfOvLmipN2jflMDza9Dc/NmiAsyMbfNTT1DhERIFWkcMBKW+VvyD3d
         nRPlckEgjkAlZEURd0XcgucFlYKCWBDDPDRi9JrbffgSaa45pfFmGVpuUjZfVYyzbSkt
         pNbSbp5OTRDBZGMIc+IU40OCrE7oi//kfy+mayV7MvJ8KlMA1oP6mSTUhH4EL23CndBu
         pj9Rulax1yL5Ko4j+Kzpeybz5Hp8U2/ro0LvYtGQ5wf9eJm8QTmIn1ckmXTiFWfSwXQk
         EhUJ3wMwc7l1DXQvjkhFfqOv0R+un6WIxpYFBmiTnGu+tLkk4pknrte8nqwIcb2rgf+m
         /9Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771648220; x=1772253020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tuOgoOTZLXH+3C7CUph7NNzBgAOFkmZpYhbkSOA0eug=;
        b=ornB297x9dde2PrvUckA7ZA5Ymf2kad66NMYiONgCxYXG32BPAwt/jb9txrYX3tZBa
         EMSoJP/4irUNLMYlNM48HKZbeI9OpDzhUyPCcrq3SxBy0EJ9k5+JzSZeMRsBCswgVw+n
         0gZ+V1WaI2nRpKosRUvmvRr1CmJo0ItxBVzAvvbCYl6y4IQcN9XIQFIdo53QdwNVbAFY
         GdgWV+6NIsWau3NeMwXpObx7WahOgUR8k6BVcO3OOTzuCf1YpBywOu+4mI7E6JiZmKnr
         Wc8p+j0YEkdJRXHWBWc12ADH/9izMy6v8ohzxG8M5am1X0sOPSql6ytmMlC8eec6Aisl
         9eFg==
X-Gm-Message-State: AOJu0Yw4lNfaVLUtVVSKeaqvPVzU0T4QDkBSyND1NStR+NwYQyOp4IO+
	HIdf+JWlMyhp6mQl1qZJ6Vns1G4xBvI7axCTEGc8RzbDo7GePvtHRXXI0Lo2aC1FsjZ5NMHbX/8
	jHLIh
X-Gm-Gg: AZuq6aI7dp4EjyNer1NtxiD9kk+vqhxAwM+BbjF42S5PPbAqb35eV8OkiCHxU4RXEFd
	BmCPYfZHwwI7Y88J++2ZUuiAVyuGlTSv1a7RwF4xpGBboCtZBgxEsvkeYx0j8TZEkz3Lc8oNlTa
	4lQzGj5wgHc99rxBfdt+CiVgUwu1aoJn+7ivmm/ekTZ5E6GieaK8BlUsCY9nNfkobkt+8nQtOwt
	aB22FRMmGyjp3OTMug0h9+0DWqFgqnqpws+LwBCcaZN3cdKdS3BEzxXXZYfoHhkra3k4sqonu2z
	fzHgKfxMt3/wVKajWd8fLaXTkB8N73fLp8RNVD07SVYg3ZqcyFGz1xSkLVrRobiXTlGHqtEe9Mu
	Dd5SYvrd8zET80CIs2QQBiV9Kd9s9KT7VdC2mO0StHy43AKYuitw4C6u+oJEuQfp6vFNHUUDBN+
	qmNXNRScQXuazrnJIJFX2+WdQdOsHZXofwfc5UWXDbEjKHHI5gdy3t96X2ZCSXpQGXFW/0AJGkf
	cC3IRpcKIfpPV0=
X-Received: by 2002:ac8:5995:0:b0:506:9a89:5f36 with SMTP id d75a77b69052e-5070bc9f7e6mr28073171cf.51.1771648219721;
        Fri, 20 Feb 2026 20:30:19 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d6a1e6fsm9984991cf.16.2026.02.20.20.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 20:30:18 -0800 (PST)
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
Subject: [PATCH 2/2] cxl/region: skip default driver attach for memdev with attach callbacks
Date: Fri, 20 Feb 2026 23:30:13 -0500
Message-ID: <20260221043013.1420169-2-gourry@gourry.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260221043013.1420169-1-gourry@gourry.net>
References: <20260221043013.1420169-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a CXL memdev has a custom attach callback, cxl_add_to_region()
should not call device_attach() on the auto-discovered region.

The default device_attach() binds the dax driver, which may online
memory via dax_kmem.  The custom attach callback then has to tear down
the dax stack to convert the region to sysram, but dax_kmem refuses to
offline memory during its remove path, leaving regions stuck online.

Skip device_attach() when cxlmd->attach is set.  The attach callback
is responsible for setting up the region after auto-discovery completes
(e.g. adding it as sysram directly).

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/region.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 276046d49f88..e5edeabd9262 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3971,6 +3971,12 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
 	}
 
 	if (attach) {
+		struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+
+		/* Skip device_attach if memdev has is own attach callback */
+		if (cxlmd->attach)
+			return 0;
+
 		/*
 		 * If device_attach() fails the range may still be active via
 		 * the platform-firmware memory map, otherwise the driver for
-- 
2.47.3

