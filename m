Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7127FBA2
	for <linux-cxl@vger.kernel.org>; Wed, 30 Apr 2025 00:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745971957; cv=none; b=S4vl0kXJLCVRT75lb18cudifXPLzp4OToJMLySdOrAvyKTeG1MYxmkH+JtKT/Y1PF7bSfgpd1dh4OwZfxaxirlnxFejI5FtNdm2sEckO9DuWAL/zzaYFsr6vsBVK1B0VQpWrFomPwexwezrm0uyKUDE7OStvGux1RhMSYvHTLUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745971957; c=relaxed/simple;
	bh=qJvAeC9PJ0yrfTjybs1QJ63QO49Ry6kSSEW1PYb/KCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q1nemJW2MQjL73rp7ctKI6NEbE4qA6U1+nsP5r8JT1FPd9BMREzq6+VwLxVCMZ7vONqcnSf2tNPuijDMyCf3BpfAJPPJH4WiVjTxiUZIkBb1zeel73jh8BdlHD74X+8yqvDGaVzXSdg/4+aJuAEn07jueoYpyQU4kEy3B58SHWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=B5mR4VJV; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="B5mR4VJV"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-476ae781d21so78558431cf.3
        for <linux-cxl@vger.kernel.org>; Tue, 29 Apr 2025 17:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1745971954; x=1746576754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1s5gcOP/bkzD9yLDRr1nu8e/0M24YgRWFUxLhi7LbcA=;
        b=B5mR4VJVK5aZiN3MIE2zDyFkz1/I+UUKDVZ/Jglqg0mM2oAo1Fj3YBFchXnDN2DD90
         OdjBNFWqkeyfTE/oNh20SSTk0CiaYHL7y8K2JXXk5JuDo6ovGpN7BxM0uQdRte6NK/Nz
         koFYtJMacdZ7yVXB35IyAAICy6HRkXUrYt+ZOed6L5BXKnw1z0vwo5/7R1LgLcN4Dmi8
         6/wnPdbv90D4Xt+9X8HB/s7BdpFDevdvWGMT2c/i2bQkirYEK/FnTj2X5QTUGCa+u7q5
         fyykCrkTZmhTsV6vTlxLZq3Oo3GEVsD19y5FHkNZpke2W4Rbi8foDQfvnOca5xhiSN3u
         YXpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745971954; x=1746576754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1s5gcOP/bkzD9yLDRr1nu8e/0M24YgRWFUxLhi7LbcA=;
        b=epESIBzMT2GVY11TVrnoUNLzGb2dpB8iME/A5+/g+bqANsxl40sO5g0sHRWqpFU8hM
         aeJb2wOrefvBVMc+mlkncsyiVVvh4U2fpr4D6weQ7Be45cpOv2ZNNBM3msxnH4kdnni8
         bS/MIgDEB+rgiKpqwur8w5YN++inpVkgPAfG82zynK4vSQY6lkvkXG1VbntmKSOGbdoe
         hOALWjw8TX7PScoAHSmZtpVEm7on2c8S4zCbANwH31BFztUqWI2tKip4VIWfPG2pCY4t
         IPgKFxFsV9x6OWdV7eX28xR956ztlUxus4iz1XlGOx1K+dsFeFQELXhZHxVqyCDn8VWC
         m0qA==
X-Gm-Message-State: AOJu0YwuPuiitmjq98rSGSz++CQ2tmqBAh4YOBmWCWuFzlVUUk2G0VdE
	Qt9Wf/TmYL3QxbShCoUDV8JdLEIZcDsJlQmP9Ng/ChtANkzQGYwVRbVCGWQcFxHWw4osirpePN4
	c
