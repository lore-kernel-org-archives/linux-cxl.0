Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [20.231.56.155])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6434964D
	for <linux-cxl@vger.kernel.org>; Mon, 19 Aug 2024 15:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=20.231.56.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724082391; cv=none; b=dQUECS0dB+gZMjD6gxaE+OMhj4R1K5AhGl+zae27Y/6w+f/nWbYU9v4eP3dNVHxvZXzilhGVsMAW5j8PNHZQiY5cq8iZFbx4gPB5mjpa1RllRt6hy+f38ww5+vq8qqUhZSwaGn9hMecEtrkEcsygJQFDsaJa+8JS0hi75jnv04c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724082391; c=relaxed/simple;
	bh=M4GuemEQW2lRKp2dzGLDOT4mI/lwvoQIWr9yr785cRA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mo0gyFEXh8EpK7QrG1vzCXidZts63rh3LlJOvDPpfgSYUxJv+1bQPSpMg9FVgLah4EfbCdvk+zaM+6VfsddiOMcfLx1xN3m4L2ab9XhrswpXRhIvUIQ1qmliUtKlB+9MV8/ghQ7AcuhtDUklZCtHwR4jzcPmCFOsFAhzQlNYppc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buaa.edu.cn; spf=pass smtp.mailfrom=buaa.edu.cn; dkim=pass (1024-bit key) header.d=buaa.edu.cn header.i=@buaa.edu.cn header.b=mA3O3CT6; arc=none smtp.client-ip=20.231.56.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buaa.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buaa.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=buaa.edu.cn header.i=@buaa.edu.cn header.b="mA3O3CT6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=buaa.edu.cn; s=buaa; h=Received:From:To:Cc:Subject:Date:
	Message-ID:MIME-Version:Content-Transfer-Encoding; bh=eHCzLVijvZ
	VS8xfMwSX7R/aoRgmljFgeLKrSemIizjY=; b=mA3O3CT6F4uyqgb9Wsq2kgZAOW
	qlkgMvyqBlESsg51kkDhtS+7r06Qzmt7F0LbtYCJ7Di3K+rDkQLnnitR/n/XaU8M
	TEZpEy5OIyEjJI85FJ0G45nhtBWn0LndtPLmK5SomyHWX3F3mcYhBIf8yVo+N/4B
	2z6Fc0V+d73HC5Z2I=
Received: from gp-VMware-Virtual-Platform.localdomain (unknown [139.227.253.185])
	by coremail-app2 (Coremail) with SMTP id Nyz+CgCHeSXQZ8Nmcv_XAA--.59236S2;
	Mon, 19 Aug 2024 23:42:10 +0800 (CST)
From: peng guo <engguopeng@buaa.edu.cn>
To: jonathan.cameron@huawei.com
Cc: fan.ni@samsung.com,
	linux-cxl@vger.kernel.org,
	peng guo <engguopeng@buaa.edu.cn>
Subject: [PATCH v2] hw/cxl: fix physical address field in get scan media results output
Date: Mon, 19 Aug 2024 23:42:06 +0800
Message-ID: <20240819154206.16456-1-engguopeng@buaa.edu.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Nyz+CgCHeSXQZ8Nmcv_XAA--.59236S2
X-Coremail-Antispam: 1UD129KBjvJXoWrZF4xKw1xJw4rJr4fuFyrtFb_yoW8JF18pr
	45KrnIvayrJ347XrsrX340g3WDWrZxGr9xuwsxuryjyr1kJF4UXFy5Ka1F9w45Xa4rJay8
	ArnY9ryUJan8ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkF1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
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
	jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: d2isijirrujqpexdthxhgxhubq/

When using the mailbox command get scan media results, the scan media 
restart physical address field in the ouput palyload is not 64-byte 
aligned.

This patch removed the error source of the restart physical address. 

The Scan Media Restart Physical Address is the location from which the 
host should restart the Scan Media operation. [5:0] bits are reserved.
Refer to CXL spec r3.1 Table 8-146

Fixes: 89b5cfcc31e6 ("hw/cxl: Add get scan media results cmd support")
Signed-off-by: peng guo <engguopeng@buaa.edu.cn>
---
v1 -> v2: Add module name to title

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

