Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C6413DB9F
	for <linux-cxl@vger.kernel.org>; Thu,  3 Jul 2025 13:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751550204; cv=none; b=cfcNTzI9oVCAv3ZG1kAms7JuJgerfn58IYik8+aKhDFrw+G+uw8+MUdAR4Hf61vZze98ivrfr7Qns2haMbt9MfyZVKljoNu/CL+3S4RaI/6R8kjwE6KcQUj1Yb16KkkAKVVR4V+to1+VKdYTnOO5w6LGyhp4Fx6Z+ZBkGHJ0Uog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751550204; c=relaxed/simple;
	bh=5pEox9J03Rwz9lYgKN4viD8qSVHWxF4AzOogP8aQL4g=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sw2uZvy0RSecETKxPFt4505v1PYK9+Z5udKvZqpkYZcXcoxy99R6SRBtw89w7f2ez3q/0QLqbwmWMu0xoRY5IkG75h4oZJ1qZWxT3DSongRwASWS8GUmdtm+uP8Lqca15b+uUyd59TcSJRUm9Zai1b8uYwV/vCd7zIxYnybtP78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bXyd622Jxz6L5ZG;
	Thu,  3 Jul 2025 21:42:50 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 78A361402EE;
	Thu,  3 Jul 2025 21:43:19 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 3 Jul
 2025 15:43:18 +0200
Date: Thu, 3 Jul 2025 14:43:17 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <alison.schofield@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan
 Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] cxl: Define a SPA->CXL HPA root decoder callback
 for XOR Math
Message-ID: <20250703144317.00000f9a@huawei.com>
In-Reply-To: <0ba61cc55f1c3a99e33594a66e470b54bd4b81ef.1751513505.git.alison.schofield@intel.com>
References: <cover.1751513505.git.alison.schofield@intel.com>
	<0ba61cc55f1c3a99e33594a66e470b54bd4b81ef.1751513505.git.alison.schofield@intel.com>
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

On Wed,  2 Jul 2025 21:03:20 -0700
alison.schofield@intel.com wrote:

> From: Alison Schofield <alison.schofield@intel.com>
> 
> When DPA->SPA translation was introduced, it included a helper that
> applied the XOR maps to do the CXL HPA -> SPA translation for XOR
> region interleaves. In preparation for adding SPA->DPA address
> translation, introduce the reverse callback.
> 
> The root decoder callback is defined generically and not all usages
> may be self inverting like this XOR function. Add another root decoder
> callback that is the spa_to_hpa function.
> 
> Update the existing cxl_xor_hpa_to_spa() with a name that reflects
> what it does without directionality: cxl_apply_xor_maps(), a generic
> parameter: addr replaces hpa, and code comments stating that the
> function supports the translation in either direction.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
