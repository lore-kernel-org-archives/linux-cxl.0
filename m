Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740B13176F9;
	Sat, 16 Aug 2025 18:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755369053; cv=none; b=Ez/ECmUWhKVN495/qGdjTL6OhLNa3997WII2GT0uvYKZRZQkDQOPdLZD0sEf1nD7QU3SGeB/1jdPddnfLzzFQzJgQw5Ol2AM07dFEaEufxo64dA5mE+ZhUQzuxwQ5v7ybaaLhZ2ccx3JDpw1RHOgUDIwtFI4PIE7o1uHght1TZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755369053; c=relaxed/simple;
	bh=Ca9Tn1UJzfTzHyDL78FjDFTXk6DN5IoHNYT47ja8cTU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s6vg+WqC4kDT5ljIEHuwyv2cacCwIC03j5aqVO9l3Jg/oia7baY+o9Ehu/VfqtK80tNVC2bIsgq0LO7j/soKgRjYbCOMQJ+rLvV/JSTrfmphqX7knxuuNbfsGWhEhXkovuDSjO8sq/LuX6RqAuGg19d6HKU5Kl9zxFBzf4mi1Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oj2zt9DY; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oj2zt9DY"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-76e39ec6f30so2072616b3a.2;
        Sat, 16 Aug 2025 11:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755369051; x=1755973851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fhn2t1l0lC8TOAJKE/KsB3bglQE6ARXTKvnpQpTHz8U=;
        b=Oj2zt9DYlP0WjXREMBuHuPZe2WlMjM8T7IMrRoJw3NlyYaa2NIA18z7zdFXj9zEMVZ
         yt5DNuG9x4rDRooZ+7CpY2ceWhn8861t/pBsNR2vpAuXCOowbcAJfIfxJUdrqz/cXBW9
         0ABu+Sx3qsBGdViw+qMg8cZR/oKj8vCecuTUOArMpBCjSHmUeVhRKL3GvBBTA6MtAeNI
         bzqxLdJ/uYLu71aAIhDpN4/qyP5vCqonb3eloYvLlpirrNnRjM1FPZfyDFXHFTs5OSps
         BfkL1f006ke4ydNTffpLA1/99D2lpzWcYafNDTt4yXV8YrHKJ0QQ8aM91OJsM56bBQwT
         oc6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755369051; x=1755973851;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fhn2t1l0lC8TOAJKE/KsB3bglQE6ARXTKvnpQpTHz8U=;
        b=BcXpkRQuS7mMaMX9zbzTDvtiLyaFGLX8j0h5YZEfAXiIe4OpYBOPNnTemZJEKrK3Xs
         IaT2n4/vJcopCRk0v2eltQHx0QqLytcCWGYsRdY/QeOF8EWID9agp9GOPU9uO7gISOjl
         u3WXvlM7p2Rgv2nuGoTUm+xFguHa8ZDANs4uSww+E1oeG8+62YQ2OS3dd5ROHLVKJH9A
         Z36SjgWwafO8q4hCILTtaAK2fincnmZoZM9B1R+h9FtkYz9fpIkQwDdqzpwQHLaaocpt
         WphwdzFqu9oJcC2T2Oi2NimshEK3GNfR4v7gOeuYpMEsPevW1sxhrFDw6JpDb8x313ZE
         aA8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUFsngnsS7AKtZslwfDhvysMmTQ7lO1Zt6HS+iLmBJjoo1cbk2QSB0S6Ip9+j7bOx1oYKw7f8m47I0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGBTJxApu2D4+t54nxNdobzvI7LguyaC5053PJlzLNARL0rLRv
	rLLbbpNjJWykurT36iNEp87I3EHUOXjTbLoFkNLsWv5sQwYUNu0yDiQTZ9aM1HGks0o=
