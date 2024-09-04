Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FDB33D5
	for <linux-cxl@vger.kernel.org>; Wed,  4 Sep 2024 00:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725408799; cv=none; b=PYT4+pgzfO7BlUGiWprchCL8CyawRPFEFwNYce8YuuOA3xl441UMdrcklpB7LfDmm0dTy6TAWMtIURVMqcdS3pUo3AhB1IL/H89C9K1M2QlKC8iwYu3fT15a+RHpjuCejG3bkieaa+LBWIDizQOVNOkCXVFYEuPM7xG8NQDFA7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725408799; c=relaxed/simple;
	bh=cjTCsUpNS/jmDyf0VZkuWuIhMHArYvI4tUpjaiOChVs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cRQjYsR/lub4qAq37cCRQqD/DmLQ4JPkPEgEv3k9KJIcvx3Pl/SIQ3yHBafINyhdZD2hcu9a5FdX4O323Mgnsbmex+uSJkJK8tNPr9pqbftJ8OWPvxLkYk8wEJLU6oJnmQzFt5KNjVX2FZ2OGjbPjB/IOVfsuUft4h1XuIH1NP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99E70C4CEC4;
	Wed,  4 Sep 2024 00:13:18 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com,
	ira.weiny@intel.com,
	vishal.l.verma@intel.com,
	alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com,
	dave@stgolabs.net
Subject: [PATCH v8 0/3] cxl: Region bandwidth calculation for targets with shared upstream link
Date: Tue,  3 Sep 2024 17:11:49 -0700
Message-ID: <20240904001316.1688225-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v8:
- Fixed kbot warning
- Fix checking incorrect return value (Alison)
- Remove goto from cxl_region-shared_upstream_bandwidth_update() (Alison)
- Add ** for kdoc comment (Alison)
- Fixup documentation texts (Jonathan)
- Rebase against v6.11-rc

This series provides recalculation of the CXL region bandwidth when the targets have
shared upstream link by walking the toplogy from bottom up and clamp the bandwdith
as the code traverses up the tree. An example topology:

 An example topology from Jonathan:

                 CFMWS 0
                   |
          _________|_________
         |                   |
     ACPI0017-0            ACPI0017-1
   GP0/HB0/ACPI0016-0   GP1/HB1/ACPI0016-1
     |          |        |           |
    RP0        RP1      RP2         RP3
     |          |        |           |
   SW 0       SW 1     SW 2        SW 3
   |   |      |   |    |   |       |   |
  EP0 EP1    EP2 EP3  EP4  EP5    EP6 EP7

 Computation for the example topology:

 Min (GP0 to CPU BW,
      Min(SW 0 Upstream Link to RP0 BW,
          Min(SW0SSLBIS for SW0DSP0 (EP0), EP0 DSLBIS, EP0 Upstream Link) +
          Min(SW0SSLBIS for SW0DSP1 (EP1), EP1 DSLBIS, EP1 Upstream link)) +
      Min(SW 1 Upstream Link to RP1 BW,
          Min(SW1SSLBIS for SW1DSP0 (EP2), EP2 DSLBIS, EP2 Upstream Link) +
          Min(SW1SSLBIS for SW1DSP1 (EP3), EP3 DSLBIS, EP3 Upstream link))) +
 Min (GP1 to CPU BW,
      Min(SW 2 Upstream Link to RP2 BW,
          Min(SW2SSLBIS for SW2DSP0 (EP4), EP4 DSLBIS, EP4 Upstream Link) +
          Min(SW2SSLBIS for SW2DSP1 (EP5), EP5 DSLBIS, EP5 Upstream link)) +
      Min(SW 3 Upstream Link to RP3 BW,
          Min(SW3SSLBIS for SW3DSP0 (EP6), EP6 DSLBIS, EP6 Upstream Link) +
          Min(SW3SSLBIS for SW3DSP1 (EP7), EP7 DSLBIS, EP7 Upstream link))))

---

Dave Jiang (3):
      cxl: Preserve the CDAT access_coordinate for an endpoint
      cxl: Calculate region bandwidth of targets with shared upstream link
      cxl: Add documentation to explain the shared link bandwidth calculation

 Documentation/driver-api/cxl/access-coordinates.rst |  90 +++++++
 Documentation/driver-api/cxl/index.rst              |   1 +
 MAINTAINERS                                         |   1 +
 drivers/cxl/core/cdat.c                             | 509 +++++++++++++++++++++++++++++++++++++++-
 drivers/cxl/core/core.h                             |   4 +-
 drivers/cxl/core/pci.c                              |  23 ++
 drivers/cxl/core/port.c                             |  20 ++
 drivers/cxl/core/region.c                           |   2 +
 drivers/cxl/cxl.h                                   |   1 +
 drivers/cxl/cxlmem.h                                |   4 +-
 10 files changed, 640 insertions(+), 15 deletions(-)

