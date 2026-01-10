Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B14227B32B
	for <linux-cxl@vger.kernel.org>; Sat, 10 Jan 2026 19:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768072059; cv=none; b=fvkTQTiOXl1F71NlO2IjpYgho46LZmOy9wHNBByCg5+YYIPfCQPtWjtQxaMcQRtPglQ/iVGgdgc32/wDu86RSE6D1XYp3eDvMaQBaq2h+ivQVqf9qg8Us0/EOY6OPMTKAv7UFGryCXpM5fhasNkKaAha8Ia1/EOoGZK/22cTMQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768072059; c=relaxed/simple;
	bh=91y8DlsGHvFqSo1YPUhYH5DfNbwDctVaD99uH0fOzzI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eAIjrIaKUcmxJaz4AVTT3Qs498Q3ZYy9QoJK3I11UqKudG7GdvuZuwnFv5CJCi7Uxf+gJc6bl6CAROUGEdz2j96wFc0UR3W6OcnY26SWx/GkxoWysmiwWTS9APfBkmOeTBeK1NuH73aCfFhhKPsyRhU2pT4McR/Utbj9IfNauXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mrRndkCD; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mrRndkCD"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-45a815c1cfdso914580b6e.0
        for <linux-cxl@vger.kernel.org>; Sat, 10 Jan 2026 11:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768072057; x=1768676857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=1kxXWJvr37TXUuYsr8iBFLGiGmenc+CVNu+9/LLD/pI=;
        b=mrRndkCDVLD0jLhxlupz9kHoodubm5b2yE0Ju7qMRiBCEQNdYHb2EN7VDrZP619anJ
         iKxeAb7XbhXrGEEVtw8KyMPML6QoCK1QNiPq77XYnl064FiOohYzrfZY6Y2h1dQfo6Qc
         chAd19Ikc7KbclzWBCGqEgZImoLmQZ1BO973OjvPVWL3zDFecwmCAYn9sXIrOlYP98Jp
         XVA3nw1z+ZMqOwi4FDdTOI+88cIt2x0tsb4uVJ7oJu3mdzsfnX/5UM9fEpfrsX6XFbTN
         rs+G+e8sHu/SVlOIXcU9Gcn9kNvcysNmPlaY3HMf1S/bJskucKovf4hkTCzKfjn5EwBd
         mngg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768072057; x=1768676857;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1kxXWJvr37TXUuYsr8iBFLGiGmenc+CVNu+9/LLD/pI=;
        b=lKEfc8z2OmyF1mkPfsoX4vXDVwzIbOs4j+rsPzCs94HjJwFl3V+oN2VXoInFgF/vYe
         LQ5lL0APosoo6b22VQRYARx/crt2HXFBpTSPSTe7RPrsqwNi6RYgifnkSC4RsT+C4KTr
         71XX1cVYI9gERUreC9ChGFOEF8sEGLS/Ff9bx6u6TidRvm87zjuL56IU32d5C7R7lerc
         94Bqgpdfp6EMz8Eybd5r5hjTanDfadwkCz8N9dvkMt4nvzt5+hQECiuNWo1Y/s+riUeb
         vKWfMOKEJ9Lt7mpUQvAEDwuetrSc1oOgNYu95FL7eWuopSEI+ZZSvQyKBY2053QKns4E
         B3+g==
X-Forwarded-Encrypted: i=1; AJvYcCVTTqpH8L8QHNlFlpZ6UnSx4y/RqW3FnRhqGl61inrAQeQnsDVjBZtJBBM3sqg6HI+Qt0ts+2WvfTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YywQQynfeBclWRC8yozbzPFdm3B+BsS3uZXvH6DY4UF37W08K5Q
	nVd6thkcTcDH4/Rtk9QDEG2wnU/cirC2Kdl0I0YrbelodPxxcXgPDszN
