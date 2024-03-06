Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82FB133402
	for <linux-cxl@vger.kernel.org>; Wed,  6 Mar 2024 15:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709737706; cv=none; b=fSegjODJiZlNGxIwHEan8iriPG1Y2Q2nMeqK6QtnnYQAZ06m0M5/p7c4bApkRLgZK6uzDbPzSkeLhJpCNPA/kp20RUQUAtCQ8GRcdvSQUZfDqQez1nRVunI0y9qTn/wG6nFKQddVui9zgBcYFsvV680LMeT543uDQwH0SQ5NM7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709737706; c=relaxed/simple;
	bh=sZ4SsExJ1Z/CXHIh/bcf194ua/BbQdbqiqgr1cu2F3s=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PkzZFi3JPRGA5O3nA4cGLs/78/v+Zt8iyEn+wkNAoSZ6Uk74zJ5c8MOqsRPe4HZVCH5pAYETYqiXLy2Q3vHDbXMS1e1v1qaSmM8xjC98H8j61ZJFlqkOZYTZlqszJ3zK3FBYtA15j6+FDfX9jaoEx0g+8wgliICTN241dEyp0Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TqbLc2PYTz6K7F9;
	Wed,  6 Mar 2024 23:04:24 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 5866A14196E;
	Wed,  6 Mar 2024 23:08:21 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 6 Mar
 2024 15:07:31 +0000
Date: Wed, 6 Mar 2024 15:07:30 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <nifan.cxl@gmail.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
	<gregory.price@memverge.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <a.manzanares@samsung.com>, <dave@stgolabs.net>,
	<nmtadam.samsung@gmail.com>, <jim.harris@samsung.com>,
	<Jorgen.Hansen@wdc.com>, <wj28.lee@gmail.com>, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v5 01/13] hw/cxl/cxl-mailbox-utils: Add
 dc_event_log_size field to output payload of identify memory device command
Message-ID: <20240306150730.00000d29@Huawei.com>
In-Reply-To: <20240304194331.1586191-2-nifan.cxl@gmail.com>
References: <20240304194331.1586191-1-nifan.cxl@gmail.com>
	<20240304194331.1586191-2-nifan.cxl@gmail.com>
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

On Mon,  4 Mar 2024 11:33:56 -0800
nifan.cxl@gmail.com wrote:

> From: Fan Ni <fan.ni@samsung.com>
> 
> Based on CXL spec r3.1 Table 8-127 (Identify Memory Device Output
> Payload), dynamic capacity event log size should be part of
> output of the Identify command.
> Add dc_event_log_size to the output payload for the host to get the info.
> 
> Signed-off-by: Fan Ni <fan.ni@samsung.com>
I'm going to give tags on this mostly so I can easily see what I was happy
with on any future versions if we need them.

If I end up sending the code to Michael, a may squash them into
just a SoB.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

