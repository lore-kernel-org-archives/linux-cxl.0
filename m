Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12922459BF;
	Wed, 15 Jan 2025 13:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736947915; cv=none; b=eqcHQbgMuUyxEpmd7dra9LGpClNtc3R7THbJ0Dcs56WPw5+ZRkr6HixcQxK3vOS9506TjxkJxdBos+GHdxin1NZSpB+DWC6Iw2Ue8EK0NEPs7V7D6L07hmjokZDAhtU3wstn8Dy2Xyetz+bzIQ3dhPKEzBL5XmicUKr0e3CI3+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736947915; c=relaxed/simple;
	bh=2cpelZi2u6YSNhMqtW6yrrs03Gjb/ntXot6HF99wuA4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D5tSuoqs9/jvIiktT0/tNo0zT7vOTr4yrbiCz3CpnQtvKELisDf4EShkdAje6R3X6B6D0qN8LfSp+s2fY27GU+cFyQre1+jIkX6jQ4HyQmEdjZUTsdTdieqKFhbkM+E8xpeSg5NmOajTn/OqdH90aF9uXPv5q81dbs5MzTzk4Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YY6Gk5HMNz6K9Kh;
	Wed, 15 Jan 2025 21:26:54 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id F3539140A35;
	Wed, 15 Jan 2025 21:31:49 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 15 Jan
 2025 14:31:49 +0100
Date: Wed, 15 Jan 2025 13:31:48 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/port: Constify 'struct bin_attribute'
Message-ID: <20250115133148.00001cb6@huawei.com>
In-Reply-To: <20250114-sysfs-const-bin_attr-cxl-v1-1-5afa23fe2a52@weissschuh.net>
References: <20250114-sysfs-const-bin_attr-cxl-v1-1-5afa23fe2a52@weissschuh.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 14 Jan 2025 22:25:14 +0100
Thomas Wei=DFschuh <linux@weissschuh.net> wrote:

> The sysfs core now allows instances of 'struct bin_attribute' to be
> moved into read-only memory. Make use of that to protect them against
> accidental or malicious modifications.
>=20
> Signed-off-by: Thomas Wei=DFschuh <linux@weissschuh.net>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

