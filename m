Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D96910A39
	for <linux-cxl@vger.kernel.org>; Fri, 21 Jun 2024 16:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718986831; cv=none; b=nOBIC+kc6z1cgd6v3ZPLnbGqpxJsF2HlIE1k60mapSqSY/sdk7YI8eOum/eLA/R6vLR/r86pWWPJ5jEmyJPdXEz/xJ134Mwa3foUqp4yfefD1zGeNz+ajFkNY9cCuSM68KhV5rClEtA8PK4RhAUE2o6jVYTh0cls5lMCR4Ttsq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718986831; c=relaxed/simple;
	bh=/Co0zMQI/Spa310mO0fkZ0PfkTB0P56AUmfD1wRkgIM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tNiCHv2qJZQmVin4y7d3qf/Jxpy4yBs8z0Wm0M9A30WLxZvyI9LJ5qZmjYnzUEWzGHxKr44YWvxs7bCRRcYavXr0n4AVimWDZVT6Je98yOxnJ8t5sbEbpU7AnOrhklCjVp8PBqwwcHP/bMAAVarst8GMfWgb1BB3QMD8yPDptp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W5Mwx2tcSz6K98T;
	Sat, 22 Jun 2024 00:18:41 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 59172140B38;
	Sat, 22 Jun 2024 00:20:16 +0800 (CST)
Received: from localhost (10.122.19.247) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 21 Jun
 2024 17:20:15 +0100
Date: Fri, 21 Jun 2024 17:20:14 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <imammedo@redhat.com>, <mst@redhat.com>, Markus Armbruster
	<armbru@redhat.com>, <qemu-devel@nongnu.org>, <ankita@nvidia.com>,
	<marcel.apfelbaum@gmail.com>, <philmd@linaro.org>, Richard Henderson
	<richard.henderson@linaro.org>
CC: <linuxarm@huawei.com>, Dave Jiang <dave.jiang@intel.com>, Huang Ying
	<ying.huang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
	<eduardo@habkost.net>, <linux-cxl@vger.kernel.org>, Michael Roth
	<michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v3 qemu 00/11] acpi: NUMA nodes for CXL HB as GP +
 complex NUMA test
Message-ID: <20240621172014.00007b7c@huawei.com>
In-Reply-To: <20240620160324.109058-1-Jonathan.Cameron@huawei.com>
References: <20240620160324.109058-1-Jonathan.Cameron@huawei.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 20 Jun 2024 17:03:08 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> v3: Thanks to Richard for help debugging BE issue and to Igor for
>     finding a bunch of other thing to improve via the context in
>     the fix patch.

I forgot to mention that his time I ran the bios tables test on
an emulated x86_64 machine on top of an emulated s390 (with the timeouts
massively increased as it took about 2 hours).

Hopefully no more surprises!

