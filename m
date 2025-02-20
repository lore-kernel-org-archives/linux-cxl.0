Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C0E1E2616
	for <linux-cxl@vger.kernel.org>; Thu, 20 Feb 2025 17:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740072613; cv=none; b=O8EGRdzWljVMlnv2LWIHHsMg/s18kY8Rtf/3CFYARH4aRyF7k9sAOZ77l5BzCivLMLxNFeQ/gOF3KzPNce/vnOhN1oxQwUQFB47oU3ibOLPBIP0ak91JAWU4KNNcEqTRQsSP3tUC7rZZ1k1tdmBtAEsHAPG2QulyfoWexnNsW/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740072613; c=relaxed/simple;
	bh=2fGq9tYeoOl1SxlsqlGDZxPgIPwTpvATfbIy0nfdGmk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sruth3GMsXkxeoQT6cbefLITBzrLmj6Fc29h5xcLkTmJVeWefxRcboSjYN5g6pp739WnQSyYoYN6TkihaHpCvKKuR4VmXnOs/4QyhmlcVCqQQLTxYzOgnfsZxYNvWgn2yjiU/S1RL5r2auSKn7A3BjRnvqQN/pPZJW53h1E3+R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YzKws0xhFz6HJjF;
	Fri, 21 Feb 2025 01:28:29 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 27603140257;
	Fri, 21 Feb 2025 01:30:08 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 20 Feb
 2025 18:30:07 +0100
Date: Thu, 20 Feb 2025 17:30:06 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<alison.schofield@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <seven.yi.lee@gmail.com>, <ming.li@zohomail.com>,
	<a.manzanares@samsung.com>, <fan.ni@samsung.com>, <anisa.su@samsung.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 4/4] tools/testing/cxl: Set Shutdown State support
Message-ID: <20250220173006.00000a0f@huawei.com>
In-Reply-To: <20250220013604.263489-5-dave@stgolabs.net>
References: <20250220013604.263489-1-dave@stgolabs.net>
	<20250220013604.263489-5-dave@stgolabs.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 19 Feb 2025 17:36:04 -0800
Davidlohr Bueso <dave@stgolabs.net> wrote:

> Add support to emulate the CXL Set Shutdown State operation.
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Li Ming <ming.li@zohomail.com>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
FWIW looks fine to me as well.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
