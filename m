Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9587A225798;
	Thu,  6 Feb 2025 09:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738832705; cv=none; b=MHGYVapqLSJITW4nlMRsuj2xEZXL3ybwB2QyS32oqYAulGaTTYzxgnY+fzoJsrfJTxs/gwNbWOi/eXoRFSeH5cjFfgp3V2KWNz7MVj3ap5YZgIQ94XDf5NY6cTkO7gl3lGfeO5d5Xx++yOdhQWoPWoUy6pamr5oloYUKUAE5oaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738832705; c=relaxed/simple;
	bh=4sJT36nrAxJI+xt6mkh3Z2maLd5jZcYYmJdOXV7uQzk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KoqdK3GsL70OAvOUjWmc9oSV2qODVpYSpcnKpKIF9nRhGGgkzRceUk9Yo9Evbf3q6NvXKr8nyQANmybB5w9XM8uL2yIY5JDemgGaDXutwNkexPyP/uWDEtAUKHocF6cS3INkk0x6ZWqX3yXK5qcf7Ur3mFZSykP64mqzrbqcvxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cN7tmzui; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cN7tmzui"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5dcedee4f7bso990048a12.0;
        Thu, 06 Feb 2025 01:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738832702; x=1739437502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y5boeGXpsRAwjhq3mFO2V0FLbLR2Czj9he1HiE52HhA=;
        b=cN7tmzuiKQyymbKqdk1MI/df+ZJqZh3NCebWHa7sa+P5BLOiNQXhEUW1CtJgVPoT83
         CNwKfsQ9IXvkowxVV2+d3HjmrCQjfwyCSjSIXmusLYQemZiIlQczhLsNFWTRVgVu1DS7
         OAvP+KREl2Qw2Mu9lfsH3NTV9Ur6bMuOpWBI++YeDg+ldllp8SRZmerMZpzIi/iuXtgd
         KCeMXJgX+dtkeGjwCgn4ly9lnIjSo9GX5x+Scg/PsiEbcZYLbTnStX4f5qgRe+drnfhT
         UQCoxtS5na3/QHxg39n3vNT4AZV+HrV2+kPRbkYm4ft55xmXOzN5nd5R5UsLXtHqcw0s
         ypqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738832702; x=1739437502;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y5boeGXpsRAwjhq3mFO2V0FLbLR2Czj9he1HiE52HhA=;
        b=bZmjSqOLAO0X+DicxZby+itVDAPlwA72zxaUQbemuVg80uzZgOxi3mTRgBdNjSF9J/
         sDdSrtiPEY+abDGAKcnuljtyN+px+QA9CCakDoMuLq0fAFWgBA9aPmDS7JTB9gHzFwlr
         LrCAvw8RxQu3XE/AzgtnSf7HsOmpaHXwQJgbozNwR8fndZ9zZdZDSo73JHprWZY1tbNw
         s6wuyygbLI0/HeVKwoK3E7BlF1euxhbFert2BQRHSCT/C8OXKOveBnPRrrpPoo1tW2OR
         +H5WnN8Edw1w0D3YmndUXMUwxNgAGkLdP73Wkgi6vbL8Mue8BxVPw+QN/+r32IwHc4bx
         Gd0g==
X-Forwarded-Encrypted: i=1; AJvYcCUVhmQ4JjL9s/RPUvPkSQblOtNeBRuLt+IsdyCP9mJvoX4xKrUS/j1kCfS/AmS7wxVjtyd/zXISn6qZ7VhA@vger.kernel.org, AJvYcCVBG7rstkdBmV6WuhIJMQLR9yuUq3kA0wY/SdVHbv/7/cw7S8zNDWJcXAVWEhN66APtmSox+fqKdjznzAdmwfs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOhnvJjQoiW43ijniB2idoXDYs48GCwhnOxNf5WLULwvbwt4wh
	4enn6so9lHtOmHJWMZPLazgSMGtHHCh2OXAG3gUzkzWzbxU1ZtxU
X-Gm-Gg: ASbGncvITEUSIvHQOlcczbToaMRapz5tpq0u8TY6bPzhSgUdz2VZ5hu8olygkUhbe0i
	eGt0Ukydm2k2Ntcqt8SvA/d8GBtIutCxj+2LHujJwAqPC5aLcsj1KcFZvFhMqsSC5EhffhuACgk
	6JTHmeIA2tC0v2lVqq/INRkLvL2hPWvFIel2yQb8dYh3h2xjVZQW4PR2qqqVoyA2+42Bq4H8SAw
	8VSpxDoZS8WYMJs+2L7mnh2GaFvuEVx5DCzYlLHo0+3xE7G3zsVmb9jMoL7/SHEMrPXMTcJlIyB
	Gp3MUayRiPQCm/Am
X-Google-Smtp-Source: AGHT+IEAw3jTkVm/dhWDLxPHeI4eNiGr+dQ2NxMhxzzKjJGlU1URjFicJ8Y29Efq9eO89ZPyOiaWgg==
X-Received: by 2002:a05:6402:50d0:b0:5dc:cc90:a390 with SMTP id 4fb4d7f45d1cf-5dcdb776e8fmr5897274a12.32.1738832701545;
        Thu, 06 Feb 2025 01:05:01 -0800 (PST)
Received: from void.cudy.net ([46.210.137.151])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dcf1b738dcsm548429a12.4.2025.02.06.01.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 01:05:01 -0800 (PST)
From: Andrew Kreimer <algonell@gmail.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Andrew Kreimer <algonell@gmail.com>
Subject: [PATCH] cxl: Fix typo in RC description
Date: Thu,  6 Feb 2025 11:04:08 +0200
Message-ID: <20250206090456.12298-1-algonell@gmail.com>
X-Mailer: git-send-email 2.48.1.220.gbc204b7427
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a typo in one of the RC descriptions:
 - occured -> occurred

Fix it via codespell.

Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 drivers/cxl/cxlmem.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index c0d2a8b6aaf6..f7a517709b7e 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -147,7 +147,7 @@ static inline struct cxl_ep *cxl_ep_load(struct cxl_port *port,
 	C(MBUNSUPPORTED, -ENXIO, "unsupported on the mailbox it was issued on"),\
 	C(PAYLOADLEN, -ENXIO, "invalid payload length"),			\
 	C(LOG, -ENXIO, "invalid or unsupported log page"),			\
-	C(INTERRUPTED, -ENXIO, "asynchronous event occured"),			\
+	C(INTERRUPTED, -ENXIO, "asynchronous event occurred"),			\
 	C(FEATUREVERSION, -ENXIO, "unsupported feature version"),		\
 	C(FEATURESELVALUE, -ENXIO, "unsupported feature selection value"),	\
 	C(FEATURETRANSFERIP, -ENXIO, "feature transfer in progress"),		\
-- 
2.48.1.220.gbc204b7427

