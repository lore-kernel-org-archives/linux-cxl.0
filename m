Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB2E343893
	for <linux-cxl@vger.kernel.org>; Sat, 12 Sep 2026 09:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789205912; cv=none; b=UBHIM0dRKkKl/rBU/pEsuYkULbzaQ+H2vO+1cvxknvUjik+OLsOIZQ03tOvoWxeUU+ATRLzt2q97g4f0SMAiKfAbIDJf4c/pzRt3jKIIkeoBsDrEPvKCzJ4+P3AOLyFkAAmEfXfURK7fLKefWaRZf2P7zQ+2g7+mZDBVXeHjEmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789205912; c=relaxed/simple;
	bh=DMlf7BX21e26FdJU3jD5s4qhG0lSZXtCtwncPmUerlA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LnMPlhiYhqlSizZx1rDGYXe1azGSlspjRQOnAsdIMJVtHNb47qmuJb778FQAIzlrQcTWL8HBi8bSJcI36OF3lixpXtLX9C8SxCZ/D/8KkGBxGdkfW43bMuKT+Kkvec5Zymv0hDq4QYZntzEF1K22sMMjM4u6XFy0y1SHOxJ57TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q9aTkZLh; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q9aTkZLh"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccc09d65so561826a91.3
        for <linux-cxl@vger.kernel.org>; Sat, 12 Sep 2026 02:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789205910; x=1789810710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sv8E4eydRaPEzHxJrkeiEKfp359c2ql+U5LVMcs5Vns=;
        b=Q9aTkZLhkaVKmepnLMtAqCEvW+sFYWVEdXWJBih5YhL6Rhf+8OBnJaJ88WUn+z3461
         MIXp2eWu/YPxhwLpEK8YYGBgptmkcU6IqbASwvDjHOo9aGi6Z7T29fOKsocBpRTrsptv
         uaJ/qyz7eHQzZzJkTB/ALcl8xNshHuUejL/c2h8ZYKS3JSFkX88fr8QcjliJu6vt4/ia
         QgCiooIUhPeJ0p0ZaFuW0LvFBhbl1o4hyLEC09yLnXdC4n9ETzlWrMkZKrdnRNr3Arvw
         2+pVtafJI5HRf2e+bB6GRqxVefalFGho66rKS7xHQd0VSzRQXPmJp9DF3SzAIv+bCDSx
         mPpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789205910; x=1789810710;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sv8E4eydRaPEzHxJrkeiEKfp359c2ql+U5LVMcs5Vns=;
        b=LdsLEJL0Vsgr3PzUrGt2+Qn6K8J/qRHk9orS8ufyhNP8Y2l3AiblTYaPXUmAOfWTOl
         OJjC1E5+PvhNcNX7CPMkkwZl3fP5ZMH2tDTfJrDFx8FzUyrlP6FtVN8Wkca4THqDnQGG
         Ov96q5SKIkjD5yBe6N3kJuy65uBsjAlkvCAW2eljruLPiNiMjsaSDMKO/sMcMHY6Njzu
         BqF2rOwIy68OPrexpqaGtFOsg99KyZL6Pcp3DR3orRCzve4NUFWSX26av0aKvZXHNZ6G
         9i5oy4qBRmQev/gEJFA66ePUXA317r6ln+YShT/BG9UfriTy1Z8Mu9LSgNkwC0ogGhDK
         Ssvw==
X-Forwarded-Encrypted: i=1; AKwUvBxnzMHO9uDMy2BAwC4EIJQZ3DyCUW/Enxk/HUmjFd69GlCsWs1nG06HwmA3d6l1gYMa4sQw5Qaz1GA=@vger.kernel.org
X-Gm-Message-State: AFuF++lAzWTcsULMdpf5IHF7pHSiAn4Ld+fkB0R7UHD0bw3o4RKBzLtq
	ixFbKX01km8XRAAcG5LfQ0rAmBGQjV7Z0bLhWF3MIKcGR7HhIDQEoYVB
X-Gm-Gg: AYBFou3Uh7aaf3f0VEkG8k2PaSXEEpH4+dpEnNHOtlNDoUpptduALNXdilMudukQKvP
	BYGBqyYmdchACtzTw2mUb5VP7ALApQ/P27hh0adh8mhH2pFmt1gMoqU8XCXzuDE8iFrFF80295T
	aS4QDRZIXsk4qLShdBS54BOscm6Nz3h4BfynmnXfAC4z4je0oZQDRKTW7+j8kjmYIwDCaB2yor8
	zGJAsKQ7h20p38OAPdmLzglERI/khS+xsxOrdlC3iMuyZigiDt33MMBYZ2aKsXfUHIkWHb7LrCa
	ejivIvZBaUohPTmTrCBXCXIEkhI0RxWJy7EQfM0OCqZD7ILwwYODBB2rZqe71ZKMmHStitFG7sN
	fGgolJvqr/vZRsbJ5pldzXauF5x7FaSaRqTDGka+y9giF4wvTChTuHK5ejCFM9tyXIgeQQxk0py
	alVauBVC54m5yuNCqvqSMq80EO6e8pJMcDRmEFLQxAbtZFkkEZu5klUPdIAjUoWeoTjeuVxruzA
	td5h1KZLH/BBALQ63LvBylwnQU=
X-Received: by 2002:a17:90b:3906:b0:398:9bd4:d12 with SMTP id 98e67ed59e1d1-39d9c3727b3mr13349887a91.17.1789205910259;
        Sat, 12 Sep 2026 02:38:30 -0700 (PDT)
Received: from acer-nitro-anv15-41.entro.com ([118.34.230.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d98a58d23sm10928052a91.2.2026.09.12.02.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 02:38:29 -0700 (PDT)
From: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>
Cc: anisa.su887@gmail.com,
	benjamin.cheatham@amd.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] cxl/events: Return IRQ_NONE when no event is pending
Date: Sat, 12 Sep 2026 15:08:15 +0530
Message-ID: <20260912093815.14455-1-shaikhkamal2012@gmail.com>
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
with IRQF_SHARED and must determine whether the event-log facility
claimed the interrupt.

The handler masks the Device Event Status register to the event logs
supported by the driver. However, when no supported status bit is set,
it exits the processing loop and still returns IRQ_HANDLED. This
incorrectly reports that the interrupt was claimed and prevents the
generic spurious-interrupt detector from accounting it as unhandled.

Track whether the CXL event handler claimed the interrupt and return
IRQ_NONE when no supported event is detected. If no handler sharing the
vector claims a sustained interrupt storm, the generic spurious-
interrupt detector can eventually identify and disable the affected
IRQ.

Signed-off-by: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
---
Changes in V2:
- Emphasize that returning IRQ_NONE enables generic spurious-interrupt
  detection and drop the Fixes tag. (Jonathan Cameron)
- Check whether the event interrupt is already disabled by Anisa Su's
  patch; no code changes were needed. (Ben Cheatham)
- Rebase onto v7.3-rc2; no code changes.

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

base-commit: df2908090cda368b01ff43709f51890076c56157
-- 
2.43.0

