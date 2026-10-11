Received: from mail-dy2-f6.google.com (mail-dy2-f6.google.com [74.125.229.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E3144A708
	for <linux-cxl@vger.kernel.org>; Sun, 11 Oct 2026 13:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791724825; cv=none; b=ew1QEXMDrkVRgzqI55P6N89UkGr5zHIxSTFaTAFqdNz7yrT56/bQlGAnvMOzvto+zeGtq+UEslSPp5b3Ue7JbRgicx7e640O6Q0yg7ecR8cBO73r2U0WpvG9kwaw6j3HCEdS7Fv9XE41bnRw4+Eyj2PmI5Pql8FmjzfuVotsv9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791724825; c=relaxed/simple;
	bh=uXYPY6h1yD2YP8cgMDGftsU7ylCzXryuv3bVUW6VD3E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mZ1w/CLjMovVNv0HOFh8trr7GFiUDvs9kHDe5UoGmO0ktG89Z0pEeCJvVjXJlrzlM08Ji3qqt1CdMACsySXT9mXEF9B19Zf7rakyw0vZ+NI1bBKtxYt5vUTlCa1X9h20mQy17z9+NRH9RGjd8kezhIxsnieXfgMw676c2EmrZVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TfcuReCm; arc=none smtp.client-ip=74.125.229.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TfcuReCm"
Received: by mail-dy2-f6.google.com with SMTP id 5a478bee46e88-3599f43e0aeso225958eec.0
        for <linux-cxl@vger.kernel.org>; Sun, 11 Oct 2026 06:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791724823; x=1792329623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RC5wNxG5OvZ7QX4c7CG14p2PybaZXqw3gD9axjHB3VU=;
        b=TfcuReCmX56ub8M8kJYfuGYnjrNQckolaFjlkti41HYMWrpfm2isNlRR3WOtR2Fslz
         qKyAVNll1KDkriVLAqh2aTC4qK+Zo87xZJU1GrIhWqtqf6FBwdF+j5P0tgwJAln1mX81
         OfukIhp6lkPwzD6f6Nl/Omnit+BwxXiC5KKnM0jztkagS63kT1vnb+ABoJJwkQINHhtW
         iuKZBBPCdVoaOmw534VGPfFi3UBW2H6xjbielNfESIuc8gIazXFLXnD6WaTyTExpeklh
         M9XOJGnzSFxffNURDE6+EQ0qzSifPeztQg5sg45es6ExaKszO/8Q0ialzC2UOXNynldM
         +GJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791724823; x=1792329623;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RC5wNxG5OvZ7QX4c7CG14p2PybaZXqw3gD9axjHB3VU=;
        b=q7sW8Whb2jB1/eqglUCsjo3IfU2GXVlIH17FNb7cafG1kRqfBhoO5H8DOLmogtIOjs
         Llr7Pjq7UsnmsQQ8tIhOV8XhoYn+9HBv+WFlo5xZCHsGPRAio8qYZXqjHrykVcr1QLeY
         ss9oceM6aMTIFqqbIx5MZaOrHHoiUHUyog+uQBGhwOhKjzykO3axjbq4f3zj1UZy35cv
         SElbs0kMOGzdQWcExRGaJa4teC4z6naaZZEqC22mEGOSkdwdw63vx0w0WGOVAbI2r4XY
         E5nJBMoQVj73ePJVvoznEZmcCzrX+n3k68kqdbEDHQ56aal47oDhF/EmbrbhkNo6O+WV
         0jng==
X-Forwarded-Encrypted: i=1; AKwUvByXP5fEAIDwVxiM8XscV7Je+MJ2q24/5FEq4O3plfSps9fz0feLPdkxg3W3BdLOXvI2LK7ugJg8JkA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJv+pOLtmWU8p0tcw5QE3fmNVD4MT4akUMm9Y691UaFmYsqUIfG
	bu8rzU7+zrGo9o9ivKOrpHO6UrGZ7kR5eQlBPCT555DHLSlzNqMCXl76
X-Gm-Gg: AYBFou1iiYYOOBM0UIlCRhgXzzt/5OQxqc6LtWd1Af6nbq7Abd4BpHRgzaPKUMEAEum
	FgguED715qCWeA/ixZaz9PEbM/4xkgEQeN4kP4ZxeTDA0xz1ew3x7WcRArMQr4yx8ubFdxVRdBC
	cABerK5dLG/DZeSDkyWubWVz68JV8AkLQq3V72zTI7edmLDZ2d0GMfhhwTs6z5ZLxMsx5SjF0Yc
	VX7BdjinoPCgVn3lJI+5fr1PSzutMY08ahUNAiyX/lDX1uViWSuifs/5dBA9x6S+J46n4LWHdH0
	ufOMme4UMtZKgqx+/mQKOIfFYD74joMi+JpJ/dGCVGpK5H8PmSd+1WAH90Ld6A+EhVkcTHdIw+3
	rB4apEmoW4I22xe9r6sc216bI71wMD4cVsiO03jFef8mq/GTFK3qEfhElkEp2PpRjdedP7xSmof
	0ATUAWZX/91d4rXdicJYsjNP0UXJ80WdbK8ohpVx+1S0KXg8mm09cLox7+b0wPoCL6/RBxQyY56
	tGJgy7HS5IaqvvThLbHf4z0752jXvpCXcu5u3M7hPvDgfgG25/EEJOBXd+A5xZURlBEGA==
X-Received: by 2002:a05:7022:1605:b0:151:94a6:6f5f with SMTP id a92af1059eb24-16a5fc917b4mr10950183c88.10.1791724823038;
        Sun, 11 Oct 2026 06:20:23 -0700 (PDT)
Received: from localhost (ec2-18-143-158-86.ap-southeast-1.compute.amazonaws.com. [18.143.158.86])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a1becb11sm20136059c88.4.2026.10.11.06.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 06:20:22 -0700 (PDT)
From: jianyungao89@gmail.com
To: linux-kernel@vger.kernel.org
Cc: Jianyun Gao <jianyungao89@gmail.com>,
	Dan Williams <djbw@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	nvdimm@lists.linux.dev (open list:DEVICE DIRECT ACCESS (DAX)),
	linux-cxl@vger.kernel.org (open list:DEVICE DIRECT ACCESS (DAX))
Subject: [PATCH] dax: fix dax_core_init error return code
Date: Sun, 11 Oct 2026 21:20:17 +0800
Message-Id: <20261011132017.31131-1-jianyungao89@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jianyun Gao <jianyungao89@gmail.com>

dax_core_init() mistakenly returns 0 on error paths. Change the
error return to use rc so the actual error code is propagated
to the caller.

Fixes: 9567da0b408a ("device-dax: Introduce bus + driver model")
Signed-off-by: Jianyun Gao <jianyungao89@gmail.com>
---
 drivers/dax/super.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 45f84b0eb909..0f35f65363ee 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -723,7 +723,7 @@ static int __init dax_core_init(void)
 
 	rc = dax_fs_init();
 	if (rc)
-		return rc;
+		goto err_fs;
 
 	rc = alloc_chrdev_region(&dax_devt, 0, MINORMASK+1, "dax");
 	if (rc)
@@ -738,7 +738,8 @@ static int __init dax_core_init(void)
 	unregister_chrdev_region(dax_devt, MINORMASK+1);
 err_chrdev:
 	dax_fs_exit();
-	return 0;
+err_fs:
+	return rc;
 }
 
 static void __exit dax_core_exit(void)
-- 
2.34.1

