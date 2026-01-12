Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B102E265A
	for <linux-cxl@vger.kernel.org>; Mon, 12 Jan 2026 16:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768235773; cv=none; b=fa/L4KEG5EVl46HUlQxvpwEDzDSjznH/5yxecYNHTCUu5/AFJZpFE9atw3DRWXwe8LF9GME+x7erOuh6p3PRH5nd6m2OUibtzNBYhNNprC5bTc+QPupdG9foxXhCAVzkDaFhT2KCZUqQTzjJRZJhR5TeWgS1OkE9EeMieV3QsMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768235773; c=relaxed/simple;
	bh=Hk+57CNZUTJGonJIYyjaO83T2sgxKKuNO9rva+9k0kU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=caI0fKgNVJXFTOxZG+oKOdIncxmohOXdxRjTkIddpo5evbmmQVj1DYoSOdrkNaPzJ2Fyl/5jgHC9+DF9S1nZMb9aEXnGqge1FQciiUhz8+GuScbg6A3LjrRCoxEcpKcYntu+F+38vBIUDIob5OCx9K677VaeNdsmRUg9BYkIPZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=lTM1WMAy; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="lTM1WMAy"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8b2ec756de0so715649285a.3
        for <linux-cxl@vger.kernel.org>; Mon, 12 Jan 2026 08:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1768235765; x=1768840565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YcpN/uYsH1Dv10pXdsdEXhAfmqLRknf8ikqAWK0teK0=;
        b=lTM1WMAymLLsAU1uM/ecjXdIyAmoi1vU04gg1HV5qNma0m5/kvL/ObtYUxfeDzSZPK
         d9lARv4XFx2bm52IftjBeXd4QhOPfFvd3OsDPhtoniX0T9hLxR2uGjJhUkwX6FPpb1ty
         ny1ElI8GgRJ+nbmXwj11ECV/KAOPcYR7cffrNVwKA3hwrOSOjp1qmvh7/bF4N442OWgw
         mwLt9Q73jNMIWQ4AmKC4GeoHeqGo8VIga07hZmdpu4eDCZkfB1ROSojarLglQENBxEW7
         NXordVxCVnQO7tqRWc5VLBhDuhK4GRBhwN0kyBFDzF4SSc5CnGJIzx8MGPThN+fYoQ1O
         p/aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768235765; x=1768840565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YcpN/uYsH1Dv10pXdsdEXhAfmqLRknf8ikqAWK0teK0=;
        b=g/Ui+1NsI+NuKNdN8Ir1ojYdL+BLsLr/d6ITND3EsWhBhLK43KlZGSzglLjNZaFziZ
         yuprhP/PEJyHc6am0rGiQU/p1qZUKBxKiAEEdYKTfyQPgH/hy9ZbIXmW8KuIdx9WDidV
         qt61NADi2usHIsAi0rfFRwhwykopzjy7m8NskvQke5m80NwFVyv0VqUpF69bXDJMAaKG
         tI1yUT/40koa+OTxKnoYT1A5avuf0RnaB/oVmMKpMjYmtid4l56M1LHK2aTjXQzB9XIk
         YzqJ3WUXY5/6mkX8LHEkEr7O6PvsRZY1peWHVKBzgLRPwjXebTKMb5O8n6HR6S5/dN+i
         e9VA==
X-Gm-Message-State: AOJu0Ywe43z6kV8hObe/kkqup5oDPdDZVf9/0l36U/i7pDWDZL/30iPh
	fwqWOnRS3hHAZChKw4QrKWGzA29M3/vk8zZjFQz3jxrmVzCEpjG17QKGdxxaqzr+oPRzjb5xr/Q
	BIUL5
X-Gm-Gg: AY/fxX6/NgGzR3c5P1nlT8Ta0kkIOcjwZym3T8A45w/GsaG4n3PNlniDS6SSKFJGJVL
	ZJ00cCwMiNc5YdJjozHQlejT6y1BFvdjclRJktT3pR4RHh+BahGOM72iW9H83pizEuRG+Q8Tbdh
	2dU34+hivNohyUv2wqZvHjkXn1znlswac1barSIoj3SjW8ehRSIrXSSBee1cq47hl8gY9W+IefI
	U+FW/nMyzBqzS14QGcvv3YsSf+eQjOMLD4ncJ1Bf040ANbudetVcC6gYx+OaU1+M+/8GANnLNqf
	qDYFvBHx6zt7ewBZyhT3mVKFEksTtIw8xRbMe+RQ3cnnMNCeurq8HlE52SsLJV5rtRdt4GmFNKZ
	NPm8qjRHiFiEjIRO/rY905yzc+N9pSPN3OHEW7eW0uGdolkcdKBwFppnxCDeoD+eK2YIW+4HW5X
	iimeJKuWZFf8h3JkxXfcU8J/hJ9EUWkj9zTn38NNENVcz58f1iKhL9YHlmv2RupDdlzB/pOLdJR
	hQ=
