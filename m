Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAEA22B8D5
	for <linux-cxl@vger.kernel.org>; Thu, 22 May 2025 08:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747903603; cv=none; b=RS8+Mh8/tqW3dFNoJ5gQOyhRK6k+tux2wWW0HUwQZWF8xF10teg/7FsqjDgoEnJFJXYwkqeNQDjqi5k05gzC6Kb6Jghrlm6wFib1s9++N+CFmPuRuxPd6NVXqTsDyl8Y5Jc9fUYsv3yKtegGKaph5uLTmHZYpszqGycBjzHcINs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747903603; c=relaxed/simple;
	bh=DQ9g896ylP30QOnuL7HRQSOAPub4b1NW7PNwaH2f9eU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MUY60vDFx5ENgIq1VpDWeEPu+balb5hapqCM293on1DIZFh2cYpVCHJlm5C011VAFzeTRVI8DUACnKT7KinmVugq1BAI68plrJSJG554uq3Ql/Sq9Gzgl1b0A3HJmy4o8bTieK+g8ZNXtxhlTv1HQ5zRovRtBHRCiIXdjGPoAkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b321d74t6z6GDCT;
	Thu, 22 May 2025 16:45:41 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 6D9F4140142;
	Thu, 22 May 2025 16:46:37 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 22 May 2025 10:46:37 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Thu, 22 May 2025 10:46:37 +0200
From: Shiju Jose <shiju.jose@huawei.com>
To: "alison.schofield@intel.com" <alison.schofield@intel.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH] cxl/features: Remove the inline specifier from to_cxlfs()
Thread-Topic: [PATCH] cxl/features: Remove the inline specifier from
 to_cxlfs()
Thread-Index: AQHbyqkzwKi36XebIkCmMeKZcUUlurPeVZOA
Date: Thu, 22 May 2025 08:46:37 +0000
Message-ID: <c83ef693e8844168a79d8dd335374f32@huawei.com>
References: <20250521233625.1745849-1-alison.schofield@intel.com>
In-Reply-To: <20250521233625.1745849-1-alison.schofield@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

>-----Original Message-----
>From: alison.schofield@intel.com <alison.schofield@intel.com>
>Sent: 22 May 2025 00:36
>To: Davidlohr Bueso <dave@stgolabs.net>; Jonathan Cameron
><jonathan.cameron@huawei.com>; Dave Jiang <dave.jiang@intel.com>; Alison
>Schofield <alison.schofield@intel.com>; Vishal Verma
><vishal.l.verma@intel.com>; Ira Weiny <ira.weiny@intel.com>; Dan Williams
><dan.j.williams@intel.com>
>Cc: linux-cxl@vger.kernel.org
>Subject: [PATCH] cxl/features: Remove the inline specifier from to_cxlfs()
>
>From: Alison Schofield <alison.schofield@intel.com>
>
>to_cxlfs() was declared 'inline' in the header but only defined in
>drivers/cxl/core/features.c. This has worked because features.c was the on=
ly file
>using the function and the definition happened to be available in the same
>compilation unit.
>
>However, in preparation for a second .c file using the header and needing =
to call
>the function, the inline specifier became an issue.
>Sparse flagged the declaration as invalid since 'inline' requires a visibl=
e
>definition at the point of use.
>
>Defining the function in the header was considered but rejected, as it dep=
ends
>on internal symbols not visible at that level.
>
>Remove the inline specifier to correct the linkage violation.
>
>Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Thanks Alison.

Reviewed-by: Shiju Jose <shiju.jose@huawei.com>
>---
>
>I intentionally did not add a Fixes Tag at the point this was introduced b=
ecause
>there is no breakage until the second user comes along.
>
>The second user is this patchset being reviewed:
>[PATCH v6 0/8] cxl: support CXL memory RAS features
>https://lore.kernel.org/linux-cxl/20250521124749.817-1-
>shiju.jose@huawei.com/
>
>
> drivers/cxl/core/features.c | 2 +-
> include/cxl/features.h      | 2 +-
> 2 files changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c ind=
ex
>1498e2369c37..efe88c043227 100644
>--- a/drivers/cxl/core/features.c
>+++ b/drivers/cxl/core/features.c
>@@ -36,7 +36,7 @@ static bool is_cxl_feature_exclusive(struct cxl_feat_ent=
ry
>*entry)
> 	return is_cxl_feature_exclusive_by_uuid(&entry->uuid);
> }
>
>-inline struct cxl_features_state *to_cxlfs(struct cxl_dev_state *cxlds)
>+struct cxl_features_state *to_cxlfs(struct cxl_dev_state *cxlds)
> {
> 	return cxlds->cxlfs;
> }
>diff --git a/include/cxl/features.h b/include/cxl/features.h index
>5f7f842765a5..b9297693dae7 100644
>--- a/include/cxl/features.h
>+++ b/include/cxl/features.h
>@@ -64,7 +64,7 @@ struct cxl_features_state {  struct cxl_mailbox;  struct
>cxl_memdev;  #ifdef CONFIG_CXL_FEATURES -inline struct cxl_features_state
>*to_cxlfs(struct cxl_dev_state *cxlds);
>+struct cxl_features_state *to_cxlfs(struct cxl_dev_state *cxlds);
> int devm_cxl_setup_features(struct cxl_dev_state *cxlds);  int
>devm_cxl_setup_fwctl(struct device *host, struct cxl_memdev *cxlmd);  #els=
e
>
>base-commit: 92a09c47464d040866cf2b4cd052bc60555185fb
>--
>2.37.3
>

