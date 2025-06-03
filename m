Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6F2155C82;
	Tue,  3 Jun 2025 17:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748970421; cv=none; b=K+4QfZvLhPX8VU6lUMKnAGDQXEIiv0R4GvK+O0kw//nmTy9R49TCFV5RLt7AZbZ6mr62iMIXmNNjGmwzDmCxE1myQXGQ8x9z/7yfBoBCSZ4+40/3iGb2//D4OfpfnRvltTaiQ6SyEU4Agc3J45q0F2Vycn1q6qtNoqXSuZ4irwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748970421; c=relaxed/simple;
	bh=i6QpDQSeBsKF42yVvc4pQ/tmFz+KyMX1NkhEKe/Qr64=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Yv0XCm0sLDpUqgehdMxCssmuL8rXhhxTYabiJWEOU9QiH/7XrwT2m85SVNjQVBWloU2hxjbsYHbwhffEqKhyvdAYmpiGYuoTlH3rPyuWgpu83MjR9TKvrqebkk5ScOcFRWWJ64PFB4GNvCTF9yYsxlzLcoZYXSycFAyHhRblJeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bBcXh3Ypqz6K9D2;
	Wed,  4 Jun 2025 01:05:24 +0800 (CST)
Received: from frapeml100007.china.huawei.com (unknown [7.182.85.133])
	by mail.maildlp.com (Postfix) with ESMTPS id 21CC11404C5;
	Wed,  4 Jun 2025 01:06:55 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100007.china.huawei.com (7.182.85.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 3 Jun 2025 19:06:54 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Tue, 3 Jun 2025 19:06:54 +0200
From: Shiju Jose <shiju.jose@huawei.com>
To: Li Ming <ming.li@zohomail.com>, "dave@stgolabs.net" <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 1/2] cxl/edac: Fix the min_scrub_cycle of a region
 miscalculation
Thread-Topic: [PATCH v1 1/2] cxl/edac: Fix the min_scrub_cycle of a region
 miscalculation
Thread-Index: AQHb1HRe2L8Bqhz0UUKRS5iJHdTV5bPxqo+w
Date: Tue, 3 Jun 2025 17:06:54 +0000
Message-ID: <32f7cc85f82c4ec79d1864e0f02f3016@huawei.com>
References: <20250603104314.25569-1-ming.li@zohomail.com>
In-Reply-To: <20250603104314.25569-1-ming.li@zohomail.com>
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
>Sent: 03 June 2025 11:43
>To: dave@stgolabs.net; Jonathan Cameron <jonathan.cameron@huawei.com>;
>dave.jiang@intel.com; alison.schofield@intel.com; vishal.l.verma@intel.com=
;
>ira.weiny@intel.com; dan.j.williams@intel.com; Shiju Jose
><shiju.jose@huawei.com>
>Cc: linux-cxl@vger.kernel.org; linux-kernel@vger.kernel.org; Li Ming
><ming.li@zohomail.com>
>Subject: [PATCH v1 1/2] cxl/edac: Fix the min_scrub_cycle of a region
>miscalculation
>
>When trying to update the scrub_cycle value of a cxl region, which means
>updating the scrub_cycle value of each memdev under a cxl region. cxl driv=
er
>needs to guarantee the new scrub_cycle value is greater than the
>min_scrub_cycle value of a memdev, otherwise the updating operation will
>fail(Per Table 8-223 in CXL r3.2 section 8.2.10.9.11.1).
>
>Current implementation logic of getting the min_scrub_cycle value of a cxl
>region is that getting the min_scrub_cycle value of each memdevs under the=
 cxl
>region, then using the minimum min_scrub_cycle value as the region's
>min_scrub_cycle. Checking if the new scrub_cycle value is greater than thi=
s
>value. If yes, updating the new scrub_cycle value to each memdevs. The iss=
ue is
>that the new scrub_cycle value is possibly greater than the minimum
>min_scrub_cycle value of all memdevs but less than the maximum
>min_scrub_cycle value of all memdevs if memdevs have a different
>min_scrub_cycle value. The updating operation will always fail on these
>memdevs which have a greater min_scrub_cycle than the new scrub_cycle.
>
>The correct implementation logic is to get the maximum value of these
>memdevs' min_scrub_cycle, check if the new scrub_cycle value is greater th=
an
>the value. If yes, the new scrub_cycle value is fit for the region.
>
>The change also impacts the result of
>cxl_patrol_scrub_get_min_scrub_cycle(), the interface returned the minimum
>min_scrub_cycle value among all memdevs under the region before the change=
.
>The interface will return the maximum min_scrub_cycle value among all
>memdevs under the region with the change.
>

Reviewed-by: Shiju Jose <shiju.jose@huawei.com>

>Signed-off-by: Li Ming <ming.li@zohomail.com>
>---
>Changes from RFC:
>1. Add more description about the max scrub cycle. (Alison) 2. Add more
>description about the min scrub cycle of a region. (Alison) 3. Drop RFC ta=
g.
>
>base-commit: 9f153b7fb5ae45c7d426851f896487927f40e501 cxl/next
>---
> drivers/cxl/core/edac.c | 8 ++++++--
> 1 file changed, 6 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c index
>2cbc664e5d62..0ef245d0bd9f 100644
>--- a/drivers/cxl/core/edac.c
>+++ b/drivers/cxl/core/edac.c
>@@ -103,10 +103,10 @@ static int cxl_scrub_get_attrbs(struct
>cxl_patrol_scrub_context *cxl_ps_ctx,
> 				u8 *cap, u16 *cycle, u8 *flags, u8 *min_cycle)
>{
> 	struct cxl_mailbox *cxl_mbox;
>-	u8 min_scrub_cycle =3D U8_MAX;
> 	struct cxl_region_params *p;
> 	struct cxl_memdev *cxlmd;
> 	struct cxl_region *cxlr;
>+	u8 min_scrub_cycle =3D 0;
> 	int i, ret;
>
> 	if (!cxl_ps_ctx->cxlr) {
>@@ -133,8 +133,12 @@ static int cxl_scrub_get_attrbs(struct
>cxl_patrol_scrub_context *cxl_ps_ctx,
> 		if (ret)
> 			return ret;
>
>+		/*
>+		 * The min_scrub_cycle of a region is the max of minimum
>scrub
>+		 * cycles supported by memdevs that back the region.
>+		 */
> 		if (min_cycle)
>-			min_scrub_cycle =3D min(*min_cycle, min_scrub_cycle);
>+			min_scrub_cycle =3D max(*min_cycle, min_scrub_cycle);
> 	}
>
> 	if (min_cycle)
>--
>2.34.1

