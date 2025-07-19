Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202D7186A;
	Sat, 19 Jul 2025 11:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752924390; cv=none; b=aaKsARAeDJ+QA7rmQeSdTSmmBz99zGRWuzIRaKcGLA8FggHOPA2gDiAR7Nx0PusRwe90CoiHNcU5+nT2NnZzmPd8esWvWpXzLjex1FiQgiMQvzyZpGLgP5AY67JmP7p/jB5pMx8xEJ2qh7MZ3f6Ac7e3P+G6NR8XWVe6jslPrQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752924390; c=relaxed/simple;
	bh=KYnXqm+R0357NOyh+FXM6qRFnZpUrmAPV6EatTu4tXk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M65a9yNJUM6JBdKJ7NOvObxRYk2vphqq2HrXgbMwoBTrGNDcyI8TFZH2RywyQRPcuM3fFd36ri1V0NJTn3PLRvIgryiNighcQcndxo7U569NIKH5AI5Ih/uF5tWaM24woU4uT5G4RSz5ujnl4JUQvcLSRln4A54N4vD+0qfZcvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TcOaZQiA; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TcOaZQiA"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-747fba9f962so2824647b3a.0;
        Sat, 19 Jul 2025 04:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752924388; x=1753529188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1tm4VD55Vw0PRPdwY8xwaWOPoyGLCdto1ggUmWV9vps=;
        b=TcOaZQiAVqW9NiDdMF0J1nCI8IQ9CxR3jK+IPQ0EWtHhopS8Oz8WNujjUrM1xyZQE0
         SYA9A6clTYRPy8WgvIeYPEwZWvNkbgPVZvgrDDAhFrrIJjbOFZybpF2l9oq8iJywmcvS
         JhtkglBm1Hg8gde02S29w9M0kbLjDCcxHYRIyYq2zAgpuJ/Sjcft3+VWPrJ3fyG5BQU8
         PNZ9I/+D2WEq8H8/xXvVgp4nGNvwhsyXc3bMPlfuvjML95WHyeUnlcNvF3WoItzE4f1a
         IvFE/SnoBH/AZWFOZeq+HPCn68+B9Ti/ANrd2zfslgL36VFHv692olUTEsQaaRDZwcSY
         3m1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752924388; x=1753529188;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1tm4VD55Vw0PRPdwY8xwaWOPoyGLCdto1ggUmWV9vps=;
        b=VzAKgFUh6DtctO6Z1rrjiUuBqyPghB5eLR7d3EHpwTgCqHrF2vx1KvnTiXJYXg4TT1
         xkO8j1NhrqfkatWfH2rHrODh9lfp6JjyaV/n346RXx7f1hmEUXLFXRKvfE/cUzG9ERyB
         KqAxnPB11qa+5j7a16t6OY3vEZNu5LDyZZpKZCguLLg4Sde+wh6Jzv3vXAcxcjZtDpjs
         oEiPUx+UhuyzN7xrHe/aAGHJK5wXgWSvGmaIeSW6loLZ766gGxFnkCQCszjecRoQD4WU
         NLD7Tn+ItjpKwFa/FkyuAV540Mvx+jh3D5am/EdZGNGAGQQ4M9UiviMZUBEzw/NsuI9Y
         W5cA==
X-Gm-Message-State: AOJu0YwaxC/xCLlT9nWvDcY58zeyv/cVPkQghY2uKEZeLV0FbnkXgtDo
	YNji7BIY+wVv6QP9A2D/lbGJFzMhAixBYGUgMcj6ZBdubv/XRzfUVbcJfJESsQ==
X-Gm-Gg: ASbGncs0AH/LQ4ysBabkvwy66ssL+fJ4YFfvHfTkOcBK19GjCP4EGhnBsjMu+S8yWeP
	g4b6YgGVgBVMbV9xJnm/yeA7/JZuIIW3dAlvIRDG9s7jRzpyIM8nJIF5RMeF8ea78vsmqZiZ0eQ
	gzJINWhubXQY9MLfioFXGn+cN8ajzyhkrnxvlNRjtEdraczGoeUec+pdupkXB+3cFWnmiPTi6iE
	K0nc6FIQYkDyMkb2R5Em1HnoL8mBAbfYXDP1IaWBrbhoWMZvaddOQW62nbK4A9TwptgLEHrjNMh
	JFH8fDjPcRPyU7wptlbHj8pCW0w7YTYomUkJfMPW6xODXSQ/RT1sK0CMnPazbj4lg7tg3GlkLT7
	9B2IxzX3+tWTj/gbyZobrweojl+iHDFal9zIx
X-Google-Smtp-Source: AGHT+IFmRoeLC70Lhc7juH4UNMmJFL7/wL5HGXnGAKf9YWlOgGS/dduvmFnLqo5f3fnqixRiHbm17w==
X-Received: by 2002:a05:6a21:4598:b0:232:22a4:bd50 with SMTP id adf61e73a8af0-2391a30a4edmr11063515637.9.1752924387722;
        Sat, 19 Jul 2025 04:26:27 -0700 (PDT)
Received: from localhost.localdomain ([240f:34:212d:1:b20:5ffa:a79a:5174])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f2fe8b88bsm2479637a12.16.2025.07.19.04.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 04:26:27 -0700 (PDT)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: linux-cxl@vger.kernel.org,
	akpm@linux-foundation.org,
	akinobu.mita@gmail.com
Subject: [PATCH] resource: fix false warning in __request_region()
Date: Sat, 19 Jul 2025 20:26:04 +0900
Message-Id: <20250719112604.25500-1-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A warning is raised when __request_region() detects a conflict with a
resource whose resource.desc is IORES_DESC_DEVICE_PRIVATE_MEMORY.

But this warning is only valid for iomem_resources.
The hmem device resource uses resource.desc as the numa node id, which can
cause spurious warnings.

This change fixes this by restricting the warning to only iomem_resource.
This also adds a missing new line to the warning message.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
 kernel/resource.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index 8d3e6ed0bdc1..f9bb5481501a 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -1279,8 +1279,9 @@ static int __request_region_locked(struct resource *res, struct resource *parent
 		 * become unavailable to other users.  Conflicts are
 		 * not expected.  Warn to aid debugging if encountered.
 		 */
-		if (conflict->desc == IORES_DESC_DEVICE_PRIVATE_MEMORY) {
-			pr_warn("Unaddressable device %s %pR conflicts with %pR",
+		if (parent == &iomem_resource &&
+		    conflict->desc == IORES_DESC_DEVICE_PRIVATE_MEMORY) {
+			pr_warn("Unaddressable device %s %pR conflicts with %pR\n",
 				conflict->name, conflict, res);
 		}
 		if (conflict != parent) {
-- 
2.34.1

