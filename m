Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCACB2566
	for <linux-cxl@vger.kernel.org>; Wed, 14 May 2025 00:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747182695; cv=none; b=niIkjoN57YNK44hPejeL0KCsHYJmjbu4OKZyaVLXSB7FhQ9QLB0hgf4SHt/M1OzW6IfkJtJvjSegwnChrqTY+mEuJSQCVlHZ5g6we/Nk3fokqBra7GcBRKyQUm6+C1+YQYKfgVQlPprkEnPPmMJ48XcBd8HsVSN6JAMK7Be2nBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747182695; c=relaxed/simple;
	bh=PGKRJJP+vc0pJIppJkp544MicAAlOpcSz+hYnPTjxBo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AdNvdftChFIcbJpRAC2yrW5jHAAu0N8WWw6Ta00iJ29mUYUZM6SSmeiyVJoHMI2NSigRJmL0k4Yaqn3UJs2AteRcYoQTeAfHyi/SPvN+PMrVrtsL7ilaYcp5o8IdzH8Rz0F4V6AwsTLrPhANZlTmplzIx9L8cQRgv/1YG9cuhgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B089C4CEE4;
	Wed, 14 May 2025 00:31:35 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	gourry@gourry.net
Subject: [PATCH 0/4] cxl: Update CXL documentation for access coordinates calculation
Date: Tue, 13 May 2025 17:31:29 -0700
Message-ID: <20250514003133.584401-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


Dave Jiang (4):
  cxl: docs/platform/cdat reference documentation
  cxl: docs/platform/acpi/srat fix memory table misalignment
  cxl: docs/platform/acpi/srat Add generic target documentation
  cxl: doc/linux/access-coordinates Update access coordinates
    calculation methods

 Documentation/driver-api/cxl/index.rst        |  1 +
 .../cxl/linux/access-coordinates.rst          | 87 +++++++++++++++++++
 .../driver-api/cxl/platform/acpi/srat.rst     | 27 +++++-
 .../driver-api/cxl/platform/cdat.rst          | 24 +++++
 .../driver-api/cxl/platform/cdat/dslbis.rst   | 33 +++++++
 .../driver-api/cxl/platform/cdat/dsmas.rst    | 23 +++++
 .../driver-api/cxl/platform/cdat/sslbis.rst   | 45 ++++++++++
 7 files changed, 237 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/driver-api/cxl/platform/cdat.rst
 create mode 100644 Documentation/driver-api/cxl/platform/cdat/dslbis.rst
 create mode 100644 Documentation/driver-api/cxl/platform/cdat/dsmas.rst
 create mode 100644 Documentation/driver-api/cxl/platform/cdat/sslbis.rst


base-commit: 7855bc1362518673103bd9357827572207e6f6d9
-- 
2.49.0

