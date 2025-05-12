Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D397251790
	for <linux-cxl@vger.kernel.org>; Mon, 12 May 2025 16:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747066919; cv=none; b=m0K36+iRg3Vo2KiywMUy628b9BEMZBQYscR6NeVfIM14Hg/0Klvd9jAAOZXPzQsKfxm+v8kGzWlSCannjNrxjxF3LFRfe9EsG3VFJ2RHfQgNShkFFGBPiGtO1c8KtasprjeJ1vTkfdneXShZjIpkJyQIA2uDzxDT8JN2rLO1M0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747066919; c=relaxed/simple;
	bh=DoI5kxJikAM/qpIRAtn9fjxrQS8+dT5cbJX/H3hs68w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qORIC+bo3c8D1jQ2EoYCLEL3gPdlLsG5uTjna0S71rjOPStYX4/3tcKCajLHFwxzWbUQ/fLAcUlSec/vN3wzZLEl6SxlP3tKLoSfxy+znSo3odzKEnQgpqmaVWWhHM2Bf/x8jVztg2bPEumpjZzCXeWKuxmlnripcj6cG71R4Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=T11VnCbF; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="T11VnCbF"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7caea4bc9e9so893509885a.1
        for <linux-cxl@vger.kernel.org>; Mon, 12 May 2025 09:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1747066916; x=1747671716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sNILEeZYlBJQYm8rxVf5XnkRfrtj2f63uIZxnPhs6Qs=;
        b=T11VnCbFRPyHD4HaXeoavsqFfREJZpXTL/5dnngo7KylDBShtZ6689/TFf2dvDz1fD
         yih49sm2N9ze/p5IT++yOpphrutlzwkydXKBZp4bA3aAdvHDcnkyJb7RayJsS+Iwuqn7
         ivpk7lWohsG7Sa2GLFXeDD9QX7vxmPVbwCO7XcoM44PJZQK5rX0i1e/A6GyApss9TXCv
         j7HKiCCev5mtJA5Azaav1zSLKUJt4DwtKG+JnyQE2zThGsRFs7MmC+eA7fX8SwlBkgrG
         jKt23Dbpz0E49qcBvPj7bN2g5u1SCAdRbW7aaoCZNrfNiGzNEbGhdEitg3pIHCu+Qu3X
         hKtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747066916; x=1747671716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sNILEeZYlBJQYm8rxVf5XnkRfrtj2f63uIZxnPhs6Qs=;
        b=p7f5uyMaK8xEaR0zAlAMI6XxWTbOsZx1oAYphe4dcVdbU+6knaXNmkqh5wcQZ/q/8j
         XYydkMOdi5px8jHaskudVTNZkdsH6+sF5aqy8+hJE72NmFpChQhj4QXnSLlaYBNl6O3/
         6MM0YMAJBjJ0TEaL8PTJMbQ7r4uWGmGa37PC0R8E6WWZRIt/hU5ngRwWF+gFrH259Wy4
         WFK1nyv5rTP/ksnIss8tB4b4f4b17Rtf6ERdEq2m7ELHNywR7V8aiDOa3kXTgi1T2gqx
         GMlqVQvM8UoxUZvkRpvwT0LIN6rgGVHFTyqDJRVmtuqesE9Jd7Ln2pbAomwW1njrleWG
         04LQ==
X-Gm-Message-State: AOJu0Yx+O4ZcfqzNUrAQj9Om72qlGfC/IUe4OVxllIKFmJUZIK9qpexz
	uwgiVaDcEubkg1fazvoHpSzuTvFX3nU+R1t4bQZRH+BfCghIboclSv09RaYSB+0Qc+gt6oFuvBv
	O
X-Gm-Gg: ASbGncvcMMOyX5HPcDh/beQ0qENn0uYHEFlNykvaZREIOpUlV+VbQPy+qtsoca3Nq4P
	9VAtZMGNTyY0NKcBaTrcsNBwBnxwPPj8v+Rs8ctyzvpYuDG7l7TWMe6vk77WwRh0IZ/cYDhDGBr
	+UleHmuPEciMNxbEDq5ovQj5lZKN5mGDyvIbwIlQBwz3NxKLKJ37ylUDi1+yoZk1rDvQ5Udw65W
	WT4qQfqQgy9g8pLkvvAhtOg8W4jb5I5+J3sp2qsaHtZfEEBRWClebWdt9nNFM6YL4z905tvYpJ0
	Um6maqAR32FI4eOudYq86USZ0khk964BVUcyYva3CfSAy01FvUU1PeqSoegH8IEVbawH3t8sTiG
	DZQRuCNqRoB9gQJHMSZlRdAH/OcAO+hjFaZvd
