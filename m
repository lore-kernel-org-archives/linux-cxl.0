Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F8E2BEC20
	for <linux-cxl@vger.kernel.org>; Fri,  4 Jul 2025 10:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751623746; cv=none; b=bKByo85FoduJq4Rvfiq7KkWKyrVCUmw37ioLYUMlcUpsTdZ75+1qy/PyEjKNwMJmO8EN/P17WdNCblE7wA8pe+EDcOzw57QtvPlLXQ/Yt7FD9WhgjDvLfuNe6NSgfyJWgPeYquOco6skor70+PhfpN6qvz5wPzYQtuXb1hQX1KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751623746; c=relaxed/simple;
	bh=yneg8NIh65ej0ReJu+xOvch3CCm2rChZs9EJdRaS4P0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a01px32SbZI7Jolrah3u3OtrhTexfpnSWljSiMYPbtHLWfArScsHPikJ93qRr4BVoi3DV2nB8bVYtlRgnWWpzE0eN2mgu5YGBU8/ZJxxjzWMfaGUMaoMwXr0FpXaTxVQaaFiIuyb9S0t046fkF72hRmhWuiqnSVNgCZDY/3+Quo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bYTpq2Zyfz6M4jJ;
	Fri,  4 Jul 2025 18:08:03 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id C68011402F1;
	Fri,  4 Jul 2025 18:09:01 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 4 Jul
 2025 12:09:01 +0200
Date: Fri, 4 Jul 2025 11:09:00 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
Subject: Re: [PATCH v5 10/10] cxl: Remove devm_cxl_port_enumerate_dports()
 that is no longer used
Message-ID: <20250704110900.000005a8@huawei.com>
In-Reply-To: <20250703232710.3141436-11-dave.jiang@intel.com>
References: <20250703232710.3141436-1-dave.jiang@intel.com>
	<20250703232710.3141436-11-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 3 Jul 2025 16:27:10 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Delete function devm_cxl_port_enumerate_dports() which is no longer being
> used anywhere. Also remove cxl_test support.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Hard to disagree with removing so much code ;)

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

