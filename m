Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834D4149C64
	for <linux-cxl@vger.kernel.org>; Fri, 26 Apr 2024 16:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714147550; cv=none; b=uaqGE9Dsf8979RTYmQ/xrrbOB9pWrOxiqUbZChHdT/POoNTdqshbIGt8AtxWCB1SqqiY28mjS2I4GcF0PZxZAxp0aZQdqp7hukf1PasIfCocC/EMQTqGwBAP5JRf0nBC4dPt2nJG7PJtOeB5nRNrHwsYVFBdIhHleTizpb7cpcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714147550; c=relaxed/simple;
	bh=6pOkIBprxHTq5lS1Kf6DdJH3kDswt94wNlUqFlX6KNg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SerqynscJ2kLoYoW0rmzm/530uJrL0BAW2KfPFn27jB6+qV6xp1YyXjDo7pVP6dn2xj3vmUZ5W8g0YSmnTjLwDiY6sHj19x9FSNvOh/3wMV0TQ+oTgy4rlIJx1Gh89MzWbpIZiPVFm9Bwy42FtXOr2+2vlrZspSg1Qaa0il0ynI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VQyHd2vcSz6D94c;
	Sat, 27 Apr 2024 00:05:33 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 35FFB1408F9;
	Sat, 27 Apr 2024 00:05:45 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 26 Apr
 2024 17:05:44 +0100
Date: Fri, 26 Apr 2024 17:05:43 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <sthanneeru.opensrc@micron.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<john@jagalactic.com>, <emirakhur@micron.com>, <ajayjoshi@micron.com>,
	<Ravis.OpenSrc@micron.com>, <sthanneeru@micron.com>
Subject: Re: [PATCH v3 2/2] cxl/mbox: Add Clear Log mailbox command
Message-ID: <20240426170543.00000663@Huawei.com>
In-Reply-To: <20240313071218.729-3-sthanneeru.opensrc@micron.com>
References: <20240313071218.729-1-sthanneeru.opensrc@micron.com>
	<20240313071218.729-3-sthanneeru.opensrc@micron.com>
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
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 13 Mar 2024 12:42:18 +0530
<sthanneeru.opensrc@micron.com> wrote:

> From: Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>
> 
> Adding UAPI support for CXL r3.1 8.2.9.5.4
> Clear Log command.
> 
> This proposed patch will be useful for clearing and populating
> the Vendor debug log in certain scenarios, allowing for the
> aggregation of results over time.
> 
> Signed-off-by: Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>
Also harmless (with this restriction to vendor debug log) and useful.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>



