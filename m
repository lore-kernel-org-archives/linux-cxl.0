Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3149A2F8BC3;
	Thu, 14 Aug 2025 11:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755171798; cv=none; b=N7VmHPpgegCP1PMwMorBJtFnDxSROmo8luXNTx5iYgK1FArtSk6ATKC6tHDf6JcrCIqhKo4ntMb2Pj/6hnviI6Fh7wDa/tX9WNYB+wuaxOoGD7WDoetU4OurIDz/ZC/fYto229NgMJYYGtRWBkY0QDdAGYwGo8oIQqrm+VbEzNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755171798; c=relaxed/simple;
	bh=Zdy7dLbFkZGtII3NQmazxOkB03u71Z+SQYve42TvTVI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UYJNkU0fkVioW/z5bPYlEnSh1sZXiqmsowJC/1ESXEFq7tR7SJEZZic99S/tGx+AaAvmSKT6DCwWqYvOGCS8JsrxPkBTDgwleIPxYa9sMS1nRUzuimI1jmKHxmsoDw+iuq4CHb1TR8TGu0L9HMOvFXEQevUUqXXi39+wd7coh5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NnG4Um3r; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NnG4Um3r"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b4716f9a467so129123a12.0;
        Thu, 14 Aug 2025 04:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755171794; x=1755776594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SCmrgWC//nzUB+KMWvV1r1xovE6hyF4d5hN6Lt7hoXI=;
        b=NnG4Um3rLqvb/JV9fj9axMvAe7G/lfxsVLeAyiNLD9Idtxs9PM/foXkAUyV8brWT4v
         5vnTC9hSX0fgKZrDc5ZR+QQXN+Mo9hBORolsYx6QwneBNmQHe2SYRR4BAxYwv9IdU0ri
         sWPN2g2rNKHFqbvzdR5yIHXCbihIWcWoO8xu5R1brv+K2IkhlSGfSsIYjiXknZG6yy8+
         YXKPJxJQmeTdzj2GfhzOqOV/SLZAzwo9ZDxzC8sjSZv/65LcGRMHfd6k8cQIFmPT0HBE
         tmomlMumDCWc4P5Cfw7HdSobNLjeCSgq+Zi4WFfUhEjOzWZigfpB2dlqx2J7iJMtQmmc
         aIHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755171794; x=1755776594;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SCmrgWC//nzUB+KMWvV1r1xovE6hyF4d5hN6Lt7hoXI=;
        b=adxQQPdhr/1xBoliHvUfSfhEDVDcI1kdFrD7HJnBPXHnyWz/C79f0EEHqHNorZN4Gb
         teuX9VRV5bTJNjJXN10aRUKHiN4u9lic7xNoBDACkjKi0Wa9w0RhHJs/XS6f/cBu3ZzV
         lCzjSQ5hSE1JX7l4qfvyZY6k5e04RfJ1GeIZk9iwu8hK4eJwsbGFWku+b3BlC2Es6QzG
         8AQuo6ukHnKsroOCbm1QnOAdXSQq3NTKqLgfckz4m2Y6VkIFv6quf0+fnQWcmrwn0LAk
         euGGTyC1V9vKLJNtV4goH5LPbA/SPd+n/DwGrAqu9FTxVnSFmMkFLHjl2+z5UughYyBv
         fGqw==
X-Forwarded-Encrypted: i=1; AJvYcCUUFaE7KZrJU5SuEgdXfrHIURXwtSLFoux0UKJHgEpz/F+bE4EHjWA85VUQDfTrM9sDi8Q3UlwDzEWcOuRuHPc9padS9jk=@vger.kernel.org, AJvYcCV5zilt2kkotn5bab3TTAzs06ZVUgPDpxOPVybAbHtolJ95oACLfIWTFNDKvJ6Ni/12a6TAvbvYPr4FyXNM7NnzZLs=@vger.kernel.org, AJvYcCVzdGvCRioMKMoenEceN8lCraMec+S/Owf15sa+TX5ysbwRCc2R7jkpwKsVU2/ri3IDWwKrR+bshgr3@vger.kernel.org, AJvYcCW9wTS7TUxe+boB25ydMM5sXCg4uB/KZr3iUGBDwiRO7id6YKBwg9KbX2oSleVhcFbpOWf1pqzo5IQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9BSPZMilMGlLyLvsLnlt817KNtnc+gdvt0RR87GzlWl9HMjJo
	DQW76cDigL12xXjP1W6srdM4+i3WY7wwp9mmjwt2M6bl3jOiSRtXPh7P
