Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCB6314B9F
	for <linux-cxl@vger.kernel.org>; Fri,  5 Dec 2025 19:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764964765; cv=none; b=JsRfVWV0ZjAaWnBem5zEeoNNrMiHsmwS/CcIW11tzMUNDFo9ZmWUbnZQxrNy42wmiL9GiRzZd7lFOARPEkMh1iY2Tns+FTfnIt7C0zXHmMXiBK5ovlQMqEpO1fn7sgZZV2du0oPnihWLVj1RG/dPVFzlPFJc7xuInIMvI7DKVdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764964765; c=relaxed/simple;
	bh=KXG9ML4QrywwSbj9RV55Xkow5gc4O6RdtcrRXbI8fUI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aqJO8VhTjQ6UXlnBj71wLCw8rb3IwYsXbPYpO88JEv6It3D7+6ydgIT0+JelZ0qDDYUGgw/Z2KRwwSDcrmQcLCiyMZ0AIBkA9JndLKEDlCFb4N+LLvj5DSHkdNIs9wqcsRasnbfa2ZL1XsDPcb73DVdsrGEjIoC6UrLS4gQSTyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hfgcYKL/; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hfgcYKL/"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-297d4ac44fbso20104565ad.0
        for <linux-cxl@vger.kernel.org>; Fri, 05 Dec 2025 11:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764964763; x=1765569563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=llFqqyNk8jXBqJcl0wD7NrMGTORDR9jCdFvzBCTiJbM=;
        b=hfgcYKL/mPmHfd4v7FBWyurBCwLOIaFheRWg9BOQt+fsfo7lUoCd50rtvvdQpmk23C
         ra010CAZcDk2ot8q2VljjWwuusfq8XzTBhMSujH+/I0dioUykr+0DoPMaTCRteB1vJ6i
         ujwFUo+iV7c9PnS9Bna5HlnePeICcR/d+bXJcsgDHQaUVSpIvIqWX6qrLUFo5rHD14aS
         pxviLbQwMCrOZ3CwhajvztHglAZF4fdU0gySJT4r3BcUYUAlgSFMGHb41XLz68rMPMB5
         OFjv4xmqfTTxKPDUEF2yjdv5uEw7aaJRf1/TSckPvkLAoqwCY3Mj0mMCGZPz9G+LUOiR
         6IlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764964763; x=1765569563;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=llFqqyNk8jXBqJcl0wD7NrMGTORDR9jCdFvzBCTiJbM=;
        b=nozHOogW2Tj1GTu5hXwxjBayJkICP/mNVXDSKc4XEjZZyQaRJ27tz4Ik0p4JhhSBqX
         evRCn2/9HBEDw9YGYdc5qwVB/Wzq4lX+h5h0dL9bN8V85ii289eFDttAtHXguCk34thq
         B4aNrKAKtXiRKucQGLstMqqXp+j5cUUtbGjxa7QW4HIsS3oh6IHkayIeoK6qv/BKrpoX
         KOT9hmHJLoV5fkiSNeu7QzagxS56rA9NC4aS3NT7QnhgY/Fog/NFHdcgTRvvkTQjtB6V
         BOSek5IkSEfOOsg+MYIEdvvL1q3Eh954UmOSEjTtBA9JFd3eUE0imHtkX3WmrtA2zTB0
         gABQ==
X-Forwarded-Encrypted: i=1; AJvYcCVx90DSAbS5Ou5S/pZqNADll9f1Tu0Memswej1bnKfbvtOWzRPkx30b5o34t4KaqVurmMp+pGe3JP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP+HxUurWDcFsP73lbZoQu5wRLouDvakmz4m+v50qErXZS/GcP
	95IXIkU9oqx+GsuR5SH9TGoonxaW0ha0cXZhnRgt/I6o6W4SMh05eRAV/FNMm2dL
X-Gm-Gg: ASbGncvEjNig+dTkWAQR4+Q87OJVYz3SrwHhSHy//yZVLRqy41xhvTFlk/f8U6X+cUz
	18xBbEqiupDUblRBgT1gdLLxHdFRUokX0FZVNykrwTYKMTU6z2VsJlLsp8JN9kqjiK5eyzBnxA8
	fQ47I1O/iJu6R6YDucNJI6lEldzGpG9C2YGzMtwcmCVDIFBWIisH7y9hNNHMdR5JzyhdDIgC0ST
	GguAa1H71lGiO12JQTYPPA8WLM13aKB15vO63vzDYRcjj9MsvDm2lKYfnlD9NFE0viAWdLWVORi
	+aKH67lpr0Iu5BE/LgovArw/cWRzZ6Z4+kZpt69WjpBwquNrhZ7rZhTe8AofjtkS4KaKMX3vXZs
	lz2IrlL552wQVGfGjCRb7ZKuMGeU1+zhwAZslIbMrjyNH9997SykjCtFaDk5/4+8I/9g4tGIYZ0
	xsM7dzmTap2U50sGRuJGdQPA==
X-Google-Smtp-Source: AGHT+IFBaNQIvA9NMkJ9rbJbun8cBBs/oHm859m9/Ia1NTDJ9a71KfJJjG6K7z/p+vPNVd5e/Ju7/A==
X-Received: by 2002:a17:903:1b23:b0:297:e6ca:c053 with SMTP id d9443c01a7336-29d9eda6fa4mr90800315ad.28.1764964763339;
        Fri, 05 Dec 2025 11:59:23 -0800 (PST)
Received: from Swarag-NB.localdomain ([117.254.5.43])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29dae99effasm57026415ad.57.2025.12.05.11.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 11:59:22 -0800 (PST)
From: Swarag V S <swaragvs09@gmail.com>
To: dan.j.williams@intel.com
Cc: jonathan.cameron@huawei.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Swarag V S <swaragvs09@gmail.com>
Subject: [PATCH] cxl/pci: Fixed typo in Kconfig help text
Date: Sat,  6 Dec 2025 01:25:25 +0530
Message-Id: <20251205195524.2454-1-swaragvs09@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The help text for CXL_PCI incorrectly uses 'Device's' (possessive)

instead of 'Devices' (plural). Fixed the grammar.

Signed-off-by: Swarag V S <swaragvs09@gmail.com>
---
Hi Dan and CXL team,
This is a small grammar fix for the CXL Kconfig and my first open source contribution.
Found this small grammar typo while reading the documentation for my seminar>
Hope it helps!

 drivers/cxl/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 48b7314af..78b39b3c5 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -24,7 +24,7 @@ config CXL_PCI
 	default CXL_BUS
 	help
 	  The CXL specification defines a "CXL memory device" sub-class in the
-	  PCI "memory controller" base class of devices. Device's identified by
+	  PCI "memory controller" base class of devices. Devices identified by
 	  this class code provide support for volatile and / or persistent
 	  memory to be mapped into the system address map (Host-managed Device
 	  Memory (HDM)).
-- 
2.51.0.windows.1

