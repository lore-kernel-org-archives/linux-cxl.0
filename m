Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710FF10E4
	for <linux-cxl@vger.kernel.org>; Thu, 15 May 2025 00:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747267784; cv=none; b=Oaer4lJfahwZQdeZXmO2oV03a/khQFmpDOepgsoUJldlyEq/NNitdhHTMHQMxZ6gTvi/TpyFqEzQ0iJm6H5iYqf4fChL9Vo3seXj6s2YydHBHhTGmsuvifT5wnxA+xz3uHfJ9Jms0oeQVX3RY6yPry9zxVPCgFF5NFxdujwh+L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747267784; c=relaxed/simple;
	bh=PrQ1vxDx4MYQWvl+k8IG4+qBfmYGiqAmBnEMaac2EnE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h6sKvZ8h17Qb07ldoe2tk7aZr408MPcTF1u2F4+rcKghI8zuHHaoYxErFfEnhf0MB0bAZUaGtYpMWWs81bIU8e/am1bEblU+wZZ9OE+KSyz5woRIAzRCA6lRWGardkOTygq/kLVFEawaNZcRhU7+i7g6YJ2Jo0iyA9wjQi9QAUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAD98C4CEE3;
	Thu, 15 May 2025 00:09:43 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	gourry@gourry.net
Subject: [PATCH v2 0/3] cxl: Update CXL documentation for access coordinates calculation
Date: Wed, 14 May 2025 17:09:20 -0700
Message-ID: <20250515000923.2590820-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2:
- Language clarifications (Gregory)
- Move all CDAT bits into single document. (Gregory)
- Define CDAT terms. (Gregory)

Add CXL access coordinates calculation documentation including CDAT details.


Dave Jiang (3):
  cxl: docs/platform/cdat reference documentation
  cxl: docs/platform/acpi/srat Add generic target documentation
  cxl: doc/linux/access-coordinates Update access coordinates
    calculation methods

 Documentation/driver-api/cxl/index.rst        |   1 +
 .../cxl/linux/access-coordinates.rst          |  86 +++++++++++++
 .../driver-api/cxl/platform/acpi/srat.rst     |  27 ++++
 .../driver-api/cxl/platform/cdat.rst          | 118 ++++++++++++++++++
 4 files changed, 232 insertions(+)
 create mode 100644 Documentation/driver-api/cxl/platform/cdat.rst


base-commit: 7855bc1362518673103bd9357827572207e6f6d9
-- 
2.49.0

