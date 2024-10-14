Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A0143AA9
	for <linux-cxl@vger.kernel.org>; Mon, 14 Oct 2024 14:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728917521; cv=none; b=dEYgDmoQdHSOa7zWHtGtpUUVZS++e6GOLAvE86V2KoVXgl6zyMFDqMF0EbaYMZLGUe0xn9xolqQup4IBcutl0VDCVa5nKg5UzZuPqdhAkc9QdoAqhhsUeE8l842PWL5mM+efD4d7KPmlRzsaZNsex8Vn92K9bgZfOX++xGmm6M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728917521; c=relaxed/simple;
	bh=8eFK8IUgErmzpwO1/lYrIeNLIkD/XotHbZ0yikD7WbA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fMmBcVencCn3+GEgszgZ0zKY4wTzeH7DbAgTete0DW0N0Az2BfGvSgpzE09yLTU+Hy2bPF9RiTHb36eofQB9lW+AJuXh9/1njhrOO6C5RUWUN7OcByS6UezJgLCmiZ4GwIEWByRzGGJ+UnJgD0iu/7F6vxAXxxX2Y6XrF7olZJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XS0Wy0wxZz6GC7R;
	Mon, 14 Oct 2024 22:50:22 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id DE3221400CA;
	Mon, 14 Oct 2024 22:51:56 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 14 Oct
 2024 16:51:55 +0200
Date: Mon, 14 Oct 2024 15:51:54 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <alejandro.lucero-palau@amd.com>,
	<dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<dave@stgolabs.net>, <fan.ni@samsung.com>, Alejandro Lucero
	<alucerop@amd.com>
Subject: Re: [PATCH v4 2/3] cxl: Move mailbox related bits to the same
 context
Message-ID: <20241014155154.00001d5a@Huawei.com>
In-Reply-To: <20240905223711.1990186-3-dave.jiang@intel.com>
References: <20240905223711.1990186-1-dave.jiang@intel.com>
	<20240905223711.1990186-3-dave.jiang@intel.com>
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
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 5 Sep 2024 15:35:46 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Create a new 'struct cxl_mailbox' and move all mailbox related bits to
> it. This allows isolation of all CXL mailbox data in order to export
> some of the calls to external kernel callers and avoid exporting of CXL
> driver specific bits such has device states. The allocation of
> 'struct cxl_mailbox' is also split out with cxl_mailbox_create() so the
> mailbox can be created independently.
> 
> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> Reviewed-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Link: https://patch.msgid.link/20240724185649.2574627-2-dave.jiang@intel.com
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

LGTM.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Note this is currently being carried in Shiju's RAS features set
as well.  What is the merge plan?  My preference is an immutable branch
that Borislav could pull into the EDAC tree and on which we can base
other stuff in CXL 
That is a branch based on 6.12-rc1 directly with an appropriate tag
that Shiju's patch set can refer to.

Thanks,

Jonathan
