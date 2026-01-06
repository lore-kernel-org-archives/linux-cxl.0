Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net (zg8tmja5ljk3lje4ms43mwaa.icoremail.net [209.97.181.73])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59550145B3E;
	Tue,  6 Jan 2026 03:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.181.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767669061; cv=none; b=ChbQ1VbrkXm0eDezzX3k39cl72Lf+Ll4yOafAb/SAD/dgXCn7F9QjkfUiOA7dstdbZ9C995Ul5uScg+bkeFJIMqEWxiin3HTYly1/z+gxEutXd/Ai7E5TM36LxS3BuakvvsEM8vj/5eVC7Ay0zyLGE4DCIRv5rPuXxTVkuaU67I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767669061; c=relaxed/simple;
	bh=0XVpj4pbE0g3Su0ut17GFEoUeIgnehClsvz3NHB5GM4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eq1Bzku4pzikxDIclZTVwecSmEjEz8JhJoYwxKfIxnrW8xdirIOc/IxZqtfpdJxzK49hSRAxDPhbdPHoRsMJBG48TuCe4G/wn4dm2W4cDbQOLRKkYe6aqE9npVm3sTZ+xKf2iSq7CVdAV8awQMyHfhFjvrDRiO47VxJT7O5NN7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=209.97.181.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwCXnCQ4fVxpniHoAg--.61611S2;
	Tue, 06 Jan 2026 11:10:48 +0800 (CST)
Received: from localhost.localdomain (unknown [218.76.62.144])
	by mail (Coremail) with SMTP id AQAAfwCX7eozfVxpE1ARAA--.16517S2;
	Tue, 06 Jan 2026 11:10:44 +0800 (CST)
From: Cui Chao <cuichao1753@phytium.com.cn>
To: Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Mike Rapoport <rppt@kernel.org>
Cc: Wang Yinfeng <wangyinfeng@phytium.com.cn>,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 0/1] Identify the accurate NUMA ID of CFMW
Date: Tue,  6 Jan 2026 11:10:41 +0800
Message-Id: <20260106031042.1606729-1-cuichao1753@phytium.com.cn>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwCX7eozfVxpE1ARAA--.16517S2
X-CM-SenderInfo: pfxlux1drrlkut6sx5pwlxzhxfrphubq/1tbiAQAHAGlcG0AAvgADsV
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=cuichao175
	3@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU8nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

Changes in v2:
- Added an example memory layout to changelog.
- Added linux-cxl@vger.kernel.org to CC list.
- Assigned the result of meminfo_to_nid(&numa_reserved_meminfo, start)
  to a local variable.

Cui Chao (1):
  mm: numa_memblks: Identify the accurate NUMA ID of CFMW

 mm/numa_memblks.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

-- 
2.33.0

