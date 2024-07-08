Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED49142E80;
	Mon,  8 Jul 2024 15:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720452571; cv=none; b=rF3B97KaFtUIuGqyhhe5JkKEr897wXl2BMiAD0DTg9/JqSDRdTmVks6udxka1f7ZvEfnl/fZ+jSwIToz21OboFR7G+Uq6eb1lc+mW4JXntQx9udiidEAFJTUM1iFoOsDSKjlyPdLGcZdCpMzpb95CpAS696WPfLPKdp9ePhdWX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720452571; c=relaxed/simple;
	bh=pHGrU06dDgIohfOZNyTOXRGFIfPJGLhM05zDRXQwlIA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ABwqTDGga2U8aIBMS9VoUC2/DsSYHqHK7ucekrAHld9XZiTL2vhWZlmCaWADTSJ2ZylFh+IQYlqZzlcXqOG7viunLqrb32k4STw9n/PJfXvGWeb4OUXXuW1teKjYpDhXUP6Apr6vXQUkg1VsUaDzgc/Cv16B3b6CbTLFQZbh71I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buaa.edu.cn; spf=pass smtp.mailfrom=buaa.edu.cn; dkim=pass (1024-bit key) header.d=buaa.edu.cn header.i=@buaa.edu.cn header.b=KU5FpEh8; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buaa.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buaa.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=buaa.edu.cn header.i=@buaa.edu.cn header.b="KU5FpEh8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=buaa.edu.cn; s=buaa; h=Received:From:To:Cc:Subject:Date:
	Message-ID:MIME-Version:Content-Transfer-Encoding; bh=jpG9/lUJIA
	huGAbBRSauqWsUisuORJ+1OpZD4Zt02hY=; b=KU5FpEh8pSwVYDeS0VgumKDCGA
	FxgPTXY0PVxaILalUASm/BRhtyLBT/H7Jwc30mK0MXkoJeHeueR4TqYf4H3WXTKd
	P5/nlgik4La5rxsQP9xidv3mtSamvCZe1b/tFnvJnbbtu6ZwEYxVgtqnsKmXkDTT
	W1jc71x0WrPQh4MJw=
Received: from gp-VMware-Virtual-Platform.localdomain (unknown [139.227.253.190])
	by coremail-app2 (Coremail) with SMTP id Nyz+CgD3UfXABYxmOvOYAA--.32315S2;
	Mon, 08 Jul 2024 23:29:18 +0800 (CST)
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
Subject: [PATCH] cxl core:wrong value of macro definition
Date: Mon,  8 Jul 2024 23:29:02 +0800
Message-ID: <20240708152902.5853-1-engguopeng@buaa.edu.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Nyz+CgD3UfXABYxmOvOYAA--.32315S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xw4DZFWxZr4kKF4fury8Zrb_yoW3Wrg_Gr
	1rWrZxZa1FvF9rKFnIgr4rC3yS9a1kXr1FvFn5Kr4akayakrs8Wry09r47ZrW2vrW8tr1D
	J34DJr18tr47tjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbakFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
	wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
	vE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2
	jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52
	x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWU
	XwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY02Avz4vE
	14v_XrWl42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW7tr1UJr1l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjfU5Q6JUUUUU
X-CM-SenderInfo: d2isijirrujqpexdthxhgxhubq/

The first value of the macro definition DEFINE_CXL_VENDOR_DEBUG_UUID
does not match the definition in the CXL 2.0 specification table 170.

Signed-off-by: peng guo <engguopeng@buaa.edu.cn>
---
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

