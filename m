Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D364A3E
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jan 2025 00:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737591958; cv=none; b=rbJ3lI2xmld5wtLQrmaJ7C/hhPDyGooiWU0c9INOMbIk0T8idGxrK26l0kTdmk1V5+I7UtRtwtHITgjiKhFfqIvPxXHGrPV/v5+nm9Ua0G4f7fi2e9OQ2yvNUhx44vsb6iSlgGM0NSWnOwPLtHWkQOQsdjsvGKMze0rXw1CM3/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737591958; c=relaxed/simple;
	bh=3b0jKqtLi6AkGNloKRhrBx4Q/7XteBCs4LoYoq9FfJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FPrTS+WHKeP2+RdrBkTHC3VYqGUVRHQm7HnOJX1mtvAvHc27bmZUVWJFma8gXM130Ns06d1DBrjSb/ON9wZa3uuDSML9/LoJpgZ3hyNhACPxgol8t6UQdyf/70YsiogVi60rJ3GkvBjI7PyFSzxMpyC+xLfwZksmIK/D9D21qXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABEC3C4CED2;
	Thu, 23 Jan 2025 00:25:57 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: alison.schofield@intel.com
Subject: [NDCTL PATCH resend 3/5] cxl: Add get major and minor for cxl features device
Date: Wed, 22 Jan 2025 17:24:52 -0700
Message-ID: <20250123002530.2762440-4-dave.jiang@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250123002530.2762440-1-dave.jiang@intel.com>
References: <20250123002530.2762440-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add helper functions to retrieve the major and minor of the associated
char device for the cxl features device. The char device provides
access to issue ioctl via the FWCTL subsystem to the CXL features
driver for CXL mailbox feature commands.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 cxl/lib/libcxl.c   | 10 ++++++++++
 cxl/lib/libcxl.sym |  2 ++
 cxl/libcxl.h       |  2 ++
 3 files changed, 14 insertions(+)

diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
index 8bc0394543dc..f2da48278cb0 100644
--- a/cxl/lib/libcxl.c
+++ b/cxl/lib/libcxl.c
@@ -4874,3 +4874,13 @@ CXL_EXPORT struct cxl_features *cxl_features_get_next(struct cxl_features *featu
 
 	return list_next(&ctx->features, features, list);
 }
+
+CXL_EXPORT int cxl_features_get_major(struct cxl_features *features)
+{
+	return features->major;
+}
+
+CXL_EXPORT int cxl_features_get_minor(struct cxl_features *features)
+{
+	return features->minor;
+}
diff --git a/cxl/lib/libcxl.sym b/cxl/lib/libcxl.sym
index 9b1708d8e86a..6d70d5b90377 100644
--- a/cxl/lib/libcxl.sym
+++ b/cxl/lib/libcxl.sym
@@ -294,4 +294,6 @@ global:
 	cxl_bus_get_by_provider;
 	cxl_features_get_first;
 	cxl_features_get_next;
+	cxl_features_get_major;
+	cxl_features_get_minor;
 } LIBECXL_8;
diff --git a/cxl/libcxl.h b/cxl/libcxl.h
index 7e94eb8bce24..5dcc60c8bf1a 100644
--- a/cxl/libcxl.h
+++ b/cxl/libcxl.h
@@ -497,6 +497,8 @@ struct cxl_features;
 
 struct cxl_features *cxl_features_get_first(struct cxl_ctx *ctx);
 struct cxl_features *cxl_features_get_next(struct cxl_features *features);
+int cxl_features_get_major(struct cxl_features *features);
+int cxl_features_get_minor(struct cxl_features *features);
 
 #ifdef __cplusplus
 } /* extern "C" */
-- 
2.47.1

