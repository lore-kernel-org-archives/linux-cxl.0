Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFAA22541B
	for <linux-cxl@vger.kernel.org>; Tue, 24 Jun 2025 19:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750792910; cv=none; b=TCEOXeDF7ZuQ1ST1cAzW7V2U2XFvbIp3KAyr8+g9YTOKXdP0ipelfTX1ZdHYf0qof60ifNPhP96gTo9Y4R6ThBxoRGVGeuftXOXqY//zkrDnBRrKXGbqM2DuNYe3FvPniwMDcXp/h4X0gtgFr7rjU3DEHWqeRonuMiN3O8iviow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750792910; c=relaxed/simple;
	bh=A+vYjbtf87rqj5nqUonBqTa9TtCzS7H/NQIjFIzxbi0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Cuo7ElVNGv3NoEJG1dIi6Vmu3bKP8Lwz8hB+zy2Pls2byd23Txv7FkN12H1zC0TxOj0W58ck9ylmsSXvjsW5EMXZsGJA1Ud3NxpYisQcZBMrX6vcyTTOENFEh/GcSy0B0U4s87/sy1a9yQVJ67kBTJkhPaZJT1Wph74OY7FRuB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bRZWQ0hF2z6D8rn;
	Wed, 25 Jun 2025 03:19:14 +0800 (CST)
Received: from frapeml100007.china.huawei.com (unknown [7.182.85.133])
	by mail.maildlp.com (Postfix) with ESMTPS id BF5671404A6;
	Wed, 25 Jun 2025 03:21:44 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100007.china.huawei.com (7.182.85.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 24 Jun 2025 21:21:44 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Tue, 24 Jun 2025 21:21:44 +0200
From: Shiju Jose <shiju.jose@huawei.com>
To: Alok Tiwari <alok.a.tiwari@oracle.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "dave@stgolabs.net" <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>
Subject: RE: [PATCH] cxl/edac: Use correct format specifier for u32 val
Thread-Topic: [PATCH] cxl/edac: Use correct format specifier for u32 val
Thread-Index: AQHb46XMvW0oxhT1yUO1xTtdJeZ2c7QSsv0A
Date: Tue, 24 Jun 2025 19:21:44 +0000
Message-ID: <156bcdadf29144999f42896d5d0421a7@huawei.com>
References: <20250622183919.4156343-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20250622183919.4156343-1-alok.a.tiwari@oracle.com>
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
>From: Alok Tiwari <alok.a.tiwari@oracle.com>
>Sent: 22 June 2025 19:39
>To: linux-cxl@vger.kernel.org; dave@stgolabs.net; Jonathan Cameron
><jonathan.cameron@huawei.com>; dave.jiang@intel.com;
>alison.schofield@intel.com; vishal.l.verma@intel.com; ira.weiny@intel.com;
>dan.j.williams@intel.com
>Cc: alok.a.tiwari@oracle.com
>Subject: [PATCH] cxl/edac: Use correct format specifier for u32 val
>
>The dev_dbg() message in cxl_set_ecs_threshold() used %d for an unsigned
>value, which could lead to incorrect logging.
>Update the format specifier to %u to match variable type.
>
>Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
Reviewed-by: Shiju Jose <shiju.jose@huawei.com>
>---
> drivers/cxl/core/edac.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c index
>2cbc664e5d626..76cb016e0bd9a 100644
>--- a/drivers/cxl/core/edac.c
>+++ b/drivers/cxl/core/edac.c
>@@ -693,7 +693,7 @@ static int cxl_set_ecs_threshold(struct device *dev, u=
8
>*log_cap, u16 *config,
> 				      ECS_THRESHOLD_IDX_4096);
> 		break;
> 	default:
>-		dev_dbg(dev, "Invalid CXL ECS threshold count(%d) to set\n",
>+		dev_dbg(dev, "Invalid CXL ECS threshold count(%u) to set\n",
> 			val);
> 		dev_dbg(dev, "Supported ECS threshold counts: %u, %u, %u\n",
> 			ECS_THRESHOLD_256, ECS_THRESHOLD_1024,
>--
>2.46.0
>

