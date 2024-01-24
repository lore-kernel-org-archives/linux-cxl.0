Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C6F8F72
	for <linux-cxl@vger.kernel.org>; Wed, 24 Jan 2024 13:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706104159; cv=none; b=k077x+aR2M4ytV1k6ZKkkos+us9c4LBnJ9pUfbII0f/pxLb/QaWv8pbx1+OhXyfN/KpLoQkP8OfyGXmE2mBbjgFkxMf8ZkippJzHQspXXjxuPPIJsK7KOoVf0DQ7IG6pcGW7uQ6OvzUF+b/Qzmr206nmC4WjxYDXMlimSCea25s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706104159; c=relaxed/simple;
	bh=ZujCBsMNMNpVvIvr+gRvHwrNGWzjLSpVfL1ArnnHudU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XnzW5KkYPsGnOCesa74IXh3lbDejgz6yq3vWxadoMaE4+bgIlO8irI9qF7OSoHzpcjgYmRiEfwdXL8yUfRYPC/I/61G8mVAIDgLIYVjxgh+j5CRLUy2/8t/MDr1S8eroDawgvUgkv0SKCsjgJwGz/0Xb6BxgBN4agMU0oAXkjEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TKlbp1jpYz6JB4j;
	Wed, 24 Jan 2024 21:46:14 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 48998140517;
	Wed, 24 Jan 2024 21:49:14 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Jan 2024 13:49:13 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, Fan Ni
	<fan.ni@samsung.com>, Michael Tsirkin <mst@redhat.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, <linuxarm@huawei.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/5] hw/cxl: Update link register definitions.
Date: Wed, 24 Jan 2024 13:48:11 +0000
Message-ID: <20240124134814.8717-3-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240124134814.8717-1-Jonathan.Cameron@huawei.com>
References: <20240124134814.8717-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

Not actually implemented, but we need to reserve more space for
the larger version of the structure in CXL r3.1.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/hw/cxl/cxl_component.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
index 7d3edef1bf..2c7631bd1e 100644
--- a/include/hw/cxl/cxl_component.h
+++ b/include/hw/cxl/cxl_component.h
@@ -104,10 +104,10 @@ REG32(CXL_RAS_ERR_HEADER0, CXL_RAS_REGISTERS_OFFSET + 0x18)
     (CXL_RAS_REGISTERS_OFFSET + CXL_RAS_REGISTERS_SIZE)
 #define CXL_SEC_REGISTERS_SIZE   0 /* We don't implement 1.1 downstream ports */
 
-/* 8.2.5.11 - CXL Link Capability Structure */
+/* CXL r3.1 Section 8.2.4.19: CXL Link Capability Structure */
 #define CXL_LINK_REGISTERS_OFFSET \
     (CXL_SEC_REGISTERS_OFFSET + CXL_SEC_REGISTERS_SIZE)
-#define CXL_LINK_REGISTERS_SIZE   0x38
+#define CXL_LINK_REGISTERS_SIZE   0x50
 
 /* CXL r3.1 Section 8.2.4.20: CXL HDM Decoder Capability Structure */
 #define HDM_DECODE_MAX 10 /* Maximum decoders for Devices */
-- 
2.39.2