X-Gm-Gg: ASbGnctpMxS5PZm1stAPVZXNBhiNb7FmsRmDCSDmjyQmxoAbyH1K0x35WnOzmdzyJ3J
	KtC2aiXgZinNcGf+mAo4RsKPBo3ogvf0K5d5U520fzNUIvq3Lo5vauQYs9GvQybTGrS9M4QKQNj
	X4D736W80U29qgFyRCronRwqm1b8M1OAICLBN8mZWVXyhuTAcCdl4sMJIGKGxNsf5Rs1ak8g6N/
	uyO+lUsu907ZejftlkMkseQ/ZSGN146EiEWMtTm/nU3P66RxzVR7h9ZDDOkwpb728kQSTTlr2XG
	lB97RkTZdAENndtUvos/lwFu7YNXvYmFbzY4SCQIWHrdHacbCbPJRpqh2lACF6oT04AZt5gVTfq
	/W0qMnSpv/gLHKfCGv3yIvG5jV/bUc+n8NxmCbxnj7w==
X-Google-Smtp-Source: AGHT+IFjz0rJDhGfparMNY6VC/JIueZmZiEB6VolaLHi06NigLtt9WJc9wH1l8gFuRX+8nKyr9njyg==
X-Received: by 2002:a05:6a21:3391:b0:240:198:7790 with SMTP id adf61e73a8af0-240e619e927mr4884569637.10.1755369051185;
        Sat, 16 Aug 2025 11:30:51 -0700 (PDT)
Received: from lkmp.. ([157.51.100.44])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b472d73a418sm4251175a12.38.2025.08.16.11.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 11:30:50 -0700 (PDT)
From: rakuram <rakuram.e96@gmail.com>
To: linux-doc@vger.kernel.org
Cc: dan.j.williams@intel.com,
	dave@stgolabs.net,
	dave.jiang@intel.com,
	jonathan.cameron@huawei.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	linux-cxl@vger.kernel.org,
	alison.schofield@intel.com,
	gourry@gourry.net,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	corbet@lwn.net,
	rakuram.e96@gmail.com
Subject: [PATCH] Documentation/driver-api: Fix typo error in cxl
Date: Sun, 17 Aug 2025 00:00:33 +0530
Message-ID: <20250816183034.7970-1-rakuram.e96@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixed the following typo errors

intersparsed ==> interspersed
in Documentation/driver-api/cxl/platform/bios-and-efi.rst

ndoe ==> node
in Documentation/driver-api/cxl/allocation/page-allocator.rst

Signed-off-by: rakuram <rakuram.e96@gmail.com>
---
 Documentation/driver-api/cxl/allocation/page-allocator.rst | 2 +-
 Documentation/driver-api/cxl/platform/bios-and-efi.rst     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/driver-api/cxl/allocation/page-allocator.rst b/Documentation/driver-api/cxl/allocation/page-allocator.rst
index 7b8fe1b8d5bb..4ac3368c3947 100644
--- a/Documentation/driver-api/cxl/allocation/page-allocator.rst
+++ b/Documentation/driver-api/cxl/allocation/page-allocator.rst
@@ -62,7 +62,7 @@ Because the local node does not have :code:`ZONE_MOVABLE`, the CXL node is
 functionally unreachable for direct allocation.  As a result, the only way
 for CXL capacity to be used is via `demotion` in the reclaim path.
 
-This configuration also means that if the DRAM ndoe has :code:`ZONE_MOVABLE`
+This configuration also means that if the DRAM node has :code:`ZONE_MOVABLE`
 capacity - when that capacity is depleted, the page allocator will actually
 prefer CXL :code:`ZONE_MOVABLE` pages over DRAM :code:`ZONE_NORMAL` pages.
 
diff --git a/Documentation/driver-api/cxl/platform/bios-and-efi.rst b/Documentation/driver-api/cxl/platform/bios-and-efi.rst
index 645322632cc9..a9aa0ccd92af 100644
--- a/Documentation/driver-api/cxl/platform/bios-and-efi.rst
+++ b/Documentation/driver-api/cxl/platform/bios-and-efi.rst
@@ -202,7 +202,7 @@ future and such a configuration should be avoided.
 
 Memory Holes
 ------------
-If your platform includes memory holes intersparsed between your CXL memory, it
+If your platform includes memory holes interspersed between your CXL memory, it
 is recommended to utilize multiple decoders to cover these regions of memory,
 rather than try to program the decoders to accept the entire range and expect
 Linux to manage the overlap.
-- 
2.43.0

