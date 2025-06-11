Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9EF23D2B1;
	Wed, 11 Jun 2025 10:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749638648; cv=none; b=ZD5mWqLY7GIttPh2knYpx2orMWZAIvVD4zZO7+va+NI+5dCMYeKDp8ldbA7bln1ZbRjiAV+ym9YgXm+A+9z7AS5AE2/cYPjFX5KweDX9GAH2vLkZOuA2ZD+HrZvu7GWlFNpPxa9REtmiDm60XCyLYp7VgNm/u04fdaLaSLkUh1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749638648; c=relaxed/simple;
	bh=gJ9pvMHHMZdtyEHvI20T7HG10qF8I0VjoKUThkWAfKI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jRWprg3ur4VY0WGENNTtGIOvSDvPjg2VVIBJX5kbqao07TY4S0MKPh/MuljoVFwIUWFkniZo0Uwrn1GrZjkh8J7+yF4sOiwiCyOhHMi+3gUh20V4jv74ddfh4qUchmVqkXAR8MdDHDY570YckHn4UQyOxq+NDBNb+baTHGP4KgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bHMhT5gWYz6M50l;
	Wed, 11 Jun 2025 18:43:37 +0800 (CST)
Received: from frapeml100006.china.huawei.com (unknown [7.182.85.201])
	by mail.maildlp.com (Postfix) with ESMTPS id EEF651404FD;
	Wed, 11 Jun 2025 18:44:01 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100006.china.huawei.com (7.182.85.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 11 Jun 2025 12:44:01 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Wed, 11 Jun 2025 12:44:01 +0200
From: Shiju Jose <shiju.jose@huawei.com>
To: Li Ming <ming.li@zohomail.com>, "dave@stgolabs.net" <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] cxl/edac: Fix potential memory leak issues
Thread-Topic: [PATCH 1/1] cxl/edac: Fix potential memory leak issues
Thread-Index: AQHb2oIwmpZ4onuTlE2PS5sH4NovFbP9xXKg
Date: Wed, 11 Jun 2025 10:44:01 +0000
Message-ID: <d44aac6a202d4e1695a52ddc0e33a735@huawei.com>
References: <20250611033542.96184-1-ming.li@zohomail.com>
In-Reply-To: <20250611033542.96184-1-ming.li@zohomail.com>
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
>From: Li Ming <ming.li@zohomail.com>
>Sent: 11 June 2025 04:36
>To: dave@stgolabs.net; Jonathan Cameron <jonathan.cameron@huawei.com>;
>dave.jiang@intel.com; alison.schofield@intel.com; vishal.l.verma@intel.com=
;
>ira.weiny@intel.com; dan.j.williams@intel.com; Shiju Jose
><shiju.jose@huawei.com>
>Cc: linux-cxl@vger.kernel.org; linux-kernel@vger.kernel.org; Li Ming
><ming.li@zohomail.com>
>Subject: [PATCH 1/1] cxl/edac: Fix potential memory leak issues
>
>In cxl_store_rec_gen_media() and cxl_store_rec_dram(), use kmemdup() to
>duplicate a cxl gen_media/dram event to store the event in a xarray by
>xa_store(). The cxl gen_media/dram event allocated by kmemdup() should be
>freed in the case that the xa_store() fails.
>
>Fixes: 0b5ccb0de1e2 ("cxl/edac: Support for finding memory operation
>attributes from the current boot")
>Signed-off-by: Li Ming <ming.li@zohomail.com>

Thanks Ming for fixing.=20

Tested-by: Shiju Jose <shiju.jose@huawei.com>=20
Reviewed-by: Shiju Jose <shiju.jose@huawei.com>

>---
>base-commit: 87b42c114cdda76c8ad3002f2096699ad5146cb3 cxl/fixes
>---
> drivers/cxl/core/edac.c | 10 ++++++----
> 1 file changed, 6 insertions(+), 4 deletions(-)
>
>diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c index
>2cbc664e5d62..b4c5c23a45d4 100644
>--- a/drivers/cxl/core/edac.c
>+++ b/drivers/cxl/core/edac.c
>@@ -1086,13 +1086,13 @@ static void cxl_del_overflow_old_recs(struct xarra=
y
>*rec_xarray)  int cxl_store_rec_gen_media(struct cxl_memdev *cxlmd, union
>cxl_event *evt)  {
> 	struct cxl_mem_err_rec *array_rec =3D cxlmd->err_rec_array;
>-	struct cxl_event_gen_media *rec;
> 	void *old_rec;
>
> 	if (!IS_ENABLED(CONFIG_CXL_EDAC_MEM_REPAIR) || !array_rec)
> 		return 0;
>
>-	rec =3D kmemdup(&evt->gen_media, sizeof(*rec), GFP_KERNEL);
>+	struct cxl_event_gen_media *rec __free(kfree) =3D
>+		kmemdup(&evt->gen_media, sizeof(*rec), GFP_KERNEL);
> 	if (!rec)
> 		return -ENOMEM;
>
>@@ -1106,6 +1106,7 @@ int cxl_store_rec_gen_media(struct cxl_memdev
>*cxlmd, union cxl_event *evt)
>
> 	cxl_del_expired_gmedia_recs(&array_rec->rec_gen_media, rec);
> 	cxl_del_overflow_old_recs(&array_rec->rec_gen_media);
>+	retain_and_null_ptr(rec);
>
> 	return 0;
> }
>@@ -1114,13 +1115,13 @@
>EXPORT_SYMBOL_NS_GPL(cxl_store_rec_gen_media, "CXL");  int
>cxl_store_rec_dram(struct cxl_memdev *cxlmd, union cxl_event *evt)  {
> 	struct cxl_mem_err_rec *array_rec =3D cxlmd->err_rec_array;
>-	struct cxl_event_dram *rec;
> 	void *old_rec;
>
> 	if (!IS_ENABLED(CONFIG_CXL_EDAC_MEM_REPAIR) || !array_rec)
> 		return 0;
>
>-	rec =3D kmemdup(&evt->dram, sizeof(*rec), GFP_KERNEL);
>+	struct cxl_event_dram *rec __free(kfree) =3D
>+		kmemdup(&evt->dram, sizeof(*rec), GFP_KERNEL);
> 	if (!rec)
> 		return -ENOMEM;
>
>@@ -1134,6 +1135,7 @@ int cxl_store_rec_dram(struct cxl_memdev *cxlmd,
>union cxl_event *evt)
>
> 	cxl_del_expired_dram_recs(&array_rec->rec_dram, rec);
> 	cxl_del_overflow_old_recs(&array_rec->rec_dram);
>+	retain_and_null_ptr(rec);
>
> 	return 0;
> }
>--
>2.34.1