X-Gm-Gg: AY/fxX70awPBNwCp8FkVYIbzGQYKJO9jLAWqV68t7QroSsa4Ngj1hfF9HANmdYkRJL/
	MeqOrgh+PhX3uY7IS88KaTThz8TPqTvzBF8nvvYpIuuMR6RUUULBfjXenzMzMU3yNL5H0Ms4uKW
	G0IfmvwDEh1K+8bUwtyFE2bm4G9JkQRbayswQJbYfdz3KhH7gSIE2K2Rzrjt2hq8YPV04DWcvWf
	YBxsWjBgvqeupc9sN4uHzDCcqeihLH2PbuRMb6CjjaRq+np4a4yzepGjsP6yd9FGGe2NHJTfSKp
	nSIphobihQ8YkPD1HupshJs0L24YfwHR+33Pdu+8smLp9S1RgyU170x3ORFVViNDlB6k0kfUcPw
	th9ysQrCEWACvnlARXqpISm+4GO1twUhPp2BYOBeg1fstYDQ1atLAR3Bh+eTrHp7WBEIc6YtIum
	0ykY1YYf0VDRyUaHaabi+DTtogX0om6tfypiFx/OzkQOuq
X-Google-Smtp-Source: AGHT+IHF3kxlvFCYdu1TdAxwzT3/VhpgRW+MaVF+0hexls3iOlpvZgWGzL6a5rAL1q7LEdZ1m6hFrQ==
X-Received: by 2002:a05:6808:2445:b0:450:b8da:b800 with SMTP id 5614622812f47-45a6bf119c0mr6228889b6e.47.1768072057069;
        Sat, 10 Jan 2026 11:07:37 -0800 (PST)
Received: from localhost.localdomain ([2603:8080:1500:3d89:7d36:1b0c:6e77:5735])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ffa4de55ffsm9254775fac.2.2026.01.10.11.07.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 10 Jan 2026 11:07:36 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
From: John Groves <John@Groves.net>
X-Google-Original-From: John Groves <john@groves.net>
To: John Groves <John@Groves.net>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: John Groves <jgroves@micron.com>,
	Joao Martins <joao.m.martins@oracle.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	David Hildenbrand <david@kernel.org>,
	Ying Huang <huang.ying.caritas@gmail.com>,
	Aravind Ramesh <arramesh@micron.com>,
	Ajay Joshi <ajayjoshi@micron.com>,
	venkataravis@micron.com,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	John Groves <john@groves.net>
Subject: [PATCH] Add some missing kerneldoc comment fields for struct dev_dax
Date: Sat, 10 Jan 2026 13:07:23 -0600
Message-ID: <20260110190723.5562-1-john@groves.net>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the missing @align and @memmap_on_memory fields to kerneldoc comment
header for struct dev_dax.

Also, some other fields were followed by '-' and others by ':'. Fix all
to be ':' for actual kerneldoc compliance.

Fixes: 33cf94d71766 ("device-dax: make align a per-device property")
Fixes: 4eca0ef49af9 ("dax/kmem: allow kmem to add memory with memmap_on_memory")
Signed-off-by: John Groves <john@groves.net>
---
 drivers/dax/dax-private.h | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
index 0867115aeef2..a7c4ff258737 100644
--- a/drivers/dax/dax-private.h
+++ b/drivers/dax/dax-private.h
@@ -65,16 +65,17 @@ struct dev_dax_range {
 };
 
 /**
- * struct dev_dax - instance data for a subdivision of a dax region, and
- * data while the device is activated in the driver.
- * @region - parent region
- * @dax_dev - core dax functionality
+ * struct dev_dax - instance data for a subdivision of a dax region
+ * @region: parent region
+ * @dax_dev: core dax functionality
+ * @align: alignment of this instance
  * @target_node: effective numa node if dev_dax memory range is onlined
  * @dyn_id: is this a dynamic or statically created instance
  * @id: ida allocated id when the dax_region is not static
  * @ida: mapping id allocator
- * @dev - device core
- * @pgmap - pgmap for memmap setup / lifetime (driver owned)
+ * @dev: device core
+ * @pgmap: pgmap for memmap setup / lifetime (driver owned)
+ * @memmap_on_memory: allow kmem to put the memmap in the memory
  * @nr_range: size of @ranges
  * @ranges: range tuples of memory used
  */

base-commit: 9ace4753a5202b02191d54e9fdf7f9e3d02b85eb
-- 
2.52.0

