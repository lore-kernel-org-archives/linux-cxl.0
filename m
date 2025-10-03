Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300CB21ABB9
	for <linux-cxl@vger.kernel.org>; Fri,  3 Oct 2025 14:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759502016; cv=none; b=W1kegnCZWvjbj3FeaeFOomYwZvKhk4bGWdai03yd49WTQONfwNX3Hw7hHAQtStUCzZwWAR0miNCtJqMZN7CVyrhS4I7pM/dqQb+YBOjYsiAJZgBh7itz+tXzgsVLRrCLkYjGIsy6oR2gqzYpZ7NadaI4rKaXPkOrwdwlSYDgahQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759502016; c=relaxed/simple;
	bh=f0k+kW0Uq5dGtEoUx3uqrv98HH4BGEJvGHNwLn4gP3c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XUtrzNhJ1Cn/XlWUHm2vRsflpt4M07B63esWGMb3naWAafs89wwkonnQzxIPDwq4ov7wNFn5pBu9fKCb7pky3hvlY/1s3S2lS9BuAZl4P+8uKVwq/tzYeeOstWqZtdCS0lGtDMdD/aVnDr0vLRKxM/0yAybI1H3CsiIV1spE4Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=QsglpAhS; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="QsglpAhS"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-856328df6e1so250201385a.0
        for <linux-cxl@vger.kernel.org>; Fri, 03 Oct 2025 07:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1759502014; x=1760106814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I6dPEYp0SmulQxrX2drwOWKtF0shLYyrmazi9ATO4Jg=;
        b=QsglpAhSjdCPMD01m1v8tsdOknWuAsW8vg8xN7+mTQEVycJvAek1gwAhzmB6aarrDH
         FBhAvdPj6eP6NasL84Bng4bknZIKqmjMnHiIzbjbU3HxxPAqbmxFh1LExyUQ0ENA+1O1
         gZ1ushPCLGeUCleWgKU3nH7lipNeg0hPb7ZUwCMk9i5PTg6IsXJjIH0NmgMWnDRWrSoM
         MUZ8EqMUMpxKw6JnnyxqGts8sOA1yvvr1bXcYOqDGhLH3tPRnImz3FRFYxYXgy+6Rd91
         yq1NqdLyk3rs3qD65F9OUNwACcdSdjEIwddk/jcCgqm76rZ+pr51dKaxeZbWvn3sY1mf
         ykgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759502014; x=1760106814;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I6dPEYp0SmulQxrX2drwOWKtF0shLYyrmazi9ATO4Jg=;
        b=PDf3EL1j0GB12DYunVQaRrS84VkgqBKdm5G0T1SSi+5BA8B4nPsCXGQnplt+EK/zMR
         74cFzZI2JPXFCdXxetqXVfKsrqFTOmclImvzx81arE0PUiMmK17MolHH+pUtr63mxAC2
         9kgv1+TdZM6GCdrmp136033cg8lCzBPrUpalyZQSF9K/cIBKLk0WQ1JRVAbepLmqESGA
         eXD1p0UGqFPfOpnUlv2odObjN8m3WNaW14w2fe73e0lvEVj7ffqX/8NtXMBbErHsZeu0
         PdNlC79Zr2gA53gHZswTRZwCLRYWFN6PLEgRg0jfdipP4PBHdUVjOM9fXd/TRg/t9gLG
         LVew==
X-Gm-Message-State: AOJu0YxJKZFaefeCxUxlpSMtMlbfgBzWY++kj+dW6wXt1JVrg4BzDknQ
	8PKs8q9OA9mWaRrESARJI8nfLNMGMLYKnmtgz0eEoV5+gt9RJAXW4RJzbIo5z5NYon/KyyVWD91
	AeL1y
