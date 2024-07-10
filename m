Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB031803D;
	Wed, 10 Jul 2024 02:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720578707; cv=none; b=GZE55l2S2O09PIXd5n8obqKxnOLxdf8BbIYZphr0dlICj3W/iGJbAZ/Kao5qGCBg5gE86vu92+baP0yWmmKRBhbWK3Hy/GzZjY1XrrCs0aqcLUIs1dqkYaSnZ6+0qyZFqi8EepBg3t/ZSwHkh6vFFIqhQ6uhvgWIqZ9vvKjxRZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720578707; c=relaxed/simple;
	bh=VfASIcXgp6WP1IkMElURGKvL9Z0Ezt72D6Iw28GRsnA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pGmnT4HClr4FIWfXsr7QnBMCWsOCNxxsaPyjB41Y9fWO+RAljmH1v0VWyXsnaMoq9boopcmDQyLbIP0CieLD3eAGUJC1UtKwK69wqYtG1lpWiFq2dcJpY5CaHLUuZjhNaU9cI6kPmR6FyLrwTgOccw0yCAxKsp+bXEYjanjXuvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buaa.edu.cn; spf=pass smtp.mailfrom=buaa.edu.cn; dkim=pass (1024-bit key) header.d=buaa.edu.cn header.i=@buaa.edu.cn header.b=sfPl+Hon; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buaa.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buaa.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=buaa.edu.cn header.i=@buaa.edu.cn header.b="sfPl+Hon"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=buaa.edu.cn; s=buaa; h=Received:From:To:Cc:Subject:Date:
	Message-ID:MIME-Version:Content-Transfer-Encoding; bh=GxeGh6VsVK
	wOay+/N1Y08QePwQlg5NH+QbtG0//gEQg=; b=sfPl+HonHxlY6nHUSWYobPQFxv
	8H4CQ3Z/OSoJXuhRcd0s+EJYwO2tlqfPS88+jWWLAADgtTtdgesnRnuF9ihKJVNv
	zSIMRrjBSUMS1z1cwtQCrmB9qydhax5WOtapM06uiqBiQYnC1P7t8i9saEaWJwU1
	ihKRXjSEf6EuvwZjU=
Received: from gp-VMware-Virtual-Platform.localdomain (unknown [139.227.253.190])
	by coremail-app2 (Coremail) with SMTP id Nyz+CgCX7_J+8o1my0+rAA--.270S2;
	Wed, 10 Jul 2024 10:31:28 +0800 (CST)
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
Subject: [PATCH v3] cxl/core: Support mbox op clear log of vendor debug logs
Date: Wed, 10 Jul 2024 10:31:12 +0800
Message-ID: <20240710023112.8063-1-engguopeng@buaa.edu.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Nyz+CgCX7_J+8o1my0+rAA--.270S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tr4xCr18Kr13Jr1fZrW8WFg_yoW8WrWkpF
	WYga4jvFZxWa4UKwn2va48WFWruasakry5G3ZFvrW0vwsxZa10qry5tay7XFyFvryrAa4U
	tr4kKr15G3W0y3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvm1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
	z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcV
	Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j
	6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28I
	cxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Aw1UJr1UMxC20s026xCaFVCjc4AY6r1j6r
	4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
	67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
	x0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
	z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
	UI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: d2isijirrujqpexdthxhgxhubq/

When user send a mbox cmd whose opcode is CXL_MBOX_OP_CLEAR_LOG and
the in_payload is normal vendor debug log UUID according to
the CXL specification
cxl_payload_from_user_allowed() will return false unexpectedly,
Sending mobox cmd operation failed and the kernel log will print:
Clear Log: input payload not allowed.

All CXL devices that support a debug log shall support the Vendor Debug
Log to allow the log to be accessed through a common host driver, for any
device, all versions of the CXL specification define the same value with
Log Identifier of: 5e1819d9-11a9-400c-811f-d60719403d86

refer to:
CXL spec r2.0 Table 169
CXL spec r3.0 Table 8-62
CXL spec r3.1 Table 8-71

Fix the definition value of DEFINE_CXL_VENDOR_DEBUG_UUID to match the
CXL r3.1 specification.

Fixes: 472b1ce6e9d6 ("cxl/mem: Enable commands via CEL")
Signed-off-by: peng guo <engguopeng@buaa.edu.cn>
---
v2 -> v3: Add a description of the impact of this issue on user usage
          Modify the fixes tag
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

