Received: from sgoci-sdnproxy-4.icoremail.net (sgoci-sdnproxy-4.icoremail.net [129.150.39.64])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D89BA29
	for <linux-cxl@vger.kernel.org>; Sun,  7 Apr 2024 08:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.150.39.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712479012; cv=none; b=BsqCpF3FG2+QTkcGK5X9DJI+euKy2/BuUDEBEEUpVT+lLmXJZlCjCZXS+BK3kJ0qeSR2fEeKP9UoII8QbSuuUobRxorlOtJE5ro4tPtNCde4BEJR+kRh21kQVG7ou33yCxI9vyKq/oTqxHBfbk8TGxGx4kYdUBZSVhCEAYfJRkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712479012; c=relaxed/simple;
	bh=ZAId9xzZme3/Rg8RbEAJu4beMN6nMb1fdL5b2LkcYG4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M6cyqvAfimjIRsClIhYFSsyYkG0bqZPjj75THzW9OcSbJsAykjKTTwynACsJlpo3g+8fphXvNevWUj/cbfKgFKWFFWHszr2zM3dpesJ9z1lvyUjuactqc8w99kbew5hKa/7jOm3LAmPY3PYn19S5rQISKJ+qJwZp6ueuBsFfe8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=129.150.39.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwDXiAkSWxJmyposCA--.35515S2;
	Sun, 07 Apr 2024 16:36:34 +0800 (CST)
Received: from phytium.com.cn (unknown [123.150.8.50])
	by mail (Coremail) with SMTP id AQAAfwB3r9QMWxJmQu8BAA--.2488S3;
	Sun, 07 Apr 2024 16:36:29 +0800 (CST)
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: peter.maydell@linaro.org,
	jonathan.cameron@huawei.com
Cc: qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org,
	chenbaozi@phytium.com.cn,
	Yuquan Wang <wangyuquan1236@phytium.com.cn>
Subject: [PATCH 0/1] qemu-options.hx: Fix typo for interleave-granularity of CFMW
Date: Sun,  7 Apr 2024 16:35:38 +0800
Message-Id: <20240407083539.1488172-1-wangyuquan1236@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwB3r9QMWxJmQu8BAA--.2488S3
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAIAWYRo98FIAAAsm
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU8nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

This patch fixes the unit typo of interleave-granularity of
CXL Fixed Memory Window in qemu-option.hx.

Yuquan Wang (1):
  qemu-options.hx: Fix typo for interleave-granularity of CFMW

 qemu-options.hx | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.34.1

