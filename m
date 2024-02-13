Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B595F551
	for <linux-cxl@vger.kernel.org>; Tue, 13 Feb 2024 17:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707846252; cv=none; b=oAMxWWE2e5jXsjpK5jXJKV07lwPK2yQ7J+5NQxER5YgAuTOBT+IMZDmk8JV3lo9qoMBU2nTf+92Rsvt23KNgCXX7ziCbeXjpgTnhQw8GKKx5UgnZDN4qfFlz0pRzwJkrIJ7jcyH8OTdekWXV0SAvw0tUTsJ0RnSnFLVivk8JegY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707846252; c=relaxed/simple;
	bh=sVt05EqO6ziUyy3HBGu20qeUuUX+zwyZmrLC0iOHSAY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ux11tNoCAchAWo/VbIZfyv+sduMmTP0vtwv6ZM7sykggi58GM5NecdKa6aIYc4SVq6v0WTT1pehzMwoHrgyOvoaGSs94Sx8mQYArIcN8xPUHXDb+wkdjBesI6ERKnU8o26ycxnUVJ/cRqWhoufpkyDU5Jerets61EKItY+7tHEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TZ7rV1Ckwz6J9yP;
	Wed, 14 Feb 2024 01:40:10 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 6C8361400D9;
	Wed, 14 Feb 2024 01:44:07 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 13 Feb
 2024 17:44:06 +0000
Date: Tue, 13 Feb 2024 17:44:05 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <nifan.cxl@gmail.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>,
	<a.manzanares@samsung.com>, <dave@stgolabs.net>, <nmtadam.samsung@gmail.com>,
	<nifan@outlook.com>, <jim.harris@samsung.com>, "Fan Ni" <fan.ni@samsung.com>
Subject: Re: [PATCH v3 8/9] hw/cxl/events: Add qmp interfaces to add/release
 dynamic capacity extents
Message-ID: <20240213174405.00002568@Huawei.com>
In-Reply-To: <20231107180907.553451-9-nifan.cxl@gmail.com>
References: <20231107180907.553451-1-nifan.cxl@gmail.com>
	<20231107180907.553451-9-nifan.cxl@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

> diff --git a/qapi/cxl.json b/qapi/cxl.json
> index 8cc4c72fa9..6b631f64f1 100644
> --- a/qapi/cxl.json
> +++ b/qapi/cxl.json
> @@ -25,7 +25,8 @@
>    'data': ['informational',
>             'warning',
>             'failure',
> -           'fatal']
> +           'fatal',
> +           'dyncap']
>   }
Needs a docs update.

Upstream QEMU seems to have gained some stricter checks
so this just broke my build after a rebase.

Jonathan
