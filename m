Received: from sgoci-sdnproxy-4.icoremail.net (sgoci-sdnproxy-4.icoremail.net [129.150.39.64])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D9A26BD92
	for <linux-cxl@vger.kernel.org>; Tue, 11 Feb 2025 02:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.150.39.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739240727; cv=none; b=CTnmZMtbSNtP3WzKvvu3/fhI5MX8aaOFKYSZkcOhs2vOgCZufHUtIiYjJksDe+5WOEkTfRNk6gtLditygevoBKIB02qvqNfcT4pcVyYAVjwLjdMwUuV5923tJ441JlkvikIz/2+YjBtNFhKiqNUNBy/RU1nhyYrqQ/zD740uxCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739240727; c=relaxed/simple;
	bh=LutZh64kPgJdkHFnUVodu4nan/q/HYN2v4lyMTO5f8Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MkQrw/rX765AtEH+4v2KIuQopNELqL60pzUwfw57qLauuFQtAaCvmOz4SBkYINGy2XegQ2cb6/55JI5jnAbY5Rgez1vcmG1xYCZ9Qmoib/s80SuN7uUN42gcYGrHCDxufKUqCD79OeXxgsgzAmKn7K4KoKIUUTbgZYVMwFV9Qow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=129.150.39.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwBnyD3otKpnPo1YAg--.25763S2;
	Tue, 11 Feb 2025 10:24:40 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
	by mail (Coremail) with SMTP id AQAAfwDX3YnmtKpnW+AgAA--.43854S3;
	Tue, 11 Feb 2025 10:24:38 +0800 (CST)
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: jonathan.cameron@huawei.com,
	fan.ni@samsung.com
Cc: qemu-devel@nongnu.org,
	chenbaozi@phytium.com.cn,
	linux-cxl@vger.kernel.org,
	Yuquan Wang <wangyuquan1236@phytium.com.cn>
Subject: [PATCH 0/1] mem/cxl-type3: Add a default value of sn
Date: Tue, 11 Feb 2025 10:24:12 +0800
Message-Id: <20250211022413.80842-1-wangyuquan1236@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwDX3YnmtKpnW+AgAA--.43854S3
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQASAWeqWwIAwwAFsA
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU8nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

The previous default value of sn is UI64_NULL which would cause the
cookie of nd_interleave_set be '0' and the "invalid interleave-set
-cookie" failure in label validation.

As many users maybe not know how to set a unique sn for cxl-type3
device and perhaps be confuesd by the failure of label validation,
so this defines '1' as the default value of serial number to fix the
problem.

Yuquan Wang (1):
  mem/cxl-type3: Add a default value of sn

 hw/mem/cxl_type3.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

-- 
2.34.1