X-Google-Smtp-Source: AGHT+IFwl36mLDo7FZkCUHoGJHyTy2zewdmXD6A4NvIgp/fn+qZTsyQP+IQVYzuIHMVoFWLDW+xitg==
X-Received: by 2002:a05:622a:1aa0:b0:476:8cad:72e0 with SMTP id d75a77b69052e-49452734c55mr177946951cf.15.1747066905232;
        Mon, 12 May 2025 09:21:45 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-42.washdc.ftas.verizon.net. [96.255.20.42])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-49452583961sm52461791cf.58.2025.05.12.09.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 09:21:44 -0700 (PDT)
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
	corbet@lwn.net,
	Randy Dunlap <rdunlap@infradead.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH v3 02/17] cxl: docs - access-coordinates doc fixups
Date: Mon, 12 May 2025 12:21:19 -0400
Message-ID: <20250512162134.3596150-3-gourry@gourry.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512162134.3596150-1-gourry@gourry.net>
References: <20250512162134.3596150-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Place the hierarchy diagram in access-coordinates.rst in a code block.

Fix a few grammar issues.

Suggested-by: Randy Dunlap <rdunlap@infradead.org>
Suggested-by: Bagas Sanjaya <bagasdotme@gmail.com>
Signed-off-by: Gregory Price <gourry@gourry.net>
---
 .../cxl/linux/access-coordinates.rst          | 30 +++++++++----------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/Documentation/driver-api/cxl/linux/access-coordinates.rst b/Documentation/driver-api/cxl/linux/access-coordinates.rst
index b07950ea30c9..e408ecbc4038 100644
--- a/Documentation/driver-api/cxl/linux/access-coordinates.rst
+++ b/Documentation/driver-api/cxl/linux/access-coordinates.rst
@@ -26,20 +26,20 @@ There can be multiple switches under an RP. There can be multiple RPs under
 a CXL Host Bridge (HB). There can be multiple HBs under a CXL Fixed Memory
 Window Structure (CFMWS).
 
-An example hierarchy:
+An example hierarchy::
 
->                CFMWS 0
->                  |
->         _________|_________
->        |                   |
->    ACPI0017-0          ACPI0017-1
-> GP0/HB0/ACPI0016-0   GP1/HB1/ACPI0016-1
->    |          |        |           |
->   RP0        RP1      RP2         RP3
->    |          |        |           |
->  SW 0       SW 1     SW 2        SW 3
->  |   |      |   |    |   |       |   |
-> EP0 EP1    EP2 EP3  EP4  EP5    EP6 EP7
+                CFMWS 0
+                  |
+         _________|_________
+        |                   |
+    ACPI0017-0          ACPI0017-1
+ GP0/HB0/ACPI0016-0   GP1/HB1/ACPI0016-1
+    |          |        |           |
+   RP0        RP1      RP2         RP3
+    |          |        |           |
+  SW 0       SW 1     SW 2        SW 3
+  |   |      |   |    |   |       |   |
+ EP0 EP1    EP2 EP3  EP4  EP5    EP6 EP7
 
 Computation for the example hierarchy:
 
@@ -82,8 +82,8 @@ this point all the bandwidths are aggregated per each host bridge, which is
 also the index for the resulting xarray.
 
 The next step is to take the min() of the per host bridge bandwidth and the
-bandwidth from the Generic Port (GP). The bandwidths for the GP is retrieved
-via ACPI tables SRAT/HMAT. The min bandwidth are aggregated under the same
+bandwidth from the Generic Port (GP). The bandwidths for the GP are retrieved
+via ACPI tables SRAT/HMAT. The minimum bandwidth are aggregated under the same
 ACPI0017 device to form a new xarray.
 
 Finally, the cxl_region_update_bandwidth() is called and the aggregated
-- 
2.49.0

