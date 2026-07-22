Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD43351C11
	for <linux-cxl@vger.kernel.org>; Wed, 22 Jul 2026 20:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784753585; cv=none; b=UeqIlh+UEQZENd2MLUBFCdvWBahW3/4gtp2GYW4GwnHxB7wKBwtvZmmB3Ck15kdAuf8rW3Tt11WWoCMchLt0z9qkspISYmIi7rvy2BiVGd2ByeFjfOCFYDgST8+kpJBfmbGtdqTmA1I6/f28TF0C6U11pug2Vmpx5AlAUpOhnJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784753585; c=relaxed/simple;
	bh=NZorlxOJhBHI1jKQoE4D8OgSbWfx4bFI0KAfuBbCO84=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UEZZPV9BcavxSuP0gA6KA722Z3l6uuigz7lTlIMy6Yu2r22Ag3Xo4XvQWS+bHH4r0TCGjjWgQp8sTO4hrUDU3qWW5xGpgb9rkHCBPrlt9iDghsKOlxiv3bEfNlkbflfIYSpTqVcqro/4F4THRdcUUZwzzk1ApkNKYOf65DpUFAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BA3D1F000E9;
	Wed, 22 Jul 2026 20:53:04 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: djbw@kernel.org,
	dave@stgolabs.net,
	jic23@kernel.org,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com
Subject: [PATCH 0/3] cxl: Misc sashiko fixes
Date: Wed, 22 Jul 2026 13:52:59 -0700
Message-ID: <20260722205303.3184787-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several shashiko reported issues
1. cxl/memdev: Don't mask an earlier partition's poison query error
2. cxl/ras: Clear software-only TLP log fields after RCH AER copy
3. cxl/region: Guard against unset partition in poison_by_decoder()


Dave Jiang (3):
  cxl/region: Guard against unset partition in poison_by_decoder()
  cxl/ras: Clear software-only TLP log fields after RCH AER copy
  cxl/memdev: Don't mask an earlier partition's poison query error

 drivers/cxl/core/memdev.c  | 2 ++
 drivers/cxl/core/ras_rch.c | 7 +++++++
 drivers/cxl/core/region.c  | 3 +++
 3 files changed, 12 insertions(+)


base-commit: 1590cf0329716306e948a8fc29f1d3ee87d3989f
-- 
2.55.0

