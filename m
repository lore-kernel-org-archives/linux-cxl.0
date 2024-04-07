Received: from sgoci-sdnproxy-4.icoremail.net (sgoci-sdnproxy-4.icoremail.net [129.150.39.64])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A291879
	for <linux-cxl@vger.kernel.org>; Sun,  7 Apr 2024 08:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.150.39.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712479015; cv=none; b=bHqIPoHQ2BWsAjyZSg14cQxZkQ+uEb4aRSgKwBEhhfKVPuvTDTIXjh4wuBaoNJSRKuYsUwnvilc7yRxdyt42bIlZFGXHw8rftYwCepHDL34Ir+6Er/1qTHb/vK7lpg3TWOMtQ3eczzBPHDaI+/NdxKabRWeOhN2/UDdWI01r2Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712479015; c=relaxed/simple;
	bh=7lvdPos42N1QC7AuxlZsocCjvy1atlkzwR3J68Jw2aU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Sn6Qd22FrS3w2y/wT/n4u1oJ+jJt4cy4SMG//q9f81EE9u5zZc2zAqiYAP942Lmk6M7tbiXbQTMUJUqO45fu0o59sgs3JD9T7tk23JfhzgCqQG5oYV52dIQ/zIXP23ISLogfeCfaP34dri6p4ioN9tAKKrWQmjIJvzaEzZ/jeCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=129.150.39.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwCXnwsYWxJmYJssCA--.30372S2;
	Sun, 07 Apr 2024 16:36:40 +0800 (CST)
Received: from phytium.com.cn (unknown [123.150.8.50])
	by mail (Coremail) with SMTP id AQAAfwB3r9QMWxJmQu8BAA--.2488S4;
	Sun, 07 Apr 2024 16:36:34 +0800 (CST)
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: peter.maydell@linaro.org,
	jonathan.cameron@huawei.com
Cc: qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org,
	chenbaozi@phytium.com.cn,
	Yuquan Wang <wangyuquan1236@phytium.com.cn>
Subject: [PATCH 1/1] qemu-options.hx: Fix typo for interleave-granularity of CFMW
Date: Sun,  7 Apr 2024 16:35:39 +0800
Message-Id: <20240407083539.1488172-2-wangyuquan1236@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240407083539.1488172-1-wangyuquan1236@phytium.com.cn>
References: <20240407083539.1488172-1-wangyuquan1236@phytium.com.cn>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwB3r9QMWxJmQu8BAA--.2488S4
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAIAWYRo98FIgAAsk
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvdXoWrKw45Kw1xWF4rtr48tF4UXFb_yoWkGFg_WF
	95JwsYqrWxZa4UG3WIvanrJr98X34rGwn7Wa1jqayqkr4rXw45JryvgFyxWrnxWa18Ar1S
	krnrXwn5C34xZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrnU
	Uv73VFW2AGmfu7jjvjm3AaLaJ3UjIYCTnIWjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRUUUUU
	UUUU=

This patch fixes the unit typo of interleave-granularity of
CXL Fixed Memory Window in qemu-option.hx.

Signed-off-by: Yuquan Wang wangyuquan1236@phytium.com.cn
---
 qemu-options.hx | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 7fd1713fa8..e1b272d51a 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -151,14 +151,14 @@ SRST
         platform and configuration dependent.
 
         ``interleave-granularity=granularity`` sets the granularity of
-        interleave. Default 256KiB. Only 256KiB, 512KiB, 1024KiB, 2048KiB
-        4096KiB, 8192KiB and 16384KiB granularities supported.
+        interleave. Default 256(bytes). Only 256, 512, 1k, 2k
+        4k, 8k and 16k granularities supported.
 
         Example:
 
         ::
 
-            -machine cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.targets.1=cxl.1,cxl-fmw.0.size=128G,cxl-fmw.0.interleave-granularity=512k
+            -machine cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.targets.1=cxl.1,cxl-fmw.0.size=128G,cxl-fmw.0.interleave-granularity=512
 ERST
 
 DEF("M", HAS_ARG, QEMU_OPTION_M,
-- 
2.34.1

