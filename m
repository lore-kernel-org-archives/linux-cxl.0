Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFE12D3729
	for <linux-cxl@vger.kernel.org>; Thu,  3 Jul 2025 12:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751547103; cv=none; b=JEnPj6sovB7pJnJ6PEQyXD4THKh28yPg40+1X8MfFVJDZVhYropjNWXGoz1GQvmj3qvdTLNd6jUY7biAhaigKxt9KG6anbmuVpx3C5GHo2SYDC8MUnbIv8IYZMXs43CrTkCUmlrgBJSMfhSEWXmooXksZB9vDK10sEAxXUP768Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751547103; c=relaxed/simple;
	bh=69FII9ZCto5+BcoohL7Be1eTZUTApdGDKVq8rvNMKAY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NTXxI1yyZn9ZS6pDrSyV36VdvlGFkvalupTA28QsxXx6EQtsh8fmaBQBsCUxUSBEqDU1j/YCiUJxOel1KBcANJAjbHB1l7TAhaiuglmU73jA31QlkICsH2M2rxk1a2Ls35Bfka6kyfNsVwTvVZaqeNvq9TeTdIcqynVKlx6Ixp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bXxQd4xVcz6L5QC;
	Thu,  3 Jul 2025 20:48:41 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id C00F614044F;
	Thu,  3 Jul 2025 20:51:37 +0800 (CST)
Received: from localhost (10.122.19.247) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 3 Jul
 2025 14:51:37 +0200
Date: Thu, 3 Jul 2025 13:51:36 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <shiju.jose@huawei.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
	<fan.ni@samsung.com>, <dave@stgolabs.net>, <linuxarm@huawei.com>
Subject: Re: [PATCH v3 1/7] hw/cxl/events: Update for rev3.2 common event
 record format
Message-ID: <20250703135136.00002b0d@huawei.com>
In-Reply-To: <20250703091657.1868-2-shiju.jose@huawei.com>
References: <20250703091657.1868-1-shiju.jose@huawei.com>
	<20250703091657.1868-2-shiju.jose@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 3 Jul 2025 10:16:50 +0100
<shiju.jose@huawei.com> wrote:

> From: Shiju Jose <shiju.jose@huawei.com>
> 
> CXL spec 3.2 section 8.2.9.2.1 Table 8-55, Common Event Record
> format has updated with optional Maintenance Operation Subclass,
> LD ID and ID of the device head information.
> 
> Add updates for the above optional parameters in the related
> CXL events reporting and in the QMP commands to inject CXL events.
> 
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Hi Shiju,

Anisa's fmapi-dcd series moved one instance of this from cxl_type3.c to cxl/cxl-events.c
I'll tweak that whilst applying it to my gitlab tree.

Doesn't make any fundamental difference for anyone wishing to review
the series.

Thanks,

Jonathan

