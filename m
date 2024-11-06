Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB5A205154
	for <linux-cxl@vger.kernel.org>; Wed,  6 Nov 2024 15:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730908749; cv=none; b=uSiAbDEN8A0DYrlQhtkw5YfkP1Yn+koFeMh3f9pxfCv9WSlxRSuPRmew1mGZESlBo7Ax1k2MNKhbV6xGEyskqZFhiQmseTcohcFuPqMHnphwb54/0z9md9on4qH8+nWFCCPP439DqDz+jxQufh2ACtVPXGfgqsWD0TizAHLIkIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730908749; c=relaxed/simple;
	bh=a2SRNhgByLYkEQQV8w/BUYuqaC8BJarO22cske/QxvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MoR61OrVVowwnaxb7fwSClQckecRbEqVGpSCpEPHrCKQpHPyG4TV6ZW6g5w0S8nJkgg5S3oWgBUIGNhTCbTdOiXE6tpzUME1YN5HMAM5IZT5dlFcXgKjZFIBe3aOO/TPXHYpTPZFlDXNn0SKXPQpC5t4I1JSXSWIM7x6Dsmq1/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=fCRPLyiZ; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="fCRPLyiZ"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7b155cca097so84409085a.1
        for <linux-cxl@vger.kernel.org>; Wed, 06 Nov 2024 07:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1730908746; x=1731513546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dE7GBdO27UpsSNU1CxN3p2/3T9xO+pcffcnhhBLFfkk=;
        b=fCRPLyiZs+9ptDNCDmtf7ik0bWzhFKd4BMazhLG6cy/alPFUiNI+GEx1762pXu5mZN
         AKDBm5RFPgL0HN7JFp6vDUJB2F+q6iXUluKrvZonZU6NjYvyIbVsuKUcJ+pFzS3FcZ38
         iD2nip8wqtN6NLt+DFgFlitub6QaIhi+AtsX6zozjH4Lx/Ewt13X+vqV2/P62vbx1PBa
         qPaYkBl683qMGsb/Y/lY2UyTV3NlMYgMahjEFd7UjBqa9ZzDXZTJ1jX0QTDh2Xvlba5/
         Ta4KYbbfXJ7ojUBUVGG0c8LElVjA2wm6l4ToaUY8y8LaVx8gmHELuz3XIF7YvU02YuCS
         DOAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730908746; x=1731513546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dE7GBdO27UpsSNU1CxN3p2/3T9xO+pcffcnhhBLFfkk=;
        b=T9djbxfCgRgitHfHzZbpOtyDhCpw76ptebkimKDOzCNGxwC+StkTqGAFtzAEEwxWTk
         Gr/U5K5yWHmkF2uZMjSk9lupc5tpi1IM/4G6dzB8mRsDgH0uXrl8ITthQN20XQTlSYAH
         7/fOcqXKikrJxFdjH93erjrGnpXGykWz24XFUT8o5cKu015mTsHd62mulelbMnsl6hl8
         AxJyuGw+pVjBR80sBikRDjzAsXlWuDJYJAwcZh5SxkGd33onOkK0uxjKXb9IhOqhklPV
         tnwtkXMMyuKziEr0AAHop8Ht7WCB2HUDIyFzhx8v2A7YJyhZFbHKXIGb9W9angjGON1M
         tS9g==
X-Gm-Message-State: AOJu0YxQa5F4F9XRy8EAcaro3zC6cj3pvPuWtsMTwhQ53EvhlpSAg2mu
	m+mkglzGuqYT5X1LRSJFR9MB0t9Ic6zuTUEVYMgMEHXiA050/Vg+3FSn8l0XJ14=
X-Google-Smtp-Source: AGHT+IEUkctiVyqefq/YK8UzVAb3G1JlrVxWuRVPIwvQYFeNj0t51VLwtemS/L2Zn+W2U6AWN8z3Tg==
X-Received: by 2002:a05:620a:bc4:b0:7b1:3c19:a665 with SMTP id af79cd13be357-7b3217fd138mr445393985a.19.1730908746378;
        Wed, 06 Nov 2024 07:59:06 -0800 (PST)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b2f39f7b85sm641377285a.31.2024.11.06.07.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 07:59:06 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-mm@kvack.org
Cc: linux-cxl@vger.kernel.org,
	kernel-team@meta.com,
	Jonathan.Cameron@huawei.com,
	dan.j.williams@intel.com,
	rrichter@amd.com,
	Terry.Bowman@amd.com,
	dave.jiang@intel.com,
	ira.weiny@intel.com,
	alison.schofield@intel.com,
	gourry@gourry.net,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	hpa@zytor.com,
	rafael@kernel.org,
	lenb@kernel.org,
	david@redhat.com,
	osalvador@suse.de,
	gregkh@linuxfoundation.org,
	akpm@linux-foundation.org,
	rppt@kernel.org
Subject: [PATCH v6 3/3] acpi,srat: give memory block size advice based on CFMWS alignment
Date: Wed,  6 Nov 2024 10:58:47 -0500
Message-ID: <20241106155847.7985-4-gourry@gourry.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241106155847.7985-1-gourry@gourry.net>
References: <20241106155847.7985-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Capacity is stranded when CFMWS regions are not aligned to block size.
On x86, block size increases with capacity (2G blocks @ 64G capacity).

Use CFMWS base/size to report memory block size alignment advice.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Gregory Price <gourry@gourry.net>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Acked-by: David Hildenbrand <david@redhat.com>
---
 drivers/acpi/numa/srat.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index 44f91f2c6c5d..34b6993e7d6c 100644
--- a/drivers/acpi/numa/srat.c
+++ b/drivers/acpi/numa/srat.c
@@ -14,6 +14,7 @@
 #include <linux/errno.h>
 #include <linux/acpi.h>
 #include <linux/memblock.h>
+#include <linux/memory.h>
 #include <linux/numa.h>
 #include <linux/nodemask.h>
 #include <linux/topology.h>
@@ -338,13 +339,22 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
 {
 	struct acpi_cedt_cfmws *cfmws;
 	int *fake_pxm = arg;
-	u64 start, end;
+	u64 start, end, align;
 	int node;
 
 	cfmws = (struct acpi_cedt_cfmws *)header;
 	start = cfmws->base_hpa;
 	end = cfmws->base_hpa + cfmws->window_size;
 
+	/* Align memblock size to CFMW regions if possible */
+	align = 1UL << __ffs(start | end);
+	if (align >= SZ_256M) {
+		if (memory_block_advise_max_size(align) < 0)
+			pr_warn("CFMWS: memblock size advise failed\n");
+	} else {
+		pr_err("CFMWS: [BIOS BUG] base/size alignment violates spec\n");
+	}
+
 	/*
 	 * The SRAT may have already described NUMA details for all,
 	 * or a portion of, this CFMWS HPA range. Extend the memblks
-- 
2.43.0