X-Gm-Gg: ASbGnctchfaWhts0Vgs8fDOPwe3TbF+X7SOgSVmvLIrW/ahzS5p2zPk6+95IPEBwQv7
	CZSJn0yFxd5o9UBOUyGxamC0spEKnJstPCaGI3dGjbP3LaA5U4GGJzcBYrIfw83BU9f0PvrPVk2
	3iKguiMmC9ozyod2lAXA34Ai60ApnKoqNe1e114YNnlbuG41SIfLyTG5g/0YsXEaMq0ticvANMm
	XoBXkVa7S604hTmS5nbublYmPGrom4iFhmq+8LcEi1u+VrW1YN/M634p1YAnRU5dkuUUlryOkUL
	fAMmfC3Ng4Be1sfTctQmXh78s93UZITYVoX/GIuX4bzBqsqOx0SesXy3hjEwGmONYNLwyiwR5Jp
	gkbyqALSR2jdvDCpTD933tng/jW3Nk8bnb5MOhDjlw5+2cJcnc4FKqra12M+Br4JFkcYpS5zQXO
	7FLhYLP/48FbMsZcQKRRi0bd822KsiQ8MUCco=
X-Google-Smtp-Source: AGHT+IEaQ0B2XmFj8U/GUa+p19UedSknVSwCkjKUNut/FbZ2W4QxK/tAJmdZIZwBzFFIVtotQb9hmA==
X-Received: by 2002:a05:620a:28cd:b0:858:ee50:25da with SMTP id af79cd13be357-87a38b336a1mr458817485a.63.1759501956557;
        Fri, 03 Oct 2025 07:32:36 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-877797993e1sm426958685a.58.2025.10.03.07.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 07:32:36 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	corbet@lwn.net,
	gourry@gourry.net,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation/driver-api/cxl: remove page-allocator quirk section
Date: Fri,  3 Oct 2025 10:32:32 -0400
Message-ID: <20251003143233.1985150-1-gourry@gourry.net>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The node/zone quirk section of the cxl documentation is incorrect.
The actual reason for fallback allocation misbehavior in the
described configuration is due to a kswapd/reclaim thrashing scenario
fixed by the linked patch.  Remove this section.

Link: https://lore.kernel.org/linux-mm/20250919162134.1098208-1-hannes@cmpxchg.org/
Signed-off-by: Gregory Price <gourry@gourry.net>
---
 .../cxl/allocation/page-allocator.rst         | 31 -------------------
 1 file changed, 31 deletions(-)

diff --git a/Documentation/driver-api/cxl/allocation/page-allocator.rst b/Documentation/driver-api/cxl/allocation/page-allocator.rst
index 7b8fe1b8d5bb..3fa584a248bd 100644
--- a/Documentation/driver-api/cxl/allocation/page-allocator.rst
+++ b/Documentation/driver-api/cxl/allocation/page-allocator.rst
@@ -41,37 +41,6 @@ To simplify this, the page allocator will prefer :code:`ZONE_MOVABLE` over
 will fallback to allocate from :code:`ZONE_NORMAL`.
 
 
-Zone and Node Quirks
-====================
-Let's consider a configuration where the local DRAM capacity is largely onlined
-into :code:`ZONE_NORMAL`, with no :code:`ZONE_MOVABLE` capacity present. The
-CXL capacity has the opposite configuration - all onlined in
-:code:`ZONE_MOVABLE`.
-
-Under the default allocation policy, the page allocator will completely skip
-:code:`ZONE_MOVABLE` as a valid allocation target.  This is because, as of
-Linux v6.15, the page allocator does (approximately) the following: ::
-
-  for (each zone in local_node):
-
-    for (each node in fallback_order):
-
-      attempt_allocation(gfp_flags);
-
-Because the local node does not have :code:`ZONE_MOVABLE`, the CXL node is
-functionally unreachable for direct allocation.  As a result, the only way
-for CXL capacity to be used is via `demotion` in the reclaim path.
-
-This configuration also means that if the DRAM ndoe has :code:`ZONE_MOVABLE`
-capacity - when that capacity is depleted, the page allocator will actually
-prefer CXL :code:`ZONE_MOVABLE` pages over DRAM :code:`ZONE_NORMAL` pages.
-
-We may wish to invert this priority in future Linux versions.
-
-If `demotion` and `swap` are disabled, Linux will begin to cause OOM crashes
-when the DRAM nodes are depleted. See the reclaim section for more details.
-
-
 CGroups and CPUSets
 ===================
 Finally, assuming CXL memory is reachable via the page allocation (i.e. onlined
-- 
2.51.0

