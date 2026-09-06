Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43833395AFA
	for <linux-cxl@vger.kernel.org>; Sun,  6 Sep 2026 15:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788710246; cv=none; b=en4SkL87/s4Tcqb4AN2xvC1kUq4vfcHujX2d81AtXfSScNGudlKsz4x1FxkU4KjvBP7nLXXD0K8xyevaLa0xSFLUTVwfEVm8p4IIRBPSHLArZOMKFkTb+5EfHhFy0GI5E+IzND2/qtCO4LLEedPLSGXF1U4bWe8RldMYGZyDRRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788710246; c=relaxed/simple;
	bh=R+OWhEGuC0AXGIp00EKjH9kKnhBwUsVuPJbJI3JH3kY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mHZFCqMMH1AeOMDJURjMF0Sp0w9k+uQ3tW02tR3IimI3cSJ+A6iiRjhoDypFnz1NPXMpJLfEgBEbkmVp0Av5iIuw3I4zs75I34YzQifcSZ7ZjWZrixIly/8iRGBnLLSO8dn49uOdIYX1go1HakgR/lzNA8O/66K91rE6vR2DGIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YkKRsAzE; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YkKRsAzE"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38e42560ebcso1957626a91.1
        for <linux-cxl@vger.kernel.org>; Sun, 06 Sep 2026 08:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788710239; x=1789315039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=apIkgapLuCgEcMXQm6sW1tAj0MdsQkxgudPXQSkaM5k=;
        b=YkKRsAzEC6mYD2jv4yGn+fUGdX43NWj86K6wWZQVmj2mPqkrXopJwg1ZRsIhXKxtSO
         Zb4nu15iNqJw7DCBNdIJ+ABxVoz5tNdDqEOvNsYNGF7Z4IuFABNb+S/2PDtObfebGJWd
         IXHH3/34yJU4zfJ4WEf+sL1luL7/FVRTynSLgSizEvUdvr4WzJVWY5r7NnO1VdTUaKXC
         l8FdFXaVllrXbPVaku/5QeMmMrLLvau7v0M28ub3+ANnOnKYCtZj6hxMivaMGrPRuAc5
         Wra62khdnhfhvohlxqKFUfYUbTsE7aXBmuu/C20voq5Lb72X1xaNT22/S6u26iRYCVLe
         jFMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788710239; x=1789315039;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=apIkgapLuCgEcMXQm6sW1tAj0MdsQkxgudPXQSkaM5k=;
        b=WeTfYiLWc+OIk8fTN0qME2faDSRE02RlbqmIsnuhPPfS4NUlDgIgL8BP6MK9WYNG8b
         SVp2hNd+OS74rxfaWtgs9uroq1tr7rUOQEvi8DGa37bwbNLvHXfGZKvsyY/49cSedzfy
         N3BwhM6u6azvtO6ckSDTOGFPorrUs6Y00n6Vq9X7v3tNyfexrejJE3VQN/qmeuxLCHjY
         mSfons0Ob8QMnFVM6EzSOwNz2rCiDzadmvDDW0zpG/uaX/F6twnDanyjfdOrZnU9QPes
         7Df5KYMtBkSUEQpqAx/HKDJc2yZDrXeo2egjS2hasOa6MrSa4d5KVyVU9GTJQatCIWFM
         1BYA==
X-Gm-Message-State: AFuF++liHiiaHYYFn/qJnq4spzjhOpqJ2PmH9mOybXdC+/IaVwVUXrBL
	Uz0ZAxP60OpXZryr5Q5OcuRF68pcAgbVmMJU+Tk4gueCZFK+pGkzpjWY
X-Gm-Gg: AYBFou15zfvCx1vgqNtAAUu650C0d5GIOKesBWf3Bj1dqU4g/pZVpPP1SKu5J1n6DUj
	H/uo5+wTmOn+bu3upiWBItFCGNBJyaGhs38yd/uRE6u2GQomWoTj18Dm1ZWVEoUBazLz+zrUDTm
	M4ghsAPhGfOeggjQ9zqFjRoQZVuf4GaSpnbRndFZmMuCDE/dlI+g4Z+qWWWOKD9LzNewBjG/kmk
	vsDwu1qGv4tD+wSBed260pHZwd44crhXk2L/4Xi23MxMiuPCtt7aknOL83wiNDgLOdIdso9bf16
	9ThZ00Zp3Pr5/W6Ew6d2452z2TmTEZoNHJ/no4NFZ+AN8RFmxVGyyHDCypN3M49FBMMSPpasUPQ
	C9GrN6YMRXw3ldZFvoyw33JUrefl+v1eYFRT0eEdPpp4Ioq8Ly1i1OE75EtI1TOs/as0qVQx7BE
	1q3ALdNuVQfFUL/uQF/TzEEzjLKo3XMmdILisYrN6FHLc0Z1P19kCPMjW4jxY9BGCqYv6oqDjSr
	nRq8L0IcRnxUkimrw==
X-Received: by 2002:a17:90b:5243:b0:38e:c232:9d3f with SMTP id 98e67ed59e1d1-39b2614df1emr28808066a91.5.1788710239188;
        Sun, 06 Sep 2026 08:57:19 -0700 (PDT)
Received: from acer-nitro-anv15-41.entro.com ([118.34.230.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b07b197a9sm21756544a91.0.2026.09.06.08.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 08:57:18 -0700 (PDT)
From: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] cxl/events: Return IRQ_NONE when no event is pending
Date: Sun,  6 Sep 2026 21:27:05 +0530
Message-ID: <20260906155705.13252-1-shaikhkamal2012@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CXL event interrupts may share an MSI/MSI-X vector with other event
logs or device features. Consequently, cxl_event_thread() is registered
with IRQF_SHARED and must determine whether an interrupt belongs to the
event-log facility.

The handler masks the Device Event Status register to the event logs
supported by the driver. However, when no supported status bit is set,
it exits the processing loop and still returns IRQ_HANDLED.

Track whether at least one supported event status bit was observed.
Return IRQ_NONE when there was no event to service, while continuing to
return IRQ_HANDLED after processing one or more event logs.

Fixes: a49aa8141b65 ("cxl/mem: Wire up event interrupts")

Signed-off-by: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
---
 drivers/cxl/pci.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index c7c91e8dc51d..8b560cae91f2 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -515,6 +515,7 @@ static irqreturn_t cxl_event_thread(int irq, void *id)
 	struct cxl_dev_id *dev_id = id;
 	struct cxl_dev_state *cxlds = dev_id->cxlds;
 	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
+	bool handled = false;
 	u32 status;
 
 	do {
@@ -527,11 +528,13 @@ static irqreturn_t cxl_event_thread(int irq, void *id)
 		status &= CXLDEV_EVENT_STATUS_ALL;
 		if (!status)
 			break;
+
+		handled = true;
 		cxl_mem_get_event_records(mds, status);
 		cond_resched();
 	} while (status);
 
-	return IRQ_HANDLED;
+	return handled ? IRQ_HANDLED : IRQ_NONE;
 }
 
 static int cxl_event_req_irq(struct cxl_dev_state *cxlds, u8 setting)

base-commit: 7098e9cd98a05c0c5de2fae0c2465f9d966fdd07
prerequisite-patch-id: 92e40cd60a697020faac475dcc77ba63b33434ea
prerequisite-patch-id: 10027ad5d9aed85806047f807b3a76273b6c4a77
-- 
2.43.0

