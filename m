Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987008632C;
	Sat, 19 Apr 2025 20:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745094957; cv=none; b=dG50sjRuvKwZ7OZaEo5510bG+hTBr5IFZ1DMpwVEWhsgRyLVKBRSJs+yccHE2Nq0pHzVyB+YyClbvAz8JPX9YfYLDPSO66Yg2V13utRDnUgduymOrqNDDbOKAlHm3lWeGwicANCS95BPv/ZOfiB7OjcBXAA/PyE/SvrDzUx43so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745094957; c=relaxed/simple;
	bh=/wHM3bw4hF5gO/lR83sYkQ/inlou31KdGPkItwpSMXY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iMw2P4l/eVK4+K/8/jRWJDdf40so2YqaSMlabq9oPKx4nJEFzKtZixNTVjVM3FsMFqYCYysxufgheZYMtbmdfPH++6G8BkxbPghkQQxGsLRMk+D6OnJZd54e0qeocWrQNhPDHGC+I3lXiyhkheXgBI6sFjqhoHkHnEMSrkcyb4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PeesrPK0; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PeesrPK0"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-73c17c770a7so3743675b3a.2;
        Sat, 19 Apr 2025 13:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745094955; x=1745699755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nOVbeXXV8dfjkRh8tdwBfNUeOzwIqqLB9VNDFDIkZO0=;
        b=PeesrPK0JlMfCJmiymrJIN57gBdPrZJ30eFFom0bmjAIgH8F4BueivXWF7ABC9wqsI
         E4H5sHcqHV50gZZCx3J/JYRKYP8AeELbYVj2Fxj8YWw0Yj1ALCOxOhCV5EF8E9WJBX3U
         PABAtjHjk2lpuHG2zYq/VxeXZoxW7A+ZL0TL9XxKWdoR9AywkLYpAcKSu5zA4sg+GKj/
         m6QfNAdECZKTuk6fUSZ2vEy/MFHVaB9Upf3vI+P+9xjJqs6zvGGa44EueGv5HWIe4CHh
         caYetvzgzqRFfldjBZ7dbgbwKAYZedmu8TVzqUyFKMQ1/0hBXwXm+/gFQ6T0CeRqBQjk
         jZtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745094955; x=1745699755;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nOVbeXXV8dfjkRh8tdwBfNUeOzwIqqLB9VNDFDIkZO0=;
        b=idgXOngUH7G4NJ7Xcr2aMMm3iXqdEkbIdWDHu4+ci7yv1ojyyZAu3mYlICtCFq866P
         cp6DprjBOrT4AvCJcjQYa+HIjNMVUIJDWpu/FDK8+8BRg5OLszGmDwynlwsHDmsZhRzF
         NFQvL4eIqX4878dx+nQxkxBCJ7ZNiRpv4U08q255F9WtbvFq2aZcA7k2vlbUJwjJJbWh
         c54wktnSoCHlMc7hRBgMKcttBLk0YZV3dTAH7rvR2lqvxSQ1jTfqvXS/1s6T+GKHb9qv
         U6R44NNjiKsv1psII6mcEmDFKK0GhdX+qhLQWmmJfZhOZJm1tWiqZbwjlHBumau80SkA
         Gl5A==
X-Forwarded-Encrypted: i=1; AJvYcCVOY6xkq6kzsViF5xbmNY0U3t/dQmLlcraFNe4xfe/LPVKKSVc0TLr9DDBddz488u4WOktikom86xLb34D8@vger.kernel.org, AJvYcCXXvtr4ejQmeMstEvJKDmcnuG031UG58ge65Qt1I0PNtBtrfsWIWE7lQZdxsogsqsiCo0H9K5XlXCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwwFvjnjIxT7+xUrnyuTfVvfrSa87tw/kVhXpjNDJHOwlrLRgE
	8rITEpJ5DEfOQMGM0vCkCxnF0sooBOhMmtCNWm7lIIYcYCQtULfi
X-Gm-Gg: ASbGnctCPvPG9oDlkTLHOIz26uLTukVM+SfieCvAHZG7Ro7+dvFCC5Rc7Vuqo3WMzDg
	AK1IMqytSQR/rK8zuk3HL0jyo/AbJYJcR3Oc47gjpxQnA5R+lE42W1IAUZjLaSBvOpFOwImXBwd
	9ErA7I3PvyqJO6vCe9b/E9m0FJyb2YTydbN/iuIml4S2Edx2/SAjOQRH34dmqLmFfdzhgSaULSA
	HVjXZ24bZDWznjqiOqCFKpDvMqDOYqs5ZS7l19MsQJWsHl9cCkBwNiZOM+oedm3E0tC/7fLkVXt
	kx5dTmC9auqXXvtfcbdpXF/SLF9ON3PmmAeCvJlIzS1LvlGRGR1cjpK8pTvD3f2qOSuY5OF1f2S
	OlB08spMhfA==
X-Google-Smtp-Source: AGHT+IFhuK9eaDk8FrZ49BKcYWjIVbI0I5NibD14eGzbCaNLWsYvWurfxwc36MuDg0PsQcSVQmuskg==
X-Received: by 2002:a05:6a21:3399:b0:1f3:4661:d19e with SMTP id adf61e73a8af0-203cbc29b56mr9860152637.9.1745094954723;
        Sat, 19 Apr 2025 13:35:54 -0700 (PDT)
Received: from purva-IdeaPad-Gaming-3-15IHU6.. ([2409:4080:1187:dd2:ee65:709f:56e9:9560])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b0db14488adsm3185603a12.61.2025.04.19.13.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Apr 2025 13:35:54 -0700 (PDT)
From: Purva Yeshi <purvayeshi550@gmail.com>
To: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Cc: ming.li@zohomail.com,
	huang.ying.caritas@gmail.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Purva Yeshi <purvayeshi550@gmail.com>
Subject: [PATCH] cxl: core: Initialize eiw and eig to fix potential uninitialized use
Date: Sun, 20 Apr 2025 02:05:30 +0530
Message-Id: <20250419203530.45594-1-purvayeshi550@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix Smatch-detected issue:

drivers/cxl/core/region.c:1292 check_interleave_cap()
error: uninitialized symbol 'eiw'.
drivers/cxl/core/region.c:1297 check_interleave_cap()
error: uninitialized symbol 'eig'.
drivers/cxl/core/region.c:1299 check_interleave_cap()
error: uninitialized symbol 'eig'.

Smatch reports possible uninitialized usage of these variables if
the helper functions ways_to_eiw() or granularity_to_eig() fail to
assign values under certain conditions.

Initialize the eiw and eig variables to zero when they are declared
in check_interleave_cap() to prevent potential use of uninitialized
values.

Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>
---
 drivers/cxl/core/region.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index c3f4dc244df7..edf8636f190a 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1266,8 +1266,8 @@ static int check_interleave_cap(struct cxl_decoder *cxld, int iw, int ig)
 	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
 	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
 	unsigned int interleave_mask;
-	u8 eiw;
-	u16 eig;
+	u8 eiw = 0;
+	u16 eig = 0;
 	int high_pos, low_pos;
 
 	if (!test_bit(iw, &cxlhdm->iw_cap_mask))
-- 
2.34.1

