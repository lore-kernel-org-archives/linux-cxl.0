Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABF813D278
	for <linux-cxl@vger.kernel.org>; Wed, 27 Nov 2024 09:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732698788; cv=none; b=LG9GRtTg6JNSSMwcEVVt+Fhzhgnk4fwk8JaBn7LAYpNkjwfEPs5f04qUIIYy3dBU1XMn6H4onEcKEs+QwYZ5kNfisAmuJeEfk4tAMoZUXJZ27yiWnNTxnTXcNIlDrPMjRDbizjd/tb7txhCb9vOFC9W75I8AzvM0yN1U9unyi5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732698788; c=relaxed/simple;
	bh=Fq/I3L3zDbTH0IWn5CMvMqBlRj5fgLbAFu50krgL9n8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bwmAb03IzpjDMD8CUU1rJoeOVUxZhVNbTQzLT+1NDGfGs73PFZYPSb3Dy0HOiYslV0SfobCVaX9Vk4bHl6FjGvXnVj99VNp+XelRavYD3+UZmqCRfKqWGSAnjZb8otzgcUJE1TQ9Jfp+vwMsr8CQNxyr0Atx+P5BAIFATjzVR+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwDX33mT4kZnQEgFBQ--.64960S2;
	Wed, 27 Nov 2024 17:12:51 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
	by mail (Coremail) with SMTP id AQAAfwCn_nqR4kZnVcRcAA--.11074S3;
	Wed, 27 Nov 2024 17:12:50 +0800 (CST)
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: AbdulLateef.Attar@amd.com,
	gaoliming@byosoft.com.cn,
	michael.d.kinney@intel.com,
	zhiguang.liu@intel.com
Cc: Jonathan.Cameron@Huawei.com,
	marcin.juszkiewicz@linaro.org,
	chenbaozi@phytium.com.cn,
	devel@edk2.groups.io,
	linux-cxl@vger.kernel.org,
	Yuquan Wang <wangyuquan1236@phytium.com.cn>
Subject: [RFC EDK2 PATCH v5 0/1] MdePkg/IndustryStandard: add definitions for CXL CEDT
Date: Wed, 27 Nov 2024 17:12:28 +0800
Message-Id: <20241127091229.112833-1-wangyuquan1236@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwCn_nqR4kZnVcRcAA--.11074S3
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQACAWdGJokDzQABsD
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvdXoW7Gry3Cr45Xw4fAF4rur4rKrg_yoWDXwb_u3
	4Iyry8Gw18ZFyxXay5KF1rtr97Gr4Utr1Fka9xXr1xWF1DJrs8Cw4UJ39xZFyfurW2qF1f
	J3Z8ZrWfAwnFgjkaLaAFLSUrUUUU0b8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrnU
	Uv73VFW2AGmfu7jjvjm3AaLaJ3UjIYCTnIWjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRUUUUU
	UUUU=

v4 -> v5:
- Add some comments on maximum sizing
- Introduce a errata fixed at CXL3.2

v3 -> v4:
- Fix the style of the variable name according to EDKII coding guidelines

v2 -> v3:
- Put each struct into the file for the spec they were introduced

RFC because
- Less experience and not particularly confident in edk2 area

I am trying to support cxl on Qemu sbsa-ref platform, but it relies on CXL ACPI elements
within compiled UEFI flash instead of virt/i386 using qemu-build-Acpi tables. Thus I
introduce fundamental structures of CEDT into the header file for the spec they were
introduced.

Yuquan Wang (1):
  MdePkg/IndustryStandard: add definitions for CXL CEDT

 MdePkg/Include/IndustryStandard/Cxl20.h | 41 +++++++++++++++++
 MdePkg/Include/IndustryStandard/Cxl30.h | 59 +++++++++++++++++++++++++
 MdePkg/Include/IndustryStandard/Cxl31.h | 47 ++++++++++++++++++++
 3 files changed, 147 insertions(+)
 create mode 100644 MdePkg/Include/IndustryStandard/Cxl31.h

-- 
2.34.1

