Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4138F27453
	for <linux-cxl@vger.kernel.org>; Sun, 17 Aug 2025 17:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755451217; cv=none; b=a5KA47uLhCJGIl0iLZLHQFHLWVXs56myg7ZXITW9iMeOYUWbOrd1CAA6fqPrdN+ri2nrccIH3wVC4pKP/s9u0dYIjlSvibwm8QhXeHrvmo7Wg2zEZpzbetomh4+bakusZwAmayC5JtE/74TgfiMj4goXwVdDiH5FswisQt3fA44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755451217; c=relaxed/simple;
	bh=QywHrMCGHrpw1N/WF8P8OPYDpdoKfATYmwOmZsutAD0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eDVQsax5pyIUw5Kx+9TcP4StRZlXsOrxCpYAw1lb/Bn5yxVGa4cnaMaHHTsZ44qwHDIwOZVcIxhruVUHcHKopJMnnI3vIytlECMmCm3esLhLtfFPkWtl+JU39SNSvCOfqFDc3AUY9dwsZTelxV0CN1ID9l7Bo57bbUqp6jGFzW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=ZyiChyiG; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="ZyiChyiG"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b1098f9e9eso47993731cf.0
        for <linux-cxl@vger.kernel.org>; Sun, 17 Aug 2025 10:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1755451215; x=1756056015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mSnL06ycRqaedii29t6GSI9Lkyw4QrGbTSVi1KTNBmM=;
        b=ZyiChyiGBkmghbYceYdmQsAdDOKK0WHt+Tt2kRvC0w0s+gAQ8HNGmXieB9LldrVWXB
         oxSX5D0PuNOU1lm+l6o1tNsaf0xBqOQxo/NtDuNFcLeLS93oVakRN7afJC3AGHvoJY74
         aGKHWcSay/XaertrpKw8EQPrSpIS/jzs9QUS7SG7XgKZ0Rz8QQCxKO4KA7AeKfaaPCcu
         jrf5oqrZ0/c8oJ6UyEhlQB5JqCvF3lH6e3muQE6KcgNMxkiNODKxX+bIGMYpJzQImBbP
         W1P7Q2YH12mt6byQ1F/aGA4qrRPKhuO9tbGEkwuCRipzvFx91mvl/9lTDvVNDck+AHEw
         NZZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755451215; x=1756056015;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mSnL06ycRqaedii29t6GSI9Lkyw4QrGbTSVi1KTNBmM=;
        b=XYQ4EfkRIwIAs0m0HQyHNkgFDzRlGw+yXURP84HVrxOeG2Arvnq70t/zGRKvsJsf0+
         TgfwbPPQt2Oc76lkSbDzGmBhiBdToW5BKuLmbxZZlhsTDQumJsBWq+XyQdtiA2z8J/bM
         Sl1APt4cPmATt+8kW2Fmv0GFZw3oEuuxTg0uo46evfaPOJqA3buV9By2Jkf7p8Pvxo/d
         GBjqtOAFIHyZ8TW9v44Ze0Pv19RbBBmxqhUUD5WnODzaXOWHHq9C6DNLF0RpFWCigDmN
         Z3QipiFkODVCCTskYhemAaKNsmwSUsRiAViQMX5pj339HnznrgrEd+YUGeNrWbX7X/UG
         SpIg==
X-Gm-Message-State: AOJu0YwuZshxt15lDy/UfHl3xHxdDuXSychvWlvCf3loBsReDavWPBwE
	EHO731crBi/QvWP6k6nTg123aYXAe81RY/FeycDCHGBN0WrLxNle3pUcnqQhxjJr9qcrSRt5FdO
	FslkK
X-Gm-Gg: ASbGncuGxHU5Jk95xXfeSEIoa8mAcLB41NG6/u+7SApJOvNdRVXxjks8L7NKrMSBVsQ
	x/Uj71sTUXpHE6fxyGdE7Ay7JhpOjgEta7hKmrbSHuaIfEhzhtXyEvCD4EdehQYy/V+Jk500j+e
	8we9w3Y90e7bHQQswxziEgSm/cOFAfwSOW5o1wtBLHVqD2qXXjpoAtT9T2XSBY5tVTPPrZN8Ul3
	qmZFqj+CdiMqsSwy/x71ayLXcPwENaXuzt0k9nIemOjd/KpUJwa1aeuJxGdwsrOYLS+p5Q//edb
	zdfIXwKP056BAmCgRSj0t2Diz/pH4moVctYpTca6Rpq2bjTxfgBdI9EwqaHfr2szXH69IOet2Oc
	+1QTKgReypBJq9OCwvd/A91N0Ll7HohTumUJFx2Dka7kfXbsy7GJx+Tw7
X-Google-Smtp-Source: AGHT+IGwz143a26VUvXza9j4UAUrHILartEYg3sAkeI33tXkk2gT37GFXk9hZ2LW7zx6MH72H+UDag==
X-Received: by 2002:a05:622a:5515:b0:4b0:7a69:7280 with SMTP id d75a77b69052e-4b12a78434dmr91489461cf.45.1755451214902;
        Sun, 17 Aug 2025 10:20:14 -0700 (PDT)
Received: from fedora (pool-96-255-20-42.washdc.ftas.verizon.net. [96.255.20.42])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b11dc18a0esm39529561cf.9.2025.08.17.10.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 10:20:14 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-cxl@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	corbet@lwn.net,
	Gregory Price <gourry@gourry.net>
Subject: [PATCH] cxl,documentation: remove page-allocator quirk section
Date: Sun, 17 Aug 2025 13:20:02 -0400
Message-ID: <20250817172002.43488-1-gourry@gourry.net>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The node/zone quirk section of the cxl documentation is incorrect.
The actual reason for fallback allocation misbehavior in the
described configuration is due to how reclaim is engaged when
the local nodes capacity is exhausted when nodes have no overlapping
zones.  No fix is available for this issue yet, but the documentation
here is incorrect, so simply remove it.

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
2.50.1

