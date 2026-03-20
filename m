Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20C228643A
	for <linux-cxl@vger.kernel.org>; Fri, 20 Mar 2026 14:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774017216; cv=none; b=oZQ0Fqu1o+ldZMhuypqfjTMR6hxOI/BqcaRHR2c2rysFYnrSAhG+jqZBEU9XIzQNiHkiXBYoj6aiW7dC7I+xTER7HIXSer3dIwHp9mrm3mvb85TyKxf+w8EqIioSLkeOf21LfrQ0ZriSkjcvRfn53/MMShiLphWTfsNHGZrKzmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774017216; c=relaxed/simple;
	bh=g/4+Pczgnk/lIcqeYbkpp5igXCcNjvRoqsvep0JRJRE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XlKbTfK3A9MZCFfTTlHMePG8ptsH7SF7Fr4DVLXRtw0r3QxSYfa5sN5XFIvvBjArhB49fWIb3NFGaXcwkc+2WqgxPsq3zGxfJpW7egMHKPRUm7DnuxID55ZD0H3eRgIbcvn8FXmPsi7WE79MpAnyzfiQuZZEvc8AbU+VQkj2oSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fclR00rhczHnGhl;
	Fri, 20 Mar 2026 22:33:00 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id B70FD40587;
	Fri, 20 Mar 2026 22:33:25 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 20 Mar
 2026 14:33:25 +0000
Date: Fri, 20 Mar 2026 14:33:23 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <dave@stgolabs.net>,
	<alison.schofield@intel.com>
Subject: Re: [PATCH v3] cxl: Add endpoint decoder flags clear when PCI reset
 happens
Message-ID: <20260320143323.00004013@huawei.com>
In-Reply-To: <20260319152541.2739343-1-dave.jiang@intel.com>
References: <20260319152541.2739343-1-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Thu, 19 Mar 2026 08:25:41 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> When a PCI reset happens, the lock and enable flags of the CXL device
> should be cleared to avoid stale state flags after reset. Add flag
> clearing during cxl_reset_done() to clear the relevant endpoint
> decoder flags for all decoders of the endpoint device.
> 
> Reported-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

Thanks for quick turnaround!  Major advantage for me being
rare case where I could still remember the context without having
to go reread the earlier threads :)

