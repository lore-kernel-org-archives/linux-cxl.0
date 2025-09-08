Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D01310631
	for <linux-cxl@vger.kernel.org>; Mon,  8 Sep 2025 15:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757346184; cv=none; b=X+E+15p5gBcI654diV5hRJYno7iYOzxQkSJ8o2vADyuvE/BPyNSYghFP37ebW/cEApvDj6+SJzvu0atrB5/xl/3alfYVykR1xjS1V9t4pVWHn1U3gyYwyDjLQcwTjz/p2zAPU4Pt6Pr5c7Bv04gpc2goNb9iCwDOcg2YN5PnVx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757346184; c=relaxed/simple;
	bh=DisFmMFBSXv0Ws1L2v6rJGekmvpM/RhWkOYxpFItgMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tPlAWLD9l0SD5MBx9RykBIh9YxcDQiohWHJfuP4C5p3EzMYIsweZ+/cr/1TRLJyHvx3/ifFRB1/Yi8FFTLPluJ4PKgKS6j37oYwyOjvbshlwSySsAstBF5zWsC3NE96XkRJCe9wMmNdDdmzcOGodpeoLdTuD9bj/Jwe6XtVOoCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=T2ft00v9; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="T2ft00v9"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45de1f2cdeeso9640135e9.0
        for <linux-cxl@vger.kernel.org>; Mon, 08 Sep 2025 08:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1757346179; x=1757950979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W1IYyzzCzTU65Qn2g3MyhoY0E6PEk7fdDf5bz5konSs=;
        b=T2ft00v93NmGtyGP2s1YJnII6kX0xqRKPDOSn0JRM2Y0a42WfbnFqMsHPmX1tCG3He
         4CS0TGEwAUVSIgwTPpkYSDvdESq1wJdHiprWXkeK/Se7gB/CCSU7zaT/SsAUp2w2FWIS
         v580Jq16WN83kAuXX+Rxfag+2Jcl6FknLeU/gg9/G/ct4sOxNjnrfHWOM7lLJjQKP++f
         C4mP8Oww0niwGl4fVklw7uo9WKbAANTB7ADQewKyXZ8dgkxRaomVMAYBuuqE8BBZD7Bk
         qYnp+jRA68bby9peHf0urqDlW+/bfVySH76NGtX112C9pzNoDbeD8XGy38xrejEqh4KJ
         1kUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757346179; x=1757950979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W1IYyzzCzTU65Qn2g3MyhoY0E6PEk7fdDf5bz5konSs=;
        b=wMrinqzXjLdrh/08zZfMl5swhciJDy2ufeCOXJ+qx0oK3kqZC1aF2pU0XaeNJo7N06
         pI3CKs1yf0/gP+IXLTQNSF4L/y2STLP0Ce9aF5pEq0J4RPGcO59rnT7ELhOJy8UlzLUx
         w44KLtFFMR+diED32U3wNYpFdk+ihUNdPFeDng73qlnbGmfhU9QQdkW5yfvjC460Il46
         CcPzRCWIGNIgWBCZq9WWyzdU1cRqq7sXOCxxz44sTso8M7BZCqIAXOtWPjUDA7NDFHzt
         PPYIO/xdLqx+s3mRhi5QFeORYRgzZQj2fe9d173BB6O/71VQhSkexwzhAyLbVoGa/zK3
         p2Fw==
X-Gm-Message-State: AOJu0YyoHURGiDeYs+eYi0cO0Kke7sEbisvJJldigU+GAh1y8erQ4W7F
	MD+2ELlEAz1W7YnMAFCYAnyUduQb3fpB4OJ5QRBhNj6mn89ENv4AKpfQOo7YxQ==
X-Gm-Gg: ASbGncsiMdQ+QLskzqVJte6lApSVUmsoLa+cC+a91h2rXS4tAZS7bm/lJlAIw+E0S3K
	MBropfiT+IkYx+FHLilZVeA9UmzXW5ekqLVOwcAQiH4mcACkpUqkAvqM0FIeeClZMvvvFNQR9WK
	SyhFfVOXoq4In6Jdk6ZFn0Evfi50YttHXetCEfxBCJmn2XeUAn3sWpHqBkJvXQmQBX79Z67DXNJ
	STwQRRyDoDjO6xFQkIuqrRBFGJaeVwPxxRPTx1dRVqNpm6KDxDoope+oFqq6KYnNtdwh9thHiZq
	UqsTTP1W3P4iQVeYHj49kKzrIhs1VH1FhaaYRrPuc1GAoGeNPrTWiYMHVxhEdelkeWjYAGVijDK
	gI/CzavCIfyuSw+yYyDgBU9olTJ87r9yCUPx7Y+zRoTSnQ+iwvfOi01lWTL/JM2WTY60D
X-Google-Smtp-Source: AGHT+IEy2O6XdnwXSCszBRo2t1GYp0WW4OT4K7CPwcUeeTfNv4Ah6l3+35wcvZbF9e+a2CsawUWSwQ==
X-Received: by 2002:adf:a448:0:b0:3e7:4701:d1ca with SMTP id ffacd0b85a97d-3e74701d6e2mr2784333f8f.17.1757346179104;
        Mon, 08 Sep 2025 08:42:59 -0700 (PDT)
Received: from node1.manccluster.local (revolution.cs.man.ac.uk. [130.88.198.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d6cf485eb7sm32151677f8f.3.2025.09.08.08.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 08:42:58 -0700 (PDT)
From: Joshua Lant <joshualant@googlemail.com>
X-Google-Original-From: Joshua Lant <joshualant@gmail.com>
To: linux-cxl@vger.kernel.org
Cc: Jonathan.Cameron@huawei.com,
	Joshua Lant <joshualant@gmail.com>
Subject: [QEMU- PATCH v2 1/1] cxl_type3: fix segfault in cxl_destroy_dc_regions
Date: Mon,  8 Sep 2025 16:30:20 +0100
Message-ID: <20250908154251.904229-2-joshualant@gmail.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20250908154251.904229-1-joshualant@gmail.com>
References: <20250908154251.904229-1-joshualant@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CXL_TYPE3_CLASS() should be CXL_TYPE3_GET_CLASS() given object (CXLType3Dev)
input. Leads to segfault in object_class_dynamic_cast.

Fixes: ef73003556 (cxl_type3: add MHD callbacks)
Signed-off-by: Joshua Lant <joshualant@gmail.com>
---
 hw/mem/cxl_type3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index c4658e0955..14cb09d9fe 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -919,7 +919,7 @@ static void cxl_destroy_dc_regions(CXLType3Dev *ct3d)
 {
     CXLDCExtent *ent, *ent_next;
     CXLDCExtentGroup *group, *group_next;
-    CXLType3Class *cvc = CXL_TYPE3_CLASS(ct3d);
+    CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(ct3d);
     int i;
     CXLDCRegion *region;
 
-- 
2.43.7

