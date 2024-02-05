Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCF05B68C
	for <linux-cxl@vger.kernel.org>; Mon,  5 Feb 2024 19:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707161544; cv=none; b=Dbh9H4WsG+LwJAvMCPR7yHwRvyJ4qUogTdob5yweFJs8t9x/vagswQAbxMEO3GTF7PE5HrgBx8AYYcc7q+HHEvLGYuFhM1Fxn7uIasMsHz6xz70F6tpfOwEvfDoL2pbSwt484Qq1LJ1Ulqi6wxQuvqwaWEfO1WzVubjSQUJ89is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707161544; c=relaxed/simple;
	bh=Y9T3bW6bM9969DYzRG/GuQheALQYqvbrLSbKZkCzADE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BGJMtzmQGueZxSKxoav0hAATnn3FGgqRV9GHFOgFCjO1nyzN1xVSvkv16xfzIngkY1/H6Q2YH6Z8gWCgzOiohLDRUBsOzJQLggdeQGrO2McpHSlENMPGDFVjYYZOia/plaCIo7njAN3BVvDEFXWd6JbQsCRpHkVyQoI0upi70T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B3C5C433C7;
	Mon,  5 Feb 2024 19:32:24 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com,
	ira.weiny@intel.com,
	vishal.l.verma@intel.com,
	alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com,
	dave@stgolabs.net
Subject: [PATCH v4 0/4] cxl: Fix memdev qos_class sysfs attributes
Date: Mon,  5 Feb 2024 12:30:30 -0700
Message-ID: <20240205193218.1657243-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v4:
- Fix resetting of dpa_perf (Wonjae)
- Change cxl_qos_match() to return bool. (Jonathan)
- Remove unnecessary void * casting. (Jonathan)
- Replace open code with sysfs_update_groups() helper. (Jonathan)

This series provides fixes to the memdev qos_class sysfs attributes. The
current code emits duplicate sysfs attribute under the same directory and
the ram qos_class clobbers the pmem qos_class. Move the attributes under
static definitions and allow the attributes to show up under ram and pmem
directory individually.

The series also adds cxl_test support in order to allow CXL CLI add a unit
test for qos_class attributes.
