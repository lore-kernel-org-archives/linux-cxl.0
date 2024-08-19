Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [20.231.56.155])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC5F1684A0
	for <linux-cxl@vger.kernel.org>; Mon, 19 Aug 2024 12:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=20.231.56.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724069151; cv=none; b=RW3ieMWCqf2bj3Z2l6xvxBaUjtJiJFIrZqFqgWjmNw6zg/U7/csVpcTy83N20RIW+Zc3R0kqUZnOUyrP1y8+//koUA+tCWHWLuLh8FLOb4wu8TYFkCLmZnJosFoJI+tANhATnfe3Au9/5PSVA+Y06+CxzFutby3nmVflbrPgdUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724069151; c=relaxed/simple;
	bh=z7+BcBjeTH3ZFXmYxbOllsb/Gc7WFQVUfKiRI0iCbNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PDgk539p0RdnYdhcOng73TFmlRghV6As3xiOijbJjj70vspjOK9uoztJeuTaMs6sS9Ks3wG3JwnbKeYVsJN6uD53I6DZhbFtXCI2+1jryMzhfg9yBlECfonYAF21jYSeYjD6xGY+OhADQMLwqrpPlbTU545QzWZBqDLPda5w9uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buaa.edu.cn; spf=pass smtp.mailfrom=buaa.edu.cn; dkim=pass (1024-bit key) header.d=buaa.edu.cn header.i=@buaa.edu.cn header.b=SuifMVTC; arc=none smtp.client-ip=20.231.56.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buaa.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buaa.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=buaa.edu.cn header.i=@buaa.edu.cn header.b="SuifMVTC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=buaa.edu.cn; s=buaa; h=Received:From:To:Cc:Subject:Date:
	Message-ID:MIME-Version:Content-Transfer-Encoding; bh=9htQEcGgtX
	BKncCWxYjlaMi2Glm0tDq8jlPledI32M0=; b=SuifMVTCU0cIwcvBw45dZcv3Og
	7zzC4tC7t/J9CeqdrmaG6i/HQJ0W6/Cd2LtQh09fImel8u7T9n0FPN1pRfeaLP2h
	CPUg/rgMHC9kQCMKpH+YNiG6r3P8AHs2drEkG0TSEFqmaB/tWCojQVAaRF2AvZbg
	vvyOG7lpMUesO5R2g=
Received: from gp-VMware-Virtual-Platform.localdomain (unknown [139.227.253.185])
	by coremail-app2 (Coremail) with SMTP id Nyz+CgC3pyOHNMNmFUjUAA--.46772S2;
	Mon, 19 Aug 2024 20:03:21 +0800 (CST)
From: peng guo <engguopeng@buaa.edu.cn>
To: jonathan.cameron@huawei.com
Cc: fan.ni@samsung.com,
	linux-cxl@vger.kernel.org,
	peng guo <engguopeng@buaa.edu.cn>
Subject: [RESEND] hw/cxl: fix the determination of illegal physical addresses
Date: Mon, 19 Aug 2024 20:03:17 +0800
Message-ID: <20240819120317.12505-1-engguopeng@buaa.edu.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Nyz+CgC3pyOHNMNmFUjUAA--.46772S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw4fCFWUKr4xtr1fKF4kJFb_yoW8WF18pr
	s3Kr4Sqr1Fkay7ZFs2y395Xw4UCrWxKFZ2krWv9wn8Gr90gr45ZF13KayI93s8J34rta4r
	ZF4jgrWDCa1jvF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkY1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2
	jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52
	x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWU
	GwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv
	6cx26F1DJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI
	8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41l
	IxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIx
	AIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
	jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: d2isijirrujqpexdthxhgxhubq/

When physical address range in the input payload of scan media command
exceeds static_mem_size but does not exceed the sum of static and dynamic
memory, the scan media mailbox command unexpectedly returns an error code
which is CXL_MBOX_INVALID_PA.

This patch determines whether the physical address is valid in two cases. 
If dynamic memory exists, check whether the address range of the request 
exceeds the range of static memory and dynamic memory.If dynamic memory 
does not exist, then check whether the address range of the request 
exceeds the static memory size.

Fixes: d61cc5b6a8d3 ("hw/cxl: Add get scan media capabilities cmd support")
Signed-off-by: peng guo <engguopeng@buaa.edu.cn>
---
 hw/cxl/cxl-mailbox-utils.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 3ebbd32e10..b23c6b9b0b 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1943,11 +1943,12 @@ static CXLRetCode cmd_media_scan_media(const struct cxl_cmd *cmd,
     }
     query_length = ldq_le_p(&in->length) * CXL_CACHE_LINE_SIZE;
 
-    if (query_start + query_length > cxl_dstate->static_mem_size) {
-        return CXL_MBOX_INVALID_PA;
-    }
-    if (ct3d->dc.num_regions && query_start + query_length >=
+    if (ct3d->dc.num_regions) {
+        if (query_start + query_length >=
             cxl_dstate->static_mem_size + ct3d->dc.total_capacity) {
+                return CXL_MBOX_INVALID_PA;
+            }
+    } else if (query_start + query_length > cxl_dstate->static_mem_size) {
         return CXL_MBOX_INVALID_PA;
     }
 
-- 
2.43.0

