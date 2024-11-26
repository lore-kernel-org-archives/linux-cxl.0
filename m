Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E54BBE65
	for <linux-cxl@vger.kernel.org>; Tue, 26 Nov 2024 03:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732590144; cv=none; b=pJs72UJrRbmcy/ZWicBMBmIzkqwNk5hL9NgMV/bGjCrWBUw5LT0PMpyAC1xp5KJpFZ814JbEu1g5LD+nHP4CIJ/BlR87lDz3d3Sq4puwLtOsB21jPsGPCVJDCnnhuzzgHBOfvWO+oA74pWBE0extX7x1TuXoqoYV8qCx6rzV+EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732590144; c=relaxed/simple;
	bh=KgqMHK4hnisjerxJ1FBqnZDDau6B39S3SD1RlVWiyOM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=thkZvzY8lz2eKxDU0qRKyO/+qkZPfS0LlTR+InrX5FmbX7GXTUmY3D1YGe1/ILmlsyz2WmohUVGdHDgjzBYl30fOLlDukn+8KoT+Ne11JAcrdmVQJGoQFzzP0nGDve3RuXMADCXVqZDsJgMzoT/U5ah5sKETlgMIgl59Z5PZ10Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwDn7BwtOkVnwtNkBw--.35167S2;
	Tue, 26 Nov 2024 11:02:05 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
	by mail (Coremail) with SMTP id AQAAfwC3DnsqOkVn9vhaAA--.10060S3;
	Tue, 26 Nov 2024 11:02:04 +0800 (CST)
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: AbdulLateef.Attar@amd.com,
	gaoliming@byosoft.com.cn,
	zhiguang.liu@intel.com,
	michael.d.kinney@intel.com
Cc: Jonathan.Cameron@Huawei.com,
	marcin.juszkiewicz@linaro.org,
	chenbaozi@phytium.com.cn,
	devel@edk2.groups.io,
	linux-cxl@vger.kernel.org,
	Yuquan Wang <wangyuquan1236@phytium.com.cn>
Subject: [RFC EDK2 PATCH v4 0/1] MdePkg/IndustryStandard: add definitions for CXL CEDT
Date: Tue, 26 Nov 2024 11:01:58 +0800
Message-Id: <20241126030159.72111-1-wangyuquan1236@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwC3DnsqOkVn9vhaAA--.10060S3
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQABAWdE1PMBTAABsJ
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvdXoWrZFWxZrW3Kr13KF1fKrW7urg_yoWfZFX_C3
	4IyryxGw18ZFy8Xa45KF1rtryxGr4UKr1Ska9rXr1xWr1DJrs8Cw47J39xZFyfCrWIqF1f
	J3Z8ZrWxAwnFgjkaLaAFLSUrUUUU1b8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrnU
	Uv73VFW2AGmfu7jjvjm3AaLaJ3UjIYCTnIWjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRUUUUU
	UUUU=

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

 MdePkg/Include/IndustryStandard/Cxl20.h | 38 ++++++++++++++++++++
 MdePkg/Include/IndustryStandard/Cxl30.h | 46 +++++++++++++++++++++++++
 MdePkg/Include/IndustryStandard/Cxl31.h | 45 ++++++++++++++++++++++++
 3 files changed, 129 insertions(+)
 create mode 100644 MdePkg/Include/IndustryStandard/Cxl31.h

-- 
2.34.1

