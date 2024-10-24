Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64501C9B87
	for <linux-cxl@vger.kernel.org>; Thu, 24 Oct 2024 12:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729771870; cv=none; b=Qga/FfEXxj9p6d942XqRD8oGAPpCY5DcIlVw0rY188sBmvifxHBJEq7BE3D3waPSsuvAxq2T7vPrBxlKgwh5LamHrWN5frg1UVChrnaqLd/HIlMP5TD3/hnpO7cdxl3Y6I2IEZq+9RM7DFLgFaOU4TPFRhAqMhi7rQ66txnoip4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729771870; c=relaxed/simple;
	bh=N3lXyqhlpJ2pa0yxM6HCT/736VvT/5nO4mP3zIYnNto=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QY7Phk0nqJ/bC5rz5c8SHH0AmaD0QB6xrIn9ebptzwV6+wDxsd1kLkJ2ad3W5tH+0ScWgV3fGU0kz/RPkp3R+Y5dILNHoSdh3lUcJKy7/FX3+LmyaFnMFduPIXgMVfNuIF5SIp61U1BuwhNiStSRjK/oeM/U7JeF46/dlwORdDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XZ4VF1gJTz6K9JX;
	Thu, 24 Oct 2024 20:09:57 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 0567F140B39;
	Thu, 24 Oct 2024 20:10:58 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 24 Oct
 2024 14:10:57 +0200
Date: Thu, 24 Oct 2024 13:10:55 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <ira.weiny@intel.com>, Zijun Hu <quic_zijuhu@quicinc.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Vishal Verma <vishal.l.verma@intel.com>, "Alison
 Schofield" <alison.schofield@intel.com>, <dave.jiang@intel.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 5/6] cxl/port: Prevent out-of-order decoder
 allocation
Message-ID: <20241024131055.00000f84@Huawei.com>
In-Reply-To: <172964783668.81806.14962699553881333486.stgit@dwillia2-xfh.jf.intel.com>
References: <172964779333.81806.8852577918216421011.stgit@dwillia2-xfh.jf.intel.com>
	<172964783668.81806.14962699553881333486.stgit@dwillia2-xfh.jf.intel.com>
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
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 22 Oct 2024 18:43:57 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> With the recent change to allow out-of-order decoder de-commit it
> highlights a need to strengthen the in-order decoder commit guarantees.
> As it stands match_free_decoder() ensures that if 2 regions are racing
> decoder allocations the one that wins the race will get the lower id
> decoder, but that still leaves the race to *commit* the decoder.
> 
> Rather than have this complicated case of "reserved in-order, but may
> still commit out-of-order", just arrange for the reservation order to
> match the commit-order. In other words, prevent subsequent allocations
> until the last reservation is committed.
> 
> This precludes overlapping region creation events and requires the
> previous regionN to either move forward to the decoder commit stage or
> drop its reservation before regionN+1 can move forward. That is,
> provided that regionN and regionN+1 decode through the same switch port.
> 
> As a side effect this allows match_free_decoder() to drop its dependency
> on needing write access to the device_find_child() @data parameter [1].
> 
> Reported-by: Zijun Hu <quic_zijuhu@quicinc.com>
> Closes: http://lore.kernel.org/20240905-const_dfc_prepare-v4-0-4180e1d5a244@quicinc.com
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
LGTM
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
