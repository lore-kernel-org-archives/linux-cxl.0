Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C5F26E6F4
	for <linux-cxl@vger.kernel.org>; Fri,  2 Jan 2026 15:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767368890; cv=none; b=OPW6mxEts1yntDls8Rua/kF8F6wISj2eYpuIHQaApQaRopdIYTzTlFHiOyYAYvwXBXyUtpjqtR/9TTWbQPmwuqT8KEHNvXuxFY7al6Ywdx9X0oUlXvQV6x19KDKkUbFshfJ23SBDqDbhRtgtIIM+mi1xM6n2bPRXtIodtJqpdKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767368890; c=relaxed/simple;
	bh=Siq5ns5xFuzM1glE8/VPCm6yhfDAULpw1aEzdGjRonI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rRPKa1BTfOtlnsBC/v3snJ15MbcneDQ1cxGW8stLuzzdskjTgMZARid//0ZlmJFRGzjLTi97mXbWqY568W5LCnNXMbZbFpwPkWZh29FQ4SkY6vxvvsIeeep5qI774H+YToRbOfETFDsAhP8mOTxsCDslQQHWvpCtMQrLlOetCio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4djSk42V24zJ467w;
	Fri,  2 Jan 2026 23:47:08 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 0750940569;
	Fri,  2 Jan 2026 23:48:04 +0800 (CST)
Received: from SecurePC-101-06.huawei.com (10.122.19.247) by
 dubpeml100005.china.huawei.com (7.214.146.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 2 Jan 2026 15:48:03 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Michael Tsirkin <mst@redhat.com>, <qemu-devel@nongnu.org>, Vinayak
 Holikatti <vinayak.kh@samsung.com>
CC: <linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>, Ravi Shankar
	<venkataravis@micron.com>
Subject: [PATCH qemu 1/2] hw/cxl: Check for overflow on santize media as both base and offset 64bit.
Date: Fri, 2 Jan 2026 15:47:30 +0000
Message-ID: <20260102154731.474859-2-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260102154731.474859-1-Jonathan.Cameron@huawei.com>
References: <20260102154731.474859-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml100005.china.huawei.com (7.214.146.113)

The both the size and base of a media sanitize operation are both provided
by the VM, an overflow is possible which may result in checks on valid
range passing when they should not.  Close that by checking for overflow
on the addition.

Fixes: 40ab4ed10775 ("hw/cxl/cxl-mailbox-utils: Media operations Sanitize and Write Zeros commands CXL r3.2(8.2.10.9.5.3)")
Closes: https://lore.kernel.org/qemu-devel/CAFEAcA8Rqop+ju0fuxN+0T57NBG+bep80z45f6pY0ci2fz_G3A@mail.gmail.com/
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/cxl/cxl-mailbox-utils.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index a64b8ba5351f..d8f62a13a8ec 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -2411,7 +2411,7 @@ static uint64_t get_dc_size(CXLType3Dev *ct3d, MemoryRegion **dc_mr)
 static int validate_dpa_addr(CXLType3Dev *ct3d, uint64_t dpa_addr,
                              size_t length)
 {
-    uint64_t vmr_size, pmr_size, dc_size;
+    uint64_t vmr_size, pmr_size, dc_size, dpa_end;
 
     if ((dpa_addr % CXL_CACHE_LINE_SIZE) ||
         (length % CXL_CACHE_LINE_SIZE)  ||
@@ -2423,7 +2423,12 @@ static int validate_dpa_addr(CXLType3Dev *ct3d, uint64_t dpa_addr,
     pmr_size = get_pmr_size(ct3d, NULL);
     dc_size = get_dc_size(ct3d, NULL);
 
-    if (dpa_addr + length > vmr_size + pmr_size + dc_size) {
+    /* sanitize 64 bit values coming from guest */
+    if (uadd64_overflow(dpa_addr, length, &dpa_end)) {
+        return -EINVAL;
+    }
+
+    if (dpa_end > vmr_size + pmr_size + dc_size) {
         return -EINVAL;
     }
 
-- 
2.48.1

