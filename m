Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11DA202F71
	for <linux-cxl@vger.kernel.org>; Mon, 27 Apr 2026 03:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777260383; cv=none; b=pHXU0QTLd85kOfds4UkFg+FiH4VbdwZAMZcgt0RvQPDPY4nBcIKKAqdD0wgamQ6HpNY0flMQfffwMqiPNpfgGgLQlxDiVFpvPUcU9ldaUu/DDnqxbULYo6/wCtCC++fOxZXcJsqrrnoEd3GRXsl8iXijHhrDWJ34yktQZYrC0uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777260383; c=relaxed/simple;
	bh=nqvj57KyioIL2PzkBGckZgOX3gNQ7keOp2XX5NnhH1A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BeZdppX0Z8j1k2KrlzcyOtHGyavSFK0ZdSKJxdMokxv08RUP+FxmHpr1Oo2j5c8kBlvvP1R7+6We364icNO59cAk1zipqQhB2A9xlxysom7wgtgakTkmdxbu13QKE6NLWmPW78uiYZCNM9MD9mfOVqFPOHRRnafCOE3r9od4bpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7927261a3acso84112307b3.0
        for <linux-cxl@vger.kernel.org>; Sun, 26 Apr 2026 20:26:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777260381; x=1777865181;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nkfGwwfLBvGDGBedAG45wh5V1KcMlUL2EI/8teegCSQ=;
        b=OtdSZ0PKKWtaEP7bD1G7XA7zZaMrBQreJPp2gdvcSU+onMbqYNUrzqp8X2/2Td63dY
         wePrW66TtWAPV85OzjgT8DrVPpBICrCbwnEGbj/3hQXKW3JWIh6UrZYmUR7vjhuHOBkK
         3Ur3cq/wOzZY8WmxbqzDGcaBOF4s/RTgRURfQzB/G0NKdt4pF7u2iGWD3HjwCecBtjyo
         a/sIvoV+PSoOglDMdJc3i1+tdXty9Y5nyExdCYknhoOGaBDNmmA/73SgAWN8hl+FHR52
         txT5bsb/ApNVr6jhzwcqk7JscNSI+4zVLU2PlbeKSmUjeTbe+pomz6PSEZrTZbYDDwaJ
         1ULA==
X-Forwarded-Encrypted: i=1; AFNElJ+vmHf/O+XpZV1TS2JR3iCD8K/dWivEgeBtYtOrFntkMRbN8nuPby1V0QtZ54XMt29Q437zYbvebYY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBhUQZl7HICzYZ6Pt5iQSCzIf7RiqAoyiqe4ctQRF1+NOpedu0
	YxEErG0T7KGHSwVp3Fh6+pj3tjQHjgxZvw3mucl0BmYibbCT+XsxPgdy
X-Gm-Gg: AeBDieu26+VUcwLsi5B0nrfALejrOsG9WhKHCktBsRYMh5/1bvPMDjxM4wys28XAbdK
	IPbmF02fQI3Et3BOAXythqxCXDaYFwvmupRUpQOo5wVcBIrMON6yvOXXJ8AptvHsMpwaU5+L1N9
	ssPlnmcjaGry8d77ezICxXVa+oJ66RqOGG5SjUa/OVlHiW+a7PNfO6FaBxNpZZ5G34i0T/48BfK
	yPUUwPUiUj0TdxSa9cHWp+vBbIv7nWoP/YUoMMGz6H9A8VxRIDXtESgtVFqhzDU10ENN4M+XCPZ
	7DAZWybBYnLzz3kB0XMLRiXOuza2oQuR35zf6L8fb22J9k94BIBs+xfQypE0fUxHScUUqNnjLDw
	MLIdcmwD8x1YAM+MqPLg5xgkdtGD9jmALnrex3uQmaeEkeCdzwBfirwa5VKpm4V1dRX/TdMLWhB
	UstJ/ZoKk9XlLXpNvfeDcMeKhK2ZMVi2s=
X-Received: by 2002:a05:690e:24db:b0:650:2257:e085 with SMTP id 956f58d0204a3-65310a2c277mr27421691d50.30.1777260380940;
        Sun, 26 Apr 2026 20:26:20 -0700 (PDT)
Received: from tofu.. ([128.210.0.165])
        by smtp.googlemail.com with ESMTPSA id 956f58d0204a3-65314b26b56sm14087239d50.4.2026.04.26.20.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 20:26:19 -0700 (PDT)
From: Sungwoo Kim <iam@sung-woo.kim>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <djbw@kernel.org>,
	Robert Richter <rrichter@amd.com>,
	Li Ming <ming.li@zohomail.com>,
	Gregory Price <gourry@gourry.net>,
	Ben Widawsky <bwidawsk@kernel.org>
Cc: Dave Tian <daveti@purdue.edu>,
	Sungwoo Kim <iam@sung-woo.kim>,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] cxl/region: Fix race conditions in cxl region unregistration.
Date: Sun, 26 Apr 2026 23:20:07 -0400
Message-ID: <20260427032010.916681-2-iam@sung-woo.kim>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This version mainly addresses Dave's comments and meaningful issues reported by Sashiko AI[1].

Overview
========
This patch series fixes race conditions in cxl region unregistration.

devm_release_action() should be called once, otherwise, it warns about
the second call. However, the current implementation has a race condition
that allows multiple calls to devm_release_action(). The details are in
each patch.

To fix these, the first patch adds a new function that guarantees that
devm_release_action() is called only once.
Using this function, the second patch subsitutes the current use of 
devm_release_action() in cxl region with the new function.

Change in v3
============
Addressed Dave's comments:
- Split and made this in a patch series.
- Enhanced a commit log explaining why a workqueue is used in the first patch.
- Added a context on how these issues were found and what impact was observed and how that effects a user in the second patch.
Sashiko AI review fixes:
- Fixed construct_region() as it also can race.
- Used a driver's wq instead of system wq so unbinding can drain a work.

[1] https://sashiko.dev/#/patchset/20260422045637.3048249-2-iam%40sung-woo.kim

Earlier approach:
v2: https://lore.kernel.org/linux-cxl/20260422045637.3048249-2-iam@sung-woo.kim/
v1: https://lore.kernel.org/linux-cxl/20260308185958.2453707-2-iam@sung-woo.kim/

Sungwoo Kim (2):
  cxl/region: serialize devm action removal via scheduled work
  cxl/region: Fix a race bug in delete_region_store()

 drivers/cxl/core/port.c   |  6 +++++
 drivers/cxl/core/region.c | 47 ++++++++++++++++++++++++++++++++++-----
 drivers/cxl/cxl.h         |  9 ++++++++
 3 files changed, 57 insertions(+), 5 deletions(-)

-- 
2.47.3

