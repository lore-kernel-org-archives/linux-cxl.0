Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B90D2F99B5
	for <linux-cxl@vger.kernel.org>; Wed, 17 Sep 2025 16:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758127068; cv=none; b=dfjcQJJkqqoQT4CZyux4aPqIXO+coDpL8WjYcuTqGdNQN5FRoak7g74ti0VnvL21lBoZiiqWXgest4saHqr7ZU97pStZKwqdnc7LZ/pGDcfGElnf+4EAru4brbScgNWbVw65lSPXjxD5zG5YZkSezMUXlobMz/KFkv/X0IHd00w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758127068; c=relaxed/simple;
	bh=7mQ1vuRWHQyjPlPtWmfLuympILGUWH5fSAUV/I0Evr0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h5TW/Eyl2fOg8W+QGcxwc5hZz5nJ55SALYZBC8XuVOy/XB7xqtKG5Uq+PoHjoCr5/iJZL2f/mAkd+sOBY0VAVmY0xL881685hL0TAMdYLqhqbFMKh1JwFcHUXWy26iYGtQZowB2pXZaPpEF+Pn/jjBAMSWYTde0LIxxIpE8O9wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cRkpb429kz6L5Yj;
	Thu, 18 Sep 2025 00:33:11 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 65B5B1402EA;
	Thu, 18 Sep 2025 00:37:44 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 17 Sep
 2025 18:37:43 +0200
Date: Wed, 17 Sep 2025 17:37:42 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: wangyuquan <wangyuquan1236@phytium.com.cn>
CC: <fan.ni@samsung.com>, <mst@redhat.com>, <marcel.apfelbaum@gmail.com>,
	<rad@semihalf.com>, <peter.maydell@linaro.org>,
	<leif.lindholm@oss.qualcomm.com>, <graf@amazon.com>,
	<claudio.fontana@huawei.com>, <philmd@linaro.org>,
	<richard.henderson@linaro.org>, <chenbaozi@phytium.com.cn>,
	<qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [RFC QEMU PATCH v4 2/2] pci-host/cxl: Support creation of a new
 CXL Host Bridge
Message-ID: <20250917173742.000078cc@huawei.com>
In-Reply-To: <20250807105910.240070-3-wangyuquan1236@phytium.com.cn>
References: <20250807105910.240070-1-wangyuquan1236@phytium.com.cn>
	<20250807105910.240070-3-wangyuquan1236@phytium.com.cn>
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

On Thu, 7 Aug 2025 18:59:10 +0800
wangyuquan <wangyuquan1236@phytium.com.cn> wrote:

> From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
> 
> Define a new CXL host bridge type (TYPE_CXL_HOST). This is an
> independent CXL host bridge which combined GPEX features (ECAM, MMIO
> windows and irq) and CXL Host Bridge Component Registers (CHBCR).
> 
> The root bus path of CXL_HOST is "0001:00", that would not affect the
> original PCIe host topology on some platforms. In the previous, the
> pxb-cxl-host with any CXL root ports and CXL endpoint devices would
> share the resources (like BDF, MMIO space) of the original pcie
> domain, but it would cause some platforms like sbsa-ref are unable to
> support the original number of PCIe devices. The new type provides a
> solution to resolve the problem.
> 
> Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>

Likewise, this looks fine to me.  If the SBSA maintainers
are happy with the approach and PCI folk think the more generic parts
look fine then would be good to move this forwards.

Acked-by: Jonathan Cameron <jonathan.cameron@huawei.com>

