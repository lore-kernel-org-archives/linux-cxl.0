Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6832AD2C
	for <linux-cxl@vger.kernel.org>; Mon, 19 Aug 2024 15:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.46.229.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724080468; cv=none; b=SfW4rd9Tb5ioNDIHhiGE/COAVd1jT1kV8ieW6TD15pNI5W9rWh96+Mr2Oh+GZDg5UQKXuME5+gXACpQQWTLGZJbkGNuwIQ+v9dL/tIVX5WSZSsWwEqotBaSx5JM3L7uOySkqQ4C/2to5hEY8mTIfF6p6+A8koz+S1cJHguGWnt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724080468; c=relaxed/simple;
	bh=JjRjkElxX2jbaVSA3zKXD/sEgF9cOLRlLxxx8RqsdzA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VwWukTaiZIKXaZBpnDmRonY4y9kmPZTigbmzqFcW+VvUhuvghPqS6DPOV9V3Y7tP0K4Oml8VxYthzPJxiYhoKNp04aX4XMPRQnIN3k4kzOafHVvwV2/kjqUw0VJMzYLA/5G3jDB1PbIqAPyN2SuTOr0HVRj3SocFc/am3iVVqro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buaa.edu.cn; spf=pass smtp.mailfrom=buaa.edu.cn; dkim=pass (1024-bit key) header.d=buaa.edu.cn header.i=@buaa.edu.cn header.b=lME90Yzx; arc=none smtp.client-ip=207.46.229.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buaa.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buaa.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=buaa.edu.cn header.i=@buaa.edu.cn header.b="lME90Yzx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=buaa.edu.cn; s=buaa; h=Received:From:To:Cc:Subject:Date:
	Message-ID:MIME-Version:Content-Transfer-Encoding; bh=UaP8XcFBSn
	E6MKeWDOBuxvjgVuv/I2VRLDz9dOUEKwc=; b=lME90Yzx29/BQo8r4re58bWHWO
	jx5x7TMlHwwb2JE1OjgGibfYvYV2vvHsve9s1DRo8fzvukCaS1nXmJF7bpLLI5UT
	rGrLT8TymZutTqO++58mDLS4MIXQ7nbY/+KaMCCkUgIZFfsiyS+jVLcBIDLc2blT
	eSbczkCFg2WUwaiBA=
Received: from gp-VMware-Virtual-Platform.localdomain (unknown [139.227.253.185])
	by coremail-app2 (Coremail) with SMTP id Nyz+CgAnGCRYYMNm9XTXAA--.49996S2;
	Mon, 19 Aug 2024 23:10:18 +0800 (CST)
From: peng guo <engguopeng@buaa.edu.cn>
To: jonathan.cameron@huawei.com
Cc: fan.ni@samsung.com,
	linux-cxl@vger.kernel.org,
	peng guo <engguopeng@buaa.edu.cn>
Subject: [PATCH] fix physical address field in get scan media results output
Date: Mon, 19 Aug 2024 23:10:11 +0800
Message-ID: <20240819151012.16202-1-engguopeng@buaa.edu.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Nyz+CgAnGCRYYMNm9XTXAA--.49996S2
X-Coremail-Antispam: 1UD129KBjvJXoWrZF4xKw1xJw4rJr4fuFyrtFb_yoW8Jr47pr
	45KrsIvayrZ347XrsrX3y0g3WDWrZxGF9xu3y3uryYyr1kJFWDXFy5Ka1F9w45Xa4rJay8
	ZrnYgryUJan8ZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkF1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E
	87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
	8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
	Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxF
	aVAv8VW7tr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGw
	C20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48J
	MIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMI
	IF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
	87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
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

