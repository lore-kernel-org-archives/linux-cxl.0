Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7902E7F39;
	Wed, 13 Aug 2025 13:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755092649; cv=none; b=tgtZhZv9eOCb02NMel+v3hyEfCEjJgUGef814Jyr7L3XZQu0mHZnV0rl2za1aC6ow3zYPTdsScCFOnRhFE3scPq0PBeJzRxlNiUKxe8hWfHR0/2nQ/vvDWTXOm667Li4uqmguzayUF3hMnLKjvc1BGDVCHAhCjNCtjYstTDA2Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755092649; c=relaxed/simple;
	bh=sE9wor2MDjeQ3trquLM+Zf1b94PQN3zD7QdmGEn/D84=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kaqd0I8ImNUhsmL/tHFRHNES/BctFdN1ZK+X2obb82gXQWFGjOrEZr4yqtE1X4oUQM7KKVliOCK4Nozb6DDYeyglLjy++bxpokWP4y4bqQNI6EDaMJuROjK6PogvXNwEmOWp3jOAca61nDX31tcg8Uwo8ro8yEB+qY9EHcbmaN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4c28by4WsHz6L52K;
	Wed, 13 Aug 2025 21:39:10 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 4F2051400D4;
	Wed, 13 Aug 2025 21:44:03 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 13 Aug
 2025 15:44:02 +0200
Date: Wed, 13 Aug 2025 14:44:01 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Neeraj Kumar <s.neeraj@samsung.com>
CC: <linux-cxl@vger.kernel.org>, <nvdimm@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <gost.dev@samsung.com>,
	<a.manzanares@samsung.com>, <vishak.g@samsung.com>, <neeraj.kernel@gmail.com>
Subject: Re: [PATCH V2 04/20] nvdimm/label: CXL labels skip the need for
 'interleave-set cookie'
Message-ID: <20250813144401.00004fee@huawei.com>
In-Reply-To: <20250730121209.303202-5-s.neeraj@samsung.com>
References: <20250730121209.303202-1-s.neeraj@samsung.com>
	<CGME20250730121227epcas5p4675fdb3130de49cd99351c5efd09e29e@epcas5p4.samsung.com>
	<20250730121209.303202-5-s.neeraj@samsung.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 30 Jul 2025 17:41:53 +0530
Neeraj Kumar <s.neeraj@samsung.com> wrote:

> CXL LSA v2.1 utilizes the region labels stored in the LSA for interleave
> set configuration instead of interleave-set cookie used in previous LSA
> versions. As interleave-set cookie is not required for CXL LSA v2.1 format
> so skip its usage for CXL LSA 2.1 format
> 
> Signed-off-by: Neeraj Kumar <s.neeraj@samsung.com>

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
