Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF7D34BA29
	for <linux-cxl@vger.kernel.org>; Wed, 17 Sep 2025 16:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758127161; cv=none; b=YIQUfubPGC0z23grYEa/6AqWn5UFEr0QKp3ZaC2fOlN9T8zCK6C6Ai284lcpe9J03zt3FhsdkQEe5BsXtgBAk59zvYkBsV4RV7Z+1tmJRj75zIb+wC8ydZYTl+FNfvtKlb9dKna6Z/+PeV1ezFRuVuNUzuJs1OXjeRdCFT+Bke4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758127161; c=relaxed/simple;
	bh=4i7vM693YKmn297Mz+qaP7fvex3BVG8MtpeSzU/B+Do=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d7vXSWw54Dil8u41HRADhfZFKS5PzNrAXVlwBbihPv1I3za8lghO9XYKCbU5/Q6M2LiqvFP/pXtgdMoWbnq0e/xX6IXgIkngXQl9eKHH8Z3rWBd3qKPf3mw+JEgN9U6Greqe5qaaMlMLbf2C7bLrStLzWT73MOnaFXLRE/+wGgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cRkvp2gpdz6GDNk;
	Thu, 18 Sep 2025 00:37:42 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id B25AD14020A;
	Thu, 18 Sep 2025 00:39:15 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 17 Sep
 2025 18:39:15 +0200
Date: Wed, 17 Sep 2025 17:39:14 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: wangyuquan <wangyuquan1236@phytium.com.cn>
CC: <rad@semihalf.com>, <peter.maydell@linaro.org>,
	<leif.lindholm@oss.qualcomm.com>, <chenbaozi@phytium.com.cn>,
	<qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, <qemu-arm@nongnu.org>
Subject: Re: [RFC QEMU PATCH v7] hw/arm/sbsa-ref: Support CXL Host Bridge &
 CFMW
Message-ID: <20250917173914.0000331e@huawei.com>
In-Reply-To: <20250807111037.241118-1-wangyuquan1236@phytium.com.cn>
References: <20250807111037.241118-1-wangyuquan1236@phytium.com.cn>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 7 Aug 2025 19:10:37 +0800
wangyuquan <wangyuquan1236@phytium.com.cn> wrote:

> From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
> 
> This creates a specific CXL host bridge (0001:00) with four cxl
> root ports on sbsa-ref. And the memory layout provides separate
> space windows for the cxl host bridge in the sbsa-ref memmap:
> 
> - 64K  CXL Host Bridge Component Registers (CHBCR)
> - 64K  CXL_PIO
> - 128M CXL_MMIO
> - 256M CXL_ECAM
> - 4G   CXL_MMIO_HIGH
> 
> To provide CFMWs on sbsa-ref, this extends 1TB space from the
> hole above RAM Memory [SBSA_MEM] for CXL Fixed Memory Window:
> 
> - 1T   CXL_FIXED_WINDOW
> 
> Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
This looks pretty standard to me so FWIW as someone who hasn't used
the SBSA model.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>


