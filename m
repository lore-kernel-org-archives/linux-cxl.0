Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4383155C3B
	for <linux-cxl@vger.kernel.org>; Mon,  1 Apr 2024 23:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712014488; cv=none; b=BGW02Cq9du+kqjqR3ZBQQU1vcRNazPrdYW/YnlXT5cCx3sMABQ3SPF5sOUiSWfzK2ZXJsd5Q+Tn5J5nZdXKU75CewScwqWS/9mtlmdLjci6gceqtqilNoNwxBrQReR2rI99kjCxCbXgzZ5ZibQ71qMNZsnbjbuqf0DQh6ffMVKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712014488; c=relaxed/simple;
	bh=7SM/YEqWCQ7tklIUiLiJoHu0Uw1D1xyK4/6ok03wh0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YYIIofHE6XYegGWalWzWiOMnKUV4r3DwIYhhOxdnUjp+nUhgzYfJb+gPRIFfXCUTLJsliZFo6v9j5VNsKpQwVr5iyl5S1qDM78AF98ZeGY6P0neItPSqPv9L1gxd5d2oU7/GUOdvcycMmLouxlfa44ONuhhmzgTt1ZhZM5YIdzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF881C433C7;
	Mon,  1 Apr 2024 23:34:47 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com,
	ira.weiny@intel.com,
	vishal.l.verma@intel.com,
	alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com,
	dave@stgolabs.net
Subject: [PATCH v6 0/4] cxl: access_coordinate validity fixes for 6.9
Date: Mon,  1 Apr 2024 16:32:58 -0700
Message-ID: <20240401233445.3057332-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v6:
- Simplify commit log for 1/4. (Dan)
- Normalize values from CDAT to nanoseconds. (Dan)
- Fix cxl_test for dpa_perf multi-class.

Hi Jonathan and Davidlohr,
Please take a look at 2/4 again and also review 3/4 which is new. The introduction
of the 2 access level for 'struct access_coordinate' caused a bit of adjustment
to the code. To keep flow of looping through the dports without additional existance
check, I made the setting of both access class coordinates from the beginning of
the calculation. Thank you!

[1/4] cxl: Remove checking of iter in cxl_endpoint_get_perf_coordinates()
[2/4] cxl: Consolidate dport access_coordinate ->hb_coord and ->sw_coord into ->coord
[3/4] cxl: Fix incorrect region perf data calculation
[4/4] cxl: Add checks to access_coordinate calculation to fail missing data
