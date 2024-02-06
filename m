Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0EC17592
	for <linux-cxl@vger.kernel.org>; Tue,  6 Feb 2024 19:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707246274; cv=none; b=coFiCLHa2r/tKJ/6hex2PlMw7GxVFGFTx7Aam6CK7pHpsuCjAvYkxZvqin2AE1SJfjyVemcaTn3e+yRhywxtjqDPA8kQ2CvCh86Kj4s24mULACBc8kp8lBUlnV6/FzV1WB2PEkDPPSsf7MisV0gTCi5Eu21ppwuNNbMnIeAJGxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707246274; c=relaxed/simple;
	bh=3l6aWvlvnNPOE+UuooeAdlhWwcsQUhvDjbGN3qpdaIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h70RIJhn/VUq/QbelKvrzrYSH1LZeV0N5XZP2UF2yZcUQbwlkCreErrLVjI8g3jiNuPaQnh+BNxsqtGEQO7z6ou/WuxdKTjigDrAVnOijJ6/iNzMrQf4WMtScIdVt71y73Pye4O49kk0Kwc0602lh9FCuSSpwa7CVDSaq8d6Glw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8CD5C433F1;
	Tue,  6 Feb 2024 19:04:33 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com,
	ira.weiny@intel.com,
	vishal.l.verma@intel.com,
	alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com,
	dave@stgolabs.net
Subject: [PATCH v5 0/4] cxl: Fix memdev qos_class sysfs attributes
Date: Tue,  6 Feb 2024 12:03:36 -0700
Message-ID: <20240206190431.1810289-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v5:
- Only update the perf sysfs groups (Dan)
- Remove unnecessary type cast (Jonathan)

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
