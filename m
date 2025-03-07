Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EC0257AC1
	for <linux-cxl@vger.kernel.org>; Fri,  7 Mar 2025 20:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741381025; cv=none; b=ABni0JWrC82Z7hGNOhf3XXKXyHk2ZJn04fYVL8TF/fjAZFfs+jgHdBrKmzo33zdhFEPkFABZb6Rvw+I65Qoto+vzmMorCsl/fGAT4fZzA8yBfOq71povZSTiCprMz9PLJP1oEE4dNg4Ss0rFfxkQNkYN4fbx3HlrS8oduUNdTMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741381025; c=relaxed/simple;
	bh=9ZPQoaY7GflGkXKoabSGUB0KhvGP2niv7+kkN3b1LJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D3ExjTk1k7qGjn6x6sZFBylxBnffDML8aRYpPlsBxKmh2JtJ6ZuIqqjSqFhMS2rEYFsNqSYcxRbiEN2Yy6tQ3FP0x/J6rPWxRe7HbCTmXkDdzkpPFOIZtg6EgGC8JcrcubO1fxb1UKqt29d+Rpc8nvFUHOkeZducKN8/wj9TYhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99D14C4CED1;
	Fri,  7 Mar 2025 20:57:04 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: jgg@nvidia.com,
	saeedm@nvidia.com,
	jonathan.cameron@huawei.com
Subject: [PATCH v8 9/9] cxl: Fixup kdoc issues for include/cxl/features.h
Date: Fri,  7 Mar 2025 13:55:39 -0700
Message-ID: <20250307205648.1021626-10-dave.jiang@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250307205648.1021626-1-dave.jiang@intel.com>
References: <20250307205648.1021626-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixup kdoc issues for include/cxl/features.h from linux-next build.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 include/cxl/features.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/cxl/features.h b/include/cxl/features.h
index ead63573b0b4..cdd4c7131cc3 100644
--- a/include/cxl/features.h
+++ b/include/cxl/features.h
@@ -51,8 +51,6 @@ enum cxl_features_capability {
  * struct cxl_features_state - The Features state for the device
  * @cxlds: Pointer to CXL device state
  * @entries: CXl feature entry context
- *	@num_features: total Features supported by the device
- *	@ent: Flex array of Feature detail entries from the device
  * @fwctl_dev: Firmware Control device
  */
 struct cxl_features_state {
-- 
2.48.1

