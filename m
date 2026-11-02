Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793646919;
	b=Kn7VTpHkkz2TtaWfUxKFWfHoXK4os5D8ntIhZ2x+cWK5Nr0TtmVG9JKxYvWaxtGmeoCu
	 4gTJGMGX5Vvo2KoObn6r94jT/5jvBYLKX0VWrTyIa0F/i+riSjTFkZE95BUuUO+oe1fVQ
	 W1YDahQTrUxPfJUYuN97hoe3XYefj6XT7tkaRWUbGllJpKuy4l2aPO68uPJQtGjkkqJ4K
	 BX/5Wimpa4w+o6JaB14E9d18Iz0YBfIXXKSbxdw10brBAwyZyvKRDOY0KHooYgapG5Yaw
	 oLIFyGBGAfBy3zWL1RgwdWToL0eooz7YovfzDTJLQ0C+c+gZL7qysgLOYW7++SjwmfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793646919;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=tqFKmigeTD+MfvoT7YW2E8qoX5d7P8FBk2IeBiKDls0=;
	b=CEMmVkpCqwSOv6XLQ6dAg33pVt56JwGZgW/GEbt1yQ2HFEQ6VOxc+4ZpM9NEPRyfBun1
	 5a7BaPiAcUV0OmIWF1cUu1NvOpn4pGFf4ES4p2cBCdiww1nzwqDC21y7UdzcKfCMRYmZi
	 UkAFX9r4BYYa6Zz/c2mQkq/jSwhrZgjwxIjm8XGquKn9yZ8rfvoC3Lhi9gO6TeWCQUZRM
	 kYi31D5mOG20KxlfBJb584biqQ6pS2OuJirxaHpceIcfeFEDU1YgihYDgZVymZIikCavS
	 ky9VpJeSBo9ea/b0CqJqEOZ9985rPEEygGnp2KwBVcf8dBD+7JthE1QIWoumS+QGqnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WrJ4PMC8;
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369E1606A330
	for <linux-cxl@vger.kernel.org>; Mon,  2 Nov 2026 19:15:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 369E1606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WrJ4PMC8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793646918; x=1825182918;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KO35rck8MZqAbsAwM2HfBzpbOqnJksAOaz0TGDOdmG8=;
  b=WrJ4PMC8kbqZHB8xlZI33nGq+rvAinWOzJ3yfQn8wpDKfLx/FeF3Y6ZL
   80yJeOe9B+AUrYAoaz1/ZbQAIuGbwVQLUh+uxgAjqLVtiuHz+CpgxQPvl
   iSr8HKzYTYTJ7QckXSqRr0IuWu/t4OYCkPwUN0cTcnWbElEP7NBkkaZcL
   F9eLq0zr0KzMeVZkshLSCdk919E4p0vu68P7+jgIk5WLlvJNeMI9f+9kM
   A7cHwWujV1x4/8WprXtNQHNQpFuKD9m3NC7Fr0AMdSeZwqovPI5Ynm/dX
   Ob72LDRsLQwruO0i3EjgsEoweu3E7wXd0yKjCriiX32VEbqK812YlrWlf
   Q==;
X-CSE-ConnectionGUID: o+Ct8AXzRKe7vQLGbbngUA==
X-CSE-MsgGUID: umvpDjXSSESZV9y7xV5MiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2383463"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2383463"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 11:15:17 -0800
X-CSE-ConnectionGUID: owkioaeKSPKejjt36iFOng==
X-CSE-MsgGUID: ixV1poytQvGWecJD6EsRrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6294132"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.125.109.173])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 11:15:17 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Richard Cheng <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v2 0/4] cxl: Add KUnit tests and documentation
Date: Mon,  2 Nov 2026 11:15:10 -0800
Message-ID: <cover.1793645996.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


Changes in v2:
- Use explicit hex designators in the decoder count table to match the spec (JonathanC)
- Generalize arch option and add help ref in testing page (AnisaS)
- Explicitly initialize the mock return_code to SUCCESS (MingL)
- Add a 'Maintaining KUnit tests' section to testing page
- Wrap long lines in testing page (JonathanC)
- Rebase on 7.4-rc1
v1: https://lore.kernel.org/linux-cxl/cover.1791949910.git.alison.schofield@intel.com/


The CXL subsystem has no KUnit tests. Its automated test coverage comes
from cxl_test and the ndctl suite, which exercise the driver stack through
an emulated CXL topology. KUnit complements that coverage by testing self-
contained logic and error paths in isolation.

This series introduces CXL KUnit infrastructure and documentation describing
how it complements the existing cxl_test coverage.

The first KUnit suite, a collection of related test cases, exercises the HDM
decoder interleave encoding helpers, providing a starting point for testing
self-contained CXL logic. The second suite exercises mailbox command handling,
including error paths that are difficult to reach through cxl_test.

The mailbox tests also demonstrate the value of regression coverage. An
unknown device return code can cause an out-of-bounds read and allow a failed
command to be reported as successful. The series corrects that behavior, then
adds tests that reproduce the failure without the correction. With KASAN enabled,
the tests also expose the out-of-bounds read.

Together, the two suites establish a pattern for adding KUnit coverage
to CXL, both for existing functionality and for bugs as they are found.


Alison Schofield (3):
  Documentation/driver-api/cxl: Add a testing page
  cxl: Add KUnit tests for HDM decoder encoding helpers
  cxl/mbox: Add KUnit tests for cxl_internal_send_cmd()

Gaobin Huang (1):
  cxl/mbox: Treat unknown device return codes as errors

 Documentation/driver-api/cxl/index.rst   |   1 +
 Documentation/driver-api/cxl/testing.rst | 139 +++++++++++++
 drivers/cxl/.kunitconfig                 |   4 +
 drivers/cxl/Kconfig                      |  16 ++
 drivers/cxl/Makefile                     |   1 +
 drivers/cxl/core/Makefile                |   1 +
 drivers/cxl/core/tests/Makefile          |   5 +
 drivers/cxl/core/tests/mbox_kunit.c      | 250 +++++++++++++++++++++++
 drivers/cxl/cxlmem.h                     |   6 +
 drivers/cxl/tests/Makefile               |   5 +
 drivers/cxl/tests/hdm_encoding_kunit.c   | 159 ++++++++++++++
 11 files changed, 587 insertions(+)
 create mode 100644 Documentation/driver-api/cxl/testing.rst
 create mode 100644 drivers/cxl/.kunitconfig
 create mode 100644 drivers/cxl/core/tests/Makefile
 create mode 100644 drivers/cxl/core/tests/mbox_kunit.c
 create mode 100644 drivers/cxl/tests/Makefile
 create mode 100644 drivers/cxl/tests/hdm_encoding_kunit.c


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.37.3

