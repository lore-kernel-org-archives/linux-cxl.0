Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [20.231.56.155])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A7B257D;
	Tue,  9 Jul 2024 14:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=20.231.56.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720534382; cv=none; b=fonzTF7mLb+vrnLBrjVwb06oWJsp7anuaB4g5AYcWzCcxMB3Zv8uq+6mN/TTTKDV6aoD40N4mMa9kyFEmElu1yyu8CDIaci5a/CHfmRSFACM7H0EJ1sQGsX7BY/B/lqlFBR9ASZWEk1mKZintxKH+YqzSEJktlA9j5mhdvOBFzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720534382; c=relaxed/simple;
	bh=REUN238YloUXsB58VaHbrHn7J9PWVHNTx9d72CTCeCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NinLdiIfc0Nk6fozII/sTZYfeHZXO4yWYIE14iZpJKSPN/UqhqDA5S47AWhNXVre/R3H+TNcg+EtsZLCIDd1qkhk6/kauS0drlU/zXy+C0U5sYrAF9+F2WVzwSGYRUOIWLl1XX8k8RvotxYBhZ4WDyer2IvcMF85YBsoy2E7Vt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buaa.edu.cn; spf=pass smtp.mailfrom=buaa.edu.cn; dkim=pass (1024-bit key) header.d=buaa.edu.cn header.i=@buaa.edu.cn header.b=elFsQjvD; arc=none smtp.client-ip=20.231.56.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buaa.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buaa.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=buaa.edu.cn header.i=@buaa.edu.cn header.b="elFsQjvD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=buaa.edu.cn; s=buaa; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=fY/ybTvHed6MNaKpWv3DmQPhPOmMZSa+Cv
	/Avwj2tGQ=; b=elFsQjvD50wAQ07Ua4n2XyiNmqvn6htCrVw/GzU31aS8hCtzUR
	yA3KgA0Izj8mB3FYP2c+DcQDNFTv2L/+7JXIFwMK/6Y02mCwMsq8xHokgIrCgKsF
	tqo+U8TROFhX2H+xkbDnBrLZNDM3yNZ6HkuEWIharia99Amghzwq/eVME=
Received: from gp-VMware-Virtual-Platform.localdomain (unknown [139.227.253.190])
	by coremail-app2 (Coremail) with SMTP id Nyz+CgBHovVZRY1m2YGkAA--.53442S2;
	Tue, 09 Jul 2024 22:12:42 +0800 (CST)
From: peng guo <engguopeng@buaa.edu.cn>
To: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wyguopeng@163.com,
	peng guo <engguopeng@buaa.edu.cn>
Subject: [PATCH v2] cxl/core: Fix the UUID of CXL vendor debug Log identifier
Date: Tue,  9 Jul 2024 22:12:39 +0800
Message-ID: <20240709141239.10737-1-engguopeng@buaa.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <045fb08e-6d18-4558-b7b2-b83c412307da@intel.com>
References: <045fb08e-6d18-4558-b7b2-b83c412307da@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Nyz+CgBHovVZRY1m2YGkAA--.53442S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Xr1UtrW7JryUXrWUXryxKrg_yoW8JF4UpF
	WrKFy0yFZ5Wa47twn2q348WFWruasakryUC3ZF9w48Za93Z3W0qry5KayUJF90vr95J3Wj
	qr4vkr15Ga10kw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvq1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2
	jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52
	x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWU
	GwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY
	0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26F1DJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
	C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
	wI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
	v20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
	jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0x
	ZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: d2isijirrujqpexdthxhgxhubq/

Fix the definition value of DEFINE_CXL_VENDOR_DEBUG_UUID to match the
CXL r3.1 specification, although this value is not currently used.

All CXL devices that support a debug log shall support the Vendor Debug
Log to allow the log to be accessed through a common host driver, for any
device, all versions of the CXL specification define the same value with
Log Identifier of: 5e1819d9-11a9-400c-811f-d60719403d86

refer to:
CXL spec r2.0 Table 169
CXL spec r3.0 Table 8-62
CXL spec r3.1 Table 8-71

Fixes: 49be6dd80751 ("cxl/mbox: Move command definitions to common location")
Signed-off-by: peng guo <engguopeng@buaa.edu.cn>
---
 v1 -> v2: update commit message  and addressed review comments

 drivers/cxl/cxlmem.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index af8169ccdbc0..feb1106559d2 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -563,7 +563,7 @@ enum cxl_opcode {
 		  0x3b, 0x3f, 0x17)
 
 #define DEFINE_CXL_VENDOR_DEBUG_UUID                                           \
-	UUID_INIT(0xe1819d9, 0x11a9, 0x400c, 0x81, 0x1f, 0xd6, 0x07, 0x19,     \
+	UUID_INIT(0x5e1819d9, 0x11a9, 0x400c, 0x81, 0x1f, 0xd6, 0x07, 0x19,     \
 		  0x40, 0x3d, 0x86)
 
 struct cxl_mbox_get_supported_logs {
-- 
2.43.0

