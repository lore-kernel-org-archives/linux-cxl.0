Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBAC219F9
	for <linux-cxl@vger.kernel.org>; Wed, 10 Jul 2024 22:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720650440; cv=none; b=XLlDXMM3LHDTLbXtN61t1ec6WReuf/QnFBgfNg96SwTK7yybrv4yIr3Eea+eGRSknCxp6By2CS8g6edxgWHQaUw6C/iosBHnEQKk6hi+PAHbeCpocGhacbT0wF6cLw+/zmKBdgErvjfGSGibwuSsKIfmVthurly8YqxVAzzinI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720650440; c=relaxed/simple;
	bh=oOr1Tx/Abk49wnhBLTjPBgWQplz6YTNucCBsfKku6UI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ldoStYU4PPc4IHe3N9BwR/pm8igV+BfNhOYa04GL/5N6k7NrVgIfk0nZtb5eBnjBys664P4nwjtiVLm61ogR46z//VwtZu6FkfCDXv9z6Je550LMWbS9hVjMWhyOBcqHCmreBYpWtuLt1bco0zVDexJFsZE8mb1bPccxm/lzaDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 996B0C32781;
	Wed, 10 Jul 2024 22:27:19 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com,
	ira.weiny@intel.com,
	vishal.l.verma@intel.com,
	alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com,
	dave@stgolabs.net
Subject: [PATCH v7 0/3] cxl: Region bandwidth calculation for targets with shared upstream link
Date: Wed, 10 Jul 2024 15:23:59 -0700
Message-ID: <20240710222716.797267-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v7:
- Add documentation explaining how the bandwidth is calculated. (Dan)
- Fix 2hb2rp2ep case. (Jonathan)
  - Split out the RP and HB level work.
- Rename functions and add kdoc comments to clarify the code. (Dan)
- Move activation point to immediately after cxl_region_setup_targets(). (Dan)
- Added information on testing and results in commit log. (Dan)
- See specific patches for more details.

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

