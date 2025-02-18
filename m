Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2060F28629C
	for <linux-cxl@vger.kernel.org>; Tue, 18 Feb 2025 23:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739919679; cv=none; b=D5gJsSQJKeLsDBgcAeLs6yYzvjs7Eyjr3e/9ntlre5zjfs7YLJtw1V/jfljNzfQSjWsrsDBE47xLMgIdgZ8LpAVB88tPznLPdhetDvLEH1YhPVpWmiDxrHsEZx1ni6pot++yNcW3EKPuPSfje8JsBswcI4vCv5CacTu71dLhHoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739919679; c=relaxed/simple;
	bh=XyCkjEVPCuA1XA8uSgM6KP/0h5758DPlYkmjLPx/nZM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eEmi/ySMteXAaikbfvkHi58uSs88HuNTkDiq8GOeVO3Ygy5r1s9ocwhBHkG6gsi+UeT6bUm80i2muBAzRwBid6i7D7z+RLq54YSd/foiN7wXdIDhvOh9JGFmvzHPEhr0vgxtGMN144SmJNOkJracb9b+Pwt2O4Fkw6fTZMIY+64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D8BCC4CEE6;
	Tue, 18 Feb 2025 23:01:18 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: alison.schofield@intel.com
Subject: [NDCTL PATCH v4 0/3] ndctl: Add support and test for CXL Features support
Date: Tue, 18 Feb 2025 15:59:53 -0700
Message-ID: <20250218230116.2689627-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v3:
- Update test to use opcode instead of command id.

v2:
- Drop features device enumeration
- Add discovery of char device under memdev

The series provides support of libcxl enumerating FWCTL character device
under the cxl_memdev device. It discovers the char device major
and minor numbers for the CXL features device in order to allow issuing
of ioctls to the device. 

A unit test is added to locate cxl_memdev exported by the cxl_test
kernel module and issue all the supported ioctls to the associated
FWCTL char device to verify that all the ioctl paths are working as expected.

Kernel series: https://lore.kernel.org/linux-cxl/20250218225721.2682235-1-dave.jiang@intel.com/T/#t

Dave Jiang (3):
      cxl: Add cxl_bus_get_by_provider()
      cxl: Enumerate major/minor of FWCTL char device
      cxl/test: Add test for cxl features device

 cxl/lib/libcxl.c     |  85 ++++++++++++++++
 cxl/lib/libcxl.sym   |   7 ++
 cxl/lib/private.h    |   1 +
 cxl/libcxl.h         |   4 +
 test/cxl-features.sh |  31 ++++++
 test/fwctl.c         | 383 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 test/meson.build     |  45 +++++++++
 7 files changed, 556 insertions(+)
