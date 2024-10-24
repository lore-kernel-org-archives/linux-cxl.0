Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8673D170826
	for <linux-cxl@vger.kernel.org>; Thu, 24 Oct 2024 09:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729763017; cv=none; b=OY6obUAMEBjvLmbFVBvAeKKgnrRWQ7j03T7mLf+KBZ3qm00ZOgvQ86b0NVtUbt9J78gLws+DUnUZVGSB/xPrXDQmvjec8q0xf8oJhQBTo22e1WFcXNOBiss2lEEgSCPoVlVwSeqjy1gCwDsszOzZ0ows/O6xvbPEGrldvfw2Zbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729763017; c=relaxed/simple;
	bh=NuLopXHJArcbIBaeV/N5QXwyBlGRqMGIY1km6/XMerg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FXfX18wZy4cb0X+xCsM07cJmZ9fDi6mI6AGB0nSxqFo/N/7q2qgTYqq9Btk7RC1EcpN53jc2q6OzrK8rxwW+GDau5UIf/SpgZfa1C3n91/QxwYQzHWu1WMY+ZLpcayWobqsR5dKviQTP+wB28zhkUiWLrz/L+qf61MhOtI1KXik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XZ1D51wJ8z6K9CD;
	Thu, 24 Oct 2024 17:42:29 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id A9C4F140A79;
	Thu, 24 Oct 2024 17:43:29 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 24 Oct
 2024 11:43:29 +0200
Date: Thu, 24 Oct 2024 10:43:27 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave.jiang@intel.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 2/6] cxl/port: Fix cxl_bus_rescan() vs
 bus_rescan_devices()
Message-ID: <20241024104327.00007b7a@Huawei.com>
In-Reply-To: <172964781104.81806.4277549800082443769.stgit@dwillia2-xfh.jf.intel.com>
References: <172964779333.81806.8852577918216421011.stgit@dwillia2-xfh.jf.intel.com>
	<172964781104.81806.4277549800082443769.stgit@dwillia2-xfh.jf.intel.com>
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
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 22 Oct 2024 18:43:32 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> It turns out since its original introduction, pre-2.6.12,
> bus_rescan_devices() has skipped devices that might be in the process of
> attaching or detaching from their driver. For CXL this behavior is
> unwanted and expects that cxl_bus_rescan() is a probe barrier.
> 
> That behavior is simple enough to achieve with bus_for_each_dev() paired
> with call to device_attach(), and it is unclear why bus_rescan_devices()
> took the position of lockless consumption of dev->driver which is racy.
> 
> The "Fixes:" but no "Cc: stable" on this patch reflects that the issue
> is merely by inspection since the bug that triggered the discovery of
> this potential problem [1] is fixed by other means.  However, a stable
> backport should do no harm.
> 
> Fixes: 8dd2bc0f8e02 ("cxl/mem: Add the cxl_mem driver")
> Link: http://lore.kernel.org/20241004212504.1246-1-gourry@gourry.net [1]
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