X-Gm-Gg: ASbGncvoXkXoYjlFVSetf1ofru6oR1w4s4ldCE9hCC8CB/j6M0SIl3nWkb7AlE58JXF
	2nKisZpimvT4TELjbYNGbO8qi4epPaZqKFfyQccWweUmHyAdQNlgN0keJ3bw5WbxW9kFs3bkuNO
	3KwUeFpr4XRnjmGnSKanhQ9U64927MvV11dRE7hP1dPYJtHxiwHwnHLdC6f93S89gv/zjeTnmN2
	KHXLeaQM1SvTuUZymvhsW61wn7WJShpbbdrCTePFoifsWAluxQf0PDo2RA+mzjYH7SX8htv1V56
	8lwPXLUESFXswvIDrmlnm0EbMGU29gpusvq+o7FCccrqAvBvEnMea0bgkMHhZyzQC9ZHZtCWHQ4
	g2dSI0GRAr/UAvltbfgvpJ9yur+Z6
X-Google-Smtp-Source: AGHT+IEKGR2FHHd25LiYQesqqVIWnTFxWxv53o72vrO3uUoe9coBak8e3HrW/K1B4aZLE7+Z/ygLCA==
X-Received: by 2002:ac8:6f10:0:b0:476:79d2:af57 with SMTP id d75a77b69052e-489e4a8942amr9867851cf.22.1745971954008;
        Tue, 29 Apr 2025 17:12:34 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47e9f7a820esm87634411cf.41.2025.04.29.17.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 17:12:33 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-cxl@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	corbet@lwn.net
Subject: [RFC PATCH 01/17] cxl: update documentation structure in prep for new docs
Date: Tue, 29 Apr 2025 20:12:08 -0400
Message-ID: <20250430001224.1028656-2-gourry@gourry.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250430001224.1028656-1-gourry@gourry.net>
References: <20250430001224.1028656-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Restructure the cxl folder to make adding docs per-page cleaner.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 .../theory-of-operation.rst}                  |  0
 Documentation/driver-api/cxl/index.rst        | 22 ++++++++++++++++---
 .../cxl/{ => linux}/access-coordinates.rst    |  0
 3 files changed, 19 insertions(+), 3 deletions(-)
 rename Documentation/driver-api/cxl/{memory-devices.rst => devices/theory-of-operation.rst} (100%)
 rename Documentation/driver-api/cxl/{ => linux}/access-coordinates.rst (100%)

diff --git a/Documentation/driver-api/cxl/memory-devices.rst b/Documentation/driver-api/cxl/devices/theory-of-operation.rst
similarity index 100%
rename from Documentation/driver-api/cxl/memory-devices.rst
rename to Documentation/driver-api/cxl/devices/theory-of-operation.rst
diff --git a/Documentation/driver-api/cxl/index.rst b/Documentation/driver-api/cxl/index.rst
index 965ba90e8fb7..dfc0a4aa9003 100644
--- a/Documentation/driver-api/cxl/index.rst
+++ b/Documentation/driver-api/cxl/index.rst
@@ -4,12 +4,28 @@
 Compute Express Link
 ====================
 
+CXL device configuration has a complex handoff between platform (Hardware,
+BIOS, EFI), OS (early boot, core kernel, driver), and user policy decisions
+that have impacts on each other.  The docs here break up configurations steps.
+
 .. toctree::
    :maxdepth: 1
+   :caption: Overview
 
-   memory-devices
-   access-coordinates
-
+   self
    maturity-map
 
+.. toctree::
+   :maxdepth: 2
+   :caption: Device Reference
+
+   devices/theory-of-operation
+
+.. toctree::
+   :maxdepth: 1
+   :caption: Linux Kernel Configuration
+
+   linux/access-coordinates
+
+
 .. only::  subproject and html
diff --git a/Documentation/driver-api/cxl/access-coordinates.rst b/Documentation/driver-api/cxl/linux/access-coordinates.rst
similarity index 100%
rename from Documentation/driver-api/cxl/access-coordinates.rst
rename to Documentation/driver-api/cxl/linux/access-coordinates.rst
-- 
2.49.0

