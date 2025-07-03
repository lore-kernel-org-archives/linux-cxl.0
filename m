Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1618F2E0411;
	Thu,  3 Jul 2025 09:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751536372; cv=none; b=Ygl1rFLfRrB/XK+gq+RVC4tWKQHBxUvFcn4pELkPSgPwbexMuh3gONuPYIAnyKeOt83l6dzikQ7Qw4NZy9bEOL0hGgKN8UgYl10BiySoChGOY65Z9BmJpRHIe+r1YkMc9dSoXyhqrUCANnchL/eQ3EteT+TL87MuSyfO0Bi1Rg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751536372; c=relaxed/simple;
	bh=mV7xMp6TFO+YQwzpnn+FnEIQmIkBb8Cgt9hINbPFbSA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rWQFzkIJ5g0hGnnQWEz/xy4eYQZK0k6t58jxUnnhFSL2GLQLOaP/wYxtpvhUJg596VyaiZ1TegcAlXJ5hPi/1G2U+n5f4cPovSShzwF5LaB9Xxy4X415SKc5CVItjrpBCWT9y+iv6ytFQqwvy1VfSeXFkqX9beltVTRRhJM3C/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bXsSH5xbsz6L51S;
	Thu,  3 Jul 2025 17:49:51 +0800 (CST)
Received: from frapeml100007.china.huawei.com (unknown [7.182.85.133])
	by mail.maildlp.com (Postfix) with ESMTPS id 896441402F0;
	Thu,  3 Jul 2025 17:52:47 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100007.china.huawei.com (7.182.85.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 3 Jul 2025 11:52:47 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Thu, 3 Jul 2025 11:52:47 +0200
From: Shiju Jose <shiju.jose@huawei.com>
To: Li Ming <ming.li@zohomail.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "andriy.shevchenko@linux.intel.com"
	<andriy.shevchenko@linux.intel.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "ilpo.jarvinen@linux.intel.com"
	<ilpo.jarvinen@linux.intel.com>, "dave@stgolabs.net" <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/3] resource: Introduce a new helper
 resource_contains_addr()
Thread-Topic: [PATCH v2 1/3] resource: Introduce a new helper
 resource_contains_addr()
Thread-Index: AQHb6yHhHtFU4bW2uUO6pVheFz/yK7QgJMAg
Date: Thu, 3 Jul 2025 09:52:47 +0000
Message-ID: <95a899051e5c46aca70aa0b0016c0f90@huawei.com>
References: <20250702072008.468371-1-ming.li@zohomail.com>
In-Reply-To: <20250702072008.468371-1-ming.li@zohomail.com>
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
>Sent: 02 July 2025 08:20
>To: akpm@linux-foundation.org; andriy.shevchenko@linux.intel.com;
>bhelgaas@google.com; ilpo.jarvinen@linux.intel.com; dave@stgolabs.net;
>Jonathan Cameron <jonathan.cameron@huawei.com>; dave.jiang@intel.com;
>alison.schofield@intel.com; vishal.l.verma@intel.com; ira.weiny@intel.com;
>dan.j.williams@intel.com; Shiju Jose <shiju.jose@huawei.com>
>Cc: linux-cxl@vger.kernel.org; linux-kernel@vger.kernel.org; Li Ming
><ming.li@zohomail.com>
>Subject: [PATCH v2 1/3] resource: Introduce a new helper
>resource_contains_addr()
>
>In CXL subsystem, many functions need to check an address availability by
>checking if the resource range contains the address. Providing a new helpe=
r
>function resource_contains_addr() to check if the resource range contains =
the
>input address.
>
>Suggested-by: Alison Schofield <alison.schofield@intel.com>
>Signed-off-by: Li Ming <ming.li@zohomail.com>
Tested-by: Shiju Jose <shiju.jose@huawei.com>
>---
>v2:
>* Implement a general helper resource_contains_addr(). (Alison)
>
>base-commit: 0a46f60a9fe16f5596b6b4b3ee1a483ea7854136 cxl/fixes
>---
> include/linux/ioport.h | 8 ++++++++
> 1 file changed, 8 insertions(+)
>
>diff --git a/include/linux/ioport.h b/include/linux/ioport.h index
>e8b2d6aa4013..75f5e9ccd549 100644
>--- a/include/linux/ioport.h
>+++ b/include/linux/ioport.h
>@@ -308,6 +308,14 @@ static inline bool resource_contains(const struct
>resource *r1, const struct res
> 	return r1->start <=3D r2->start && r1->end >=3D r2->end;  }
>
>+/* True if res contains addr */
>+static inline bool resource_contains_addr(const struct resource *res,
>+const resource_size_t addr) {
>+	if (res->flags & IORESOURCE_UNSET)
>+		return false;
>+	return res->start <=3D addr && addr <=3D res->end; }
>+
> /* True if any part of r1 overlaps r2 */  static inline bool
>resource_overlaps(const struct resource *r1, const struct resource *r2)  {
>--
>2.34.1

