Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net (zg8tmja5ljk3lje4ms43mwaa.icoremail.net [209.97.181.73])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ABC719CC14;
	Fri, 13 Feb 2026 06:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.181.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770962650; cv=none; b=LAn60x7coktN/G4KspR7+HV1e9BRdbtQc4f1vV9exmvKwkX2ESaZpkGwVrayF+52NLswmS8XJDUR6GsPJRYi+xZXwVeLOs08B/stSpCamt3jsWW6Pi6Y0WPrFBdzJB2DELKZy7rAoejiVrtp3wS6KgGshZqq7eU4z5cw+C+v/uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770962650; c=relaxed/simple;
	bh=LcfB9C2cJQllXs2RhviVjjwhtsUdvU69/itZZqTT8UA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZO8d/X8us+qXVzRTDeLPtW7d9pIQAzr4fHDA+wi4rTy4xfakb1NWKghdoOYP90Njsr/6n6kzyzN0vyEPZAG3OY/TWWSyQl/evE7pqpERM1S4ZzjmFbAnVkg6eI/GDk+T2x2h2f7xlVeMmhxaR4S8f/soHGEtlcQl9n18H9z//Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=209.97.181.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwB3kqjMvo5ptsgZBw--.1469S2;
	Fri, 13 Feb 2026 14:03:56 +0800 (CST)
Received: from localhost.localdomain (unknown [218.76.62.144])
	by mail (Coremail) with SMTP id AQAAfwAHXuvEvo5pWw0bAA--.32545S2;
	Fri, 13 Feb 2026 14:03:48 +0800 (CST)
From: Cui Chao <cuichao1753@phytium.com.cn>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Mike Rapoport <rppt@kernel.org>,
	Wang Yinfeng <wangyinfeng@phytium.com.cn>,
	dan.j.williams@intel.com,
	Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>,
	Gregory Price <gourry@gourry.net>,
	David Hildenbrand <david@kernel.org>,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	qemu-devel@nongnu.org
Subject: [PATCH v4 0/1] Identify the accurate NUMA ID of CFMW
Date: Fri, 13 Feb 2026 14:03:46 +0800
Message-Id: <20260213060347.2389818-1-cuichao1753@phytium.com.cn>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwAHXuvEvo5pWw0bAA--.32545S2
X-CM-SenderInfo: pfxlux1drrlkut6sx5pwlxzhxfrphubq/1tbiAQAFAGmONAkAtAADsp
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=cuichao175
	3@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU8nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

Changes in v4:
- Condensed the impact description in changelog.
- Added Gregory's Reviewed-by tag.
- Added Dan's Reviewed-by tag.
- Added Cc: <stable@vger.kernel.org> tag

Cui Chao (1):
  mm: numa_memblks: Identify the accurate NUMA ID of CFMW

 mm/numa_memblks.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

-- 
2.33.0

