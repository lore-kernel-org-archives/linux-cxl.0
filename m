Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8099DD2E0
	for <linux-cxl@vger.kernel.org>; Fri, 22 Dec 2023 09:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ybl6Zi6c"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6d39132d6baso1017322b3a.0
        for <linux-cxl@vger.kernel.org>; Fri, 22 Dec 2023 01:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703235663; x=1703840463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hvABOATJauSvkSqTnUfEfpb2YY1wUplxC8fyiFfoJNA=;
        b=Ybl6Zi6cP8l0vBsPjx8LZjmCH8iZ4HcrBY3upOZBh+6xPXh3VIgQpzAlPhWs2VqhaT
         O4PleaX1IUn+Oc+rqgHD160JGEE1cnK5DlB7umBeEv2uQ+/7e522oGMhfX1rNOugEZxb
         UQ6J104vAfIWRFE/3l786kOx2/+rVl00bwe4KxkGC/w4GU0qOgZP8qdm3LcBpzsEHjMM
         ILe5HzVAHtVbvQSHcqrec8Z2HZqAm+RsLPkKeJyOLn2+sBM9oE9YJ9dv0yqBGK7H6t2K
         5yhFx9kbaY/X7zoOJSxlH/0fWOz9G6kUXAGJXjExhl0cLM1ax/sDLQFndzQASlBcf7rQ
         LK1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703235663; x=1703840463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hvABOATJauSvkSqTnUfEfpb2YY1wUplxC8fyiFfoJNA=;
        b=JeVvKHR4WpFK3ANsYjORaCWRjM1dCyKEwp4J7B3mrRBmYrNT2QESde1DdaZmXL0w6b
         XqB2CgyMT8P/ibfK12SuklYovs5y9T6PrXFwlNOjPBDOdE9ohk+GPhGnPsGchzG9UOUS
         8NSP3yqEiRvTHagxfTB4One3HaLclnOgeGzGqFeoIoDK4wI5NgkWZ8rnqXGC/oMZy6mz
         Q8O/r7iCCp0jXjY4Tu6aaKCgZ87ypwf/cF/QTk+UtieSWc8HBX7DMrieFkWl9B9BxPIx
         sQUvEQGqiOHa7Dx1H4ff4BwXNQeW/UnN2Od4LTXuInhOeMXNSnujevOYScR3M5gqgMzK
         KWlg==
X-Gm-Message-State: AOJu0YyZuwhX4icKBWakyakQjW11Etk7nvfb0QR2Fbsohlo/BOJDcpB3
	lq+i5CYSBwZ5UL+/ywSqTUw=
X-Google-Smtp-Source: AGHT+IGhWtEpqol/n70fWOtQPCv/l5/XQatLGGrbIXg+l4DVfnjYUXFwCLt1N6LEeqYA3c5Rp0nxYA==
X-Received: by 2002:a05:6a00:993:b0:6b2:baa0:6d4c with SMTP id u19-20020a056a00099300b006b2baa06d4cmr732656pfg.33.1703235662524;
        Fri, 22 Dec 2023 01:01:02 -0800 (PST)
Received: from localhost.localdomain ([1.245.180.67])
        by smtp.gmail.com with ESMTPSA id f23-20020a056a000b1700b006d990040342sm400560pfu.155.2023.12.22.01.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 01:01:01 -0800 (PST)
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Fan Ni <fan.ni@samsung.com>,
	"Michael S . Tsirkin" <mst@redhat.com>
Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	linux-cxl@vger.kernel.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 1/4] hw/cxl: fix build error in cxl_type3_stubs.c
Date: Fri, 22 Dec 2023 18:00:48 +0900
Message-Id: <20231222090051.3265307-2-42.hyeyoo@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231222090051.3265307-1-42.hyeyoo@gmail.com>
References: <20231222090051.3265307-1-42.hyeyoo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix build errors in cxl_type3_stubs.c due to a the incorrect definition
of the qmp_cxl_{add,release}_dynamic_capacity functions.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 hw/mem/cxl_type3_stubs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/mem/cxl_type3_stubs.c b/hw/mem/cxl_type3_stubs.c
index 1b54ec028c..d913b11b4d 100644
--- a/hw/mem/cxl_type3_stubs.c
+++ b/hw/mem/cxl_type3_stubs.c
@@ -68,14 +68,14 @@ void qmp_cxl_inject_correctable_error(const char *path, CxlCorErrorType type,
     error_setg(errp, "CXL Type 3 support is not compiled in");
 }
 
-void qmp_cxl_add_dynamic_capacity(const char *path,
+void qmp_cxl_add_dynamic_capacity(const char *path, uint8_t region_id,
                                   CXLDCExtentRecordList  *records,
                                   Error **errp)
 {
     error_setg(errp, "CXL Type 3 support is not compiled in");
 }
 
-void qmp_cxl_release_dynamic_capacity(const char *path,
+void qmp_cxl_release_dynamic_capacity(const char *path, uint8_t region_id,
                                       CXLDCExtentRecordList  *records,
                                       Error **errp)
 {
-- 
2.39.3

