Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EBE18C345;
	Tue, 27 Aug 2024 11:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724757355; cv=none; b=paEAJqyJ0qVQkICISA0CJLahFFIhb/X8oNCbB/uotSMMAUJjx0lSzfsIRn3XDuxDLJMg4AksbIdbbmALbHacoCN6y/pAQzVj/qMubmZNObhQTd0Cf8yfPzKPvt9utgW3RE+h7OZD9N+RCpPb09bLc6NHN3SE0VWainIrl3JsYac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724757355; c=relaxed/simple;
	bh=O3RMyC7YePNQp0PJtDMyCVnAcgZuOihs3XoD4kqeGII=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h5xfmVIZgcuk5iCIfQ+JrNado7zjJrMin2LY2h+C/RE0+QRf4Tz5vv9iR4sDseD5+GZjsRlCMBms+NusdcKnEk2y70aZs24zzq1EuBs5gEl35FKxy30xYq7nQgZbD9Mb8rfP8Ac92QdDFb0Hw/ePS1t8CaXbtXdFPKNY/dIuG64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WtPy04xgtz6J6wF;
	Tue, 27 Aug 2024 19:11:52 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id A67FA140CB9;
	Tue, 27 Aug 2024 19:15:50 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 27 Aug
 2024 12:15:50 +0100
Date: Tue, 27 Aug 2024 12:15:49 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Kunwu Chan <kunwu.chan@linux.dev>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Kunwu Chan <chentao@kylinos.cn>
Subject: Re: [PATCH] tools/testing/cxl: Use dev_is_platform()
Message-ID: <20240827121549.00003e17@Huawei.com>
In-Reply-To: <20240827095123.168696-1-kunwu.chan@linux.dev>
References: <20240827095123.168696-1-kunwu.chan@linux.dev>
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
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 27 Aug 2024 17:51:23 +0800
Kunwu Chan <kunwu.chan@linux.dev> wrote:

> From: Kunwu Chan <chentao@kylinos.cn>
> 
> Use dev_is_platform() instead of checking bus type directly.
> 
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
