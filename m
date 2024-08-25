Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0AF13A89A
	for <linux-cxl@vger.kernel.org>; Sun, 25 Aug 2024 10:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.46.229.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724581365; cv=none; b=uu/5rYWk/G4aepBvR/waQvjPVU+zxGn8tcOTuIEu6MGmtY8gYXWEXLa8EBdGYA13Q8DRdDC/oK1sarDFKJfkJsEnzjRf9XlYyXMrtlnDXvbYqxDUErVW3fm9zXf+jyQ1Jp7n4HO0c4sxuwL9KUGhXwB0KtJu4SHC/2burSy0/hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724581365; c=relaxed/simple;
	bh=2DQG51DiteoO0MVKpITEv1Y2FLKIJnTiOcxL9qybrm0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ieKUs18Oe2LDyeO0vgf/37+CnFyyQ9Zt8xxxDSEMR4+aqcsfPrt/kIuE6qzqIA5O1lxyqyf9zhefiJXOGM/MMHYCLNA6ikLQJy9O7RKdRWZFZcCFLU8zO+U3VdLn8LDOaGFt/4HJBEftpcjhIJ0S7GFFZJtRf1VgUjW6h9mvfuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buaa.edu.cn; spf=pass smtp.mailfrom=buaa.edu.cn; dkim=pass (1024-bit key) header.d=buaa.edu.cn header.i=@buaa.edu.cn header.b=GDWBQRny; arc=none smtp.client-ip=207.46.229.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buaa.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buaa.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=buaa.edu.cn header.i=@buaa.edu.cn header.b="GDWBQRny"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=buaa.edu.cn; s=buaa; h=Received:From:To:Cc:Subject:Date:
	Message-ID:MIME-Version:Content-Transfer-Encoding; bh=Ughe4HkEcC
	tqRyRZ7fpO9i+fyOFkw7Jk4xY6EMQZZdo=; b=GDWBQRny6pY+74Kl6wNQvDoVN9
	vniPzxtXWAWNEcPn9irm0Griswry4jq3uSVCtv2E9wtwizyi11M73t/2HMQtGFOk
	9fgw/QxhWsxoA/pFFBK3j8TjZ+HQFVZj5HwBZDCZLqp+SrwbuE+pW56CUv/uG0BM
	GRBcYb9OT4d7hDZd8=
Received: from gp-VMware-Virtual-Platform.localdomain (unknown [139.227.253.185])
	by coremail-app2 (Coremail) with SMTP id Nyz+CgCnmibVBctmh4yDAQ--.6641S2;
	Sun, 25 Aug 2024 18:22:15 +0800 (CST)
From: peng guo <engguopeng@buaa.edu.cn>
To: jonathan.cameron@huawei.com,
	fan.ni@samsung.com
Cc: mst@redhat.com,
	qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org,
	peng guo <engguopeng@buaa.edu.cn>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3] hw/cxl: fix physical address field in get scan media results output
Date: Sun, 25 Aug 2024 18:22:12 +0800
Message-ID: <20240825102212.3871-1-engguopeng@buaa.edu.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Nyz+CgCnmibVBctmh4yDAQ--.6641S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WF48AFWDCw48WFW5WrW7Jwb_yoW8XrWDpr
	4DKrnIvayrA347XrsrXa40ga4UWrZxWry3u39xu34jvr97ZFWUXFy5Ka1F9r45X3s5tay8
	ArnY9ryUKan8Z3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

When using the mailbox command get scan media results, the scan media 
restart physical address field in the ouput palyload is not 64-byte 
aligned.

This patch removed the error source of the restart physical address. 

The Scan Media Restart Physical Address is the location from which the 
host should restart the Scan Media operation. [5:0] bits are reserved.
Refer to CXL spec r3.1 Table 8-146

Fixes: 89b5cfcc31e6 ("hw/cxl: Add get scan media results cmd support")
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Link: https://lore.kernel.org/linux-cxl/20240819154206.16456-1-engguopeng@buaa.edu.cn/
Signed-off-by: peng guo <engguopeng@buaa.edu.cn>
---
v2 -> v3: 
-- Resend +CC qemu-devel list and Michael Tsirkin.

v1 -> v2: 
-- Add module name to title.
---
 hw/cxl/cxl-mailbox-utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 3ebbd32e1028..9258e48f95ee 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -2076,7 +2076,7 @@ static CXLRetCode cmd_media_get_scan_media_results(const struct cxl_cmd *cmd,
 
         start = ROUND_DOWN(ent->start, 64ull);
         stop = ROUND_DOWN(ent->start, 64ull) + ent->length;
-        stq_le_p(&out->records[i].addr, start | (ent->type & 0x7));
+        stq_le_p(&out->records[i].addr, start);
         stl_le_p(&out->records[i].length, (stop - start) / CXL_CACHE_LINE_SIZE);
         i++;
 
-- 
2.43.0

