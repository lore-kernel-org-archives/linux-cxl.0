Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE0E18FC91;
	Mon, 11 Aug 2025 16:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754930993; cv=none; b=dx4NZ29x7Q17IHmV5sLoIZRpp6Ssx6LJuWesqxPDHIzsvb5wz1NKpUSjsSVtTDgpMhGDdtCp+WrioMMsr5C8+Z10ZF5c+uwrIvHFkFCjukmOlD7+3MkHWI6UaTWVSSIWK5d4hsCYAc8wfUUPW85pSLJM7wn/9u3LbNE5TiUroHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754930993; c=relaxed/simple;
	bh=r3SklTF/J28zldzKGFpkhzr6DqkcSyicNNJtCcisZS4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=SsUFDg84mk66cgY5FBm+X+69D+c9ZSDcxEq/iDjSpLf56ngJ7Y024Qs4QaxMzaBMWJEEK8P9T4ReCB9wWUJnaW0h/JUoa34+hmnxPcXfFc4jyAIeybfm8izQ/kfOs8xmW0yva4mr3jY+xsgH1tTg4+GlVESTtjxi9lLT85uKgjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NZCOUCOY; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NZCOUCOY"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-76bddb92dc1so5776034b3a.0;
        Mon, 11 Aug 2025 09:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754930991; x=1755535791; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kN7nybJBSUg9GTrQwRnc+qxQzY/TYZwbF8aIFzNGiuc=;
        b=NZCOUCOYwrfxdykFxk6NAGAG5sy8Fy+lIg58yOB6CYvX+a4T8ENtAEok86HghW4C/p
         96W33d7PAzzSuvCWlLqeCQiBTAxEm3BoiuBwpX/KHFYt2L1H7His++3PKFsl8GXwCCmk
         vamg1QqcYcSmN3jaxPtbioPho05H9d2JI1PoJr9Em/ksMzHuHcIP+kwhITw17ILxKHh1
         2G5aSL9F4CEOEsCryjftVrk1zGsBsPLW487YAozs2TOSLi7UQ0LECI+yQKhsH9aqgSYv
         YNjTYLpEtscHghSIh6XnBaLFmStNOF5uaCyQElF8g92fgw55aaBvx706GH5I3XHaRmeu
         FIWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754930991; x=1755535791;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kN7nybJBSUg9GTrQwRnc+qxQzY/TYZwbF8aIFzNGiuc=;
        b=kD7L+RKTOSfQA5MvYKjMkFN4jI6P5iFlS7oXx0X0JBSYePFepNxmPOhNoDNOhbUS5x
         e00eke6DiejMMyirwW+l0YmXu5S5H51KdXF76/kOE61x3tiSX9l1lBhnC7smvoJ95hJE
         cNZSj+iw8h69RreMhq32BgVvDMChxOV3Bh4PGbBpqFDfRYdL+ZgK+oBO1qK0sRgAOIa+
         WO8Hl/L5R2W47YTJWJnxmpxEnItbkdQujJDIE7/v5fXzJ9vRYKR5dCG9zzZSGfj0+xZd
         VlsC9nT1hQ0aRVTcFucA9XIj7as2JapJoKaWyHqGsOEEpnBCAX7lGSXQP56oaInicfnJ
         308A==
X-Forwarded-Encrypted: i=1; AJvYcCWVkmmHimLPlmI0/eiota6H6QBLT5kmjwpfn+gQfAf9F2/D8tfbPZuk9PKwJLXTagAkR9tYHMk/pijeakI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWNj4lg4vWFvvem6U5e/lAkpsEMaIDgD3eYtQnUx7es6ntpNfH
	4RxfUDR503BeO+nurPD+aIbQYc2mCOLdJBPFkkvgbLasfmH/vReQfph2
