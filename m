Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279BD244660;
	Tue, 10 Jun 2025 17:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749576837; cv=none; b=b/USwIpjUEstxtqvjjfXrVqaPG/M4ujSnC6zAm54/iiML5QBKui9dAaQaWkH/U1MxLtmw/1wEr6r18t4cvoCVe7BnR3oz+biqdOH49j5wX7ZJKoLTnf6733zRRu54tjIbuS50jN5w70MZ2KAUhznErg27XmKYgBZKBdgQIfJAPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749576837; c=relaxed/simple;
	bh=0CPTphKhrUBOZPlZ9pKlo5NWj8DVPWh9CCrT/9TEVXE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tpFBDg1xBwifnYPBgfZkF00yCx1m44mHLyvjxbzNbu/rZjlIYD0QYjpmKUItgh/TJQGJJ1RKEBLkfH4CPVzqHXCKIyC0DtwpGxofu6vY2DJPOpFp3Ab/wR+lZfGXBDOb22B2dom5vbiXjr2zQCu1wxJaxcxLBtDJIxlfzby2XMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X7fAPwTw; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7fAPwTw"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-23636167afeso13712235ad.3;
        Tue, 10 Jun 2025 10:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749576835; x=1750181635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xJ4a1Zth++0ZqMvctA3wgDOhGEIMr6HHOHD5mEZCyYA=;
        b=X7fAPwTw7heKMErZqWP//rUyF7YRMB9tsDFlrdRlogoAUuu/JegR3MlSJl6cQ8M7w3
         u4H8xlZLSYdfPVcfOF9J3aPCmURu6SbR6Sn+oP6gFgQQWTlOFMqEub/WabnOOWnRJ7Eq
         uFTmSYxDPWqCtFcwwmcCIP8aCJBYnms1EaU8AN/+ooAqtKKiAHBVv5ahGCUe+qG6R5FK
         rFR3vkKt0+GE5UZWFmWnCDOs7u++J2kBaTSfu8uJnLxxv9ZA3ISlonYOMD6SHktxkhaK
         CCZ7Al5dQRZ+vLWnuAQNsRN5MwrDA81t0F5XB5Fozl0VGLgWye0qfEqtC/nR0UkwaYoX
         DxMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749576835; x=1750181635;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xJ4a1Zth++0ZqMvctA3wgDOhGEIMr6HHOHD5mEZCyYA=;
        b=cjlau/6MRsR65c8ouXLljdHrB0jWcdVAdL5QngXcwCcXAkSyFT5gOh2zn/2v+S7q0y
         NRnfZ3P8KJxsy6eLx/fBTSMLIMUCDC1VGDF+0Eg/7d8KBBEgZP7mwL/x+jg+ZadfD0Hq
         oePyCoA6KDQA4o8y8yUhGU2iqCsFhrt/d1LOCsEPtMkCYzCHZYyTelEWrjD8L3STN/rI
         +N4InOTr1hQSr8iYolARIgKryPTrEsZbrq0ToIu+ESlp+AWW4giQ428BvLjjFb/6j/lp
         GAP4o9qPeZuqCVA4PV1egEy5WlB2goMZNptpv8yCT3MK8RuFFb3NacTFcdTDX8zY5WqC
         ESLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhw1UOxqMmk4Hxod1gsxtNnG+8z6UBEcbOWZBYPz2vNAuerhQ254YUFtGF9F+R9voDny7f2sQGb88=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuzjcMlq8lp/WzhfxWtLzHmGUkbXyl2k7N+4jfKU+3mgX6mqPs
	fOevwujqcgbuT1fM2DKevnRTHTX2dwcnVUKwJ4LAI79yv61D2Njv5WKN
X-Gm-Gg: ASbGncvj665TnAVZ8eXOVty6Czzn8A6wPInC6wS1nSHczXKRnsi9jM1G9ZElQ/Aq8DY
	OzpR3R9TFYgbqurXoWqpCzWKG3yL/UR/ZWRMXSmbiJCMD8fj4gsV/4bj2BvbDRXtdqdTq6zM2tm
	s8dAVGgKm8lMjZf5ZsTlCUE5j02Lxdxj761B7r1zHPQqZV51kUCW+lNv8fe5oaOaN36S+KeHwsJ
	7GKG73LGUotA8PEkmVjo0tGIy8MHXNbtFGlVQ9QF/x69pZ8d3ahv8uRP/R5yOCOc1P/kNinSUtp
	aEAFxGHRk5sK6bgroZXH+3GWj62vA0koqmYp19U1MMj6jIEJiepRekWVpHA=
X-Google-Smtp-Source: AGHT+IFZJTHsdk/TxpbHmEjLgwmerwlZHiNEHv4q9luAbNVAuVqA2jk6ZzkIZbMPI5Jw47KA/seAtA==
X-Received: by 2002:a17:902:d585:b0:235:1ff0:369f with SMTP id d9443c01a7336-23641a8acddmr2433695ad.5.1749576835279;
        Tue, 10 Jun 2025 10:33:55 -0700 (PDT)
Received: from localhost ([159.117.73.36])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23603077f95sm73627005ad.13.2025.06.10.10.33.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jun 2025 10:33:54 -0700 (PDT)
From: Nai-Chen Cheng <bleach1827@gmail.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: linux-cxl@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	Shuah Khan <skhan@linuxfoundation.org>,
	Nai-Chen Cheng <bleach1827@gmail.com>
Subject: [PATCH] Documentation: fix typo in CXL driver documentation
Date: Wed, 11 Jun 2025 01:31:52 +0800
Message-ID: <20250610173152.33566-1-bleach1827@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typo 'enumates' to 'enumerate' in CXL driver operation
documentation to improve readability.

Signed-off-by: Nai-Chen Cheng <bleach1827@gmail.com>
---
 Documentation/driver-api/cxl/linux/cxl-driver.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/driver-api/cxl/linux/cxl-driver.rst b/Documentation/driver-api/cxl/linux/cxl-driver.rst
index 9759e90c3cf1..dd6dd17dc536 100644
--- a/Documentation/driver-api/cxl/linux/cxl-driver.rst
+++ b/Documentation/driver-api/cxl/linux/cxl-driver.rst
@@ -20,7 +20,7 @@ The CXL driver is split into a number of drivers.
 * cxl_port  - initializes root and provides port enumeration interface.
 * cxl_acpi  - initializes root decoders and interacts with ACPI data.
 * cxl_p/mem - initializes memory devices
-* cxl_pci   - uses cxl_port to enumates the actual fabric hierarchy.
+* cxl_pci   - uses cxl_port to enumerate the actual fabric hierarchy.
 
 Driver Devices
 ==============
-- 
2.43.0

