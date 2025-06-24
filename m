Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8172D4B55;
	Tue, 24 Jun 2025 14:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750776553; cv=none; b=Fl93anyBb2tHH3IS2vx8LIN0qv/uT0HJn4ODSSAg/p35V1BNN+sni5iHoHGETsRG4GixPiJMv3PxT8NpDIhSw/ShwcIxSdC95a5dP8CgYTK2KDQy58tL2cHQyu0L7rtL4Vz/Urhm5L67wfCEvBekh8FW1rf7AY5DZtrwBX4QXtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750776553; c=relaxed/simple;
	bh=k63dUMrxuP+pXkGPYNOLQuLDInZ1Aa1nDtY8Wekcx+c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LHJ0gaBFHUygTn/8jkV9iwgMa3GXERsABCyY0PvL/iJbHhdg+1oSnVaq8VkDEDlAlnASr6FoXncSKTAxuaErHaA3AJM7RmkOryOlIw/YmCTC64K2k+ZtYr52XIoulh4iNg0QNPFuuiqOiRVEFBOXxtecXqWJPAvE7NUbRorHTlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bRSQ10dF4z6J69c;
	Tue, 24 Jun 2025 22:44:09 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id ABC1B140158;
	Tue, 24 Jun 2025 22:49:08 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 24 Jun 2025 16:49:08 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Tue, 24 Jun 2025 16:49:08 +0200
From: Shiju Jose <shiju.jose@huawei.com>
To: Li Ming <ming.li@zohomail.com>, "dave@stgolabs.net" <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] cxl/edac: Fix using wrong repair type to check dram
 event record
Thread-Topic: [PATCH 1/1] cxl/edac: Fix using wrong repair type to check dram
 event record
Thread-Index: AQHb4aRbXn0MH+hivkiQkxp6bmOsr7QSaqzw
Date: Tue, 24 Jun 2025 14:49:08 +0000
Message-ID: <3f0636a92de94d608276a1f6da17e4d7@huawei.com>
References: <20250620052924.138892-1-ming.li@zohomail.com>
In-Reply-To: <20250620052924.138892-1-ming.li@zohomail.com>
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
>Sent: 20 June 2025 06:29
>To: dave@stgolabs.net; Jonathan Cameron <jonathan.cameron@huawei.com>;
>dave.jiang@intel.com; alison.schofield@intel.com; vishal.l.verma@intel.com=
;
>ira.weiny@intel.com; dan.j.williams@intel.com; Shiju Jose
><shiju.jose@huawei.com>
>Cc: linux-cxl@vger.kernel.org; linux-kernel@vger.kernel.org; Li Ming
><ming.li@zohomail.com>
>Subject: [PATCH 1/1] cxl/edac: Fix using wrong repair type to check dram e=
vent
>record
>
>cxl_find_rec_dram() is used to find a DRAM event record based on the input=
ted
>attributes. Different repair_type of the inputted attributes will check th=
e DRAM
>event record in different ways.
>When EDAC driver is performing a memory rank sparing, it should use
>CXL_RANK_SPARING rather than CXL_BANK_SPARING as repair_type for DRAM
>event record checking.
>
>Fixes: 588ca944c277 ("cxl/edac: Add CXL memory device memory sparing
>control feature")
>Signed-off-by: Li Ming <ming.li@zohomail.com>
>---
>base-commit: 3c70ec71abdaf4e4fa48cd8fdfbbd864d78235a8 cxl/fixes

Reviewed-by: Shiju Jose <shiju.jose@huawei.com>
>---
> drivers/cxl/core/edac.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c index
>d725ee954199..623aaa4439c4 100644
>--- a/drivers/cxl/core/edac.c
>+++ b/drivers/cxl/core/edac.c
>@@ -1323,7 +1323,7 @@ cxl_mem_get_rec_dram(struct cxl_memdev *cxlmd,
> 		attrbs.bank =3D ctx->bank;
> 	break;
> 	case EDAC_REPAIR_RANK_SPARING:
>-		attrbs.repair_type =3D CXL_BANK_SPARING;
>+		attrbs.repair_type =3D CXL_RANK_SPARING;
> 		break;
> 	default:
> 		return NULL;
>--
>2.34.1