X-Gm-Gg: ASbGncs2LxThsD2ln4rhzEcce9HoFdRxdBo59NH6b3PT/1l3L8+asaL0Gz6IgGavE2w
	iepmnUIez2dob04/guBkZif1IdU+4IeWepCYjKNj/iLFPvWXSsLLCc/OxhgBimll5f5dHz14xcx
	02uniQmLovRaews2KXfrXg6ZMDm4OC7YSfyQhHHTgHlgiruax/raDlVAyFmmCN2AZXaGDCxlprz
	hb2KCFOyGWiPunNT+oin9mlcbzoyzx+piyZaiDwNgvEB3ADDt58av7n+rF5GQrazY+jJcTAF/EG
	BJMxgQ/yWlPFpg7lPfC/axdXSxH5cxUKwPx4E/OGm9xPUPd1KVGh9/HhsHVThqbBAHCaeR1YTvK
	0DAYcB3CyMyIteaK0lHin
X-Google-Smtp-Source: AGHT+IHX0e/PO4Z3IwmNT2g44cWPgFEvNfHjvzx7OGW61t+9EdTI2FUpffbo9A0LBSYC4/7QS364CA==
X-Received: by 2002:a05:6a00:2d9d:b0:749:b41:2976 with SMTP id d2e1a72fcca58-76e0de36131mr468710b3a.3.1754930990889;
        Mon, 11 Aug 2025 09:49:50 -0700 (PDT)
Received: from localhost ([159.117.70.219])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-76c09adf8efsm18808340b3a.68.2025.08.11.09.49.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 09:49:50 -0700 (PDT)
From: Nai-Chen Cheng <bleach1827@gmail.com>
Date: Tue, 12 Aug 2025 00:49:46 +0800
Subject: [PATCH] cxl/region: use str_enabled_disabled() instead of tenary
 operator
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-cxl-region-string-choices-v1-1-50200b0bc782@gmail.com>
X-B4-Tracking: v=1; b=H4sIACofmmgC/x2MQQqAMAzAviI9W9DpRP2KeBizbgWZ0ooI4t8dH
 gNJHlASJoWxeEDoYuU9ZajLAnx0KRDykhlMZWzV1wb9vaFQyBrqKZwC+rizJ8XVOjf0jWnajiD
 3h9DK9/+e5vf9AFmqYxRrAAAA
To: Davidlohr Bueso <dave@stgolabs.net>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kernel-mentees@lists.linux.dev, Nai-Chen Cheng <bleach1827@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754930986; l=1250;
 i=bleach1827@gmail.com; s=20250730; h=from:subject:message-id;
 bh=r3SklTF/J28zldzKGFpkhzr6DqkcSyicNNJtCcisZS4=;
 b=RmrHqhWXztlnPYHIiYy0fLMXBeWj3a9h4BobSSZiAzZsOkanJ5yunaC+jR0Rs1ULm2fOlqXDs
 lfJwZzUvlM3DobMEhFxNVjW9SL4KwYG+ODfoN2qNQHOsf8LrYsoglF4
X-Developer-Key: i=bleach1827@gmail.com; a=ed25519;
 pk=jahFPRplw20Aaim8fIt8SxlFMqkHbJ+s8zYBGbtHH5g=

Replace tenary operator with str_enabled_disabled() helper to enhance
code readability and consistency.

Signed-off-by: Nai-Chen Cheng <bleach1827@gmail.com>
---
 drivers/cxl/core/region.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 71cc42d05248..83d58787b5af 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -10,6 +10,7 @@
 #include <linux/sort.h>
 #include <linux/idr.h>
 #include <linux/memory-tiers.h>
+#include <linux/string_choices.h>
 #include <cxlmem.h>
 #include <cxl.h>
 #include "core.h"
@@ -1468,9 +1469,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 				dev_name(port->uport_dev), dev_name(&port->dev),
 				__func__, cxld->interleave_ways,
 				cxld->interleave_granularity,
-				(cxld->flags & CXL_DECODER_F_ENABLE) ?
-					"enabled" :
-					"disabled",
+				str_enabled_disabled(cxld->flags & CXL_DECODER_F_ENABLE),
 				cxld->hpa_range.start, cxld->hpa_range.end);
 			return -ENXIO;
 		}

---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250812-cxl-region-string-choices-f5aa9832346e

Best regards,
-- 
Nai-Chen Cheng <bleach1827@gmail.com>