X-Gm-Gg: ASbGncvPXtfMqohgQ44bs8U646vZL2kbYOsw8kUOEe5O/T3LpS1U87B/zjmnhGwIz1/
	kerbFHki5Ku8uudKCid1RRyOGVR/t5G31oO5BW1OjLsZ0ebRBzvaFoF/9iW81fm3dFOXChhPvZQ
	zsjpGLWjL5zl0I9YP2okJ2xbtvchXe2RAZP1icTDCDHWv55DPa//WsabnJCOrm6Wtont+jbksyU
	mQHtCD2lE2jxcGkK8YbYokxtmTIAq5Jvyihh2Fdf1QZHNhpOUi22FeAgWfqf0wmeZzILqDTAVHe
	QxWhhke5ulaPuElp7VfxGx1t8zis5fSJ9nH83d84quJXMMbCAgZPdNbf69QhEUjPjo+SMSrdgxC
	2guLi/ZroI9aa0JE9KmfydZTjdnlM+Q==
X-Google-Smtp-Source: AGHT+IGj538MNFw8lnLpKQJxZofnRLU078qxv/1o5OvFcfhFzVvepwV4a2SHH8CKzazBMkPgBT0qiQ==
X-Received: by 2002:a05:6a00:1255:b0:736:4d90:f9c0 with SMTP id d2e1a72fcca58-76e2f8bfd42mr1938894b3a.1.1755171794275;
        Thu, 14 Aug 2025 04:43:14 -0700 (PDT)
Received: from ranganath.. ([2406:7400:98:6831:7d1d:f0f4:7398:409e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76c34d23f01sm19285741b3a.23.2025.08.14.04.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 04:43:13 -0700 (PDT)
From: Ranganath V N <vnranganath.20@gmail.com>
To: corbet@lwn.net,
	linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	alim.akhtar@samsung.com,
	dave@stgolabs.net,
	rafael@kernel.org,
	linux-kernel-mentees@vger.kernel.org,
	skhan@linuxfoundation.org,
	vishal.l.verma@intel.com,
	Ranganath V N <vnranganath.20@gmail.com>
Subject: [PATCH] Documentation: Fix driver-api typos
Date: Thu, 14 Aug 2025 17:12:44 +0530
Message-ID: <20250814114245.16399-1-vnranganath.20@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Corrected a few spelling mistakes

- functionalty ==> functionality
in Documentation/driver-api/cxl/devices/device-types.rst

- adjascent ==> adjacent
in Documentation/driver-api/cxl/platform/example-configurations/one-dev-per-hb.rst

- succeessful ==> successful
in Documentation/driver-api/thermal/exynos_thermal_emulation.rst

Signed-off-by: Ranganath V N <vnranganath.20@gmail.com>
---
 Documentation/driver-api/cxl/devices/device-types.rst           | 2 +-
 .../cxl/platform/example-configurations/one-dev-per-hb.rst      | 2 +-
 Documentation/driver-api/thermal/exynos_thermal_emulation.rst   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/driver-api/cxl/devices/device-types.rst b/Documentation/driver-api/cxl/devices/device-types.rst
index 923f5d89bc04..7f69dfa4509b 100644
--- a/Documentation/driver-api/cxl/devices/device-types.rst
+++ b/Documentation/driver-api/cxl/devices/device-types.rst
@@ -22,7 +22,7 @@ The basic interaction protocol, similar to PCIe configuration mechanisms.
 Typically used for initialization, configuration, and I/O access for anything
 other than memory (CXL.mem) or cache (CXL.cache) operations.
 
-The Linux CXL driver exposes access to .io functionalty via the various sysfs
+The Linux CXL driver exposes access to .io functionality via the various sysfs
 interfaces and /dev/cxl/ devices (which exposes direct access to device
 mailboxes).
 
diff --git a/Documentation/driver-api/cxl/platform/example-configurations/one-dev-per-hb.rst b/Documentation/driver-api/cxl/platform/example-configurations/one-dev-per-hb.rst
index aebda0eb3e17..a4c3fb51ea7d 100644
--- a/Documentation/driver-api/cxl/platform/example-configurations/one-dev-per-hb.rst
+++ b/Documentation/driver-api/cxl/platform/example-configurations/one-dev-per-hb.rst
@@ -10,7 +10,7 @@ has a single CXL memory expander with a 4GB of memory.
 Things to note:
 
 * Cross-Bridge interleave is not being used.
-* The expanders are in two separate but adjascent memory regions.
+* The expanders are in two separate but adjacent memory regions.
 * This CEDT/SRAT describes one node per device
 * The expanders have the same performance and will be in the same memory tier.
 
diff --git a/Documentation/driver-api/thermal/exynos_thermal_emulation.rst b/Documentation/driver-api/thermal/exynos_thermal_emulation.rst
index c21d10838bc5..f77d27c25ce2 100644
--- a/Documentation/driver-api/thermal/exynos_thermal_emulation.rst
+++ b/Documentation/driver-api/thermal/exynos_thermal_emulation.rst
@@ -32,7 +32,7 @@ Exynos emulation mode requires synchronous of value changing and
 enabling. It means when you want to update the any value of delay or
 next temperature, then you have to enable emulation mode at the same
 time. (Or you have to keep the mode enabling.) If you don't, it fails to
-change the value to updated one and just use last succeessful value
+change the value to updated one and just use last successful value
 repeatedly. That's why this node gives users the right to change
 termerpature only. Just one interface makes it more simply to use.
 
-- 
2.43.0

