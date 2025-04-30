Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F0C1E570B
	for <linux-cxl@vger.kernel.org>; Wed, 30 Apr 2025 00:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745971987; cv=none; b=DO/fl7f2S5nd7Zhbrx1Z7KUirFBWOkmDFJmpIizjv1ss8ouMOrRl+227/92vG0nAS3wyy6BjU8B6FWfvXvi1EZaSIwNBNPwM9QwJIDI/ECHq1QshKsPxpZ6VXevU5/zirKynUfM6Dt+GP8R3XTxCPesP6piIlTPZ8Eij/LbgSi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745971987; c=relaxed/simple;
	bh=0K2qYudSIKSpntsCjjospSQ3Faqk32cfHXFTc352FVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jpBQo6k/zg6+8FFToFS3yLnwpQFVXZl6pG3DdODKdp/eqqrbpqcp5+DBMjA9agwoixu0q++96TC9CCmfpJ0ispqchVLhh6VsBgX0YnuNsGiqN6iGA+a2M5zJOZAwEx/UtQ37r86CaIeB4yfmbc/AuzzMm77RHb7fjaE2WAhUFcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=qw9MN/Y7; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="qw9MN/Y7"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4775ccf3e56so4898071cf.0
        for <linux-cxl@vger.kernel.org>; Tue, 29 Apr 2025 17:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1745971984; x=1746576784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0nlYJCidbo7D6EAdzULAlI9wXCDZH50uIfMmptbRecU=;
        b=qw9MN/Y75ouhn6KECXclLkEN/G+rWANX8W0YPDtZyW0zAXvrQDMmz64vBsJf7KYGMi
         mtQT6SaUP6lz8wXAnufPQ1/mk7FG6Qp3J9weSITJRRV7lueUHf0GfqzzGtdnY8NdUSW3
         CWJvguwo9teQFX3dr3fQCAJDAGrgA1lTzcrroMMDUjHnwcsO7s/nC7qXWTyDEgmtb8uD
         R7Q1fpIFA/pUE40A1IhGn6nFZ0QAYfocm1M6L0QjGJEQPfzHqdEiIe9j1mVpQtEPuZfR
         3C+Jc4wcrYQ/lTQLc+E2abFe1nH088Khay5dRikGVEoD9Ovgq64goy1LMFu76xK4DRKY
         y64g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745971984; x=1746576784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0nlYJCidbo7D6EAdzULAlI9wXCDZH50uIfMmptbRecU=;
        b=iMGl6T4DAyNtNesLUS5VNUkaNEEOMzzW7Wsi04O0K5TU4C2SqOSO4T+/kI3CNvl80l
         5PF4Ca4xIFEJx3IlJ1r+KWpcODtp40vgKYsmbG9X2viCDUdV1BULH+h9kHlUrhRuzNi3
         qHkbOHTOutJBGfsmP+Uwn6iY8aHMftvd86rJIyz5S35na+VdDJbmnZ5aPXW6sxpHIz9u
         hfi8xuYW7UaFan3b/WJTdbH2D4k0PR+uuQtH22ASXeiqQRtiogKnJRY5eBxzIr3Y94p8
         F4li3Bzw6DA21pusPiTbY9NIYo2iT/dHZRZ3s35+IR12k98oC1hYLioIH34dGWrxrI5Y
         xUww==
X-Gm-Message-State: AOJu0Yx/l4sqeG7rPurTtEyr8domSLckHpW6D5TxGzauS0NINQH3sUWe
	0m1uUkdqCtRiCYut5Jalzm2za1zSaOUspK7Wu3qIk4AgPlHD/qGKOXz3FghSx0ChL4HuJ7xh0sE
	j
X-Gm-Gg: ASbGncvAXEIzRzIa632aVYjKADJcCrzCW0t1l74LWZ85MJcZ7RNUsGnYCqPwhTNupZ8
	86ScrDwXxRZ7OYj+Jy7e4hiT6BM21p5bg3NK23XVzrKhKjlDNW1G6KWn5feM2sYubwPByGyeWsC
	ygCuERAZA6Wffd4blI7zNridn+yLB2JOHl9uoGMp7URpIHHwgVhdqs0oQWeGQjT+4Xz3e5qw/YM
	0HWBaP5vRuVcSLyEZdjAV9x6jhDu3wDVAgivEcxw9WSVxnuU8+5ylc5zkaT/JOdAQIz7sBRDLOD
	PuJKabeJP6iMdlvaRD3LzXJtOb+MBBBZ7CLiQqpl04s6ITM0uCj9IK1u/+rH6QNl7Wy4iWZ0m5u
	vdYjzcScwIx1AHIjUMLhzqPJfteNG
X-Google-Smtp-Source: AGHT+IHHlI+GitsjsH8YXECXSbCgG0VCNVvdhBX/jA/ObO5ilet3C+3xZmGZflAts3b1Fw2a8vwXHA==
X-Received: by 2002:a05:622a:2483:b0:477:1dd0:6d15 with SMTP id d75a77b69052e-489cb7b9eb5mr13982081cf.5.1745971984051;
        Tue, 29 Apr 2025 17:13:04 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47e9f7a820esm87634411cf.41.2025.04.29.17.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 17:13:03 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-cxl@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	corbet@lwn.net
Subject: [RFC PATCH 16/17] cxl: docs/allocation/tiering
Date: Tue, 29 Apr 2025 20:12:23 -0400
Message-ID: <20250430001224.1028656-17-gourry@gourry.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250430001224.1028656-1-gourry@gourry.net>
References: <20250430001224.1028656-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Carve out a space for folks to explain existing tiering mechanisms
and how CXL capacity interacts with it.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 .../driver-api/cxl/allocation/tiering.rst     | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 Documentation/driver-api/cxl/allocation/tiering.rst

diff --git a/Documentation/driver-api/cxl/allocation/tiering.rst b/Documentation/driver-api/cxl/allocation/tiering.rst
new file mode 100644
index 000000000000..dde7010fff12
--- /dev/null
+++ b/Documentation/driver-api/cxl/allocation/tiering.rst
@@ -0,0 +1,30 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Memory Tiering
+##############
+
+todo
+
+Memory Tiers
+************
+
+todo
+
+
+Transparent Page Placement
+**************************
+
+todo
+
+Data Access MONitor
+*******************
+
+to be updated
+
+References
+==========
+
+- `Self-tuned Memory Tiering RFC prototype and its evaluation <https://lore.kernel.org/all/20250320053937.57734-1-sj@kernel.org/>`_
+- `SK Hynix HMSDK Capacity Expansion <https://github.com/skhynix/hmsdk/wiki/Capacity-Expansion>`_
+- `kernel documentation <https://origin.kernel.org/doc/html/latest/mm/damon/>`_
+- `project website <https://damonitor.github.io/>`_
-- 
2.49.0