X-Google-Smtp-Source: AGHT+IFRPZbBbTCf/WOGz6KEi6yYu6VUkTSJSbTA6OixgptEep5NhZocpcXBxWuFQvIu25RSebcYsw==
X-Received: by 2002:a05:620a:c53:b0:8b2:6a35:9635 with SMTP id af79cd13be357-8c38936898fmr2409334785a.6.1768235764551;
        Mon, 12 Jan 2026 08:36:04 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f4a7962sm1489152685a.11.2026.01.12.08.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 08:36:04 -0800 (PST)
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
Subject: [PATCH 4/6] cxl: add CONFIG_CXL_REGION_CTRL_AUTO_* build config options
Date: Mon, 12 Jan 2026 11:35:12 -0500
Message-ID: <20260112163514.2551809-5-gourry@gourry.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112163514.2551809-1-gourry@gourry.net>
References: <20260112163514.2551809-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To give users the option to have the auto-behavior of memory to default
to SYSRAM, provide a switch.  The default is still recommended to be DAX
in case of multiple devices being added to the system, but this provides
simpler systems a path to use the sysram controller for systems already
configured with auto-regions.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/Kconfig                | 32 ++++++++++++++++++++++++++++++
 drivers/cxl/core/memctrl/memctrl.c |  2 ++
 drivers/cxl/cxl.h                  |  2 +-
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 48b7314afdb8..5aed1524f8f1 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -211,6 +211,38 @@ config CXL_REGION
 
 	  If unsure say 'y'
 
+choice
+	prompt "CXL Region Auto Control Mode"
+	depends on CXL_REGION
+	default CXL_REGION_CTRL_AUTO_DAX
+	help
+	  Select the default controller for CXL regions when ctrl mode is
+	  set to 'auto'. This determines how CXL memory regions are exposed
+	  to the system when no explicit control mode is specified.
+
+config CXL_REGION_CTRL_AUTO_DAX
+	bool "DAX"
+	help
+	  When a CXL region's control mode is 'auto', create a DAX region
+	  controller. This allows fine-grained control over the memory region
+	  through the DAX subsystem, and the region can later be converted to
+	  System RAM via daxctl.
+
+	  This is the default and recommended option for most use cases.
+
+config CXL_REGION_CTRL_AUTO_SYSRAM
+	bool "System RAM"
+	help
+	  When a CXL region's control mode is 'auto', hotplug the region
+	  directly as System RAM. This makes the CXL memory immediately
+	  available to the kernel's memory allocator without requiring
+	  additional userspace configuration.
+
+	  Select this if you want CXL memory to be automatically available
+	  as regular system memory.
+
+endchoice
+
 config CXL_REGION_INVALIDATION_TEST
 	bool "CXL: Region Cache Management Bypass (TEST)"
 	depends on CXL_REGION
diff --git a/drivers/cxl/core/memctrl/memctrl.c b/drivers/cxl/core/memctrl/memctrl.c
index 1b661465bdeb..cb6c37f4c0ee 100644
--- a/drivers/cxl/core/memctrl/memctrl.c
+++ b/drivers/cxl/core/memctrl/memctrl.c
@@ -31,6 +31,8 @@ int cxl_enable_memctrl(struct cxl_region *cxlr)
 					p->res->start, p->res->end, cxlr,
 					is_system_ram) > 0)
 			return 0;
+		if (IS_ENABLED(CONFIG_CXL_REGION_CTRL_AUTO_SYSRAM))
+			return devm_cxl_add_sysram_region(cxlr);
 		return devm_cxl_add_dax_region(cxlr);
 	case CXL_MEMCTRL_DAX:
 		return devm_cxl_add_dax_region(cxlr);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index c69d27a2e97d..1dae6fe4f70c 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -506,7 +506,7 @@ enum cxl_partition_mode {
 /*
  * Memory Controller modes:
  *   None - No controller selected
- *   Auto   - either BIOS-configured as SysRAM, or default to DAX
+ *   Auto   - Auto-select based on BIOS, boot, and build configs.
  *   DAX    - creates a dax_region controller for the cxl_region
  *   SYSRAM - hotplugs the region directly as System RAM
  *   PMEM   - persistent memory controller (nvdimm)
-- 
2.52.0

