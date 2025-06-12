Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72962417F0
	for <linux-cxl@vger.kernel.org>; Thu, 12 Jun 2025 14:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749739050; cv=none; b=mIvolLLHA0m9WAQrPd3FQM2y/Y1a9y95BPxBPejutLUpN3vjXXNeyN+3GJ+N2br3ZoKfFy3IXG3xNlTtwI+vP+qVsen74ytpc4nHknRK2hco3fKD5ocIjWvRGgUFrX/HsxVw/TUIKcOlSrlNKaBnGMbpJkajh1qLPqs7B194yZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749739050; c=relaxed/simple;
	bh=oiORZEhIV7K0nIC8pk5ZlE6WqX+9P4rbewKHUZGjCk8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XnK62SrMrlEh8ydrgxq246TKc2R17w826fkMvgbOPpx4yRz9A3M1ws3brdXFnUaoCpsORPkxxTIS6tqHA2VqL77Y1JEJrgv31NwzEOltXmiHpCNEkvXzOPOMnQ0Q4Zn9crvaZV4MlmKBimXgfo2Xlnm40lYeeZqjE9JkMPFUaDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bJ4nV6GDgz6K9DZ;
	Thu, 12 Jun 2025 22:35:26 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 803311402EC;
	Thu, 12 Jun 2025 22:37:22 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 12 Jun
 2025 16:37:22 +0200
Date: Thu, 12 Jun 2025 15:37:20 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: wangyuquan <wangyuquan1236@phytium.com.cn>
CC: <fan.ni@samsung.com>, <mst@redhat.com>, <marcel.apfelbaum@gmail.com>,
	<chenbaozi@phytium.com.cn>, <qemu-devel@nongnu.org>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [RFC PATCH v2 1/2] hw/pxb-cxl: Rename the pxb cxl host bridge
Message-ID: <20250612153720.0000260d@huawei.com>
In-Reply-To: <20250530103320.534173-2-wangyuquan1236@phytium.com.cn>
References: <20250530103320.534173-1-wangyuquan1236@phytium.com.cn>
	<20250530103320.534173-2-wangyuquan1236@phytium.com.cn>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 30 May 2025 18:33:19 +0800
wangyuquan <wangyuquan1236@phytium.com.cn> wrote:

> This renames some descriptions and definitions of pxb cxl host
> bridge, since the original names can be confusing.
> 
> Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
Seems reasonable though only needed if we move forward with
patch 2.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
