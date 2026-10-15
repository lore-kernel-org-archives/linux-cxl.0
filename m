Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3932C08BB;
	Thu, 15 Oct 2026 05:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792043489; cv=none; b=HW12zXuYmjf1uj3qtlvuAuKPSVaiywNiW+ji68NQg4stLfZqd5ttrZ0J9Bt336KsNmWZcpPLMaQwAgidaIQ/bZ2uk5rP3zFiNhZ7KwF8IrmiqFUbtULqu72HAvgZozk3Myhhy9639J34QMNchb1ssyBHZnFOsfiv9LbdIK6ZtLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792043489; c=relaxed/simple;
	bh=RPfLHOypHFNj683KtnHCEwwojO79vNekU/dPOOxt3F4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lgyjLEVJm0Yujr8Df0fO0eAPn2hN9/6HMddpu2fqKWtZ7HNF+fFOdOc8nDyFWutnduKk8QXFME87hhNp2yHFhzHSPxQWOnb0NV/gBR3LVKfnKwP0p+ouMph1FhSHXsCLLFcJUuCSz7GVMVeTa8RXvJHA9obV81RbxFcnjRxMbkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=semi.ac.cn; spf=pass smtp.mailfrom=semi.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=semi.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=semi.ac.cn
Received: from localhost.localdomain (unknown [159.226.228.16])
	by APP-03 (Coremail) with SMTP id rQCowAAnM0G7adBq5zfQCg--.15649S2;
	Thu, 15 Oct 2026 13:51:06 +0800 (CST)
From: Gaobin Huang <huanggaobin23@semi.ac.cn>
To: linux-cxl@vger.kernel.org
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Richard Cheng <icheng@nvidia.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] cxl/mbox: Add the CXL 4.0 command return codes 001Fh and 0020h
Date: Thu, 15 Oct 2026 13:50:48 +0800
Message-Id: <20261015055048.1765042-1-huanggaobin23@semi.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAAnM0G7adBq5zfQCg--.15649S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uFWrWF4xGFy3AF1kWr4DArb_yoW8JFyDpF
	WxWFyj9ry5G39Fv3y0y3yjgr98XF9IyrWUKa4ag390vFs8JFy7ZrZrtFy2ya45A3yfJFW5
	Kr4DJrZ09ayqkrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBKb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq
	07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r
	18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vI
	r41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67AK6r
	4rMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_
	Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x
	0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8
	JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIx
	AIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU5vNtDUUUUU=
	=
X-CM-SenderInfo: xkxd0wxjdruxrqstq2xhplhtffof0/1tbiBwEBDGrQUWFPzQAAsD

CMD_CMD_RC_TABLE ends at 001Eh (Invalid Extent List), but the command
return code table in CXL r4.0 Table 8-208 also defines:

  001Fh  Transfer Out of Order: The input parameters data transfer was
         aborted because it occurred out of order.
  0020h  Request Abort Not Supported by Background Operation: The ongoing
         background operation does not support the Request Abort command.

A device that reports either code is described as an unknown return code.
Add both entries, mapped to -ENXIO.

Signed-off-by: Gaobin Huang <huanggaobin23@semi.ac.cn>
---
 drivers/cxl/cxlmem.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index c401e3a1a..43f29564c 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -190,6 +190,8 @@ static inline struct cxl_ep *cxl_ep_load(struct cxl_port *port,
 	C(FEATURETRANSFEROOO, -ENXIO, "feature transfer out of order"),		\
 	C(RESOURCEEXHAUSTED, -ENXIO, "resources are exhausted"),		\
 	C(EXTLIST, -ENXIO, "invalid Extent List"),				\
+	C(TRANSFEROOO, -ENXIO, "transfer out of order"),			\
+	C(REQABORTNOTSUP, -ENXIO, "request abort not supported"),		\
 
 #undef C
 #define C(a, b, c) CXL_MBOX_CMD_RC_##a

base-commit: 999811aca000b0d3d1c838c60dc9db7c72eb0c73
-- 
2.34.1

