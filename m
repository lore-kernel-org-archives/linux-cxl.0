Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE7B1A073F
	for <linux-cxl@vger.kernel.org>; Wed,  4 Feb 2026 11:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770203720; cv=none; b=nieaiAW/TTDsKAH2/WfwgjniS7SDNHINrpGUGiY2saW2jnY7sfI8hNNGLMZGmt+7XaSqnVtbQd/R4Wz/gKbgx2zYMyskbUBESDX6tbrybsEpxmyRGFB1feAB9M7bUdU01bXxxVNBwD0/U0N4uY0bA015F9xlRJsRgxBG40yQGKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770203720; c=relaxed/simple;
	bh=0ltJSVeg7+gMFifyRqNLr2EjJQlmOwXLodbfSklSBy0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CL4xnrOYpq/uunT3WkXb16UAGpRP0pXKXIDcI+e25huARsBbR3ej+E5WZ248OaFUFwd7/qxkg45/Y9+Mkpc66PSYDh/LTqjiJpiq4/xyUv/j2hnPr/PMZ1k7wFGq/GSd9T71hI+NVcU22YxRMTqUpUxw5vKqhD6RK16+Z2kb17I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f5d6D5JljzJ46F6;
	Wed,  4 Feb 2026 19:14:28 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id A462D40571;
	Wed,  4 Feb 2026 19:15:17 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 4 Feb
 2026 11:15:17 +0000
Date: Wed, 4 Feb 2026 11:15:15 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Michael Tsirkin <mst@redhat.com>, <qemu-devel@nongnu.org>, "Vinayak
 Holikatti" <vinayak.kh@samsung.com>, <linuxarm@huawei.com>
CC: <linux-cxl@vger.kernel.org>, Ravi Shankar <venkataravis@micron.com>, Peter
 Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH qemu 0/2] hw/cxl: Two media operations related fixes.
Message-ID: <20260204111442.00000e13@huawei.com>
In-Reply-To: <20260102154731.474859-1-Jonathan.Cameron@huawei.com>
References: <20260102154731.474859-1-Jonathan.Cameron@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Fri, 2 Jan 2026 15:47:29 +0000
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> Peter reported both of these last cycle.  Both are related to sanity
> checking parameters.

Hi Michael

Just a reminder to take a look at and if possible queue these up.

I see I didn't +CC Peter. Sorry about that Peter. If you could sanity
check as they are fixes for bugs you reported a while back.

Thanks,

Jonathan

> 
> Jonathan Cameron (2):
>   hw/cxl: Check for overflow on santize media as both base and offset
>     64bit.
>   hw/cxl: Take into account how many media operations are requested for
>     param check
> 
>  hw/cxl/cxl-mailbox-utils.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 

