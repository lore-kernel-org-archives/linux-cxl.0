Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCAE3F5BDB;
	Thu,  3 Sep 2026 09:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788429345; cv=none; b=E/s0TV087nueHxJ44qAh0ZeElhrHgdjWZiv0piYyTUVWA39kf8CGbAjmA73VsgFgjM3DmQFbfX/rqxTOaLRMomlICe6AvU+VvoQM895urfn3qMQwJv4lutQmfYtuvhvwc8Ar4HR7eY5iiSmw8klP4Z+5G48BFheMds9iz7k9b4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788429345; c=relaxed/simple;
	bh=tJxSv8YPQj/RRr7maKA8AhxYsSl4mdaAOIjYMhMY9Wg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kPj2usPd9fb3rFuJXgQbf0ZHWUnzB2T1FHJSAyE6EZSaGieZLIkkOr3/3NukbJxHw+19puYzs3FSi7aU10wKFozb9YC04AZ4+YZgsahm2sJoyi/hM4Em8pm+VKKAc1sMOppfGnZ01/4ZO6Rd577N81Xl2FwgVvxVzaJHG1hwmpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=c2/Jgrk1; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=WbJQ8IZe; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="c2/Jgrk1";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="WbJQ8IZe"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hbFMv0LXLzMlDk;
	Thu, 03 Sep 2026 11:55:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788429339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=r/Ui16OnCm1tcqwkqF95gqF7P108l1CO30h3rVmWRd8=;
	b=c2/Jgrk1FzbgB9W44ohY+J6eaAyVXuOITiV8QkBPRX4ad3WMw6AsnhjtGnqVBNRgCCPV0D
	UlgL71xY9mHdHBQbcyxwhPxGSt9sfMNo9AK+LayDvGLe0M9IoBQld4vdvpzncJxhpaaijV
	xvHSfPC60jNIqo7QftV8OrByK/xtfeHVgMeW9vAlInOUZnl/pSw3kj2SyMsXe3nxV3XE/s
	AhokqICd1c5bM9zW1/i+pV94tJLDaPd5p8l7rJ4vjhGgK5gfkCgaTvLHIaSk2sXIA/QyzG
	1JvULoR8NooK1sIY33XO4awukOSOMsYeykZS1JHlBlmFnRgxihcJ8bu8z9MJBg==
From: Manuel Ebner <manuelebnerli@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788429337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=r/Ui16OnCm1tcqwkqF95gqF7P108l1CO30h3rVmWRd8=;
	b=WbJQ8IZeiKAy6PJu8dQAcdeH7ebm04ypEqATYFGH+ungScGY4lVpHAwlAKnC63Go+UQyur
	YrO0iZNr7sYc3Tfb8q3oGp/hruM3GEHr+f/c2QqTma83C/ukwV13D3NGSIIjsde8+tZTMF
	kZ6RZ6P5HzzFOq7qkCsHNBmMMOyDUqI3IICBj36AC7dEwuYbOfMgEE9fUBxCY9aKltllaV
	49CYJgut/0qh9kcM7w1QS7yguvumD5ujClh+PX8Kbom7mNqisHgH57DluQU4+iZRcuqu+N
	DaRWnBc0qG2bcf7XdOutkX+MVeD4nYRYLKMpPpIMaoYffEXgLvBFLbVBN6Dnrg==
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: Manuel Ebner <manuelebnerli@mailbox.org>,
	linux-cxl@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] cxl: docs/platform/acpi: Fix brackets
Date: Thu,  3 Sep 2026 11:54:45 +0200
Message-ID: <20260903095445.729419-2-manuelebnerli@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: y9rdatg71weiqnpeock3jzegm6wm5foq
X-MBO-RS-ID: 7d29fa50edb8dbb1939

Add '}' and fix indentation.

Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
---
 Documentation/driver-api/cxl/platform/acpi/dsdt.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/driver-api/cxl/platform/acpi/dsdt.rst b/Documentation/driver-api/cxl/platform/acpi/dsdt.rst
index b4583b01d..73b23d82a 100644
--- a/Documentation/driver-api/cxl/platform/acpi/dsdt.rst
+++ b/Documentation/driver-api/cxl/platform/acpi/dsdt.rst
@@ -25,4 +25,5 @@ Example Compute Express Link Host Bridge ::
             ...
             Name (_UID, 0x05)  // _UID: Unique ID
             ...
-      }
+        }
+    }
-- 
2.54.0

