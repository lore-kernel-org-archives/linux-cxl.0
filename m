Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184912D248E;
	Mon, 18 Aug 2025 17:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755539631; cv=none; b=DSUybroIHctrhALwpGhHLuYccl/nHbykwB5SKYRAOKOTrGW8fGfYmlogQe5ulm2TVc+BOmBAA7vIawMG/rDy2JYkhUosy53E3drDR/z3HFBHHFdpbeNjEQIvIFeZNmc3DVIxJ/UZ8ctNjnogCDyDDvXXpQD5iCwvJd5e1ETAJGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755539631; c=relaxed/simple;
	bh=HJIUb4G5YI+Rixd/D2ApFQOK4mZ88TMso8AJjwTrMlY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KOfZNzxCFZ7Nxa+JLm4PB24WdZdGg7/gq9+wOdsSXDsrd4C+75JodtWCenedjG1qNHYj64BGvQzWCwPVEStla26wVcL0DOpfqnkdnIQD8jkazmEEXU8fZC7GGL/XuSPMqgvAoHsdoP4h5QWApxr8DZgaZYLzsIi1PI3s/2xuzKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lmFbRHpV; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmFbRHpV"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-76e2e8e2d2dso2705808b3a.1;
        Mon, 18 Aug 2025 10:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755539629; x=1756144429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9c4GNojMcxWdoHKIoocPUw00TeAK1QWc4rtBiWWbTGg=;
        b=lmFbRHpVqKgUJylJZhFvAW6g3gT8WC3s7KxhB2uWLBatw0OxBIdmR3k7myEHRtk6i/
         oEvPUYklfHk5YF+/ySukUajJDuUt4bItb+16ef6ku2l+Va54ooFOT2r80hw1SZeEVJVd
         ySUiGlbrk306YFFmnMpxRRsbSESfhMeSd1z1mF4mg7P26HArkQfK5t2puHAKIps5JOJ9
         lTCh0vNx/nqF/8aJHstdl8bBbXpObQ4y30IymOaLydAsgrEXNNlvPhhAbNu26PWMXSnH
         FOBhZCYVRH7yyWRJmgFmyrTe75q9tUs93kJB/5AyfdsX9787yQQlyTsvoskMyEd9qZuV
         ZiKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755539629; x=1756144429;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9c4GNojMcxWdoHKIoocPUw00TeAK1QWc4rtBiWWbTGg=;
        b=H9SJS1GTab/pXzZMZ+TyurTfX+Y+7lIazVSECi5jNlHQw6vhhFHr+z0XXAXhIZU91D
         lyA2Vkb9QagTSn8PQg68KkC6JAQWBlq0hCFuc72kLvmVkgo8gPUxW/fEnBBgplLCIbZH
         D37ucIVUuzxxrd1wtNWmRtq6vBlBxyRy+KHrAhIZVgPjYPQppWFXb6e/CtvrmHD8wXLi
         2bKWcM86RvZIxu9Sv3JColruNAB/Ov72OxTHyzEAxdJgLBBJNBwbNDlss1xHlOEz+YjU
         6XvNn+YRB9JSOsvkR9V+XRg2sgBIkGx18DjJuElcTDSYVhZmpTCxZq+KzNXD5p8qGtZg
         Zg+A==
X-Forwarded-Encrypted: i=1; AJvYcCWU1Us3trrAe08oBhxx8H6M+hc0GghikvR3xH0/Nox1y7/iy2eC6VX6dyraYd33T0aTGL74trAiiCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkwZf8hp5h8KR9ixkNjPNqKONwoUc7U5oKc7hatxP5iAiQP0ei
	It0yVdvnxTL9qmoeBbiCuW8/c7DWnwQLmcEden7JeZYwg4xg2sZQPgNFQwEVtlKE90o=
X-Gm-Gg: ASbGncvXU7hl4Y1qR8XcZoi6c5xU4D2SzL8omYNgV+brhogTKSatHXGX/8ZlOO6eFph
	IFK+5JlNsnaH/SCqPO8cMiuwmHGLsRYd636v9q/UjvjPz3B/lmFQGuAwHPLO1vQMSvNlQjD9cLy
	0wmvo6Ekja/9OF+8gEiZ2Bz2T0hcehZ739ijg9XfOyuTqmITD+M/zHzTLsEm41etxaxYN6zRcSI
	6yIHB9jIc1Sdfg4dhzsdKIPZIStPR26IOSGGYB1Gr/lZ5GWroUWwX6KAiIqKMPmpwCszhHItbow
	NaKe4QWHlcckpFcjg5dLAcip/tinSlwBP+jRp89W0Vwsi2uNsrR/CiZTx1rryXF4FTQz2zMLYal
	6XgMjCNC11VlqWy0BEWyahQqhUU9z
X-Google-Smtp-Source: AGHT+IGimQ0BQxI4HtYUvNmSf65iLZ6R75oRZQfjucpMXUHBcrTZ+pSB/uB+jU0Oaqu0OvBWl6QukA==
X-Received: by 2002:a05:6a00:1806:b0:76e:3a11:d24f with SMTP id d2e1a72fcca58-76e516de72dmr10789522b3a.15.1755539628773;
        Mon, 18 Aug 2025 10:53:48 -0700 (PDT)
Received: from lkmp.. ([223.237.184.72])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d0d22e9sm248437b3a.8.2025.08.18.10.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 10:53:48 -0700 (PDT)
From: Rakuram Eswaran <rakuram.e96@gmail.com>
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
Subject: [PATCH v3] Documentation/driver-api: Fix typo error in cxl
Date: Mon, 18 Aug 2025 23:23:34 +0530
Message-ID: <20250818175335.5312-1-rakuram.e96@gmail.com>
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

---
Changelog:

Changes since v2:
- Fixed Signed-off-by line to include fullname
  (feedback from Jonathan Corbet)

Changes since v1:
- Dropped fix for page-allocator.rst as requested by Gregory

Suggested-by: Gregory Price <gourry@gourry.net> 
Signed-off-by: Rakuram Eswaran <rakuram.e96@gmail.com>
---
 Documentation/driver-api/cxl/platform/bios-and-efi.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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

