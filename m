Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B76E25B1CE
	for <linux-cxl@vger.kernel.org>; Mon, 23 Jun 2025 14:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750689088; cv=none; b=gXgxwTkSxa11SXyG0LzC6VeJA0Qgd4Z13FIMdrg4HnntSpZbifhcB4JyY044uzkzIA9mWgzBqwMxQAuFVCbh+8pydOyPTsjT6Pz1IKH5Cm364BolHKJQ+0yRMY5I4xPfKBGpOldpgRwckvyhdTWzn/kN7tvozq8oThCKHRZpTXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750689088; c=relaxed/simple;
	bh=6OhPvA1jbklf1AmANbuU0SBxxthDNf+ae7i2NNGPBOo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZUJd3y/N2tCZN2NxVXtLKcwwLKrycot0i4c5fV95Brk9KAHp+ggNBkMu47CiSnQBylgF5b9FKZ4n/elV3xzykbdF/RUwM+vjKjM9jH1tjKRMLizADdaEdiFlphFy7974rQMTeoQI9z0Ui/luWO3vQMaKsyz5b+EUuMYM3zwWGys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bQr8x1WNgz6D983;
	Mon, 23 Jun 2025 22:30:41 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 05CFC1402FC;
	Mon, 23 Jun 2025 22:31:24 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 23 Jun
 2025 16:31:23 +0200
Date: Mon, 23 Jun 2025 15:31:22 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <jgroves@micron.com>, <ravis.opensrc@micron.com>,
	<fan.ni@samsung.com>, <anisa.su@samsung.com>, <a.manzanares@samsung.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 4/7] cxl/mbox: Stronger cxl_mbox_background_complete()
 semantics
Message-ID: <20250623153122.00007bdd@huawei.com>
In-Reply-To: <20250617193611.564668-5-dave@stgolabs.net>
References: <20250617193611.564668-1-dave@stgolabs.net>
	<20250617193611.564668-5-dave@stgolabs.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 17 Jun 2025 12:36:08 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> Account for all situations where hw has no on-going background
> command. Current semantics do no change with this patch, but will

do not

> serve for later supporting cancel requests. As such rename the
> helper accordingly.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
