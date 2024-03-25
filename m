Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566F070CB3
	for <linux-cxl@vger.kernel.org>; Mon, 25 Mar 2024 23:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711407759; cv=none; b=VCv6AEeSMd7ytkXDztDyzIrnf/MvJKGpSnCiFfZayp9PfyVB2gMPLxC6QglQxW4t9QxRfghG0czjwGQSMbAfZxzxFzpM4dEUPKhjhFNfBqIqn0T5zBSJFtX61u7VjuDy5MvH5BsbdnvMSkRe80W0T9g4UHG7RnpMc/H/v7NpaXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711407759; c=relaxed/simple;
	bh=9PU8WZX7WOI19hnWAKSnrwQNefNQpVgbYA0XGGBp53s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AZv9YlmG1Wxr8w7kAOLmT+dBC4xYb42HFL4cM7pmqnTG6xhuEMCESMipNfMnbP/hJ5fP5sHPgZx8eZdGV6I3KPspPtR/HFwcp6SjMe12kGvlo8PxEP65tYim8WnFdTirLwo4fhrRLimCE2hXiFwNgDwGk+RwytcFhlOrYjDMKoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2FD7C433F1;
	Mon, 25 Mar 2024 23:02:38 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com,
	ira.weiny@intel.com,
	vishal.l.verma@intel.com,
	alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com,
	dave@stgolabs.net
Subject: [PATCH v5 0/4] cxl: access_coordinate validity fixes for 6.9
Date: Mon, 25 Mar 2024 16:00:47 -0700
Message-ID: <20240325230234.1847525-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v5:
- Rebased against v6.9-rc1 and adjusted to multi access levels from the
  HMEM_REPORTING support code added in the v6.9 merge window.

Hi Jonathan and Davidlohr,
Please take a look at 2/4 again and also review 3/4 which is new. The introduction
of the 2 access level for 'struct access_coordinate' caused a bit of adjustment
to the code. To keep flow of looping through the dports without additional existance
check, I made the setting of both access class coordinates from the beginning of
the calculation.

[1/4] cxl: Remove checking of iter in cxl_endpoint_get_perf_coordinates()
[2/4] cxl: Consolidate dport access_coordinate ->hb_coord and ->sw_coord into ->coord
[3/4] cxl: Fix incorrect region perf data calculation
[4/4] cxl: Add checks to access_coordinate calculation to fail missing data
