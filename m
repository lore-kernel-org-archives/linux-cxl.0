Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49334846D
	for <linux-cxl@vger.kernel.org>; Wed, 17 Apr 2024 03:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713325879; cv=none; b=lYGuKJfHy6th0xBA5glnQzk+7PEig6WW6FSzQJLm9SizW0mVcy0/C5XmXG7MgoKz5dpRmgUpijdtlzTmX53mAYJkJCYoPkavio5WlYUdCyCNs/Qo/juc70ZZuPI/bjCiDeVsDuKQ8FFirJOa6txozXp4+c44nY9HpFM5NkzJ+8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713325879; c=relaxed/simple;
	bh=NJp4+T6opihtF6JykcOdg05R2dkZFJuxMq8sGOcUdNk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qJyF77Y/58mo5/fxpKxBF3NCAsr5ZvAH5KloaDck1fECWWbMW7AFijI9sHM08XYTEc+c8Uib4zz0yPI7UXJZBmh7u7MnMNuORWjgwD5cntrfSejsklNlXSOklPwlvcznLcqgSfj5qnuhPs5XDlUbVKLAFwnVNB/f+r1bY66DX6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr; spf=pass smtp.mailfrom=snu.ac.kr; dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b=n9gdUdX9; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b="n9gdUdX9"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2a528e7f2b6so3779223a91.0
        for <linux-cxl@vger.kernel.org>; Tue, 16 Apr 2024 20:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snu.ac.kr; s=google; t=1713325874; x=1713930674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OhV56taU7++Z+JWH7zmlfWQwCU9i9NFlAwJ7NR5vyUw=;
        b=n9gdUdX9czojv2r4JpQsJ3RHrM9ixRqQbYx6gQRBp8ny4AMUNSgNX5YddadWhj+CTU
         0cuTk9NPK/oHFSEYe/2XoL0H4ybPr9eos1O4uu9wO2f/guoubXEWsPwa3Jn1SqiJ/bdz
         KTc5uaLzBMyYAKhM6riCWvRSx5YRD9YBOrOXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713325874; x=1713930674;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OhV56taU7++Z+JWH7zmlfWQwCU9i9NFlAwJ7NR5vyUw=;
        b=NAjHXBfAaVhpVYbOX8idR9E0dslfNQVmYL1dYo6f07ohzZXVyynTrdB4/D380B8LJG
         CiOCQGD10dgErSHP3XUJ0Oae3pfPEB9geJg/fhR0WbFcUZFbQemJNpFhaYeoHFPKQXUT
         xgoMzYEBxj4vSikgcuvAiiUZUmeXCJbXSt5iPo555xbaAOe4pMSnLvfTy0JFr2QRblkt
         vF3PdyVhKsJtRI9rvkF56PbU6ZiWpg64gtt6tcGzo3PWJc2vuYQyh5kirm7y+8CQr13b
         eyhfuySwVG67ONUx1zul9TG6vfCj1BZQrYz0DqF9u7r3vlgSGcTN608xzPQ5zihUmEwF
         +22A==
X-Gm-Message-State: AOJu0Yxhu+TQxyHNv/tQQHrqT2ELpQLPWlLGr1rg/PGoJLX9MW5+BWnS
	TFD9NnP53xEvCCeG82kZX/+4x+7m6T/SaKPLuWYZ7MSEpPrduw5BsONbSYGgn7J6MeqvwOGj4Mt
	UHS0=
X-Google-Smtp-Source: AGHT+IGdXQiDs8kc2ufJZgofUQG4ck768IiqbKk6/mtDoXyg89PLHENbm9p6R7vjVgiy70ZIuztvvQ==
X-Received: by 2002:a17:90a:fe98:b0:2a7:d619:8e14 with SMTP id co24-20020a17090afe9800b002a7d6198e14mr8445536pjb.5.1713325873738;
        Tue, 16 Apr 2024 20:51:13 -0700 (PDT)
Received: from localhost.localdomain ([147.46.121.48])
        by smtp.gmail.com with ESMTPSA id t1-20020a17090aae0100b002a2d8d34009sm379234pjq.27.2024.04.16.20.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 20:51:13 -0700 (PDT)
From: Sangyun Kim <sangyun.kim@snu.ac.kr>
To: linux-cxl@vger.kernel.org
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Sangyun Kim <sangyun.kim@snu.ac.kr>
Subject: [PATCH] cxl/cxl-event: include missing <linux/types.h> and <linux/uuid.h>
Date: Wed, 17 Apr 2024 12:50:43 +0900
Message-Id: <20240417035043.2791431-1-sangyun.kim@snu.ac.kr>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The linux/cxl-event.h header file uses the u8, u16, and uuid_t types,
but it doesn't include the necessary header files,
<linux/types.h> and <linux/uuid.h>.

Currently, cxl-event.h is only used by drivers/cxl/cxlmem.h,
and it doesn't cause any errors because cxlmem.h indirectly
includes the required types.

However, cxl-event.h may be used by other CXL-related code in the future,
so it's important to fix this issue by including the missing header files
directly in cxl-event.h.

Signed-off-by: Sangyun Kim <sangyun.kim@snu.ac.kr>
---
 include/linux/cxl-event.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
index 03fa6d50d46f..812ed16ffc2f 100644
--- a/include/linux/cxl-event.h
+++ b/include/linux/cxl-event.h
@@ -3,6 +3,9 @@
 #ifndef _LINUX_CXL_EVENT_H
 #define _LINUX_CXL_EVENT_H
 
+#include <linux/types.h>
+#include <linux/uuid.h>
+
 /*
  * Common Event Record Format
  * CXL rev 3.0 section 8.2.9.2.1; Table 8-42
-- 
2.25.1

