Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28BC63C8
	for <linux-cxl@vger.kernel.org>; Mon, 25 Mar 2024 19:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711393508; cv=none; b=HS23ZP1BeAaR/dXTj2iQfrG9ppc2XetEs9GUBUfdPSAIemhXPnNREcu3g9Ed3iO/rU6kzVxQYSFFWPXRdjs1ZwhteyJ+j8XqYh11SYQIYxZSvC1FTAZkQfM6gIHVQgyeOQG/G3LZmWz9xrm+UG9GdBNw8iAXmsQkoE+rLtmTREM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711393508; c=relaxed/simple;
	bh=bY9OUoQnlJcGkHF0LCPSTf31ilHkOgLIamkwuAvGnms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nPrHE+LTBFybiVBWVcRAkUnY3shVJ2g0E764ljitqmFwpLhCS8uRuc3w8lyUSLHY+tfamlh6jEdgU9TlxI+jiT03G3MNlOMTvq3awCDrpa+1LskndVUs+Clj914xnph7z5X2OB5YubMA5Vl4AtzkDPtMT3nAgOFL/n0aYyz3CIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fODg7s+/; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fODg7s+/"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e6aaa2f02cso2888081b3a.2
        for <linux-cxl@vger.kernel.org>; Mon, 25 Mar 2024 12:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711393506; x=1711998306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j3xErw1D7pd0Oy+zBQHAytaYYoPYpk9Jd+HPJGbw/j8=;
        b=fODg7s+/lUaL/yWVsLD0ozWNg2eJ1qZKn+wG+89K11gXfuI0PfW6kMMH91n79euNlm
         xR+TIEAfYsvs2Xj9YdFpw5ZlMsVY133pn4oudapIqvoaK8wavUwehIO10js+8M5VWQv7
         ArJJXRY/VfZ6brnqqCB6dRr/l0jXo0I9ZOaoKA0BpO3cspktSoADDxkG5TFZvfd9qKtv
         sxogURyUAbdJuooPjkuwCxP1NzkKQVe88ySzKPXCavuXQwr6M1KgPR5FT+W4VopBSJH3
         bpMekX1p7FaqeYawroV8/io1eWnkObxVkt6HBCdZmig3L8iolQRP6RgWbUHmG1JjaF5r
         Wf2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711393506; x=1711998306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j3xErw1D7pd0Oy+zBQHAytaYYoPYpk9Jd+HPJGbw/j8=;
        b=UwOBKZ2MVQgnc7ygBLWtKQ24n1P9X5o/hb9HmbUG6xI26xiNSt33hcR5VfV5RZJlqI
         sERshfD//XQVv65WAVZ8CzA+VA+sxhsnlMCYS878/H4qa3etTvbsqksPCRBkpS3kfcN5
         mmvbzvciCK8jqx9aSxXoZD+bwflBLClHJm7njnXDicUWlCM20246IFLOvFGLwAbvL6NS
         ZRSSfiDe6Kz9/S+RWt3kOPM8dBfuIt8xb9H+jMvlRr2GlIvbPW4rzecyaR5VwuvEmAI4
         yugTDNyr93/eyq8CGiw8Kg6U/2WLprmbgDa7Fujlv59uhAFrWWECJYZEOjf+H/lgXprl
         KZYw==
X-Forwarded-Encrypted: i=1; AJvYcCWqSCC78B5TLBIrHwWY9TtYSDmulcj4OfVP8Ir6PbBEDlS1hq6ZZKOlr8baQHOizHBBiY5/Bwa2qaCCPyEbTtvSnmyIWWFlePc3
X-Gm-Message-State: AOJu0YxccucepUIyvredJXmWaG2DHgvcKay8/TvNyqOBK00zvIKunxEG
	/AqoJq4bSQOyZL/k5kOqwj5dJILuv9UYO8yfzBT43rGzEp5ynEDWIQAU6Ieo
X-Google-Smtp-Source: AGHT+IGAoTYpamTa5d5OnaOZK4Ce1M2BOIOF3MtObyKz38nf/HynrGLAJSbsZFdb3lLdMdbSuUH8OA==
X-Received: by 2002:a05:6a20:12d5:b0:1a3:647b:b895 with SMTP id v21-20020a056a2012d500b001a3647bb895mr8351996pzg.47.1711393506060;
        Mon, 25 Mar 2024 12:05:06 -0700 (PDT)
Received: from localhost.localdomain ([2601:641:300:14de:7bed:2ef:bead:18b])
        by smtp.gmail.com with ESMTPSA id z7-20020a634c07000000b005f05c9ee8d3sm1722663pga.93.2024.03.25.12.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 12:05:05 -0700 (PDT)
From: nifan.cxl@gmail.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com,
	linux-cxl@vger.kernel.org,
	gregory.price@memverge.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	a.manzanares@samsung.com,
	dave@stgolabs.net,
	nmtadam.samsung@gmail.com,
	nifan.cxl@gmail.com,
	jim.harris@samsung.com,
	Jorgen.Hansen@wdc.com,
	wj28.lee@gmail.com,
	Fan Ni <fan.ni@samsung.com>
Subject: [PATCH v6 12/12] hw/mem/cxl_type3: Allow to release extent superset in QMP interface
Date: Mon, 25 Mar 2024 12:02:30 -0700
Message-ID: <20240325190339.696686-13-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240325190339.696686-1-nifan.cxl@gmail.com>
References: <20240325190339.696686-1-nifan.cxl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fan Ni <fan.ni@samsung.com>

Before the change, the QMP interface used for add/release DC extents
only allows to release an extent whose DPA range is contained by a single
accepted extent in the device.

With the change, we relax the constraints.  As long as the DPA range of
the extent is covered by accepted extents, we allow the release.

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/mem/cxl_type3.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 2628a6f50f..62c2022477 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1935,8 +1935,7 @@ static void qmp_cxl_process_dynamic_capacity(const char *path, CxlEventLog log,
                            "cannot release extent with pending DPA range");
                 return;
             }
-            if (!cxl_extents_contains_dpa_range(&dcd->dc.extents,
-                                                dpa, len)) {
+            if (!ct3_test_region_block_backed(dcd, dpa, len)) {
                 error_setg(errp,
                            "cannot release extent with non-existing DPA range");
                 return;
-- 
2.43.0

