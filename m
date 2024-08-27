Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC1D481CD
	for <linux-cxl@vger.kernel.org>; Tue, 27 Aug 2024 16:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724775910; cv=none; b=CMgdEoF9/xWHqzY20Gp8vIH0Zv4/Mqj8tR2GfPRdNwZ+PgluNdBgIdH8G/rQyKy9dUAKYhxgy1OZc5cO0YN3fY48YTAwi3vrQu+8I8XXBB6yGs56kWVAeKhNYvWQBkhyCnoOQ1TxkeixoOoDqm+MXzcn+e69iA58EqKV4nr+sSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724775910; c=relaxed/simple;
	bh=IN6Pp4amwdKwnrPTXZsGSQilhgEXITrw9xtJryhnDzY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J5dxANndWeBZuptK75bP5FCnHAbLMcUJFXEos2wIRSBV53z/NlzUs5W/B1I/QD43SKHsuVZWwt+pM472OE2cFFfC5GVd8GfdqCxEGLTBGtd8RGfDyivC4Bj4vgMtiUcs6vS3STsqkYl6nVzISL1NcQVHxDXTZqrVbgzsT+rApfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WtXpq0gjZz6K5Xs;
	Wed, 28 Aug 2024 00:21:07 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id B9E031400D1;
	Wed, 28 Aug 2024 00:25:05 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 27 Aug
 2024 17:25:05 +0100
Date: Tue, 27 Aug 2024 17:25:04 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Yanfei Xu <yanfei.xu@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, <ming4.li@intel.com>
Subject: Re: [v3 4/4] cxl/pci: simplify the check of mem_enabled in
 cxl_hdm_decode_init()
Message-ID: <20240827172504.00007219@Huawei.com>
In-Reply-To: <20240813110532.870869-5-yanfei.xu@intel.com>
References: <20240813110532.870869-1-yanfei.xu@intel.com>
	<20240813110532.870869-5-yanfei.xu@intel.com>
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
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 13 Aug 2024 19:05:32 +0800
Yanfei Xu <yanfei.xu@intel.com> wrote:

> Cases can be divided into two categories which are DVSEC range enabled and
> not enabled when HDM decoders exist but is not enabled. To avoid checking
> info->mem_enabled, which indicates the enablement of DVSEC range, every
> time, we can check !info->mem_enabled once in advance. This simplification
> can make the code clearer.
> 
> No functional change intended.
> 
> Signed-off-by: Yanfei Xu <yanfei.xu@intel.com>
LGTM as definitely simpler if we handled the !mem_enabled case first.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
