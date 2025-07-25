Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C92A2E4247;
	Fri, 25 Jul 2025 11:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753441492; cv=none; b=Vb3oxCggq/t5SD0PMPaBiZy8hc579vYv+WzQNF57Abtu9SI7h96OrZhRp4ayen99SpElfDhGVOQGQIl88BN6EasctKsbeRsw+rSor/OAvEb9yR0nTP2G0oAht7El/ZbqCCCsUESSQjnBCY0LQAZgwnKMNSAWx+dFNzsJYJkarIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753441492; c=relaxed/simple;
	bh=q9oWzlqirHRDaE2LY4cRgTqZdEiBd9WB4RZ5klHjvFQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jZNuns9riLapVOvBd5Afj9bC+Gxgd0vCRW81qCjvjtVgFsoejInz1jchs0FReThLv+EwtzW6V/s4sHHZ90EQz3WeIOguHa2E1lcgzd1l2k8m+v/oPSrubxXc9OgapTvx9xt6Koj0Gu4+ylG3CYTblORKRbQKH8gVHbZnaxHJjqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bpQ2j02K3z6L54J;
	Fri, 25 Jul 2025 19:03:09 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 33B1B14038F;
	Fri, 25 Jul 2025 19:04:48 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 25 Jul
 2025 13:04:47 +0200
Date: Fri, 25 Jul 2025 12:04:46 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <alison.schofield@intel.com>
CC: Jonathan Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] Documentation/ABI/testing/debugfs-cxl: Add 'cxl' to
 clear_poison path
Message-ID: <20250725120446.00007950@huawei.com>
In-Reply-To: <20250724224308.2101255-1-alison.schofield@intel.com>
References: <20250724224308.2101255-1-alison.schofield@intel.com>
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

On Thu, 24 Jul 2025 15:43:06 -0700
alison.schofield@intel.com wrote:

> From: Alison Schofield <alison.schofield@intel.com>
> 
> 'cxl' is missing from the path to the clear_poison attribute. Add it.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
